'''



'''

import pymysql
import pymysql.cursors


username = 'newuser'
password = 'newpassword'

def handle_exception(e, desc):
    print(f'Exception: {desc}\n> {e}\n')

def delete_tables(connection):
    tables = ['Associated_With', 'References_', 'Work_Experience', 'Minimum_Job_Requirements', 'Institute_Departments', 'Educational_Qualifications', 'Contains_Department', 'Department', 'Institute_Offers', 'Courses', 'Educational_Institutes', 'Person', 'Jobs', 'Institutes', 'Project_Field', 'Fields', 'Project']
    
    with connection.cursor() as cursor:
        for table in tables:
            try:
                query = f"drop table {table};"
                cursor.execute(query)
            except Exception as e:
                print(f'Error {e} while dropping {table}')

    connection.commit()

def create_tables(connection):
    create_project                    = "create table Project(Project_Id int primary key, Type_ varchar(50) check (Type_ IN ('Research', 'Development','Engineering','Machine Learning','Data Science')), Description varchar(200));"
    create_fields                     = "create table Fields(Field_Id int primary key,Field_ varchar(50));"
    create_project_field              = "create table Project_Field(Project_Id int,Field_Id int,foreign key (Project_Id) references Project (Project_Id) ON DELETE CASCADE,foreign key (Field_Id) references Fields (Field_Id)  ON DELETE CASCADE,primary key(Project_id, Field_Id));"
    create_institutes                 = "create table Institutes(Institute_Id int primary key,Name varchar(50) not null,Type varchar(50) check (Type in ('Company', 'University')),Project_Id int,foreign key (Project_Id) references Project (Project_Id)  ON DELETE CASCADE);"
    create_jobs                       = "create table Jobs(Job_Id int primary key,Job_Description varchar(200) not null,Institute_Id int,Salary int check (Salary > 0),Start_Date date,End_Date date,Type varchar(50) check (Type IN ('Software Developer', 'Project Manager', 'Researcher')),Duration_Worked int,foreign key (Institute_Id) references Institutes (Institute_Id)  ON DELETE CASCADE);"
    create_person                     = "create table Person(Person_Id int primary key,Name varchar(50),Aadhar_Number int unique not null,Job_Id int, Phone_Number varchar(50),Date_of_Birth date,Age int,Gender varchar(10),Foreign key(Job_Id) references Jobs(Job_Id)  ON DELETE CASCADE);"
    create_educational_institutes     = "create table Educational_Institutes(Educational_Institute_Id int primary key,Name varchar(50) not null,Type varchar(50) check (Type in ('School', 'University')));"
    create_courses                    = "create table Courses(Course_Id int primary key,Course varchar(50)); "
    create_institute_offers           = "create table Institute_Offers(Educational_Institute_Id int,Course_Id int,foreign key (Educational_Institute_Id) references Educational_Institutes (Educational_Institute_Id)  ON DELETE CASCADE,foreign key (Course_Id) references Courses (Course_Id)  ON DELETE CASCADE);"
    create_department                 = "create table Department(Department_Id int primary key,Department varchar(50));"
    create_contains_department        = "create table Contains_Department(Educational_Institute_Id int,Department_Id int,foreign key (Educational_Institute_Id) references Educational_Institutes (Educational_Institute_Id) ON DELETE CASCADE,foreign key (Department_Id) references Department (Department_Id)  ON DELETE CASCADE,primary key (Educational_Institute_Id, Department_Id));"
    create_educational_qualifications = "create table Educational_Qualifications(Person_Id int,Educational_Institute_Id int,Description varchar(200),CGPA float check (CGPA >= 0 and CGPA <= 10),Qualifications varchar(50) check (Qualifications in ('PhD', 'Masters', 'Bachelors','Senior Secondary')),foreign key (Person_Id) references Person (Person_Id) ON DELETE CASCADE,foreign key (Educational_Institute_Id) references Educational_Institutes (Educational_Institute_Id) ON DELETE CASCADE);"
    create_institute_departments      = "create table Institute_Departments(Institute_Id INT,Department_Name varchar(50),Project_Id int,primary key(Institute_Id,Department_Name),foreign key(Institute_Id) references Institutes(Institute_Id) ON DELETE CASCADE,foreign key (Project_Id) references Project(Project_Id) ON DELETE CASCADE);"
    create_minimum_job_requirements   = "create table Minimum_Job_Requirements(Job_Id int, Min_Years_of_Experience float, Min_Qualifications varchar(50) check (Min_Qualifications in ('PhD', 'Masters', 'Bachelors','Senior Secondary')), Min_CGPA float,foreign key(Job_Id) references Jobs(Job_Id) ON DELETE CASCADE);"
    create_work_experience            = "create table Work_Experience(Person_Id INT, Job_Id INT, Number_of_Years INT, foreign key(Person_Id) references Person(Person_Id) ON DELETE CASCADE, foreign key(Job_Id) references Jobs(Job_Id) ON DELETE CASCADE);"
    create_references                 = "create table References_(Person_Id int,Institute_Id int, Job_Id int,foreign key (Person_Id) references Person(Person_Id) ON DELETE CASCADE,foreign key(Job_Id) references Jobs(Job_Id) ON DELETE CASCADE, foreign key (Institute_Id) references Institutes(Institute_Id) ON DELETE CASCADE);"
    create_associated_with            = "create table Associated_With(Person_Id int,Institute_Id int,Job_Id INT,Project_Id int,foreign key (Person_Id) references Person(Person_Id) ON DELETE CASCADE,foreign key(Institute_Id) references Institutes(Institute_Id) ON DELETE CASCADE,foreign key(Institute_Id) references Institutes(Institute_Id) ON DELETE CASCADE,foreign key(Project_Id) references Project(Project_Id) ON DELETE CASCADE);"
    
    create_tables_list = [
        create_project,
        create_fields,
        create_project_field,
        create_institutes,
        create_jobs,
        create_person,
        create_educational_institutes,
        create_courses,
        create_institute_offers,
        create_department,
        create_contains_department,
        create_educational_qualifications,
        create_institute_departments,
        create_minimum_job_requirements,
        create_work_experience,
        create_references,
        create_associated_with
    ]


    with connection.cursor() as cursor:
        for create_query in create_tables_list:
            try:
                cursor.execute(create_query)
            except Exception as e:
                print(f'Error {e} during: {create_query}')

    connection.commit()


