# Day 1 - Points Table from Match Results

Problem:
Given a table with `team_1`, `team_2`, and `winner`, create a points table with:
- total matches played
- matches won
- matches lost

Concepts used:
- `UNION ALL` to combine team_1 and team_2 into one column
- `CASE WHEN` for conditional win flag
- `GROUP BY` for team level summary
- `ORDER BY` to rank teams by wins

Thought process:
1. Combine both team columns into one list.
2. Add a win flag using CASE WHEN.
3. Group by team to count matches, wins, and losses.
4. Sort by number of wins.
