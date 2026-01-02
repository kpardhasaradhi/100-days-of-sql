# Compare Orders Between Two Tables in MySQL

## Overview
This SQL script compares two tables — `tbl_orders` and `tbl_orders_copy` — to identify which orders were **inserted** or **deleted** between them.  
It uses `LEFT JOIN` operations and `UNION ALL` to produce a consolidated result showing differences between the two datasets.

## Problem
We have two tables:
- `tbl_orders`: represents the current list of orders.
- `tbl_orders_copy`: represents a previous snapshot of orders.

Some orders may exist in one table but not in the other. The goal is to detect which orders were **added** or **removed**.

## Task
Determine which records are:
- **Inserted (I):** present in `tbl_orders` but missing in `tbl_orders_copy`.
- **Deleted (D):** present in `tbl_orders_copy` but missing in `tbl_orders`.

## Goal
Generate a result set with two columns:
- `order_id`: the unique order identifier.
- `flag`: `'I'` for inserted or `'D'` for deleted.

This helps track changes between the two tables.

## SQL Query
```sql
SELECT o.order_id, 'I' AS flag
FROM tbl_orders o
LEFT JOIN tbl_orders_copy c 
  ON o.order_id = c.order_id
WHERE c.order_id IS NULL

UNION ALL

SELECT c.order_id, 'D' AS flag
FROM tbl_orders_copy c
LEFT JOIN tbl_orders o 
  ON o.order_id = c.order_id
WHERE o.order_id IS NULL;

How It Works
The first SELECT finds orders that exist in tbl_orders but not in tbl_orders_copy and labels them 'I'.
The second SELECT finds orders that exist in tbl_orders_copy but not in tbl_orders and labels them 'D'.
UNION ALL combines both results into one list.
```
