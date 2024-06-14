const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const prisma = require("../db");

/**
 * @param {import("express").Request} req
 * @param {import("express").Response} res
 * @param {import("express").NextFunction} next
 */
const register = async (req, res, next) => {
  const { nama_user, email, password, role } = req.body;

  try {
    const passwordHash = await bcrypt.hash(password, 10);
    const user = await prisma.user.create({
      data: {
        nama_user: nama_user,
        email: email,
        password: passwordHash,
        role: role || "regular",
      },
    });

    res.status(201).send({
      message: "User successfully registered",
      data: null,
    });
  } catch (err) {
    next(err);
  }
};

/**
 * @param {import("express").Request} req
 * @param {import("express").Response} res
 * @param {import("express").NextFunction} next
 */
const login = async (req, res, next) => {
  const { email, password } = req.body;

  try {
    const user = await prisma.user.findUnique({
      where: {
        email: email,
      },
    });

    if (!user) {
      return res.status(401).send({
        message: "Invalid email / password",
        data: null,
      });
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).send({
        message: "Invalid email / password",
        data: null,
      });
    }

    const token = jwt.sign(
      {
        id: user.id,
        name: user.namaUser,
        email: user.email,
      },
      process.env.JWT_SECRET
    );

    return res.send({
      message: "User successfully logged in",
      data: { token },
    });
  } catch (err) {
    next(err);
  }
};

module.exports = { register, login };
