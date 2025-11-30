# Day 011 - Finding the Median Employee Age

## Problem
We have an `emp_01` table containing employee details, including `emp_age`.  
The goal is to calculate the **median age** of employees using SQL since MySQL does not have a built-in median function.

## Task
Write a query to find the median employee age using window functions and aggregation.  
Round the result to the nearest integer.

## Goal
Find the median employee age to understand the central age distribution of employees in the dataset.

## Query
```sql
WITH cte AS (
    SELECT 
        emp_age,
        ROW_NUMBER() OVER (ORDER BY emp_age ASC) AS rn_asc,
        ROW_NUMBER() OVER (ORDER BY emp_age DESC) AS rn_desc
    FROM emp_01
)
SELECT 
    ROUND(AVG(emp_age)) AS avg_age
FROM cte
WHERE GREATEST(rn_asc, rn_desc) - LEAST(rn_asc, rn_desc) <= 1


Approach
The goal was to find the median employee age from the emp_01 table to understand the typical age of employees.
First, a CTE was created to assign row numbers to each employee’s age in both ascending and descending order using the ROW_NUMBER() window function.
Next, the difference between these two row numbers was checked using the GREATEST() and LEAST() functions to identify the middle record(s).
Then, the AVG() function was used on those middle values to calculate the median age, and the result was rounded using the ROUND() function to display it as a whole number.
This approach made it easy to calculate the median in MySQL even though it doesn’t have a built-in median function.
