const functions = require("firebase-functions");
const admin = require("firebase-admin");
const test_data = require("./test_data");
admin.initializeApp();
const db = admin.firestore();
const driversRef = db.collection('active_drivers');
const ridersRef = db.collection('active_riders');
// TODO: make a temporary collection in firestore that will have all the driverId
var driverIdList = []; 
exports.getActiveRiders = functions.https.onRequest(async (req, res) =>  {
    const snapshot = await ridersRef.get();
    res.send(snapshot.docs.map(doc => doc.data()))
});

exports.getActiveDrivers = functions.https.onRequest(async (req, res) =>  {
    const snapshot = await driversRef.get();
    res.send(snapshot.docs.map(doc => doc.data()))
});

exports.populateActiveRiders = functions.https.onRequest(async (req, res) =>  {
    const original = req.query.text;
    test_data.ridersList.forEach(addRider);
    var writeResult = ''
    async function addRider(rider, index, arr) {
        writeResult += await ridersRef.doc(rider.id).set(rider);
    }
    res.json({result: "Populated 'active_riders'"});
});

exports.populateActiveDrivers = functions.https.onRequest(async (req, res) =>  {
    const original = req.query.text;
    test_data.driversList.forEach(addDriver);
    
    var writeResult = ''
    async function addDriver(driver, index, arr) {
        writeResult += await driversRef.doc(driver.id).set(driver);
    }
    res.json({result: "Populated 'active_drivers'"});
});

exports.requestDriver = functions.https.onRequest(async (req, res) =>  {
    const requestedDriver = test_data.driversList[0]; // DRIVER
    const driverId = requestedDriver.id; 
    //const requestingRider = test_data.requestingRider[0]; // RIDER
    const requestingRider = test_data.charlesRider; // change to your name
    const riderId = requestingRider.id; 
    await driversRef.doc(driverId).collection('requests').doc(riderId)
    .create(requestingRider)
    .then(res.json(requestingRider))
    .catch(err => res.status(400).json('Error : ' + err));
});

exports.acceptRider = functions.https.onRequest(async (req, res) =>  {
    //const requestingRider = test_data.ridersList[0] // RIDER
    const requestingRider = test_data.charlesRider; // change to your name
    const riderId = requestingRider.id; 
    const acceptingDriver = test_data.driversList[0]; // DRIVER
    await driversRef.doc(acceptingDriver.id).collection('requests').doc(riderId)
    .delete();
    await ridersRef.doc(requestingRider.id).update({
        acceptingDriver: acceptingDriver,
    });
    await driversRef.doc(acceptingDriver.id).collection('accepted').doc(riderId)
    .create(requestingRider)
    .then(res.json('Accepted: ' + riderId))
    .catch(err => res.status(400).json('Error : ' + err));
 
});


