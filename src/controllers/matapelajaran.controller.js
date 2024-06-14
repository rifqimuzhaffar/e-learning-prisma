const prisma = require("../db");

const index = async (req, res, next) => {
  try {
    const { id_kelas, id_mode_pembelajaran } = req.query;

    if (!id_kelas || !id_mode_pembelajaran) {
      return res.status(400).send({
        message: "error",
        error: "id_kelas and id_mode_pembelajaran are required",
      });
    }

    const mataPelajarans = await prisma.mataPelajaran.findMany({
      where: {
        id_mode: Number(id_mode_pembelajaran),
        modePembelajaran: {
          id_kelas: Number(id_kelas),
        },
      },
      select: {
        id: true,
        nama_pelajaran: true,
        img_thumbnail: true,
      },
    });

    return res.send({
      message: "success",
      data: mataPelajarans.map((pelajaran) => ({
        id: pelajaran.id,
        nama: pelajaran.nama_pelajaran,
        img_thumbnail: pelajaran.img_thumbnail,
      })),
    });
  } catch (error) {
    return res.status(500).send({
      message: "error",
      error: error.message,
    });
  }
};

module.exports = index;
