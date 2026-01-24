#User Sessionization in SQL

#🧩 Problem
We need to identify and group user sessions from event-level data.
A new session should start if the time gap between two consecutive events for the same user exceeds 30 minutes.

The data is stored in an events_day_66 table that contains multiple records per user with event timestamps.

#🎯 Goal

To calculate session-level metrics for each user, including:

Number of events per session
Session start and end time
Session duration in minutes
Only events within the same continuous session should be grouped together.

⚙️ Approach
Step 1: Create a CTE to calculate the previous event time for each user using the LAG() function.

Step 2: Compute the time difference between consecutive events in minutes using TIMESTAMPDIFF().

Step 3: Assign a new session group whenever the time gap exceeds 30 minutes.

Step 4: Aggregate the results to calculate session-level metrics such as event count, duration, start, and end time.

💻 Query
```sql

WITH cte AS (
    SELECT *,
           LAG(event_time, 1, event_time) OVER (PARTITION BY userid ORDER BY event_time) AS prev_event_time
    FROM events_day_66
),
group_cte AS (
    SELECT *,
           TIMESTAMPDIFF(MINUTE, prev_event_time, event_time) AS time_diff_in_minutes,
           SUM(
               CASE 
                   WHEN TIMESTAMPDIFF(MINUTE, prev_event_time, event_time) <= 30 THEN 0 
                   ELSE 1 
               END
           ) OVER (PARTITION BY userid ORDER BY event_time) AS session_group
    FROM cte
)
SELECT 
    userid,
    COUNT(*) AS session_events,
    session_group + 1 AS session_id,
    TIMESTAMPDIFF(MINUTE, MIN(event_time), MAX(event_time)) AS session_duration,
    MIN(event_time) AS session_start,
    MAX(event_time) AS session_end
FROM group_cte
GROUP BY userid, session_group;
```

📊 Sample Output

userid	session_events	session_id	session_duration	session_start	session_end

1	2	1	0	2023-09-10 09:00:00	2023-09-10 09:00:00
1	3	2	50	2023-09-10 10:00:00	2023-09-10 10:50:00
1	4	3	10	2023-09-10 12:40:00	2023-09-10 12:50:00
1	2	4	20	2023-09-10 13:10:00	2023-09-10 13:30:00
