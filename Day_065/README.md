# Poll Winning Amount Calculation

## Problem  
We need to calculate each user’s winning amount in a poll based on their correct answers and the total amount collected for that poll. The goal is to distribute the total poll amount among users who selected the correct option.

## Goal  
To compute the winning amount for each user by dividing the total poll amount proportionally among users who answered correctly.

## Approach  
1. **Extract poll and answer data** from the `polls` and `poll_answers` tables.  
2. **Create a CTE (`winning_amount_cte`)** to calculate each user’s winning amount and the total number of correct answers per poll using a window function.  
3. **Create another CTE (`total_amount_cte`)** to calculate the total amount collected per poll.  
4. **Join both CTEs** on `poll_id` to distribute the total amount among the correct users.  
5. **Round the final winning amount** to two decimal places for clarity.

## SQL Query  
```sql
WITH winning_amount_cte AS (
    SELECT 
        p.poll_id,
        p.user_id,
        amount AS winning_amount,
        SUM(amount) OVER (PARTITION BY p.poll_id) AS div_amount
    FROM polls p
    LEFT JOIN poll_answers pa 
        ON p.poll_id = pa.poll_id 
        AND p.poll_option_id = pa.correct_option_id
    WHERE pa.poll_id IS NOT NULL
),
total_amount_cte AS (
    SELECT 
        p.poll_id,
        SUM(amount) AS total_amount 
    FROM polls p
    LEFT JOIN poll_answers pa 
        ON p.poll_id = pa.poll_id 
        AND p.poll_option_id = pa.correct_option_id
    WHERE pa.poll_id IS NULL
    GROUP BY p.poll_id
)
SELECT 
    wac.poll_id,
    wac.user_id,
    ROUND((winning_amount / div_amount) * total_amount, 2) AS winning_amount
FROM winning_amount_cte wac
JOIN total_amount_cte tac 
    ON wac.poll_id = tac.poll_id;
```

Output
poll_id	user_id	winning_amount
p1	id2	750.00
p1	id5	150.00
p2	id9	1200.00
p2	id6	600.00
