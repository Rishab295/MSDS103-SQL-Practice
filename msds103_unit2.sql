-- ============================================================
-- PART 1: CREATE DATABASE
-- ============================================================
CREATE DATABASE msds103_unit2;

USE msds103_unit2;

SELECT DATABASE();

-- ============================================================
-- PART 2: CREATE TABLES
-- DDL - CREATE
-- ============================================================

-- ------------------------------------------------------------
-- 2.1 DEPARTMENTS TABLE
-- ------------------------------------------------------------

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);


-- ------------------------------------------------------------
-- 2.2 EMPLOYEES TABLE
-- manager_id refers to another employee
-- ------------------------------------------------------------

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dept_id INT,
    salary DECIMAL(10,2),
    manager_id INT,
    hire_date DATE,

    CONSTRAINT fk_employee_department
        FOREIGN KEY (dept_id)
        REFERENCES departments(dept_id),

    CONSTRAINT fk_employee_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees(emp_id)
);


-- ------------------------------------------------------------
-- 2.3 PRODUCTS TABLE
-- ------------------------------------------------------------

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2)
);


-- ------------------------------------------------------------
-- 2.4 ORDERS TABLE
-- ------------------------------------------------------------

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    emp_id INT,
    product_id INT,
    qty INT,
    order_date DATE,

    CONSTRAINT fk_order_employee
        FOREIGN KEY (emp_id)
        REFERENCES employees(emp_id),

    CONSTRAINT fk_order_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- ------------------------------------------------------------
-- 2.5 REGIONS TABLE
-- Used later for CROSS JOIN
-- ------------------------------------------------------------

CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region VARCHAR(50)
);

-- ============================================================
-- PART 3: CHECK TABLE STRUCTURE
-- ============================================================

-- Show all tables
SHOW TABLES;

-- Describe each table
DESCRIBE departments;
DESCRIBE employees;
DESCRIBE products;
DESCRIBE orders;
DESCRIBE regions;

-- ============================================================
-- PART 4: INSERT DATA
-- DML - INSERT
-- ============================================================

-- ------------------------------------------------------------
-- 4.1 INSERT DEPARTMENTS
-- ------------------------------------------------------------

INSERT INTO departments
(dept_id, dept_name, location)
VALUES
(1, 'Data Science', 'Pune'),
(2, 'IT', 'Mumbai'),
(3, 'Sales', 'Delhi'),
(4, 'HR', 'Bangalore'),
(5, 'Finance', 'Hyderabad'),
(6, 'Marketing', 'Chennai');

-- Check data
SELECT * FROM departments;

-- ------------------------------------------------------------
-- 4.2 INSERT EMPLOYEES
-- First insert managers
-- ------------------------------------------------------------

INSERT INTO employees
(emp_id, name, dept_id, salary, manager_id, hire_date)
VALUES
(101, 'Amit Sharma', 1, 85000, NULL, '2019-01-15'),
(102, 'Priya Patil', 2, 95000, NULL, '2018-06-10'),
(103, 'Rahul Mehta', 3, 90000, NULL, '2019-03-20'),
(104, 'Sneha Kulkarni', 4, 80000, NULL, '2020-01-05'),
(105, 'Vikram Joshi', 5, 88000, NULL, '2018-11-12');


-- ------------------------------------------------------------
-- Insert employees reporting to managers
-- ------------------------------------------------------------

INSERT INTO employees
(emp_id, name, dept_id, salary, manager_id, hire_date)
VALUES
(106, 'Neha Desai', 1, 65000, 101, '2021-02-15'),
(107, 'Rohan Shah', 1, 72000, 101, '2022-04-18'),
(108, 'Kiran More', 2, 60000, 102, '2021-07-22'),
(109, 'Pooja Singh', 2, 68000, 102, '2022-01-10'),
(110, 'Arjun Rao', 3, 55000, 103, '2021-08-14'),
(111, 'Meena Nair', 3, 62000, 103, '2020-09-19'),
(112, 'Suresh Iyer', 4, 52000, 104, '2022-03-11'),
(113, 'Anjali Verma', 5, 58000, 105, '2021-05-30'),
(114, 'Raj Malhotra', NULL, 50000, NULL, '2023-02-01');

