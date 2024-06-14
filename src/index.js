const path = require("path");
require("dotenv").config({ path: path.join(__dirname, "../.env") });
const express = require("express");

const authRouter = require("./routes/auth.route");
const kelasRouter = require("./routes/kelas.route");
const mataPelajaranRouter = require("./routes/matapelajaran.route");
const babRouter = require("./routes/bab.route");
const subBabRouter = require("./routes/subbab.route");
const materialRouter = require("./routes/material.route");

const app = express();

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

if (!process.env.JWT_SECRET) {
  console.error(
    "JWT_SECRET is not provided, fill it with random string or generate it using 'openssl rand -base64 32'"
  );
  process.exit(1);
}

app.use("/api/auth", authRouter);
app.use("/api/kelas", kelasRouter);
app.use("/api/matapelajaran", mataPelajaranRouter);
app.use("/api/bab", babRouter);
app.use("/api/sub-bab", subBabRouter);
app.use("/api/material", materialRouter);

app.listen(process.env.SERVER_PORT || 5000, () => {
  console.log("Server Running in Port " + process.env.SERVER_PORT);
});
