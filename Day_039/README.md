# Brand Category Mapping using SQL

## Overview
This project uses **Common Table Expressions (CTEs)** and **window functions** in MySQL to assign product categories to brands based on their sequence in the dataset.  
The query ensures that each brand is grouped under the correct category, even when category values are missing for some rows.

## Problem
The `brands` table contains two columns — `category` and `brand_name`.  
Some rows have missing category values, and we need to fill those missing categories based on the nearest non-null category above them.

## Task
Use SQL window functions to identify the range of rows belonging to each category and assign the correct category name to all related brands.

## Goal
Display each brand with its corresponding category, ensuring that all brands are grouped correctly even if the original data had missing category values.

## SQL Query
```sql
WITH cte_1 AS (
    SELECT 
        category,
        brand_name,
        ROW_NUMBER() OVER () AS rno
    FROM brands
),
cte_2 AS (
    SELECT 
        *,
        LEAD(rno, 1, 9999) OVER (ORDER BY rno) AS next_rno
    FROM cte_1
    WHERE category IS NOT NULL
)
SELECT 
    cte_2.category,
    cte_1.brand_name
FROM cte_1
JOIN cte_2
    ON cte_1.rno >= cte_2.rno 
   AND cte_1.rno <= cte_2.next_rno - 1;


Explanation
cte_1 assigns a unique row number to each record in the brands table.
cte_2 finds the next non-null category row using the LEAD() function and stores its row number as next_rno.
The final query joins both CTEs to fill missing categories by matching rows between the current and next category boundaries.


Output Example
category	brand_name
chocolates	5-star
chocolates	dairy milk
chocolates	perk
chocolates	eclair
Biscuits	britannia
Biscuits	good day
Biscuits	boost

```
