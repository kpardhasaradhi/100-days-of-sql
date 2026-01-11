
# Department Average Salary Comparison Query

## Problem Statement
We need to identify departments whose **average salary** is lower than the **average salary of all other departments combined**.  
The goal is to compare each department’s average salary with the overall average of the remaining departments and return only those that fall below it.

---

## Goal
To display each department’s ID, its average salary, and the average salary of all other departments for comparison.  
This helps identify departments that are underperforming in terms of employee compensation.

---

## Example

### Input Table: `emp_04`
| department_id | employee_id | salary |
|----------------|--------------|--------|
| 100            | 1            | 8000   |
| 100            | 2            | 9000   |
| 200            | 3            | 12000  |
| 300            | 4            | 6500   |
| 300            | 5            | 6500   |

### Output
| department_id | avg_sal | avg_salary_of_remaining_depts |
|----------------|----------|-------------------------------|
| 300            | 6500.00  | 9750.00                       |

---

## SQL Solution
```sql
with cte as (
    select department_id,
           avg(salary) as avg_sal,
           count(*) as no_of_emp,
           sum(salary) as total_salary
    from emp_04
    group by department_id
)
select c1.department_id,
       c1.avg_sal,
       sum(c2.total_salary) / sum(c2.no_of_emp) as avg_salary_of_remaining_depts
from cte c1
join cte c2
  on c1.department_id != c2.department_id
group by c1.department_id, c1.avg_sal
having sum(c2.total_salary) / sum(c2.no_of_emp) > c1.avg_sal;
