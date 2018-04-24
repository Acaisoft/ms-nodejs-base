let express = require('express');
let config = require('./lib/configuration');
let app = express();
let port = config.get('app:port');

app.get('/', (req, res) => res.send('Hello World!'));
app.get('/healthz', (req, res) => res.send('{"status": "OK"}'));

app.listen(port, () => console.log('Example app listening on port: ' + port));