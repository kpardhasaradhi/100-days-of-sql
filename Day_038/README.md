```markdown
# Call Duration Comparison in MySQL

## Overview
This project analyzes call records from the `call_details` table to compare total incoming and outgoing call durations for each phone number.  
It identifies numbers where the total **outgoing call duration** is greater than the **incoming call duration**.

## Problem
The `call_details` table contains details such as:
- `call_number`
- `call_type` (either `'INC'` for incoming or `'OUT'` for outgoing)
- `call_duration`

We need to find which numbers spend more time making outgoing calls than receiving incoming calls.

## Task
Use **Common Table Expressions (CTEs)** to calculate total incoming and outgoing call durations separately for each number.  
Then, join both results and filter only those numbers where outgoing duration exceeds incoming duration.

## Goal\
Display the following columns:
- `call_number`
- `out_dur` — total outgoing call duration  
- `in_dur` — total incoming call duration  

Show only numbers where `out_dur > in_dur`.

## SQL Query
```sql
WITH inc_call AS (
    SELECT 
        call_number,
        call_type,
        SUM(call_duration) AS in_dur
    FROM call_details
    WHERE call_type = 'INC'
    GROUP BY call_number
),
out_call AS (
    SELECT 
        call_number,
        call_type,
        SUM(call_duration) AS out_dur
    FROM call_details
    WHERE call_type = 'OUT'
    GROUP BY call_number
)
SELECT 
    o.call_number,
    o.out_dur,
    i.in_dur
FROM inc_call i
JOIN out_call o 
    ON i.call_number = o.call_number
WHERE o.out_dur > i.in_dur;
```

## Output Example
| call_number | out_dur | in_dur |
|--------------|---------|--------|
| 2159010      | 338     | 18     |

```
