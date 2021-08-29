const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.populateActiveRiders = functions.https.onRequest(async (req, res) =>  {
  const original = req.query.text;
    ridersList.forEach(addRider);
    
    var writeResult = ''
    async function addRider(rider, index, arr) {
        writeResult += await admin.firestore().collection('active_riders').doc(rider.id).set(rider);
    }
    res.json({result: "Populated 'active_riders'"});
});

const ridersList = [
    {
        id: "rider1",
        name: "John",
        address: "Here"
    },
    {
        id: "rider2",
        name: "Bob",
        address: "There"
    },
]