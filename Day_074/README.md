💼 Day 74 – Employees with Matching Salaries

🧩 Problem
The dataset contains employee details including their department and salary. The challenge is to find employees who earn the same salary as someone else in the same department.

🎯 Goal
To identify and display all employees who share identical salaries within their respective departments.

🧠 Approach

First, I selected all employee records from the emp_salary table using alias e1.
Next, I joined the same table again as e2 to compare employees within the same department.
Then, I used the ON condition to match rows where the department IDs were equal but employee IDs were different.
After that, I added a condition to check if both employees had the same salary.
Finally, I used ORDER BY to sort the results by department ID and employee ID for better readability.

🧾 Query
```sql

SELECT e1.* 
FROM emp_salary e1 
JOIN emp_salary e2 
    ON e1.emp_id != e2.emp_id 
    AND e1.dept_id = e2.dept_id 
    AND e1.salary = e2.salary 
ORDER BY e1.dept_id, e1.emp_id;
```

🧮 Output

emp_id	name	salary	dept_id

101	sohan	3000	11

104	cat	3000	11

102	rohan	4000	12

105	suresh	4000	12

💡 Key Learnings

Learned how to use a self-join to compare rows within the same table.
Understood how to apply multiple join conditions effectively.
Practiced filtering results using inequality (!=) and equality (=) together.
Reinforced the use of ORDER BY for organized output.
Improved understanding of identifying duplicate values within groups.

🏁 Summary

This challenge helped me practice self-joins to compare data within the same table. By combining multiple conditions, I successfully found employees earning the same salary in the same department, improving my SQL comparison and join logic skills.
