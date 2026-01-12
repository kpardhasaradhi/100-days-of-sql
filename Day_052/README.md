# Day 52 – Selecting Employees Within a Budget

You are given a table named `candidates_uplers` that contains employee details with their positions (`senior` or `junior`) and salaries.  
The task is to determine how many employees from each position can be selected such that their combined salaries do not exceed a total budget of **$50,000**.  
Seniors are prioritized first, and any remaining budget after selecting seniors is used to hire juniors.

---

## Goal
To calculate the number of senior and junior employees that can be hired within the given budget constraint using cumulative salary totals.

---

## Example

### Input
| id | positions | salary |
|----|------------|--------|
| 1  | senior     | 15000  |
| 2  | senior     | 20000  |
| 3  | senior     | 18000  |
| 4  | junior     | 10000  |
| 5  | junior     | 12000  |
| 6  | junior     | 8000   |

### Output
| juniors | seniors |
|----------|----------|
| 3        | 2        |

---

## SQL Query
```sql
WITH cte AS (
    SELECT 
        *,
        SUM(salary) OVER (PARTITION BY positions ORDER BY salary ASC, id) AS running_sal
    FROM candidates_uplers
),
seniors_cte AS (
    SELECT 
        COUNT(*) AS seniors,
        SUM(salary) AS seniors_salary
    FROM cte
    WHERE positions = 'senior' 
      AND running_sal <= 50000
),
juniors_cte AS (
    SELECT 
        COUNT(*) AS juniors
    FROM cte
    WHERE positions = 'junior' 
      AND running_sal <= 50000 - (
          SELECT seniors_salary 
          FROM seniors_cte
      )
)
SELECT 
    juniors, 
    seniors
FROM seniors_cte
JOIN juniors_cte;
Explanation
CTE Creation:
The first CTE calculates a running total of salaries for each position (senior and junior) using the SUM() window function with PARTITION BY positions ORDER BY salary, id.

Selecting Seniors:
The second CTE (seniors_cte) counts how many senior employees can be selected without exceeding the $50,000 budget.

Selecting Juniors:
The third CTE (juniors_cte) counts how many junior employees can be selected within the remaining budget after accounting for the total salary of selected seniors.

Final Output:
The final query joins both CTEs to display the number of juniors and seniors that fit within the total budget.
