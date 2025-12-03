# Recursive CTE for Yearly Product Sales

## Overview
This project demonstrates how to use a **recursive Common Table Expression (CTE)** in SQL to calculate total yearly sales for each product.  
The goal is to handle sales periods that span multiple calendar years and ensure that every product’s sales are correctly allocated to each year.

## Problem Statement
Create a report that shows the **total sales for each product by calendar year**.  
Each product may have a sales period that starts and ends on different dates, possibly crossing over multiple years.  
The report should include all years in which a product was active, even if it was active for only part of the year.

## Approach
- A recursive CTE named **days** was created to expand each product’s sales period into individual daily records.  
- The first part of the CTE selected the initial rows from the `sales` table with `product_id`, `period_start`, `period_end`, and `average_daily_sales`.  
- The recursive part used `UNION ALL` with `DATE_ADD` to add one day at a time to the `sale_date`, continuing until the date reached the `period_end`.  
- This generated one row per day for each product’s sales period, ensuring full daily coverage even when periods crossed calendar years.  
- Finally, the results were grouped by `product_id` and `YEAR(sale_date)` to calculate total yearly sales for each product using `SUM(average_daily_sales)`.

## Example Query
```sql
WITH RECURSIVE days AS (
    SELECT 
        product_id,
        period_start AS sale_date,
        period_end,
        average_daily_sales
    FROM sales
    UNION ALL
    SELECT 
        product_id,
        DATE_ADD(sale_date, INTERVAL 1 DAY),
        period_end,
        average_daily_sales
    FROM days
    WHERE sale_date < period_end
)
SELECT 
    product_id,
    YEAR(sale_date) AS sales_year,
    SUM(average_daily_sales) AS total_sales
FROM days
GROUP BY product_id, YEAR(sale_date)
ORDER BY product_id, sales_year;
