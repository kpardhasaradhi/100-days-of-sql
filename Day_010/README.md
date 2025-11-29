# Day 010 - Daily Trip Cancellation Rate

## Problem
We have two tables, `trips` and `users`. We need to calculate the cancellation rate of trips made by unbanned users (both client and driver) for each day between **"2013-10-01"** and **"2013-10-03"**.

## Task
Write a SQL query to find the daily cancellation rate by dividing the number of cancelled trips (`cancelled_by_driver` or `cancelled_by_client`) by the total number of trips made by unbanned users on that day.  
Round the cancellation rate to two decimal places.

## Goal
Determine the daily cancellation rate for trips involving only unbanned users, helping to understand how often rides were cancelled compared to total requests within the given date range.

## Query
```sql
WITH cte AS (
    SELECT *
    FROM trips t
    JOIN users u ON u.users_id = COALESCE(t.client_id, t.driver_id)
    WHERE u.banned = 'No'
),
total_rides AS (
    SELECT request_at, COUNT(*) AS completed_rides
    FROM cte
    GROUP BY request_at
),
cancelled_rides AS (
    SELECT request_at, COUNT(*) AS uncompleted_rides
    FROM cte
    WHERE status IN ('cancelled_by_driver', 'cancelled_by_client')
    GROUP BY request_at
)
SELECT 
    tr.request_at,
    tr.completed_rides,
    COALESCE(cr.uncompleted_rides, 0) AS uncompleted_rides,
    ROUND(COALESCE(cr.uncompleted_rides, 0) / tr.completed_rides, 2) AS cancelled_percent
FROM total_rides tr
LEFT JOIN cancelled_rides cr 
    ON tr.request_at = cr.request_at
ORDER BY tr.request_at;
Approach
The goal was to find the daily cancellation rate of trips made by unbanned users.
Joined trips and users tables using COALESCE() to exclude banned users.
Counted total trips and cancelled trips (cancelled_by_driver, cancelled_by_client) using separate CTEs.
Used LEFT JOIN and COALESCE() to include all days and replace missing values with 0.
Calculated cancellation rate by dividing cancelled rides by total rides and rounding to two decimals.
Output
request_at	completed_rides	uncompleted_rides	cancelled_percent
2013-10-01	3	1	0.33
2013-10-02	4	2	0.50
2013-10-03	3	0	0.00
#100DaysOfSQLChallenge
