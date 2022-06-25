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

-- Дамп структуры для таблица faifly.workersbooking_booking
CREATE TABLE IF NOT EXISTS `workersbooking_booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `proc_name` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `starting_datetime` datetime(6) NOT NULL,
  `finish_datetime` datetime(6) NOT NULL,
  `master_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workersbooking_booki_master_id_cd72f43e_fk_workersbo` (`master_id`),
  CONSTRAINT `workersbooking_booki_master_id_cd72f43e_fk_workersbo` FOREIGN KEY (`master_id`) REFERENCES `workersbooking_workers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_every_schedule
CREATE TABLE IF NOT EXISTS `workersbooking_every_schedule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_every_schedule_schedule_list
CREATE TABLE IF NOT EXISTS `workersbooking_every_schedule_schedule_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `every_schedule_id` bigint NOT NULL,
  `schedules_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `workersbooking_every_sch_every_schedule_id_schedu_f6e7a32c_uniq` (`every_schedule_id`,`schedules_id`),
  KEY `workersbooking_every_schedules_id_de6e4de6_fk_workersbo` (`schedules_id`),
  CONSTRAINT `workersbooking_every_every_schedule_id_b49e7157_fk_workersbo` FOREIGN KEY (`every_schedule_id`) REFERENCES `workersbooking_every_schedule` (`id`),
  CONSTRAINT `workersbooking_every_schedules_id_de6e4de6_fk_workersbo` FOREIGN KEY (`schedules_id`) REFERENCES `workersbooking_schedules` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_location
CREATE TABLE IF NOT EXISTS `workersbooking_location` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_schedules
CREATE TABLE IF NOT EXISTS `workersbooking_schedules` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `starting_datetime` datetime(6) NOT NULL,
  `finish_datetime` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_specialities
CREATE TABLE IF NOT EXISTS `workersbooking_specialities` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workersbooking_specialities_slug_5248f5a3` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

-- Дамп структуры для таблица faifly.workersbooking_workers
CREATE TABLE IF NOT EXISTS `workersbooking_workers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `location_id` bigint DEFAULT NULL,
  `speciality_id` bigint DEFAULT NULL,
  `schedule_work_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `schedule_work_id` (`schedule_work_id`),
  KEY `workersbooking_worke_location_id_5881bc44_fk_workersbo` (`location_id`),
  KEY `workersbooking_worke_speciality_id_19e694b0_fk_workersbo` (`speciality_id`),
  CONSTRAINT `workersbooking_worke_location_id_5881bc44_fk_workersbo` FOREIGN KEY (`location_id`) REFERENCES `workersbooking_location` (`id`),
  CONSTRAINT `workersbooking_worke_schedule_work_id_6b490c75_fk_workersbo` FOREIGN KEY (`schedule_work_id`) REFERENCES `workersbooking_every_schedule` (`id`),
  CONSTRAINT `workersbooking_worke_speciality_id_19e694b0_fk_workersbo` FOREIGN KEY (`speciality_id`) REFERENCES `workersbooking_specialities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Экспортируемые данные не выделены.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
