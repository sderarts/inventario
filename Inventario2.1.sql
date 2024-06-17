CREATE DATABASE  IF NOT EXISTS `inventario` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventario`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: inventario
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria_producto`
--

DROP TABLE IF EXISTS `categoria_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_producto` (
  `id_cat` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_producto`
--

LOCK TABLES `categoria_producto` WRITE;
/*!40000 ALTER TABLE `categoria_producto` DISABLE KEYS */;
INSERT INTO `categoria_producto` VALUES (1,'Maquinaria'),(2,'Herramientas');
/*!40000 ALTER TABLE `categoria_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `id_emp` int NOT NULL AUTO_INCREMENT,
  `rol_emp` int DEFAULT NULL,
  `nombre_emp` varchar(45) DEFAULT NULL,
  `apellido_emp` varchar(45) DEFAULT NULL,
  `correo_emp` varchar(45) DEFAULT NULL,
  `contrasena_emp` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_emp`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (13,NULL,'ron','howard','ro@com','$2b$10$.1WAm8Vsua1z/UrcJjTZ0.Zt1PRKfNiKk4sMZAwDcvGnq.YFXcgtW'),(14,NULL,'ignacio','orozco','ig@com','$2b$10$AxikrEpKEscEM9f97jMNZ.733qTqLYHgd.x6fFw0byX/VLwi7A3o.');
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etiqueta`
--

DROP TABLE IF EXISTS `etiqueta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etiqueta` (
  `id_etiqueta` int NOT NULL AUTO_INCREMENT,
  `nombre_etiqueta` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_etiqueta`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etiqueta`
--

LOCK TABLES `etiqueta` WRITE;
/*!40000 ALTER TABLE `etiqueta` DISABLE KEYS */;
INSERT INTO `etiqueta` VALUES (1,'uno'),(2,'dos'),(3,'tres'),(4,'cuatro');
/*!40000 ALTER TABLE `etiqueta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etiqueta_producto`
--

DROP TABLE IF EXISTS `etiqueta_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etiqueta_producto` (
  `id_etiqueta_producto` int NOT NULL AUTO_INCREMENT,
  `fk_pro` int DEFAULT NULL,
  `fk_etiqueta` int DEFAULT NULL,
  PRIMARY KEY (`id_etiqueta_producto`),
  KEY `id_pro_idx` (`fk_pro`),
  KEY `id_kit_idx` (`fk_etiqueta`),
  CONSTRAINT `id_kit` FOREIGN KEY (`fk_etiqueta`) REFERENCES `etiqueta` (`id_etiqueta`),
  CONSTRAINT `id_pro` FOREIGN KEY (`fk_pro`) REFERENCES `producto` (`id_pro`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etiqueta_producto`
--

LOCK TABLES `etiqueta_producto` WRITE;
/*!40000 ALTER TABLE `etiqueta_producto` DISABLE KEYS */;
INSERT INTO `etiqueta_producto` VALUES (12,13,NULL),(13,16,NULL),(14,16,NULL),(15,16,NULL),(23,13,2),(24,13,1),(25,16,2),(26,16,3),(27,16,4),(28,17,4),(29,17,2);
/*!40000 ALTER TABLE `etiqueta_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kit`
--

DROP TABLE IF EXISTS `kit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kit` (
  `id_kit` int NOT NULL AUTO_INCREMENT,
  `nombre_kit` varchar(45) DEFAULT NULL,
  `precio_kit` int DEFAULT NULL,
  `fk_emp` int DEFAULT NULL,
  PRIMARY KEY (`id_kit`),
  KEY `kit_ibfk_1_idx` (`fk_emp`),
  CONSTRAINT `kit_ibfk_1` FOREIGN KEY (`fk_emp`) REFERENCES `empleado` (`id_emp`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kit`
--

LOCK TABLES `kit` WRITE;
/*!40000 ALTER TABLE `kit` DISABLE KEYS */;
INSERT INTO `kit` VALUES (7,'kit maestro ',50000,13),(8,'kit meastro dos',23000,13),(9,'Kit prueba martes',158000,13);
/*!40000 ALTER TABLE `kit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kit_producto`
--

DROP TABLE IF EXISTS `kit_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kit_producto` (
  `id_kit_producto` int NOT NULL AUTO_INCREMENT,
  `fk_kit` int NOT NULL,
  `fk_pro` int NOT NULL,
  PRIMARY KEY (`id_kit_producto`),
  KEY `fk_kit` (`fk_kit`),
  KEY `fk_pro` (`fk_pro`),
  CONSTRAINT `kit_producto_ibfk_1` FOREIGN KEY (`fk_kit`) REFERENCES `kit` (`id_kit`),
  CONSTRAINT `kit_producto_ibfk_2` FOREIGN KEY (`fk_pro`) REFERENCES `producto` (`id_pro`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kit_producto`
--

LOCK TABLES `kit_producto` WRITE;
/*!40000 ALTER TABLE `kit_producto` DISABLE KEYS */;
INSERT INTO `kit_producto` VALUES (6,7,13),(7,7,14),(8,8,13),(9,7,14),(10,9,16),(11,9,17),(12,9,14);
/*!40000 ALTER TABLE `kit_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id_pro` int NOT NULL AUTO_INCREMENT,
  `nombre_pro` varchar(45) DEFAULT NULL,
  `descripcion_pro` varchar(45) DEFAULT NULL,
  `cantidad_pro` varchar(45) DEFAULT NULL,
  `ubicacion_pro` varchar(45) DEFAULT NULL,
  `fecha_venc` date DEFAULT NULL,
  `precio_pro` int DEFAULT NULL,
  `fk_prov` int DEFAULT NULL,
  `fk_emp` int DEFAULT NULL,
  `fk_cat` int DEFAULT NULL,
  PRIMARY KEY (`id_pro`),
  KEY `producto_ibfk_1_idx` (`fk_prov`),
  KEY `producto_ibfk_2_idx` (`fk_emp`),
  KEY `producto_ibfk_3_idx` (`fk_cat`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`fk_prov`) REFERENCES `proveedor` (`id_prov`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`fk_emp`) REFERENCES `empleado` (`id_emp`) ON UPDATE RESTRICT,
  CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`fk_cat`) REFERENCES `categoria_producto` (`id_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (12,'d','d','44','sadasd','2009-02-12',2,8,13,NULL),(13,'tornillos','t 5 cm','20','sector sur','2025-02-05',20000,9,13,NULL),(14,'Taladro bauker','4x4','1','sector sur','2008-02-01',44500,9,13,NULL),(15,'Sprint 2 Product','desc','5','sadfsad','2005-02-02',50000,9,13,NULL),(16,'test 6','desc','2','d','2020-02-02',22,9,13,1),(17,'test 7','desc','70','ubi','2025-02-25',30000,8,13,2),(18,'Producto Quimico','desc','1','biohazard','2024-06-01',280000,9,13,2),(19,'Producto Quimico 2','desc','1','biohazard','2024-07-01',280000,9,13,2),(20,'Producto Quimico 3','desc','1','biohazard','2024-07-13',280000,9,13,2),(21,'Producto Quimico 4','desc','1','biohazard','2024-07-11',280000,9,13,2);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `id_prov` int NOT NULL AUTO_INCREMENT,
  `nombre_prov` varchar(45) DEFAULT NULL,
  `apellido_prov` varchar(45) DEFAULT NULL,
  `empresa_prov` varchar(45) DEFAULT NULL,
  `correo_prov` varchar(45) DEFAULT NULL,
  `terminos_pago` int DEFAULT NULL,
  `dir_prov` varchar(45) DEFAULT NULL,
  `telefono_prov` int DEFAULT NULL,
  PRIMARY KEY (`id_prov`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (8,'bob','esponja','telefonica com','bob@com',2,'pina express 3',1133442255),(9,'Matias','Cornejo','duoc minerales','m@com',1,'antofagasta sur',22334411);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-17  1:55:05
