# Day 61 Solution – Find Consecutive Free Seats in Cinema

## Problem  
Find all seats in the cinema that are free and have at least one neighboring seat (either before or after) that is also free.

## Task  
Write a SQL query to find seat IDs where the seat is free (`free = 1`) and either the previous or next seat is also free. Show only those seat IDs.

## Goal  
To find all free seats that are part of a group of two or more consecutive free seats.

## Approach  
- I first created a CTE to include each seat along with its previous and next seat’s status using the `LAG()` and `LEAD()` functions.  
- Next, I used `LAG(free, 1)` to check the seat before and `LEAD(free, 1)` to check the seat after each seat.  
- Then, I selected only those seats where `free = 1` and either the previous or next seat was also free.  
- Finally, I ordered the results by `seat_id` to list all consecutive free seats in order.

## Query  
```sql
WITH cte AS (
  SELECT *,
         LAG(free, 1) OVER (ORDER BY seat_id) AS previous_seat,
         LEAD(free, 1) OVER (ORDER BY seat_id) AS next_seat
  FROM cinema
)
SELECT seat_id
FROM cte
WHERE free = 1 
  AND (previous_seat = 1 OR next_seat = 1)
ORDER BY seat_id;
Output
seat_id
3
4
5
7
8
14
15
17
18
19
20
```
