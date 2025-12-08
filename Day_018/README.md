🧾 Day 18 – Customer Retention by Consecutive Months
💡 Problem Statement
We have a transactions table containing cust_id, order_date, and amount. The goal is to measure customer retention by identifying customers who placed orders in successive months. This helps track how many customers continue to purchase month after month.

🗂️ Table Details
transactions

cust_id – Unique customer identifier
order_date – Date of the order
amount – Order amount
🌿 Approach
Created a CTE to compare each customer’s current and previous order months.
Used the LAG(order_date) window function with PARTITION BY cust_id to get the previous order date for each customer.
Applied MONTHNAME(order_date) to extract the month name for easier reporting.
Added a flag (same_flag) to mark customers who placed orders in consecutive months.
Grouped the results by month and counted how many customers made repeat purchases.
🧠 SQL Solution
WITH cte AS (
  SELECT 
    cust_id,
    order_date AS cur_month,
    MONTHNAME(order_date) AS month,
    LAG(order_date) OVER(PARTITION BY cust_id ORDER BY order_date) = order_date AS same_flag
  FROM transactions
)
SELECT 
  month,
  COUNT(same_flag) AS retained_customers
FROM cte
GROUP BY month;

🎯 Goal
Generate a report showing retained customers who placed orders in consecutive months. This helps analyze customer loyalty, repeat purchase behavior, and overall retention trends.
