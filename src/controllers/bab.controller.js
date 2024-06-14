const prisma = require("../db");

const index = async (req, res, next) => {
  try {
    const { id_mata_pelajaran } = req.query;

    if (!id_mata_pelajaran) {
      return res.status(400).send({
        message: "error",
        error: "id_mata_pelajaran is required",
      });
    }

    const babs = await prisma.bab.findMany({
      where: {
        id_pelajaran: Number(id_mata_pelajaran),
      },
      include: {
        subbab: {
          select: {
            id: true,
            is_gratis: true,
            material: {
              select: {
                userMaterials: {
                  select: {
                    status: true,
                  },
                },
              },
            },
          },
        },
      },
    });

    const data = babs.map((bab) => ({
      id: bab.id,
      nama: bab.nama_bab,
      total_sub_bab_gratis: bab.subbab.filter((subBab) => subBab.is_gratis)
        .length,
      babProgress: calculateProgress(bab) || 0,
    }));

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

const calculateProgress = (bab) => {
  const totalSubBabs = bab.subbab.length;
  const completedSubBabs = bab.subbab.filter((subBab) => {
    return subBab.material.some((material) =>
      material.userMaterials.some(
        (userMaterial) => userMaterial.status === "completed"
      )
    );
  }).length;
  return (completedSubBabs / totalSubBabs) * 100;
};

module.exports = { index };
