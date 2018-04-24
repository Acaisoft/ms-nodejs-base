const config = require("./lib/configuration");
const app = require("./app");
const port = config.get("app:port");

app.listen(port, () => console.log("Example app listening on port: " + port));
