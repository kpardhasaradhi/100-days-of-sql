# Driver Ride Profitability Analysis

## Overview
This SQL script analyzes driver ride data to find how many rides each driver completed and how many of those rides were "profitable" — meaning the next ride started at the same location where the previous ride ended.

## Problem
We have a table named `drivers` that stores ride details for each driver, including:
- `id` — driver ID  
- `start_time` — when the ride started  
- `start_loc` — starting location  
- `end_loc` — ending location  

Each driver can have multiple rides in a day. We need to find:
1. The total number of rides each driver completed.
2. The number of rides where the next ride started from the same location where the previous one ended.

## Task
Use SQL window functions to compare consecutive rides for each driver and determine how many rides were profitable.

## Goal
Display each driver's ID, total rides, and profitable rides to understand their route efficiency.

## SQL Query
```sql
WITH cte AS (
    SELECT
        *,
        LEAD(start_loc, 1) OVER (PARTITION BY id ORDER BY start_time) AS next_start_loc
    FROM drivers
)
SELECT
    id,
    COUNT(*) AS total_rides,
    SUM(CASE WHEN end_loc = next_start_loc THEN 1 ELSE 0 END) AS profit_rides
FROM cte
GROUP BY id;
```


Approach
Used a WITH clause to create a CTE that includes each ride and the start location of the next ride using the LEAD() window function.
Compared end_loc with next_start_loc using a CASE WHEN condition to identify profitable rides.
Used COUNT(*) to count total rides and SUM() to count profitable rides.
Grouped results by id to show totals per driver.
Output Example
id	total_rides	profit_rides
dri_1	5	1
dri_2	2	0
