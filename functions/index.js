const functions = require("firebase-functions");
const admin = require("firebase-admin");
const test_data = require("./test_data");
admin.initializeApp();
const db = admin.firestore();
// TODO: make a temporary collection in firestore that will have all the driverId
var driverIdList = []; 
exports.getActiveRiders = functions.https.onRequest(async (req, res) =>  {
    const snapshot = await db.collection('active_riders').get();
    res.send(snapshot.docs.map(doc => doc.data()))
});

exports.getActiveDrivers = functions.https.onRequest(async (req, res) =>  {
    const snapshot = await db.collection('active_drivers').get();
    res.send(snapshot.docs.map(doc => doc.data()))
});

exports.populateActiveRiders = functions.https.onRequest(async (req, res) =>  {
  const original = req.query.text;
    test_data.ridersList.forEach(addRider);
    
    var writeResult = ''
    async function addRider(rider, index, arr) {
        writeResult += await db.collection('active_riders').doc(rider.id).set(rider);
    }
    res.json({result: "Populated 'active_riders'"});
});

exports.populateActiveDrivers = functions.https.onRequest(async (req, res) =>  {
    const original = req.query.text;
      test_data.driversList.forEach(addDriver);
      
      var writeResult = ''
      async function addDriver(driver, index, arr) {
          writeResult += await db.collection('active_drivers').doc(driver.id).set(driver);
      }
      res.json({result: "Populated 'active_drivers'"});
  });

exports.requestDriver = functions.https.onRequest(async (req, res) =>  {
    const requestedDriver = test_data.driversList[0]; // DRIVER
    const driverId = requestedDriver.id; 
    const requestingRider = test_data.requestingRider[0]; // RIDER
    const rider = requestingRider.user;
    const riderId = requestingRider.id; 
    const riderEndLoc = requestingRider.endLocation;
    const riderStartLoc = requestingRider.startLocation;
    await db.collection('active_drivers').doc(driverId).collection('requests')
    .doc(riderId).set({
        id: riderId,
        acceptingDriver: requestingRider.acceptingDriver,
        endLocation: {
            address: riderEndLoc.address,
            lat: riderEndLoc.lat,
            lng: riderEndLoc.lng,
        },
        riderCount: requestingRider.riderCount,
        runtimeType: requestingRider.runtimeType,
        startLocation: {
            address: riderStartLoc.address,
            lat: riderStartLoc.lat,
            lng: riderStartLoc.lng,
        },
        timeOfTrip: requestingRider.timeOfTrip,
        user: {
            displayName: rider.displayName,
            email: rider.email,
            id: rider.id,
            phoneNumber: rider.phoneNumber,
            photoUrl: rider.photoUrl,
        },
    })
    .then(res.json(requestingRider))
    .catch(err => res.status(400).json('Error : ' + err));
});

exports.acceptRider = functions.https.onRequest(async (req, res) =>  {
    const requestingRider = test_data.ridersList[0] // RIDER
    const rider = requestingRider.user;
    const riderId = requestingRider.id; 
    const riderEndLoc = requestingRider.endLocation;
    const riderStartLoc = requestingRider.startLocation;
    const acceptingDriver = test_data.driversList[0]; // DRIVER
    await db.collection('active_drivers').doc(acceptingDriver.id).collection('requests').doc(riderId)
    .delete();
    await db.collection('active_riders').doc(requestingRider.id).update({
        acceptingDriver: acceptingDriver,
    });
    await db.collection('active_drivers').doc(acceptingDriver.id).collection('accepted').doc(riderId)
    .set({
        id: riderId,
        acceptingDriver: acceptingDriver,
        endLocation: {
            address: riderEndLoc.address,
            lat: riderEndLoc.lat,
            lng: riderEndLoc.lng,
        },
        riderCount: requestingRider.riderCount,
        runtimeType: requestingRider.runtimeType,
        startLocation: {
            address: riderStartLoc.address,
            lat: riderStartLoc.lat,
            lng: riderStartLoc.lng,
        },
        timeOfTrip: requestingRider.timeOfTrip,
        user: {
            displayName: rider.displayName,
            email: rider.email,
            id: rider.id,
            phoneNumber: rider.phoneNumber,
            photoUrl: rider.photoUrl,
        },
    })
    .then(res.json('Accepted: ' + riderId))
    .catch(err => res.status(400).json('Error : ' + err));
 
});



/*
        id: driverId,
        encodedRoute: requestedDriver.encodedRoute,
        riderCount: requestedDriver.riderCount,
        runtimeType: requestedDriver.runtimeType,
        timeOfTrip: requestedDriver.timeOfTrip,
        user: {
            displayName: driver.displayName,
            email: driver.email,
            id: driver.id,
            phoneNumber: driver.phoneNumber,
            photoUrl: driver.photoUrl,
        },

*/


