# 🧮 Day 78 – Team Qualification Check Using CTEs

---

**🧩 Problem**  
The task was to identify which team members are qualified based on two criteria and to mark them as qualified only if their team has more than one member meeting both conditions.

---

**🎯 Goal**  
The goal was to calculate each member’s qualification status and determine if the team collectively meets the required number of qualified members.

---

**🧠 Approach**  
- **First**, I created a **CTE** to check each member’s criteria using a `CASE WHEN` statement and assigned a value of 1 when both `criteria1` and `criteria2` were ‘Y’, otherwise 0.  
- **Next**, I used **GROUP BY** with **SUM** to calculate the total qualified count for each member based on their `teamid` and `memberid`.  
- **Then**, I created a second **CTE** to sum up the qualified members for each team, giving the total number of members who met both criteria.  
- **After that**, I used a **LEFT JOIN** between the two CTEs on `teamid` to compare each member’s results with the team’s total qualified count.  
- **Finally**, I used a **CASE WHEN** statement to mark ‘Y’ if both criteria were ‘Y’ and the team had more than one qualified member, otherwise marked it as ‘N’.

---

**🧾 Query**
```sql
WITH cte AS (
  SELECT 
    teamid,
    memberid,
    criteria1,
    criteria2,
    SUM(CASE WHEN criteria1 = 'Y' AND criteria2 = 'Y' THEN 1 ELSE 0 END) AS qualified
  FROM Ameriprise_llc
  GROUP BY teamid, memberid, criteria1, criteria2
),
cte2 AS (
  SELECT 
    teamid,
    SUM(qualified) AS min_qualification
  FROM cte
  GROUP BY teamid
)
SELECT 
  c1.teamid,
  c1.memberid,
  c1.criteria1,
  c1.criteria2,
  CASE 
    WHEN c1.criteria1 = 'Y' AND c1.criteria2 = 'Y' AND c2.min_qualification > 1 THEN 'Y'
    ELSE 'N'
  END AS qualified
FROM cte c1
LEFT JOIN cte2 c2 
ON c1.teamid = c2.teamid;
```

🧮 Output

teamid	memberid	criteria1	criteria2	qualified
T1	T1_mbr1	Y	Y	Y
T1	T1_mbr2	Y	Y	Y
T1	T1_mbr3	Y	N	N
T1	T1_mbr4	Y	N	N
T1	T1_mbr5	N	N	N
T2	T2_mbr1	Y	N	N
T2	T2_mbr2	N	N	N
T2	T2_mbr3	N	N	N
T2	T2_mbr4	N	N	N
T2	T2_mbr5	N	N	N


💡 Key Learnings

Learned how to use CTEs to simplify multi-step SQL logic.
Practiced using CASE WHEN for conditional calculations.
Understood how to apply aggregate functions like SUM() with GROUP BY.
Gained experience in comparing individual results with team-level summaries using JOINs.
Strengthened understanding of logical filtering in SQL queries.
🏁 Summary
This challenge demonstrated how to use multiple CTEs and conditional logic to evaluate team-level qualifications. It showed how to combine aggregation, joins, and conditional expressions to produce clear and meaningful results