-- Check data
SELECT * FROM employees;

-- ------------------------------------------------------------
-- 4.3 INSERT PRODUCTS
-- ------------------------------------------------------------

INSERT INTO products
(product_id, name, category, price)
VALUES
(201, 'Laptop', 'Electronics', 75000),
(202, 'Monitor', 'Electronics', 25000),
(203, 'Keyboard', 'Accessories', 3000),
(204, 'Mouse', 'Accessories', 1500),
(205, 'Office Chair', 'Furniture', 12000),
(206, 'Desk', 'Furniture', 18000),
(207, 'Tablet', 'Electronics', 35000),
(208, 'Headset', 'Accessories', 5000);

SELECT * FROM products;

-- ------------------------------------------------------------
-- 4.4 INSERT ORDERS
-- ------------------------------------------------------------

INSERT INTO orders
(order_id, emp_id, product_id, qty, order_date)
VALUES
(301, 106, 201, 2, '2024-01-10'),
(302, 107, 202, 3, '2024-01-15'),
(303, 108, 203, 5, '2024-01-20'),
(304, 109, 204, 10, '2024-02-05'),
(305, 110, 205, 2, '2024-02-12'),
(306, 111, 206, 1, '2024-02-20'),
(307, 106, 207, 2, '2024-03-01'),
(308, 107, 208, 4, '2024-03-05'),
(309, 108, 201, 1, '2024-03-15'),
(310, 109, 202, 2, '2024-03-20'),
(311, 110, 203, 8, '2024-04-02'),
(312, 111, 204, 12, '2024-04-10'),
(313, 112, 205, 3, '2024-04-18'),
(314, 113, 206, 2, '2024-05-01'),
(315, 106, 201, 1, '2024-05-10'),
(316, 107, 207, 3, '2024-05-15');

SELECT * FROM orders;

-- ------------------------------------------------------------
-- 4.5 INSERT REGIONS
-- ------------------------------------------------------------

INSERT INTO regions
(region_id, region)
VALUES
(1, 'North'),
(2, 'South'),
(3, 'East'),
(4, 'West');

SELECT * FROM regions;

-- ============================================================
-- PART 5: BASIC SELECT QUERIES
-- ============================================================

-- Display all employees
SELECT *
FROM employees;


-- Display selected columns
SELECT
    emp_id,
    name,
    salary
FROM employees;


-- Column aliases
SELECT
    name AS employee_name,
    salary AS employee_salary
FROM employees;


-- DISTINCT
-- Display unique department IDs
SELECT DISTINCT dept_id
FROM employees;

-- ============================================================
-- PART 6: WHERE CLAUSE
-- ============================================================

-- Salary greater than 70000
SELECT *
FROM employees
WHERE salary > 70000;


-- Salary equal to 65000
SELECT *
FROM employees
WHERE salary = 65000;


-- Salary between 60000 and 80000
SELECT *
FROM employees
WHERE salary BETWEEN 60000 AND 80000;


-- Employees from department 1
SELECT *
FROM employees
WHERE dept_id = 1;


-- Multiple conditions using AND
SELECT *
FROM employees
WHERE salary > 60000
AND dept_id = 1;


-- Using OR
SELECT *
FROM employees
WHERE dept_id = 1
OR dept_id = 2;


-- Using IN
SELECT *
FROM employees
WHERE dept_id IN (1, 2, 3);


-- Using NOT IN
SELECT *
FROM employees
WHERE dept_id NOT IN (1, 2);


-- Names starting with A
SELECT *
FROM employees
WHERE name LIKE 'A%';


-- Names containing 'a'
SELECT *
FROM employees
WHERE name LIKE '%a%';


-- Employees without department
SELECT *
FROM employees
WHERE dept_id IS NULL;


-- Employees having a department
SELECT *
FROM employees
WHERE dept_id IS NOT NULL;

-- ============================================================
-- PART 7: ORDER BY
-- ============================================================

-- Salary ascending
SELECT *
FROM employees
ORDER BY salary ASC;


