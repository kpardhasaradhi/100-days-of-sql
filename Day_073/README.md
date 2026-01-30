🏠 Day 73 – Airbnb Room Type Frequency

🧩 Problem

The dataset contains Airbnb search records where each entry lists one or more room types in a comma-separated format. The challenge is to identify how often each room type appears across all searches.

🎯 Goal

To extract individual room types from the combined list, count their occurrences, and display the total number of searches for each room type.

🧠 Approach

First, I created a CTE to extract the first and second room types from the filter_room_types column using SUBSTRING_INDEX.
Next, I used a CASE statement to handle rows containing multiple room types separated by commas.
Then, I built another CTE to combine both room types into a single column using UNION ALL.
After that, I filtered out NULL values to keep only valid room types.
Finally, I grouped the results by room type and used COUNT() to find how many times each type appeared.

🧾 Query
```sql

WITH cte AS (
    SELECT 
        *,
        SUBSTRING_INDEX(filter_room_types, ',', 1) AS first_room_type,
        CASE
            WHEN filter_room_types LIKE '%,%' 
            THEN SUBSTRING_INDEX(filter_room_types, ',', -1)
        END AS second_room_type
    FROM airbnb_searches
),
rooms_cte AS (
    SELECT first_room_type AS room FROM cte
    UNION ALL
    SELECT second_room_type FROM cte
)
SELECT 
    room,
    COUNT(room)
FROM rooms_cte
WHERE room IS NOT NULL
GROUP BY room;
```

🧮 Output

room	COUNT(room)

entire home	2

private room	3

shared room	2

💡 Key Learnings

Learned how to split comma-separated values using SUBSTRING_INDEX.
Used CASE to handle conditional extraction of multiple values.
Practiced combining results with UNION ALL.
Reinforced grouping and aggregation using GROUP BY and COUNT().
Improved understanding of CTEs for step-by-step data transformation.
🏁 Summary
This challenge demonstrated how to handle comma-separated data efficiently in SQL. By using CTEs and string functions, I successfully extracted and counted each room type, providing clear insights into room search trends.
