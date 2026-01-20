🧩 Friend Page Recommendation Query
🧠 Problem
You are given two tables — friends and likes.

friends — stores user-friend relationships
likes — stores which user likes which page
The task is to find pages that a user’s friends like but the user hasn’t liked yet.
This helps recommend new pages or interests to users based on their friends’ activity.

🎯 Goal
Return a list of users along with the pages liked by their friends that they haven’t liked themselves.
This will serve as a simple page recommendation system.

🪜 Approach
Join the friends and likes tables to get all pages liked by a user’s friends.
Use a subquery to exclude pages that the user already likes.
Apply DISTINCT to remove duplicate recommendations.
Sort the results by user_id and page_id for clarity.

💻 Query
```
SELECT DISTINCT 
    f.user_id, 
    l.page_id
FROM 
    friends f
JOIN 
    likes l 
    ON f.friend_id = l.user_id
WHERE 
    l.page_id NOT IN (
        SELECT 
            page_id 
        FROM 
            likes 
        WHERE 
            user_id = f.user_id
    )
ORDER BY 
    f.user_id, 
    l.page_id;
```

📊 Example
friends

user_id	friend_id
1	2
1	3
2	1
2	3
3	1
3	2
4	2
likes

user_id	page_id
1	A
2	B
2	C
3	A
3	B
Output

user_id	page_id
1	B
1	C
3	C
4	B
4	C
🧾 Explanation
The join connects each user with the pages liked by their friends.
The subquery filters out pages already liked by the user.
DISTINCT ensures unique recommendations.
The final result lists all potential new pages for each user.
