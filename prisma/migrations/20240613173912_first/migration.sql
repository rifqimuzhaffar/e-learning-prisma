-- CreateTable
CREATE TABLE `Kelas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_kelas` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ModePembelajaran` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_mode` VARCHAR(191) NOT NULL,
    `id_kelas` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MataPelajaran` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_pelajaran` VARCHAR(191) NOT NULL,
    `img_thumbnail` VARCHAR(191) NULL,
    `id_mode` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Bab` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_bab` VARCHAR(191) NOT NULL,
    `img_thumbnail` VARCHAR(191) NULL,
    `id_pelajaran` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Subbab` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_sub_bab` VARCHAR(191) NOT NULL,
    `is_gratis` BOOLEAN NOT NULL,
    `img_thumbnail` VARCHAR(191) NULL,
    `id_bab` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Material` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_material` VARCHAR(191) NOT NULL,
    `img_thumbnail` VARCHAR(191) NULL,
    `xp` INTEGER NOT NULL,
    `gold` INTEGER NOT NULL,
    `id_tipe_material` INTEGER NOT NULL,
    `id_sub_bab` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TipeMaterial` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `jenis_material` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nama_user` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `role` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserMaterial` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `id_user` INTEGER NOT NULL,
    `id_material` INTEGER NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `xp_earned` INTEGER NOT NULL,
    `gold_earned` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `ModePembelajaran` ADD CONSTRAINT `ModePembelajaran_id_kelas_fkey` FOREIGN KEY (`id_kelas`) REFERENCES `Kelas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MataPelajaran` ADD CONSTRAINT `MataPelajaran_id_mode_fkey` FOREIGN KEY (`id_mode`) REFERENCES `ModePembelajaran`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Bab` ADD CONSTRAINT `Bab_id_pelajaran_fkey` FOREIGN KEY (`id_pelajaran`) REFERENCES `MataPelajaran`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Subbab` ADD CONSTRAINT `Subbab_id_bab_fkey` FOREIGN KEY (`id_bab`) REFERENCES `Bab`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Material` ADD CONSTRAINT `Material_id_tipe_material_fkey` FOREIGN KEY (`id_tipe_material`) REFERENCES `TipeMaterial`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Material` ADD CONSTRAINT `Material_id_sub_bab_fkey` FOREIGN KEY (`id_sub_bab`) REFERENCES `Subbab`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserMaterial` ADD CONSTRAINT `UserMaterial_id_user_fkey` FOREIGN KEY (`id_user`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserMaterial` ADD CONSTRAINT `UserMaterial_id_material_fkey` FOREIGN KEY (`id_material`) REFERENCES `Material`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
