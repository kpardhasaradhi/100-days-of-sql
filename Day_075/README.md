
💼 Day 75 – Highest and Lowest Salary by Department

🧩 Problem

The dataset contains employee details such as department ID, employee name, and salary. The challenge is to identify which employee in each department earns the highest salary and which one earns the lowest.

🎯 Goal
To display each department along with the names of the employees who have the maximum and minimum salaries within that department.

🧠 Approach

First, I used the WITH clause to create a CTE that calculates the maximum and minimum salary for each department using MAX() and MIN() functions.
Next, I joined this CTE with the main employee_day_75 table on the department ID to match employees with their department’s salary range.
Then, I used a CASE statement inside the MAX() function to identify the employee whose salary equals the department’s maximum salary.
After that, I applied another CASE statement to find the employee with the minimum salary in the same department.
Finally, I grouped the results by department ID to show one row per department with both the highest-paid and lowest-paid employees.

🧾 Query
```sql
WITH cte AS (
    SELECT 
        dep_id,
        MAX(salary) AS max_salary,
        MIN(salary) AS min_salary
    FROM employee_day_75
    GROUP BY dep_id
)
SELECT 
    c.dep_id,
    MAX(CASE WHEN a.salary = c.max_salary AND c.dep_id = a.dep_id THEN a.emp_name END) AS max_sal_emp,
    MAX(CASE WHEN a.salary = c.min_salary AND c.dep_id = a.dep_id THEN a.emp_name END) AS min_sal_emp
FROM cte c
JOIN employee_day_75 a 
    ON a.dep_id = c.dep_id
GROUP BY c.dep_id;

```


🧮 Output

dep_id	max_sal_emp	min_sal_emp

1	Prasad	Siva

2	Ravi	Sai

💡 Key Learnings

Learned how to use a CTE to simplify multi-step SQL logic.
Used aggregate functions like MAX() and MIN() to find salary extremes per department.
Applied conditional logic with CASE inside aggregate functions.
Practiced joining CTEs with the main table for comparison.
Strengthened understanding of grouping and aggregation in SQL.

🏁 Summary

This challenge helped me find the highest and lowest-paid employees in each department using CTEs, joins, and conditional aggregation. It improved my ability to combine multiple SQL concepts to produce clear and meaningful results.
