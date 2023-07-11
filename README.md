# Only-Jobs
Mini project worked on for the course: Data and Applications 


### Functional Requirements Implemented

1. Search for Alumni of a college
2. Add a new job to the market
3. Find projects by field
4. Check eligibility of a person for a job
5. Find all jobs for which the person is eligibile

We did these while maintaining ACID properties as well
We implemented Application Constraints as well!!

### Commands for setup
Start docker service
sudo service docker start

Download Docker image for mysql
sudo docker pull mysql/mysql-server:latest

Verify that the image is stored correctly
sudo docker images

Deploy the container
sudo docker run --name=only-jobs -d mysql/mysql-server:latest

To check if the image is running correctly
docker ps


apt-get install mysql-client
sudo dnf install mysql-client

To get credentials
sudo docker logs mysql_docker

From the above command
Generated root password
/?6jggxb61H06_Mb8F4WT&O?ap#7=gw_


To run SQL bash
sudo docker exec -it only-jobs bash

In SQL bash,
mysql -uroot -p

Then paste the above password

To change password
ALTER USER 'root'@'localhost' IDENTIFIED BY 'only-jobs-secure-password';

New Password
only-jobs-secure-password

In SQL prompt
create database test_db;
use test_db;
CREATE TABLE test_table (userId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, firstName VARCHAR(20), lastName VARCHAR(20));

Creating a new user
CREATE USER 'newuser'@'%' IDENTIFIED BY 'newpassword';

GRANT ALL PRIVILEGES ON test_db.* to 'newuser'@'%';
Instead of specifying an ip address, we use '%'. This is to allow remote connection from anywhere via user newuser.

Create a python environment
virtualenv venv
source ./env/bin/activate

In the virtual environment
pip install pymysql

To create the requirements.txt file
pip freeze > requirements.txt


docker run -p 13306:3306 --name only-jobs-official -eMYSQL_ROOT_PASSWORD=only-jobs-secure-password -d mysql:latest

CREATE DATABASE jobs_db;

use jobs_db;

CREATE TABLE test_table (userId INT NOT NULL AUTO_INCREMENT PRIMARY KEY, firstName VARCHAR(20), lastName VARCHAR(20));
CREATE USER 'newuser'@'%' IDENTIFIED BY 'newpassword';
GRANT ALL PRIVILEGES ON jobs_db.* to 'newuser'@'%';

To create dump file for db
docker exec CONTAINER_ID /usr/bin/mysqldump -u root --password=only-jobs-secure-password jobs_db > only_jobs_dump.sql


### Changes made to the data model 

* Some things had to be changed to keep things consistent -
* Added CGPA column to Minimum_Job_Requirements
* Added Number_of_Years column to Work_Experience
* The column Affiliated in Project is not needed since this is captured in the relation Associated_With
* The column Departments is not needed since this is captured in the Department table
* Removed Department_Id in Institute_Departments and made Department_Name as part of the primary key. This way there is no ambiguity between an Institute's department (like IBM's Research Department) and an Educational Institute's Department (like MIT's Quantum Department)
* In hindsight we should not have made a strict distinction between Educational Institutes and Institutes. That complicated things by a lot.
* Initially, Department_Works_on_Project was created because Institute_Department's attribute - Project_Id was multivalued. For now we have removed the table Department_Works_on_Project and kept Project_Id in Institute_Department (which will be single valued)
* Job_Id in Person was removed, because that relation gets handled by Associated_With
* Added Min_CGPA to Minimum_Job_Requirements





### Features

* Maintaining ACID properties



## Queries to Test

Feature 4 - Check Eligibility
Person ID: 1111
Job ID: 4001
Output should be true
