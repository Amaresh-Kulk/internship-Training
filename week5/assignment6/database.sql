create database sampleEmployee;

use sampleEmployee;

create table Employees	(
	employee_id INT PRIMARY KEY identity(101, 1),
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50) not null,
    department VARCHAR(50) not null
)
ALTER TABLE Employees
ADD phone_number VARCHAR(10);

INSERT INTO Employees (name, position, department) VALUES
('Alice Johnson', 'Manager', 'Sales'),
('Bob Smith', 'Engineer', 'IT'),
('Carol Davis', 'Analyst', 'Finance'),
('David Wilson', 'Technician', 'Maintenance'),
('Emma Brown', 'HR Specialist', 'Human Resources'),
('Frank Miller', 'Designer', 'Marketing'),
('Grace Lee', 'Developer', 'IT'),
('Henry Clark', 'Accountant', 'Finance'),
('Ivy Lewis', 'Assistant', 'Administration'),
('Jack White', 'Supervisor', 'Production');

UPDATE Employees SET phone_number = '9876543210' WHERE employee_id = 101;
UPDATE Employees SET phone_number = '9123456780' WHERE employee_id = 102;
UPDATE Employees SET phone_number = '9988776655' WHERE employee_id = 103;
UPDATE Employees SET phone_number = '9012345678' WHERE employee_id = 104;
UPDATE Employees SET phone_number = '9090909090' WHERE employee_id = 105;
UPDATE Employees SET phone_number = '9345678901' WHERE employee_id = 106;
UPDATE Employees SET phone_number = '9789012345' WHERE employee_id = 107;
UPDATE Employees SET phone_number = '9654321098' WHERE employee_id = 108;
UPDATE Employees SET phone_number = '9567890123' WHERE employee_id = 109;
UPDATE Employees SET phone_number = '9445566778' WHERE employee_id = 110;

select * from Employees
