-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: jobs_db
-- ------------------------------------------------------
-- Server version	8.0.31

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

--
-- Table structure for table `Contains_Department`
--

DROP TABLE IF EXISTS `Contains_Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contains_Department` (
  `Educational_Institute_Id` int NOT NULL,
  `Department_Id` int NOT NULL,
  PRIMARY KEY (`Educational_Institute_Id`,`Department_Id`),
  KEY `Department_Id` (`Department_Id`),
  CONSTRAINT `Contains_Department_ibfk_1` FOREIGN KEY (`Educational_Institute_Id`) REFERENCES `Educational_Institutes` (`Educational_Institute_Id`),
  CONSTRAINT `Contains_Department_ibfk_2` FOREIGN KEY (`Department_Id`) REFERENCES `Department` (`Department_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contains_Department`
--

LOCK TABLES `Contains_Department` WRITE;
/*!40000 ALTER TABLE `Contains_Department` DISABLE KEYS */;
INSERT INTO `Contains_Department` VALUES (2002,1),(2007,1),(2009,1),(2002,2),(2003,2),(2001,3),(2004,3),(2005,3),(2006,3),(2007,3),(2008,3),(2009,3),(2010,3),(2003,4),(2001,5),(2008,5),(2006,6);
/*!40000 ALTER TABLE `Contains_Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Courses`
--

DROP TABLE IF EXISTS `Courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Courses` (
  `Course_Id` int NOT NULL,
  `Course` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Course_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Courses`
--

LOCK TABLES `Courses` WRITE;
/*!40000 ALTER TABLE `Courses` DISABLE KEYS */;
INSERT INTO `Courses` VALUES (301,'Intro to Programming'),(302,'Digital Systems And Microcontrollers'),(303,'Intro to Stochastic Processes'),(304,'Data And Applications'),(305,'Algorithm Analysis and Design'),(306,'Principles Of Programming Languages'),(307,'Intro to NLP'),(308,'Intro to Human Sciences'),(309,'Advanced NLP'),(310,'Intro to Blockchain'),(311,'Intro to Machine Learning'),(312,'Intro to Artificial Intelligence'),(313,'Data Science and Applications'),(314,'Distributed Systems'),(315,'Intro to Game Theory'),(316,'Computer Vision'),(317,'Intro to Software Systems'),(318,'Signal Processing'),(319,'Computational Linguistics'),(320,'Intro to Computational Social Science'),(321,'Intro to Quantum Computing');
/*!40000 ALTER TABLE `Courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Department` (
  `Department_Id` int NOT NULL,
  `Department` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Department_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (1,'Language Department'),(2,'Electronics Department'),(3,'Computer Science Department'),(4,'Mathematics Department'),(5,'Human Science Department'),(6,'Quantum Department');
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Educational_Institutes`
--

DROP TABLE IF EXISTS `Educational_Institutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Educational_Institutes` (
  `Educational_Institute_Id` int NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Educational_Institute_Id`),
  CONSTRAINT `Educational_Institutes_chk_1` CHECK ((`Type` in (_utf8mb4'School',_utf8mb4'University')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Educational_Institutes`
--

LOCK TABLES `Educational_Institutes` WRITE;
/*!40000 ALTER TABLE `Educational_Institutes` DISABLE KEYS */;
INSERT INTO `Educational_Institutes` VALUES (2001,'IIITH','University'),(2002,'GD Goenka Public School','School'),(2003,'IITB','University'),(2004,'IITD','University'),(2005,'DPS','School'),(2006,'MIT','University'),(2007,'VIT','University'),(2008,'DAV','School'),(2009,'Kunskapskolan','School'),(2010,'Stanford','University');
/*!40000 ALTER TABLE `Educational_Institutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Educational_Qualifications`
--

DROP TABLE IF EXISTS `Educational_Qualifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Educational_Qualifications` (
  `Person_Id` int DEFAULT NULL,
  `Educational_Institute_Id` int DEFAULT NULL,
  `Description` varchar(200) DEFAULT NULL,
  `CGPA` float DEFAULT NULL,
  `Qualifications` varchar(50) DEFAULT NULL,
  KEY `Person_Id` (`Person_Id`),
  KEY `Educational_Institute_Id` (`Educational_Institute_Id`),
  CONSTRAINT `Educational_Qualifications_ibfk_1` FOREIGN KEY (`Person_Id`) REFERENCES `Person` (`Person_Id`),
  CONSTRAINT `Educational_Qualifications_ibfk_2` FOREIGN KEY (`Educational_Institute_Id`) REFERENCES `Educational_Institutes` (`Educational_Institute_Id`),
  CONSTRAINT `Educational_Qualifications_chk_1` CHECK (((`CGPA` >= 0) and (`CGPA` <= 10))),
  CONSTRAINT `Educational_Qualifications_chk_2` CHECK ((`Qualifications` in (_utf8mb4'PhD',_utf8mb4'Masters',_utf8mb4'Bachelors',_utf8mb4'Senior Secondary')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Educational_Qualifications`
--

LOCK TABLES `Educational_Qualifications` WRITE;
/*!40000 ALTER TABLE `Educational_Qualifications` DISABLE KEYS */;
INSERT INTO `Educational_Qualifications` VALUES (1111,2007,'In Computer Science',9.8,'Bachelors'),(1112,2010,'In Electronics',9.9,'Bachelors'),(1113,2006,'In Computer Science',7.8,'Masters'),(1114,2003,'In Robotics',8.9,'Bachelors'),(1115,2004,'In Computer Vision',8.5,'Masters'),(1116,2001,'In Machine Learning',9,'PhD'),(1117,2007,'In Artificial Intelligence',9.5,'PhD'),(1118,2008,'In Science',9.4,'Senior Secondary'),(1119,2005,'In Science',9.6,'Senior Secondary'),(1120,2001,'In Electronics and Telecommunication',9.4,'Bachelors'),(1121,2005,'In Science',9.7,'Senior Secondary');
/*!40000 ALTER TABLE `Educational_Qualifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fields`
--

DROP TABLE IF EXISTS `Fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fields` (
  `Field_Id` int NOT NULL,
  `Field_` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Field_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fields`
--

LOCK TABLES `Fields` WRITE;
/*!40000 ALTER TABLE `Fields` DISABLE KEYS */;
INSERT INTO `Fields` VALUES (1,'Computer Vision'),(2,'Game Theory'),(3,'Natural Language Processing'),(4,'User Experience Development'),(5,'Game Development'),(6,'Robotics'),(7,'Machine Unlearning'),(8,'Reinforcement Learning'),(9,'Quantum Machine Learning'),(10,'Data Science');
/*!40000 ALTER TABLE `Fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Institute_Departments`
--

DROP TABLE IF EXISTS `Institute_Departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Institute_Departments` (
  `Institute_Id` int NOT NULL,
  `Department_Name` varchar(50) NOT NULL,
  `Project_Id` int DEFAULT NULL,
  PRIMARY KEY (`Institute_Id`,`Department_Name`),
  KEY `Project_Id` (`Project_Id`),
  CONSTRAINT `Institute_Departments_ibfk_1` FOREIGN KEY (`Institute_Id`) REFERENCES `Institutes` (`Institute_Id`),
  CONSTRAINT `Institute_Departments_ibfk_2` FOREIGN KEY (`Project_Id`) REFERENCES `Project` (`Project_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Institute_Departments`
--

LOCK TABLES `Institute_Departments` WRITE;
/*!40000 ALTER TABLE `Institute_Departments` DISABLE KEYS */;
INSERT INTO `Institute_Departments` VALUES (13,'Machine Learning Department',3),(6,'Development Department',4),(7,'Development Department',6),(8,'Development Department',7),(3,'Quantum Department',9),(12,'Data Science Department',12);
/*!40000 ALTER TABLE `Institute_Departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Institute_Offers`
--

DROP TABLE IF EXISTS `Institute_Offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Institute_Offers` (
  `Educational_Institute_Id` int DEFAULT NULL,
  `Course_Id` int DEFAULT NULL,
  KEY `Educational_Institute_Id` (`Educational_Institute_Id`),
  KEY `Course_Id` (`Course_Id`),
  CONSTRAINT `Institute_Offers_ibfk_1` FOREIGN KEY (`Educational_Institute_Id`) REFERENCES `Educational_Institutes` (`Educational_Institute_Id`),
  CONSTRAINT `Institute_Offers_ibfk_2` FOREIGN KEY (`Course_Id`) REFERENCES `Courses` (`Course_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Institute_Offers`
--

LOCK TABLES `Institute_Offers` WRITE;
/*!40000 ALTER TABLE `Institute_Offers` DISABLE KEYS */;
INSERT INTO `Institute_Offers` VALUES (2001,301),(2001,320),(2002,302),(2002,319),(2003,303),(2003,318),(2004,304),(2004,317),(2005,305),(2005,316),(2006,306),(2006,315),(2007,307),(2007,314),(2008,308),(2008,313),(2009,309),(2009,312),(2010,310),(2010,311),(2006,321);
/*!40000 ALTER TABLE `Institute_Offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Institutes`
--

DROP TABLE IF EXISTS `Institutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Institutes` (
  `Institute_Id` int NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Project_Id` int DEFAULT NULL,
  PRIMARY KEY (`Institute_Id`),
  KEY `Project_Id` (`Project_Id`),
  CONSTRAINT `Institutes_ibfk_1` FOREIGN KEY (`Project_Id`) REFERENCES `Project` (`Project_Id`),
  CONSTRAINT `Institutes_chk_1` CHECK ((`Type` in (_utf8mb4'Company',_utf8mb4'University')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Institutes`
--

LOCK TABLES `Institutes` WRITE;
/*!40000 ALTER TABLE `Institutes` DISABLE KEYS */;
INSERT INTO `Institutes` VALUES (1,'IIITH','University',1),(2,'IIITB','University',9),(3,'Qualcomm','Company',9),(4,'IITB','University',2),(5,'IIITD','University',5),(6,'Google','Company',4),(7,'Rockstar North','Company',6),(8,'Rockstar South','Company',7),(9,'IITD','University',8),(10,'MIT','University',10),(11,'IIITV','University',11),(12,'Uber','Company',12),(13,'Microsoft','Company',3);
/*!40000 ALTER TABLE `Institutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Jobs`
--

DROP TABLE IF EXISTS `Jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Jobs` (
  `Job_Id` int NOT NULL,
  `Job_Description` varchar(200) NOT NULL,
  `Institute_Id` int DEFAULT NULL,
  `Salary` int DEFAULT NULL,
  `Start_Date` date DEFAULT NULL,
  `End_Date` date DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Duration_Worked` int DEFAULT NULL,
  PRIMARY KEY (`Job_Id`),
  KEY `Institute_Id` (`Institute_Id`),
  CONSTRAINT `Jobs_ibfk_1` FOREIGN KEY (`Institute_Id`) REFERENCES `Institutes` (`Institute_Id`),
  CONSTRAINT `Jobs_chk_1` CHECK ((`Salary` > 0)),
  CONSTRAINT `Jobs_chk_2` CHECK ((`Type` in (_utf8mb4'Software Developer',_utf8mb4'Project Manager',_utf8mb4'Researcher')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Jobs`
--

LOCK TABLES `Jobs` WRITE;
/*!40000 ALTER TABLE `Jobs` DISABLE KEYS */;
INSERT INTO `Jobs` VALUES (1111,'Development of GTA 8',6,50000,'2020-10-10','2022-10-09','Software Developer',2);
/*!40000 ALTER TABLE `Jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Minimum_Job_Requirements`
--

DROP TABLE IF EXISTS `Minimum_Job_Requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Minimum_Job_Requirements` (
  `Job_Id` int DEFAULT NULL,
  `Min_Years_of_Experience` float DEFAULT NULL,
  `Min_Qualification` varchar(50) DEFAULT NULL,
  KEY `Job_Id` (`Job_Id`),
  CONSTRAINT `Minimum_Job_Requirements_ibfk_1` FOREIGN KEY (`Job_Id`) REFERENCES `Jobs` (`Job_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Minimum_Job_Requirements`
--

LOCK TABLES `Minimum_Job_Requirements` WRITE;
/*!40000 ALTER TABLE `Minimum_Job_Requirements` DISABLE KEYS */;
/*!40000 ALTER TABLE `Minimum_Job_Requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Person` (
  `Person_Id` int NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Aadhar_Number` int NOT NULL,
  `Job_Id` int DEFAULT NULL,
  `Phone_Number` varchar(50) DEFAULT NULL,
  `Date_of_Birth` date DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Person_Id`),
  UNIQUE KEY `Aadhar_Number` (`Aadhar_Number`),
  KEY `Job_Id` (`Job_Id`),
  CONSTRAINT `Person_ibfk_1` FOREIGN KEY (`Job_Id`) REFERENCES `Jobs` (`Job_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES (1111,'Aryaman Kolhe',6677,NULL,'9889360562','2000-08-09',22,'Male'),(1112,'Vrinda Agarwal',8899,NULL,'8874577777','2002-10-07',20,'Female'),(1113,'Prakhar Jain',9987,NULL,'7007905500','2001-12-10',21,'Male'),(1114,'Kunal Bhosikar',9986,NULL,'7007123232','1999-09-17',23,'Male'),(1115,'Bhumika Joshi',967,NULL,'9305512623','2004-10-07',18,'Female'),(1116,'Ashwini Kulkarni',6734,NULL,'9979997980','2002-09-30',20,'Female'),(1117,'Ashani Pandey',6756,NULL,'9889360567','1997-08-08',25,'Female'),(1118,'Faizal Karim',8974,NULL,'7007123456','1979-07-07',43,'Male'),(1119,'Eshan Gupta',6720,NULL,'9889360569','1999-09-09',23,'Male'),(1120,'Mahika Jain',7820,NULL,'93055126908','2004-10-10',18,'Female'),(1121,'Sannidhya Gupta',9089,NULL,'9009876523','2003-11-09',19,'Male');
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Project`
--

DROP TABLE IF EXISTS `Project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Project` (
  `Project_Id` int NOT NULL,
  `Type_` varchar(50) DEFAULT NULL,
  `Description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`Project_Id`),
  CONSTRAINT `Project_chk_1` CHECK ((`Type_` in (_utf8mb4'Research',_utf8mb4'Development',_utf8mb4'Engineering',_utf8mb4'Machine Learning',_utf8mb4'Data Science')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Project`
--

LOCK TABLES `Project` WRITE;
/*!40000 ALTER TABLE `Project` DISABLE KEYS */;
INSERT INTO `Project` VALUES (1,'Research','Creating a 3d model from a 2d image'),(2,'Research','Decision making'),(3,'Engineering','Speech Detection - Detect from which region a person is'),(4,'Engineering','Enhance User Experience'),(5,'Research','Computer Graphics - Making computer graphics look realistic'),(6,'Development','GTA 8 a very popular open world game'),(7,'Development','Red Dead Redemption 3'),(8,'Engineering','Making a robot who has emotions'),(9,'Machine Learning','Remove from a model all the traces of a selected data point'),(10,'Machine Learning','Using Reinforcement Learning for choosing an Ansatz for Variational Algorithms'),(11,'Machine Learning','Transformer Conversational Chatbot in Python using TensorFlow 2.0'),(12,'Data Science','Fake news Detection');
/*!40000 ALTER TABLE `Project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Project_Field`
--

DROP TABLE IF EXISTS `Project_Field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Project_Field` (
  `Project_Id` int NOT NULL,
  `Field_Id` int NOT NULL,
  PRIMARY KEY (`Project_Id`,`Field_Id`),
  KEY `Field_Id` (`Field_Id`),
  CONSTRAINT `Project_Field_ibfk_1` FOREIGN KEY (`Project_Id`) REFERENCES `Project` (`Project_Id`),
  CONSTRAINT `Project_Field_ibfk_2` FOREIGN KEY (`Field_Id`) REFERENCES `Fields` (`Field_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Project_Field`
--

LOCK TABLES `Project_Field` WRITE;
/*!40000 ALTER TABLE `Project_Field` DISABLE KEYS */;
INSERT INTO `Project_Field` VALUES (1,1),(5,1),(2,2),(3,3),(4,4),(6,5),(7,5),(8,6),(9,7),(10,8),(11,9),(12,10);
/*!40000 ALTER TABLE `Project_Field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `References_`
--

DROP TABLE IF EXISTS `References_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `References_` (
  `Person_Id` int DEFAULT NULL,
  `Institute_Id` int DEFAULT NULL,
  `Job_Id` int DEFAULT NULL,
  KEY `Person_Id` (`Person_Id`),
  KEY `Job_Id` (`Job_Id`),
  KEY `Institute_Id` (`Institute_Id`),
  CONSTRAINT `References__ibfk_1` FOREIGN KEY (`Person_Id`) REFERENCES `Person` (`Person_Id`),
  CONSTRAINT `References__ibfk_2` FOREIGN KEY (`Job_Id`) REFERENCES `Jobs` (`Job_Id`),
  CONSTRAINT `References__ibfk_3` FOREIGN KEY (`Institute_Id`) REFERENCES `Institutes` (`Institute_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `References_`
--

LOCK TABLES `References_` WRITE;
/*!40000 ALTER TABLE `References_` DISABLE KEYS */;
/*!40000 ALTER TABLE `References_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Work_Experience`
--

DROP TABLE IF EXISTS `Work_Experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Work_Experience` (
  `Person_Id` int DEFAULT NULL,
  `Job_Id` int DEFAULT NULL,
  KEY `Person_Id` (`Person_Id`),
  KEY `Job_Id` (`Job_Id`),
  CONSTRAINT `Work_Experience_ibfk_1` FOREIGN KEY (`Person_Id`) REFERENCES `Person` (`Person_Id`),
  CONSTRAINT `Work_Experience_ibfk_2` FOREIGN KEY (`Job_Id`) REFERENCES `Jobs` (`Job_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Work_Experience`
--

LOCK TABLES `Work_Experience` WRITE;
/*!40000 ALTER TABLE `Work_Experience` DISABLE KEYS */;
/*!40000 ALTER TABLE `Work_Experience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_table`
--

DROP TABLE IF EXISTS `test_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_table` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_table`
--

LOCK TABLES `test_table` WRITE;
/*!40000 ALTER TABLE `test_table` DISABLE KEYS */;
INSERT INTO `test_table` VALUES (1,'Pramkhar','Jain');
/*!40000 ALTER TABLE `test_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-27 16:03:20
