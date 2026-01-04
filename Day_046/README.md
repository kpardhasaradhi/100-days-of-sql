# Find Users Who Bought Different Products on Different Dates

## Overview
This SQL query identifies users who made purchases on more than one date and bought **different products** on each of those dates. The goal is to find users who did not repeat the same product across multiple purchase dates.

## Problem
We have a table named `purchase_history` that stores user purchase details with columns:
- `userid`
- `productid`
- `purchasedate`

Each user can make multiple purchases on different dates. We need to find users who made purchases on more than one date and bought **unique products** on each date.

## Task
Find users who purchased on multiple dates (`COUNT(DISTINCT purchasedate) > 1`) and whose total number of products equals the number of distinct products (`COUNT(productid) = COUNT(DISTINCT productid)`).

## Goal
Return a list of `userid`s who made purchases on more than one date and never bought the same product twice.

## SQL Query
```sql
SELECT userid
FROM purchase_history
GROUP BY userid
HAVING COUNT(DISTINCT purchasedate) > 1
   AND COUNT(productid) = COUNT(DISTINCT productid);

```


Output Example
userid
1
4
Approach
I grouped the data by userid to analyze each user’s purchase history.
I used COUNT(DISTINCT purchasedate) to find users who purchased on more than one date.
I compared COUNT(productid) with COUNT(DISTINCT productid) to ensure no product was repeated.
I used the HAVING clause to filter only those users who met both conditions.
The query returned users who bought different products on different dates.
Notes