-- Salary descending
SELECT *
FROM employees
ORDER BY salary DESC;


-- Multiple columns
SELECT *
FROM employees
ORDER BY dept_id ASC, salary DESC;

-- ============================================================
-- PART 8: UPDATE
-- ============================================================

-- Give employee 106 a 10% salary raise
UPDATE employees
SET salary = salary * 1.10
WHERE emp_id = 106;


-- Verify the update
SELECT *
FROM employees
WHERE emp_id = 106;


-- Increase salary of department 1 employees by 5%
UPDATE employees
SET salary = salary * 1.05
WHERE dept_id = 1;

-- ============================================================
-- PART 9: DELETE
-- ============================================================

-- Delete employee 114
DELETE FROM employees
WHERE emp_id = 114;


-- Verify deletion
SELECT *
FROM employees
WHERE emp_id = 114;

-- ============================================================
-- PART 10: ALTER TABLE
-- ============================================================

-- Add a new column
ALTER TABLE products
ADD stock INT;


-- Check table structure
DESCRIBE products;


-- Give every product stock of 100
UPDATE products
SET stock = 100;


-- Modify the column
ALTER TABLE products
MODIFY stock INT DEFAULT 0;


-- Rename the column
ALTER TABLE products
RENAME COLUMN stock TO stock_quantity;

-- ============================================================
-- PART 11: TRUNCATE
-- ============================================================

-- Create a temporary table
CREATE TABLE test_table (
    id INT,
    description VARCHAR(100)
);


-- Insert test data
INSERT INTO test_table
VALUES
(1, 'Test A'),
(2, 'Test B'),
(3, 'Test C');


-- Check data
SELECT *
FROM test_table;


-- Remove ALL rows
TRUNCATE TABLE test_table;


-- Check again
SELECT *
FROM test_table;


-- Remove the entire table
DROP TABLE test_table;

-- ============================================================
-- PART 12: INNER JOIN
-- ============================================================

-- Display employee and department
-- Only matching records are returned

SELECT
    e.emp_id,
    e.name,
    d.dept_name,
    d.location
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;

-- ============================================================
-- PART 13: LEFT OUTER JOIN
-- ============================================================

-- Display ALL employees
-- Even employees without a department

SELECT
    e.emp_id,
    e.name,
    d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;


-- Find employees without departments

SELECT
    e.emp_id,
    e.name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- ============================================================
-- PART 14: RIGHT OUTER JOIN
-- ============================================================

-- Display ALL departments
-- Even departments without employees

SELECT
    d.dept_name,
    e.name
FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id;


-- Find departments without employees

SELECT
    d.dept_id,
    d.dept_name
FROM employees e
RIGHT JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

-- ============================================================
-- PART 15: SELF JOIN
-- ============================================================

-- Display employee and manager

SELECT
    e.name AS employee,
    m.name AS manager
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id;


-- Employee + employee salary + manager + manager salary

SELECT
    e.name AS employee,
    e.salary AS employee_salary,
    m.name AS manager,
    m.salary AS manager_salary
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id;


-- Find employees earning more than their manager

SELECT
    e.name AS employee,
    e.salary AS employee_salary,
    m.name AS manager,
    m.salary AS manager_salary
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;

-- ============================================================
-- PART 16: CROSS JOIN
-- ============================================================

-- Every employee-region combination

SELECT
    e.name,
    r.region
FROM employees e
CROSS JOIN regions r;


-- Every product-region combination

SELECT
    p.name AS product,
    r.region
FROM products p
CROSS JOIN regions r;


-- Count all combinations

SELECT COUNT(*) AS total_combinations
FROM products
CROSS JOIN regions;

-- ============================================================
-- PART 17: MULTI-TABLE JOIN
-- ============================================================

-- Employee + Department + Order + Product

SELECT
    e.name AS employee,
    d.dept_name,
    p.name AS product,
    o.qty,
    o.order_date
FROM orders o
JOIN employees e
ON o.emp_id = e.emp_id
JOIN departments d
ON e.dept_id = d.dept_id
JOIN products p
ON o.product_id = p.product_id;

-- ============================================================
-- PART 18: ORDER VALUE
-- ============================================================

