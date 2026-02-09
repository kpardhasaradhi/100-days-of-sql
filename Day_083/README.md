Day 83 – 🔍 Compare Source and Target Tables Challenge

---

🧩 Problem
We have two tables, source and target, each containing IDs and names. The goal is to compare both tables and identify records that are new in one table, missing in the other, or have mismatched names for the same ID.

---

🎯 Goal
Find and display all records that differ between the two tables, showing whether each record is “New in source,” “New in target,” or “Mismatch.”

---

🧠 Approach

First, I compared the source and target tables using a LEFT JOIN to find records that exist in one table but not the other or have different names.
Next, I used a CASE WHEN statement to label each record as 'New in source', 'New in target', or 'Mismatch' based on the join results.
Then, I applied a UNION with another LEFT JOIN in the opposite direction to simulate a FULL JOIN since MySQL doesn’t support it directly.
After that, I used COALESCE() to handle NULL values and ensure IDs appear even if they exist in only one table.
Finally, I filtered the results using WHERE comment IS NOT NULL to show only meaningful differences between the two tables.

---

🧾 Query

```sql 
WITH cte AS (
    SELECT COALESCE(s.id, t.id) AS id,
           CASE 
               WHEN t.id IS NULL THEN 'New in source'
               WHEN s.id IS NULL THEN 'New in target'
               WHEN s.name != t.name THEN 'Mismatch'
           END AS comment
    FROM source s
    LEFT JOIN target t ON s.id = t.id
    WHERE t.id IS NULL OR s.name != t.name
    UNION
    SELECT COALESCE(s.id, t.id) AS id,
           CASE 
               WHEN t.id IS NULL THEN 'New in source'
               WHEN s.id IS NULL THEN 'New in target'
               WHEN s.name != t.name THEN 'Mismatch'
           END AS comment
    FROM target t
    LEFT JOIN source s ON s.id = t.id
    WHERE s.id IS NULL OR s.name != t.name
)
SELECT * 
FROM cte
WHERE comment IS NOT NULL;

```

---


🧮 Output

id	comment
3	New in source
4	Mismatch
5	New in target


💡 Key Learnings

Learned how to simulate a FULL JOIN in MySQL using LEFT JOIN and UNION.
Understood how to use CASE WHEN for conditional labeling in comparisons.
Practiced handling NULL values effectively with COALESCE().
Reinforced the use of filtering to remove unnecessary or null results.

🏁 Summary
This challenge helped me compare two datasets efficiently by identifying missing and mismatched records. It strengthened my understanding of joins, conditional logic, and data validation techniques in SQL.
