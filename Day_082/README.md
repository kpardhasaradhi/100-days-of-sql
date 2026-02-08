Day 82 – 🏏 ICC World Cup Points Table Challenge

---

🧩 Problem
We have a table named icc_world_cup_2026 that stores match results with columns for team_1, team_2, and winner. The goal is to calculate each team’s total matches, wins, draws, losses, and total points based on match outcomes.

---

🎯 Goal
Generate a points table showing each team’s performance, including total matches played, matches won, drawn, lost, and total points, sorted by the number of matches won in descending order.

---

🧠 Approach

First, I created a CTE named teams_cte using the WITH clause to calculate match statistics for each team.
Next, I used two SELECT queries with a UNION — one for team_1 and one for team_2 — to include all teams in the dataset.
Then, I applied COUNT() with CASE WHEN to calculate matches won and drawn for each team.
After that, I grouped the results by team name using GROUP BY to get totals per team.
Finally, I calculated matches lost and total points using the formula (matches_won * 2) + matches_drawn and sorted the results by matches_won in descending order.

---

🧾 Query
```sql

WITH teams_cte AS (
    SELECT team_1,
           COUNT(*) AS total_matches,
           COUNT(CASE WHEN winner = team_1 THEN 1 END) AS matches_won,
           COUNT(CASE WHEN winner = 'DRAW' THEN 1 END) AS matches_drawn
    FROM icc_world_cup_2026
    GROUP BY team_1

    UNION

    SELECT team_2,
           COUNT(*) AS total_matches,
           COUNT(CASE WHEN winner = team_2 THEN 1 END) AS matches_won,
           COUNT(CASE WHEN winner = 'DRAW' THEN 1 END) AS matches_drawn
    FROM icc_world_cup_2026
    GROUP BY team_2
)
SELECT team_1 AS team,
       total_matches,
       matches_won,
       matches_drawn,
       total_matches - matches_won AS matches_lost,
       (matches_won * 2) + matches_drawn AS points
FROM teams_cte
ORDER BY matches_won DESC;
```
---

🧮 Output

team	total_matches	matches_won	matches_drawn	matches_lost	points

IND	5	4	1	0	9

ENG	5	3	1	1	7

AUS	4	2	1	1	5

💡 Key Learnings

Learned how to use CASE WHEN within COUNT() to handle conditional aggregations.
Understood how to use UNION to combine results from two similar queries.
Practiced using a CTE for cleaner and more organized SQL logic.
Reinforced the use of calculated columns for metrics like points and losses.

🏁 Summary
This challenge helped me create a cricket points table using SQL by combining match data for both teams, applying conditional logic, and calculating performance metrics. It strengthened my understanding of CTE, CASE WHEN, and aggregation functions in SQL.
