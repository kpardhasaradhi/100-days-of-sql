Day 80 – 📈 Consistent Revenue Growth Challenge

🧩 Problem
We have a table named company_revenue that stores company names, years, and their yearly revenue. The goal is to find companies whose revenue increases every year without any drop.
---
🎯 Goal
Identify and return only those companies where the revenue grows continuously year after year, showing consistent performance.
---
🧠 Approach

First, I created a CTE using the WITH clause to calculate two row numbers for each company.
Next, I used ROW_NUMBER() with PARTITION BY company and ordered one by revenue and another by year.
Then, I compared both row numbers to check if the revenue order matches the year order.
After that, I selected only those companies where both sequences align perfectly.
Finally, I excluded companies where the order mismatched, ensuring only consistent growth companies appear in the result.

---

🧾 Query
```sql
WITH cte AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY company ORDER BY revenue) AS rev_rno,
        ROW_NUMBER() OVER (PARTITION BY company ORDER BY year) AS year_rno
    FROM company_revenue
)
SELECT DISTINCT *
FROM company_revenue
WHERE company NOT IN (
    SELECT company FROM cte WHERE rev_rno != year_rno
);

```

---

🧮 Output

company	year	revenue
ABC1	2000	100
ABC1	2001	110
ABC1	2002	120
💡 Key Learnings

Learned how to use ROW_NUMBER() with PARTITION BY for ranking within groups.
Understood how to compare ordered sequences using window functions.
Practiced filtering results using subqueries.
Reinforced the use of CTE for cleaner and modular SQL logic.
🏁 Summary
This challenge helped me identify companies with consistent revenue growth by comparing ranking patterns of revenue and year. It strengthened my understanding of window functions and logical filtering in SQL.
