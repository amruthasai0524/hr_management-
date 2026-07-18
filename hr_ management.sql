CREATE DATABASE hr_management_system;
USE hr_management_system;
SHOW DATABASES;

# create tables 
CREATE TABLE departments
(
department_id INT PRIMARY KEY AUTO_INCREMENT,

department_name VARCHAR(100) NOT NULL UNIQUE,

location VARCHAR(100)
);

# verification 
DESC departments;

# job
 CREATE TABLE jobs
(
job_id INT PRIMARY KEY AUTO_INCREMENT,

job_title VARCHAR(100) NOT NULL,

min_salary DECIMAL(10,2),

max_salary DECIMAL(10,2)
);


# verify 

DESC jobs;

# CREATE TABLE employees
CREATE TABLE employees
(
    employee_id INT PRIMARY KEY AUTO_INCREMENT,

    first_name VARCHAR(50),

    last_name VARCHAR(50),

    gender ENUM('Male','Female'),

    date_of_birth DATE,

    email VARCHAR(100) UNIQUE,

    phone VARCHAR(15),

    hire_date DATE,

    department_id INT,

    job_id INT,

    salary DECIMAL(10,2),

    manager_id INT,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id),

    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);

# This is called a Self Join Relationship because a manager is also an employee.


desc employees;

# projects 
CREATE TABLE projects
(
project_id INT PRIMARY KEY AUTO_INCREMENT,

project_name VARCHAR(100),

start_date DATE,

end_date DATE,

budget DECIMAL(15,2)
);

CREATE TABLE employee_project
(
employee_id INT,

project_id INT,

assigned_date DATE,

PRIMARY KEY(employee_id,project_id),

FOREIGN KEY(employee_id)
REFERENCES employees(employee_id),

FOREIGN KEY(project_id)
REFERENCES projects(project_id)
);

# One employee can work on many projects.

#One project has many employees.

# This is called a Many-to-Many Relationship.

# ATTENDENCE 
CREATE TABLE attendance
(
attendance_id INT PRIMARY KEY AUTO_INCREMENT,

employee_id INT,

attendance_date DATE,

status ENUM('Present','Absent','Leave'),

check_in TIME,

check_out TIME,

FOREIGN KEY(employee_id)
REFERENCES employees(employee_id)
);

# leaves 

CREATE TABLE leaves
(
leave_id INT PRIMARY KEY AUTO_INCREMENT,

employee_id INT,

leave_type VARCHAR(30),

start_date DATE,

end_date DATE,

status VARCHAR(30),

FOREIGN KEY(employee_id)
REFERENCES employees(employee_id)
);

# payroll

CREATE TABLE payroll
(
payroll_id INT PRIMARY KEY AUTO_INCREMENT,

employee_id INT,

basic_salary DECIMAL(10,2),

bonus DECIMAL(10,2),

deduction DECIMAL(10,2),

net_salary DECIMAL(10,2),

payment_date DATE,

FOREIGN KEY(employee_id)
REFERENCES employees(employee_id)
);


# performance 
CREATE TABLE performance
(
    performance_id INT PRIMARY KEY AUTO_INCREMENT,

    employee_id INT,

    review_date DATE,

    rating DECIMAL(3,2),

    remarks VARCHAR(255),

    FOREIGN KEY(employee_id)
    REFERENCES employees(employee_id)
);

# training
# company training programs 

CREATE TABLE training
(
    training_id INT PRIMARY KEY AUTO_INCREMENT,

    training_name VARCHAR(100),

    trainer_name VARCHAR(100),

    duration_days INT
);

# employee training 

CREATE TABLE employee_training
(
    employee_id INT,

    training_id INT,

    completion_date DATE,

    PRIMARY KEY(employee_id,training_id),

    FOREIGN KEY(employee_id)
    REFERENCES employees(employee_id),

    FOREIGN KEY(training_id)
    REFERENCES training(training_id)
);

# recruitment 
CREATE TABLE recruitment
(
    recruitment_id INT PRIMARY KEY AUTO_INCREMENT,

    job_id INT,

    opening_date DATE,

    closing_date DATE,

    vacancies INT,

    FOREIGN KEY(job_id)
    REFERENCES jobs(job_id)
);

