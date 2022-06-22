-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               8.0.28 - MySQL Community Server - GPL
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Дамп структуры базы данных faifly
CREATE DATABASE IF NOT EXISTS `faifly` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `faifly`;

-- Дамп структуры для таблица faifly.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_booking
CREATE TABLE IF NOT EXISTS `workersbooking_booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `proc_name` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `starting_date` date NOT NULL,
  `finish_date` date NOT NULL,
  `starting_time` time(6) NOT NULL,
  `finish_time` time(6) NOT NULL,
  `master_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workersbooking_booki_master_id_cd72f43e_fk_workersbo` (`master_id`),
  CONSTRAINT `workersbooking_booki_master_id_cd72f43e_fk_workersbo` FOREIGN KEY (`master_id`) REFERENCES `workersbooking_workers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_location
CREATE TABLE IF NOT EXISTS `workersbooking_location` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_schedules
CREATE TABLE IF NOT EXISTS `workersbooking_schedules` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_work_start` date NOT NULL,
  `date_work_finish` date NOT NULL,
  `time_start` time(6) NOT NULL,
  `time_finish` time(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_specialities
CREATE TABLE IF NOT EXISTS `workersbooking_specialities` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_workers
CREATE TABLE IF NOT EXISTS `workersbooking_workers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location_id` bigint DEFAULT NULL,
  `speciality_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workersbooking_worke_speciality_id_19e694b0_fk_workersbo` (`speciality_id`),
  KEY `workersbooking_worke_location_id_5881bc44_fk_workersbo` (`location_id`),
  CONSTRAINT `workersbooking_worke_location_id_5881bc44_fk_workersbo` FOREIGN KEY (`location_id`) REFERENCES `workersbooking_location` (`id`),
  CONSTRAINT `workersbooking_worke_speciality_id_19e694b0_fk_workersbo` FOREIGN KEY (`speciality_id`) REFERENCES `workersbooking_specialities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_workers_schedule
CREATE TABLE IF NOT EXISTS `workersbooking_workers_schedule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `workers_id` bigint NOT NULL,
  `schedules_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `workersbooking_workers_w_workers_id_schedules_id_fd39126f_uniq` (`workers_id`,`schedules_id`),
  KEY `workersbooking_worke_schedules_id_9faaa83e_fk_workersbo` (`schedules_id`),
  CONSTRAINT `workersbooking_worke_schedules_id_9faaa83e_fk_workersbo` FOREIGN KEY (`schedules_id`) REFERENCES `workersbooking_schedules` (`id`),
  CONSTRAINT `workersbooking_worke_workers_id_663e3e62_fk_workersbo` FOREIGN KEY (`workers_id`) REFERENCES `workersbooking_workers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
