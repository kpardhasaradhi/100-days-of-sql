## 🎬 Find Four or More Consecutive Empty Seats in a Theater (MySQL)

### **Problem**  
We have a table named `movie` that stores seat details in a theater.  
Each record has columns like `seat` (for example, A1, A2, etc.) and `occupancy` (where 0 means empty and 1 means taken).  
We need to find all seats that are part of a group of four or more consecutive empty seats in the same row.  

---

### **Task**  
The query should detect sequences of four consecutive seats where `occupancy = 0`.  
It should group these consecutive empty seats together and return all seats that belong to such sequences.  

---

### **Goal**  
Show the row, seat number, and occupancy for every seat that is part of a group of four or more empty seats next to each other in the same row.  

---

### 💡 **Approach**  
1. A `CTE` (`cte1`) was created using the `WITH` clause to separate the seat into two parts — the row letter and the seat number.  
2. Another `CTE` (`cte2`) was used to check every group of four seats in the same row.  
3. A third `CTE` (`cte3`) was created to filter only those groups where all four seats were empty.  
4. Finally, the result from `cte2` was `JOINED` with `cte3` using the `JOIN` and `BETWEEN` clauses.  

---

### 🧠 **SQL Query**

```sql
WITH cte1 AS (
  SELECT LEFT(seat, 1) AS row_id,
         SUBSTRING(seat, 2) + 0 AS seat_id,
         occupancy
  FROM movie
),
cte2 AS (
  SELECT *,
         MAX(occupancy) OVER (PARTITION BY row_id ORDER BY seat_id ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS is_4_empty,
         COUNT(occupancy) OVER (PARTITION BY row_id ORDER BY seat_id ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS cnt
  FROM cte1
),
cte3 AS (
  SELECT * FROM cte2 WHERE is_4_empty = 0 AND cnt = 4
)
SELECT c2.*
FROM cte2 c2
JOIN cte3 c3 ON c2.row_id = c3.row_id AND c2.seat_id BETWEEN c3.seat_id AND c3.seat_id + 3;
📊 Sample Output
row_id	seat_id	occupancy
A	3	0
A	4	0
A	5	0
A	6	0
🧩 Key Learnings
Used CTEs to simplify multi-step logic.
Applied MAX() and COUNT() window functions to detect consecutive seat patterns.
Used JOIN and BETWEEN to expand filtered results to full seat groups.
Practiced pattern detection using SQL windowing techniques.
