const functions = require("firebase-functions");
const admin = require("firebase-admin");
const test_data = require("./test_data");
admin.initializeApp();
const db = admin.firestore();
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

exports.requestRider = functions.https.onRequest(async (req, res) =>  {
    const driverId = test_data.driversList[0].id;
    await db.collection('active_riders').doc(driverId).add(test_data.singleRider)
    .then(res.send(snapshot.docs.map(doc => doc.data())))
    .catch(err => res.status(400).json('Error : ' + err));
});




