// server.js

// BASE SETUP
// =============================================================================

// call the packages we need
var express    = require('express');        // call express
var app        = express();                 // define our app using express
var bodyParser = require('body-parser');
var request = require('request');
var querystring = require('querystring');
const BigchainDB = require('bigchaindb-driver')
const bip39 = require('bip39')

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var port = 8081;        // set our port

// ROUTES FOR OUR API
// =============================================================================
var router = express.Router();              // get an instance of the express Router



const alicia = new BigchainDB.Ed25519Keypair(bip39.mnemonicToSeed('alicia').slice(0,32))
const baron = new BigchainDB.Ed25519Keypair(bip39.mnemonicToSeed('baron').slice(0,32))
const charles = new BigchainDB.Ed25519Keypair(bip39.mnemonicToSeed('charles').slice(0,32))
const danica = new BigchainDB.Ed25519Keypair(bip39.mnemonicToSeed('danica').slice(0,32))


const conn = new BigchainDB.Connection(
    'https://test.bigchaindb.com/api/v1/',
    { app_id: '4928a457',
      app_key: '9b8030ecd8d4008bdfefb3cfaaa5b385' })

// test route to make sure everything is working (accessed at GET http://localhost:8080/api)
router.get('/createPatient', function(req, res) {
    const patient = {
    name: req.query.name,
    age: req.query.age,
    height: req.query.height,
    weight: req.query.weight,
    address: req.query.address,
    idNumber: req.query.idNumber
}


     // Construct a transaction payload
    const txCreatePaint = BigchainDB.Transaction.makeCreateTransaction(
        // Asset field
        {
            patient,
        },
        // Metadata field, contains information about the transaction itself
        // (can be `null` if not needed)
        {
            datetime: new Date().toString(),
            doctor: 'John'
        },
        // Output. For this case we create a simple Ed25519 condition
        [BigchainDB.Transaction.makeOutput(
            BigchainDB.Transaction.makeEd25519Condition(alice.publicKey))],
        // Issuers
        alice.publicKey
    )
    // The owner of the painting signs the transaction
    const txSigned = BigchainDB.Transaction.signTransaction(txCreatePaint,
        alice.privateKey)

    // Send the transaction off to BigchainDB
    conn.postTransactionCommit(txSigned)
        .then(res.send(txSigned.id))

});

router.get('/getRiskNew', function(req, res) {
    
    if(req.query.mme = 1000){
        //These values were found through our model
        res.send(String(44.1))
    }else if (req.query.mme >= 1100) {
        res.send(String(49.9))
    }else {
        res.send(String(52.5))
    }

});

//Couldn't get the json to send, kept getting errors so we just obtained the data from the model directly instead of querying it .

router.get('/getRisk', function(req, res) {
var data = {
        "Inputs": {
                "input1":
                [
                    {
                            'Col1': "Jefferson County, AL",   
                            'Col3': "$20,000",   
                            'Col4': "880",   
                            'Col6': "25",   
                    }
                ],
        },
    "GlobalParameters":  {
    }
}


var formData = querystring.stringify(data);
var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer yJp58IuTwueTsLpaKZahaXPR4cF+VraXQDlTZW2OdEujsOcZND06beiFFgQG1qzq8X8gTve/osG5TnZtBWhH/A=='
}

// Configure the request
var options = {
    url: 'https://ussouthcentral.services.azureml.net/workspaces/a8669c260aa34b98b83b86a6a80283a3/services/698e4378ad9c400caa88a796ae2dba69/execute?api-version=2.0&details=true&format=swagger',
    method: 'POST',
    headers: headers,
    body: formData
}

// Start the request
request(options, function (error, response, body) {
   
        // Print out the response body
        console.log(response)
});

  
});

function getSoftheonCreds(){
request.post('https://hack.softheon.io/oauth2/connect/token',
    { form: { client_id: "43643075-1b50-4b5d-bc72-13d364d0bd10",
     client_secret: "9908d766-11c9-4009-8cf2-50a47e8cf631",
     grant_type: "password",
     scope: "enterpriseapi openid",
     username: "hack019",
     password: "8qHbGSWP"
    }} ,
    function (error, response, body) {
            return(JSON.parse(body)["access_token"])
    }
);
}


router.get('/getCreds', function(req, res) {
getSoftheonCreds().then(function(key) {
console.log(key)
request.post({
   url: 'https://hack.softheon.io/api/enterprise/v1/content/entities/19',
   form: {"Profiles": [
        {
          "Acl": -1,
          "Type": 1,
          "Strings": [
            "High School",
            "St. Louis County, MO",
            "Anthem Gold"
          ]
        }    
      ],
      "Acl": -1,
      "Type": 789,
      "Subtype": 0,
      "State": "Available",
      "Name": "alicia",
 	"Category": "Common"
    },
   headers: { 
      'authorization' : key 
   },
   method: 'POST'
  },

  function (e, r, body) {
      console.log(body);
  });
});
});

router.get('/query', function(req, res) {
conn.searchAssets(req.query.queryParam).then(assets => res.send(assets));
});

router.post('/createPrescription', function(req, res){
    console.log(req.body)
    var seed = req.body["seedName"]
    var params = req.body
    
    const usingKey = new BigchainDB.Ed25519Keypair(bip39.mnemonicToSeed(seed).slice(0,32));
    
    const assetdata = {
        'prescription': params
    }
    const txCreatePaint = BigchainDB.Transaction.makeCreateTransaction(
        // Asset field
        {
            assetdata
        },
        // Metadata field, contains information about the transaction itself
        // (can be `null` if not needed)
        {
            datetime: new Date().toString(),
            doctor: 'John'
        },
        // Output. For this case we create a simple Ed25519 condition
        [BigchainDB.Transaction.makeOutput(
            BigchainDB.Transaction.makeEd25519Condition(usingKey.publicKey))],
        // Issuers
        usingKey.publicKey
    )
    // The owner of the painting signs the transaction
    const txSigned = BigchainDB.Transaction.signTransaction(txCreatePaint,
        usingKey.privateKey)

    // Send the transaction off to BigchainDB
    conn.postTransactionCommit(txSigned)
        .then(console.log(txSigned.id))


});

// more routes for our API will happen here

// REGISTER OUR ROUTES -------------------------------
// all of our routes will be prefixed with /api
app.use('/api', router);

// START THE SERVER
// =============================================================================
app.listen(port);
console.log('Magic happens on port ' + port);
