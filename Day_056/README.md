# 🏙️ Unique City Routes Query

---

## 🧩 Problem  
You are given a table **`city_distance`** that stores distances between pairs of cities. Each record includes:  
- **source** — the starting city  
- **destination** — the ending city  
- **distance** — the distance between them  

Some routes appear twice in reverse order (for example, *New Delhi–Panipat* and *Panipat–New Delhi*).  
The task is to remove such duplicates and keep only one record for each unique route.

---

## 🎯 Goal  
Return a list of **unique city pairs** with their corresponding distances, ensuring that each route appears only once regardless of direction.

---

## 🧠 Approach  
1. Create a CTE (`cte`) to normalize city pairs by defining `city1` and `city2` such that the alphabetically smaller city always comes first.  
2. Use a second CTE (`cte2`) to count occurrences of each unique pair using a window function with `PARTITION BY city1, city2, distance`.  
3. Select only one record per unique route by filtering where the count is 1 or where `source < destination`.  

---

## 💻 Query  
```sql
WITH cte AS (
    SELECT distance, source, destination,
           CASE WHEN source < destination THEN source ELSE destination END AS city1,
           CASE WHEN source < destination THEN destination ELSE source END AS city2
    FROM city_distance
),
cte2 AS (
    SELECT distance, source, destination,
           COUNT(*) OVER (PARTITION BY city1, city2, distance) AS cnt
    FROM cte
)
SELECT distance, source, destination
FROM cte2
WHERE cnt = 1 OR source < destination;

📊 Example Output
distance	source	destination
100	New Delhi	Panipat
200	Ambala	New Delhi
1500	Bangalore	Mysore
2500	Mumbai	Pune
2500	Chennai	Bhopal

🧾 Explanation
The first CTE ensures consistent ordering of city names for comparison.
The second CTE counts how many times each unique pair appears.
The final query filters out duplicates by keeping only one direction for each route.