-- Formula:
-- Order Value = Quantity × Product Price

SELECT
    o.order_id,
    p.name AS product,
    o.qty,
    p.price,
    o.qty * p.price AS order_value
FROM orders o
JOIN products p
ON o.product_id = p.product_id;

-- ============================================================
-- PART 19: SCALAR SUBQUERY
-- ============================================================

-- Employees earning above overall average salary

SELECT
    name,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


-- Employees earning below average salary

SELECT
    name,
    salary
FROM employees
WHERE salary < (
    SELECT AVG(salary)
    FROM employees
);


-- Employee with maximum salary

SELECT
    name,
    salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);


-- Employee with minimum salary

SELECT
    name,
    salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

-- ============================================================
-- PART 20: IN SUBQUERY
-- ============================================================

-- Employees working in departments
-- located in Pune or Mumbai

SELECT
    name,
    dept_id
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE location IN ('Pune', 'Mumbai')
);


-- Employees belonging to departments
-- whose name contains 'Data'

SELECT
    name,
    dept_id
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE dept_name LIKE '%Data%'
);

-- ============================================================
-- PART 21: EXISTS
-- ============================================================

-- Departments having at least one employee

SELECT
    d.dept_id,
    d.dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);


-- Departments having NO employees

SELECT
    d.dept_id,
    d.dept_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);

-- ============================================================
-- PART 22: CORRELATED SUBQUERY
-- ============================================================

-- Employees earning above
-- their own department's average salary

SELECT
    e.name,
    e.dept_id,
    e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);

-- ============================================================
-- PART 23: AGGREGATE FUNCTIONS
-- ============================================================

-- COUNT
SELECT COUNT(*) AS total_employees
FROM employees;


-- SUM
SELECT SUM(salary) AS total_salary
FROM employees;


-- AVG
SELECT AVG(salary) AS average_salary
FROM employees;


-- MIN
SELECT MIN(salary) AS minimum_salary
FROM employees;


-- MAX
SELECT MAX(salary) AS maximum_salary
FROM employees;


-- All aggregate functions together

SELECT
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;

-- ============================================================
-- PART 24: GROUP BY
-- ============================================================

-- Number of employees per department

SELECT
    dept_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY dept_id;


-- Average salary per department

SELECT
    dept_id,
    AVG(salary) AS average_salary
FROM employees
GROUP BY dept_id;


-- Minimum and maximum salary per department

SELECT
    dept_id,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees
GROUP BY dept_id;

-- ============================================================
-- PART 25: GROUP BY + HAVING
-- ============================================================

-- Departments with average salary > 60000

SELECT
    dept_id,
    AVG(salary) AS average_salary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 60000;


-- Departments having more than 2 employees

SELECT
    dept_id,
    COUNT(*) AS employee_count
FROM employees
GROUP BY dept_id
HAVING COUNT(*) > 2;

-- ============================================================
-- PART 26: WHERE + GROUP BY + HAVING
-- ============================================================

-- Employees hired after 2020
-- Group them by department
-- Keep departments whose average salary > 55000

SELECT
    dept_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM employees
WHERE hire_date >= '2020-01-01'
GROUP BY dept_id
HAVING AVG(salary) > 55000
ORDER BY average_salary DESC;

-- ============================================================
-- PART 27: JOIN + GROUP BY
-- ============================================================

-- Number of employees per department

SELECT
    d.dept_name,
    COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;


-- Average salary by department

SELECT
    d.dept_name,
    AVG(e.salary) AS average_salary
FROM departments d
JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY average_salary DESC;

-- ============================================================
-- PART 28: SALES / REVENUE ANALYSIS
-- ============================================================

-- Total revenue

SELECT
    SUM(o.qty * p.price) AS total_revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id;


-- Revenue by product

SELECT
    p.name AS product,
    SUM(o.qty) AS total_quantity,
    SUM(o.qty * p.price) AS total_revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_revenue DESC;


-- Revenue by category

SELECT
    p.category,
    SUM(o.qty * p.price) AS total_revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- ============================================================
