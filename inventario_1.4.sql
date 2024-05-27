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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  PRIMARY KEY (`id_pro`),
  KEY `producto_ibfk_1_idx` (`fk_prov`),
  KEY `producto_ibfk_2_idx` (`fk_emp`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`fk_prov`) REFERENCES `proveedor` (`id_prov`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`fk_emp`) REFERENCES `empleado` (`id_emp`) ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-26 22:50:39
