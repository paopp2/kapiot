const functions = require("firebase-functions");
const admin = require("firebase-admin");
const firebase_tools = require('firebase-tools');
const cors = require('cors');
const polyUtil = require('./polyline_helpers');
const driver_data = require("./test_data/drivers.json");
const rider_data = require("./test_data/riders.json");
const userInfo_data = require("./test_data/user_info.json");
const test_data = Object.assign({},driver_data,rider_data,userInfo_data);

admin.initializeApp();
const db = admin.firestore();
const rtdb = admin.database();
const driversRef = db.collection('active_drivers');
const ridersRef = db.collection('active_riders');
const userInfoRef = db.collection('user_info');
require('dotenv').config();

exports.recursiveDelete = functions
  .runWith({
    timeoutSeconds: 540,
    memory: '512MB'
  })
  .https.onRequest(async (data, context, req, res) => {
    const access_token = process.env.ACCESS_TOKEN;
    const rider_path = 'active_riders';
    const driver_path = 'active_drivers';
    const project_ID = process.env.PROJECT_ID;

    await firebase_tools.firestore
      .delete(rider_path, {
        project: project_ID,
        recursive: true,
        yes: true,
        token: access_token
      });
    await firebase_tools.firestore
      .delete(driver_path, {
        project: project_ID,
        recursive: true,
        yes: true,
        token: access_token
      });
});

exports.getActiveRiders = functions.https.onRequest(async (req, res) =>  {
    const snapshot = await ridersRef.get();
    res.send(snapshot.docs.map(doc => doc.data()))
});

exports.getActiveDrivers = functions.https.onRequest(async (req, res) =>  {
    const snapshot = await driversRef.get();
    res.send(snapshot.docs.map(doc => doc.data()))
});

// use populateAll instead to populate all riders and drivers with our own infos
exports.populateAll = functions.https.onRequest(async (req, res) =>  {
    test_data.ridersList.forEach(addRider);
    async function addRider(rider) {
        await ridersRef.doc(rider.id).set(rider);
    }
    test_data.driversList.forEach(addDriver);
    async function addDriver(driver) {
        await driversRef.doc(driver.id).set(driver);
        var path = '/realtime_locations/' + driver.id;
        var encodedRoute = driver.encodedRoute;
        var decodedRoute = polyUtil.decode(encodedRoute);
        var json = {
            lat: decodedRoute[0][0],
            lng: decodedRoute[0][1]
        };
        await rtdb.ref(path).set(json);
    }
    res.json({result: "Populated drivers and riders'"});
});

exports.populateUserInfo = functions.https.onRequest(async (req, res) =>  {
    test_data.userInfoList.forEach(addUserInfo);
    async function addUserInfo(userInfo) {
        await userInfoRef.doc(userInfo.id).set(userInfo);
    }
    res.json({result: "Populated 'user_info'"});
});

exports.populateActiveRiders = functions.https.onRequest(async (req, res) =>  {
    test_data.ridersList.forEach(addRider);
    async function addRider(rider) {
        await ridersRef.doc(rider.id).set(rider);
    }
    res.json({result: "Populated 'active_riders'"});
});

exports.populateActiveDrivers = functions.https.onRequest(async (req, res) =>  {
    test_data.driversList.forEach(addDriver);
    async function addDriver(driver) {
        await driversRef.doc(driver.id).set(driver);
    }
    res.json({result: "Populated 'active_drivers'"});
});

exports.requestDriver = functions.https.onRequest(async (req, res) =>  {
    const requestedDriver = test_data.driversList[parseInt(req.query.d,10)];  
    const driverId = requestedDriver.id; 
    const requestingRider = test_data.ridersList[parseInt(req.query.r,10)]; 
    const riderId = requestingRider.id; 
    await driversRef.doc(driverId).collection('requests').doc(riderId)
    .create(requestingRider)
    .then(res.json(requestingRider))
    .catch(err => res.status(400).json('Error : ' + err));
});

exports.acceptRider = functions.https.onRequest(async (req, res) =>  {
    const requestingRiderConfig = test_data.ridersList[parseInt(req.query.r,10)];
    const acceptingDriverConfig = test_data.driversList[parseInt(req.query.d,10)]; 
    const driversIdList = test_data.driversList.map(driver => driver.id);
    const riderId = requestingRiderConfig.id;
    const driverId = acceptingDriverConfig.id;
    await ridersRef.doc(riderId).update({
        acceptingDriverConfig: acceptingDriverConfig,
    });
    driversIdList.forEach(deleteRequests);
    async function deleteRequests(id){
        await driversRef.doc(id).collection('requests').doc(riderId).delete();
    }
    await driversRef.doc(driverId).update({
        riderCount: admin.firestore.FieldValue.increment(1)
    });
    await driversRef.doc(driverId).collection('accepted').doc(riderId)
    .create(requestingRiderConfig)
    .then(res.json('Accepted: ' + driversIdList))
    .catch(err => res.status(400).json('Error : ' + err));
});

exports.requestAllDrivers = functions.https.onRequest(async (req, res) =>  {
    const driversList = test_data.driversList;
    const requestingRider = test_data.ridersList[parseInt(req.query.r,10)]; 
    const riderId = requestingRider.id; 
    driversList.forEach(requestDriver);
    async function requestDriver(driver) {
        await driversRef.doc(driver.id).collection('requests').doc(riderId)
        .create(requestingRider);
    }
    res.json({result: "Requested all drivers"});
});

exports.dropRider = functions.https.onRequest(async (req, res) =>  {
    const driver = test_data.driversList[parseInt(req.query.d,10)];
    const rider = test_data.ridersList[parseInt(req.query.r,10)];
    const driverId = driver.id;
    const riderId = rider.id; 
    const riderName = rider.user.displayName;
    await driversRef.doc(driverId).update({
        riderCount: admin.firestore.FieldValue.increment(-1)
    });
    await driversRef.doc(driverId).collection('accepted').doc(riderId)
    .delete()
    .then(res.json('Dropped ' + riderName))
    .catch(err => res.statusMessage(400).json('Error: ' + err));
});


exports.getRoute = functions.https.onRequest(async (req, res) =>  {
    cors()(req,res, () => {
        const driver = test_data.driversList[parseInt(req.query.d,10)];
        const encodedRoute = driver.encodedRoute;
        const decodedRoute = polyUtil.decode(encodedRoute);
        res.send(decodedRoute);
    });
});

exports.setRoute = functions.https.onRequest(async (req, res) =>  {
    cors()(req,res, () => {
        const driver = test_data.driversList[parseInt(req.query.d,10)];
        const lat = parseFloat(req.query.lat);
        const lng = parseFloat(req.query.lng);
        const path = '/realtime_locations/' + driver.id;
        const json = {
            lat: lat,
            lng: lng 
        };
        setTimeout(setData,1000,json);
        async function setData(json){
            await rtdb.ref(path).update(json);
        }
        res.send(json);
    });
});

exports.sendRating = functions.https.onRequest(async (req, res) =>  {
    cors()(req,res, async () => {
        const requestedDriver = test_data.driversList[parseInt(req.query.d,10)];  
        const rating = parseInt(req.query.rating,10);
        const driverId = requestedDriver.id; 
        await userInfoRef.doc(driverId).set({
            driverInfo: {
                'rateTotal': admin.firestore.FieldValue.increment(rating),
                'ratingResponseCount': admin.firestore.FieldValue.increment(1),
            }
        },{merge:true})
        .then(res.json(driverId))
        .catch(err => res.status(400).json('Error : ' + err));
    });
});
