# Day 59 Solution – Consecutive Low-Stock Days

## Problem  
Find suppliers and products that had stock quantities below 50 for two or more consecutive days.

## Task  
Write a SQL query to identify each continuous period where `stock_quantity` was less than 50.  
For each such sequence, display the `supplier_id`, `product_id`, the first `record_date` of that period, and the total number of consecutive days.

## Goal  
To detect consecutive low-stock streaks for each supplier and product, helping identify inventory issues or supply delays.

## Approach  
- I first created a CTE to compare each record’s stock with the previous day using the `LAG()` function.  
- Next, I used a `CASE` statement to check whether the current record continued the same low-stock streak or started a new one.  
- If both the current and previous records had stock below 50 and their dates were one day apart, I kept them in the same group; otherwise, I started a new one.  
- Then, in the next CTE, I added up these group breaks using the `SUM()` window function to assign a unique group number to each streak.  
- After that, I grouped the data by `supplier_id`, `product_id`, and the group number.  
- Once the grouping was done, I filtered the results to include only those groups that had two or more consecutive days with stock below 50.  
- Finally, I displayed the `supplier_id`, `product_id`, the first date of each streak, and the total number of consecutive days.

## Query  
```sql
WITH cte AS (
  SELECT supplier_id,
         product_id,
         record_date,
         stock_quantity,
         CASE 
           WHEN stock_quantity < 50
                AND LAG(stock_quantity) OVER (PARTITION BY supplier_id, product_id ORDER BY record_date) < 50
                AND DATEDIFF(record_date, LAG(record_date) OVER (PARTITION BY supplier_id, product_id ORDER BY record_date)) = 1
           THEN 0 ELSE 1 
         END AS grp_break
  FROM stock
),
grouped AS (
  SELECT supplier_id,
         product_id,
         record_date,
         stock_quantity,
         SUM(grp_break) OVER (PARTITION BY supplier_id, product_id ORDER BY record_date) AS grp
  FROM cte
)
SELECT supplier_id,
       product_id,
       MIN(record_date) AS first_date,
       COUNT(*) AS no_of_days
FROM grouped
WHERE stock_quantity < 50
GROUP BY supplier_id, product_id, grp
HAVING COUNT(*) >= 2

```


ORDER BY supplier_id, product_id, first_date;
Output
supplier_id	product_id	first_date	no_of_days
1	1	2022-01-02	3
1	1	2022-01-10	2
1	1	2022-01-15	2
1	2	2022-01-08	2
