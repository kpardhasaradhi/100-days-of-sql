🧠 Problem Statement
Analyze user behavior to find how many users who listened to Music events later performed a Prime (P) event within 30 days.

🗂️ Dataset
Table: events

Column	Type	Description
user_id	INT	Unique identifier for each user
type	VARCHAR(10)	Type of event (Music, P, etc.)
access_date	DATE	Date of the event

🧩 Approach
Extract all users who performed a Music event.
Calculate a 30‑day window after each music event.
Identify users who performed a Prime (P) event within that window.
Compute the conversion ratio.

🧾 SQL Solution


with music_cte as (
  select 
    user_id,
    access_date as music_date,
    date_add(access_date, interval 30 day) as thirty_day_period
  from events
  where type = 'Music'
),
prime_cte as (
  select 
    user_id,
    access_date as prime_date
  from events
  where type = 'P'
),
joined_cte as (
  select 
    m.user_id,
    m.music_date,
    p.prime_date,
    m.thirty_day_period < p.prime_date as cnt
  from music_cte m
  left join prime_cte p 
    on m.user_id = p.user_id
)
select 
  count(user_id) as total_users,
  count(prime_date) as prime_users,
  sum(case when cnt = 0 then 1 else 0 end) / count(user_id) as conversion_ratio
from joined_cte;
