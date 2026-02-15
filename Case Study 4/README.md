Case Study 4 – Data Bank Customer & Transactions Analysis

📌 Dataset
This case study uses the Data Bank dataset with three main tables:

regions – Contains region details (Africa, America, Asia, Europe, Oceania)

customer_nodes – Shows which node each customer is allocated to, with start and end dates

customer_transactions – Records all deposits, withdrawals, and purchases per customer

The goal is to analyze customer allocation, transaction behavior, reallocation metrics, and data provisioning needs.

✅ Results
All questions were successfully analyzed. Insights include node distribution, reallocation patterns, transaction statistics, customer balance trends, and data growth options.

🏆 Learnings & Skills

Using window functions (ROW_NUMBER, SUM, AVG) for cumulative balances and percentiles

Calculating median, 80th, 95th percentile, min, avg, max

Analyzing monthly customer balances and deposit/withdrawal behavior

Understanding data allocation strategies based on balance and interest

Working with common table expressions (CTEs) for step-by-step calculations


A. Customer Nodes Exploration


 1️⃣ How many unique nodes are there on the Data Bank system?

<img width"1916" height"178" alt"How many unique nodes are there on the Data Bank system" src"https://github.com/user-attachments/assets/b289c89d-3fad-4798-9cb3-673b5954b90e" />

 3️⃣ How many customers are allocated to each region?

<img width"1884" height"355" alt"Median, 80th, and 95th percentile for reallocation days per region" src"https://github.com/user-attachments/assets/face829f-b642-4c17-ba03-9eced588a61d" />

 4️⃣ How many days on average are customers reallocated to a different node?

<img width"1891" height"660" alt"Min, average, and maximum values of running balance per customer" src"https://github.com/user-attachments/assets/5224bf52-9654-469f-b007-027230c19d86" />


 5️⃣ Median, 80th, and 95th percentile for reallocation days per region



<img width"1866" height"621" alt"Monthly interest based on daily balance (annual rate 6%, no compounding)" src"https://github.com/user-attachments/assets/fe90ff2e-9567-48b7-aa80-f17accacbf3e" />



B. Customer Transactions




1️⃣ What is the unique count and total amount for each transaction type?

<img width"1871" height"171" alt"Percentage of customers who increase closing balance by 5%" src"https://github.com/user-attachments/assets/e5bd2c0e-d03d-4e27-b934-db94d1f39dc0" />





2️⃣ What is the average total historical deposit counts 
   and amounts for all customers?



<img width"1897" height"658" alt"Running customer balance including impact of each transaction" src"https://github.com/user-attachments/assets/1da7e206-e8bf-4630-9156-2c875482f79f" />



3️⃣ For each month - how many Data Bank customers 
   make more than 1 deposit AND either 
   1 purchase OR 1 withdrawal in a single month?



<img width"1874" height"281" alt"Unique count and total amount for each transaction type" src"https://github.com/user-attachments/assets/00318661-f0cf-49d1-b760-7e48e1e0a544" />


4️⃣ What is the closing balance for each customer 
   at the end of each month?


<img width"1871" height"171" alt"Percentage of customers who increase closing balance by 5%" src"https://github.com/user-attachments/assets/e23b0ffa-2de8-4d4e-906f-44ec2136a594" />



5️⃣ What is the percentage of customers who increase 
   their closing balance by more than 5% month-over-month?


 <img width"1866" height"621" alt"Monthly interest based on daily balance (annual rate 6%, no compounding)" src"https://github.com/user-attachments/assets/1117ba82-c0c3-4b1b-9505-2116ae75cc17" />


 
 C. Data Allocation Challenge
 




 2️⃣ Min, average, and maximum values of running balance per customer

<img width"1891" height"660" alt"Min, average, and maximum values of running balance per customer" src"https://github.com/user-attachments/assets/66614166-fd64-4d38-b9ca-398a09bdb48e" />


 
 D. Extra Challenge – Interest Calculation
 

 1️⃣ Monthly interest based on daily balance (annual rate 6%, no compounding)

<img width"1884" height"355" alt"Median, 80th, and 95th percentile for reallocation days per region" src"https://github.com/user-attachments/assets/dbbb9035-1be8-4271-b3cd-188ca4b73b34" />




