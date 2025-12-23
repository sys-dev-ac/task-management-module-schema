/*
  Warnings:

  - A unique constraint covering the columns `[seller_id]` on the table `tm_workspaces` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `seller_id` to the `tm_workspaces` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `five_minute_journals` MODIFY `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User';

-- AlterTable
ALTER TABLE `goals` MODIFY `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User';

-- AlterTable
ALTER TABLE `notes` MODIFY `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User';

-- AlterTable
ALTER TABLE `tm_workspaces` ADD COLUMN `seller_id` BIGINT UNSIGNED NOT NULL,
    MODIFY `agency_id` BIGINT UNSIGNED NULL;

-- AlterTable
ALTER TABLE `todos` MODIFY `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User';

-- CreateIndex
CREATE UNIQUE INDEX `tm_workspaces_seller_id_key` ON `tm_workspaces`(`seller_id`);

-- AddForeignKey
ALTER TABLE `tm_workspaces` ADD CONSTRAINT `tm_workspaces_seller_id_fkey` FOREIGN KEY (`seller_id`) REFERENCES `sellers`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
