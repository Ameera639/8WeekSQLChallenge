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

All 10 questions were solved successfully
Ranking and window functions were used to analyze customer order patterns
Insights include top spending customers, most popular menu items, and customer visit frequency


🏆 Learnings

Organizing SQL queries professionally
Applying Ranking and Window Functions in real datasets
Understanding table relationships and customer behavior
Building a clean, portfolio-ready SQL project

Results Screenshots

![Q1 Total Spending](results/Q1_Total_Spending_By_Customer.png)
![Q2 Most Purchased](results/Q2_Most_Purchased_Items.png)
![Q3 Customer Visits](results/Q3_Customer_Visit_Count.png)
![Q4 Top Products By Category](results/Q4_Top_Products_By_Category.png)
![Q5 Average Order Value](results/Q5_Average_Order_Value.png)
![Q6 Member vs NonMember](results/Q6_Member_vs_NonMember_Comparison.png)
![Q7 Order Ranking](results/Q7_Order_Ranking_Per_Customer.png)
![Q8 First and Last Purchase](results/Q8_First_and_Last_Purchase.png)
![Q9 Customer Loyalty](results/Q9_Customer_Loyalty_Analysis.png)
![Q10 Profit By Product](results/Q10_Profit_By_Product.png)



FROM sales
GROUP BY customer_id
