# Hall Events Merge Query

## Problem Statement
You are given a table named `hall_events` that stores event schedules for multiple halls. Each record contains:
- `hall_id` – the ID of the hall
- `start_date` – the start date of an event
- `end_date` – the end date of an event

Some events in the same hall may overlap or occur back-to-back. The task is to **merge all overlapping or consecutive events** for each hall and return the final list of merged date ranges.

## Goal
For each `hall_id`, combine all events that overlap or touch each other into a single continuous date range.  
Return the hall ID, the earliest start date, and the latest end date for each merged block.

## Example
### Input
| hall_id | start_date | end_date   |
|----------|-------------|------------|
| 1        | 2023-01-13  | 2023-01-17 |
| 1        | 2023-01-18  | 2023-01-25 |
| 2        | 2022-12-09  | 2022-12-23 |
| 3        | 2022-12-01  | 2023-01-30 |

### Output
| hall_id | start_date | end_date   |
|----------|-------------|------------|
| 1        | 2023-01-13  | 2023-01-25 |
| 2        | 2022-12-09  | 2022-12-23 |
| 3        | 2022-12-01  | 2023-01-30 |

## SQL Solution (MySQL 8.0+)

```sql
with recursive cte as (
    select *, 
           row_number() over (order by hall_id, start_date) as event_id
    from hall_events
),
r_cte as (
    select hall_id, start_date, end_date, event_id, 1 as flag
    from cte where event_id = 1
    union all
    select c.hall_id, c.start_date, c.end_date, c.event_id,
           case 
               when c.hall_id = r.hall_id
                    and (c.start_date between r.start_date and r.end_date
                         or r.start_date between c.start_date and c.end_date)
               then r.flag 
               else r.flag + 1 
           end as flag
    from r_cte r
    inner join cte c on r.event_id + 1 = c.event_id
)
select hall_id,
       min(start_date) as start_date,
       max(end_date) as end_date
from r_cte
group by hall_id, flag
order by hall_id, start_date;
```

Explanation
The first CTE assigns a unique event_id to each event ordered by hall and start date.
The recursive CTE (r_cte) walks through events one by one.
If two events overlap or touch, they share the same flag.
Otherwise, a new flag is assigned to start a new merged block.
The final query groups by hall and flag to get the merged date ranges.
