-- CreateTable
CREATE TABLE `TestUser` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `TestUser_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `accounts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `account_type` VARCHAR(191) NULL,
    `account_details` TEXT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `is_default` TINYINT NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `acelle_campaigns` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `customer_id` INTEGER UNSIGNED NOT NULL,
    `type` TEXT NOT NULL,
    `name` TEXT NOT NULL,
    `subject` TEXT NOT NULL,
    `plain` LONGTEXT NOT NULL,
    `from_email` TEXT NOT NULL,
    `from_name` TEXT NOT NULL,
    `reply_to` TEXT NOT NULL,
    `status` TEXT NOT NULL,
    `sign_dkim` BOOLEAN NOT NULL,
    `track_open` BOOLEAN NOT NULL,
    `track_click` BOOLEAN NOT NULL,
    `resend` INTEGER NOT NULL,
    `custom_order` INTEGER NOT NULL,
    `run_at` TIMESTAMP(0) NULL,
    `delivery_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `template_source` TEXT NOT NULL,
    `last_error` TEXT NULL,
    `image` VARCHAR(191) NOT NULL,
    `default_mail_list_id` INTEGER UNSIGNED NULL,
    `tracking_domain_id` BIGINT UNSIGNED NULL,
    `use_default_sending_server_from_email` BOOLEAN NOT NULL DEFAULT false,
    `preheader` TEXT NULL,
    `running_pid` INTEGER NULL,
    `template_id` INTEGER UNSIGNED NULL,
    `skip_failed_message` BOOLEAN NOT NULL DEFAULT false,

    INDEX `acelle_campaigns_default_mail_list_id_foreign`(`default_mail_list_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `acelle_languages` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `region_code` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_default` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `acelle_pages` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `layout_id` INTEGER UNSIGNED NOT NULL,
    `mail_list_id` INTEGER UNSIGNED NOT NULL,
    `content` LONGTEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `subject` VARCHAR(191) NOT NULL,
    `use_outside_url` BOOLEAN NOT NULL DEFAULT false,
    `outside_url` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `acelle_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `value` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `acelle_subscribers` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `mail_list_id` INTEGER UNSIGNED NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `from` VARCHAR(191) NOT NULL,
    `ip` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `tags` TEXT NULL,
    `verification_status` VARCHAR(100) NULL,
    `last_verification_at` DATETIME(0) NULL,
    `last_verification_by` VARCHAR(100) NULL,
    `last_verification_result` MEDIUMTEXT NULL,
    `import_batch_id` CHAR(36) NULL,

    INDEX `acelle_subscribers_email_index`(`email`),
    INDEX `acelle_subscribers_mail_list_id_email_index`(`mail_list_id`, `email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `acelle_templates` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `customer_id` INTEGER UNSIGNED NULL,
    `name` VARCHAR(191) NOT NULL,
    `subject` VARCHAR(191) NULL,
    `from_name` VARCHAR(191) NULL,
    `from_email` VARCHAR(191) NULL,
    `reply_to` VARCHAR(191) NULL,
    `content` LONGTEXT NOT NULL,
    `custom_order` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `archived_at` TIMESTAMP(0) NULL,
    `builder` BOOLEAN NOT NULL DEFAULT false,
    `is_default` BOOLEAN NULL DEFAULT false,
    `theme` VARCHAR(191) NULL,
    `type` VARCHAR(191) NOT NULL,
    `is_blank` BOOLEAN NOT NULL DEFAULT false,

    INDEX `acelle_templates_archived_at_index`(`archived_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `activations` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `completed` BOOLEAN NOT NULL DEFAULT false,
    `completed_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `activations_user_id_completed_index`(`user_id`, `completed`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `addons` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `addon_identifier` VARCHAR(191) NOT NULL,
    `purchase_code` VARCHAR(191) NULL,
    `version` VARCHAR(191) NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `image` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `addresses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `phone_no` VARCHAR(191) NULL,
    `address` TEXT NOT NULL,
    `address_ids` VARCHAR(191) NULL,
    `country` VARCHAR(191) NULL,
    `state` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `latitude` DECIMAL(10, 8) NULL,
    `longitude` DECIMAL(11, 8) NULL,
    `postal_code` VARCHAR(191) NULL,
    `default_shipping` TINYINT NOT NULL DEFAULT 0,
    `default_billing` TINYINT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `addresses_default_billing_index`(`default_billing`),
    INDEX `addresses_default_shipping_index`(`default_shipping`),
    INDEX `addresses_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `admin_chat_support` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `agency_id` BIGINT UNSIGNED NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `whatsapp_number` VARCHAR(191) NOT NULL,
    `prefilled_message` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `admin_chat_support_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `admin_get_started` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `setup_sub_account` BOOLEAN NOT NULL DEFAULT false,
    `setup_white_label_account` BOOLEAN NOT NULL DEFAULT false,
    `setup_domains` BOOLEAN NOT NULL DEFAULT false,
    `add_plan` BOOLEAN NOT NULL DEFAULT false,
    `join_affiliate` BOOLEAN NOT NULL DEFAULT false,
    `add_staff` BOOLEAN NOT NULL DEFAULT false,
    `setup_white_label_settings` BOOLEAN NOT NULL DEFAULT false,
    `setup_pricing_plans` BOOLEAN NOT NULL DEFAULT false,
    `completion_percentage` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `setup_chat_support` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `affiliate_clicks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `affiliate_id` BIGINT UNSIGNED NULL,
    `package_id` BIGINT UNSIGNED NULL,
    `click_date_time` DATETIME(0) NOT NULL,
    `ip_address` TEXT NULL,
    `referral_url` VARCHAR(191) NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `affiliate_clicks_affiliate_id_foreign`(`affiliate_id`),
    INDEX `affiliate_clicks_package_id_foreign`(`package_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `affiliate_packages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `affiliate_id` BIGINT UNSIGNED NULL,
    `program_package_id` BIGINT UNSIGNED NULL,
    `commission_percentage` DECIMAL(8, 2) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `affiliate_packages_affiliate_id_foreign`(`affiliate_id`),
    INDEX `affiliate_packages_program_package_id_foreign`(`program_package_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `affiliates` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `commission` DECIMAL(4, 2) NOT NULL DEFAULT 40.00,
    `razorpay_account_id` VARCHAR(191) NULL,
    `razorpay_account_product_id` VARCHAR(191) NULL,
    `razorpay_activation_status` VARCHAR(191) NULL,
    `join_date` DATETIME(0) NOT NULL,
    `affiliate_type` TINYINT NOT NULL,
    `is_agency_admin_affiliate` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `agency_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,

    INDEX `affiliates_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agencies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id` BIGINT UNSIGNED NULL,
    `super_agency_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `sales_email` VARCHAR(191) NOT NULL,
    `admin_email` VARCHAR(191) NOT NULL,
    `subscribed_till` DATETIME(0) NULL,
    `lifetime_validity` BOOLEAN NOT NULL DEFAULT false,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `version` VARCHAR(191) NOT NULL DEFAULT '000',
    `version_android` VARCHAR(191) NOT NULL DEFAULT '000',
    `unlimited_credits` BOOLEAN NOT NULL DEFAULT false,
    `sub_account_credit_price` INTEGER UNSIGNED NOT NULL DEFAULT 2000,
    `sub_account_package_type` VARCHAR(191) NOT NULL DEFAULT 'Diamond Seller',
    `white_label_credit_price` INTEGER UNSIGNED NOT NULL DEFAULT 2000,
    `email_credit_charge` DECIMAL(3, 2) NOT NULL DEFAULT 0.09,
    `sms_trn_credit_charge` DECIMAL(3, 2) NOT NULL DEFAULT 0.09,
    `sms_promo_credit_charge` DECIMAL(3, 2) NOT NULL DEFAULT 0.09,
    `health_enabled` BOOLEAN NOT NULL DEFAULT false,
    `agency_type` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `notification_app_id` VARCHAR(191) NULL,
    `notification_api_key` VARCHAR(191) NULL,
    `organization_domain` VARCHAR(191) NULL,
    `organization_sub_domain` VARCHAR(191) NULL,
    `marketplace_enabled` BOOLEAN NOT NULL DEFAULT false,
    `ai_suite_enabled` BOOLEAN NOT NULL DEFAULT false,
    `whatsapp_cloud_api` BOOLEAN NOT NULL DEFAULT true,
    `success_habits` BOOLEAN NOT NULL DEFAULT true,
    `lms` BOOLEAN NOT NULL DEFAULT true,
    `social_network` BOOLEAN NOT NULL DEFAULT true,
    `group_chat` BOOLEAN NOT NULL DEFAULT true,
    `ad_launcher` BOOLEAN NOT NULL DEFAULT true,
    `student_portal` BOOLEAN NOT NULL DEFAULT true,
    `common_mobile_app` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `agencies_customer_id_index`(`customer_id`),
    INDEX `agencies_super_agency_id_index`(`super_agency_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_affiliate_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `agency_id` BIGINT UNSIGNED NOT NULL,
    `razorpay_key` VARCHAR(191) NULL,
    `razorpay_secret` VARCHAR(191) NULL,
    `commission_percentage` VARCHAR(191) NOT NULL DEFAULT '40',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `agency_affiliate_settings_agency_id_index`(`agency_id`),
    INDEX `agency_affiliate_settings_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_cancellations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `signature_file` VARCHAR(191) NULL,
    `nullified` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `agency_cancellations_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `agency_id` BIGINT UNSIGNED NOT NULL,
    `parent_id` BIGINT UNSIGNED NULL,
    `position` INTEGER NULL,
    `ordering` INTEGER NOT NULL DEFAULT 0,
    `slug` VARCHAR(191) NOT NULL,
    `commission` DOUBLE NOT NULL DEFAULT 0.000,
    `is_featured` TINYINT NOT NULL DEFAULT 0,
    `status` TINYINT NOT NULL DEFAULT 0,
    `icon` TEXT NULL,
    `logo_id` BIGINT UNSIGNED NULL,
    `logo` TEXT NULL,
    `banner_id` BIGINT UNSIGNED NULL,
    `banner` TEXT NULL,
    `icon_location` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_category_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `title` VARCHAR(191) NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_credit_costs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `agency_id` BIGINT UNSIGNED NOT NULL,
    `plan_type` ENUM('Silver Seller', 'Gold Seller', 'Diamond Seller') NOT NULL,
    `cost` DOUBLE NOT NULL DEFAULT 1.00,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_email_plans` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `agency_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `credit` VARCHAR(191) NOT NULL,
    `plan_id` BIGINT UNSIGNED NOT NULL,
    `status` BOOLEAN NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_extention_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `agency_id` BIGINT UNSIGNED NOT NULL,
    `extended_months` INTEGER UNSIGNED NULL,
    `previous_date` DATETIME(0) NULL,
    `new_date` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `agency_extention_logs_agency_id_index`(`agency_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_marketplace_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `agency_id` BIGINT UNSIGNED NOT NULL,
    `marketplace_name` VARCHAR(191) NULL,
    `settings` LONGTEXT NULL,
    `home_components` MEDIUMTEXT NULL,
    `banner` TEXT NULL,
    `light_logo` TEXT NULL,
    `dark_logo` TEXT NULL,
    `footer_logo` TEXT NULL,
    `business_network_banner` TEXT NULL,
    `mobile_app_banner` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `meta_info` LONGTEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_plan_permissions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `agency_plan_id` BIGINT UNSIGNED NOT NULL,
    `shop_builder` BOOLEAN NOT NULL DEFAULT true,
    `funnel_builder` BOOLEAN NOT NULL DEFAULT true,
    `form_builder` BOOLEAN NULL,
    `url_redirect` BOOLEAN NOT NULL DEFAULT true,
    `ad_launcher` BOOLEAN NOT NULL DEFAULT true,
    `crm` BOOLEAN NOT NULL DEFAULT true,
    `emails` BOOLEAN NOT NULL DEFAULT true,
    `SMS_gateway` BOOLEAN NOT NULL DEFAULT false,
    `whatsapp_sender` BOOLEAN NOT NULL DEFAULT true,
    `whatsapp_official` BOOLEAN NOT NULL DEFAULT true,
    `IVR_calls` BOOLEAN NOT NULL DEFAULT true,
    `ai_dashboard` BOOLEAN NOT NULL DEFAULT false,
    `ai_brain` BOOLEAN NOT NULL DEFAULT false,
    `ai_funnels` BOOLEAN NOT NULL DEFAULT false,
    `ai_agents` BOOLEAN NOT NULL DEFAULT false,
    `automation_workflow` BOOLEAN NOT NULL DEFAULT true,
    `bulk_campaigns` BOOLEAN NOT NULL DEFAULT true,
    `calendar_booking` BOOLEAN NOT NULL DEFAULT true,
    `sales_and_finance` BOOLEAN NOT NULL DEFAULT true,
    `lms` BOOLEAN NOT NULL DEFAULT true,
    `success_habits` BOOLEAN NOT NULL DEFAULT true,
    `community` BOOLEAN NOT NULL DEFAULT true,
    `app_store` BOOLEAN NOT NULL DEFAULT true,
    `knowledge_base` BOOLEAN NOT NULL DEFAULT true,
    `idea_board` BOOLEAN NOT NULL DEFAULT true,
    `manage_staff` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `agency_plan_permissions_agency_plan_id_index`(`agency_plan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agency_plans` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `agency_id` BIGINT UNSIGNED NOT NULL,
    `enabled_for_affiliate` BOOLEAN NOT NULL DEFAULT false,
    `name` VARCHAR(191) NOT NULL,
    `duration` DECIMAL(4, 2) NOT NULL,
    `complimentary` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `plan_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `snapshot_id` BIGINT UNSIGNED NULL,
    `email_limit` BIGINT UNSIGNED NOT NULL DEFAULT 10000,
    `unlimited_staff` BOOLEAN NOT NULL DEFAULT true,
    `staff_limit` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `unlimited_contacts` BOOLEAN NOT NULL DEFAULT true,
    `contacts_limit` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `activate_package_on_purchase` BOOLEAN NOT NULL DEFAULT true,
    `plan_type` ENUM('Silver Seller', 'Gold Seller', 'Premium Gold Seller', 'Diamond Seller', 'Premium Diamond Seller') NOT NULL DEFAULT 'Diamond Seller',
    `health_enabled` BOOLEAN NOT NULL DEFAULT false,
    `school_enabled` BOOLEAN NOT NULL DEFAULT false,
    `school_community_settings` TEXT NULL,
    `template_access_enabled` BOOLEAN NOT NULL DEFAULT true,
    `template_access_list` TEXT NULL,
    `credit_usage` DOUBLE NOT NULL DEFAULT 1.00,
    `charged_yearly_without_discount_credit` BOOLEAN NOT NULL DEFAULT false,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `agency_plans_snapshot_id_index`(`snapshot_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `announcement_banner_analytics` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `banner_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `sub_account_id` VARCHAR(191) NULL,
    `event_type` ENUM('impression', 'click', 'dismiss') NOT NULL,
    `user_agent` VARCHAR(191) NULL,
    `ip_address` VARCHAR(45) NULL,
    `metadata` JSON NULL,
    `created_at` TIMESTAMP(0) NOT NULL,

    INDEX `announcement_banner_analytics_event_type_index`(`event_type`),
    INDEX `idx_banner_event_created`(`banner_id`, `event_type`, `created_at`),
    INDEX `idx_created`(`created_at`),
    INDEX `idx_user_created`(`user_id`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `announcement_banner_dismissals` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `banner_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `sub_account_id` VARCHAR(191) NULL,
    `is_permanent` BOOLEAN NOT NULL DEFAULT false,
    `dismissed_at` TIMESTAMP(0) NOT NULL,

    INDEX `announcement_banner_dismissals_dismissed_at_index`(`dismissed_at`),
    INDEX `announcement_banner_dismissals_user_id_banner_id_index`(`user_id`, `banner_id`),
    UNIQUE INDEX `idx_dismissal_unique`(`banner_id`, `user_id`, `sub_account_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `announcement_banners` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `agency_id` BIGINT UNSIGNED NULL,
    `title` VARCHAR(191) NOT NULL,
    `content` TEXT NOT NULL,
    `type` ENUM('text', 'html', 'image') NOT NULL DEFAULT 'text',
    `style` ENUM('popup', 'card', 'notification', 'bar', 'toast') NOT NULL DEFAULT 'notification',
    `animation` ENUM('slide-top', 'slide-bottom', 'slide-left', 'slide-right', 'bounce', 'fade', 'pulse', 'none') NOT NULL DEFAULT 'fade',
    `image_url` VARCHAR(191) NULL,
    `link_url` VARCHAR(191) NULL,
    `button_text` VARCHAR(191) NULL,
    `background_color` VARCHAR(191) NOT NULL DEFAULT '#3b82f6',
    `text_color` VARCHAR(191) NOT NULL DEFAULT '#ffffff',
    `button_color` VARCHAR(191) NULL,
    `priority` INTEGER NOT NULL DEFAULT 0,
    `is_dismissible` BOOLEAN NOT NULL DEFAULT true,
    `permanent_dismiss` BOOLEAN NOT NULL DEFAULT false,
    `show_countdown` BOOLEAN NOT NULL DEFAULT false,
    `start_time` TIMESTAMP(0) NULL,
    `end_time` TIMESTAMP(0) NULL,
    `targeting_rules` JSON NULL,
    `display_settings` JSON NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `impression_count` INTEGER NOT NULL DEFAULT 0,
    `click_count` INTEGER NOT NULL DEFAULT 0,
    `dismiss_count` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `announcement_banners_agency_id_index`(`agency_id`),
    INDEX `announcement_banners_priority_index`(`priority`),
    INDEX `idx_aa_start_end`(`agency_id`, `is_active`, `start_time`, `end_time`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `api_key_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `api_key_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(191) NOT NULL DEFAULT 'en',
    `title` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `api_keys` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `key` VARCHAR(191) NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `app_intro_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `order` VARCHAR(191) NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `app_intro_id` BIGINT NOT NULL,
    `description` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `app_intro_languages_lang_index`(`lang`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `app_intros` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `status` TINYINT NOT NULL DEFAULT 1,
    `image_id` BIGINT UNSIGNED NULL,
    `image` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `app_notifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `notifiable_id` BIGINT UNSIGNED NOT NULL,
    `user_type` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `notifiable_type` VARCHAR(191) NOT NULL,
    `data` TEXT NOT NULL,
    `read_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `app_notifications_notifiable_id_index`(`notifiable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `app_store` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `app_name` VARCHAR(191) NULL,
    `code` VARCHAR(1024) NULL,
    `state` VARCHAR(191) NULL,
    `url` VARCHAR(1024) NULL,
    `access_token` VARCHAR(1024) NULL,
    `default` BOOLEAN NOT NULL DEFAULT false,
    `refresh_token` VARCHAR(1024) NULL,
    `expires_at` VARCHAR(191) NULL,
    `data` JSON NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `app_store_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `apps` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` CHAR(36) NOT NULL,
    `key` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `device_id` BIGINT UNSIGNED NULL,
    `title` VARCHAR(191) NULL,
    `website` VARCHAR(191) NULL,
    `status` INTEGER NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `apps_uuid_unique`(`uuid`),
    UNIQUE INDEX `apps_key_unique`(`key`),
    INDEX `apps_device_id_foreign`(`device_id`),
    INDEX `apps_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `assignables` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `assignable_id` BIGINT UNSIGNED NOT NULL,
    `assignable_type` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `assignables_assignable_id_index`(`assignable_id`),
    INDEX `assignables_assignable_type_index`(`assignable_type`),
    INDEX `assignables_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attachments` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `email_id` BIGINT UNSIGNED NULL,
    `template_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NOT NULL,
    `file` VARCHAR(191) NOT NULL,
    `size` VARCHAR(191) NOT NULL,
    `storage` VARCHAR(191) NOT NULL DEFAULT 'aws_s3',
    `media_id` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute_category` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id` BIGINT UNSIGNED NOT NULL,
    `attribute_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `title` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `attribute_languages_attribute_id_lang_index`(`attribute_id`, `lang`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute_values` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `attribute_id` BIGINT UNSIGNED NOT NULL,
    `value` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attributes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `auto_triggers` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `subscriber_id` INTEGER UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `data` TEXT NULL,
    `automation2_id` INTEGER UNSIGNED NOT NULL,
    `executed_index` TEXT NULL,
    `exited_at` TIMESTAMP(0) NULL,
    `last_error` TEXT NULL,
    `event_time` TIMESTAMP(0) NULL,
    `next_run_on` TIMESTAMP(0) NULL,
    `event_time_actions` INTEGER UNSIGNED NULL DEFAULT 0,
    `appointment_id` INTEGER UNSIGNED NULL,
    `skip_notification_action` BOOLEAN NOT NULL DEFAULT false,
    `invoice_id` VARCHAR(191) NULL,
    `order_id` VARCHAR(191) NULL,
    `instagram_action_id` VARCHAR(191) NULL,
    `is_test` BOOLEAN NOT NULL DEFAULT false,

    INDEX `auto_triggers_appointment_id_foreign`(`appointment_id`),
    INDEX `auto_triggers_automation2_id_foreign`(`automation2_id`),
    INDEX `auto_triggers_automation2_id_subscriber_id_index`(`automation2_id`, `subscriber_id`),
    INDEX `auto_triggers_created_at_index`(`created_at`),
    INDEX `auto_triggers_exited_at_index`(`exited_at`),
    INDEX `auto_triggers_instagram_action_id_index`(`instagram_action_id`),
    INDEX `auto_triggers_invoice_id_index`(`invoice_id`),
    INDEX `auto_triggers_is_test_index`(`is_test`),
    INDEX `auto_triggers_next_run_on_index`(`next_run_on`),
    INDEX `auto_triggers_query_optimization_index`(`is_test`, `automation2_id`, `exited_at`, `created_at`),
    INDEX `auto_triggers_skip_notification_action_index`(`skip_notification_action`),
    INDEX `auto_triggers_subscriber_id_index`(`subscriber_id`),
    INDEX `idx_auto_triggers_update_optimization`(`automation2_id`, `exited_at`, `next_run_on`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `automation2_versions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `automation2_id` INTEGER UNSIGNED NOT NULL,
    `version_name` VARCHAR(191) NULL,
    `data` LONGTEXT NOT NULL,
    `is_user_saved` BOOLEAN NOT NULL DEFAULT false,
    `description` TEXT NULL,
    `created_by` BIGINT UNSIGNED NULL,
    `loaded_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `automation2_versions_uid_unique`(`uid`),
    INDEX `auto2_versions_auto_user_created_idx`(`automation2_id`, `is_user_saved`, `created_at`),
    INDEX `automation2_versions_is_user_saved_index`(`is_user_saved`),
    INDEX `automation2_versions_loaded_at_index`(`loaded_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `automation2s` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `customer_id` INTEGER UNSIGNED NOT NULL,
    `mail_list_id` INTEGER UNSIGNED NOT NULL,
    `time_zone` VARCHAR(191) NULL,
    `status` VARCHAR(191) NOT NULL,
    `shard_number` TINYINT NOT NULL DEFAULT 0,
    `data` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `segment_id` TEXT NULL,
    `last_error` TEXT NULL,
    `schedule_on` TIMESTAMP(0) NULL,
    `schedule_off` TIMESTAMP(0) NULL,
    `allow_duplicate` BOOLEAN NOT NULL DEFAULT false,
    `trigger_type` VARCHAR(191) NULL,
    `specific_time` BOOLEAN NULL,
    `specific_start_time` VARCHAR(191) NULL,
    `specific_end_time` VARCHAR(191) NULL,
    `specific_days` TEXT NULL,

    INDEX `automation2s_customer_id_index`(`customer_id`),
    INDEX `automation2s_status_customer_id_trigger_type_created_at_index`(`status`, `customer_id`, `trigger_type`, `created_at`),
    INDEX `automation2s_trigger_type_index`(`trigger_type`),
    INDEX `idx_customer_status`(`customer_id`, `status`),
    INDEX `idx_shard_number`(`shard_number`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `automation_overdue_configs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `automation_id` INTEGER UNSIGNED NOT NULL,
    `automation_uid` VARCHAR(191) NULL,
    `overdueable_type` VARCHAR(191) NOT NULL,
    `overdueable_id` BIGINT UNSIGNED NOT NULL,
    `morph_db` VARCHAR(191) NULL,
    `delay` INTEGER NOT NULL DEFAULT 0,
    `overdue_webhook` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `automation_overdue_configs_automation_id_foreign`(`automation_id`),
    INDEX `automation_overdue_configs_overdueable_type_overdueable_id_index`(`overdueable_type`, `overdueable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `banners` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `order` INTEGER NOT NULL DEFAULT 1,
    `link` VARCHAR(191) NOT NULL DEFAULT '/',
    `status` VARCHAR(191) NOT NULL DEFAULT '1',
    `image_id` BIGINT UNSIGNED NULL,
    `image` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `batches` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `total_records` INTEGER UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `batches_type_index`(`type`),
    INDEX `batches_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blog_categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `slug` VARCHAR(100) NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `blog_categories_slug_status_index`(`slug`, `status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blog_category_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `blog_category_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `title` VARCHAR(191) NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `blog_category_languages_blog_category_id_lang_index`(`blog_category_id`, `lang`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blog_comment_likes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `commentable_type` VARCHAR(191) NOT NULL,
    `commentable_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `blog_comment_likes_commentable_type_commentable_id_index`(`commentable_type`, `commentable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blog_comment_replies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `blog_comment_id` BIGINT UNSIGNED NOT NULL,
    `parent_id` BIGINT UNSIGNED NULL,
    `comment` TEXT NULL,
    `level` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `blog_comment_replies_blog_comment_id_foreign`(`blog_comment_id`),
    INDEX `blog_comment_replies_parent_id_foreign`(`parent_id`),
    INDEX `blog_comment_replies_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blog_comments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `blog_id` BIGINT UNSIGNED NOT NULL,
    `comment` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `blog_comments_blog_id_foreign`(`blog_id`),
    INDEX `blog_comments_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blog_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `blog_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `title` VARCHAR(191) NOT NULL,
    `short_description` TEXT NULL,
    `long_description` LONGTEXT NULL,
    `tags` TEXT NULL,
    `meta_title` VARCHAR(250) NULL,
    `meta_description` TEXT NULL,
    `meta_keyword` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `blog_languages_blog_id_lang_index`(`blog_id`, `lang`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blog_views` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `blog_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `blog_views_blog_id_foreign`(`blog_id`),
    INDEX `blog_views_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `blogs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `image_id` BIGINT UNSIGNED NULL,
    `image` TEXT NULL,
    `banner_id` BIGINT UNSIGNED NULL,
    `banner` TEXT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'published',
    `slug` VARCHAR(100) NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `blogs_user_id_status_index`(`user_id`, `status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `brand_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `brand_id` BIGINT NOT NULL,
    `lang` VARCHAR(10) NOT NULL,
    `title` VARCHAR(191) NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `brand_languages_brand_id_lang_title_index`(`brand_id`, `lang`, `title`),
    INDEX `brand_languages_lang_index`(`lang`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `brands` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `slug` VARCHAR(100) NOT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `logo_id` BIGINT UNSIGNED NULL,
    `logo` TEXT NULL,
    `banner_id` BIGINT UNSIGNED NULL,
    `banner` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `brands_slug_status_index`(`slug`, `status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `bulk_operation_entries` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `bulk_operation_id` BIGINT UNSIGNED NOT NULL,
    `batch_id` BIGINT UNSIGNED NULL,
    `identifier_id` BIGINT UNSIGNED NULL,
    `line` BIGINT UNSIGNED NULL,
    `identifier` VARCHAR(191) NULL,
    `identifier_class` VARCHAR(191) NULL,
    `status` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `bulk_message_key` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `bulk_operation_entries_batch_id_index`(`batch_id`),
    INDEX `bulk_operation_entries_bulk_operation_id_index`(`bulk_operation_id`),
    INDEX `bulk_operation_entries_identifier_class_identifier_id_index`(`identifier_class`, `identifier_id`),
    INDEX `bulk_operation_entries_status_index`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `bulk_operations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `server_side_event_id` BIGINT UNSIGNED NULL,
    `operation_name` VARCHAR(191) NULL,
    `type` VARCHAR(191) NULL,
    `module` VARCHAR(191) NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `message` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `bulk_operations_server_side_event_id_index`(`server_side_event_id`),
    INDEX `bulk_operations_type_module_index`(`type`, `module`),
    INDEX `bulk_operations_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `call_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `call_status` VARCHAR(191) NULL,
    `call_type` VARCHAR(191) NULL,
    `duration` VARCHAR(191) NULL,
    `handled_by` VARCHAR(191) NULL,
    `handled_status` VARCHAR(191) NULL,
    `department` VARCHAR(191) NULL,
    `file_path` TEXT NULL,
    `response` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `call_logs_contact_id_index`(`contact_id`),
    INDEX `call_logs_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaign_audience` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `campaign_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_message_sent` BIGINT NOT NULL DEFAULT 0,
    `whatsapp_status` ENUM('sent', 'failed') NULL,
    `email_status` ENUM('sent', 'failed') NULL,
    `wamid` VARCHAR(191) NULL,
    `email_id` BIGINT UNSIGNED NULL,
    `campaign_log_id` BIGINT UNSIGNED NULL,
    `sms_status` VARCHAR(191) NULL,

    INDEX `campaign_audience_campaign_id_index`(`campaign_id`),
    INDEX `campaign_audience_campaign_log_id_foreign`(`campaign_log_id`),
    INDEX `campaign_audience_contact_id_index`(`contact_id`),
    INDEX `campaign_audience_email_id_index`(`email_id`),
    INDEX `campaign_audience_is_message_sent_index`(`is_message_sent`),
    INDEX `idx_campaign_audience_campaign_id`(`campaign_id`),
    INDEX `idx_campaign_audience_contact_id`(`contact_id`),
    INDEX `idx_campaign_audience_email_status`(`email_status`),
    INDEX `idx_campaign_audience_wamid`(`wamid`),
    INDEX `idx_campaign_audience_whatsapp_status`(`whatsapp_status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaign_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `campaign_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `campaign_languages_campaign_id_lang_title_index`(`campaign_id`, `lang`, `title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaign_links` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `campaign_id` INTEGER UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `url` TEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaign_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `campaign_audience_id` BIGINT UNSIGNED NULL,
    `__data` JSON NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `date` DATE NULL,

    INDEX `campaign_logs_campaign_audience_id_foreign`(`campaign_audience_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaign_products` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `campaign_id` BIGINT UNSIGNED NOT NULL,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `discount` DOUBLE NULL,
    `discount_type` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaign_requests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `campaign_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `discount` DOUBLE NOT NULL DEFAULT 0.000,
    `discount_type` VARCHAR(191) NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaign_webhooks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `endpoint` TEXT NOT NULL,
    `campaign_id` INTEGER UNSIGNED NOT NULL,
    `campaign_link_id` INTEGER UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaigns` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `slug` VARCHAR(191) NOT NULL,
    `background_color` VARCHAR(50) NULL,
    `text_color` VARCHAR(50) NULL,
    `banner_id` BIGINT UNSIGNED NULL,
    `banner` TEXT NULL,
    `thumbnail` TEXT NULL,
    `thumbnail_id` BIGINT UNSIGNED NULL,
    `start_date` TIMESTAMP(0) NULL,
    `end_date` TIMESTAMP(0) NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `featured` TINYINT NOT NULL DEFAULT 0,
    `flash_sale` TINYINT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `campaigns_slug_unique`(`slug`),
    INDEX `campaigns_slug_start_date_end_date_status_index`(`slug`, `start_date`, `end_date`, `status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `campaigns_lists_segments` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `campaign_id` INTEGER UNSIGNED NOT NULL,
    `mail_list_id` INTEGER UNSIGNED NOT NULL,
    `segment_id` INTEGER UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `carts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `seller_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `guest_id` VARCHAR(30) NULL,
    `product_id` BIGINT UNSIGNED NULL,
    `variant` VARCHAR(191) NULL,
    `quantity` INTEGER NULL,
    `price` DOUBLE NULL,
    `discount` DOUBLE NULL,
    `tax` DOUBLE NULL,
    `shipping_cost` DOUBLE NULL,
    `shipping_type` VARCHAR(190) NULL,
    `coupon_applied` BOOLEAN NULL DEFAULT false,
    `coupon_discount` DOUBLE NULL,
    `trx_id` VARCHAR(191) NULL,
    `product_referral_code` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` BIGINT NULL,
    `position` INTEGER NULL,
    `ordering` INTEGER NOT NULL DEFAULT 0,
    `slug` VARCHAR(100) NOT NULL,
    `commission` DOUBLE NULL DEFAULT 0.000,
    `is_featured` TINYINT NOT NULL DEFAULT 0,
    `status` TINYINT NOT NULL DEFAULT 1,
    `icon` TEXT NULL,
    `logo_id` BIGINT UNSIGNED NULL,
    `logo` TEXT NULL,
    `banner_id` BIGINT UNSIGNED NULL,
    `banner` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `icon_location` VARCHAR(191) NULL,

    INDEX `categories_is_featured_index`(`is_featured`),
    INDEX `categories_ordering_index`(`ordering`),
    INDEX `categories_parent_id_slug_status_index`(`parent_id`, `slug`, `status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `category_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id` BIGINT NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `title` VARCHAR(191) NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `category_languages_category_id_lang_title_index`(`category_id`, `lang`, `title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `chat_histories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(191) NULL,
    `chat_code` VARCHAR(191) NULL,
    `message_code` VARCHAR(191) NULL,
    `chat` LONGTEXT NULL,
    `messages` INTEGER NULL,
    `favorite` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `chat_histories_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `chat_rooms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `receiver_id` BIGINT UNSIGNED NOT NULL,
    `is_accepted` TINYINT NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `chat_widgets` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `uid` CHAR(36) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` TEXT NULL,
    `settings` JSON NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `assigned_user_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `chat_widgets_uid_unique`(`uid`),
    INDEX `chat_widgets_assigned_user_id_index`(`assigned_user_id`),
    INDEX `chat_widgets_user_id_status_index`(`user_id`, `status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `chats` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `sub_name` VARCHAR(191) NULL,
    `chat_code` VARCHAR(191) NOT NULL,
    `logo` VARCHAR(191) NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `prompt` LONGTEXT NULL,
    `description` LONGTEXT NULL,
    `category` VARCHAR(191) NULL,
    `type` VARCHAR(191) NOT NULL DEFAULT 'original',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `checkouts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `seller_id` BIGINT UNSIGNED NOT NULL,
    `coupon_id` BIGINT UNSIGNED NULL,
    `trx_id` VARCHAR(191) NULL,
    `coupon_discount` DOUBLE NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(191) NULL,
    `state_id` BIGINT UNSIGNED NOT NULL,
    `country_id` BIGINT UNSIGNED NOT NULL,
    `cost` DOUBLE NOT NULL DEFAULT 0.000,
    `latitude` DECIMAL(10, 8) NULL,
    `longitude` DECIMAL(11, 8) NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `logo` VARCHAR(191) NULL,
    `banner` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `click_logs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `message_id` VARCHAR(191) NOT NULL,
    `url` TEXT NOT NULL,
    `ip_address` VARCHAR(191) NOT NULL,
    `user_agent` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `click_logs_message_id_foreign`(`message_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `color_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `color_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `color_languages_color_id_name_lang_index`(`color_id`, `name`, `lang`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `colors` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(50) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `commission_histories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` BIGINT UNSIGNED NULL,
    `order_detail_id` BIGINT UNSIGNED NULL,
    `seller_id` BIGINT UNSIGNED NULL,
    `admin_commission` DOUBLE NULL DEFAULT 0.000,
    `seller_earning` DOUBLE NULL DEFAULT 0.000,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_announcements` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` CHAR(36) NOT NULL,
    `community_owner_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `content` TEXT NULL,
    `image_url` VARCHAR(191) NULL,
    `has_cta` BOOLEAN NOT NULL DEFAULT false,
    `link_url` VARCHAR(191) NULL,
    `button_text` VARCHAR(191) NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `community_announcements_uuid_unique`(`uuid`),
    INDEX `community_announcements_community_owner_id_foreign`(`community_owner_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `slug` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `order` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `community_categories_user_id_name_unique`(`user_id`, `name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_channel_criteria` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `channel_id` BIGINT UNSIGNED NOT NULL,
    `criteria_type` VARCHAR(191) NOT NULL,
    `criteria_id` BIGINT UNSIGNED NOT NULL,
    `criteria_meta` JSON NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `idx_channel_criteria`(`channel_id`, `criteria_type`, `criteria_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_channels` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` CHAR(36) NOT NULL,
    `community_owner_id` BIGINT UNSIGNED NOT NULL,
    `owner_id` BIGINT UNSIGNED NOT NULL,
    `owner_type` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `slug` VARCHAR(191) NOT NULL,
    `visibility` VARCHAR(191) NOT NULL DEFAULT 'hidden',
    `allow_posting` BOOLEAN NOT NULL DEFAULT true,
    `order` INTEGER NOT NULL DEFAULT 0,
    `icon_url` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `community_channels_uuid_unique`(`uuid`),
    INDEX `idx_channels_community_owner`(`community_owner_id`),
    INDEX `idx_channels_order`(`order`),
    INDEX `idx_channels_owner`(`owner_id`, `owner_type`),
    INDEX `idx_channels_owner_visibility_order`(`community_owner_id`, `visibility`, `order`),
    INDEX `idx_channels_visibility`(`visibility`),
    UNIQUE INDEX `community_channels_community_owner_id_name_unique`(`community_owner_id`, `name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_chat_inboxes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `ulid` VARCHAR(191) NOT NULL,
    `group_id` VARCHAR(191) NOT NULL,
    `sender_id` BIGINT UNSIGNED NULL,
    `type` ENUM('group', 'personal') NOT NULL,
    `__data` TEXT NULL,
    `last_message_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `community_chat_inboxes_ulid_unique`(`ulid`),
    INDEX `community_chat_inboxes_group_id_index`(`group_id`),
    INDEX `community_chat_inboxes_last_message_at_index`(`last_message_at`),
    INDEX `community_chat_inboxes_sender_id_foreign`(`sender_id`),
    INDEX `community_chat_inboxes_type_index`(`type`),
    INDEX `community_chat_inboxes_type_last_message_at_index`(`type`, `last_message_at`),
    INDEX `community_chat_inboxes_ulid_index`(`ulid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_comments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `post_id` BIGINT UNSIGNED NOT NULL,
    `owner_id` BIGINT UNSIGNED NOT NULL,
    `owner_type` VARCHAR(191) NOT NULL,
    `comment` LONGTEXT NULL,
    `parent_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `attachments` JSON NULL,

    INDEX `community_comments_post_id_foreign`(`post_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_custom_links` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `community_owner_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `url` VARCHAR(191) NOT NULL,
    `open_in_new_tab` BOOLEAN NOT NULL DEFAULT true,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `community_custom_links_community_owner_id_foreign`(`community_owner_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_follows` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `community_owner_id` BIGINT UNSIGNED NOT NULL,
    `follower_id` BIGINT UNSIGNED NOT NULL,
    `following_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `community_follows_follower_id_foreign`(`follower_id`),
    INDEX `community_follows_following_id_foreign`(`following_id`),
    UNIQUE INDEX `community_follows_unique`(`community_owner_id`, `follower_id`, `following_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_group_members` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `group_id` VARCHAR(191) NOT NULL,
    `member_id` BIGINT UNSIGNED NOT NULL,
    `role` ENUM('admin', 'moderator', 'member') NOT NULL DEFAULT 'member',
    `activity_type` ENUM('added', 'removed', 'left', 'joined') NULL,
    `activity_by` BIGINT UNSIGNED NULL,
    `activity_at` TIMESTAMP(0) NULL,
    `removed_at` TIMESTAMP(0) NULL,
    `removed_by` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `is_pinned` BOOLEAN NOT NULL DEFAULT false,
    `is_muted` BOOLEAN NOT NULL DEFAULT false,
    `is_archived` BOOLEAN NOT NULL DEFAULT false,

    INDEX `community_group_members_activity_by_foreign`(`activity_by`),
    INDEX `community_group_members_group_id_role_index`(`group_id`, `role`),
    INDEX `community_group_members_member_id_role_index`(`member_id`, `role`),
    INDEX `community_group_members_removed_at_index`(`removed_at`),
    INDEX `community_group_members_removed_by_foreign`(`removed_by`),
    UNIQUE INDEX `community_group_members_group_id_member_id_unique`(`group_id`, `member_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` CHAR(36) NOT NULL,
    `community_owner_id` BIGINT UNSIGNED NULL,
    `owner_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `slug` VARCHAR(191) NOT NULL,
    `type` ENUM('public', 'private', 'secret') NOT NULL,
    `description` TEXT NULL,
    `icon_url` VARCHAR(191) NULL,
    `cover_url` VARCHAR(191) NULL,
    `is_password_protected` BOOLEAN NOT NULL DEFAULT false,
    `password` VARCHAR(191) NULL,
    `is_unleavable` BOOLEAN NOT NULL DEFAULT false,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `default_role` ENUM('admin', 'moderator', 'member') NOT NULL DEFAULT 'member',
    `is_pinned` BOOLEAN NOT NULL DEFAULT false,
    `status` ENUM('active', 'inactive', 'archived') NOT NULL DEFAULT 'active',
    `auto_add_members` BOOLEAN NOT NULL DEFAULT false,
    `messaging_permissions` JSON NOT NULL,
    `settings` JSON NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `community_groups_uuid_unique`(`uuid`),
    INDEX `community_groups_community_owner_id_foreign`(`community_owner_id`),
    INDEX `community_groups_created_by_foreign`(`created_by`),
    INDEX `community_groups_owner_id_index`(`owner_id`),
    INDEX `community_groups_owner_id_status_index`(`owner_id`, `status`),
    INDEX `community_groups_status_index`(`status`),
    INDEX `community_groups_uuid_index`(`uuid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_likes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `likeable_id` BIGINT UNSIGNED NOT NULL,
    `likeable_type` VARCHAR(191) NOT NULL,
    `owner_id` BIGINT UNSIGNED NOT NULL,
    `owner_type` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_mentions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `mentionable_type` VARCHAR(191) NOT NULL,
    `mentionable_id` BIGINT UNSIGNED NOT NULL,
    `mentioned_type` VARCHAR(191) NOT NULL,
    `mentioned_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `community_mentions_mentionable_type_mentionable_id_index`(`mentionable_type`, `mentionable_id`),
    INDEX `community_mentions_mentioned_type_mentioned_id_index`(`mentioned_type`, `mentioned_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_notifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `notifiable_type` VARCHAR(191) NOT NULL,
    `notifiable_id` BIGINT UNSIGNED NOT NULL,
    `sender_type` VARCHAR(191) NOT NULL,
    `sender_id` BIGINT UNSIGNED NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `subject_type` VARCHAR(191) NOT NULL,
    `subject_id` BIGINT UNSIGNED NOT NULL,
    `data` TEXT NULL,
    `read_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `community_notifications_notifiable_type_notifiable_id_index`(`notifiable_type`, `notifiable_id`),
    INDEX `community_notifications_sender_type_sender_id_index`(`sender_type`, `sender_id`),
    INDEX `community_notifications_subject_type_subject_id_index`(`subject_type`, `subject_id`),
    INDEX `notifiable_read_idx`(`notifiable_type`, `notifiable_id`, `read_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_point_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `owner_id` BIGINT UNSIGNED NOT NULL,
    `course_id` BIGINT UNSIGNED NULL,
    `owner_type` VARCHAR(191) NOT NULL,
    `point` BIGINT NOT NULL DEFAULT 0,
    `type` VARCHAR(191) NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `log_date` DATE NULL,

    INDEX `community_point_logs_log_date_index`(`log_date`),
    INDEX `community_point_logs_owner_id_index`(`owner_id`),
    INDEX `owner_date_idx`(`owner_id`, `log_date`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_points_rules` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `action` VARCHAR(191) NOT NULL,
    `condition` VARCHAR(191) NOT NULL,
    `points` BIGINT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `community_points_rules_action_index`(`action`),
    INDEX `community_points_rules_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_post_reports` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `report_type` VARCHAR(191) NULL,
    `post_id` BIGINT UNSIGNED NOT NULL,
    `comment_id` BIGINT UNSIGNED NULL,
    `reporter_id` BIGINT UNSIGNED NOT NULL,
    `reason` TEXT NOT NULL,
    `status` ENUM('pending', 'reviewed') NOT NULL DEFAULT 'pending',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `community_post_reports_post_id_foreign`(`post_id`),
    INDEX `community_post_reports_reporter_id_foreign`(`reporter_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_posts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `community_owner_id` BIGINT UNSIGNED NULL,
    `owner_id` BIGINT UNSIGNED NOT NULL,
    `owner_type` VARCHAR(191) NOT NULL,
    `category_id` BIGINT UNSIGNED NULL,
    `post_type` VARCHAR(191) NOT NULL DEFAULT 'public_feed',
    `channel_ids` JSON NULL,
    `title` TEXT NOT NULL,
    `description` LONGTEXT NULL,
    `approval_status` ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    `is_pinned` BOOLEAN NOT NULL DEFAULT false,
    `hide_comment_count` BOOLEAN NOT NULL DEFAULT false,
    `turn_off_commenting` BOOLEAN NOT NULL DEFAULT false,
    `hide_like_count` BOOLEAN NOT NULL DEFAULT false,
    `pinned_order` BIGINT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `attachments` JSON NULL,

    INDEX `community_posts_category_id_foreign`(`category_id`),
    INDEX `idx_post_type`(`post_type`),
    INDEX `idx_post_type_owner`(`post_type`, `community_owner_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `community_profiles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `about` TEXT NULL,
    `image_id` BIGINT UNSIGNED NULL,
    `image` TEXT NULL,
    `logo_id` BIGINT UNSIGNED NULL,
    `logo` TEXT NULL,
    `login_banner_id` BIGINT UNSIGNED NULL,
    `login_banner` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `auto_community_access` BOOLEAN NOT NULL DEFAULT false,
    `favicon_id` BIGINT UNSIGNED NULL,
    `favicon_link` TEXT NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` TEXT NULL,
    `header_script` TEXT NULL,
    `body_script` TEXT NULL,
    `show_member_address` BOOLEAN NOT NULL DEFAULT false,
    `device_limit` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `community_version` JSON NULL,

    INDEX `community_profiles_auto_community_access_index`(`auto_community_access`),
    INDEX `community_profiles_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `compare_products` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact_additional_data` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `custom_field_id` BIGINT UNSIGNED NOT NULL,
    `form_id` BIGINT UNSIGNED NULL,
    `lead_gen_id` BIGINT UNSIGNED NULL,
    `value` JSON NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `contact_additional_data_contact_id_index`(`contact_id`),
    INDEX `contact_additional_data_custom_field_id_index`(`custom_field_id`),
    INDEX `contact_additional_data_form_id_index`(`form_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact_devices` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `device_id` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `contact_devices_contact_id_index`(`contact_id`),
    INDEX `contact_devices_user_id_index`(`user_id`),
    UNIQUE INDEX `contact_devices_user_id_device_id_unique`(`user_id`, `device_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact_documents` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `file_name` VARCHAR(191) NOT NULL,
    `file_path` VARCHAR(191) NOT NULL,
    `file_size` VARCHAR(191) NOT NULL,
    `file_type` VARCHAR(10) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `contact_documents_contact_id_foreign`(`contact_id`),
    INDEX `contact_documents_file_type_index`(`file_type`),
    INDEX `contact_documents_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact_otp` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `otp` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact_tag` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `note_id` BIGINT UNSIGNED NULL,
    `tag_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `contact_tag_contact_id_tag_id_index`(`contact_id`, `tag_id`),
    INDEX `contact_tag_note_id_index`(`note_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact_us` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `seller_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `subject` VARCHAR(191) NULL,
    `message` VARCHAR(191) NOT NULL,
    `reply` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contacts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `customer_id` BIGINT UNSIGNED NULL,
    `first_name` VARCHAR(191) NOT NULL,
    `last_name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NULL,
    `pin` SMALLINT UNSIGNED NULL,
    `google_id` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NOT NULL,
    `date_of_birth` DATE NULL,
    `profile_image` VARCHAR(191) NULL,
    `contact_type` VARCHAR(255) NOT NULL,
    `timezone` VARCHAR(191) NULL,
    `email_dnd` BOOLEAN NOT NULL DEFAULT false,
    `sms_dnd` BOOLEAN NOT NULL DEFAULT false,
    `call_dnd` BOOLEAN NOT NULL DEFAULT false,
    `business_name` VARCHAR(191) NULL,
    `gst_no` VARCHAR(191) NULL,
    `street_address` TEXT NULL,
    `city` VARCHAR(191) NULL,
    `country` VARCHAR(191) NULL,
    `state` VARCHAR(191) NULL,
    `postal_code` VARCHAR(191) NULL,
    `website` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `uid` VARCHAR(191) NULL,
    `form_builder_id` VARCHAR(191) NULL,
    `is_searchy_lead` BOOLEAN NOT NULL DEFAULT false,
    `access_token` TEXT NULL,
    `notification_device_ids` MEDIUMTEXT NULL,
    `parent_id` BIGINT UNSIGNED NULL,
    `source` VARCHAR(191) NULL,
    `batch_id` BIGINT UNSIGNED NULL,
    `whatsapp_dnd` BOOLEAN NULL DEFAULT false,
    `is_intervened` BOOLEAN NOT NULL DEFAULT true,
    `form_type` VARCHAR(191) NULL,
    `form_id` VARCHAR(191) NULL,
    `bio` TEXT NULL,
    `name_changed` BOOLEAN NOT NULL DEFAULT false,
    `total_points` BIGINT NOT NULL DEFAULT 0,
    `has_community_access` BOOLEAN NOT NULL DEFAULT false,
    `page_visit_id` VARCHAR(191) NULL,
    `last_message_at` TIMESTAMP(0) NULL,
    `instagram_user_id` VARCHAR(191) NULL,
    `instagram` VARCHAR(191) NULL,
    `ai_response_enabled` BOOLEAN NOT NULL DEFAULT true,

    INDEX `contacts_batch_id_index`(`batch_id`),
    INDEX `contacts_contact_type_index`(`contact_type`),
    INDEX `contacts_customer_id_index`(`customer_id`),
    INDEX `contacts_deleted_at_index`(`deleted_at`),
    INDEX `contacts_email_index`(`email`),
    INDEX `contacts_google_id_index`(`google_id`),
    INDEX `contacts_has_community_access_index`(`has_community_access`),
    INDEX `contacts_instagram_index`(`instagram`),
    INDEX `contacts_instagram_user_id_index`(`instagram_user_id`),
    INDEX `contacts_last_message_at_index`(`last_message_at`),
    INDEX `contacts_parent_id_foreign`(`parent_id`),
    INDEX `contacts_phone_index`(`phone`),
    INDEX `contacts_pin_index`(`pin`),
    INDEX `contacts_user_id_contact_type_created_at_index`(`user_id`, `contact_type`, `created_at`),
    INDEX `contacts_user_id_deleted_at_index`(`user_id`, `deleted_at`),
    INDEX `idx_contacts_email`(`email`),
    INDEX `idx_contacts_first_name`(`first_name`),
    INDEX `idx_contacts_last_name`(`last_name`),
    INDEX `idx_contacts_phone`(`phone`),
    INDEX `idx_email`(`email`),
    INDEX `idx_email_phone`(`email`, `phone`),
    INDEX `idx_phone`(`phone`),
    INDEX `idx_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `countries` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `iso3` CHAR(3) NULL,
    `iso2` CHAR(2) NULL,
    `phonecode` VARCHAR(191) NULL,
    `currency` VARCHAR(191) NULL,
    `currency_symbol` VARCHAR(191) NULL,
    `latitude` DECIMAL(10, 8) NULL,
    `longitude` DECIMAL(11, 8) NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `coupon_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `coupon_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `title` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `coupons` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `type` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `banner_id` BIGINT UNSIGNED NULL,
    `banner` TEXT NULL,
    `minimum_shopping` DOUBLE NULL,
    `maximum_discount` DOUBLE NULL,
    `product_id` TEXT NULL,
    `discount_type` VARCHAR(191) NULL,
    `discount` DOUBLE NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `start_date` TIMESTAMP(0) NULL,
    `end_date` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `credit_usages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `agency_id` BIGINT NOT NULL,
    `agency_plan_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `credits_used` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `related_user_id` BIGINT NOT NULL,
    `usage_date` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `credit_usages_agency_plan_id_index`(`agency_plan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `crm_quick_filters` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `filters` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `crm_quick_filters_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cronjobs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(64) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `currencies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `symbol` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `exchange_rate` DOUBLE NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `custom_fields` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `custom_folder_id` BIGINT UNSIGNED NULL,
    `field_type` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `key` VARCHAR(191) NOT NULL,
    `object` VARCHAR(191) NULL,
    `placeholder` VARCHAR(191) NULL,
    `default_value` VARCHAR(191) NULL,
    `description` TEXT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `locked` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `questions` JSON NULL,
    `field_attributes` JSON NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `is_base_column` BOOLEAN NOT NULL DEFAULT false,

    INDEX `custom_fields_key_index`(`key`),
    INDEX `custom_fields_user_id_index`(`user_id`),
    INDEX `custom_fields_user_id_key_index`(`user_id`, `key`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `custom_folders` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `object` VARCHAR(191) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `custom_menu_users` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `custom_menu_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `custom_menu_users_custom_menu_id_index`(`custom_menu_id`),
    INDEX `custom_menu_users_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `custom_menus` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `agency_id` BIGINT UNSIGNED NULL,
    `link_icon` VARCHAR(191) NULL,
    `link_title` VARCHAR(191) NOT NULL,
    `url` VARCHAR(191) NOT NULL,
    `when_clicked` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `for_agency_sidebar` BOOLEAN NOT NULL DEFAULT false,
    `for_subaccount_sidebar` BOOLEAN NOT NULL DEFAULT false,
    `visible_for_all` BOOLEAN NOT NULL DEFAULT false,
    `add_to_header_submenu` BOOLEAN NOT NULL DEFAULT false,
    `header_submenu` VARCHAR(191) NULL,
    `order` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `permissions` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `custom_menus_agency_id_index`(`agency_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `custom_values` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `custom_folder_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NOT NULL,
    `key` VARCHAR(191) NOT NULL,
    `value` VARCHAR(191) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `custom_values_key_user_id_deleted_at_index`(`key`, `user_id`, `deleted_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `delivery_hero_accounts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `delivery_hero_id` BIGINT UNSIGNED NULL,
    `source` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `delivery_heroes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `pickup_hub_id` BIGINT UNSIGNED NULL,
    `driving_licence` VARCHAR(191) NULL,
    `driving_licence_image` TEXT NULL,
    `salary` DOUBLE NULL,
    `commission` DOUBLE NULL,
    `total_commission` DOUBLE NULL,
    `total_collection` DOUBLE NULL,
    `total_paid` DOUBLE NULL,
    `country_id` BIGINT NULL,
    `state_id` BIGINT NULL,
    `city_id` INTEGER NULL,
    `address` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `delivery_histories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `delivery_hero_id` BIGINT UNSIGNED NULL,
    `event` VARCHAR(191) NOT NULL,
    `remarks` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `devices` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` CHAR(36) NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NULL,
    `user_name` VARCHAR(191) NULL,
    `qr` TEXT NULL,
    `meta` TEXT NULL,
    `status` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_default` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `devices_uuid_unique`(`uuid`),
    INDEX `devices_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `documents` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NULL,
    `type` VARCHAR(191) NULL,
    `path` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `documents_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `domains` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `domain` VARCHAR(191) NOT NULL,
    `certificate_number` VARCHAR(191) NULL,
    `record_name` VARCHAR(191) NULL,
    `record_value` VARCHAR(191) NULL,
    `ssl_number` VARCHAR(191) NULL,
    `ssl_dns_verified_at` TIMESTAMP(0) NULL,
    `ssl_issue_date` DATE NULL,
    `ssl_expiry_date` DATE NULL,
    `ssl_certificate` LONGTEXT NULL,
    `ssl_private` LONGTEXT NULL,
    `chain_of_certificate` LONGTEXT NULL,
    `ssl_chain` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `certificate_deployed` BOOLEAN NOT NULL DEFAULT false,
    `last_error` TEXT NULL,
    `verification_response` TEXT NULL,
    `ready_for_renew` BOOLEAN NOT NULL DEFAULT false,
    `www_access` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `domains_domain_deleted_at_unique`(`domain`, `deleted_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `email_links` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `email_id` INTEGER UNSIGNED NOT NULL,
    `link` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `email_server_configs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `agency_id` BIGINT UNSIGNED NULL,
    `provider` VARCHAR(191) NOT NULL,
    `settings` JSON NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `email_server_configs_agency_id_foreign`(`agency_id`),
    INDEX `email_server_configs_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `email_templates` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `details` VARCHAR(200) NULL,
    `slug` VARCHAR(50) NULL,
    `language` VARCHAR(10) NULL DEFAULT 'en',
    `html` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `email_verification_servers` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `admin_id` INTEGER UNSIGNED NULL,
    `customer_id` INTEGER UNSIGNED NULL,
    `name` TEXT NOT NULL,
    `type` TEXT NOT NULL,
    `options` TEXT NULL,
    `status` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `email_verifications` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `result` VARCHAR(20) NOT NULL,
    `details` TEXT NOT NULL,
    `subscriber_id` INTEGER UNSIGNED NOT NULL,
    `email_verification_server_id` INTEGER UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `email_verifications_result_index`(`result`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `email_webhooks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `endpoint` TEXT NOT NULL,
    `email_id` INTEGER UNSIGNED NOT NULL,
    `email_link_id` INTEGER UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `emails` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `automation2_id` BIGINT UNSIGNED NULL,
    `campaign_id` BIGINT UNSIGNED NULL,
    `subject` VARCHAR(191) NULL,
    `from_email` VARCHAR(191) NULL,
    `from_name` VARCHAR(191) NULL,
    `reply_to` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sign_dkim` BOOLEAN NOT NULL DEFAULT true,
    `track_open` BOOLEAN NOT NULL DEFAULT true,
    `track_click` BOOLEAN NOT NULL DEFAULT true,
    `action_id` VARCHAR(191) NULL,
    `plain` LONGTEXT NULL,
    `tracking_domain_id` BIGINT UNSIGNED NULL,
    `template_id` INTEGER UNSIGNED NULL,
    `customer_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `skip_failed_message` BOOLEAN NOT NULL DEFAULT false,
    `preheader` TEXT NULL,

    INDEX `emails_uid_index`(`uid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_additional_fields` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `event_id` BIGINT UNSIGNED NOT NULL,
    `form_builder_id` BIGINT UNSIGNED NOT NULL,
    `form_builder_field_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `value` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `event_additional_fields_event_id_index`(`event_id`),
    INDEX `event_additional_fields_form_builder_field_id_index`(`form_builder_field_id`),
    INDEX `event_additional_fields_form_builder_id_index`(`form_builder_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_custom_fields` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `event_id` BIGINT UNSIGNED NOT NULL,
    `custom_field_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NULL,
    `type` VARCHAR(191) NOT NULL DEFAULT 'text',
    `is_required` BOOLEAN NOT NULL DEFAULT false,
    `value` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `event_custom_fields_custom_field_id_index`(`custom_field_id`),
    INDEX `event_custom_fields_event_id_index`(`event_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_locations` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NULL,
    `public_name` VARCHAR(100) NULL,
    `short_description` VARCHAR(250) NULL,
    `image` VARCHAR(250) NULL,
    `admin_side` VARCHAR(250) NULL,
    `public_side` VARCHAR(250) NULL,
    `admin_field` VARCHAR(50) NULL,
    `public_field` VARCHAR(50) NULL,
    `details` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_type_custom_fields` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `event_type_id` BIGINT UNSIGNED NOT NULL,
    `custom_field_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NULL,
    `is_required` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `event_type_custom_fields_custom_field_id_index`(`custom_field_id`),
    INDEX `event_type_custom_fields_event_type_id_index`(`event_type_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_type_locations` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `staff_id` BIGINT UNSIGNED NULL,
    `event_type_id` INTEGER NULL,
    `event_location_id` INTEGER NULL,
    `value` VARCHAR(191) NULL,
    `short_description` VARCHAR(191) NULL,
    `details` TEXT NULL,
    `generate_link` BOOLEAN NOT NULL DEFAULT false,

    INDEX `event_type_locations_event_location_id_index`(`event_location_id`),
    INDEX `event_type_locations_event_type_id_index`(`event_type_id`),
    INDEX `event_type_locations_staff_id_foreign`(`staff_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_type_staff_details` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `event_type_id` INTEGER UNSIGNED NOT NULL,
    `staff_id` BIGINT UNSIGNED NOT NULL,
    `timezone` VARCHAR(191) NULL,
    `hours` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `event_type_staff_details_event_type_id_index`(`event_type_id`),
    INDEX `event_type_staff_details_staff_id_index`(`staff_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_types` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `calendar_scope` BOOLEAN NOT NULL DEFAULT false,
    `priority_based` BOOLEAN NOT NULL DEFAULT false,
    `user_id` INTEGER NULL,
    `staff_ids` JSON NULL,
    `name` VARCHAR(250) NULL,
    `details` TEXT NULL,
    `email_required` BOOLEAN NOT NULL DEFAULT true,
    `phone_required` BOOLEAN NOT NULL DEFAULT true,
    `booking_per_slot` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `link` VARCHAR(150) NOT NULL,
    `form_builder_id` BIGINT UNSIGNED NULL,
    `redirect_url` VARCHAR(191) NULL,
    `color` VARCHAR(20) NULL,
    `timezone` VARCHAR(250) NULL,
    `date_range` TEXT NULL,
    `minimum_scheduling_notice` VARCHAR(191) NULL,
    `duration` VARCHAR(7) NULL DEFAULT '30_min',
    `before` VARCHAR(7) NULL DEFAULT '0_min',
    `after` VARCHAR(7) NULL DEFAULT '0_min',
    `schedule_id` INTEGER NULL,
    `hours` TEXT NULL,
    `is_active` INTEGER NOT NULL DEFAULT 1,
    `max_per_day` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `event_types_form_builder_id_index`(`form_builder_id`),
    INDEX `event_types_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `events` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `contact_id` BIGINT UNSIGNED NULL,
    `uid` VARCHAR(191) NULL,
    `user_id` INTEGER NULL,
    `canceled_by` INTEGER NULL,
    `event_type_id` INTEGER NULL,
    `staff_id` BIGINT UNSIGNED NULL,
    `is_active` INTEGER NULL DEFAULT 1,
    `event_location_id` INTEGER NULL,
    `event_location_value` VARCHAR(191) NULL,
    `name` VARCHAR(250) NULL,
    `duration` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `guest_emails` TEXT NULL,
    `question` TEXT NULL,
    `start` VARCHAR(25) NOT NULL,
    `end` VARCHAR(25) NOT NULL,
    `color` VARCHAR(20) NULL,
    `timezone` VARCHAR(250) NULL,
    `date` DATE NULL,
    `google_event_id` VARCHAR(191) NULL,
    `cancellation_reason` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `no_show` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    `is_rescheduled` BOOLEAN NOT NULL DEFAULT false,

    INDEX `events_contact_id_index`(`contact_id`),
    INDEX `events_date_index`(`date`),
    INDEX `events_event_location_id_index`(`event_location_id`),
    INDEX `events_event_type_id_index`(`event_type_id`),
    INDEX `events_google_event_id_index`(`google_event_id`),
    INDEX `events_is_active_index`(`is_active`),
    INDEX `events_staff_id_foreign`(`staff_id`),
    INDEX `events_uid_index`(`uid`),
    INDEX `events_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `facebook_form_mappings` (
    `form_id` VARCHAR(191) NOT NULL,
    `facebook_form_id` VARCHAR(191) NOT NULL,
    `facebook_field_id` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `key` VARCHAR(191) NOT NULL,
    `label` VARCHAR(191) NOT NULL,
    `custom_field_id` VARCHAR(191) NOT NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `facebook_page_forms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `facebook_page_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `facebook_form_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `status` VARCHAR(191) NULL,
    `questions` JSON NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `field_mapped` BOOLEAN NOT NULL DEFAULT false,
    `activated` BOOLEAN NOT NULL DEFAULT false,

    INDEX `facebook_page_forms_facebook_page_id_index`(`facebook_page_id`),
    INDEX `facebook_page_forms_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `facebook_user_accounts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `node_id` VARCHAR(255) NOT NULL,
    `node_type` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `access_token` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `default` BOOLEAN NOT NULL DEFAULT false,
    `webhook_subscribed` BOOLEAN NOT NULL DEFAULT false,

    INDEX `facebook_user_accounts_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `facebook_user_tokens` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `access_token` TEXT NULL,
    `code` TEXT NULL,
    `expired_at` TIMESTAMP(0) NULL,
    `facebook_user_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `facebook_user_tokens_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `failed_jobs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `connection` TEXT NOT NULL,
    `queue` TEXT NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `exception` LONGTEXT NOT NULL,
    `failed_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `uuid` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `favorite_chats` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `chat_code` VARCHAR(191) NOT NULL,
    `favorite` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `favorite_chats_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `field_options` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `field_id` INTEGER UNSIGNED NOT NULL,
    `label` VARCHAR(191) NOT NULL,
    `value` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `field_options_field_id_foreign`(`field_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fields` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `mail_list_id` INTEGER UNSIGNED NOT NULL,
    `label` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `tag` VARCHAR(191) NOT NULL,
    `default_value` VARCHAR(191) NULL,
    `visible` BOOLEAN NOT NULL DEFAULT true,
    `required` BOOLEAN NOT NULL DEFAULT false,
    `custom_order` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_email` BOOLEAN NOT NULL DEFAULT false,

    INDEX `fields_mail_list_id_foreign`(`mail_list_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `five_minute_journals` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `date` DATE NULL,
    `day` DATE NULL,
    `grateful` TEXT NULL,
    `habit` TEXT NULL,
    `dream` TEXT NULL,
    `tasks` TEXT NULL,
    `affirmations` TEXT NULL,
    `feeling` TEXT NULL,
    `dont_waste` TEXT NULL,
    `fav_things` TEXT NULL,
    `must_accomplish` TEXT NULL,
    `notes` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User',

    INDEX `five_minute_journals_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `flag_icons` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `image` VARCHAR(50) NOT NULL,
    `title` VARCHAR(10) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `folderables` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `folder_id` BIGINT UNSIGNED NOT NULL,
    `folderable_type` VARCHAR(191) NOT NULL,
    `folderable_id` BIGINT UNSIGNED NOT NULL,

    INDEX `folderables_folder_id_foreign`(`folder_id`),
    INDEX `folderables_folderable_type_folderable_id_index`(`folderable_type`, `folderable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `folders` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `parent_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NULL,
    `archived_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `folders_archived_at_index`(`archived_at`),
    INDEX `folders_parent_id_foreign`(`parent_id`),
    INDEX `folders_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `form_builder_fields` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `form_builder_id` BIGINT UNSIGNED NOT NULL,
    `field_name` VARCHAR(191) NOT NULL,
    `field_preview_title` VARCHAR(191) NULL,
    `field_placeholder` VARCHAR(191) NULL,
    `field_type` INTEGER NOT NULL DEFAULT 0,
    `is_required` BOOLEAN NOT NULL DEFAULT false,
    `position` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `custom_field_id` BIGINT UNSIGNED NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `form_builders` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `pipeline_id` BIGINT UNSIGNED NULL,
    `stage_id` BIGINT UNSIGNED NULL,
    `tags` TEXT NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `position` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `enable_declaration` BOOLEAN NOT NULL DEFAULT false,
    `policy_name` VARCHAR(191) NULL,
    `policy_url` VARCHAR(191) NULL,
    `apply_affiliate_attribution` BOOLEAN NOT NULL DEFAULT false,
    `affiliate_attribution_days` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `button_title` VARCHAR(191) NOT NULL DEFAULT 'Enquire Now',
    `button_color` TEXT NULL,
    `button_text_color` VARCHAR(191) NULL,
    `redirect_link` TEXT NULL,
    `pixel_id` VARCHAR(191) NULL,
    `form_background_color` VARCHAR(191) NOT NULL DEFAULT '#ffffff',
    `form_text_color` VARCHAR(191) NOT NULL DEFAULT '#000000',
    `is_transparent_form` BOOLEAN NOT NULL DEFAULT false,

    INDEX `form_builders_pipeline_id_index`(`pipeline_id`),
    INDEX `form_builders_stage_id_index`(`stage_id`),
    INDEX `idx_uid`(`uid`),
    INDEX `idx_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `form_responses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `answerable_type` VARCHAR(191) NOT NULL,
    `answerable_id` BIGINT UNSIGNED NOT NULL,
    `response` LONGTEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `form_responses_answerable_type_answerable_id_index`(`answerable_type`, `answerable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `forms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `customer_id` INTEGER UNSIGNED NOT NULL,
    `mail_list_id` INTEGER UNSIGNED NULL,
    `template_id` INTEGER UNSIGNED NULL,
    `metadata` LONGTEXT NULL,
    `status` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `free_credits` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `credits_count` BIGINT NOT NULL,
    `free_credit` BIGINT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `funnel_categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `slug` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `funnel_folders` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `position` BIGINT NOT NULL DEFAULT 0,

    INDEX `funnel_folders_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `funnel_prebuilds` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `description` TEXT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `funnel_id` BIGINT UNSIGNED NULL,
    `pipeline_id` BIGINT UNSIGNED NULL,
    `email_template_id` INTEGER UNSIGNED NULL,
    `whatsapp_template_id` BIGINT UNSIGNED NULL,
    `automation_id` INTEGER UNSIGNED NULL,
    `agency_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `funnel_category_id` BIGINT UNSIGNED NOT NULL,
    `template_type` VARCHAR(191) NULL,
    `visibility` ENUM('global', 'agency') NOT NULL DEFAULT 'global',
    `image` VARCHAR(191) NULL,
    `image_path` JSON NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `funnel_prebuilds_automation_id_index`(`automation_id`),
    INDEX `funnel_prebuilds_email_template_id_index`(`email_template_id`),
    INDEX `funnel_prebuilds_funnel_category_id_foreign`(`funnel_category_id`),
    INDEX `funnel_prebuilds_funnel_id_foreign`(`funnel_id`),
    INDEX `funnel_prebuilds_pipeline_id_index`(`pipeline_id`),
    INDEX `funnel_prebuilds_user_id_foreign`(`user_id`),
    INDEX `funnel_prebuilds_whatsapp_template_id_index`(`whatsapp_template_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `funnel_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `funnel_id` BIGINT UNSIGNED NOT NULL,
    `domain_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NOT NULL,
    `favicon_id` VARCHAR(191) NULL,
    `favicon` TEXT NULL,
    `header_tracking_code` LONGTEXT NULL,
    `body_tracking_code` LONGTEXT NULL,
    `footer_tracking_code` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `path` VARCHAR(255) NULL,

    INDEX `funnel_settings_domain_id_foreign`(`domain_id`),
    INDEX `funnel_settings_funnel_id_foreign`(`funnel_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `funnel_tracking_events` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `funnel_id` BIGINT UNSIGNED NOT NULL,
    `pixel_id` VARCHAR(191) NOT NULL,
    `access_token` MEDIUMTEXT NOT NULL,
    `level` ENUM('funnel', 'pages') NOT NULL DEFAULT 'funnel',
    `page_ids` JSON NULL,
    `send_via_capi` BOOLEAN NOT NULL DEFAULT true,
    `capture_on_pageview` BOOLEAN NOT NULL DEFAULT true,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `funnel_tracking_events_user_id_funnel_id_index`(`user_id`, `funnel_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `get_started` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `download_app` BOOLEAN NOT NULL DEFAULT false,
    `gst_and_business_info` BOOLEAN NOT NULL DEFAULT false,
    `connect_facebook` BOOLEAN NOT NULL DEFAULT false,
    `whatsapp_sender_and_cloud_api` BOOLEAN NOT NULL DEFAULT false,
    `setup_pipeline` BOOLEAN NOT NULL DEFAULT false,
    `connect_payment_gateway` BOOLEAN NOT NULL DEFAULT false,
    `add_staff` BOOLEAN NOT NULL DEFAULT false,
    `domain_setup` BOOLEAN NOT NULL DEFAULT false,
    `lms_setup` BOOLEAN NOT NULL DEFAULT false,
    `completion_percentage` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `get_started_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `goals` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NULL,
    `date` DATE NULL,
    `description` TEXT NULL,
    `completed` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User',

    INDEX `goals_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `groupcontacts` (
    `group_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,

    INDEX `groupcontacts_contact_id_foreign`(`contact_id`),
    INDEX `groupcontacts_group_id_foreign`(`group_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `uid` VARCHAR(191) NULL,

    INDEX `groups_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_anxiety_times` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `times` DOUBLE NOT NULL DEFAULT 0.00,
    `date` DATE NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `health_anxiety_times_contact_id_index`(`contact_id`),
    INDEX `health_anxiety_times_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_before_after_photos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `date` DATE NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `photo_front` VARCHAR(191) NULL,
    `photo_side` VARCHAR(191) NULL,
    `photo_back` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_heights` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `height` DOUBLE NOT NULL DEFAULT 0.00,
    `date` DATE NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `health_heights_contact_id_index`(`contact_id`),
    INDEX `health_heights_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_plans` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NULL,
    `file_name` VARCHAR(191) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `health_plans_contact_id_index`(`contact_id`),
    INDEX `health_plans_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_pressures` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `pressure` DOUBLE NOT NULL DEFAULT 0.00,
    `date` DATE NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `systolic` DOUBLE NOT NULL DEFAULT 0.00,
    `diastolic` DOUBLE NOT NULL DEFAULT 0.00,

    INDEX `health_pressures_contact_id_index`(`contact_id`),
    INDEX `health_pressures_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_profiles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `gender` VARCHAR(191) NULL,
    `height_unit` VARCHAR(191) NULL,
    `weight_unit` VARCHAR(191) NULL,
    `dob` DATE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `health_profiles_contact_id_index`(`contact_id`),
    INDEX `health_profiles_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_questionnaire_answers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `date` DATE NULL,
    `health_questionnaire_id` BIGINT UNSIGNED NULL,
    `custom_field_id` BIGINT UNSIGNED NULL,
    `field_name` VARCHAR(191) NULL,
    `is_required` BOOLEAN NOT NULL,
    `type` VARCHAR(191) NULL,
    `response` MEDIUMTEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `health_questionnaire_answers_contact_id_index`(`contact_id`),
    INDEX `health_questionnaire_answers_custom_field_id_index`(`custom_field_id`),
    INDEX `health_questionnaire_answers_health_questionnaire_id_index`(`health_questionnaire_id`),
    INDEX `health_questionnaire_answers_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_questionnaires` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `custom_field_id` BIGINT UNSIGNED NOT NULL,
    `field_name` VARCHAR(191) NULL,
    `is_required` BOOLEAN NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `health_questionnaires_custom_field_id_index`(`custom_field_id`),
    INDEX `health_questionnaires_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_sleep_hours` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `hours` DOUBLE NOT NULL DEFAULT 0.00,
    `date` DATE NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `health_sleep_hours_contact_id_index`(`contact_id`),
    INDEX `health_sleep_hours_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_sugar_levels` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `sugar_level` DOUBLE NOT NULL DEFAULT 0.00,
    `date` DATE NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `health_sugar_levels_contact_id_index`(`contact_id`),
    INDEX `health_sugar_levels_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `health_weights` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `weight` DOUBLE NOT NULL DEFAULT 0,
    `date` DATE NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `import_progresses` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `type` VARCHAR(191) NULL,
    `current` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `total` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ingestion_events` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `item_id` CHAR(36) NOT NULL,
    `stage` ENUM('created', 'fetched', 'extracted', 'summarized', 'chunked', 'embedded', 'indexed', 'deleted') NOT NULL,
    `info` JSON NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `ingestion_events_item_id_foreign`(`item_id`),
    INDEX `ingestion_events_user_id_item_id_created_at_index`(`user_id`, `item_id`, `created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `instagram_webhook_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `event_type` VARCHAR(191) NULL,
    `object_id` VARCHAR(191) NULL,
    `sender_id` VARCHAR(191) NULL,
    `sender_username` VARCHAR(191) NULL,
    `content` TEXT NULL,
    `payload` JSON NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'received',
    `error_message` TEXT NULL,
    `processed_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `instagram_webhook_logs_status_index`(`status`),
    INDEX `instagram_webhook_logs_user_id_event_type_index`(`user_id`, `event_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `integrations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `service` VARCHAR(191) NOT NULL,
    `data` JSON NOT NULL,
    `webhook_channel_id` VARCHAR(191) NULL,
    `webhook_resource_id` VARCHAR(191) NULL,
    `webhook_expiration` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `integrations_user_id_service_unique`(`user_id`, `service`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ip_locations` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `ip_address` VARCHAR(191) NOT NULL,
    `country_code` VARCHAR(191) NULL,
    `country_name` VARCHAR(191) NULL,
    `region_code` VARCHAR(191) NULL,
    `region_name` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `zipcode` VARCHAR(191) NULL,
    `latitude` VARCHAR(191) NULL,
    `longitude` VARCHAR(191) NULL,
    `metro_code` VARCHAR(191) NULL,
    `areacode` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `ip_locations_ip_address_index`(`ip_address`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ivr_form` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `field_name` VARCHAR(191) NOT NULL,
    `field_type` INTEGER NOT NULL DEFAULT 0,
    `is_required` BOOLEAN NOT NULL DEFAULT false,
    `position` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `custom_field_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `ivr_form_custom_field_id_foreign`(`custom_field_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_batches` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `total_jobs` INTEGER NOT NULL,
    `pending_jobs` INTEGER NOT NULL,
    `failed_jobs` INTEGER NOT NULL,
    `failed_job_ids` TEXT NOT NULL,
    `options` MEDIUMTEXT NULL,
    `cancelled_at` INTEGER NULL,
    `created_at` INTEGER NOT NULL,
    `finished_at` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_monitors` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `subject_name` VARCHAR(191) NOT NULL,
    `subject_id` BIGINT NOT NULL,
    `batch_id` VARCHAR(191) NULL,
    `job_id` BIGINT NULL,
    `job_type` VARCHAR(191) NULL,
    `error` MEDIUMTEXT NULL,
    `data` MEDIUMTEXT NULL,
    `status` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jobs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `queue` VARCHAR(191) NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `attempts` INTEGER UNSIGNED NOT NULL,
    `reserved_at` INTEGER UNSIGNED NULL,
    `available_at` INTEGER UNSIGNED NOT NULL,
    `created_at` INTEGER UNSIGNED NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jwt_tokens` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `model_type` VARCHAR(191) NOT NULL,
    `jti` VARCHAR(191) NOT NULL,
    `ip_address` VARCHAR(191) NULL,
    `user_agent` TEXT NULL,
    `browser` VARCHAR(191) NULL,
    `platform` VARCHAR(191) NULL,
    `last_used_at` TIMESTAMP(0) NULL,
    `expires_at` TIMESTAMP(0) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `jwt_tokens_jti_unique`(`jti`),
    INDEX `jwt_tokens_expires_at_index`(`expires_at`),
    INDEX `jwt_tokens_jti_index`(`jti`),
    INDEX `jwt_tokens_model_id_model_type_index`(`model_id`, `model_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `knowledge_item_vectors` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `item_id` VARCHAR(191) NOT NULL,
    `vector_id` VARCHAR(191) NOT NULL,
    `chunk_index` INTEGER NULL,
    `synced_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `knowledge_item_vectors_vector_id_unique`(`vector_id`),
    INDEX `knowledge_item_vectors_user_id_index`(`user_id`),
    INDEX `knowledge_item_vectors_user_id_item_id_index`(`user_id`, `item_id`),
    INDEX `knowledge_item_vectors_vector_id_index`(`vector_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `knowledge_items` (
    `id` CHAR(36) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `visibility` ENUM('public', 'private') NOT NULL DEFAULT 'private',
    `title` VARCHAR(255) NULL,
    `description` TEXT NULL,
    `raw_text` LONGTEXT NULL,
    `source_url` VARCHAR(1024) NULL,
    `agent_content_id` VARCHAR(191) NULL,
    `is_indexed` TINYINT NOT NULL DEFAULT 0,
    `embedding_version` INTEGER NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `knowledge_items_agent_content_id_index`(`agent_content_id`),
    INDEX `knowledge_items_created_at_index`(`created_at`),
    INDEX `knowledge_items_user_id_index`(`user_id`),
    INDEX `knowledge_items_user_id_type_visibility_created_at_index`(`user_id`, `type`, `visibility`, `created_at`),
    FULLTEXT INDEX `title`(`title`, `description`, `raw_text`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `landing_page_contents` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `landing_page_id` BIGINT UNSIGNED NULL,
    `funnel_id` BIGINT UNSIGNED NULL,
    `content_type` VARCHAR(191) NOT NULL,
    `content_url` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `landing_page_contents_funnel_id_index`(`funnel_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `landing_page_funnels` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `title` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL DEFAULT 'manual',
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `prebuild` BOOLEAN NOT NULL DEFAULT false,
    `agency_id` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `folder_id` BIGINT UNSIGNED NULL,
    `position` BIGINT NOT NULL DEFAULT 0,

    INDEX `landing_page_funnels_folder_id_foreign`(`folder_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `landing_page_versions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `landing_page_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `data` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `landing_page_versions_landing_page_id_created_at_index`(`landing_page_id`, `created_at`),
    INDEX `landing_page_versions_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `landing_pages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `funnel_id` BIGINT UNSIGNED NULL,
    `title` VARCHAR(191) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `editor_path` VARCHAR(255) NULL,
    `page_uuid` VARCHAR(255) NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `user_type` TINYINT NOT NULL DEFAULT 0,
    `data` LONGTEXT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT false,
    `default_page` BOOLEAN NOT NULL DEFAULT false,
    `domain_id` BIGINT UNSIGNED NULL,
    `prebuild` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `rendered_data` LONGTEXT NULL,
    `position` BIGINT NULL DEFAULT 0,

    INDEX `landing_pages_default_page_index`(`default_page`),
    INDEX `landing_pages_funnel_id_foreign`(`funnel_id`),
    INDEX `landing_pages_funnel_id_page_uuid_index`(`funnel_id`, `page_uuid`),
    INDEX `landing_pages_slug_index`(`slug`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `language_configs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `language_id` INTEGER UNSIGNED NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `script` VARCHAR(30) NULL,
    `native` VARCHAR(30) NULL,
    `regional` VARCHAR(30) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `languages` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `locale` VARCHAR(30) NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `flag` VARCHAR(50) NULL,
    `text_direction` VARCHAR(30) NULL DEFAULT 'ltr',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `languages_locale_unique`(`locale`),
    INDEX `languages_name_index`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `layouts` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `alias` VARCHAR(191) NOT NULL,
    `group_name` VARCHAR(191) NOT NULL,
    `content` LONGTEXT NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `subject` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `link_pixel` (
    `link_id` INTEGER NOT NULL,
    `pixel_id` INTEGER NOT NULL,

    INDEX `link_id`(`link_id`),
    INDEX `pixel_id`(`pixel_id`),
    UNIQUE INDEX `link_pixel_link_id_pixel_id_unique`(`link_id`, `pixel_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `links` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `alias` VARCHAR(255) NOT NULL,
    `url` VARCHAR(2048) NOT NULL,
    `title` VARCHAR(255) NULL,
    `country_target` TEXT NULL,
    `platform_target` TEXT NULL,
    `password` VARCHAR(191) NULL,
    `disabled` TINYINT NOT NULL DEFAULT 0,
    `privacy` TINYINT NOT NULL DEFAULT 0,
    `expiration_url` VARCHAR(2048) NULL,
    `clicks` INTEGER NULL DEFAULT 0,
    `space_id` INTEGER NULL,
    `domain_id` INTEGER NULL,
    `ends_at` TIMESTAMP(0) NULL,
    `expiration_clicks` INTEGER NULL DEFAULT 0,
    `target_type` TINYINT NULL DEFAULT 0,
    `rotation_target` TEXT NULL,
    `last_rotation` TINYINT NULL DEFAULT 0,
    `privacy_password` TEXT NULL,
    `description` TEXT NULL,
    `image` TEXT NULL,
    `language_target` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `alias`(`alias`),
    INDEX `clicks`(`clicks`),
    INDEX `domain_id`(`domain_id`),
    INDEX `space_id`(`space_id`),
    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `llm_models` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `llm_provider_id` BIGINT UNSIGNED NOT NULL,
    `model_id` VARCHAR(191) NOT NULL,
    `display_name` VARCHAR(191) NOT NULL,
    `model_type` VARCHAR(191) NOT NULL,
    `capabilities` JSON NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `is_default` BOOLEAN NOT NULL DEFAULT false,
    `last_used_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `llm_models_llm_provider_id_is_active_index`(`llm_provider_id`, `is_active`),
    INDEX `llm_models_llm_provider_id_model_type_index`(`llm_provider_id`, `model_type`),
    UNIQUE INDEX `llm_models_llm_provider_id_model_id_unique`(`llm_provider_id`, `model_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `llm_providers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `provider_name` VARCHAR(191) NOT NULL,
    `encrypted_api_key` TEXT NOT NULL,
    `api_key_last4` VARCHAR(191) NOT NULL,
    `is_default` BOOLEAN NOT NULL DEFAULT false,
    `is_active` BOOLEAN NOT NULL DEFAULT true,
    `capabilities` JSON NULL,
    `last_used_at` TIMESTAMP(0) NULL,
    `last_synced_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `llm_providers_user_id_is_active_index`(`user_id`, `is_active`),
    INDEX `llm_providers_user_id_is_default_index`(`user_id`, `is_default`),
    UNIQUE INDEX `llm_providers_user_id_provider_name_unique`(`user_id`, `provider_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `log_activities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `url` VARCHAR(191) NOT NULL,
    `method` VARCHAR(50) NOT NULL,
    `ip` VARCHAR(30) NOT NULL,
    `browser` VARCHAR(191) NULL,
    `platform` VARCHAR(191) NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ltm_translations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `status` INTEGER NOT NULL DEFAULT 0,
    `locale` VARCHAR(191) NOT NULL,
    `group` VARCHAR(191) NOT NULL,
    `key` TEXT NOT NULL,
    `value` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mail_lists` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `customer_id` INTEGER UNSIGNED NOT NULL,
    `contact_id` INTEGER UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `default_subject` VARCHAR(191) NOT NULL,
    `from_email` VARCHAR(191) NULL,
    `from_name` VARCHAR(191) NULL,
    `remind_message` TEXT NULL,
    `email_subscribe` TEXT NULL,
    `email_unsubscribe` TEXT NULL,
    `email_daily` TEXT NULL,
    `send_welcome_email` BOOLEAN NOT NULL DEFAULT false,
    `unsubscribe_notification` BOOLEAN NOT NULL DEFAULT false,
    `status` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `custom_order` INTEGER NOT NULL DEFAULT 0,
    `subscribe_confirmation` BOOLEAN NOT NULL DEFAULT true,
    `all_sending_servers` BOOLEAN NULL DEFAULT false,
    `embedded_form_options` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mail_lists_sending_servers` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `sending_server_id` INTEGER UNSIGNED NOT NULL,
    `mail_list_id` INTEGER UNSIGNED NOT NULL,
    `fitness` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `media` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(250) NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `storage` VARCHAR(30) NOT NULL DEFAULT 'local',
    `type` VARCHAR(30) NULL,
    `extension` VARCHAR(10) NULL,
    `size` BIGINT NULL,
    `original_file` VARCHAR(255) NULL,
    `thumbnail` VARCHAR(191) NULL,
    `stream_path` VARCHAR(191) NULL,
    `is_stream_ready` BOOLEAN NOT NULL DEFAULT false,
    `stream_ready_at` TIMESTAMP(0) NULL,
    `image_variants` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `is_trashed` BOOLEAN NOT NULL DEFAULT false,
    `trashed_at` TIMESTAMP(0) NULL,
    `is_project_media` BOOLEAN NOT NULL DEFAULT false,

    INDEX `media_is_stream_ready_index`(`is_stream_ready`),
    INDEX `media_stream_path_index`(`stream_path`),
    INDEX `media_stream_ready_at_index`(`stream_ready_at`),
    INDEX `media_thumbnail_index`(`thumbnail`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `media_conversion_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `media_id` BIGINT UNSIGNED NOT NULL,
    `job_id` VARCHAR(191) NULL,
    `status` VARCHAR(191) NULL,
    `stream_path` VARCHAR(191) NULL,
    `metadata` JSON NULL,
    `message` TEXT NULL,
    `conversion_settings` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `media_conversion_logs_media_id_foreign`(`media_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `messages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `chat_room_id` BIGINT UNSIGNED NOT NULL,
    `message` TEXT NOT NULL,
    `is_seen` TINYINT NOT NULL DEFAULT 0,
    `type` TINYINT NOT NULL DEFAULT 1,
    `file_type` VARCHAR(191) NULL,
    `is_file` TINYINT NOT NULL DEFAULT 0,
    `file` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `migrations` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `migration` VARCHAR(191) NOT NULL,
    `batch` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `module_items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `module_id` BIGINT UNSIGNED NOT NULL,
    `snapshot_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `data` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `module_items_module_id_foreign`(`module_id`),
    INDEX `module_items_snapshot_id_foreign`(`snapshot_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `modules` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `model_type` VARCHAR(191) NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mypipeline_workflows` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `api_token` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `mypipeline_workflows_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `created_by` BIGINT UNSIGNED NULL,
    `updated_by` BIGINT UNSIGNED NULL,
    `title` VARCHAR(191) NULL,
    `topic` VARCHAR(191) NULL,
    `note` TEXT NULL,
    `opportunity_id` BIGINT NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User',

    INDEX `notes_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notification_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `new_lead` BOOLEAN NOT NULL DEFAULT true,
    `appointment_booked` BOOLEAN NOT NULL DEFAULT true,
    `referral_earned` BOOLEAN NOT NULL DEFAULT true,
    `bill_due` BOOLEAN NOT NULL DEFAULT true,
    `automation_error` BOOLEAN NOT NULL DEFAULT true,
    `product_sold` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `internal_notification` BOOLEAN NOT NULL DEFAULT true,

    INDEX `notification_settings_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `details` VARCHAR(191) NULL,
    `url` VARCHAR(191) NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'unseen',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `notifications_status_index`(`status`),
    INDEX `notifications_title_index`(`title`),
    INDEX `notifications_url_index`(`url`),
    INDEX `notifications_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `open_logs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `message_id` VARCHAR(191) NOT NULL,
    `ip_address` VARCHAR(191) NOT NULL,
    `user_agent` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `open_logs_ip_address_index`(`ip_address`),
    INDEX `open_logs_message_id_foreign`(`message_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `opportunities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `pipeline_id` BIGINT UNSIGNED NOT NULL,
    `stage_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `contact_name` VARCHAR(191) NULL,
    `contact_email` VARCHAR(191) NULL,
    `contact_phone` VARCHAR(191) NULL,
    `alternate_number` VARCHAR(191) NULL,
    `company_name` VARCHAR(191) NULL,
    `opportunity_name` VARCHAR(191) NULL,
    `description` LONGTEXT NULL,
    `status` VARCHAR(191) NULL,
    `lead_value` VARCHAR(191) NULL,
    `type` VARCHAR(191) NULL,
    `opportunity_source` VARCHAR(191) NULL,
    `initial_call_date` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `enquirer_user_id` BIGINT UNSIGNED NULL,

    INDEX `idx_contact_pipeline_stage_user_id`(`contact_id`, `pipeline_id`, `stage_id`, `user_id`),
    INDEX `idx_opportunities_stage_created_deleted`(`stage_id`, `created_at`, `deleted_at`),
    INDEX `opportunities_contact_id_index`(`contact_id`),
    INDEX `opportunities_created_at_index`(`created_at`),
    INDEX `opportunities_initial_call_date_index`(`initial_call_date`),
    INDEX `opportunities_user_id_pipeline_id_stage_id_contact_id_index`(`user_id`, `pipeline_id`, `stage_id`, `contact_id`),
    FULLTEXT INDEX `full_text_index_for_like_query`(`contact_name`, `contact_email`, `contact_phone`, `opportunity_name`, `opportunity_source`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `order_details` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `variation` VARCHAR(191) NULL,
    `price` DOUBLE NULL,
    `tax` DOUBLE NULL,
    `discount` DOUBLE NULL,
    `coupon_discount` VARCHAR(191) NULL,
    `shipping_cost` VARCHAR(191) NULL,
    `quantity` INTEGER NOT NULL DEFAULT 1,
    `pickup_hub_id` BIGINT NULL,
    `product_referral_code` VARCHAR(191) NULL,
    `is_refundable` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orders` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `seller_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `delivery_hero_id` BIGINT UNSIGNED NULL,
    `billing_address` LONGTEXT NULL,
    `shipping_address` LONGTEXT NULL,
    `delivery_status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `payment_type` VARCHAR(191) NULL,
    `payment_status` VARCHAR(191) NOT NULL DEFAULT 'unpaid',
    `payment_details` LONGTEXT NULL,
    `sub_total` DOUBLE NULL,
    `discount` DOUBLE NULL,
    `coupon_discount` DOUBLE NULL,
    `total_tax` DOUBLE NULL,
    `total_amount` DOUBLE NULL,
    `shipping_cost` DOUBLE NULL,
    `total_payable` DOUBLE NULL,
    `code` VARCHAR(191) NULL,
    `date` TIMESTAMP(0) NULL,
    `viewed` TINYINT NOT NULL DEFAULT 0,
    `delivery_viewed` TINYINT NOT NULL DEFAULT 0,
    `payment_status_viewed` TINYINT NOT NULL DEFAULT 0,
    `commission_calculated` TINYINT NOT NULL DEFAULT 0,
    `is_cancelled` VARCHAR(191) NULL DEFAULT '0',
    `is_deleted` VARCHAR(191) NULL DEFAULT '0',
    `trx_id` VARCHAR(191) NOT NULL,
    `is_mailed` BOOLEAN NOT NULL DEFAULT false,
    `offline_method_id` VARCHAR(191) NULL,
    `offline_method_file` VARCHAR(191) NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `pickup_hub_id` BIGINT UNSIGNED NULL,
    `cancel_request` TINYINT NOT NULL DEFAULT 0,
    `cancel_request_at` TIMESTAMP(0) NULL,
    `delivery_hero_assign_at` TIMESTAMP(0) NULL,
    `created_by` BIGINT UNSIGNED NULL,
    `is_draft` BOOLEAN NOT NULL DEFAULT false,
    `shipping_method` VARCHAR(191) NULL,
    `is_coupon_system_active` BOOLEAN NULL,
    `tax_method` VARCHAR(191) NOT NULL DEFAULT '{"vat_tax_type" : "","tax_type" : "" }',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `overdue_notification_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `overdue_before_3_days_mail` BOOLEAN NOT NULL DEFAULT false,
    `overdue_before_3_days_whatsapp` BOOLEAN NOT NULL DEFAULT false,
    `overdue_before_2_days_mail` BOOLEAN NOT NULL DEFAULT false,
    `overdue_before_2_days_whatsapp` BOOLEAN NOT NULL DEFAULT false,
    `overdue_before_1_days_mail` BOOLEAN NOT NULL DEFAULT false,
    `overdue_before_1_days_whatsapp` BOOLEAN NOT NULL DEFAULT false,
    `overdue_mail` BOOLEAN NOT NULL DEFAULT false,
    `overdue_whatsapp` BOOLEAN NOT NULL DEFAULT false,
    `overdue_after_1_days_mail` BOOLEAN NOT NULL DEFAULT false,
    `overdue_after_1_days_whatsapp` BOOLEAN NOT NULL DEFAULT false,
    `overdue_after_2_days_mail` BOOLEAN NOT NULL DEFAULT false,
    `overdue_after_2_days_whatsapp` BOOLEAN NOT NULL DEFAULT false,
    `overdue_after_3_days_mail` BOOLEAN NOT NULL DEFAULT false,
    `overdue_after_3_days_whatsapp` BOOLEAN NOT NULL DEFAULT false,
    `date` DATE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `overdue_push_notification` BOOLEAN NOT NULL DEFAULT false,

    INDEX `overdue_notification_logs_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `package_features` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `package_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `hint` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `package_permission` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `package_id` BIGINT UNSIGNED NOT NULL,
    `permission_id` BIGINT UNSIGNED NOT NULL,
    `permission_name` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `package_purchase_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `package_id` BIGINT UNSIGNED NOT NULL,
    `package_type` VARCHAR(191) NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `txn_id` VARCHAR(191) NOT NULL,
    `response` LONGTEXT NOT NULL,
    `payment_gateway` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `package_user` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `package_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `txn_id` VARCHAR(191) NOT NULL,
    `log_id` BIGINT UNSIGNED NOT NULL,
    `is_activated` BOOLEAN NOT NULL DEFAULT true,
    `log_type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `agency_plan_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `subscription_started_at` TIMESTAMP(0) NOT NULL,
    `subscription_ended_at` TIMESTAMP(0) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `amount_paid` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `currency` VARCHAR(191) NOT NULL,

    INDEX `package_user_agency_plan_id_index`(`agency_plan_id`),
    INDEX `package_user_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `packages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `monthly_payment_plan_id` BIGINT UNSIGNED NULL,
    `yearly_payment_plan_id` BIGINT UNSIGNED NULL,
    `description` TEXT NOT NULL,
    `type` ENUM('regular', 'add-on', 'credit') NOT NULL DEFAULT 'regular',
    `price` DOUBLE NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `no_of_month` BIGINT NOT NULL DEFAULT 1,
    `discount` DOUBLE NOT NULL,
    `discount_type` ENUM('fixed', 'percentage') NOT NULL DEFAULT 'fixed',
    `discount_start_at` TIMESTAMP(0) NULL,
    `discount_end_at` TIMESTAMP(0) NULL,
    `created_by` VARCHAR(191) NULL,
    `updated_by` VARCHAR(191) NULL,
    `email_credit` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `whatsapp_credit` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `sms_credit` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `contacts` BIGINT NULL,
    `listing` BIGINT NULL,
    `automation_workshop` BIGINT NULL,
    `sub_user` BIGINT NULL,
    `searchyAi_assistant` BIGINT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `permissions` LONGTEXT NULL,
    `order` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `product_limit` BIGINT UNSIGNED NOT NULL,
    `grace_period` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `is_custom_plan` BOOLEAN NOT NULL DEFAULT false,
    `custom_plan_user_id` BIGINT UNSIGNED NULL,
    `networking` BIGINT NULL,
    `whatsapp_devices` BIGINT NULL,
    `whatsapp_message` BIGINT NULL,
    `form_builder_limit` BIGINT UNSIGNED NULL,

    INDEX `packages_monthly_payment_plan_id_index`(`monthly_payment_plan_id`),
    INDEX `packages_yearly_payment_plan_id_index`(`yearly_payment_plan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `page_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `page_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `title` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,
    `content` LONGTEXT NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` MEDIUMTEXT NULL,
    `keywords` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `page_languages_page_id_lang_title_index`(`page_id`, `lang`, `title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(191) NOT NULL,
    `link` TEXT NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `content` LONGTEXT NULL,
    `email` VARCHAR(191) NULL,
    `optional_email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `optional_phone` VARCHAR(191) NULL,
    `meta_image` TEXT NULL,
    `meta_image_id` BIGINT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pages_status_index`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `partner_package_purchase_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `affiliate_id` BIGINT UNSIGNED NULL,
    `log_type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `package_purchase_log_id` BIGINT UNSIGNED NULL,
    `amount` DECIMAL(8, 2) NOT NULL,
    `commission_earned` DECIMAL(8, 2) NOT NULL,
    `tds_deduction` DECIMAL(4, 2) NOT NULL DEFAULT 0.00,
    `transfer_id` VARCHAR(191) NULL,
    `transfer_on_hold` BOOLEAN NULL,
    `transfer_hold_till` TIMESTAMP(0) NULL,
    `transfer_amount` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    `tds_amount` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    `transfer_succeeded` BOOLEAN NOT NULL DEFAULT false,
    `error_log` TEXT NULL,
    `transfer_note` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `partner_package_purchase_logs_affiliate_id_foreign`(`affiliate_id`),
    INDEX `partner_package_purchase_logs_package_purchase_log_id_foreign`(`package_purchase_log_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `partner_program_package_purchases` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `affiliate_id` BIGINT UNSIGNED NULL,
    `program_package_id` BIGINT UNSIGNED NULL,
    `start_date` DATETIME(0) NOT NULL,
    `end_date` DATETIME(0) NOT NULL,
    `next_renewal_date` DATETIME(0) NOT NULL,
    `purchase_amount` DECIMAL(8, 2) NOT NULL,
    `payment_status` VARCHAR(191) NOT NULL,
    `txn_id` VARCHAR(191) NOT NULL,
    `payment_response` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `partner_program_package_purchases_affiliate_id_foreign`(`affiliate_id`),
    INDEX `partner_program_package_purchases_program_package_id_foreign`(`program_package_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `partner_program_packages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `package_type` TINYINT NOT NULL,
    `description` TEXT NULL,
    `amount` DECIMAL(8, 2) NOT NULL,
    `partner_percentage` DECIMAL(8, 2) NOT NULL,
    `plan_details` TEXT NULL,
    `image` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `password_requests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `otp` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payment_histories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `event` VARCHAR(191) NOT NULL,
    `remarks` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payment_method` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `trx_id` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NULL,
    `api_token` TEXT NULL,
    `is_guest` TINYINT NOT NULL DEFAULT 0,
    `amount` DOUBLE NOT NULL DEFAULT 0,
    `type` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `paymentz_permissions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `permissions` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `paymentz_permissions_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pending_emails` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `ticket_id` INTEGER NULL,
    `type` VARCHAR(191) NULL,
    `value` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pending_emails_ticket_id_index`(`ticket_id`),
    INDEX `pending_emails_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pending_user_emails` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_type` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `token` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,

    INDEX `pending_user_emails_email_index`(`email`),
    INDEX `pending_user_emails_user_type_user_id_index`(`user_type`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pending_users` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `ticket_id` INTEGER NULL,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(25) NULL,
    `email` VARCHAR(50) NOT NULL,
    `password` VARCHAR(200) NULL,
    `address` VARCHAR(250) NULL,
    `city` VARCHAR(30) NULL,
    `role` VARCHAR(20) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `pending_users_email_unique`(`email`),
    INDEX `pending_users_ticket_id_index`(`ticket_id`),
    INDEX `pending_users_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `permissions` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NULL,
    `attribute` VARCHAR(191) NOT NULL,
    `keywords` MEDIUMTEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `persistences` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `persistences_code_unique`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `personal_access_tokens` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tokenable_type` VARCHAR(191) NOT NULL,
    `tokenable_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `token` VARCHAR(64) NOT NULL,
    `abilities` TEXT NULL,
    `last_used_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `personal_access_tokens_token_unique`(`token`),
    INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type`, `tokenable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pickup_hub_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `pickup_hub_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `address` TEXT NOT NULL,
    `lang` VARCHAR(10) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pickup_hub_languages_lang_index`(`lang`),
    INDEX `pickup_hub_languages_pickup_hub_id_index`(`pickup_hub_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pickup_hubs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `phone` VARCHAR(191) NULL,
    `pick_up_status` TINYINT NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pipelines` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `default_contact_message` BOOLEAN NOT NULL DEFAULT false,
    `visible_funnel_chart` BOOLEAN NOT NULL DEFAULT false,
    `visible_pie_chart` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `position` INTEGER NOT NULL DEFAULT 0,

    INDEX `idx_pipelines_user_id_name`(`user_id`, `name`),
    INDEX `idx_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pixels` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `type` ENUM('adroll', 'google-ads', 'bing', 'facebook', 'google-analytics', 'google-tag-manager', 'linkedin', 'pinterest', 'quora', 'twitter') NOT NULL,
    `value` VARCHAR(255) NOT NULL,
    `user_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `name`(`name`),
    INDEX `user_id`(`user_id`),
    UNIQUE INDEX `pixels_name_user_id_unique`(`name`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plans` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `product` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `trial_days` INTEGER NULL,
    `currency` VARCHAR(12) NOT NULL,
    `decimals` TINYINT NULL,
    `plan_month` VARCHAR(255) NULL,
    `plan_year` VARCHAR(255) NULL,
    `amount_month` INTEGER NULL,
    `amount_year` INTEGER NULL,
    `visibility` TINYINT NULL,
    `color` VARCHAR(32) NOT NULL,
    `option_api` TINYINT NULL,
    `option_links` INTEGER NULL,
    `option_spaces` INTEGER NULL,
    `option_domains` INTEGER NULL,
    `option_stats` TINYINT NULL,
    `option_expiration` TINYINT NULL,
    `option_password` TINYINT NULL,
    `option_disabled` TINYINT NULL,
    `option_utm` TINYINT NULL,
    `option_global_domains` TINYINT NULL DEFAULT 1,
    `option_deep_links` TINYINT NULL DEFAULT 1,
    `coupons` TEXT NULL,
    `option_data_export` TINYINT NULL DEFAULT 1,
    `option_targeting` TINYINT NULL DEFAULT 1,
    `option_pixels` INTEGER NULL DEFAULT -1,
    `deleted_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plans_email_verification_servers` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `server_id` INTEGER UNSIGNED NOT NULL,
    `plan_id` INTEGER UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__bookmark` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `dbase` VARCHAR(255) NOT NULL DEFAULT '',
    `user` VARCHAR(255) NOT NULL DEFAULT '',
    `label` VARCHAR(255) NOT NULL DEFAULT '',
    `query` TEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__central_columns` (
    `db_name` VARCHAR(64) NOT NULL,
    `col_name` VARCHAR(64) NOT NULL,
    `col_type` VARCHAR(64) NOT NULL,
    `col_length` TEXT NULL,
    `col_collation` VARCHAR(64) NOT NULL,
    `col_isNull` BOOLEAN NOT NULL,
    `col_extra` VARCHAR(255) NULL DEFAULT '',
    `col_default` TEXT NULL,

    PRIMARY KEY (`db_name`, `col_name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__column_info` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `db_name` VARCHAR(64) NOT NULL DEFAULT '',
    `table_name` VARCHAR(64) NOT NULL DEFAULT '',
    `column_name` VARCHAR(64) NOT NULL DEFAULT '',
    `comment` VARCHAR(255) NOT NULL DEFAULT '',
    `mimetype` VARCHAR(255) NOT NULL DEFAULT '',
    `transformation` VARCHAR(255) NOT NULL DEFAULT '',
    `transformation_options` VARCHAR(255) NOT NULL DEFAULT '',
    `input_transformation` VARCHAR(255) NOT NULL DEFAULT '',
    `input_transformation_options` VARCHAR(255) NOT NULL DEFAULT '',

    UNIQUE INDEX `db_name`(`db_name`, `table_name`, `column_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__designer_settings` (
    `username` VARCHAR(64) NOT NULL,
    `settings_data` TEXT NOT NULL,

    PRIMARY KEY (`username`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__export_templates` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(64) NOT NULL,
    `export_type` VARCHAR(10) NOT NULL,
    `template_name` VARCHAR(64) NOT NULL,
    `template_data` TEXT NOT NULL,

    UNIQUE INDEX `u_user_type_template`(`username`, `export_type`, `template_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__favorite` (
    `username` VARCHAR(64) NOT NULL,
    `tables` TEXT NOT NULL,

    PRIMARY KEY (`username`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__history` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(64) NOT NULL DEFAULT '',
    `db` VARCHAR(64) NOT NULL DEFAULT '',
    `table` VARCHAR(64) NOT NULL DEFAULT '',
    `timevalue` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `sqlquery` TEXT NOT NULL,

    INDEX `username`(`username`, `db`, `table`, `timevalue`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__navigationhiding` (
    `username` VARCHAR(64) NOT NULL,
    `item_name` VARCHAR(64) NOT NULL,
    `item_type` VARCHAR(64) NOT NULL,
    `db_name` VARCHAR(64) NOT NULL,
    `table_name` VARCHAR(64) NOT NULL,

    PRIMARY KEY (`username`, `item_name`, `item_type`, `db_name`, `table_name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__pdf_pages` (
    `db_name` VARCHAR(64) NOT NULL DEFAULT '',
    `page_nr` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `page_descr` VARCHAR(50) NOT NULL DEFAULT '',

    INDEX `db_name`(`db_name`),
    PRIMARY KEY (`page_nr`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__recent` (
    `username` VARCHAR(64) NOT NULL,
    `tables` TEXT NOT NULL,

    PRIMARY KEY (`username`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__relation` (
    `master_db` VARCHAR(64) NOT NULL DEFAULT '',
    `master_table` VARCHAR(64) NOT NULL DEFAULT '',
    `master_field` VARCHAR(64) NOT NULL DEFAULT '',
    `foreign_db` VARCHAR(64) NOT NULL DEFAULT '',
    `foreign_table` VARCHAR(64) NOT NULL DEFAULT '',
    `foreign_field` VARCHAR(64) NOT NULL DEFAULT '',

    INDEX `foreign_field`(`foreign_db`, `foreign_table`),
    PRIMARY KEY (`master_db`, `master_table`, `master_field`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__savedsearches` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(64) NOT NULL DEFAULT '',
    `db_name` VARCHAR(64) NOT NULL DEFAULT '',
    `search_name` VARCHAR(64) NOT NULL DEFAULT '',
    `search_data` TEXT NOT NULL,

    UNIQUE INDEX `u_savedsearches_username_dbname`(`username`, `db_name`, `search_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__table_coords` (
    `db_name` VARCHAR(64) NOT NULL DEFAULT '',
    `table_name` VARCHAR(64) NOT NULL DEFAULT '',
    `pdf_page_number` INTEGER NOT NULL DEFAULT 0,
    `x` FLOAT NOT NULL DEFAULT 0,
    `y` FLOAT NOT NULL DEFAULT 0,

    PRIMARY KEY (`db_name`, `table_name`, `pdf_page_number`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__table_info` (
    `db_name` VARCHAR(64) NOT NULL DEFAULT '',
    `table_name` VARCHAR(64) NOT NULL DEFAULT '',
    `display_field` VARCHAR(64) NOT NULL DEFAULT '',

    PRIMARY KEY (`db_name`, `table_name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__table_uiprefs` (
    `username` VARCHAR(64) NOT NULL,
    `db_name` VARCHAR(64) NOT NULL,
    `table_name` VARCHAR(64) NOT NULL,
    `prefs` TEXT NOT NULL,
    `last_update` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`username`, `db_name`, `table_name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__tracking` (
    `db_name` VARCHAR(64) NOT NULL,
    `table_name` VARCHAR(64) NOT NULL,
    `version` INTEGER UNSIGNED NOT NULL,
    `date_created` DATETIME(0) NOT NULL,
    `date_updated` DATETIME(0) NOT NULL,
    `schema_snapshot` TEXT NOT NULL,
    `schema_sql` TEXT NULL,
    `data_sql` LONGTEXT NULL,
    `tracking` VARCHAR(191) NULL,
    `tracking_active` INTEGER UNSIGNED NOT NULL DEFAULT 1,

    PRIMARY KEY (`db_name`, `table_name`, `version`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__userconfig` (
    `username` VARCHAR(64) NOT NULL,
    `timevalue` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `config_data` TEXT NOT NULL,

    PRIMARY KEY (`username`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__usergroups` (
    `usergroup` VARCHAR(64) NOT NULL,
    `tab` VARCHAR(64) NOT NULL,
    `allowed` ENUM('Y', 'N') NOT NULL DEFAULT 'N',

    PRIMARY KEY (`usergroup`, `tab`, `allowed`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pma__users` (
    `username` VARCHAR(64) NOT NULL,
    `usergroup` VARCHAR(64) NOT NULL,

    PRIMARY KEY (`username`, `usergroup`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_activities` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NULL,
    `comment_id` BIGINT UNSIGNED NULL,
    `field_changed` VARCHAR(191) NULL,
    `old_value` TEXT NULL,
    `new_value` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_assignees` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_assignees_task_id_foreign`(`task_id`),
    INDEX `pr_assignees_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_attachments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `task_id` INTEGER NULL,
    `comment_id` INTEGER NULL,
    `user_id` INTEGER NULL,
    `media_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_attachments_comment_id_index`(`comment_id`),
    INDEX `pr_attachments_media_id_index`(`media_id`),
    INDEX `pr_attachments_task_id_index`(`task_id`),
    INDEX `pr_attachments_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_backgrounds` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `bg` VARCHAR(191) NOT NULL DEFAULT '#624b66',
    `image` VARCHAR(191) NULL,
    `top` VARCHAR(191) NOT NULL DEFAULT '#624b66',
    `color` VARCHAR(50) NOT NULL DEFAULT '#ffffff',
    `type` VARCHAR(191) NOT NULL DEFAULT 'default',
    `side` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,

    INDEX `pr_backgrounds_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_board_lists` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `project_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `order` INTEGER NOT NULL DEFAULT 0,
    `is_archive` INTEGER NOT NULL DEFAULT 0,
    `user_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_board_lists_order_index`(`order`),
    INDEX `pr_board_lists_project_id_foreign`(`project_id`),
    INDEX `pr_board_lists_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_check_lists` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `is_done` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_check_lists_task_id_foreign`(`task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_comments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `details` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_comments_task_id_foreign`(`task_id`),
    INDEX `pr_comments_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_labels` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `color` VARCHAR(20) NOT NULL DEFAULT 'lightgray',
    `color_name` VARCHAR(100) NULL,

    INDEX `pr_labels_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_projects` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(200) NOT NULL,
    `slug` VARCHAR(200) NULL,
    `background_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `workspace_id` BIGINT UNSIGNED NULL,
    `description` TEXT NULL,
    `is_private` INTEGER NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_projects_user_id_foreign`(`user_id`),
    INDEX `pr_projects_workspace_id_foreign`(`workspace_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_recent_projects` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `project_id` BIGINT UNSIGNED NOT NULL,
    `opened` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_recent_projects_project_id_foreign`(`project_id`),
    INDEX `pr_recent_projects_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(50) NULL,
    `slug` VARCHAR(50) NULL,
    `type` VARCHAR(20) NULL,
    `value` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_settings_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_starred_projects` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `project_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_starred_projects_project_id_foreign`(`project_id`),
    INDEX `pr_starred_projects_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_task_labels` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `label_id` BIGINT UNSIGNED NOT NULL,

    INDEX `pr_task_labels_label_id_foreign`(`label_id`),
    INDEX `pr_task_labels_task_id_foreign`(`task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(200) NOT NULL,
    `slug` VARCHAR(200) NULL,
    `is_done` INTEGER NOT NULL DEFAULT 0,
    `is_archive` INTEGER NOT NULL DEFAULT 0,
    `description` TEXT NULL,
    `cover` INTEGER NULL,
    `list_id` BIGINT UNSIGNED NOT NULL,
    `order` INTEGER NOT NULL DEFAULT 0,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `project_id` BIGINT UNSIGNED NOT NULL,
    `due_date` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_tasks_list_id_foreign`(`list_id`),
    INDEX `pr_tasks_order_index`(`order`),
    INDEX `pr_tasks_project_id_foreign`(`project_id`),
    INDEX `pr_tasks_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_team_members` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `workspace_id` BIGINT UNSIGNED NOT NULL,
    `added_by` BIGINT UNSIGNED NULL,
    `role` VARCHAR(191) NULL DEFAULT 'normal',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_team_members_added_by_index`(`added_by`),
    INDEX `pr_team_members_user_id_index`(`user_id`),
    INDEX `pr_team_members_workspace_id_index`(`workspace_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_timers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(200) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `task_id` BIGINT UNSIGNED NOT NULL,
    `duration` INTEGER NOT NULL DEFAULT 0,
    `started_at` TIMESTAMP(0) NULL,
    `stopped_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_timers_task_id_foreign`(`task_id`),
    INDEX `pr_timers_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_workspace_types` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(200) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_workspace_types_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pr_workspaces` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(200) NOT NULL,
    `slug` VARCHAR(200) NULL,
    `type_id` BIGINT UNSIGNED NULL,
    `website` VARCHAR(200) NULL,
    `logo` VARCHAR(200) NULL,
    `description` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `pr_workspaces_type_id_foreign`(`type_id`),
    INDEX `pr_workspaces_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_categories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` BIGINT UNSIGNED NULL,
    `position` INTEGER NULL,
    `ordering` INTEGER NOT NULL DEFAULT 0,
    `slug` VARCHAR(191) NOT NULL,
    `commission` DOUBLE NOT NULL DEFAULT 0.000,
    `is_featured` TINYINT NOT NULL DEFAULT 0,
    `status` TINYINT NOT NULL DEFAULT 1,
    `icon` TEXT NULL,
    `logo_id` BIGINT UNSIGNED NULL,
    `logo` TEXT NULL,
    `banner_id` BIGINT UNSIGNED NULL,
    `banner` TEXT NULL,
    `icon_location` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_category_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `product_category_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(191) NOT NULL DEFAULT 'en',
    `title` VARCHAR(191) NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` VARCHAR(191) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_custom_fields` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `field_name` VARCHAR(191) NOT NULL,
    `field_type` TINYINT NOT NULL,
    `is_required` BOOLEAN NOT NULL DEFAULT false,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `product_custom_fields_product_id_index`(`product_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_helps` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `show_info_btn` BOOLEAN NOT NULL DEFAULT true,
    `show_video_btn` BOOLEAN NOT NULL DEFAULT true,
    `text_beside_label` LONGTEXT NULL,
    `po_title` LONGTEXT NULL,
    `po_content` LONGTEXT NULL,
    `video_info_title` LONGTEXT NULL,
    `video_link` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL DEFAULT 'en',
    `name` VARCHAR(191) NOT NULL,
    `short_description` TEXT NULL,
    `description` LONGTEXT NULL,
    `pdf_specification_id` BIGINT UNSIGNED NULL,
    `pdf_specification` MEDIUMTEXT NULL,
    `tags` VARCHAR(191) NULL,
    `unit` VARCHAR(191) NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` TEXT NULL,
    `meta_keywords` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `product_languages_lang_index`(`lang`),
    INDEX `product_languages_product_id_index`(`product_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_stocks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `variant_ids` VARCHAR(191) NULL,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NULL,
    `sku` VARCHAR(191) NULL,
    `current_stock` INTEGER NOT NULL DEFAULT 0,
    `price` DOUBLE NULL,
    `image` MEDIUMTEXT NULL,
    `image_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_vat_taxes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `vat_tax_id` BIGINT UNSIGNED NOT NULL,
    `amount` DOUBLE NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_views` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `product_views_product_id_foreign`(`product_id`),
    INDEX `product_views_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `products` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `brand_id` BIGINT UNSIGNED NULL,
    `category_id` BIGINT UNSIGNED NULL,
    `sub_category_id` BIGINT UNSIGNED NULL,
    `micro_category_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `pipeline_id` BIGINT UNSIGNED NULL,
    `stage_id` BIGINT UNSIGNED NULL,
    `sales_plan_id` BIGINT UNSIGNED NULL,
    `enable_buy_now` BOOLEAN NOT NULL DEFAULT false,
    `enable_enquire_now` BOOLEAN NOT NULL DEFAULT true,
    `enable_appointment` BOOLEAN NOT NULL DEFAULT false,
    `enable_custom_link` BOOLEAN NOT NULL DEFAULT false,
    `custom_link` TEXT NULL,
    `event_type_id` INTEGER NULL,
    `enquiry_type` VARCHAR(191) NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `slug` VARCHAR(191) NOT NULL,
    `price` DOUBLE NULL,
    `show_price` BOOLEAN NOT NULL DEFAULT true,
    `special_discount` DOUBLE NULL,
    `special_discount_type` VARCHAR(191) NULL,
    `special_discount_start` DATETIME(0) NULL,
    `special_discount_end` DATETIME(0) NULL,
    `purchase_cost` DOUBLE NULL,
    `barcode` VARCHAR(191) NULL,
    `video_provider` VARCHAR(191) NULL,
    `video_url` VARCHAR(191) NULL,
    `colors` VARCHAR(191) NULL,
    `attribute_sets` VARCHAR(191) NULL,
    `vat_taxes` VARCHAR(191) NULL,
    `has_variant` TINYINT NOT NULL DEFAULT 0,
    `selected_variants` MEDIUMTEXT NULL,
    `selected_variants_ids` MEDIUMTEXT NULL,
    `thumbnail` TEXT NULL,
    `images` TEXT NULL,
    `description_images` LONGTEXT NULL,
    `thumbnail_id` VARCHAR(191) NULL,
    `image_ids` VARCHAR(191) NULL,
    `current_stock` INTEGER NOT NULL,
    `minimum_order_quantity` INTEGER NOT NULL DEFAULT 1,
    `stock_notification` TINYINT NOT NULL DEFAULT 0,
    `low_stock_to_notify` INTEGER NULL,
    `stock_visibility` ENUM('hide_stock', 'visible_with_quantity', 'visible_with_text') NOT NULL DEFAULT 'hide_stock',
    `total_sale` BIGINT NOT NULL DEFAULT 0,
    `status` ENUM('unpublished', 'published', 'trash') NOT NULL DEFAULT 'unpublished',
    `is_approved` TINYINT NOT NULL DEFAULT 0,
    `is_catalog` TINYINT NOT NULL DEFAULT 0,
    `external_link` VARCHAR(191) NULL,
    `is_featured` TINYINT NOT NULL DEFAULT 0,
    `is_classified` TINYINT NOT NULL DEFAULT 0,
    `is_wholesale` TINYINT NOT NULL DEFAULT 0,
    `contact_info` TEXT NULL,
    `is_digital` TINYINT NOT NULL DEFAULT 0,
    `is_refundable` TINYINT NOT NULL DEFAULT 0,
    `todays_deal` TINYINT NOT NULL DEFAULT 0,
    `rating` DOUBLE NOT NULL DEFAULT 0.00,
    `viewed` BIGINT NOT NULL DEFAULT 0,
    `shipping_type` VARCHAR(191) NULL,
    `shipping_fee` DOUBLE NULL,
    `shipping_fee_depend_on_quantity` TINYINT NOT NULL DEFAULT 0,
    `estimated_shipping_days` TEXT NULL,
    `cash_on_delivery` TINYINT NOT NULL DEFAULT 0,
    `meta_image` TEXT NULL,
    `product_link` TEXT NULL,
    `product_file` TEXT NULL,
    `product_file_id` BIGINT UNSIGNED NULL,
    `meta_image_id` VARCHAR(191) NULL,
    `reward` DOUBLE NULL,
    `is_deleted` TINYINT NOT NULL DEFAULT 0,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `product_brochure_pdf` TEXT NOT NULL,
    `product_brochure_pdf_ids` VARCHAR(191) NULL,
    `product_brochure_image` TEXT NOT NULL,
    `product_brochure_image_ids` VARCHAR(191) NULL,
    `tags` TEXT NULL,
    `videos` TEXT NULL,
    `reasons` JSON NULL,
    `button_title` VARCHAR(191) NULL,
    `redirect_link` TEXT NULL,
    `pixel_id` VARCHAR(191) NULL,
    `last_status` VARCHAR(191) NULL,
    `total_inquired` BIGINT NOT NULL DEFAULT 0,
    `position` INTEGER NULL DEFAULT 0,
    `total_visits` BIGINT UNSIGNED NOT NULL DEFAULT 0,

    INDEX `products_category_id_user_id_slug_index`(`category_id`, `user_id`, `slug`),
    INDEX `products_current_stock_minimum_order_quantity_status_index`(`current_stock`, `minimum_order_quantity`, `status`),
    INDEX `products_event_type_id_index`(`event_type_id`),
    INDEX `products_is_approved_index`(`is_approved`),
    INDEX `products_price_special_discount_special_discount_type_index`(`price`, `special_discount`, `special_discount_type`),
    INDEX `products_sales_plan_id_index`(`sales_plan_id`),
    INDEX `products_slug_index`(`slug`),
    INDEX `products_special_discount_start_special_discount_end_index`(`special_discount_start`, `special_discount_end`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `project_files` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `related_to` VARCHAR(20) NULL,
    `related_id` BIGINT NULL,
    `file` TEXT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `projects` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `user_id` BIGINT NOT NULL,
    `status` VARCHAR(20) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `refunds` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `order_detail_id` BIGINT UNSIGNED NULL,
    `seller_id` BIGINT UNSIGNED NULL,
    `processed_by` BIGINT UNSIGNED NULL,
    `total_amount` DOUBLE NULL,
    `shipping_cost` DOUBLE NULL,
    `refund_amount` DOUBLE NULL,
    `payment_type` VARCHAR(191) NULL,
    `payment_details` TEXT NULL,
    `exchange_rate` DOUBLE NULL DEFAULT 1,
    `seller_approval` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `admin_approval` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `reject_reason` TEXT NULL,
    `remark` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `registration_requests` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(191) NULL,
    `last_name` VARCHAR(191) NULL,
    `phone` VARCHAR(30) NULL,
    `otp` BIGINT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reminders` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `completed` BOOLEAN NOT NULL DEFAULT false,
    `completed_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `replicate_histories` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `replicatiobale_type` VARCHAR(191) NOT NULL,
    `replicatiobale_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `replicate_id` BIGINT UNSIGNED NOT NULL,
    `old_uuid` VARCHAR(191) NULL,
    `uuid` VARCHAR(191) NULL,
    `data` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `snapshot_id` BIGINT UNSIGNED NULL,

    INDEX `replicate_histories_replicate_id_index`(`replicate_id`),
    INDEX `replicate_histories_replicatiobale_id_index`(`replicatiobale_id`),
    INDEX `replicate_histories_replicatiobale_type_index`(`replicatiobale_type`),
    INDEX `replicate_histories_snapshot_id_foreign`(`snapshot_id`),
    INDEX `replicate_histories_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `replies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `device_id` BIGINT UNSIGNED NOT NULL,
    `template_id` BIGINT UNSIGNED NULL,
    `keyword` VARCHAR(191) NULL,
    `reply` TEXT NULL,
    `match_type` VARCHAR(191) NOT NULL DEFAULT 'equal',
    `reply_type` VARCHAR(191) NOT NULL DEFAULT 'text',
    `api_key` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `replies_device_id_foreign`(`device_id`),
    INDEX `replies_template_id_foreign`(`template_id`),
    INDEX `replies_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `requirement_queries` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `product` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `location_id` VARCHAR(191) NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `user_type` VARCHAR(191) NULL,
    `description` MEDIUMTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `quantity` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `name` VARCHAR(191) NULL,
    `category` BIGINT UNSIGNED NULL,
    `sub_category` BIGINT UNSIGNED NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `review_likes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `reviewable_type` VARCHAR(191) NOT NULL,
    `reviewable_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `review_likes_reviewable_type_reviewable_id_index`(`reviewable_type`, `reviewable_id`),
    INDEX `review_likes_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `review_replies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `review_id` BIGINT UNSIGNED NOT NULL,
    `parent_id` BIGINT UNSIGNED NULL,
    `reply` TEXT NULL,
    `images` VARCHAR(191) NULL,
    `level` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `review_replies_parent_id_foreign`(`parent_id`),
    INDEX `review_replies_review_id_foreign`(`review_id`),
    INDEX `review_replies_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reviews` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `title` VARCHAR(191) NULL,
    `rating` DOUBLE NOT NULL DEFAULT 0.000,
    `comment` TEXT NULL,
    `images` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `reviews_product_id_foreign`(`product_id`),
    INDEX `reviews_status_index`(`status`),
    INDEX `reviews_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reward_details` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `reward_id` BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL,
    `product_qty` BIGINT NOT NULL,
    `reward` BIGINT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `rewards` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `rewards` DOUBLE NOT NULL DEFAULT 0.000,
    `last_converted` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `role_users` (
    `user_id` BIGINT UNSIGNED NOT NULL,
    `role_id` INTEGER UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`user_id`, `role_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `roles` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `slug` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `permissions` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `agency_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,

    UNIQUE INDEX `roles_slug_unique`(`slug`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `round_robin_assignment_automations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `automation_id` INTEGER UNSIGNED NOT NULL,
    `action_id` INTEGER UNSIGNED NOT NULL,
    `staff_id` BIGINT UNSIGNED NOT NULL,
    `weight` INTEGER UNSIGNED NULL DEFAULT 1,
    `assigned` INTEGER UNSIGNED NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `automation_id_index`(`automation_id`),
    INDEX `round_robin_assignment_automations_action_id_index`(`action_id`),
    INDEX `round_robin_assignment_automations_assigned_index`(`assigned`),
    INDEX `round_robin_assignment_automations_automation_id_foreign`(`automation_id`),
    INDEX `round_robin_assignment_automations_staff_id_foreign`(`staff_id`),
    INDEX `round_robin_assignment_automations_weight_index`(`weight`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `schedule_settings` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NULL,
    `slug` VARCHAR(50) NULL,
    `type` VARCHAR(20) NULL,
    `value` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `schedulecontacts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `contact_id` BIGINT UNSIGNED NULL,
    `schedulemessage_id` BIGINT UNSIGNED NULL,
    `status_code` INTEGER NULL,

    INDEX `schedulecontacts_contact_id_foreign`(`contact_id`),
    INDEX `schedulecontacts_schedulemessage_id_foreign`(`schedulemessage_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `schedulemessages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `device_id` BIGINT UNSIGNED NULL,
    `template_id` BIGINT UNSIGNED NULL,
    `title` VARCHAR(191) NULL,
    `body` TEXT NULL,
    `schedule_at` DATETIME(0) NULL,
    `zone` VARCHAR(191) NULL,
    `date` DATE NULL,
    `time` DATE NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `schedulemessages_device_id_foreign`(`device_id`),
    INDEX `schedulemessages_template_id_foreign`(`template_id`),
    INDEX `schedulemessages_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `searches` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `query` VARCHAR(191) NOT NULL,
    `total_search` BIGINT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_ai_staff_permissions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `staff_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `module` VARCHAR(100) NOT NULL,
    `permission` VARCHAR(100) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `seller_ai_staff_permissions_staff_id_index`(`staff_id`),
    INDEX `seller_ai_staff_permissions_staff_id_module_index`(`staff_id`, `module`),
    INDEX `seller_ai_staff_permissions_user_id_index`(`user_id`),
    INDEX `seller_ai_staff_permissions_user_id_module_permission_index`(`user_id`, `module`, `permission`),
    UNIQUE INDEX `unique_ai_staff_permission`(`staff_id`, `module`, `permission`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_custom_domains` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `domain_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `domain` VARCHAR(550) NOT NULL,
    `dns_verified` BOOLEAN NOT NULL DEFAULT false,
    `dns_verified_at` TIMESTAMP(0) NULL,
    `conf_applied` BOOLEAN NOT NULL DEFAULT false,
    `conf_applied_at` TIMESTAMP(0) NULL,
    `ssl_certificate_id` INTEGER NULL,
    `ssl_activated_at` TIMESTAMP(0) NULL,
    `raw_response` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `version` VARCHAR(191) NOT NULL DEFAULT '000',
    `version_android` VARCHAR(191) NOT NULL DEFAULT '000',
    `is_seller_domain` INTEGER NOT NULL DEFAULT 0,
    `dns_queue` INTEGER NOT NULL DEFAULT 0,
    `deleted_at` TIMESTAMP(0) NULL,
    `is_removed_from_server` BOOLEAN NOT NULL DEFAULT false,
    `removed_from_server_at` TIMESTAMP(0) NULL,

    INDEX `seller_custom_domains_conf_applied_index`(`conf_applied`),
    INDEX `seller_custom_domains_dns_verified_index`(`dns_verified`),
    INDEX `seller_custom_domains_domain_index`(`domain`),
    INDEX `seller_custom_domains_is_seller_domain_index`(`is_seller_domain`),
    INDEX `seller_custom_domains_ssl_certificate_id_index`(`ssl_certificate_id`),
    INDEX `seller_custom_domains_status_index`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_events` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `title` VARCHAR(191) NOT NULL,
    `link` VARCHAR(191) NOT NULL,
    `date_time` DATETIME(0) NOT NULL,
    `description` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_facebook_leads` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `facebook_id` VARCHAR(100) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `seller_facebook_leads_user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_notes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `note` TEXT NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `seller_notes_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_payouts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `amount` DOUBLE NULL,
    `message` LONGTEXT NULL,
    `payment_to` MEDIUMTEXT NULL,
    `payment_by` VARCHAR(191) NULL,
    `payment_from` VARCHAR(191) NULL,
    `status` ENUM('pending', 'accepted', 'rejected', 'canceled', 'processed') NOT NULL DEFAULT 'pending',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_profile_user` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `seller_profile_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_staff_model_has_permissions` (
    `permission_id` BIGINT UNSIGNED NOT NULL,
    `model_type` VARCHAR(191) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,

    INDEX `model_has_permissions_model_id_model_type_index`(`model_id`, `model_type`),
    PRIMARY KEY (`permission_id`, `model_id`, `model_type`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_staff_model_has_roles` (
    `role_id` BIGINT UNSIGNED NOT NULL,
    `model_type` VARCHAR(191) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,

    INDEX `model_has_roles_model_id_model_type_index`(`model_id`, `model_type`),
    PRIMARY KEY (`role_id`, `model_id`, `model_type`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_staff_permissions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `feature_name` VARCHAR(191) NULL,
    `guard_name` VARCHAR(191) NOT NULL,
    `sort` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_staff_role_has_permissions` (
    `permission_id` BIGINT UNSIGNED NOT NULL,
    `role_id` BIGINT UNSIGNED NOT NULL,

    INDEX `seller_staff_role_has_permissions_role_id_foreign`(`role_id`),
    PRIMARY KEY (`permission_id`, `role_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_staff_roles` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `guard_name` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `seller_staff_roles_name_guard_name_unique`(`name`, `guard_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `seller_staffs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `seller_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `type` ENUM('human', 'ai') NOT NULL DEFAULT 'human',
    `ai_prompt` TEXT NULL,
    `ai_selected_model` VARCHAR(191) NULL,
    `ai_is_active` BOOLEAN NOT NULL DEFAULT true,
    `ai_settings` JSON NULL,
    `agent_id` VARCHAR(191) NULL,
    `inbox_read` BOOLEAN NOT NULL DEFAULT false,
    `inbox_reply` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `agency_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,

    INDEX `seller_staffs_agent_id_index`(`agent_id`),
    INDEX `seller_staffs_ai_is_active_index`(`ai_is_active`),
    INDEX `seller_staffs_ai_selected_model_index`(`ai_selected_model`),
    INDEX `seller_staffs_type_index`(`type`),
    INDEX `users_seller_id_foreign`(`seller_id`),
    INDEX `users_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sellers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `shop_name` VARCHAR(191) NOT NULL,
    `slug` VARCHAR(191) NOT NULL,
    `verified_at` DATETIME(0) NULL,
    `license_no` VARCHAR(191) NULL,
    `tax_paper` TEXT NULL,
    `logo` TEXT NULL,
    `banner` TEXT NULL,
    `shop_page_contents` TEXT NULL,
    `mobile_shop_page_contents` TEXT NULL,
    `shop_banner_id` BIGINT UNSIGNED NULL,
    `shop_banner` TEXT NULL,
    `shop_tagline` TEXT NULL,
    `seller_country_id` BIGINT UNSIGNED NULL,
    `phone_no` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,
    `rating_count` DOUBLE NULL DEFAULT 0,
    `reviews_count` BIGINT NULL DEFAULT 0,
    `facebook` TEXT NULL,
    `google` TEXT NULL,
    `twitter` TEXT NULL,
    `youtube` TEXT NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `about` LONGTEXT NULL,
    `header_script` TEXT NULL,
    `body_script` TEXT NULL,
    `total_visits` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `terms_of_service` MEDIUMTEXT NULL,
    `privacy_policy` MEDIUMTEXT NULL,
    `refund_policy` MEDIUMTEXT NULL,
    `shop_banner_video` VARCHAR(191) NULL,
    `video_upload_location` VARCHAR(191) NULL,
    `city_id` BIGINT UNSIGNED NULL,
    `banner_video_link` VARCHAR(191) NULL,
    `show_call_number` BOOLEAN NOT NULL DEFAULT false,
    `wa_number` VARCHAR(191) NULL,
    `show_wa_number` BOOLEAN NOT NULL DEFAULT false,
    `paid_account` BOOLEAN NOT NULL DEFAULT false,
    `category_id` BIGINT UNSIGNED NULL,
    `sub_category_id` BIGINT UNSIGNED NULL,
    `topics` TEXT NULL,
    `linkedin` VARCHAR(255) NULL,
    `leader_name` VARCHAR(191) NULL,
    `job_position` VARCHAR(100) NULL,
    `leader_profile` TEXT NULL,
    `website_link` VARCHAR(255) NULL,
    `legal_name` TEXT NULL,
    `gst_response` LONGTEXT NULL,
    `aadhar_number` VARCHAR(191) NULL,
    `aadhar_number_verified_at` TIMESTAMP(0) NULL,
    `aadhar_number_ref_id` VARCHAR(191) NULL,
    `aadhar_number_response` LONGTEXT NULL,
    `logo_id` BIGINT UNSIGNED NULL,
    `banner_id` BIGINT UNSIGNED NULL,
    `leader_profile_id` BIGINT UNSIGNED NULL,
    `leader_about` TEXT NULL,
    `package_sort_id` INTEGER UNSIGNED NULL,
    `total_inquired` BIGINT NOT NULL DEFAULT 0,
    `show_address` BOOLEAN NOT NULL DEFAULT false,
    `published_on_searchy` BOOLEAN NOT NULL DEFAULT true,
    `agency_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,

    INDEX `sellers_shop_name_index`(`shop_name`),
    INDEX `sellers_slug_index`(`slug`),
    INDEX `sellers_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sender_sms` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `sender_name` VARCHAR(191) NOT NULL,
    `sms_user_id` INTEGER NOT NULL,
    `PEID` VARCHAR(191) NOT NULL,
    `approved` INTEGER NOT NULL DEFAULT 0,
    `is_deleted` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `senders` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `customer_id` INTEGER UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sending_server_id` INTEGER UNSIGNED NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sending_servers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` VARCHAR(36) NOT NULL,
    `admin_id` BIGINT UNSIGNED NULL,
    `customer_id` BIGINT UNSIGNED NULL,
    `bounce_handler_id` BIGINT UNSIGNED NULL,
    `feedback_loop_handler_id` BIGINT UNSIGNED NULL,
    `name` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `host` VARCHAR(191) NULL,
    `aws_access_key_id` VARCHAR(191) NULL,
    `aws_secret_access_key` VARCHAR(191) NULL,
    `aws_region` VARCHAR(191) NULL,
    `domain` VARCHAR(191) NULL,
    `api_key` VARCHAR(191) NULL,
    `smtp_username` VARCHAR(191) NULL,
    `smtp_password` VARCHAR(191) NULL,
    `smtp_port` INTEGER UNSIGNED NULL,
    `smtp_protocol` VARCHAR(191) NULL,
    `sendmail_path` VARCHAR(191) NULL,
    `quota_value` INTEGER UNSIGNED NOT NULL,
    `quota_base` INTEGER UNSIGNED NOT NULL,
    `quota_unit` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `api_secret_key` TEXT NULL,
    `quota` BLOB NULL,
    `default_from_email` VARCHAR(191) NULL,
    `options` LONGTEXT NULL,
    `username` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `sending_servers_admin_id_index`(`admin_id`),
    INDEX `sending_servers_bounce_handler_id_index`(`bounce_handler_id`),
    INDEX `sending_servers_customer_id_index`(`customer_id`),
    INDEX `sending_servers_feedback_loop_handler_id_index`(`feedback_loop_handler_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `server_configs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `value` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `server_side_events` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `type` VARCHAR(191) NULL,
    `model` VARCHAR(191) NULL,
    `operation` VARCHAR(191) NULL,
    `current` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `total` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `is_completed` BOOLEAN NOT NULL DEFAULT false,
    `data` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `server_side_events_model_index`(`model`),
    INDEX `server_side_events_type_index`(`type`),
    INDEX `server_side_events_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `service_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `service_id` BIGINT UNSIGNED NOT NULL,
    `lang` VARCHAR(10) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `sub_title` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `service_languages_service_id_lang_title_index`(`service_id`, `lang`, `title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `services` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `position` INTEGER NOT NULL DEFAULT 1,
    `url` VARCHAR(191) NULL,
    `image` TEXT NULL,
    `image_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `services_position_index`(`position`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sessions` (
    `id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `ip_address` VARCHAR(45) NULL,
    `user_agent` TEXT NULL,
    `payload` TEXT NOT NULL,
    `last_activity` INTEGER NOT NULL,

    INDEX `sessions_last_activity_index`(`last_activity`),
    INDEX `sessions_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `lang` VARCHAR(10) NULL DEFAULT 'en',
    `title` VARCHAR(100) NULL,
    `value` MEDIUMTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `settings_lang_index`(`lang`),
    INDEX `settings_title_index`(`title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sliders` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `order` INTEGER NOT NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `for_mobile` BOOLEAN NOT NULL DEFAULT false,
    `action_type` VARCHAR(191) NOT NULL,
    `link` VARCHAR(191) NOT NULL DEFAULT '/',
    `bg_image` TEXT NULL,
    `bg_image_id` BIGINT UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `sliders_action_type_index`(`action_type`),
    INDEX `sliders_order_btn_link_status_index`(`order`, `status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sms_template` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `EntityID` VARCHAR(191) NOT NULL,
    `TemplateID` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `template` VARCHAR(191) NOT NULL,
    `seller_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `service_type` ENUM('TRANS', 'PROMO') NOT NULL DEFAULT 'TRANS',
    `is_deleted` BOOLEAN NOT NULL DEFAULT false,
    `sender_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sms_user` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `phone_no` VARCHAR(191) NOT NULL,
    `seller_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `smstransactions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `device_id` BIGINT UNSIGNED NULL,
    `app_id` BIGINT UNSIGNED NULL,
    `template_id` BIGINT UNSIGNED NULL,
    `from` VARCHAR(191) NULL,
    `to` VARCHAR(191) NULL,
    `type` VARCHAR(191) NULL DEFAULT 'from_api',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `smstransactions_app_id_foreign`(`app_id`),
    INDEX `smstransactions_device_id_foreign`(`device_id`),
    INDEX `smstransactions_template_id_foreign`(`template_id`),
    INDEX `smstransactions_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `snapshot_purchase_transactions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `snapshot_id` BIGINT UNSIGNED NOT NULL,
    `payment_id` BIGINT UNSIGNED NULL,
    `plan_id` BIGINT UNSIGNED NULL,
    `transaction_id` VARCHAR(191) NULL,
    `amount` DECIMAL(8, 2) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `snapshot_purchase_transactions_payment_id_index`(`payment_id`),
    INDEX `snapshot_purchase_transactions_plan_id_index`(`plan_id`),
    INDEX `snapshot_purchase_transactions_snapshot_id_index`(`snapshot_id`),
    INDEX `snapshot_purchase_transactions_transaction_id_index`(`transaction_id`),
    INDEX `snapshot_purchase_transactions_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `snapshot_subaccounts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `snapshot_id` BIGINT UNSIGNED NOT NULL,
    `sub_account_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `snapshot_subaccounts_snapshot_id_foreign`(`snapshot_id`),
    INDEX `snapshot_subaccounts_sub_account_id_index`(`sub_account_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `snapshots` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` CHAR(36) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `admin_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `template_name` VARCHAR(191) NULL,
    `snapshot_template_image_id` VARCHAR(191) NULL,
    `category_name` VARCHAR(191) NULL,
    `is_template` BOOLEAN NOT NULL DEFAULT false,
    `template_status` BOOLEAN NOT NULL DEFAULT false,
    `version` VARCHAR(191) NOT NULL DEFAULT '1',
    `plan_id` BIGINT UNSIGNED NULL,
    `snapshot_id` BIGINT UNSIGNED NULL,
    `rejection_reason` TEXT NULL,

    INDEX `snapshots_admin_id_index`(`admin_id`),
    INDEX `snapshots_snapshot_id_index`(`snapshot_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `spaces` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `color` INTEGER NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `name`(`name`),
    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `staff_devices` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `staff_id` BIGINT UNSIGNED NOT NULL,
    `device_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `staff_devices_device_id_index`(`device_id`),
    INDEX `staff_devices_staff_id_index`(`staff_id`),
    UNIQUE INDEX `staff_devices_staff_id_device_id_unique`(`staff_id`, `device_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `staff_substaff` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `parent_id` BIGINT UNSIGNED NOT NULL,
    `staff_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `pipeline_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `default_contact_message` BOOLEAN NOT NULL DEFAULT false,
    `order` BIGINT UNSIGNED NOT NULL,
    `visible_funnel_chart` BOOLEAN NOT NULL DEFAULT false,
    `visible_pie_chart` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `idx_pipeline_id`(`pipeline_id`),
    INDEX `idx_stages_pipeline_id_name`(`pipeline_id`, `name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `states` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `country_id` BIGINT UNSIGNED NOT NULL,
    `latitude` DECIMAL(10, 8) NULL,
    `longitude` DECIMAL(11, 8) NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stats` (
    `link_id` INTEGER NOT NULL,
    `name` ENUM('browser', 'platform', 'device', 'clicks', 'country', 'city', 'referrer', 'language', 'clicks_hours') NOT NULL,
    `value` VARCHAR(255) NOT NULL,
    `count` BIGINT NOT NULL DEFAULT 1,
    `date` DATE NOT NULL,

    PRIMARY KEY (`link_id`, `name`, `value`, `date`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subscriber_fields` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `subscriber_id` INTEGER UNSIGNED NOT NULL,
    `field_id` INTEGER UNSIGNED NOT NULL,
    `value` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subscribers` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(50) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `subscribers_email_index`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subscription_items` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `subscription_id` BIGINT UNSIGNED NOT NULL,
    `stripe_id` VARCHAR(191) NOT NULL,
    `stripe_plan` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `subscription_items_stripe_id_index`(`stripe_id`),
    UNIQUE INDEX `subscription_items_subscription_id_stripe_plan_unique`(`subscription_id`, `stripe_plan`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subscriptions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `stripe_id` VARCHAR(191) NOT NULL,
    `stripe_status` VARCHAR(191) NOT NULL,
    `stripe_plan` VARCHAR(191) NULL,
    `quantity` INTEGER NULL,
    `trial_ends_at` TIMESTAMP(0) NULL,
    `ends_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `name`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `super_agencies` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `manager_agency_id` BIGINT UNSIGNED NOT NULL,
    `wallet_balance` DECIMAL(10, 2) NOT NULL DEFAULT 1.00,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `super_agencies_manager_agency_id_index`(`manager_agency_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `super_agency_wallet_transaction_details` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `wallet_transaction_id` BIGINT UNSIGNED NOT NULL,
    `transaction_id` VARCHAR(191) NULL,
    `gateway` VARCHAR(191) NULL,
    `payment_response` MEDIUMTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `super_agency_wallet_transaction_details_transaction_id_index`(`transaction_id`),
    INDEX `wallet_transaction_id`(`wallet_transaction_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `super_agency_wallet_transactions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `super_agency_id` BIGINT UNSIGNED NOT NULL,
    `transaction_type` VARCHAR(191) NOT NULL DEFAULT 'credit',
    `transaction_time` DATETIME(0) NOT NULL,
    `wallet_change` DECIMAL(8, 2) NOT NULL,
    `amount` DECIMAL(8, 2) NULL,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `related_agency_id` BIGINT UNSIGNED NULL,
    `extend_duration` INTEGER UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `super_agency_wallet_transactions_super_agency_id_index`(`super_agency_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `support_department_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(191) NOT NULL,
    `support_department_id` VARCHAR(191) NOT NULL,
    `lang` VARCHAR(10) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `support_department_languages_lang_index`(`lang`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `support_departments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `slug` VARCHAR(191) NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `supports` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `subject` VARCHAR(191) NOT NULL,
    `support_department_id` VARCHAR(191) NOT NULL,
    `priority` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `user_id` TINYINT NOT NULL,
    `ticket_id` LONGTEXT NOT NULL,
    `viewed` TINYINT NOT NULL DEFAULT 0,
    `client_viewed` TINYINT NOT NULL DEFAULT 0,
    `file` TEXT NULL,
    `ticket_body` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tags` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tasks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `opportunity_id` BIGINT UNSIGNED NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `assignee` BIGINT UNSIGNED NULL,
    `title` VARCHAR(191) NOT NULL,
    `description` TEXT NOT NULL,
    `due_date` TIMESTAMP(0) NOT NULL,
    `completed` BOOLEAN NOT NULL DEFAULT false,
    `completed_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `template_categories` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `templates` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` CHAR(36) NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `title` VARCHAR(191) NULL,
    `body` TEXT NULL,
    `type` VARCHAR(191) NULL,
    `status` INTEGER NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `archived_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `templates_uuid_unique`(`uuid`),
    INDEX `templates_archived_at_index`(`archived_at`),
    INDEX `templates_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `templates_categories` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `template_id` INTEGER UNSIGNED NOT NULL,
    `category_id` INTEGER UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `theme_options` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `options` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `throttle` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `type` VARCHAR(191) NOT NULL,
    `ip` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `throttle_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ticket_replays` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `ticket_id` LONGTEXT NOT NULL,
    `support_id` VARCHAR(191) NULL,
    `file` TEXT NULL,
    `file_id` VARCHAR(191) NULL,
    `replay` LONGTEXT NULL,
    `type` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `timelines` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `automation2_id` INTEGER UNSIGNED NOT NULL,
    `subscriber_id` BIGINT UNSIGNED NULL,
    `auto_trigger_id` INTEGER UNSIGNED NOT NULL,
    `activity` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `activity_type` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `timezones` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `country_code` VARCHAR(5) NOT NULL,
    `timezone` VARCHAR(191) NOT NULL,
    `gmt_offset` VARCHAR(8) NOT NULL,
    `dst_offset` VARCHAR(8) NOT NULL,
    `raw_offset` VARCHAR(8) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `todos` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `title` VARCHAR(191) NULL,
    `description` TEXT NULL,
    `date` DATE NULL,
    `related_to` VARCHAR(191) NULL,
    `related_id` BIGINT UNSIGNED NULL,
    `completed` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `user_type` VARCHAR(191) NOT NULL DEFAULT 'App\Models\User',

    INDEX `todos_date_index`(`date`),
    INDEX `todos_related_id_index`(`related_id`),
    INDEX `todos_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tracking_domains` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `customer_id` INTEGER UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `scheme` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tracking_logs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `runtime_message_id` VARCHAR(191) NULL,
    `message_id` VARCHAR(191) NULL,
    `customer_id` INTEGER UNSIGNED NOT NULL,
    `sending_server_id` BIGINT UNSIGNED NULL,
    `campaign_id` INTEGER UNSIGNED NOT NULL,
    `subscriber_id` INTEGER UNSIGNED NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `error` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `auto_trigger_id` INTEGER UNSIGNED NULL,
    `sub_account_id` INTEGER UNSIGNED NULL,
    `email_id` INTEGER UNSIGNED NULL,
    `is_read` BOOLEAN NOT NULL DEFAULT false,
    `read_from` VARCHAR(191) NULL,
    `read_ip` VARCHAR(191) NULL,
    `read_times` VARCHAR(191) NOT NULL DEFAULT '0',
    `is_clicked` BOOLEAN NOT NULL DEFAULT false,
    `clicked_from` VARCHAR(191) NULL,
    `clicked_ip` VARCHAR(191) NULL,
    `clicked_times` VARCHAR(191) NOT NULL DEFAULT '0',
    `is_skipped` BOOLEAN NOT NULL DEFAULT false,
    `is_bounced` BOOLEAN NOT NULL DEFAULT false,
    `is_replied` BOOLEAN NOT NULL DEFAULT false,
    `is_complained` BOOLEAN NOT NULL DEFAULT false,
    `reason` TEXT NULL,
    `is_unsubscribed` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `tracking_logs_runtime_message_id_unique`(`runtime_message_id`),
    UNIQUE INDEX `tracking_logs_message_id_unique`(`message_id`),
    INDEX `tracking_logs_auto_trigger_id_foreign`(`auto_trigger_id`),
    INDEX `tracking_logs_campaign_id_index`(`campaign_id`),
    INDEX `tracking_logs_created_at_status_customer_id_index`(`created_at`, `status`, `customer_id`),
    INDEX `tracking_logs_customer_id_index`(`customer_id`),
    INDEX `tracking_logs_email_id_index`(`email_id`),
    INDEX `tracking_logs_is_bounced_index`(`is_bounced`),
    INDEX `tracking_logs_is_clicked_index`(`is_clicked`),
    INDEX `tracking_logs_is_complained_index`(`is_complained`),
    INDEX `tracking_logs_is_read_index`(`is_read`),
    INDEX `tracking_logs_is_replied_index`(`is_replied`),
    INDEX `tracking_logs_is_skipped_index`(`is_skipped`),
    INDEX `tracking_logs_sub_account_id_index`(`sub_account_id`),
    INDEX `tracking_logs_subscriber_id_index`(`subscriber_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transcripts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `url` LONGTEXT NULL,
    `transcript` LONGTEXT NULL,
    `title` VARCHAR(191) NULL,
    `workbook` VARCHAR(191) NULL,
    `task` VARCHAR(191) NULL,
    `words` INTEGER NULL,
    `format` VARCHAR(191) NULL,
    `audio_type` VARCHAR(191) NULL,
    `description` VARCHAR(191) NULL,
    `storage` VARCHAR(191) NULL,
    `length` DECIMAL(15, 3) NULL,
    `plan_type` VARCHAR(191) NULL,
    `size` VARCHAR(191) NULL,
    `file_name` VARCHAR(191) NULL,
    `temp_name` VARCHAR(191) NULL,
    `expires_at` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `transcripts_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ui_conversations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `group_id` BIGINT NULL,
    `last_message_id` BIGINT UNSIGNED NULL,
    `last_message_content` VARCHAR(25) NULL,
    `last_message_channel` ENUM('email', 'whatsapp_sender', 'whatsapp_cloud', 'sms', 'instagram', 'live_chat') NULL,
    `last_message_time` TIMESTAMP(0) NULL,
    `unread_count` INTEGER NOT NULL DEFAULT 0,
    `starred` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `sent_type` ENUM('automatic', 'manual') NOT NULL DEFAULT 'automatic',
    `last_whatsapp_device_id` BIGINT UNSIGNED NULL,
    `is_pinned` BOOLEAN NOT NULL DEFAULT false,

    INDEX `ui_conversations_contact_id_foreign`(`contact_id`),
    INDEX `ui_conversations_group_id_index`(`group_id`),
    INDEX `ui_conversations_last_message_channel_index`(`last_message_channel`),
    INDEX `ui_conversations_last_message_id_index`(`last_message_id`),
    INDEX `ui_conversations_last_whatsapp_device_id_index`(`last_whatsapp_device_id`),
    INDEX `ui_conversations_sent_type_index`(`sent_type`),
    INDEX `ui_conversations_starred_index`(`starred`),
    INDEX `ui_conversations_unread_count_index`(`unread_count`),
    INDEX `ui_conversations_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ui_group_participants` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `group_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `role` ENUM('admin', 'member') NOT NULL DEFAULT 'member',
    `joined_at` TIMESTAMP(0) NULL,
    `left_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `ui_group_participants_contact_id_foreign`(`contact_id`),
    UNIQUE INDEX `ui_group_participants_group_id_contact_id_unique`(`group_id`, `contact_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ui_groups` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `members_count` INTEGER NOT NULL DEFAULT 0,
    `description` VARCHAR(191) NOT NULL,
    `restrict` BOOLEAN NOT NULL DEFAULT false,
    `announce` BOOLEAN NOT NULL DEFAULT false,
    `creator_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `device_id` BIGINT UNSIGNED NULL,
    `wa_group_id` VARCHAR(191) NULL,
    `response_raw` TEXT NULL,
    `invite_link` VARCHAR(191) NULL,

    INDEX `ui_groups_creator_id_index`(`creator_id`),
    INDEX `ui_groups_device_id_index`(`device_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ui_message_attachments` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `conversation_id` BIGINT UNSIGNED NOT NULL,
    `message_id` BIGINT UNSIGNED NOT NULL,
    `path` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `ui_message_attachments_conv_msg_index`(`conversation_id`, `message_id`),
    INDEX `ui_message_attachments_message_id_index`(`message_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ui_message_receipts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `message_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `status` ENUM('sent', 'delivered', 'read', 'failed', 'bounced', 'opened', 'clicked', 'skipped', 'opt-out') NOT NULL DEFAULT 'sent',
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ui_messages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `conversation_id` BIGINT UNSIGNED NOT NULL,
    `channel` ENUM('email', 'whatsapp_sender', 'whatsapp_cloud', 'sms', 'instagram', 'live_chat') NULL,
    `type` ENUM('text', 'image', 'video', 'document') NOT NULL DEFAULT 'text',
    `is_outgoing` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `content` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `status` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `status_reason` VARCHAR(191) NULL,
    `message_id` VARCHAR(255) NULL,
    `sent_by` BIGINT UNSIGNED NULL,

    INDEX `ui_messages_channel_index`(`channel`),
    INDEX `ui_messages_conversation_id_index`(`conversation_id`),
    INDEX `ui_messages_is_outgoing_index`(`is_outgoing`),
    INDEX `ui_messages_message_id_index`(`message_id`),
    INDEX `ui_messages_sent_by_index`(`sent_by`),
    INDEX `ui_messages_status_index`(`status`),
    INDEX `ui_messages_type_index`(`type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ui_scheduled_messages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `channel` VARCHAR(191) NOT NULL,
    `conversation_id` VARCHAR(191) NOT NULL,
    `raw_message` TEXT NOT NULL,
    `staff_id` BIGINT UNSIGNED NULL,
    `scheduled_at` DATETIME(0) NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `sent_at` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `ui_scheduled_messages_channel_index`(`channel`),
    INDEX `ui_scheduled_messages_conversation_id_index`(`conversation_id`),
    INDEX `ui_scheduled_messages_scheduled_at_index`(`scheduled_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `unsubscription_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `contact_id` BIGINT UNSIGNED NOT NULL,
    `message_id` VARCHAR(255) NULL,
    `reason` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `unsubscription_logs_contact_id_index`(`contact_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `uploads` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `session_id` VARCHAR(191) NOT NULL,
    `file_name` VARCHAR(191) NOT NULL,
    `total_chunks` INTEGER UNSIGNED NOT NULL,
    `uploaded_chunks` INTEGER UNSIGNED NOT NULL,
    `status` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `url_domains` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `index_page` VARCHAR(255) NULL,
    `not_found_page` VARCHAR(255) NULL,
    `user_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `name`(`name`),
    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `url_pages` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `footer` TINYINT NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `title`(`title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `url_settings` (
    `name` VARCHAR(128) NOT NULL,
    `value` TEXT NULL,

    PRIMARY KEY (`name`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_app_details` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `app_name` VARCHAR(191) NOT NULL,
    `lms_domain` VARCHAR(191) NULL,
    `accounts_domain` VARCHAR(191) NULL,
    `accounts_site_id` BIGINT UNSIGNED NULL,
    `accounts_verification_step` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `networking_domain` VARCHAR(191) NULL,
    `community_domain` VARCHAR(191) NULL,
    `community_api_secret` VARCHAR(191) NULL,
    `notification_api_key` VARCHAR(191) NULL,
    `notification_app_id` VARCHAR(191) NULL,
    `logo` TEXT NULL,
    `banner` TEXT NULL,
    `infinity_loader` TEXT NULL,
    `favicon` TEXT NULL,
    `icon_color` VARCHAR(191) NULL,
    `top_header_icon_color` VARCHAR(191) NULL,
    `sidebar_icon_color` VARCHAR(191) NULL,
    `primary_color` VARCHAR(191) NULL,
    `primary_color_dark` VARCHAR(191) NULL,
    `left_menu_bar_color` VARCHAR(191) NULL,
    `top_menu_bar_color` VARCHAR(191) NULL,
    `font_color` VARCHAR(191) NULL,
    `font_style` VARCHAR(191) NULL,
    `border_color` VARCHAR(191) NULL,
    `font_hover_color` VARCHAR(191) NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` TEXT NULL,
    `active` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_app_details_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_credit_transactions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `agency_id` BIGINT NOT NULL,
    `credits_purchased` BIGINT NOT NULL,
    `free_credit` BIGINT NOT NULL DEFAULT 0,
    `transaction_date` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `amount` DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    `transaction_id` VARCHAR(191) NULL,
    `gateway` VARCHAR(191) NULL,
    `payment_response` LONGTEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_credits` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `agency_id` BIGINT NOT NULL,
    `remaining_credits` DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_email_credit_usage_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `tracking_log_id` BIGINT UNSIGNED NOT NULL,
    `credit_usage` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_email_credits` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `credits` BIGINT UNSIGNED NOT NULL,
    `notify_low_credits` BOOLEAN NOT NULL DEFAULT false,
    `notify_warning_low_credits` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `user_email_credits_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_email_credits_purchase_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `transaction_id` VARCHAR(191) NULL,
    `gateway` VARCHAR(191) NULL,
    `credits` INTEGER UNSIGNED NOT NULL,
    `price` INTEGER UNSIGNED NOT NULL,
    `plan_type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `agency_plan_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_inactive_notifications` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `date` DATE NOT NULL,
    `inacitve_since_3_email` BOOLEAN NOT NULL DEFAULT false,
    `inacitve_since_6_email` BOOLEAN NOT NULL DEFAULT false,
    `inacitve_since_10_whatsapp` BOOLEAN NOT NULL DEFAULT false,
    `inacitve_since_15_email` BOOLEAN NOT NULL DEFAULT false,
    `inacitve_since_20_whatsapp` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_inactive_notifications_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_locking_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `locking_details` MEDIUMTEXT NULL,
    `is_reverted` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_locking_logs_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_preferences` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `dashboard_settings` MEDIUMTEXT NULL,
    `community_portal_settings` MEDIUMTEXT NULL,
    `community_default_page` VARCHAR(191) NULL,
    `phone_visibility_enabled` BOOLEAN NOT NULL DEFAULT false,
    `crm_view_type` BOOLEAN NOT NULL DEFAULT false,
    `crm_preview_fields` MEDIUMTEXT NULL,
    `crm_filters` MEDIUMTEXT NULL,
    `receive_course_access_emails` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_preferences_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_settings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `all_sub_accounts_access` BOOLEAN NOT NULL DEFAULT true,
    `all_white_label_access` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_settings_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_sms_credit_purchase_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `transaction_id` VARCHAR(191) NULL,
    `gateway` VARCHAR(191) NULL,
    `payment_response` TEXT NULL,
    `type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `credits` INTEGER UNSIGNED NOT NULL,
    `price` DECIMAL(6, 2) NOT NULL,
    `is_processed` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_sms_credit_purchase_logs_transaction_id_index`(`transaction_id`),
    INDEX `user_sms_credit_purchase_logs_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_socials` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `icon` VARCHAR(191) NOT NULL,
    `link` VARCHAR(191) NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_socials_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_subaccounts` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `subaccount_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `user_subaccounts_subaccount_id_index`(`subaccount_id`),
    INDEX `user_subaccounts_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(50) NULL,
    `phone` VARCHAR(20) NULL,
    `password` VARCHAR(191) NULL,
    `pin` SMALLINT UNSIGNED NULL,
    `permissions` TEXT NULL,
    `first_name` VARCHAR(50) NULL,
    `last_name` VARCHAR(50) NULL,
    `user_type` ENUM('admin', 'staff', 'seller', 'customer', 'delivery_hero', 'walk_in', 'seller_and_customer', 'seller_staff', 'sub_admin', 'affiliate') NOT NULL,
    `timezone` VARCHAR(255) NULL DEFAULT 'Asia/Calcutta',
    `country` VARCHAR(191) NOT NULL DEFAULT 'India',
    `country_code` CHAR(2) NOT NULL DEFAULT 'IN',
    `gender` VARCHAR(191) NULL DEFAULT 'male',
    `date_of_birth` DATE NULL,
    `status` TINYINT NOT NULL DEFAULT 1,
    `is_protected` BOOLEAN NOT NULL DEFAULT false,
    `last_status` TINYINT NULL,
    `uid` VARCHAR(191) NULL,
    `is_user_banned` TINYINT NOT NULL DEFAULT 0,
    `newsletter_enable` TINYINT NOT NULL DEFAULT 0,
    `otp` INTEGER NULL,
    `firebase_auth_id` VARCHAR(100) NULL,
    `notification_device_ids` MEDIUMTEXT NULL,
    `currency_id` VARCHAR(191) NULL DEFAULT '1',
    `lang_code` VARCHAR(191) NULL DEFAULT 'en',
    `is_password_set` TINYINT NOT NULL DEFAULT 1,
    `images` TEXT NULL,
    `socials` LONGTEXT NULL,
    `last_login` TIMESTAMP(0) NULL,
    `last_ip` VARCHAR(30) NULL,
    `last_password_change` TIMESTAMP(0) NULL,
    `image_id` BIGINT UNSIGNED NULL,
    `role_id` INTEGER UNSIGNED NULL,
    `pickup_hub_id` BIGINT UNSIGNED NULL,
    `balance` DOUBLE NULL,
    `identity_provider_access_token` TEXT NULL,
    `is_deleted` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `total_ai_messages` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `total_ai_messages_by_month` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `is_notification_sent` BOOLEAN NOT NULL DEFAULT false,
    `notification_sent_at` TIMESTAMP(0) NULL,
    `no_more_activation_message` BOOLEAN NOT NULL DEFAULT false,
    `switched_user_type` VARCHAR(191) NULL,
    `is_premium_user` BOOLEAN NOT NULL DEFAULT false,
    `white_label_domain` VARCHAR(191) NULL,
    `is_school_app` BOOLEAN NOT NULL DEFAULT false,
    `is_individual_school` BOOLEAN NOT NULL DEFAULT false,
    `school_app_domain` VARCHAR(191) NULL,
    `app_type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `staff_user_id` BIGINT UNSIGNED NULL,
    `agency_id` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `is_super_agency` BOOLEAN NOT NULL DEFAULT false,
    `sms_api_secret` VARCHAR(191) NULL,
    `my_operator_api_token` VARCHAR(255) NULL,
    `my_operator_company_id` VARCHAR(255) NULL,
    `my_operator_secret_token` VARCHAR(255) NULL,
    `my_operator_x_api_key` VARCHAR(255) NULL,
    `my_operator_user_id` VARCHAR(255) NULL,
    `my_operator_public_ivr_id` VARCHAR(191) NULL,
    `zoom_personal_meeting_url` VARCHAR(191) NULL,
    `assigned_staff_ids` JSON NULL,
    `stage_id` BIGINT UNSIGNED NULL,
    `ivr_pipeline` BIGINT UNSIGNED NULL,
    `tags` TEXT NULL,
    `is_pinned` BOOLEAN NOT NULL DEFAULT false,

    INDEX `users_agency_id_index`(`agency_id`),
    INDEX `users_email_phone_index`(`email`, `phone`),
    INDEX `users_id_user_type_index`(`id`, `user_type`),
    INDEX `users_is_super_agency_index`(`is_super_agency`),
    INDEX `users_pin_index`(`pin`),
    INDEX `users_timezone_index`(`timezone`),
    INDEX `users_user_type_index`(`user_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `utm_conversions` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `utm_visit_id` BIGINT UNSIGNED NOT NULL,
    `contact_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `conversion_type` VARCHAR(191) NOT NULL,
    `revenue` DECIMAL(10, 2) NULL,
    `conversion_data` JSON NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `utm_conversions_contact_id_index`(`contact_id`),
    INDEX `utm_conversions_user_id_index`(`user_id`),
    INDEX `utm_conversions_utm_visit_id_index`(`utm_visit_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `utm_visits` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `visitor_id` VARCHAR(191) NOT NULL,
    `session_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NULL,
    `event_type` VARCHAR(191) NOT NULL DEFAULT 'Page Visited',
    `source` VARCHAR(191) NULL,
    `utm_id` VARCHAR(191) NULL,
    `utm_source` VARCHAR(191) NULL,
    `utm_medium` VARCHAR(191) NULL,
    `utm_campaign` VARCHAR(191) NULL,
    `utm_term` VARCHAR(191) NULL,
    `utm_content` VARCHAR(191) NULL,
    `referrer` VARCHAR(191) NULL,
    `utl_link` VARCHAR(191) NULL,
    `visited_page` VARCHAR(191) NULL,
    `ip_address` VARCHAR(191) NULL,
    `user_agent` VARCHAR(191) NULL,
    `device_type` VARCHAR(191) NULL,
    `browser` VARCHAR(191) NULL,
    `os` VARCHAR(191) NULL,
    `country` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `time_spent` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `utm_visits_utm_source_utm_medium_utm_campaign_index`(`utm_source`, `utm_medium`, `utm_campaign`),
    INDEX `utm_visits_visitor_id_user_id_index`(`visitor_id`, `user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vat_taxes` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `vat_tax` VARCHAR(191) NOT NULL,
    `percentage` DOUBLE NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT '1',
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vendors` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `vendor_id` VARCHAR(191) NOT NULL,
    `enabled` BOOLEAN NOT NULL DEFAULT false,
    `cost` DOUBLE NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `video_shopping_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `video_shopping_id` BIGINT NOT NULL,
    `lang` VARCHAR(10) NOT NULL,
    `title` VARCHAR(191) NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `video_shopping_languages_lang_index`(`lang`),
    INDEX `video_shopping_languages_video_shopping_id_index`(`video_shopping_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `video_shoppings` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `slug` VARCHAR(100) NOT NULL,
    `user_id` BIGINT NOT NULL DEFAULT 1,
    `thumbnail_id` BIGINT NULL,
    `thumbnail` TEXT NULL,
    `style` VARCHAR(100) NOT NULL DEFAULT 'style_1',
    `video_type` VARCHAR(100) NULL,
    `video_url` TEXT NULL,
    `is_live` TINYINT NOT NULL DEFAULT 0,
    `status` TINYINT NOT NULL DEFAULT 1,
    `enable_related_product` TINYINT NOT NULL DEFAULT 1,
    `product_ids` VARCHAR(191) NULL,
    `total_viewed` BIGINT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `video_shoppings_slug_index`(`slug`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `visitor_analytics` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `analyzable_type` VARCHAR(191) NOT NULL,
    `analyzable_id` BIGINT UNSIGNED NOT NULL,
    `shop_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `period` VARCHAR(191) NOT NULL,
    `total_visitors` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `total_orders` BIGINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `visitor_analytics_analyzable_type_analyzable_id_index`(`analyzable_type`, `analyzable_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `voiceover_languages` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `language` VARCHAR(191) NOT NULL,
    `language_code` VARCHAR(191) NOT NULL,
    `language_flag` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `voiceover_languages_language_code_unique`(`language_code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `voiceover_results` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `language` VARCHAR(191) NOT NULL,
    `language_flag` VARCHAR(191) NULL,
    `voice` VARCHAR(191) NOT NULL,
    `voice_id` VARCHAR(191) NULL,
    `gender` VARCHAR(191) NULL,
    `text` LONGTEXT NULL,
    `text_raw` LONGTEXT NULL,
    `file_name` VARCHAR(191) NULL,
    `result_url` VARCHAR(191) NULL,
    `result_ext` VARCHAR(191) NULL,
    `storage` VARCHAR(191) NULL,
    `title` VARCHAR(191) NULL,
    `vendor` VARCHAR(191) NOT NULL,
    `vendor_id` VARCHAR(191) NULL,
    `characters` INTEGER NULL,
    `voice_type` VARCHAR(191) NOT NULL,
    `plan_type` VARCHAR(191) NOT NULL,
    `audio_type` VARCHAR(191) NULL,
    `mode` VARCHAR(191) NULL,
    `project` VARCHAR(191) NULL,
    `expires_at` DATETIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `voices` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `voice` VARCHAR(191) NOT NULL,
    `voice_id` VARCHAR(191) NOT NULL,
    `gender` VARCHAR(191) NOT NULL,
    `language_code` VARCHAR(191) NOT NULL,
    `vendor_id` VARCHAR(191) NOT NULL,
    `vendor` VARCHAR(191) NOT NULL,
    `vendor_img` VARCHAR(191) NOT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'active',
    `avatar_url` VARCHAR(191) NULL,
    `voice_type` VARCHAR(191) NOT NULL DEFAULT 'standard',
    `sample_url` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `wallets` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `order_id` BIGINT UNSIGNED NULL,
    `amount` DOUBLE NULL,
    `source` VARCHAR(191) NULL,
    `type` VARCHAR(191) NULL,
    `payment_method` VARCHAR(191) NULL,
    `payment_details` TEXT NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'pending',
    `transaction_id` VARCHAR(191) NULL,
    `image` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `webhook_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NULL,
    `payload` JSON NULL,
    `level` VARCHAR(191) NOT NULL DEFAULT 'info',
    `level_name` VARCHAR(191) NOT NULL DEFAULT 'INFO',
    `channel` VARCHAR(191) NOT NULL DEFAULT 'webhook',
    `status` ENUM('pending', 'processed', 'failed') NOT NULL DEFAULT 'pending',
    `failed_reason` TEXT NULL,
    `last_fired_at` TIMESTAMP(0) NULL,
    `fire_count` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `form_id` VARCHAR(191) NULL,
    `lead_id` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `webhook_logs_form_id_index`(`form_id`),
    INDEX `webhook_logs_lead_id_index`(`lead_id`),
    INDEX `webhook_logs_user_id_index`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `webinar` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `zoom_webinar_id` VARCHAR(191) NOT NULL,
    `uuid` VARCHAR(191) NULL,
    `topic` VARCHAR(191) NULL,
    `start_time` DATETIME(0) NULL,
    `duration` INTEGER NULL,
    `timezone` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `user_id` BIGINT UNSIGNED NULL,

    UNIQUE INDEX `webinar_zoom_webinar_id_unique`(`zoom_webinar_id`),
    INDEX `webinar_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `whats_app_message_logs` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `replied_to_whatsapp_message_logs_id` BIGINT NULL,
    `user_id` BIGINT NOT NULL,
    `contact_id` BIGINT NULL,
    `wamid` VARCHAR(191) NULL,
    `is_forwarded` BOOLEAN NULL DEFAULT false,
    `is_incoming_message` TINYINT NULL DEFAULT 1,
    `status` VARCHAR(191) NULL,
    `messaged_at` TIMESTAMP(0) NULL,
    `message` TEXT NULL,
    `wa_phone_number_id` TEXT NULL,
    `__data` JSON NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `type` VARCHAR(191) NULL,

    INDEX `idx_whatsapp_logs_status`(`status`),
    INDEX `idx_whatsapp_logs_wamid`(`wamid`),
    INDEX `idx_whatsapp_logs_wamid_status`(`wamid`, `status`),
    INDEX `whats_app_message_logs_contact_id_index`(`contact_id`),
    INDEX `whats_app_message_logs_status_index`(`status`),
    INDEX `whats_app_message_logs_type_index`(`type`),
    INDEX `whats_app_message_logs_user_id_index`(`user_id`),
    INDEX `whats_app_message_logs_wamid_index`(`wamid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `whatsapp_cloud_api` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `facebook_app_id` VARCHAR(191) NULL,
    `whatsapp_integration_access_token` TEXT NULL,
    `whatsapp_business_account_id` VARCHAR(191) NULL,
    `whatsapp_from_phone_number` VARCHAR(191) NULL,
    `whatsapp_from_phone_number_id` VARCHAR(191) NULL,
    `whatsapp_webhook_url` VARCHAR(191) NULL,
    `whatsapp_webhook_verify_token` VARCHAR(191) NULL,
    `deleted_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `webhook_verified_at` DATETIME(0) NULL,
    `isWebhookVerified` BOOLEAN NOT NULL DEFAULT false,
    `response_data` TEXT NULL,
    `registered_at` TIMESTAMP(0) NULL,

    INDEX `whatsapp_cloud_api_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `whatsapp_cloud_api_campaigns` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `campaign_name` VARCHAR(191) NOT NULL,
    `message_type` JSON NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `template_id` BIGINT UNSIGNED NULL,
    `email_template_id` BIGINT UNSIGNED NULL,
    `template_response` TEXT NULL,
    `schedule_date` DATE NULL,
    `schedule_time` TIME(0) NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `archived_at` TIMESTAMP(0) NULL,
    `status` VARCHAR(191) NOT NULL DEFAULT 'scheduled',
    `old_status` VARCHAR(191) NULL,
    `campaign_status` TEXT NULL,
    `last_sent_at` DATETIME(0) NULL,
    `attributes` JSON NULL,
    `sms_template_id` BIGINT UNSIGNED NULL,

    INDEX `whatsapp_cloud_api_campaigns_archived_at_index`(`archived_at`),
    INDEX `whatsapp_cloud_api_campaigns_sms_template_id_index`(`sms_template_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `whatsapp_templates` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uid` CHAR(36) NOT NULL,
    `cloud_api_id` BIGINT UNSIGNED NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `status` VARCHAR(15) NULL,
    `template_name` VARCHAR(255) NULL,
    `template_id` VARCHAR(45) NULL,
    `category` VARCHAR(45) NULL,
    `language` VARCHAR(45) NULL,
    `data` JSON NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `whatsapp_templates_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `wishlists` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `product_id` BIGINT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `workbooks` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `default` BOOLEAN NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `workbooks_user_id_foreign`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_workspaces` (
    `id` VARCHAR(191) NOT NULL,
    `agency_id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` TEXT NULL,
    `color` VARCHAR(20) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `updated_by` BIGINT UNSIGNED NULL,

    INDEX `tm_workspaces_agency_id_idx`(`agency_id`),
    INDEX `tm_workspaces_created_by_idx`(`created_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_workspace_members` (
    `workspace_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `role` ENUM('owner', 'admin', 'member') NOT NULL DEFAULT 'member',
    `joined_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `tm_workspace_members_user_id_idx`(`user_id`),
    PRIMARY KEY (`workspace_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_categories` (
    `id` VARCHAR(191) NOT NULL,
    `workspace_id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NULL,
    `color` VARCHAR(20) NULL,
    `icon` VARCHAR(50) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,

    INDEX `tm_categories_workspace_id_idx`(`workspace_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_tasks` (
    `id` VARCHAR(191) NOT NULL,
    `workspace_id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(500) NOT NULL,
    `description` TEXT NULL,
    `status` ENUM('TODO', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'TODO',
    `priority` ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT') NOT NULL DEFAULT 'MEDIUM',
    `dueDate` TIMESTAMP(0) NULL,
    `completedAt` TIMESTAMP(0) NULL,
    `category_id` VARCHAR(191) NULL,
    `parent_task_id` VARCHAR(191) NULL,
    `group_id` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `updated_by` BIGINT UNSIGNED NULL,

    INDEX `tm_tasks_workspace_id_idx`(`workspace_id`),
    INDEX `tm_tasks_category_id_idx`(`category_id`),
    INDEX `tm_tasks_created_by_idx`(`created_by`),
    INDEX `tm_tasks_group_id_idx`(`group_id`),
    INDEX `tm_tasks_parent_task_id_idx`(`parent_task_id`),
    INDEX `tm_tasks_status_idx`(`status`),
    INDEX `tm_tasks_priority_idx`(`priority`),
    INDEX `tm_tasks_dueDate_idx`(`dueDate`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_task_repeats` (
    `id` VARCHAR(191) NOT NULL,
    `task_id` VARCHAR(191) NULL,
    `interval` ENUM('DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY') NOT NULL,
    `startDate` DATE NOT NULL,
    `endDate` DATE NULL,
    `dayOfMonth` TINYINT NULL,
    `skipWeekends` BOOLEAN NOT NULL DEFAULT false,
    `occurrenceCount` INTEGER UNSIGNED NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,

    UNIQUE INDEX `tm_task_repeats_task_id_key`(`task_id`),
    INDEX `tm_task_repeats_task_id_idx`(`task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_repeat_days_of_week` (
    `id` VARCHAR(191) NOT NULL,
    `repeat_id` VARCHAR(191) NOT NULL,
    `dayOfWeek` TINYINT NOT NULL,

    INDEX `tm_repeat_days_of_week_repeat_id_idx`(`repeat_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_task_reminders` (
    `id` VARCHAR(191) NOT NULL,
    `task_id` VARCHAR(191) NOT NULL,
    `channel` ENUM('WHATSAPP', 'EMAIL', 'PUSH_NOTIFICATION', 'SMS') NOT NULL,
    `triggerType` ENUM('BEFORE', 'AFTER') NOT NULL,
    `triggerAt` TIMESTAMP(0) NOT NULL,
    `status` ENUM('PENDING', 'SENT', 'FAILED') NOT NULL DEFAULT 'PENDING',
    `reminderMessage` TEXT NULL,
    `retryCount` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `sentAt` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,

    INDEX `tm_task_reminders_task_id_idx`(`task_id`),
    INDEX `tm_task_reminders_status_idx`(`status`),
    INDEX `tm_task_reminders_triggerAt_idx`(`triggerAt`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_reminder_recipients` (
    `reminder_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,

    INDEX `tm_reminder_recipients_user_id_idx`(`user_id`),
    PRIMARY KEY (`reminder_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_task_attachments` (
    `id` VARCHAR(191) NOT NULL,
    `task_id` VARCHAR(191) NOT NULL,
    `fileUrl` TEXT NOT NULL,
    `fileName` VARCHAR(255) NOT NULL,
    `fileSize` BIGINT UNSIGNED NULL,
    `mimeType` VARCHAR(100) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `tm_task_attachments_task_id_idx`(`task_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_task_assignments` (
    `task_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,

    INDEX `tm_task_assignments_user_id_idx`(`user_id`),
    PRIMARY KEY (`task_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_task_loops` (
    `task_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,

    INDEX `tm_task_loops_user_id_idx`(`user_id`),
    PRIMARY KEY (`task_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_checklist_items` (
    `id` VARCHAR(191) NOT NULL,
    `task_id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(500) NOT NULL,
    `isCompleted` BOOLEAN NOT NULL DEFAULT false,
    `order` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,

    INDEX `tm_checklist_items_task_id_idx`(`task_id`),
    INDEX `tm_checklist_items_order_idx`(`order`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_task_comments` (
    `id` VARCHAR(191) NOT NULL,
    `task_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,

    INDEX `tm_task_comments_task_id_idx`(`task_id`),
    INDEX `tm_task_comments_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_task_history` (
    `id` VARCHAR(191) NOT NULL,
    `task_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `action` VARCHAR(100) NOT NULL,
    `field` VARCHAR(100) NULL,
    `oldValue` TEXT NULL,
    `newValue` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `tm_task_history_task_id_idx`(`task_id`),
    INDEX `tm_task_history_user_id_idx`(`user_id`),
    INDEX `tm_task_history_created_at_idx`(`created_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_task_templates` (
    `id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(500) NOT NULL,
    `description` TEXT NULL,
    `status` ENUM('TODO', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'TODO',
    `priority` ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT') NOT NULL DEFAULT 'MEDIUM',
    `category_id` VARCHAR(191) NULL,
    `repeat_id` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `updated_by` BIGINT UNSIGNED NULL,

    INDEX `tm_task_templates_category_id_idx`(`category_id`),
    INDEX `tm_task_templates_repeat_id_idx`(`repeat_id`),
    INDEX `tm_task_templates_created_by_idx`(`created_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_template_checklist_items` (
    `id` VARCHAR(191) NOT NULL,
    `template_id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(500) NOT NULL,
    `order` INTEGER UNSIGNED NOT NULL DEFAULT 0,

    INDEX `tm_template_checklist_items_template_id_idx`(`template_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_template_attachments` (
    `id` VARCHAR(191) NOT NULL,
    `template_id` VARCHAR(191) NOT NULL,
    `fileUrl` TEXT NOT NULL,
    `fileName` VARCHAR(255) NOT NULL,

    INDEX `tm_template_attachments_template_id_idx`(`template_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_task_groups` (
    `id` VARCHAR(191) NOT NULL,
    `workspace_id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `status` ENUM('ACTIVE', 'INACTIVE', 'ARCHIVED') NOT NULL DEFAULT 'ACTIVE',
    `type` ENUM('PRIVATE', 'PUBLIC') NOT NULL DEFAULT 'PUBLIC',
    `groupImage` TEXT NULL,
    `color` VARCHAR(20) NULL,
    `icon` VARCHAR(50) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `updated_by` BIGINT UNSIGNED NULL,

    INDEX `tm_task_groups_workspace_id_idx`(`workspace_id`),
    INDEX `tm_task_groups_created_by_idx`(`created_by`),
    INDEX `tm_task_groups_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_group_memberships` (
    `group_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,

    INDEX `tm_group_memberships_user_id_idx`(`user_id`),
    PRIMARY KEY (`group_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_idea_boards` (
    `id` VARCHAR(191) NOT NULL,
    `workspace_id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `coverImage` TEXT NULL,
    `status` VARCHAR(50) NOT NULL DEFAULT 'active',
    `isPublic` BOOLEAN NOT NULL DEFAULT false,
    `category_id` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `updated_by` BIGINT UNSIGNED NULL,

    INDEX `tm_idea_boards_workspace_id_idx`(`workspace_id`),
    INDEX `tm_idea_boards_category_id_idx`(`category_id`),
    INDEX `tm_idea_boards_created_by_idx`(`created_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_board_access` (
    `board_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,

    INDEX `tm_board_access_user_id_idx`(`user_id`),
    PRIMARY KEY (`board_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_board_tags` (
    `id` VARCHAR(191) NOT NULL,
    `board_id` VARCHAR(191) NOT NULL,
    `tag` VARCHAR(100) NOT NULL,

    INDEX `tm_board_tags_board_id_idx`(`board_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_ideas` (
    `id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(500) NOT NULL,
    `description` TEXT NULL,
    `board_id` VARCHAR(191) NOT NULL,
    `status` ENUM('DRAFT', 'ACTIVE', 'UNDER_REVIEW', 'APPROVED', 'IMPLEMENTED', 'REJECTED', 'ARCHIVED') NOT NULL DEFAULT 'DRAFT',
    `upvotes` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `updated_by` BIGINT UNSIGNED NULL,

    INDEX `tm_ideas_board_id_idx`(`board_id`),
    INDEX `tm_ideas_created_by_idx`(`created_by`),
    INDEX `tm_ideas_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_idea_attachments` (
    `id` VARCHAR(191) NOT NULL,
    `idea_id` VARCHAR(191) NOT NULL,
    `fileUrl` TEXT NOT NULL,
    `fileName` VARCHAR(255) NOT NULL,
    `fileSize` BIGINT UNSIGNED NULL,
    `mimeType` VARCHAR(100) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `tm_idea_attachments_idea_id_idx`(`idea_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_idea_tags` (
    `id` VARCHAR(191) NOT NULL,
    `idea_id` VARCHAR(191) NOT NULL,
    `tag` VARCHAR(100) NOT NULL,

    INDEX `tm_idea_tags_idea_id_idx`(`idea_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_idea_comments` (
    `id` VARCHAR(191) NOT NULL,
    `idea_id` VARCHAR(191) NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `content` TEXT NOT NULL,
    `parent_id` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,

    INDEX `tm_idea_comments_idea_id_idx`(`idea_id`),
    INDEX `tm_idea_comments_user_id_idx`(`user_id`),
    INDEX `tm_idea_comments_parent_id_idx`(`parent_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tm_links` (
    `id` VARCHAR(191) NOT NULL,
    `workspace_id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `url` TEXT NOT NULL,
    `category_id` VARCHAR(191) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL,
    `created_by` BIGINT UNSIGNED NOT NULL,
    `updated_by` BIGINT UNSIGNED NULL,

    INDEX `tm_links_workspace_id_idx`(`workspace_id`),
    INDEX `tm_links_category_id_idx`(`category_id`),
    INDEX `tm_links_created_by_idx`(`created_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `admin_chat_support` ADD CONSTRAINT `admin_chat_support_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `affiliate_clicks` ADD CONSTRAINT `affiliate_clicks_affiliate_id_foreign` FOREIGN KEY (`affiliate_id`) REFERENCES `affiliates`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `affiliate_clicks` ADD CONSTRAINT `affiliate_clicks_package_id_foreign` FOREIGN KEY (`package_id`) REFERENCES `packages`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `agency_affiliate_settings` ADD CONSTRAINT `agency_affiliate_settings_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agencies`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `agency_affiliate_settings` ADD CONSTRAINT `agency_affiliate_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `agency_cancellations` ADD CONSTRAINT `agency_cancellations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `agency_plans` ADD CONSTRAINT `agency_plans_snapshot_id_foreign` FOREIGN KEY (`snapshot_id`) REFERENCES `snapshots`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `announcement_banner_analytics` ADD CONSTRAINT `announcement_banner_analytics_banner_id_foreign` FOREIGN KEY (`banner_id`) REFERENCES `announcement_banners`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `announcement_banner_analytics` ADD CONSTRAINT `announcement_banner_analytics_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `announcement_banner_dismissals` ADD CONSTRAINT `announcement_banner_dismissals_banner_id_foreign` FOREIGN KEY (`banner_id`) REFERENCES `announcement_banners`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `announcement_banner_dismissals` ADD CONSTRAINT `announcement_banner_dismissals_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `app_store` ADD CONSTRAINT `app_store_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `automation2_versions` ADD CONSTRAINT `automation2_versions_automation2_id_foreign` FOREIGN KEY (`automation2_id`) REFERENCES `automation2s`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `automation_overdue_configs` ADD CONSTRAINT `automation_overdue_configs_automation_id_foreign` FOREIGN KEY (`automation_id`) REFERENCES `automation2s`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `bulk_operation_entries` ADD CONSTRAINT `bulk_operation_entries_batch_id_foreign` FOREIGN KEY (`batch_id`) REFERENCES `batches`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `bulk_operation_entries` ADD CONSTRAINT `bulk_operation_entries_bulk_operation_id_foreign` FOREIGN KEY (`bulk_operation_id`) REFERENCES `bulk_operations`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `bulk_operations` ADD CONSTRAINT `bulk_operations_server_side_event_id_foreign` FOREIGN KEY (`server_side_event_id`) REFERENCES `server_side_events`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `bulk_operations` ADD CONSTRAINT `bulk_operations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `chat_widgets` ADD CONSTRAINT `chat_widgets_assigned_user_id_foreign` FOREIGN KEY (`assigned_user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `chat_widgets` ADD CONSTRAINT `chat_widgets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_announcements` ADD CONSTRAINT `community_announcements_community_owner_id_foreign` FOREIGN KEY (`community_owner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_channel_criteria` ADD CONSTRAINT `community_channel_criteria_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `community_channels`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_channels` ADD CONSTRAINT `community_channels_community_owner_id_foreign` FOREIGN KEY (`community_owner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_chat_inboxes` ADD CONSTRAINT `community_chat_inboxes_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `contacts`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_custom_links` ADD CONSTRAINT `community_custom_links_community_owner_id_foreign` FOREIGN KEY (`community_owner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_follows` ADD CONSTRAINT `community_follows_community_owner_id_foreign` FOREIGN KEY (`community_owner_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_follows` ADD CONSTRAINT `community_follows_follower_id_foreign` FOREIGN KEY (`follower_id`) REFERENCES `contacts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_follows` ADD CONSTRAINT `community_follows_following_id_foreign` FOREIGN KEY (`following_id`) REFERENCES `contacts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_group_members` ADD CONSTRAINT `community_group_members_activity_by_foreign` FOREIGN KEY (`activity_by`) REFERENCES `contacts`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_group_members` ADD CONSTRAINT `community_group_members_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `community_groups`(`uuid`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_group_members` ADD CONSTRAINT `community_group_members_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `contacts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_group_members` ADD CONSTRAINT `community_group_members_removed_by_foreign` FOREIGN KEY (`removed_by`) REFERENCES `contacts`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_groups` ADD CONSTRAINT `community_groups_community_owner_id_foreign` FOREIGN KEY (`community_owner_id`) REFERENCES `users`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_groups` ADD CONSTRAINT `community_groups_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `contacts`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_groups` ADD CONSTRAINT `community_groups_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `contacts`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_post_reports` ADD CONSTRAINT `community_post_reports_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `community_posts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `community_post_reports` ADD CONSTRAINT `community_post_reports_reporter_id_foreign` FOREIGN KEY (`reporter_id`) REFERENCES `contacts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `contact_documents` ADD CONSTRAINT `contact_documents_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `contact_documents` ADD CONSTRAINT `contact_documents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `contact_tag` ADD CONSTRAINT `contact_tag_note_id_foreign` FOREIGN KEY (`note_id`) REFERENCES `notes`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `crm_quick_filters` ADD CONSTRAINT `crm_quick_filters_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `custom_menu_users` ADD CONSTRAINT `custom_menu_users_custom_menu_id_foreign` FOREIGN KEY (`custom_menu_id`) REFERENCES `custom_menus`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `custom_menu_users` ADD CONSTRAINT `custom_menu_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `custom_menus` ADD CONSTRAINT `custom_menus_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agencies`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `email_server_configs` ADD CONSTRAINT `email_server_configs_agency_id_foreign` FOREIGN KEY (`agency_id`) REFERENCES `agencies`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `email_server_configs` ADD CONSTRAINT `email_server_configs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `event_type_locations` ADD CONSTRAINT `event_type_locations_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `event_type_staff_details` ADD CONSTRAINT `event_type_staff_details_event_type_id_foreign` FOREIGN KEY (`event_type_id`) REFERENCES `event_types`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `event_type_staff_details` ADD CONSTRAINT `event_type_staff_details_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `events` ADD CONSTRAINT `events_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `folderables` ADD CONSTRAINT `folderables_folder_id_foreign` FOREIGN KEY (`folder_id`) REFERENCES `folders`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `folders` ADD CONSTRAINT `folders_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `folders`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `folders` ADD CONSTRAINT `folders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `funnel_folders` ADD CONSTRAINT `funnel_folders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `funnel_prebuilds` ADD CONSTRAINT `funnel_prebuilds_automation_id_foreign` FOREIGN KEY (`automation_id`) REFERENCES `automation2s`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `funnel_prebuilds` ADD CONSTRAINT `funnel_prebuilds_email_template_id_foreign` FOREIGN KEY (`email_template_id`) REFERENCES `acelle_templates`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `funnel_prebuilds` ADD CONSTRAINT `funnel_prebuilds_pipeline_id_foreign` FOREIGN KEY (`pipeline_id`) REFERENCES `pipelines`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `funnel_prebuilds` ADD CONSTRAINT `funnel_prebuilds_whatsapp_template_id_foreign` FOREIGN KEY (`whatsapp_template_id`) REFERENCES `templates`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ingestion_events` ADD CONSTRAINT `ingestion_events_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `knowledge_items`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ingestion_events` ADD CONSTRAINT `ingestion_events_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `instagram_webhook_logs` ADD CONSTRAINT `instagram_webhook_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `integrations` ADD CONSTRAINT `integrations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ivr_form` ADD CONSTRAINT `ivr_form_custom_field_id_foreign` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_fields`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `knowledge_items` ADD CONSTRAINT `knowledge_items_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `landing_page_funnels` ADD CONSTRAINT `landing_page_funnels_folder_id_foreign` FOREIGN KEY (`folder_id`) REFERENCES `funnel_folders`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `landing_page_versions` ADD CONSTRAINT `landing_page_versions_landing_page_id_foreign` FOREIGN KEY (`landing_page_id`) REFERENCES `landing_pages`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `landing_page_versions` ADD CONSTRAINT `landing_page_versions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `llm_models` ADD CONSTRAINT `llm_models_llm_provider_id_foreign` FOREIGN KEY (`llm_provider_id`) REFERENCES `llm_providers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `llm_providers` ADD CONSTRAINT `llm_providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `media_conversion_logs` ADD CONSTRAINT `media_conversion_logs_media_id_foreign` FOREIGN KEY (`media_id`) REFERENCES `media`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `module_items` ADD CONSTRAINT `module_items_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `modules`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `module_items` ADD CONSTRAINT `module_items_snapshot_id_foreign` FOREIGN KEY (`snapshot_id`) REFERENCES `snapshots`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_assignees` ADD CONSTRAINT `pr_assignees_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `pr_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_assignees` ADD CONSTRAINT `pr_assignees_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_backgrounds` ADD CONSTRAINT `pr_backgrounds_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_board_lists` ADD CONSTRAINT `pr_board_lists_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `pr_projects`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_board_lists` ADD CONSTRAINT `pr_board_lists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_check_lists` ADD CONSTRAINT `pr_check_lists_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `pr_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_comments` ADD CONSTRAINT `pr_comments_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `pr_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_comments` ADD CONSTRAINT `pr_comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_labels` ADD CONSTRAINT `pr_labels_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_projects` ADD CONSTRAINT `pr_projects_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_projects` ADD CONSTRAINT `pr_projects_workspace_id_foreign` FOREIGN KEY (`workspace_id`) REFERENCES `pr_workspaces`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_recent_projects` ADD CONSTRAINT `pr_recent_projects_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `pr_projects`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_recent_projects` ADD CONSTRAINT `pr_recent_projects_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_settings` ADD CONSTRAINT `pr_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_starred_projects` ADD CONSTRAINT `pr_starred_projects_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `pr_projects`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_starred_projects` ADD CONSTRAINT `pr_starred_projects_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_task_labels` ADD CONSTRAINT `pr_task_labels_label_id_foreign` FOREIGN KEY (`label_id`) REFERENCES `pr_labels`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_task_labels` ADD CONSTRAINT `pr_task_labels_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `pr_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_tasks` ADD CONSTRAINT `pr_tasks_list_id_foreign` FOREIGN KEY (`list_id`) REFERENCES `pr_board_lists`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_tasks` ADD CONSTRAINT `pr_tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `pr_projects`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_tasks` ADD CONSTRAINT `pr_tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_team_members` ADD CONSTRAINT `pr_team_members_added_by_foreign` FOREIGN KEY (`added_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_team_members` ADD CONSTRAINT `pr_team_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_team_members` ADD CONSTRAINT `pr_team_members_workspace_id_foreign` FOREIGN KEY (`workspace_id`) REFERENCES `pr_workspaces`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_timers` ADD CONSTRAINT `pr_timers_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `pr_tasks`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_timers` ADD CONSTRAINT `pr_timers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_workspace_types` ADD CONSTRAINT `pr_workspace_types_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_workspaces` ADD CONSTRAINT `pr_workspaces_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `pr_workspace_types`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pr_workspaces` ADD CONSTRAINT `pr_workspaces_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `replicate_histories` ADD CONSTRAINT `replicate_histories_snapshot_id_foreign` FOREIGN KEY (`snapshot_id`) REFERENCES `snapshots`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `replicate_histories` ADD CONSTRAINT `replicate_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `seller_ai_staff_permissions` ADD CONSTRAINT `seller_ai_staff_permissions_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `seller_staffs`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `seller_ai_staff_permissions` ADD CONSTRAINT `seller_ai_staff_permissions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `server_side_events` ADD CONSTRAINT `server_side_events_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `snapshot_subaccounts` ADD CONSTRAINT `snapshot_subaccounts_snapshot_id_foreign` FOREIGN KEY (`snapshot_id`) REFERENCES `snapshots`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `staff_devices` ADD CONSTRAINT `staff_devices_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `staff_devices` ADD CONSTRAINT `staff_devices_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `templates` ADD CONSTRAINT `templates_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `todos` ADD CONSTRAINT `todos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tracking_logs` ADD CONSTRAINT `tracking_logs_auto_trigger_id_foreign` FOREIGN KEY (`auto_trigger_id`) REFERENCES `auto_triggers`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `transcripts` ADD CONSTRAINT `transcripts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ui_conversations` ADD CONSTRAINT `ui_conversations_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ui_conversations` ADD CONSTRAINT `ui_conversations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ui_group_participants` ADD CONSTRAINT `ui_group_participants_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ui_group_participants` ADD CONSTRAINT `ui_group_participants_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `ui_groups`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ui_groups` ADD CONSTRAINT `ui_groups_creator_id_foreign` FOREIGN KEY (`creator_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_app_details` ADD CONSTRAINT `user_app_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_locking_logs` ADD CONSTRAINT `user_locking_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_preferences` ADD CONSTRAINT `user_preferences_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_settings` ADD CONSTRAINT `user_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_sms_credit_purchase_logs` ADD CONSTRAINT `user_sms_credit_purchase_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_socials` ADD CONSTRAINT `user_socials_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_subaccounts` ADD CONSTRAINT `user_subaccounts_subaccount_id_foreign` FOREIGN KEY (`subaccount_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_subaccounts` ADD CONSTRAINT `user_subaccounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `utm_conversions` ADD CONSTRAINT `utm_conversions_utm_visit_id_foreign` FOREIGN KEY (`utm_visit_id`) REFERENCES `utm_visits`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `webhook_logs` ADD CONSTRAINT `webhook_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `webinar` ADD CONSTRAINT `webinar_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `whatsapp_cloud_api` ADD CONSTRAINT `whatsapp_cloud_api_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `whatsapp_templates` ADD CONSTRAINT `whatsapp_templates_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `workbooks` ADD CONSTRAINT `workbooks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tm_workspaces` ADD CONSTRAINT `tm_workspaces_agency_id_fkey` FOREIGN KEY (`agency_id`) REFERENCES `agencies`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_workspaces` ADD CONSTRAINT `tm_workspaces_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_workspaces` ADD CONSTRAINT `tm_workspaces_updated_by_fkey` FOREIGN KEY (`updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_workspace_members` ADD CONSTRAINT `tm_workspace_members_workspace_id_fkey` FOREIGN KEY (`workspace_id`) REFERENCES `tm_workspaces`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_workspace_members` ADD CONSTRAINT `tm_workspace_members_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_categories` ADD CONSTRAINT `tm_categories_workspace_id_fkey` FOREIGN KEY (`workspace_id`) REFERENCES `tm_workspaces`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_tasks` ADD CONSTRAINT `tm_tasks_workspace_id_fkey` FOREIGN KEY (`workspace_id`) REFERENCES `tm_workspaces`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_tasks` ADD CONSTRAINT `tm_tasks_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `tm_categories`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_tasks` ADD CONSTRAINT `tm_tasks_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_tasks` ADD CONSTRAINT `tm_tasks_updated_by_fkey` FOREIGN KEY (`updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_tasks` ADD CONSTRAINT `tm_tasks_parent_task_id_fkey` FOREIGN KEY (`parent_task_id`) REFERENCES `tm_tasks`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tm_tasks` ADD CONSTRAINT `tm_tasks_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `tm_task_groups`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_repeats` ADD CONSTRAINT `tm_task_repeats_task_id_fkey` FOREIGN KEY (`task_id`) REFERENCES `tm_tasks`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_repeat_days_of_week` ADD CONSTRAINT `tm_repeat_days_of_week_repeat_id_fkey` FOREIGN KEY (`repeat_id`) REFERENCES `tm_task_repeats`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_reminders` ADD CONSTRAINT `tm_task_reminders_task_id_fkey` FOREIGN KEY (`task_id`) REFERENCES `tm_tasks`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_reminder_recipients` ADD CONSTRAINT `tm_reminder_recipients_reminder_id_fkey` FOREIGN KEY (`reminder_id`) REFERENCES `tm_task_reminders`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_reminder_recipients` ADD CONSTRAINT `tm_reminder_recipients_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_attachments` ADD CONSTRAINT `tm_task_attachments_task_id_fkey` FOREIGN KEY (`task_id`) REFERENCES `tm_tasks`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_assignments` ADD CONSTRAINT `tm_task_assignments_task_id_fkey` FOREIGN KEY (`task_id`) REFERENCES `tm_tasks`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_assignments` ADD CONSTRAINT `tm_task_assignments_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_loops` ADD CONSTRAINT `tm_task_loops_task_id_fkey` FOREIGN KEY (`task_id`) REFERENCES `tm_tasks`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_loops` ADD CONSTRAINT `tm_task_loops_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_checklist_items` ADD CONSTRAINT `tm_checklist_items_task_id_fkey` FOREIGN KEY (`task_id`) REFERENCES `tm_tasks`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_comments` ADD CONSTRAINT `tm_task_comments_task_id_fkey` FOREIGN KEY (`task_id`) REFERENCES `tm_tasks`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_comments` ADD CONSTRAINT `tm_task_comments_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_history` ADD CONSTRAINT `tm_task_history_task_id_fkey` FOREIGN KEY (`task_id`) REFERENCES `tm_tasks`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_history` ADD CONSTRAINT `tm_task_history_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_templates` ADD CONSTRAINT `tm_task_templates_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `tm_categories`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_templates` ADD CONSTRAINT `tm_task_templates_repeat_id_fkey` FOREIGN KEY (`repeat_id`) REFERENCES `tm_task_repeats`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_templates` ADD CONSTRAINT `tm_task_templates_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_templates` ADD CONSTRAINT `tm_task_templates_updated_by_fkey` FOREIGN KEY (`updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_template_checklist_items` ADD CONSTRAINT `tm_template_checklist_items_template_id_fkey` FOREIGN KEY (`template_id`) REFERENCES `tm_task_templates`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_template_attachments` ADD CONSTRAINT `tm_template_attachments_template_id_fkey` FOREIGN KEY (`template_id`) REFERENCES `tm_task_templates`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_groups` ADD CONSTRAINT `tm_task_groups_workspace_id_fkey` FOREIGN KEY (`workspace_id`) REFERENCES `tm_workspaces`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_groups` ADD CONSTRAINT `tm_task_groups_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_task_groups` ADD CONSTRAINT `tm_task_groups_updated_by_fkey` FOREIGN KEY (`updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_group_memberships` ADD CONSTRAINT `tm_group_memberships_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `tm_task_groups`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_group_memberships` ADD CONSTRAINT `tm_group_memberships_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_idea_boards` ADD CONSTRAINT `tm_idea_boards_workspace_id_fkey` FOREIGN KEY (`workspace_id`) REFERENCES `tm_workspaces`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_idea_boards` ADD CONSTRAINT `tm_idea_boards_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `tm_categories`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_idea_boards` ADD CONSTRAINT `tm_idea_boards_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_idea_boards` ADD CONSTRAINT `tm_idea_boards_updated_by_fkey` FOREIGN KEY (`updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_board_access` ADD CONSTRAINT `tm_board_access_board_id_fkey` FOREIGN KEY (`board_id`) REFERENCES `tm_idea_boards`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_board_access` ADD CONSTRAINT `tm_board_access_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_board_tags` ADD CONSTRAINT `tm_board_tags_board_id_fkey` FOREIGN KEY (`board_id`) REFERENCES `tm_idea_boards`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_ideas` ADD CONSTRAINT `tm_ideas_board_id_fkey` FOREIGN KEY (`board_id`) REFERENCES `tm_idea_boards`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_ideas` ADD CONSTRAINT `tm_ideas_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_ideas` ADD CONSTRAINT `tm_ideas_updated_by_fkey` FOREIGN KEY (`updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_idea_attachments` ADD CONSTRAINT `tm_idea_attachments_idea_id_fkey` FOREIGN KEY (`idea_id`) REFERENCES `tm_ideas`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_idea_tags` ADD CONSTRAINT `tm_idea_tags_idea_id_fkey` FOREIGN KEY (`idea_id`) REFERENCES `tm_ideas`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_idea_comments` ADD CONSTRAINT `tm_idea_comments_idea_id_fkey` FOREIGN KEY (`idea_id`) REFERENCES `tm_ideas`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_idea_comments` ADD CONSTRAINT `tm_idea_comments_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_idea_comments` ADD CONSTRAINT `tm_idea_comments_parent_id_fkey` FOREIGN KEY (`parent_id`) REFERENCES `tm_idea_comments`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `tm_links` ADD CONSTRAINT `tm_links_workspace_id_fkey` FOREIGN KEY (`workspace_id`) REFERENCES `tm_workspaces`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_links` ADD CONSTRAINT `tm_links_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `tm_categories`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_links` ADD CONSTRAINT `tm_links_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `tm_links` ADD CONSTRAINT `tm_links_updated_by_fkey` FOREIGN KEY (`updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
