const express = require("express");
const morgan = require("morgan");
const app = express();

app.use(morgan("dev"));

app.get("/", (req, res) => res.send("Hello World!"));
app.get("/healthz", (req, res) => res.json({ status: "OK" }));

module.exports = app;
