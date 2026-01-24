🎓 Perfect Score Analysis by Experience Level in SQL

🧩 Problem
We need to find how many students scored a perfect 100 in all three subjects — SQL, Algorithm, and Bug Fixing — grouped by their experience level.

🎯 Goal
To compare performance across different experience levels by showing:

The number of students who achieved perfect scores in all subjects.
The total number of students in each experience group.


⚙️ Approach

Step 1: Combine all three subject scores (sql_test, algo, and bug_fixing) into a single dataset using UNION ALL inside a CTE.
This helps standardize the structure with two columns: score and subject.

Step 2: Create a second CTE to group the data by each student’s id and experience.
Use a CASE statement to check if the student scored 100 in all three subjects.
If yes, mark them with a flag called perfect_score_flag.

Step 3: Aggregate the results by experience to count:

Students with perfect scores (max_score_students).
Total students in each experience group (total_students).

Step 4: Order the results by experience for clarity.

💻 SQL Query
```sql

WITH cte AS (
    SELECT id, experience, sql_test AS score, 'sql' AS subject
    FROM assessments
    UNION ALL
    SELECT id, experience, algo AS score, 'algo' AS subject
    FROM assessments
    UNION ALL
    SELECT id, experience, bug_fixing AS score, 'bug_fixing' AS subject
    FROM assessments
),
cte_2 AS (
    SELECT id, experience,
           CASE WHEN SUM(CASE WHEN score IS NULL OR score = 100 THEN 1 ELSE 0 END) = 3
                THEN 1 ELSE 0 END AS perfect_score_flag
    FROM cte
    GROUP BY id, experience
)
SELECT experience,
       SUM(perfect_score_flag) AS max_score_students,
       COUNT(*) AS total_students
FROM cte_2
GROUP BY experience
ORDER BY experience;

```

📊 Sample Output

experience	max_score_students	total_students
1	1	1
3	0	1
5	2	3
