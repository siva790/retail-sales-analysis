# Retail Sales Analysis

An end-to-end retail sales analysis project using **SQL, Power BI, DAX, Excel, and Power Query** to analyze sales performance, profitability, customer behavior, product performance, discounts, shipping costs, and returns.


##  Project Overview

Retail businesses generate large amounts of transactional data. However, raw transaction data alone does not provide meaningful business insights.

The objective of this project was to transform retail transaction data into actionable insights by using SQL for data analysis and Power BI for interactive reporting and visualization.

The analysis focuses on understanding:

- Sales and profitability performance
- Product performance
- Customer value and behavior
- Discount and profitability relationships
- Shipping cost impact
- Customer satisfaction
- Product returns


##  Business Objectives

The project aims to help answer important business questions such as:

1. How are overall sales and profitability performing?
2. Which products generate the highest sales?
3. Which products generate high sales but relatively low profit?
4. Which customers generate the most revenue?
5. What is the relationship between discounts and profitability?
6. How significant are shipping costs compared with sales?
7. Are less-satisfied customers more likely to return their orders?
8. Which areas of the business require improvement?


##  Tools & Technologies

| Tool | Purpose |
|---|---|
| **SQL Server** | Data analysis, aggregation, filtering, CTEs, window functions, and business analysis |
| **Power BI** | Interactive dashboards and data visualization |
| **DAX** | Business measures and calculated metrics |
| **Excel** | Data inspection and supporting analysis |
| **Power Query** | Data cleaning and transformation |


##  Key Metrics

| Metric | Result |
| **Total Sales** | 264,269,805 |
| **Total Profit** | 49,519,155 |
| **Profit Margin** | 18.74% |
| **Total Orders** | 4,200 |
| **Return Rate** | 14.57% |
| **Average Customer Satisfaction** | 3.02 |


##  Key Business Findings

### 1. Product Performance

The analysis identified significant differences in sales, profit, and profit margin across products.

For example, **Tablet** generated the highest sales among the products shown in the product-performance analysis, while **Tennis Racket** generated a substantially higher profit margin despite having lower sales.

This demonstrates that **high sales volume does not necessarily mean the highest profitability**.


### 2. High-Sales / Low-Profit Products

Products were compared against the average product sales and average product profit to identify products with:

> **Above-average sales + below-average profit**

This helps identify products that generate significant revenue but may require investigation because their profitability is relatively weak.

Potential areas to investigate include:

- Discount levels
- Product costs
- Shipping costs
- Pricing
- Operating expenses


### 3. High-Value Customers

Customers were analyzed based on their total sales contribution.

Customers generating sales above the overall customer average were identified as **high-value customers**.

The analysis showed that a relatively small group of customers contributes significant revenue, making customer retention and relationship management important business priorities.


### 4. Customer Satisfaction & Returns

A strong relationship was observed between customer satisfaction and return rate.

| Satisfaction Score | Return Rate |
| 1 | **24.31%** |
| 2 | **17.04%** |
| 3 | **13.35%** |
| 4 | **12.35%** |
| 5 | **6.61%** |

Customers with a satisfaction score of **1 had a 24.31% return rate**, while customers with a satisfaction score of **5 had a 6.61% return rate**.

This represents a **17.70 percentage-point difference**.

The result suggests that lower customer satisfaction is associated with a higher likelihood of product returns.


## Power BI Dashboard

The Power BI report was developed to provide an interactive view of the business performance.

### Dashboard Pages

- **Executive / Overview Analysis**
- **Product Analysis**
- **Customer & Order Analysis**
- **Operations & Shipping Analysis**

The dashboard includes KPI cards, product and customer analysis, profitability analysis, return analysis, and operational metrics.

### Dashboard Files

- [Power BI Dashboard PDF](PowerBI/Retail_Sales_Analysis.pdf)
- [Power BI PBIX File](PowerBI/retail_sales.pbix)

> The PDF provides a quick view of the dashboard, while the PBIX file contains the Power BI report itself.


## SQL Analysis

SQL Server was used to perform the main analytical work.

The analysis includes:

- Aggregations using `SUM`, `AVG`, and `COUNT`
- `GROUP BY` analysis
- Filtering using `WHERE`
- Conditional calculations using `CASE`
- Common Table Expressions (CTEs)
- Window functions
- Customer-level analysis
- Product-level analysis
- Profitability analysis
- Return-rate analysis

### SQL Files

- [Retail Analysis SQL](SQL/retail_analysis.sql)
- [Advanced Analysis SQL](SQL/Advanced_Analysis.sql)


##  Key Calculated Metrics

### Total Sales

```sql
SUM(sales_amount)
```

### Total Profit

```sql
SUM(profit)
```

### Profit Margin

```text
Total Profit / Total Sales × 100
```

### Return Rate

```text
Returned Orders / Total Orders × 100
```

---

## Business Recommendations

Based on the analysis, the business should consider:

### Improve Low-Satisfaction Customer Experience

Investigate the reasons behind low satisfaction and identify whether returns are related to:

- Product quality
- Product expectations
- Delivery experience
- Customer service

### Monitor High-Sales / Low-Profit Products

Products generating strong sales but relatively low profit should be reviewed for:

- Excessive discounts
- Pricing issues
- High product costs
- Shipping costs

### Focus on High-Value Customers

High-value customers should be prioritized for customer retention strategies because they contribute significant revenue.

### Monitor Shipping Costs

Products or transactions with high shipping costs relative to sales should be investigated to identify opportunities to improve operational efficiency.

## 📁 Project Structure

```text
retail-sales-analysis/
│
├── SQL/
│   ├── retail_analysis.sql
│   └── Advanced_Analysis.sql
│
├── PowerBI/
│   ├── retail_sales.pbix
│   └── Retail_Sales_Analysis.pdf
│
├── Report/
│   └── Retail Sales Data Analysis – Final Report.docx
│
└── README.md
```

## Project Report

The detailed project report contains:

- Project background
- Project objectives
- Dataset overview
- Data preparation
- Business questions
- SQL analysis
- Business findings
- Power BI dashboard analysis
- Business recommendations
- Conclusion

[View the Detailed Project Report](Report/Retail%20Sales%20Data%20Analysis%20%E2%80%93%20Final%20Report.docx)


##  Skills Demonstrated

This project demonstrates practical experience in:

- SQL
- Data Cleaning
- Data Transformation
- Data Aggregation
- Business Analysis
- Exploratory Data Analysis
- KPI Development
- DAX
- Power BI
- Data Visualization
- Customer Analysis
- Product Analysis
- Profitability Analysis
- Operational Analysis
- Business Insight Generation



##  Author

**Siva Kathir**

This project was created as a portfolio project to demonstrate practical **Data Analyst skills using SQL and Power BI**.
