 Case Study 1 – Danny’s Diner

 📌 Dataset
This case study uses a small restaurant dataset with three tables:
- sales – Customer orders  
- menu – Product details and prices  
- members – Customer membership dates  
We analyze the data to answer real-world business questions.

 📈 Ranking & Window Functions
A key focus of this project is Ranking to analyze customer behavior:

- Identify top customers based on total spending  
- Rank orders by date for each customer  
- Compare members vs non-members  
- Track the first and last purchase per customer  

✅ Results

All 8 questions were solved successfully

Ranking and window functions were used to analyze customer order patterns

Insights include top spending customers, most popular menu items, and customer visit frequency


🏆 Learnings

Organizing SQL queries professionally

Applying Ranking and Window Functions in real datasets

Understanding table relationships and customer behavior

Building a clean, portfolio-ready SQL project
FROM sales
GROUP BY customer_id;
