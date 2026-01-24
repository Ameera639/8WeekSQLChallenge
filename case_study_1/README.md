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
What is the total amount each customer spent at the restaurant?

![Q1 Total Spending](results/Q1_Total_Spending_By_Customer.png)

How many days has each customer visited the restaurant?


![Q2 Most Purchased](results/Q2_Most_Purchased_Items.png)

What was the first item from the menu purchased by each customer?


![Q3 Customer Visits](results/Q3_Customer_Visit_Count.png)

What is the most purchased item on the menu and how many times was it purchased by all customers?


![Q4 Top Products By Category](results/Q4_Top_Products_By_Category.png)

Which item was the most popular for each customer?


![Q5 Average Order Value](results/Q5_Average_Order_Value.png)

Which item was purchased first by the customer after they became a member?


![Q6 Member vs NonMember](results/Q6_Member_vs_NonMember_Comparison.png)

Which item was purchased just before the customer became a member?


![Q7 Order Ranking](results/Q7_Order_Ranking_Per_Customer.png)

What is the total items and amount spent for each member before they became a member?


![Q8 First and Last Purchase](results/Q8_First_and_Last_Purchase.png)

If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?


![Q9 Customer Loyalty](results/Q9_Customer_Loyalty_Analysis.png)

In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?


![Q10 Profit By Product](results/Q10_Profit_By_Product.png)



GROUP BY customer_id
