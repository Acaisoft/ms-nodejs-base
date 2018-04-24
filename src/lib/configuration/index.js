let nconf = require('nconf');

function Config() {
    nconf.argv().env();
    let environment = nconf.get('NODE_ENV') || 'local';
    nconf.file('default', './configs/default-config.json');
    nconf.file('env', './configs/' + environment.toLowerCase() + '/env-config.json');
    nconf.file('secrets', './configs/' + environment.toLowerCase() + '/secrets.json');
}

Config.prototype.get = function(key) {
    return nconf.get(key);
};

module.exports = new Config();