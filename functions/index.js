const functions = require("firebase-functions");
const admin = require("firebase-admin");
const test_data = require("./test_data");
admin.initializeApp();
const db = admin.firestore();
const driversRef = db.collection('active_drivers');
const ridersRef = db.collection('active_riders');

/* Pick your rider as your own */
const charlesRider = test_data.ridersList[0];
const paoloRider = test_data.ridersList[1];
const christianRider = test_data.ridersList[2];

/* Pick your driver to your liking */
const charlesDriver = test_data.driversList[0];
const paoloDriver = test_data.driversList[1];
const christianDriver = test_data.driversList[2];

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
    const requestedDriver = charlesDriver; // Changeable 
    const driverId = requestedDriver.id; 
    const requestingRider = charlesRider; // Changeable
    const riderId = requestingRider.id; 
    await driversRef.doc(driverId).collection('requests').doc(riderId)
    .create(requestingRider)
    .then(res.json(requestingRider))
    .catch(err => res.status(400).json('Error : ' + err));
});

exports.acceptRider = functions.https.onRequest(async (req, res) =>  {
    const requestingRider = charlesRider; // Changeable
    const riderId = requestingRider.id; 
    const acceptingDriver = charlesDriver; // Changeable
    await driversRef.doc(acceptingDriver.id).collection('requests').doc(riderId)
    .delete();
    await ridersRef.doc(requestingRider.id).update({
        acceptingDriver: acceptingDriver.user,
    });
    await driversRef.doc(acceptingDriver.id).collection('accepted').doc(riderId)
    .create(requestingRider)
    .then(res.json('Accepted: ' + riderId))
    .catch(err => res.status(400).json('Error : ' + err));
 
});

exports.requestAllDrivers = functions.https.onRequest(async (req, res) =>  {
    const driversList = test_data.driversList;
    const requestingRider = charlesRider; // Changeable
    const riderId = requestingRider.id; 
    driversList.forEach(requestDriver);
    async function requestDriver(driver) {
        await driversRef.doc(driver.id).collection('requests').doc(riderId)
        .create(requestingRider);
    }
    res.json({result: "Requested all drivers"});
});


