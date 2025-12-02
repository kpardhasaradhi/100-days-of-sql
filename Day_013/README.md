# SQL Query: Daily Platform Spending Summary

## Problem
We have a table called `spending` that stores user purchase data. Each record includes the purchase date (`spend_date`), user ID (`user_id`), platform used (`mobile` or `desktop`), and the amount spent (`amount`).  
Some users make purchases from both platforms on the same date, while others use only one.

The goal is to generate a daily summary showing total spending and total users for each platform type — **mobile**, **desktop**, and **both** — ensuring all three appear for every date, even if one has no data.

## Task
Write a query that:
1. Calculates total spending and user count per platform for each date.  
2. Identifies users who used both platforms on the same date.  
3. Ensures that if a platform type is missing for a date, it still appears with `0` for totals.

## Approach
1. Create a CTE (`group_cte`) to group data by `spend_date` and `user_id`, summing the total amount and counting distinct users.  
2. Use `GROUP_CONCAT()` to combine platforms used by each user into one string (e.g., “mobile and desktop”).  
3. Apply a `CASE` statement to rename “mobile and desktop” as “both.”  
4. Add a `UNION ALL` query to include missing “both” rows with `0` totals for dates where no users used both platforms.  
5. Order the results by `spend_date` and `platform`.

## Query
```sql
WITH group_cte AS (
  SELECT 
    spend_date,
    user_id,
    SUM(amount) AS total_amount,
    COUNT(DISTINCT user_id) AS users,
    GROUP_CONCAT(platform SEPARATOR ' and ') AS platforms
  FROM spending
  GROUP BY spend_date, user_id
)
SELECT 
  spend_date,
  CASE 
    WHEN platforms = 'mobile and desktop' THEN 'both' 
    ELSE platforms 
  END AS platform,
  total_amount,
  users
FROM group_cte

UNION ALL

SELECT DISTINCT 
  spend_date,
  'both' AS platform,
  0 AS total_amount,
  0 AS total_users
FROM spending
WHERE spend_date NOT IN (
  SELECT spend_date 
  FROM group_cte 
  WHERE platforms = 'mobile and desktop'
)
ORDER BY spend_date, platform;
