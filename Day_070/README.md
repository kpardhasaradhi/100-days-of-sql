🥇 Day 70 – Gold Medalists Who Never Won Silver or Bronze

🧩 Problem

The task is to identify athletes who have won gold medals but have never won silver or bronze in any Olympic event. This helps highlight athletes who exclusively achieved top positions.

🎯 Goal

The goal is to find all athletes who appear in the gold medal list but do not appear in either the silver or bronze medal lists, along with their total count of gold medals.

🧠 Approach

First, select all records from the olympic_events table to understand the data structure.
Next, focus on the gold column to identify athletes who have won gold medals.
Then, use subqueries to exclude athletes who appear in the silver or bronze columns.
After that, group the remaining athletes by name to count how many gold medals each has won.
Finally, display the athlete’s name and their total gold medal count.

🧾 Query

```sql

SELECT gold AS athlete, COUNT(*) AS medal_count
FROM olympic_events
WHERE gold NOT IN (SELECT silver FROM olympic_events)
  AND gold NOT IN (SELECT bronze FROM olympic_events)
GROUP BY athlete;
```

🧮 Output


athlete	medal_count

Amthhew Mcgarry	1

Charles	3

Ronald	1

Thomas	3

Jessica	1

💡 Key Learnings

Learned how to use subqueries to exclude specific records from results.
Practiced filtering logic with NOT IN to refine dataset selection.
Reinforced the use of GROUP BY and aggregate functions for summarizing data.
Understood how to combine multiple conditions to isolate unique cases.

🏁 Summary

This challenge demonstrated how to identify athletes who exclusively won gold medals using subqueries and grouping. It reinforced filtering techniques and aggregation logic to extract meaningful insights from relational data.
