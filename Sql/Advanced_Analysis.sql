/* Which product have high profit */

SELECT product_name,
ROUND(SUM(sales_amount),2) AS Total_sales,
ROUND(SUM(profit),2) AS Total_profit
FROM retail_sales_dataset_CLEANED
GROUP BY product_name
ORDER BY Total_profit DESC

/* Who are the Top 10 Customers by Revenue? */

SELECT TOP 10 customer_id,customer_name,
ROUND(SUM(sales_amount),2) AS Total_Amount
FROM retail_sales_dataset_CLEANED
GROUP BY customer_id,customer_name
ORDER BY Total_Amount DESC

/* Are the highest-revenue customers also the most profitable? */ 

SELECT TOP 10
customer_id,customer_name,
ROUND(SUM(sales_amount),2) AS Total_sales,
ROUND(SUM(profit),2) AS Total_profit
FROM retail_sales_dataset_CLEANED
GROUP BY customer_id,customer_name
ORDER BY Total_sales DESC

/* Which products have high sales but low profit? */

WITH Product_Performance AS
(
SELECT product_name,
SUM(sales_amount) AS Total_Sales,
SUM(profit) AS Total_Profit,
SUM(profit) * 100.0 / NULLIF(SUM(sales_amount), 0) AS Profit_Margin
FROM retail_sales_dataset_CLEANED
GROUP BY product_name
)

SELECT product_name,
ROUND(Total_Sales, 2) AS Total_Sales,
ROUND(Total_Profit, 2) AS Total_Profit,
ROUND(Profit_Margin, 2) AS Profit_Margin
FROM Product_Performance
WHERE Total_Sales >= 6292138.19 AND Profit_Margin < 27.07
ORDER BY Total_Sales DESC;


/* Are discounts contributing to the low profit margins? */

SELECT product_name,
ROUND(SUM(sales_amount),2) AS Total_sales,
ROUND(SUM(profit),2) AS Total_Profit,
ROUND(SUM(profit) * 100.0 / NULLIF(SUM(sales_amount),0),2) AS Profit_Margin,
ROUND(AVG(discount_final),2) AS Avg_discount
FROM retail_sales_dataset_CLEANED
GROUP BY product_name
ORDER BY Profit_Margin ASC

/* Categories with high sales but poor profit margins */

WITH Category_Performance AS 
(
SELECT product_category,
ROUND(SUM(sales_amount),2) AS Total_Sales,
ROUND(SUM(profit),2) AS Total_Profit,
ROUND(SUM(profit) * 100.0 / NULLIF(SUM(sales_amount),0),2) AS Profit_Margin
FROM retail_sales_dataset_CLEANED
GROUP BY product_category
),

Category_Averages AS
(
SELECT 
ROUND(AVG(Total_Sales),2) AS Avg_Total_Sales,
ROUND(AVG(Profit_Margin),2) AS Avg_Profit_Margin
FROM Category_Performance
)

SELECT C.product_category,C.Total_Sales,C.Total_Profit,C.Profit_Margin,A.Avg_Total_Sales,A.Avg_Profit_Margin
FROM Category_Performance C 
CROSS JOIN Category_Averages A
WHERE C.Total_Sales > A.Avg_Total_Sales AND Profit_Margin < A.Avg_Profit_Margin
ORDER BY Total_Sales DESC


/* How are sales changing from one month to the next? */

WITH Monthly_Sales AS
(
SELECT
YEAR(order_date) AS Sales_Year,
MONTH(order_date) AS Sales_Month,
ROUND(SUM(sales_amount),2) AS Total_Sales
FROM retail_sales_dataset_CLEANED
GROUP BY YEAR(order_date),MONTH(order_date)
),

Monthly_Growth AS
(
SELECT Sales_Year,Sales_Month,Total_Sales,
ROUND(LAG(Total_Sales) OVER (
ORDER BY Sales_Year,Sales_Month),2) AS Previous_Monthly_Sales
FROM Monthly_Sales
)

SELECT Sales_Year,Sales_Month,Total_Sales,
ROUND((Previous_Monthly_Sales),2),
ROUND((Total_Sales - Previous_Monthly_Sales) / NULLIF(Previous_Monthly_Sales,0)*100,2) AS Growth_Perc
FROM Monthly_Growth
ORDER BY Sales_Year,Sales_Month

/* Which months generated the highest and lowest sales? */ 

SELECT TOP 1
YEAR(order_date) AS Sales_Year,
MONTH(order_date) AS Sales_Month,
ROUND(SUM(sales_amount),2) AS Total_Sales
FROM retail_sales_dataset_CLEANED
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY Total_Sales DESC

SELECT TOP 1
YEAR(order_date) AS Sales_Year,
MONTH(order_date) AS Sales_Month,
ROUND(SUM(sales_amount),2) AS Total_Sales
FROM retail_sales_dataset_CLEANED
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY Total_Sales

