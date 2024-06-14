const express = require("express");

const route = express.Router();

const { index } = require("../controllers/matapelajaran.controller");

route.get("/", index);

module.exports = route;