-- PART 29: REVENUE BY EMPLOYEE
-- ============================================================

SELECT
    e.name AS employee,
    SUM(o.qty * p.price) AS total_revenue
FROM orders o
JOIN employees e
ON o.emp_id = e.emp_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY e.emp_id, e.name
ORDER BY total_revenue DESC;

-- ============================================================
-- PART 30: REVENUE BY DEPARTMENT
-- ============================================================

SELECT
    d.dept_name,
    SUM(o.qty * p.price) AS total_revenue
FROM orders o
JOIN employees e
ON o.emp_id = e.emp_id
JOIN departments d
ON e.dept_id = d.dept_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_revenue DESC;

-- ============================================================
-- PART 31: HAVING WITH REVENUE
-- ============================================================

-- Departments with revenue greater than 100000

SELECT
    d.dept_name,
    SUM(o.qty * p.price) AS total_revenue
FROM orders o
JOIN employees e
ON o.emp_id = e.emp_id
JOIN departments d
ON e.dept_id = d.dept_id
JOIN products p
ON o.product_id = p.product_id
GROUP BY d.dept_id, d.dept_name
HAVING SUM(o.qty * p.price) > 100000;

-- ============================================================
-- PART 32: TOP PRODUCTS
-- ============================================================

-- Top 5 products by revenue

SELECT
    p.name AS product,
    SUM(o.qty * p.price) AS revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY revenue DESC
LIMIT 5;

-- ============================================================
-- PART 33: DATE-BASED ANALYSIS
-- ============================================================

-- Revenue by year

SELECT
    YEAR(o.order_date) AS order_year,
    SUM(o.qty * p.price) AS revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY YEAR(o.order_date);


-- Revenue by month

SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(o.qty * p.price) AS revenue
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;
    
-- ============================================================
-- PART 34: TCL - TRANSACTION CONTROL
-- ============================================================

-- ------------------------------------------------------------
-- ROLLBACK
-- Undo changes
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE emp_id = 106;

-- Check the temporary change
SELECT *
FROM employees
WHERE emp_id = 106;

-- Undo the change
ROLLBACK;

-- Check again
SELECT *
FROM employees
WHERE emp_id = 106;


-- ------------------------------------------------------------
-- COMMIT
-- Permanently save changes
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE emp_id = 106;

-- Save the change
COMMIT;

-- Verify
SELECT *
FROM employees
WHERE emp_id = 106;

-- ============================================================
-- PART 35: SAVEPOINT
-- ============================================================

START TRANSACTION;


-- First change
UPDATE employees
SET salary = salary + 1000
WHERE emp_id = 106;

SAVEPOINT salary_change_1;


-- Second change
UPDATE employees
SET salary = salary + 2000
WHERE emp_id = 107;

SAVEPOINT salary_change_2;


-- Third change
UPDATE employees
SET salary = salary + 3000
WHERE emp_id = 108;


-- Roll back to the second savepoint
ROLLBACK TO SAVEPOINT salary_change_2;


-- Commit remaining changes
COMMIT;

-- ============================================================
-- PART 36: DCL - GRANT / REVOKE
-- ============================================================

-- Create a practice user

CREATE USER IF NOT EXISTS
'msds_student'@'localhost'
IDENTIFIED BY 'Student@123';


-- Give SELECT permission

GRANT SELECT
ON msds103_unit2.*
TO 'msds_student'@'localhost';


-- Give INSERT permission

GRANT INSERT
ON msds103_unit2.*
TO 'msds_student'@'localhost';


-- Check permissions

SHOW GRANTS
FOR 'msds_student'@'localhost';


-- Remove INSERT permission

REVOKE INSERT
ON msds103_unit2.*
FROM 'msds_student'@'localhost';


-- Check permissions again

SHOW GRANTS
FOR 'msds_student'@'localhost';

-- ============================================================
-- PART 37: USEFUL INFORMATION COMMANDS
-- ============================================================

-- Current database
SELECT DATABASE();


-- Current user
SELECT USER();


-- MySQL version
SELECT VERSION();


-- List databases
SHOW DATABASES;


-- List tables
SHOW TABLES;

