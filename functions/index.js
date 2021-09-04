const functions = require("firebase-functions");
const admin = require("firebase-admin");
const test_data = require("./test_data.json");
admin.initializeApp();
const db = admin.firestore();
const driversRef = db.collection('active_drivers');
const ridersRef = db.collection('active_riders');

var driverIdDict = {
    "3WO9ATwspsMwYCRCgdbXnfpp5r83" : [],
    "TNZyDLzIrLhS4Bklz5yG1rCoDoF2" : [],
    "HV9BcFRIKMYrQOYzd2gStGqErW12" : [],
    "" : [],
    "" : [],
    "" : []
}; 

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
    }
    res.json({result: "Populated drivers and riders'"});
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

    driversIdList.forEach(deleteRequests);
    async function deleteRequests(id){
        await driversRef.doc(id).collection('requests').doc(riderId).delete();
    }
    await ridersRef.doc(riderId).update({
        acceptingDriverConfig: acceptingDriverConfig,
    });
    await driversRef.doc(driverId).collection('accepted').doc(riderId)
    .create(requestingRiderConfig)
    .then(res.json('Accepted: ' + riderId))
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
    await driversRef.doc(driverId).collection('accepted').doc(riderId)
    .delete()
    .then(res.json('Dropped ' + riderName))
    .catch(err => res.statusMessage(400).json('Error: ' + err));
});

