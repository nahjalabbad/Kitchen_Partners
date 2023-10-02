const FormData = require("form-data");
const fs = require("fs");
const https = require('https');

var form = new FormData();
//form.append('image',fs.createReadStream(imgTemp));

var headers = form.getHeaders();
headers['Authorization'] =' Bearer 85551a8b6cfd1bae49bef6732a9c6cc1075e99aa';

const options = {
    hostname: 'api.logmeal.es',
    path: 'v2/image/recognition/complete',
    method: 'POST',
    headers: headers,
};

const req = https.requst(options , (res) => {
    res.on('data', (d) => {
        process.stdout.write(d);
    });
});
form.pipe(req);