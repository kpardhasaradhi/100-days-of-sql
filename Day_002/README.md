Day 2 – Employee vs Manager Salary Problem: Given an employee table with emp_id, emp_name, salary, and manager_id, find employees earning more than their managers.

Concepts used:
SELF JOIN to compare employee and manager records
WHERE clause to filter employees with higher salaries than their managers
ALIAS for cleaner column naming

Thought process:
Join the emp table to itself using manager_id and emp_id. Compare employee salary with manager salary. Select only those employees whose salary is greater than their manager’s. Display employee name, manager name, and both salaries.
