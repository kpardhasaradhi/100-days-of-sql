🎬 Find Four or More Consecutive Empty Seats in a Theater (MySQL)
Problem
We have a table named movie that stores seat details in a theater. Each record contains columns like seat (for example, ‘A1’, ‘A2’, etc.) and occupancy (where 0 means empty and 1 means taken).
The goal is to find all seats that are part of a group of four or more consecutive empty seats in the same row.

Task
The query should detect sequences of four consecutive seats where occupancy = 0.
It should group these consecutive empty seats together and return all the seats that belong to such sequences.

Goal
Show the row, seat number, and occupancy for every seat that is part of a group of four or more empty seats next to each other in the same row.

🧠 Approach
A CTE (cte1) was created using the WITH clause to separate the seat into two parts — the row letter and the seat number.
The seat number was converted into a numeric value using SUBSTRING(seat, 2) + 0 to make ordering easier.

Another CTE (cte2) was used to check every group of four seats in the same row.

The MAX() window function was applied to see if any of those four seats were occupied.
The COUNT() function was used to count how many seats were included in each group.
A third CTE (cte3) was created to filter only those groups where all four seats were empty (is_4_empty = 0) and the total count was four.

Finally, the result from cte2 was JOINED with cte3 using the JOIN and BETWEEN clauses to display all seats that belonged to those groups of four empty seats.

💻 SQL Query
WITH cte1 AS (
  SELECT 
    LEFT(seat, 1) AS row_id,
    SUBSTRING(seat, 2) + 0 AS seat_id,
    occupancy
  FROM movie
),
cte2 AS (
  SELECT 
    *,
    MAX(occupancy) OVER (
      PARTITION BY row_id 
      ORDER BY seat_id 
      ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING
    ) AS is_4_empty,
    COUNT(occupancy) OVER (
      PARTITION BY row_id 
      ORDER BY seat_id 
      ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING
    ) AS cnt
  FROM cte1
),
cte3 AS (
  SELECT * 
  FROM cte2 
  WHERE is_4_empty = 0 AND cnt = 4
)
SELECT 
  c2.row_id,
  c2.seat_id,
  c2.occupancy,
  c2.is_4_empty,
  c2.cnt
FROM cte2 c2
JOIN cte3 c3 
  ON c2.row_id = c3.row_id 
  AND c2.seat_id BETWEEN c3.seat_id AND c3.seat_id + 3;
📊 Sample Output
row_id	seat_id	occupancy	is_4_empty	cnt
a	3	0	0	4
a	4	0	1	4
a	5	0	1	4
a	6	0	1	4
🧩 Key Learnings
Used Common Table Expressions (CTEs) to break down complex logic into smaller steps.
Applied window functions (MAX() and COUNT()) to detect consecutive seat patterns.
Used JOIN and BETWEEN to expand filtered results to full seat groups.
Practiced data pattern detection using SQL windowing techniques.
