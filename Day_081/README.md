Day 81 – 👨‍👩‍👧 Find Each Child’s Parents Challenge

---

🧩 Problem
We have two tables, people and relations. The people table stores each person’s ID, name, and gender, while the relations table connects parents and children using their IDs. The task is to find each child’s name along with their father’s and mother’s names.

---

🎯 Goal
Display a list showing each child’s name with their corresponding father and mother by joining both tables and identifying parents based on gender.

---

🧠 Approach

First, I started with the SELECT statement to display each child’s name as child_name along with parent names.
Next, I used the CASE WHEN statement to check the parent’s gender and assign the name as father or mother.
Then, I applied the MAX() function to merge both parent names into one row for each child.
After that, I joined the people table (as child) with the relations table and again with the people table (as parents) to link children with their parents.
Finally, I grouped the results by child.name using GROUP BY so that each child appeared once with both parents’ names.


🧾 Query
```sql
SELECT 
    child.name AS child_name,
    MAX(CASE WHEN parents.gender = 'M' THEN parents.name END) AS father,
    MAX(CASE WHEN parents.gender = 'F' THEN parents.name END) AS mother
FROM people child
JOIN relations r
JOIN people parents
ON child.id = r.c_id AND r.p_id = parents.id
GROUP BY child.name;

```

---

🧮 Output

child_name	father	mother

Hawbaker	Blackston	Days

Keffer	Canty	Hansel

Mozingo	Nolf	Criss

Waugh	Tong	Chatmon

Dimartino	Beane	Hansard

---

💡 Key Learnings

Learned how to use CASE WHEN to categorize data based on conditions.
Understood how MAX() can combine multiple rows into one.
Practiced joining the same table multiple times using aliases.
Strengthened understanding of GROUP BY for grouped aggregation.
🏁 Summary
This challenge helped me identify parent-child relationships by joining tables and using conditional logic. It reinforced the use of CASE WHEN, aggregation, and joins to produce clean, structured results in SQL.
