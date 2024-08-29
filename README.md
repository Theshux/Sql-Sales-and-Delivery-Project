
# SQL Sales and Delivery Project

## Table of Contents
1. [Introduction](#introduction)
2. [Tools Used](#tools-used)
3. [Database Description](#database-description)
4. [Entity-Relationship Diagram (ERD)](#entity-relationship-diagram-erd)
5. [Project Objectives](#project-objectives)
6. [SQL Queries and Analysis](#sql-queries-and-analysis)
    - [Data Extraction](#data-extraction)
    - [Data Transformation](#data-transformation)
    - [Data Aggregation](#data-aggregation)
    - [Reporting](#reporting)
7. [Results/Findings](#resultsfindings)
8. [Recommendations](#recommendations)
9. [Limitations](#limitations)
10. [Conclusion](#conclusion)

## Introduction
This SQL project focuses on analyzing sales and delivery data for a business organization over the past decade. The primary goal is to retrieve insights that can help improve customer satisfaction and optimize delivery processes.

## Tools Used
- **SQL**
- **Database Management System**: MySQL

## Database Description
The dataset used for this project comprises several tables related to customer orders, product information, and shipping details within the sales and delivery domain.

### Entity-Relationship Diagram (ERD)
![image](https://github.com/user-attachments/assets/d637a65f-d438-43bf-9fd5-97a9e48568ea)


## Project Objectives
- Join multiple tables to create a comprehensive dataset for analysis.
- Identify key metrics such as top customers, product sales, and delivery times.
- Analyze customer retention and categorize customer behavior based on visit patterns.

## SQL Queries and Analysis
### Data Extraction
- **Q1**: Join all tables and create a new combined table.
    - **Result**: Successfully created `combined_table` by joining `market_fact`, `cust_dimen`, `orders_dimen`, `prod_dimen`, and `shipping_dimen`.

### Data Transformation
- **Q3**: Create a new column `DaysTakenForDelivery` to calculate the date difference between `Order_Date` and `Ship_Date`.
    - **Result**: Successfully added `DaysTakenForDelivery` column.

### Data Aggregation
- **Q5**: Retrieve total sales made by each product.
    - **Result**: Extracted and aggregated total sales data using window functions.

### Reporting
- **Q7**: Count the total number of unique customers in January 2011 and track their return rate every month over the year.
    - **Result**: Analyzed customer retention patterns.

## Results/Findings
- **Top 3 Customers**: The customers with the maximum number of orders were identified.
- **Longest Delivery Time**: The customer whose order took the maximum time to deliver was found.
- **Total Sales by Product**: Aggregated sales data provided insights into which products generated the most revenue.
- **Customer Retention**: Identified customer retention rates and categorized customers as retained, irregular, or churned based on their visit patterns.

## Recommendations
- **Improve Delivery Times**: Focus on optimizing logistics for customers whose orders take the longest to deliver.
- **Enhance Customer Retention**: Implement targeted marketing campaigns to re-engage customers identified as irregular or churned.
- **Product Focus**: Increase stock and promotion for products with the highest sales to maximize revenue.

## Limitations
- **Data Completeness**: The dataset may not capture all customer interactions or sales channels, which could affect the comprehensiveness of the analysis.
- **Time Frame**: The analysis is limited to the data provided from the past decade, which may not account for recent changes in customer behavior or market trends.
- **Generalization**: Insights derived from this specific business organization may not be applicable to other organizations without considering contextual differences.

## Conclusion
This project provided valuable insights into customer behavior, product performance, and delivery efficiency. By addressing the limitations and implementing the recommendations, the business can further enhance its sales and delivery operations.
