# 🧩 Split Full Name into First, Middle, and Last Names

## 🧠 Problem
You are given a table `customers` that contains a single column `customer_name` storing the full name of each customer.  
This structure makes it difficult to analyze or sort data based on individual name components.

Each record includes:
- `customer_name` — the full name of the customer (e.g., *Vishal Pratap Singh*)

The challenge is to separate this full name into **first**, **middle**, and **last** names.

---

## 🎯 Goal
Return a list of customers with their names split into three separate columns — `first_name`, `middle_name`, and `last_name` — for better readability and data analysis.

---

## 🪄 Approach
1. Used the `SUBSTRING_INDEX()` function to extract the **first name** as the first word from `customer_name`.  
2. Applied a `CASE` statement to check if the name contains more than two words.  
   - If true, used nested `SUBSTRING_INDEX()` to extract the **middle name**.  
3. Used another `CASE` statement with `SUBSTRING_INDEX(customer_name, ' ', -1)` to extract the **last name**.  
4. Displayed all three parts along with the original `customer_name` for verification.

---

## 💻 Query
```sql
SELECT 
    customer_name,
    SUBSTRING_INDEX(customer_name, ' ', 1) AS first_name,
    CASE 
        WHEN customer_name LIKE '% % %' 
        THEN SUBSTRING_INDEX(SUBSTRING_INDEX(customer_name, ' ', 2), ' ', -1)
        ELSE NULL 
    END AS middle_name,
    CASE 
        WHEN customer_name LIKE '% %' 
        THEN SUBSTRING_INDEX(customer_name, ' ', -1)
        ELSE NULL 
    END AS last_name
FROM customers;

```

📊 Output
customer_name	first_name	middle_name	last_name
Ankit Bansal	Ankit	NULL	Bansal
Vishal Pratap Singh	Vishal	Pratap	Singh
Michael	Michael	NULL	NULL
🏁 Summary
This query efficiently splits full names into first, middle, and last names using MySQL string functions and conditional logic.
It handles names with one, two, or three parts and ensures clean, structured output.