def insert_tables(connection):
    insert_project                    = "insert into Project values(1,'Research','Creating a 3d model from a 2d image'),(2, 'Research', 'Decision making'),(3,'Engineering','Speech Detection - Detect from which region a person is'),(4, 'Engineering', 'Enhance User Experience'),(5,'Research','Computer Graphics - Making computer graphics look realistic'),(6,'Development','GTA 8 a very popular open world game'),(7, 'Development', 'Red Dead Redemption 3'),(8,'Engineering','Making a robot who has emotions'),(9,'Machine Learning','Remove from a model all the traces of a selected data point'),(10,'Machine Learning','Using Reinforcement Learning for choosing an Ansatz for Variational Algorithms'),(11,'Machine Learning','Transformer Conversational Chatbot in Python using TensorFlow 2.0'),(12, 'Data Science', 'Fake news Detection');"
    insert_fields                     = "insert into Fields values(1, 'Computer Vision'),(2, 'Game Theory'),(3, 'Natural Language Processing'),(4, 'User Experience Development'),(5, 'Game Development'),(6, 'Robotics'),(7, 'Machine Unlearning'),(8, 'Reinforcement Learning'),(9, 'Quantum Machine Learning'),(10, 'Data Science');"
    insert_project_field              = "insert into Project_Field values(1, 1),(2, 2),(3, 3),(4, 4),(5, 1),(6, 5),(7, 5),(8, 6),(9, 7),(10, 8),(11, 9),(12, 10);"
    insert_institutes                 = "insert into Institutes values(1, 'IIITH', 'University', 1),(2, 'IIITB', 'University', 9),(13, 'Microsoft', 'Company', 3),(3, 'Qualcomm', 'Company', 9),(4, 'IITB', 'University', 2),(5, 'IIITD', 'University', 5),(6, 'Google', 'Company', 4),(7, 'Rockstar North', 'Company', 6),(8, 'Rockstar South', 'Company', 7),(9, 'IITD', 'University', 8),(10, 'MIT', 'University', 10),(11, 'IIITV', 'University', 11),(12, 'Uber', 'Company', 12);"
    insert_jobs                       = "insert into Jobs values(4001,'Development of GTA 8',6,5000000,'2020-10-10','2022-10-09','Software Developer',2),(4002,'Should be comfortable with Data science',12,2500000,'2019-03-09','2022-10-07','Researcher',3),(4003,'Should be comfortable with theoretical idea of machine learning',3,2000000,'2018-10-10','2022-10-10','Researcher',4),(4004,'Should be comfortable with robotics',9,1500000,'2017-08-09','2019-10-10','Researcher',2);"
    insert_person                     = "insert into Person values(1111,'Aryaman Kolhe',6677,Null,9889360562,'2000-08-09',22,'Male'),(1112,'Vrinda Agarwal',8899,Null,8874577777,'2002-10-07',20,'Female'),(1113,'Prakhar Jain',9987,Null,7007905500,'2001-12-10',21,'Male'),(1114,'Kunal Bhosikar',9986,null,7007123232,'1999-09-17',23,'Male'),(1115,'Bhumika Joshi',0967,null,9305512623,'2004-10-07',18,'Female'),(1116,'Ashwini Kulkarni',6734,null,9979997980,'2002-09-30',20,'Female'),(1117,'Ashani Pandey',6756,null,9889360567,'1997-08-08',25,'Female'),(1118,'Faizal Karim',8974,null,7007123456,'1979-07-07',43,'Male'),(1119,'Eshan Gupta',6720,null,9889360569,'1999-09-09',23,'Male'),(1120,'Mahika Jain',7820,null,93055126908,'2004-10-10',18,'Female'),(1121,'Sannidhya Gupta',9089,null,9009876523,'2003-11-09',19,'Male');"
    insert_educational_institutes     = "insert into Educational_Institutes values(2006, 'MIT', 'University'),(2002, 'GD Goenka Public School', 'School'),(2003, 'IITB', 'University'),(2004, 'IITD', 'University'),(2005, 'DPS', 'School'),(2001, 'IIITH', 'University'),(2007, 'VIT', 'University'),(2008, 'DAV', 'School'),(2009, 'Kunskapskolan', 'School'),(2010, 'Stanford', 'University');"
    insert_courses                    = "insert into Courses values(301, 'Intro to Programming'),(302, 'Digital Systems And Microcontrollers'),(303, 'Intro to Stochastic Processes'),(304, 'Data And Applications'),(305, 'Algorithm Analysis and Design'),(306, 'Principles Of Programming Languages'),(307, 'Intro to NLP'),(308, 'Intro to Human Sciences'),(309, 'Advanced NLP'),(310, 'Intro to Blockchain'),(311, 'Intro to Machine Learning'),(312, 'Intro to Artificial Intelligence'),(313, 'Data Science and Applications'),(314, 'Distributed Systems'),(315, 'Intro to Game Theory'),(316, 'Computer Vision'),(317, 'Intro to Software Systems'),(318, 'Signal Processing'),(319, 'Computational Linguistics'),(320, 'Intro to Computational Social Science'),(321, 'Intro to Quantum Computing');"
    insert_institute_offers           = "insert into Institute_Offers values(2001, 301),(2001, 320),(2002, 302),(2002, 319),(2003, 303),(2003, 318),(2004, 304),(2004, 317),(2005, 305),(2005, 316),(2006, 306),(2006, 315),(2007, 307),(2007, 314),(2008, 308),(2008, 313),(2009, 309),(2009, 312),(2010, 310),(2010, 311),(2006, 321);"
    insert_department                 = "insert into Department values(1, 'Language Department'),(2, 'Electronics Department'),(3, 'Computer Science Department'),(4, 'Mathematics Department'),(5, 'Human Science Department'),(6, 'Quantum Department');"
    insert_contains_department        = "insert into Contains_Department values(2001, 3),(2001, 5),(2002, 1),(2002, 2),(2003, 2),(2003, 4),(2004, 3),(2005, 3),(2006, 3),(2006, 6),(2007, 1),(2007, 3),(2008, 3),(2008, 5),(2009, 1),(2009, 3),(2010, 3);"
    insert_educational_qualifications = "insert into Educational_Qualifications values(1111, 2007, 'In Computer Science', 9.8, 'Bachelors'),(1112, 2010, 'In Electronics', 9.9, 'Bachelors'),(1113, 2006, 'In Computer Science', 7.8, 'Masters'),(1114, 2003, 'In Robotics', 8.9, 'Bachelors'),(1115, 2004, 'In Computer Vision', 8.5, 'Masters'),(1116, 2001, 'In Machine Learning', 9.0, 'PhD'),(1117, 2007, 'In Artificial Intelligence', 9.5, 'PhD'),(1118, 2008, 'In Science', 9.4, 'Senior Secondary'),(1119, 2005, 'In Science', 9.6, 'Senior Secondary'),(1120,2001,'In Electronics and Telecommunication',9.4,'Bachelors'),(1121, 2005, 'In Science', 9.7, 'Senior Secondary');"
    insert_institute_departments      = "insert into Institute_Departments values(13, 'Machine Learning Department', 3),(3, 'Quantum Department', 9),(6, 'Development Department', 4),(7, 'Development Department', 6),(8, 'Development Department', 7),(12, 'Data Science Department', 12);"
    insert_minimum_job_requirements   = "insert into Minimum_Job_Requirements values(4001, 2, 'Bachelors',4.8),(4002, 1, 'Masters',7.7),(4003, 5, 'Masters',7.5),(4004, 2, 'PhD',5.5);"
    insert_work_experience            = "insert into Work_Experience values(1111, 4001,3),(1113, 4002,2),(1115, 4003,6),(1116, 4004,3);"
    insert_references_                = "insert into References_ values(1111, 6, 4001),(1113, 12, 4002),(1115, 3, 4003),(1116, 9, 4004);"
    insert_associated_with            = "insert into Associated_With values(1111, 6, 4001, 4),(1113, 12, 4002, 12),(1115, 3, 4003, 9),(1116, 9, 4004, 8);"

    insert_tabes_list = [
        insert_project,
        insert_fields,
        insert_project_field,
        insert_institutes,
        insert_jobs,
        insert_person,
        insert_educational_institutes,
        insert_courses,
        insert_institute_offers,
        insert_department,
        insert_contains_department,
        insert_educational_qualifications,
        insert_institute_departments,
        insert_minimum_job_requirements,
        insert_work_experience,
        insert_references_,
        insert_associated_with
    ]

    with connection.cursor() as cursor:
        for insert_query in insert_tabes_list:
            try:
                cursor.execute(insert_query)
            except Exception as e:
                print(f'Error {e} during: {insert_query}')

    connection.commit()


try:
    connection = pymysql.connect(host='localhost',
        port=13306,
        user=username,
        password=password,
        db='jobs_db',
        cursorclass=pymysql.cursors.DictCursor)

    if connection.open:
        print('Connection established')
        delete_tables(connection)
        print("Old Tables tables deleted successfully")
        create_tables(connection)
        print("New Tables made successfully")
        insert_tables(connection)
        print("All Tables populated successfully")


except Exception as e:
    print(e)
    print('Connection Refused: either username or password is incorrect,')
    print('or the user doesn\'t have access to the database')
    tmp = input('Enter any key to continue')


print("\n--- Done! ---\n")
