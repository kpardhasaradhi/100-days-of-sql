
# Day 012 - Checking if Seller’s Second Sold Item Matches Their Favorite Brand

## Problem
We have three tables — `orders_details`, `users_brands`, and `items`.  
The `orders_details` table stores each sale with the seller, buyer, and item sold.  
The `users_brands` table stores each seller’s favorite brand, and the `items` table lists item IDs with their corresponding brands.  
The goal is to find whether the **second item** sold by each seller matches their favorite brand.

## Task
Write a SQL query to check if the brand of the second item sold by each seller (based on order date) matches their favorite brand.  
If a seller has fewer than two sales, display **'No'** for that seller.

## Goal
Identify whether each seller’s second sold item matches their favorite brand and show **'Yes'** or **'No'** for each seller.

## Query
```sql

WITH rnk_orders AS (
    SELECT *,
           RANK() OVER (PARTITION BY seller_id ORDER BY order_date ASC) AS rn
    FROM orders_details
)
SELECT 
    u.user_id AS seller_id,
    CASE 
        WHEN i.item_brand = u.favorite_brand THEN 'Yes'
        ELSE 'No'
    END AS item_fav_brand
FROM users_brands u
LEFT JOIN rnk_orders r 
    ON r.seller_id = u.user_id 
    AND r.rn = 2
LEFT JOIN items i 
    ON i.item_id = r.item_id;


Approach
The goal was to check if each seller’s second sold item matched their favorite brand.
First, a CTE (rnk_orders) was created to assign a rank to each seller’s orders using the RANK() function, ordering them by order_date.
Then, the main query joined this ranked data with the users_brands table to get each seller’s favorite brand and with the items table to get the brand of the sold item.
Next, the condition r.rn = 2 was used to select only the second sale for each seller.
Finally, a CASE statement compared the item’s brand with the seller’s favorite brand and returned 'Yes' if they matched, otherwise 'No'.
Sellers with fewer than two sales were still included using LEFT JOIN, showing 'No' for them.
