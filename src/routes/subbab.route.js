const express = require("express");

const route = express.Router();

const { verifyToken } = require("../middlewares/auth");
const { index } = require("../controllers/subbab.controller");

route.get("/", verifyToken, index);

module.exports = route;
