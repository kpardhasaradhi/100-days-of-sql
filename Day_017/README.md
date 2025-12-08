💡 Problem Statement
Identify which pairs of products are most frequently bought together in the same order. Each order can contain multiple products, and we want to find all unique product combinations that appear together.

🗂️ Dataset Tables
Tables: orders_17, products

orders_17

order_id – Unique identifier for each order
product_id – ID of the product purchased in that order
products

id – Unique product identifier
name – Product name
🌿 Approach
Join the orders_17 table to itself using order_id to find all product pairs that appear together in the same order.
Use the condition o1.product_id < o2.product_id to avoid duplicate and reverse pairs (like AB and BA).
Join both instances of the orders_17 table with the products table to get product names.
Combine product names using CONCAT() and group by the pair to count how many times each combination occurs.

🧠 SQL Solution
SELECT 
    CONCAT(p1.name, ', ', p2.name) AS product_pair,
    COUNT(*) AS frequency
FROM orders_17 o1
JOIN orders_17 o2 
    ON o1.order_id = o2.order_id
JOIN products p1 
    ON o1.product_id = p1.id
JOIN products p2 
    ON o2.product_id = p2.id
WHERE o1.product_id < o2.product_id
GROUP BY p1.name, p2.name
ORDER BY frequency DESC;

🎯 Goal
Generate a report showing product combinations and how often they are purchased together.
This helps identify popular product pairs for cross-selling, bundling, and recommendation strategies.
