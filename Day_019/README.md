🧾 Day 19 – Customer Churn (Inactivity by Month)
💡 Problem Statement
We have a transactions table containing cust_id, order_date, and amount. The goal is to identify customers who did not place orders in consecutive months, meaning they became inactive or churned after their last purchase. This helps measure customer drop‑off trends and inactivity patterns.

🗂️ Table Details
transactions

cust_id – Unique customer identifier
order_date – Date of the order
amount – Order amount
🌿 Approach
Created a CTE to compare each customer’s current order month with their next order month.
Used the LEAD(order_date) window function with PARTITION BY cust_id to get the next order date for each customer.
Applied MONTHNAME(order_date) and MONTH(order_date) to extract the month name and number for reporting.
Used COALESCE() to flag customers who didn’t place an order in the next month (is_not_ordered = 'Y').
Filtered and grouped results by month to count inactive customers.

🧠 SQL Solution


WITH cte AS (
  SELECT 
    MONTHNAME(order_date) AS month,
    MONTH(order_date) AS month_number,
    COALESCE(LEAD(order_date) OVER(PARTITION BY cust_id), 'Y') AS is_not_ordered
  FROM transactions
)
SELECT 
  month,
  COUNT(is_not_ordered) AS inactive_customers
FROM cte
WHERE is_not_ordered = 'Y'
GROUP BY month;

🎯 Goal
Generate a report showing inactive or churned customers who did not place orders in consecutive months. This helps identify customer drop‑off patterns and supports strategies to re‑engage inactive users.

