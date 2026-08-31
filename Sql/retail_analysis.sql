/* Sales & Profitability by Category */

SELECT product_category,
ROUND(SUM(sales_amount),2) AS Total_Sales, 
ROUND(SUM(profit),2) AS Total_Profit 
FROM retail_sales_dataset_CLEANED 
GROUP BY product_category
ORDER BY Total_Sales DESC

/* Which category generates the most sales? */

SELECT product_category, SUM(sales_amount) AS Total_Sales 
FROM retail_sales_dataset_CLEANED 
GROUP BY product_category
ORDER BY Total_Sales DESC

/* Which category generates the most profit? */

SELECT product_category, SUM(profit) AS Total_Profit
FROM retail_sales_dataset_CLEANED
GROUP BY product_category
ORDER BY Total_Profit DESC

/*Which region performs best? */

SELECT region,
SUM(sales_amount) AS Total_Sales,
SUM(profit) AS Total_Profit
FROM retail_sales_dataset_CLEANED
GROUP BY region
ORDER BY Total_Profit DESC

/* Which region has the highest profit margin? */

SELECT region,
ROUND(SUM(sales_amount),2) AS Total_Sales,
ROUND(SUM(profit),2) AS Total_Profit,
ROUND(SUM(profit) *100.0 /SUM(sales_amount),2) AS Profit_Margin
FROM retail_sales_dataset_CLEANED
GROUP BY region
ORDER BY Profit_Margin DESC

/* Which products sell the most? */

SELECT TOP 10 product_name,
SUM(quantity_final) AS Sell_Most
FROM retail_sales_dataset_CLEANED
GROUP BY product_name
ORDER BY Sell_Most DESC

/* Which category has the best profit margin? */ 

SELECT product_category,
ROUND(SUM(sales_amount),2) AS Total_Sales,
ROUND(SUM(profit),2) AS Total_Profit,
ROUND(SUM(profit) * 100.0 / SUM(sales_amount),2) AS Profit_Margin
FROM retail_sales_dataset_CLEANED
GROUP BY product_category
ORDER BY Profit_Margin DESC 

/* How do discounts relate to profit? */

SELECT discount_group,
COUNT(order_id) AS Total_Order,
ROUND(SUM(sales_amount),2) AS Total_Sales,
ROUND(SUM(profit),2) AS Toatl_Profit,
ROUND(SUM(profit) * 100.0/ NULLIF(SUM(sales_amount),0),2) AS Profit_Margin
FROM retail_sales_dataset_CLEANED
GROUP BY discount_group
ORDER BY Profit_Margin DESC

/* How are customers behaving? */ 

	/* How many orders received each satisfaction score? */

SELECT customer_satisfaction_final,
COUNT(*) AS Total_Orders
FROM retail_sales_dataset_CLEANED
GROUP BY customer_satisfaction_final
ORDER BY customer_satisfaction_final

	/* How much the average customer satisfaction? */

SELECT AVG(customer_satisfaction_final) AS Average_customer_satisfaction
FROM retail_sales_dataset_CLEANED

	/* How frequently are customers placing orders? */ 

SELECT TOP 10 customer_id,
COUNT(order_id) AS Total_Orders
FROM retail_sales_dataset_CLEANED
GROUP BY customer_id
ORDER BY Total_Orders DESC

	/* Which customers generate the most revenue and profit? */

SELECT TOP 10 customer_id,
ROUND(SUM(sales_amount),2) AS Total_Sales,
ROUND(SUM(profit),2) AS Total_Profit,
ROUND(AVG(customer_satisfaction_final),2) AS Avg_customer_satisfaction
FROM retail_sales_dataset_CLEANED
GROUP BY customer_id
ORDER BY Total_Sales DESC

	/* Are less-satisfied customers more likely to return their orders? */

SELECT customer_satisfaction_final,return_flag,
COUNT(order_id) AS Total_Order
FROM retail_sales_dataset_CLEANED
GROUP BY customer_satisfaction_final,return_flag
ORDER BY customer_satisfaction_final,return_flag

SELECT customer_satisfaction_final,
COUNT(order_id) AS Total_Order,
SUM(CASE WHEN return_flag = 1 THEN 1 ELSE 0 END) AS Total_Returns,
ROUND(SUM(CASE WHEN return_flag = 1 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(order_id),0),2) AS Return_rate
FROM retail_sales_dataset_CLEANED
GROUP BY customer_satisfaction_final
ORDER BY customer_satisfaction_final


/* Are returns a problem? */

	/* Overall return analysis */

SELECT return_flag,
COUNT(order_id) AS Total_Order
FROM retail_sales_dataset_CLEANED
GROUP BY return_flag
ORDER BY return_flag

	/* Calculate the overall return rate */

SELECT COUNT(order_id) AS Total_Orders,
SUM(CASE WHEN return_flag=1 THEN 1 ELSE 0 END) AS Total_Returns,
ROUND(SUM(CASE WHEN RETURN_FLAG=1 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(order_id),0),2) AS Return_Rate
FROM retail_sales_dataset_CLEANED

	/* Which category has the most returns */

SELECT product_category,
COUNT(order_id) AS Total_Order,
SUM(CASE WHEN return_flag=1 THEN 1 ELSE 0 END) AS Total_Returns,
ROUND(SUM(CASE WHEN return_flag=1 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(order_id),0),2) AS Return_Rate
FROM retail_sales_dataset_CLEANED
GROUP BY product_category
ORDER BY Return_Rate DESC

	/* Returns by product */ 

SELECT product_name,
COUNT(order_id) AS Total_Orders,
SUM(CASE WHEN return_flag = 1 THEN 1 ELSE 0 END) AS Total_Returns,
ROUND(SUM(CASE WHEN return_flag = 1 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(order_id),0),2) AS Returns_rate
FROM retail_sales_dataset_CLEANED
GROUP BY product_name
HAVING COUNT(order_id)>=10
ORDER BY Returns_rate DESC




