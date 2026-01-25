💱 Seller–Buyer Transaction Analysis in SQL

🧩 Problem

We have a table named transactions_day_68 that records customer transactions. Each transaction appears twice — once for the seller and once for the buyer — with the same amount and timestamp.

We need to identify unique seller–buyer pairs who have transacted together, count their total transactions, and remove users who acted as both seller and buyer.

🎯 Goal
To get a list of unique one‑way seller–buyer pairs with their total number of transactions, excluding customers who appear in both roles.

⚙️ Approach
Step 1:
Join the transactions_day_68 table to itself on matching amount and tran_date to pair transactions that happened at the same time and for the same amount.

Step 2:
Use a CASE statement to assign roles — the smaller transaction ID becomes the seller, and the larger one becomes the buyer. This avoids duplicates like (101, 201) and (201, 101).

Step 3:
Group the results by seller and buyer to count how many transactions each pair has together.

Step 4:
Find users who appear as both sellers and buyers by joining the result to itself.

Step 5:
Filter out those common users so that only one‑way relationships remain — sellers who never acted as buyers and buyers who never acted as sellers.

💻 SQL Query

```sql

WITH cte AS (
    SELECT 
        CASE WHEN t1.transaction_id < t2.transaction_id THEN t1.customer_id ELSE t2.customer_id END AS seller,
        CASE WHEN t1.transaction_id < t2.transaction_id THEN t2.customer_id ELSE t1.customer_id END AS buyer,
        t1.amount,
        t1.tran_date
    FROM transactions_day_68 t1
    JOIN transactions_day_68 t2
      ON t1.amount = t2.amount
      AND t1.tran_date = t2.tran_date
      AND t1.customer_id < t2.customer_id
),
transactions_cte AS (
    SELECT seller, buyer, COUNT(*) AS total_transactions
    FROM cte
    GROUP BY seller, buyer
),
common_seller_and_buyer_cte AS (
    SELECT DISTINCT c1.seller AS common_user
    FROM cte c1
    JOIN cte c2
      ON c1.seller = c2.buyer
)
SELECT *
FROM transactions_cte
WHERE seller NOT IN (SELECT common_user FROM common_seller_and_buyer_cte)
  AND buyer NOT IN (SELECT common_user FROM common_seller_and_buyer_cte);

```

📊 Sample Output

seller	buyer	total_transactions

101	201	2
103	203	1
