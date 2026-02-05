🧩 Problem

You have a family table that contains people labeled as either Adult or Child, and you want to line them up so each adult is paired with a child based on position.

---

🎯 Goal

Write a SQL query that matches adults and children row-by-row (1st adult with 1st child, 2nd adult with 2nd child, etc.), while still showing adults even if there are fewer children.

---

🧠 Approach

First, create a CTE for adults and assign each adult a row number.

Next, create a second CTE for children and assign each child a row number.

Then, use the row numbers as a common pairing key.

After that, join adults to children using a LEFT JOIN so every adult appears.

Finally, select only the paired names to get a clean adult–child mapping.

🧾 Query

```sql
WITH adult_cte AS (
    SELECT *, ROW_NUMBER() OVER () AS rno
    FROM family
    WHERE type = 'Adult'
),
child_cte AS (
    SELECT *, ROW_NUMBER() OVER () AS rno
    FROM family
    WHERE type = 'Child'
)
SELECT a.person, c.person
FROM adult_cte a
LEFT JOIN child_cte c ON a.rno = c.rno;
```

🧮 Output


person	person

John	Maya

Sarah	Liam

David	Emma

Priya	NULL

💡 Key Learnings

ROW_NUMBER() can create a simple matching key when no natural key exists.

CTEs help break a query into clean, readable steps.

A LEFT JOIN ensures all adults are included even when children are fewer.

Pairing by row position is useful for alignment-style problems.

🏁 Summary

This query separates adults and children into two lists, assigns row numbers to both, and joins them by position to generate an easy adult-to-child pairing while keeping unmatched adults visible.
