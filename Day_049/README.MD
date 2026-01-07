User Booking Analysis
This project focuses on analyzing user booking data to understand booking patterns across different segments, booking types, and time periods. The queries were written and executed in MySQL Workbench 8.0.

📘 Objective
To explore user booking behavior by:

Counting users by segment and identifying those who booked flights in April 2022.
Finding users whose first booking was a hotel.
Calculating the time gap between each user’s first and last booking.
Comparing flight and hotel booking counts across user segments.
🧩 Database Tables
user_table
Column	Type	Description
user_id	VARCHAR	Unique ID for each user
segment	VARCHAR	User segment/category
booking_table
Column	Type	Description
user_id	VARCHAR	User ID (foreign key)
booking_date	DATE	Date of booking
line_of_business	VARCHAR	Type of booking (Flight or Hotel)
🧠 Queries
1️⃣ Count total users per segment and users who booked a flight in April 2022
SELECT 
    u.segment,
    COUNT(DISTINCT u.user_id) AS no_of_users,
    COUNT(DISTINCT CASE 
        WHEN YEAR(b.booking_date) = '2022' 
             AND MONTH(b.booking_date) = '04'
             AND b.line_of_business = 'Flight'
        THEN b.user_id 
    END) AS users_who_booked_flight_in_apr_2022
FROM user_table u 
LEFT JOIN booking_table b 
    ON u.user_id = b.user_id
GROUP BY u.segment;
2️⃣ Find users whose first booking was a hotel
WITH cte AS (
    SELECT *,
           RANK() OVER(PARTITION BY user_id ORDER BY booking_date) AS rnk
    FROM booking_table
)
SELECT 
    user_id,
    booking_date,
    line_of_business
FROM cte
WHERE rnk = 1 
  AND line_of_business = 'Hotel';
3️⃣ Calculate the time difference between first and last bookings
SELECT 
    user_id,
    MIN(booking_date) AS first_booking_date,
    MAX(booking_date) AS last_booking_date,
    DATEDIFF(MAX(booking_date), MIN(booking_date)) AS no_of_days
FROM booking_table
GROUP BY user_id;
Sample Output:

user_id	first_booking_date	last_booking_date	no_of_days
u1	2022-03-23	2022-05-06	44
u2	2022-03-27	2022-04-28	32
u4	2022-03-31	2022-05-04	34
u5	2022-04-06	2022-04-20	14
u6	2022-04-06	2022-04-22	16
4️⃣ Count flight and hotel bookings for each user segment
SELECT 
    u.segment, 
    COUNT(CASE WHEN b.line_of_business = 'Flight' THEN 1 END) AS flight_bookings,
    COUNT(CASE WHEN b.line_of_business = 'Hotel' THEN 1 END) AS hotel_bookings
FROM user_table u 
JOIN booking_table b 
    ON u.user_id = b.user_id
GROUP BY u.segment;
