# Day 60 Solution – House with Maximum Battle Wins by Region

## Problem  
Find the house that has won the most battles in each region from the Game of Thrones dataset.

## Task  
Write a SQL query to identify, for every region, the house with the highest number of battle wins.  
Display the region name, house name, and the total number of battles won.

## Goal  
To find out which house won the most battles in each region and show which house was the strongest in that area.

## Approach  
- I first created a CTE to find the winner of each battle using a `CASE` statement. If the `attacker_outcome` was 1, I selected the `attacker_king` as the winner; otherwise, I selected the `defender_king`.  
- Next, I joined this CTE with the `king` table to get the house name for each winner.  
- Then, I counted how many battles each house won in every region.  
- After that, I used the `RANK()` window function to rank the houses within each region based on the number of battles won, sorting them in descending order.  
- Once the ranking was done, I selected only the top-ranked house (rank = 1) from each region.  
- Finally, I displayed the region name, house name, and the total number of battles won.

## Query  

```sql
WITH cte AS (
  SELECT name,
         region,
         CASE 
           WHEN attacker_outcome = 1 THEN attacker_king
           ELSE defender_king 
         END AS winner
  FROM battle
),
cte_2 AS (
  SELECT b.region,
         k.house,
         COUNT(*) AS battles_won,
         RANK() OVER (PARTITION BY region ORDER BY COUNT(*) DESC) AS rnk
  FROM cte b
  JOIN king k ON b.winner = k.k_no
  GROUP BY b.region, k.house
)
SELECT region, house, battles_won
FROM cte_2
WHERE rnk = 1;
```


Output
region	house	battles_won
The North	House Stark	2
The Reach	House Stark	1
The Reach	House Martell	1
The Riverlands	House Baratheon	2