WITH Monthly_Sales AS
(
SELECT
YEAR(order_date) AS Sales_Year,
MONTH(order_date) AS Sales_Month,
ROUND(SUM(sales_amount),2) AS Total_Sales
FROM retail_sales_dataset_CLEANED
GROUP BY YEAR(order_date),MONTH(order_date)
)

SELECT 
'Best_Month' AS Month_Type,
Sales_Year,Sales_Month,Total_Sales
FROM Monthly_Sales
WHERE Total_Sales = (SELECT MAX(Total_Sales) FROM Monthly_Sales)

UNION ALL

SELECT 
'Worst_Month' AS Month_Type,
Sales_Year,Sales_Month,Total_Sales
FROM Monthly_Sales
WHERE Total_Sales = (SELECT MIN(Total_Sales) FROM Monthly_Sales)

/* How do customers rank based on their total revenue */ 

SELECT TOP 10
customer_id,customer_name,
ROUND(SUM(sales_amount),2) AS Total_Sales
FROM retail_sales_dataset_CLEANED
GROUP BY customer_id,customer_name
ORDER BY Total_Sales DESC

WITH Customer_Sales AS
(
SELECT
customer_id,customer_name,
ROUND(SUM(sales_amount),2) AS Total_Sales
FROM retail_sales_dataset_CLEANED
GROUP BY customer_id,customer_name
)

SELECT 
customer_id,customer_name,Total_Sales,
RANK() OVER (ORDER BY Total_Sales DESC) AS Customer_Rank
FROM Customer_Sales
ORDER BY Customer_Rank

/* How much total sales have accumulated over time? */

WITH Monthly_Sales AS
(
SELECT 
YEAR(order_date) AS Sales_Year,
MONTH(order_date) AS Sales_Month,
ROUND(SUM(sales_amount),2) AS Total_Sales
FROM retail_sales_dataset_CLEANED
GROUP BY YEAR(order_date),MONTH(order_date)
)

SELECT Sales_Year, Sales_Month, Total_Sales,
ROUND(SUM(Total_Sales) OVER (ORDER BY Sales_Year, Sales_Month
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),2) AS Cumulative_Sales
FROM Monthly_Sales
ORDER BY Sales_Year,Sales_Month		

/* What percentage of the company's total sales comes from each product category? */

WITH Category_Sales AS
(
SELECT 
product_category,
ROUND(SUM(sales_amount),2) AS Total_Sales
FROM retail_sales_dataset_CLEANED
GROUP BY product_category
)

SELECT 
product_category,
Total_Sales,
ROUND(Total_Sales * 100.0 / SUM(Total_Sales) OVER(),2) AS Sales_Contribution_Percentage
FROM Category_Sales
ORDER BY Total_Sales DESC

/* Who are our high-value customers? */

WITH Customer_Sales AS
(
SELECT
customer_id,
ROUND(SUM(sales_amount),2) AS Total_Sales
FROM retail_sales_dataset_CLEANED
GROUP BY customer_id
),

Average_Tootal_Sales AS
(
SELECT
customer_id,Total_Sales,
ROUND(AVG(Total_Sales) OVER(),2) AS Average_Total_Sales
FROM Customer_Sales
)

SELECT
customer_id,Total_Sales
FROM Average_Tootal_Sales
WHERE Total_Sales > Average_Total_Sales
ORDER BY Total_Sales DESC

/* Which products have an unusually high percentage of returned orders? */

WITH Product_Return AS
(
SELECT
product_name,
SUM(CASE WHEN return_flag = 1 THEN 1 ELSE 0 END) AS Return_Order,
COUNT(order_id) AS Total_Order
FROM retail_sales_dataset_CLEANED
GROUP BY product_name
),

Product_Return_Rate AS
(
SELECT
product_name,Return_Order,Total_Order,
ROUND((Return_Order *100.0) / NULLIF(Total_Order,0),2) AS Return_Percentage
FROM Product_Return
),


Average_Return AS
(	
SELECT 
AVG(Return_Percentage) AS Average_Return_Rate
FROM Product_Return_Rate
)

SELECT 
P.product_name,P.Return_Order,P.Total_Order,P.Return_Percentage,
ROUND(A.Average_Return_Rate,2) AS Average_Return_Rate
FROM Product_Return_Rate P
CROSS JOIN Average_Return A
WHERE Return_Percentage > Average_Return_Rate
ORDER BY Return_Percentage DESC

/* Does higher shipping cost affect profit? */ 

WITH Product_Shipping AS
(
SELECT product_name,
ROUND(SUM(shipping_cost), 2) AS Total_Shipping_Cost,
ROUND(SUM(profit), 2) AS Total_Profit
FROM retail_sales_dataset_CLEANED
GROUP BY product_name
)

SELECT
product_name,
Total_Shipping_Cost,
Total_Profit,
ROUND(Total_Shipping_Cost * 100.0 / NULLIF(Total_Profit, 0),2) AS Shipping_Cost_Percentage,
ROUND(Total_Profit - Total_Shipping_Cost, 2) AS  Profit_After_Shipping
FROM Product_Shipping
ORDER BY Shipping_Cost_Percentage DESC
