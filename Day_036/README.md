Here’s a clean and professional **GitHub README.md** for the SQL project shown on your screen:  

---

### 🏙️ Year-wise New City Analysis (MySQL)

#### Problem  
We have a table named **`business_city`** that stores information about the cities where Udaan operates, along with the date when business activity occurred. Each record contains columns like `city_id` and `business_date`.  
The goal is to identify, for each year, how many **new cities** Udaan started operations in.

#### Task  
The query should determine the **first year** each city appeared in the dataset (the year when Udaan began operations in that city). Then, it should group the results by year and count how many cities were newly added in each year.

#### Goal  
Generate an output showing two columns — `business_year` and `count(city_id)` — where `business_year` represents the year and `count(city_id)` shows the number of **new cities** that started operations in that year.

---

### 🧠 Approach  
1. Created a **CTE** named `city_first_year` to find the **first year** each city appeared in the dataset using `MIN(YEAR(business_date))` grouped by `city_id`.  
2. Created another **CTE** (`cte_2`) joining the original table `business_city` with `city_first_year` to filter only those records where the business year matched the first year of that city’s operation.  
3. Grouped the results by `business_year` and used `COUNT(city_id)` to calculate the number of new cities added each year.  
4. Displayed the final output with `business_year` and the count of new cities.

---

### 💻 SQL Query  

```sql
WITH city_first_year AS (
  SELECT 
    city_id,
    MIN(YEAR(business_date)) AS first_year
  FROM business_city
  GROUP BY city_id
),
cte_2 AS (
  SELECT 
    b.city_id,
    YEAR(b.business_date) AS business_year,
    b.business_date
  FROM business_city b
  JOIN city_first_year cfy 
    ON b.city_id = cfy.city_id
  WHERE YEAR(b.business_date) = cfy.first_year
)
SELECT 
  business_year,
  COUNT(city_id) AS new_cities
FROM cte_2
GROUP BY business_year;
```

---

### 📊 Output  

| business_year | new_cities |
|----------------|------------|
| 2020 | 2 |
| 2021 | 1 |
| 2022 | 1 |

---

