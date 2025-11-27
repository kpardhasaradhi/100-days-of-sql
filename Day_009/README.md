# Day 009 - Understanding WHERE vs HAVING in SQL

## Problem
We have an `emp` table containing employee details such as `emp_id`, `emp_name`, `department_id`, `salary`, and `manager_id`.  
The goal is to find departments where the average salary of employees earning more than 10000 is greater than 12000.

## Table Structure
```sql
CREATE TABLE emp (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    salary INT,
    manager_id INT
);

INSERT INTO emp (emp_id, emp_name, department_id, salary, manager_id) VALUES
(1, 'Ankit', 100, 15000, 5),
(2, 'Mohit', 100, 10000, 4),
(3, 'Vikas', 100, 15000, 4),
(4, 'Rohit', 100, 12000, 2),
(5, 'Mudit', 200, 12000, 2),
(6, 'Agam', 200, 10000, 2),
(7, 'Sanjay', 200, 9000, 2),
(8, 'Ashish', 200, 5000, 2);

Task
Write a query to:

Filter employees whose salary is greater than 10000 using the WHERE clause.
Group the results by department_id.
Use the AVG() function to calculate the average salary for each department.
Apply the HAVING clause to show only departments where the average salary is greater than 12000.

Query
SELECT department_id, ROUND(AVG(salary)) AS avg_salary
FROM emp
WHERE salary > 10000
GROUP BY department_id
HAVING AVG(salary) > 12000;

Approach
● First, the goal was to find departments where the average salary of employees earning more than 10000 is above 12000.
● The WHERE clause was used first to filter out employees whose salary was less than or equal to 10000.
● Then, the data was grouped by department_id to calculate the average salary for each department using the AVG() function.
● After that, the HAVING clause was applied to filter only those departments whose average salary exceeded 12000.
● This approach highlights the difference between WHERE and HAVING, where WHERE filters rows before grouping and HAVING filters aggregated results after grouping.

Output
department_id	avg_salary
100	14000

Goal
Understand how to use WHERE and HAVING effectively in SQL to filter data before and after aggregation.
