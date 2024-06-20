const prisma = require("../db");

const index = async (req, res, next) => {
  try {
    const kelass = await prisma.kelas.findMany();

    const data = [];

    for (const kelas of kelass) {
      const modePembelajarans = await prisma.modePembelajaran.findMany({
        where: { id_kelas: kelas.id },
      });

      data.push({
        kelas: {
          id: kelas.id,
          nama: kelas.nama_kelas,
        },
        modePembelajarans: modePembelajarans.map((mode) => ({
          id: mode.id,
          nama: mode.nama_mode,
        })),
      });
    }

    return res.send({
      message: "success",
      data: data,
    });
  } catch (error) {
    return res.status(500).send({
      message: "error",
      error: error.message,
    });
  }
};

module.exports = { index };
