# SQL Query: Checking if Seller’s Second Sold Item Matches Favorite Brand

## Problem
We have three tables — `orders_details`, `users_brands`, and `items`.  
- The `orders_details` table stores details of each sale, including the seller, buyer, item, and order date.  
- The `users_brands` table stores each seller’s favorite brand.  
- The `items` table lists item IDs with their corresponding brands.  

The goal is to find out whether the **brand of the second item sold by each seller** matches their **favorite brand**.

## Task
Write a query that checks, for each seller, if the brand of their second sold item (based on order date) matches their favorite brand.  
If a seller has sold fewer than two items, display **"No"** for that seller.

## Approach
1. A CTE was created to join the `orders_details`, `users_brands`, and `items` tables. This brought together each seller’s order date, favorite brand, and the brand of the item they sold.  
2. The `ROW_NUMBER()` function was used to assign a rank to each sale per seller based on the order date, identifying the first, second, and later sales.  
3. A conditional check compared the brand of the second sold item (`rno = 2`) with the seller’s favorite brand.  
4. The `MAX()` function was used to extract the result for the second sale, and `COALESCE()` ensured that sellers with fewer than two sales showed “No” instead of a blank value.  

## Query
```sql
WITH cte AS (
  SELECT 
    od.order_date,
    od.seller_id,
    ub.favorite_brand AS fav_brand,
    i.item_brand AS item_brand,
    ROW_NUMBER() OVER(PARTITION BY od.seller_id ORDER BY od.order_date) AS rno
  FROM orders_details od
  JOIN users_brands ub ON od.seller_id = ub.user_id
  JOIN items i ON od.item_id = i.item_id
)
SELECT 
  ub.user_id AS seller_id,
  COALESCE(
    MAX(
      CASE 
        WHEN rno = 2 THEN 
          CASE WHEN item_brand = fav_brand THEN 'Yes' ELSE 'No' END
      END
    ), 'No'
  ) AS item_fav_brand
FROM users_brands ub
LEFT JOIN cte ON ub.user_id = cte.seller_id
GROUP BY ub.user_id;
