const express = require("express");
const route = express.Router();

const { index } = require("../controllers/material.controller");

route.get("/", index);

module.exports = route;
