🧩 Active Subscriptions as of January 1, 2021
🧠 Problem
We need to find customers whose subscriptions were still active on or after January 1, 2021.
The data is stored in a subscription_history table that contains multiple records per customer with event dates and subscription periods.

🎯 Goal
To display each customer’s latest subscription details before January 1, 2021, and calculate the date until their plan was valid.
Only customers whose subscriptions remained active on or after January 1, 2021, should be shown.

🪜 Approach
Step 1: First, I created a CTE to get all subscription records before January 1, 2021.
Step 2: Then, I used the ROW_NUMBER() function to rank each record by event date (latest first) for every customer.
Step 3: Next, I selected only the record with rno = 1, which represents the most recent subscription before 2021.
Step 4: After that, I used the DATE_ADD() function to add the subscription period (in months) to the event date to calculate the valid_until date.
Step 5: Finally, I filtered only those customers whose valid_until date is on or after January 1, 2021, and ordered the results by customer_id.

💻 Query
```sql
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY event_date DESC) AS rno
    FROM subscription_history
    WHERE event_date < '2021-01-01'
)
SELECT *,
       DATE_ADD(event_date, INTERVAL subscription_period MONTH) AS valid_until
FROM cte
WHERE rno = 1
  AND subscription_period IS NOT NULL
  AND DATE_ADD(event_date, INTERVAL subscription_period MONTH) >= '2021-01-01'
ORDER BY customer_id;
```

📊 Example
Input Table: subscription_history

customer_id	marketplace	event_date	event	subscription_period
1	India	2020-12-05	R	1
3	USA	2020-12-01	R	12
6	UK	2020-07-05	S	6
7	Canada	2020-08-15	S	12
Output:

customer_id	marketplace	event_date	event	subscription_period	rno	valid_until
1	India	2020-12-05	R	1	1	2021-01-05
3	USA	2020-12-01	R	12	1	2021-12-01
6	UK	2020-07-05	S	6	1	2021-01-05
7	Canada	2020-08-15	S	12	1	2021-08-15
🧾 Explanation
The CTE filters records before 2021 and ranks them per customer.
The ROW_NUMBER() ensures we only take the latest record for each customer.
The DATE_ADD() function calculates the subscription’s end date.
The final filter keeps only subscriptions valid on or after January 1, 2021.
✅ Result
This query helps identify all customers who still had an active subscription as of January 1, 2021, based on their last recorded subscription period.