# candidates 
CREATE TABLE candidates
(
    candidate_id INT PRIMARY KEY AUTO_INCREMENT,

    first_name VARCHAR(50),

    last_name VARCHAR(50),

    email VARCHAR(100),

    phone VARCHAR(15),

    experience_years INT
);


# interviews 


CREATE TABLE interviews
(
    interview_id INT PRIMARY KEY AUTO_INCREMENT,

    candidate_id INT,

    recruitment_id INT,

    interview_date DATE,

    result VARCHAR(30),

    FOREIGN KEY(candidate_id)
    REFERENCES candidates(candidate_id),

    FOREIGN KEY(recruitment_id)
    REFERENCES recruitment(recruitment_id)
);

# assets 


CREATE TABLE assets
(
    asset_id INT PRIMARY KEY AUTO_INCREMENT,

    employee_id INT,

    asset_name VARCHAR(100),

    issue_date DATE,

    return_date DATE,

    FOREIGN KEY(employee_id)
    REFERENCES employees(employee_id)
);


# login   



CREATE TABLE login
(
    login_id INT PRIMARY KEY AUTO_INCREMENT,

    employee_id INT,

    username VARCHAR(225) UNIQUE,

    password_hash VARCHAR(225),

    last_login DATETIME,

    FOREIGN KEY(employee_id)
    REFERENCES employees(employee_id)
);

# audit log 


CREATE TABLE audit_log
(
    log_id INT PRIMARY KEY AUTO_INCREMENT,

    employee_id INT,

    action_type VARCHAR(100),

    action_time DATETIME,

    FOREIGN KEY(employee_id)
    REFERENCES employees(employee_id)
);


# office 

CREATE TABLE office
(
    office_id INT PRIMARY KEY AUTO_INCREMENT,

    office_name VARCHAR(100),

    city VARCHAR(100),

    state VARCHAR(100),

    country VARCHAR(100)
);

# check all table s


SHOW TABLES;


DESC employees;

DESC performance;

DESC payroll;

SHOW TABLES;

SELECT COUNT(*) FROM employees;


# INSERT DEPARTMENTS 

INSERT INTO departments (department_name, location)
VALUES
('Human Resources','Hyderabad'),
('Information Technology','Bangalore'),
('Finance','Mumbai'),
('Marketing','Delhi'),
('Sales','Chennai'),
('Operations','Pune'),
('Research & Development','Hyderabad'),
('Customer Support','Noida'),
('Administration','Kolkata'),
('Legal','Bangalore');


SELECT * FROM departments;

# INSERT JOBS 

INSERT INTO jobs (job_title, min_salary, max_salary)
VALUES
('Software Engineer',40000,90000),
('Senior Software Engineer',70000,150000),
('Data Analyst',45000,95000),
('Data Scientist',70000,180000),
('HR Executive',30000,70000),
('HR Manager',60000,120000),
('Accountant',35000,80000),
('Marketing Executive',30000,70000),
('Project Manager',90000,200000),
('Database Administrator',70000,160000);

SELECT * FROM JOBS;


# INSERT OFFICE 
INSERT INTO office (office_name, city, state, country)
VALUES
('Head Office','Hyderabad','Telangana','India'),
('South Branch','Bangalore','Karnataka','India'),
('West Branch','Mumbai','Maharashtra','India'),
('North Branch','Delhi','Delhi','India'),
('East Branch','Kolkata','West Bengal','India');

SELECT * FROM OFFICE;


# INSERT EMPLOYESS

INSERT INTO employees
(first_name,last_name,gender,date_of_birth,email,phone,hire_date,department_id,job_id,salary,manager_id)
VALUES
('Rahul','Sharma','Male','1990-05-12','rahul@abc.com','9876500001','2020-01-15',2,2,90000,NULL),
('Priya','Reddy','Female','1992-08-18','priya@abc.com','9876500002','2021-02-20',1,6,85000,1),
('Amit','Verma','Male','1994-09-10','amit@abc.com','9876500003','2022-03-12',2,1,60000,1),
('Sneha','Patel','Female','1996-01-25','sneha@abc.com','9876500004','2023-04-05',3,7,55000,2),
('Kiran','Rao','Male','1995-07-11','kiran@abc.com','9876500005','2022-08-16',4,8,50000,2),
('Anjali','Devi','Female','1993-10-09','anjali@abc.com','9876500006','2021-05-18',5,8,52000,2),
('Vijay','Kumar','Male','1991-11-14','vijay@abc.com','9876500007','2020-09-22',2,3,65000,1),
('Meena','Joshi','Female','1997-03-20','meena@abc.com','9876500008','2023-01-17',7,4,80000,1),
('Arjun','Singh','Male','1992-06-15','arjun@abc.com','9876500009','2022-07-10',8,5,45000,2),
('Pooja','Nair','Female','1995-04-28','pooja@abc.com','9876500010','2023-02-11',9,5,42000,2);

