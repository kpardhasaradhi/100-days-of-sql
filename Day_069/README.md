# Day 69 – Finding All Possible Flight Routes from New York to Tokyo ✈️

## 🧩 Problem  

We need to find all possible flight routes from **New York** to **Tokyo**, including both **direct** and **connecting** flights. Each route should display its total travel time in minutes.

---

## 🎯 Goal  

To calculate and display all possible routes from **New York** to **Tokyo**, showing the start city, middle city (if any), end city, flight IDs, and total travel time using `TIMESTAMPDIFF()`.

---

## 🧠 Approach  

- First, I created a **CTE** to join the `flights` table with the `airports` table twice — once for the start port and once for the end port. This provided readable city names for both start and end points.  
- Next, I built another CTE called `direct_flights` to capture all flights that go directly from **New York** to **Tokyo**, calculating their travel time using `TIMESTAMPDIFF()`.  
- Then, I joined the main CTE to itself to find **connecting flights**, where the first flight’s end city matches the second flight’s start city and the second flight departs after the first one ends.  
- After that, I combined both direct and connecting flights using `UNION ALL` to show all possible routes.  
- Finally, I calculated total travel time for each route and used `CONCAT()` to combine flight IDs and city names for a clear and readable output.

---

## 🧾 Query  

```sql
WITH cte AS (
    SELECT 
        f.*, 
        a1.city_name AS start_city, 
        a2.city_name AS end_city 
    FROM flights f
    JOIN airports a1 ON a1.port_code = f.start_port
    JOIN airports a2 ON a2.port_code = f.end_port
),
direct_flights AS (
    SELECT 
        start_city, 
        NULL AS middle_city, 
        end_city, 
        start_time, 
        end_time,
        flight_id,
        TIMESTAMPDIFF(MINUTE, start_time, end_time) AS time_taken
    FROM cte 
    WHERE start_city = 'New York' AND end_city = 'Tokyo'
)
SELECT 
    start.start_city,
    start.end_city AS middle_city,
    end.end_city,
    start.start_time,
    end.end_time,
    CONCAT(start.flight_id, ',', end.flight_id) AS flight_path,
    TIMESTAMPDIFF(MINUTE, start.start_time, end.end_time) AS time_taken
FROM cte start
JOIN cte end 
    ON start.end_city = end.start_city
WHERE start.start_city = 'New York' 
  AND end.end_city = 'Tokyo'
  AND end.start_time > start.end_time

UNION ALL

SELECT * FROM direct_flights;

```


🧮 Output

]start_city	middle_city	end_city	start_time	end_time	flight_path	time_taken

New York	Los Angeles	Tokyo	2025-06-15 07:00:00	2025-06-15 22:00:00	2,3	900
New York	Los Angeles	Tokyo	2025-06-15 08:00:00	2025-06-15 23:00:00	2,9	900
New York	Los Angeles	Tokyo	2025-06-15 09:00:00	2025-06-15 23:00:00	2,9	960
New York	NULL	Tokyo	2025-06-15 06:00:00	2025-06-15 18:00:00	1	720
