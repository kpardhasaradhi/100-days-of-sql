🧮 Day 77 – Formula Evaluation Using Self Join

---

**🧩 Problem**  
The task was to find the result of each formula where the calculation depends on another row’s value. Each formula contained two parts separated by an operator, and the second part referred to another row’s value.

---

**🎯 Goal**  
The goal was to split each formula into its components, fetch the referenced value from the matching row, and then perform the correct addition or subtraction to calculate the final result.

---

**🧠 Approach**  
- **First**, I created a CTE to extract parts of the formula using string functions.  
- **Next**, I used `SUBSTRING_INDEX` and `REGEXP_SUBSTR` to split each formula into the first number, operator, and last number.  
- **Then**, I included the value column in the same CTE so each formula retained its numeric value.  
- **After that**, I joined the CTE to itself where the second number matched another row’s ID to fetch the referenced value.  
- **Finally**, I used a `CASE` statement to perform addition or subtraction based on the operator and displayed the computed result.

---

**🧾 Query**
```sql
WITH cte AS (
  SELECT
    id,
    formula,
    SUBSTRING_INDEX(formula, REGEXP_SUBSTR(formula, '[+\\-]'), 1) AS first_num,
    REGEXP_SUBSTR(formula, '[+\\-]') AS operation,
    SUBSTRING_INDEX(formula, REGEXP_SUBSTR(formula, '[+\\-]'), -1) AS last_num,
    value
  FROM input
)
SELECT
  c1.id,
  c1.formula,
  c1.value AS first_val,
  c1.operation,
  c2.value AS last_val,
  CASE
    WHEN c1.operation = '+' THEN c1.value + c2.value
    WHEN c1.operation = '-' THEN c1.value - c2.value
  END AS new_value
FROM cte c1
JOIN cte c2 ON c1.last_num = c2.id;
```

🧮 Output

id	formula	first_val	operation	last_val	new_value
4	4-1	20	-	10	10
2	2+1	5	+	10	15
3	3+2	40	+	5	45
1	1+4	10	+	20	30
💡 Key Learnings

Learned how to use string functions to extract parts of a formula.
Understood how to perform a self join to reference values from other rows.
Practiced using CASE statements for conditional arithmetic operations.
Improved understanding of combining text parsing with numeric computation in SQL.
🏁 Summary
This challenge demonstrated how to evaluate formulas that depend on other rows by splitting strings, joining data to itself, and applying conditional logic to compute accurate results.