SELECT * FROM EMPLOYEES;
SELECT COUNT(*) AS Employees FROM employees;





# INSERT PROJECTS 

INSERT INTO projects (project_name,start_date,end_date,budget)
VALUES
('HR Portal','2025-01-01','2025-06-30',500000),
('Payroll Automation','2025-02-15','2025-08-31',750000),
('CRM Upgrade','2025-03-01','2025-10-15',900000),
('AI Recruitment','2025-04-01','2025-12-31',1200000),
('Employee Mobile App','2025-05-01','2025-11-30',650000);

SELECT * FROM PROJECTS ;


# ASSIGNING THE EMPLOYEES TO PROJECT 

INSERT INTO employee_project
(employee_id,project_id,assigned_date)
VALUES
(1,1,'2025-01-05'),
(2,1,'2025-01-06'),
(3,2,'2025-02-20'),
(4,2,'2025-02-21'),
(5,3,'2025-03-10'),
(6,3,'2025-03-11'),
(7,4,'2025-04-15'),
(8,4,'2025-04-16'),
(9,5,'2025-05-05'),
(10,5,'2025-05-06');



SELECT * FROM employee_project;

SELECT COUNT(*) FROM employee_project;

SELECT COUNT(*) FROM table_name;


DELETE FROM jobs;

SELECT employee_id, first_name, job_id
FROM employees;



DELETE FROM jobs
WHERE job_id > 10;

SELECT job_id, job_title
FROM jobs;



SELECT COUNT(*) AS Total_Jobs
FROM jobs;


SELECT * FROM jobs;

INSERT INTO attendance
(employee_id, attendance_date, status, check_in, check_out)
VALUES
(1,'2025-07-01','Present','09:00:00','18:00:00'),
(2,'2025-07-01','Present','09:15:00','18:10:00'),
(3,'2025-07-01','Absent',NULL,NULL),
(4,'2025-07-01','Present','09:05:00','18:00:00'),
(5,'2025-07-01','Leave',NULL,NULL),
(6,'2025-07-01','Present','08:55:00','17:50:00'),
(7,'2025-07-01','Present','09:10:00','18:20:00'),
(8,'2025-07-01','Present','09:00:00','18:00:00'),
(9,'2025-07-01','Present','09:30:00','18:30:00'),
(10,'2025-07-01','Present','09:00:00','18:00:00');

SELECT * FROM attendance;

INSERT INTO leaves
(employee_id, leave_type, start_date, end_date, status)
VALUES
(5,'Sick Leave','2025-07-01','2025-07-03','Approved'),
(3,'Casual Leave','2025-07-10','2025-07-11','Approved'),
(2,'Annual Leave','2025-08-01','2025-08-05','Pending'),
(8,'Work From Home','2025-07-15','2025-07-15','Approved'),
(10,'Emergency Leave','2025-09-02','2025-09-03','Approved');

SELECT * FROM leaves;



INSERT INTO payroll
(employee_id, basic_salary, bonus, deduction, net_salary, payment_date)
VALUES
(1,90000,5000,2000,93000,'2025-07-31'),
(2,85000,4000,1500,87500,'2025-07-31'),
(3,60000,3000,1000,62000,'2025-07-31'),
(4,55000,2500,1000,56500,'2025-07-31'),
(5,50000,2000,500,51500,'2025-07-31'),
(6,52000,2000,1000,53000,'2025-07-31'),
(7,65000,3500,1500,67000,'2025-07-31'),
(8,80000,4000,2000,82000,'2025-07-31'),
(9,45000,1500,500,46000,'2025-07-31'),
(10,42000,1000,500,42500,'2025-07-31');


SELECT * FROM payroll;

