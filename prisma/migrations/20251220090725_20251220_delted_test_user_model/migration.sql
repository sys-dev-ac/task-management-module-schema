-- AlterTable
ALTER TABLE `five_minute_journals` MODIFY `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User';

-- AlterTable
ALTER TABLE `goals` MODIFY `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User';

-- AlterTable
ALTER TABLE `notes` MODIFY `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User';

-- AlterTable
ALTER TABLE `todos` MODIFY `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User';
