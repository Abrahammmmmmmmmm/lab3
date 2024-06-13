-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: studentsystemdatabase
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `tb_classe`
--

DROP TABLE IF EXISTS `tb_classe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_classe` (
  `Classe` int NOT NULL,
  `Grade` int NOT NULL,
  `Major_ID` varchar(30) NOT NULL,
  PRIMARY KEY (`Classe`,`Grade`,`Major_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_classe`
--

LOCK TABLES `tb_classe` WRITE;
/*!40000 ALTER TABLE `tb_classe` DISABLE KEYS */;
INSERT INTO `tb_classe` VALUES (1,2022,'11'),(1,2022,'12'),(1,2022,'13'),(1,2022,'14'),(1,2022,'15'),(1,2022,'16'),(1,2022,'17'),(1,2022,'18'),(1,2023,'14'),(1,2023,'15'),(1,2023,'16'),(1,2023,'17'),(1,2023,'18'),(1,2024,'14'),(1,2024,'15'),(1,2024,'16'),(1,2024,'17'),(1,2024,'18'),(2,2022,'11'),(2,2022,'12'),(2,2022,'13'),(2,2022,'14'),(2,2022,'15'),(2,2022,'16'),(2,2022,'17'),(2,2022,'18'),(2,2023,'14'),(2,2023,'15'),(2,2023,'16'),(2,2023,'17'),(2,2023,'18'),(3,2022,'11'),(3,2022,'12'),(4,2022,'11');
/*!40000 ALTER TABLE `tb_classe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_course`
--

DROP TABLE IF EXISTS `tb_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_course` (
  `Course_Name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Major_ID` varchar(30) NOT NULL,
  `Grade` int NOT NULL,
  PRIMARY KEY (`Course_Name`,`Major_ID`,`Grade`),
  KEY `Major_ID` (`Major_ID`),
  CONSTRAINT `tb_course_ibfk_1` FOREIGN KEY (`Major_ID`) REFERENCES `tb_major` (`Major_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_course`
--

LOCK TABLES `tb_course` WRITE;
/*!40000 ALTER TABLE `tb_course` DISABLE KEYS */;
INSERT INTO `tb_course` VALUES ('操作系统','11',2023),('数据库原理','11',2022),('数据结构','11',2022),('编译原理','11',2023),('英语','11',2022),('计算机体系结构','11',2023),('计算机组成原理','11',2022),('面向对象程序设计','11',2022),('高等数学','11',2022),('数据结构','12',2022),('英语','12',2022),('软件工程导论','12',2022),('软件开发','12',2023),('软件测试','12',2022),('软件需求分析','12',2023),('面向对象程序设计','12',2022),('项目管理','12',2022),('高等数学','12',2022),('信息安全导论','13',2022),('信息安全技术','13',2022),('密码学','13',2022),('恶意软件分析','13',2023),('数据结构','13',2022),('网络安全管理','13',2023),('英语','13',2022),('面向对象程序设计','13',2022),('高等数学','13',2022),('网络协议','14',2023),('网络基础','14',2022),('网络安全','14',2023),('计算机网络','14',2022),('人工智能导论','15',2022),('机器学习','15',2022),('深度学习','15',2023),('自然语言处理','15',2023),('大数据处理技术','16',2023),('大数据概论','16',2022),('数据可视化','16',2023),('数据挖掘','16',2022),('传感器技术','17',2022),('无线通信','17',2023),('物联网应用','17',2023),('物联网概论','17',2022),('信号与系统','18',2022),('数字电路','18',2023),('电子电路','18',2022),('通信原理','18',2023);
/*!40000 ALTER TABLE `tb_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_department`
--

DROP TABLE IF EXISTS `tb_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_department` (
  `Department_ID` varchar(30) NOT NULL,
  `Department_Name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`Department_ID`),
  UNIQUE KEY `Department_Name` (`Department_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_department`
--

LOCK TABLES `tb_department` WRITE;
/*!40000 ALTER TABLE `tb_department` DISABLE KEYS */;
INSERT INTO `tb_department` VALUES ('02','中国语言文学学院'),('16','互联网学院'),('15','人工智能学院'),('10','公共管理学院'),('12','化学与药学学院'),('08','国际贸易与金融学院'),('13','外语学院'),('17','大数据学院'),('09','工商管理学院'),('11','建筑学学院'),('06','旅游管理学院'),('07','机械与汽车工程学院'),('05','物流与信息管理学院'),('03','电子信息学院'),('01','艺术学院'),('04','计算机科学与技术学院'),('14','音乐舞蹈学院');
/*!40000 ALTER TABLE `tb_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_major`
--

DROP TABLE IF EXISTS `tb_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_major` (
  `Major_ID` varchar(30) NOT NULL,
  `Major_Name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Department_ID` varchar(30) NOT NULL,
  PRIMARY KEY (`Major_ID`),
  UNIQUE KEY `Major_Name` (`Major_Name`),
  KEY `Department_ID` (`Department_ID`),
  CONSTRAINT `tb_major_ibfk_1` FOREIGN KEY (`Department_ID`) REFERENCES `tb_department` (`Department_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_major`
--

LOCK TABLES `tb_major` WRITE;
/*!40000 ALTER TABLE `tb_major` DISABLE KEYS */;
INSERT INTO `tb_major` VALUES ('01','视觉传达设计专业','01'),('02','动画专业','01'),('03','汉语言文学专业','02'),('04','广告学专业','02'),('05','汉语国际教育专业','02'),('06','通信工程专业','03'),('07','微电子科学与工程专业','03'),('08','自动化专业','03'),('09','电子科学与技术专业','03'),('10','测控技术与仪器专业','03'),('11','计算机科学与技术专业','04'),('12','软件工程专业','04'),('13','信息安全专业','04'),('14','网络工程专业','16'),('15','人工智能专业','15'),('16','数据科学与大数据技术专业','17'),('17','物联网工程专业','16'),('18','电子信息工程专业','03'),('19','物流管理专业','05'),('20','信息管理与信息学院统专业','05'),('21','电子商务专业','05'),('22','旅游管理专业','06'),('23','机械设计制造及其自动化专业','07'),('24','汽车服务工程专业','07'),('25','车辆工程专业','07'),('26','工业工程专业','07'),('27','国际经济与贸易专业','08'),('28','金融学专业','08'),('29','工商管理专业','09'),('30','市场营销专业','09'),('31','人力资源管理专业','09'),('32','会计学专业','09'),('33','行政管理专业','10'),('34','劳动与社会保障专业','10'),('35','社会工作专业','10'),('36','建筑学专业','11'),('37','城乡规划专业','11'),('38','应用化学专业','12'),('39','制药工程(生物制药)专业','12'),('40','药物制剂专业','12'),('41','中药学专业','12'),('42','化学工程与工艺专业','12'),('43','英语专业','13'),('44','日语专业','13'),('45','朝鲜语（韩国语）专业','13'),('46','音乐表演专业','14'),('47','舞蹈编导专业','14');
/*!40000 ALTER TABLE `tb_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_score`
--

DROP TABLE IF EXISTS `tb_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_score` (
  `Student_Id` varchar(30) NOT NULL,
  `Student_Name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Course_Name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Score` decimal(4,1) DEFAULT NULL,
  PRIMARY KEY (`Course_Name`,`Student_Id`),
  KEY `Student_Id` (`Student_Id`),
  CONSTRAINT `tb_score_ibfk_1` FOREIGN KEY (`Student_Id`) REFERENCES `tb_student` (`Student_Id`),
  CONSTRAINT `tb_score_ibfk_2` FOREIGN KEY (`Course_Name`) REFERENCES `tb_course` (`Course_Name`),
  CONSTRAINT `tb_score_chk_1` CHECK ((`Score` between 0.0 and 100.0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_score`
--

LOCK TABLES `tb_score` WRITE;
/*!40000 ALTER TABLE `tb_score` DISABLE KEYS */;
INSERT INTO `tb_score` VALUES ('20221234002','钱二','人工智能导论',90.0),('20221234007','郑七','人工智能导论',88.5),('20221234004','李四','传感器技术',93.0),('20221234005','周五','信号与系统',88.5),('20221234003','孙三','大数据概论',87.0),('20221234008','王八','大数据概论',86.0),('20241234013','蒋三三','大数据概论',90.0),('20221234003','孙三','数据挖掘',89.0),('20221234008','王八','数据挖掘',89.0),('20241234013','蒋三三','数据挖掘',92.0),('20221234567','李四','数据结构',92.0),('E22214005','宋浩宇','数据结构',95.0),('E22214999','李九九','数据结构',98.0),('20221234002','钱二','机器学习',92.0),('20221234007','郑七','机器学习',91.5),('20221234004','李四','物联网概论',91.0),('20221234005','周五','电子电路',85.5),('20221234001','赵一','网络基础',85.0),('20221234006','吴六','网络基础',90.5),('20231234011','褚一一','网络基础',87.5),('20223456789','张三','英语',90.5),('E22214005','宋浩宇','英语',85.0),('E22214999','李九九','英语',97.0),('20221234001','赵一','计算机网络',88.0),('20221234006','吴六','计算机网络',92.5),('20231234011','褚一一','计算机网络',89.5),('E22214005','宋浩宇','软件工程导论',90.0),('E22214999','李九九','软件工程导论',96.0),('E22214005','宋浩宇','软件测试',90.0),('E22214999','李九九','软件测试',86.0),('20221234567','李四','面向对象程序设计',88.0),('E22214005','宋浩宇','面向对象程序设计',92.0),('E22214999','李九九','面向对象程序设计',84.0),('E22214005','宋浩宇','项目管理',91.0),('E22214999','李九九','项目管理',83.0),('20223456789','张三','高等数学',85.0),('E22214005','宋浩宇','高等数学',85.0),('E22214999','李九九','高等数学',76.0);
/*!40000 ALTER TABLE `tb_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_student`
--

DROP TABLE IF EXISTS `tb_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_student` (
  `Student_Id` varchar(30) NOT NULL,
  `Student_Name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Student_Sex` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '男',
  `Grade` int NOT NULL,
  `Classe` int NOT NULL,
  `Major_ID` varchar(30) NOT NULL,
  `Major_Name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Department_ID` varchar(30) NOT NULL,
  `Department_Name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`Student_Id`),
  KEY `Department_ID` (`Department_ID`),
  KEY `Major_ID` (`Major_ID`),
  KEY `Department_Name` (`Department_Name`),
  KEY `Major_Name` (`Major_Name`),
  CONSTRAINT `tb_student_ibfk_1` FOREIGN KEY (`Department_ID`) REFERENCES `tb_department` (`Department_ID`),
  CONSTRAINT `tb_student_ibfk_2` FOREIGN KEY (`Major_ID`) REFERENCES `tb_major` (`Major_ID`),
  CONSTRAINT `tb_student_ibfk_3` FOREIGN KEY (`Department_Name`) REFERENCES `tb_department` (`Department_Name`),
  CONSTRAINT `tb_student_ibfk_4` FOREIGN KEY (`Major_Name`) REFERENCES `tb_major` (`Major_Name`),
  CONSTRAINT `tb_student_chk_1` CHECK ((`Student_Sex` in (_utf8mb4'男',_utf8mb4'女')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_student`
--

LOCK TABLES `tb_student` WRITE;
/*!40000 ALTER TABLE `tb_student` DISABLE KEYS */;
INSERT INTO `tb_student` VALUES ('20221234001','赵一','男',2022,1,'14','网络工程专业','16','互联网学院'),('20221234002','钱二','女',2022,1,'15','人工智能专业','15','人工智能学院'),('20221234003','孙三','男',2022,2,'16','数据科学与大数据技术专业','17','大数据学院'),('20221234004','李四','女',2022,2,'17','物联网工程专业','16','互联网学院'),('20221234005','周五','男',2022,1,'18','电子信息工程专业','03','电子信息学院'),('20221234006','吴六','女',2022,1,'14','网络工程专业','16','互联网学院'),('20221234007','郑七','男',2022,2,'15','人工智能专业','15','人工智能学院'),('20221234008','王八','女',2022,2,'16','数据科学与大数据技术专业','17','大数据学院'),('20221234009','冯九','男',2022,1,'17','物联网工程专业','16','互联网学院'),('20221234010','陈十','女',2022,2,'18','电子信息工程专业','03','电子信息学院'),('20221234567','李四','女',2022,2,'12','软件工程专业','04','计算机科学与技术学院'),('20223456789','张三','男',2022,1,'11','计算机科学与技术专业','04','计算机科学与技术学院'),('20231234011','褚一一','男',2023,1,'14','网络工程专业','16','互联网学院'),('20241234013','蒋三三','男',2024,1,'16','数据科学与大数据技术专业','17','大数据学院'),('20241234014','沈四四','女',2024,1,'17','物联网工程专业','16','互联网学院'),('E22214005','宋浩宇','男',2022,2,'12','软件工程专业','04','计算机科学与技术学院'),('E22214999','李九九','男',2022,2,'12','软件工程专业','04','计算机科学与技术学院'),('Z12313000','卫二二','女',2023,2,'15','人工智能专业','15','人工智能学院');
/*!40000 ALTER TABLE `tb_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user` (
  `User_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Password_` varchar(30) NOT NULL,
  `IsLogin` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`User_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES ('Admin','123321',_binary '\0');
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'studentsystemdatabase'
--

--
-- Dumping routines for database 'studentsystemdatabase'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-24  3:11:04