INSERT INTO performance
(employee_id, review_date, rating, remarks)
VALUES
(1,'2025-06-30',4.8,'Outstanding'),
(2,'2025-06-30',4.5,'Very Good'),
(3,'2025-06-30',4.0,'Good'),
(4,'2025-06-30',3.9,'Good'),
(5,'2025-06-30',3.8,'Satisfactory'),
(6,'2025-06-30',4.2,'Very Good'),
(7,'2025-06-30',4.4,'Excellent'),
(8,'2025-06-30',4.9,'Outstanding'),
(9,'2025-06-30',3.7,'Average'),
(10,'2025-06-30',4.1,'Good');

SELECT * FROM performance;


SELECT * FROM attendance;
SELECT * FROM leaves;
SELECT * FROM payroll;
SELECT * FROM performance;

# TRAINNGN 

INSERT INTO training (training_name, trainer_name, duration_days)
VALUES
('SQL Mastery','John Smith',5),
('Python for Data Science','Alice Johnson',7),
('Power BI Dashboard','David Brown',3),
('Machine Learning Basics','Michael Lee',10),
('Leadership Skills','Sarah Wilson',2);

# EMPLOYEE TRAINING 

INSERT INTO employee_training (employee_id, training_id, completion_date)
VALUES
(1,1,'2025-07-10'),
(2,2,'2025-07-15'),
(3,3,'2025-07-20'),
(4,4,'2025-07-25'),
(5,5,'2025-07-30'),
(6,1,'2025-08-02'),
(7,2,'2025-08-05'),
(8,3,'2025-08-08'),
(9,4,'2025-08-12'),
(10,5,'2025-08-15');

# RECRUITMENT 

INSERT INTO recruitment
(job_id, opening_date, closing_date, vacancies)
VALUES
(1,'2025-08-01','2025-08-31',3),
(3,'2025-08-05','2025-09-05',2),
(4,'2025-08-10','2025-09-10',2),
(7,'2025-08-15','2025-09-15',1),
(9,'2025-08-20','2025-09-20',1);



# CANDIDATES 


INSERT INTO candidates
(first_name,last_name,email,phone,experience_years)
VALUES
('Ramesh','Kumar','ramesh@gmail.com','9000000001',2),
('Divya','Rao','divya@gmail.com','9000000002',3),
('Karthik','Reddy','karthik@gmail.com','9000000003',1),
('Neha','Sharma','neha@gmail.com','9000000004',4),
('Suresh','Patel','suresh@gmail.com','9000000005',5);


# INSTERVIEWS

INSERT INTO interviews
(candidate_id,recruitment_id,interview_date,result)
VALUES
(1,1,'2025-08-18','Selected'),
(2,2,'2025-08-19','Rejected'),
(3,3,'2025-08-20','Pending'),
(4,4,'2025-08-21','Selected'),
(5,5,'2025-08-22','Pending');

# ASSETS 
INSERT INTO assets
(employee_id,asset_name,issue_date,return_date)
VALUES
(1,'Laptop','2025-01-15',NULL),
(2,'Monitor','2025-02-01',NULL),
(3,'Keyboard','2025-03-10',NULL),
(4,'Mouse','2025-03-12',NULL),
(5,'Laptop','2025-04-05',NULL);


# LOGIN

INSERT INTO login
(employee_id,username,password_hash,last_login)
VALUES
(1,'rahul','hash123','2025-07-17 09:10:00'),
(2,'priya','hash456','2025-07-17 09:05:00'),
(3,'amit','hash789','2025-07-17 09:20:00'),
(4,'sneha','hash101','2025-07-17 09:00:00'),
(5,'kiran','hash202','2025-07-17 09:30:00');

# AUDIT LOG 


INSERT INTO audit_log
(employee_id,action_type,action_time)
VALUES
(1,'Login','2025-07-17 09:10:00'),
(2,'Update Profile','2025-07-17 10:15:00'),
(3,'Password Change','2025-07-17 11:20:00'),
(4,'Logout','2025-07-17 17:55:00'),
(5,'Login','2025-07-17 09:30:00');


# VERIFYING EVERYTHING 


SELECT COUNT(*) FROM training;
SELECT COUNT(*) FROM employee_training;
SELECT COUNT(*) FROM recruitment;
SELECT COUNT(*) FROM candidates;
SELECT COUNT(*) FROM interviews;
SELECT COUNT(*) FROM assets;
SELECT COUNT(*) FROM login;
SELECT COUNT(*) FROM audit_log;









