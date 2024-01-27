
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `board_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_lists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `board_lists` WRITE;
/*!40000 ALTER TABLE `board_lists` DISABLE KEYS */;
INSERT INTO `board_lists` VALUES (1,'TODO',NULL,'2024-01-27 07:36:03','2024-01-27 07:36:03'),(2,'In Progress','2024-01-27 14:14:15','2024-01-27 07:36:10','2024-01-27 14:14:15'),(3,'DONE',NULL,'2024-01-27 07:36:13','2024-01-27 07:36:13'),(4,'Hello','2024-01-27 14:21:08','2024-01-27 14:20:49','2024-01-27 14:21:08'),(5,'Hello','2024-01-27 15:29:47','2024-01-27 14:22:57','2024-01-27 15:29:47');
/*!40000 ALTER TABLE `board_lists` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `board_list_id` bigint unsigned NOT NULL,
  `position` double NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cards_board_list_id_foreign` (`board_list_id`),
  CONSTRAINT `cards_board_list_id_foreign` FOREIGN KEY (`board_list_id`) REFERENCES `board_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cards` WRITE;
/*!40000 ALTER TABLE `cards` DISABLE KEYS */;
INSERT INTO `cards` VALUES (1,'Task 1 updated','Description updated',1,45000,NULL,'2024-01-27 07:38:12','2024-01-27 14:24:47'),(2,'Task 2',NULL,4,15000,'2024-01-27 14:21:08','2024-01-27 07:38:23','2024-01-27 14:21:08'),(3,'task 3',NULL,1,67500,NULL,'2024-01-27 07:39:40','2024-01-27 14:26:18'),(4,'Another task','Descd',1,60000,'2024-01-27 14:24:57','2024-01-27 07:45:49','2024-01-27 14:24:57'),(5,'Here as well','Description',4,30000,'2024-01-27 14:21:08','2024-01-27 07:45:59','2024-01-27 14:21:08'),(6,'task p1',NULL,2,60000,'2024-01-27 14:14:15','2024-01-27 07:52:09','2024-01-27 14:14:15'),(7,'Task p3',NULL,3,2109.375,'2024-01-27 15:29:50','2024-01-27 07:52:12','2024-01-27 15:29:50'),(8,'Task p2',NULL,3,703.125,NULL,'2024-01-27 07:52:14','2024-01-27 15:29:44'),(9,'Task p4',NULL,2,240000,'2024-01-27 14:14:15','2024-01-27 07:52:25','2024-01-27 14:14:15'),(10,'asdasd',NULL,3,2812.5,NULL,'2024-01-27 14:23:01','2024-01-27 14:25:01'),(11,'ewrr',NULL,3,1406.25,'2024-01-27 15:29:53','2024-01-27 14:23:03','2024-01-27 15:29:53'),(12,'ytrt',NULL,3,4218.75,NULL,'2024-01-27 14:23:06','2024-01-27 14:26:03'),(13,'Test',NULL,5,703.125,'2024-01-27 15:29:47','2024-01-27 14:40:14','2024-01-27 15:29:47');
/*!40000 ALTER TABLE `cards` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2019_12_14_000001_create_personal_access_tokens_table',1),(2,'2024_01_26_231650_create_board_lists_table',1),(3,'2024_01_27_001351_create_cards_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

