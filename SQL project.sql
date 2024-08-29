create database mini_project;
/*
SQL II - Mini Project
_________________________________________________________
Composite data of a business organisation, confined to ‘sales and delivery’ domain is given for the period of last decade. From the given data retrieve solutions for the given scenario.
1. Join all the tables and create a new table called combined_table.
(market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)
2. Find the top 3 customers who have the maximum number of orders
3. Create a new column DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
4. Find the customer whose order took the maximum time to get delivered.
5. Retrieve total sales made by each product from the data (use Windows function)
6. Retrieve total profit made from each product from the data (use windows function)
7. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
8. Retrieve month-by-month customer retention rate since the start of the business.(using views)
Tips:
#1: Create a view where each user’s visits are logged by month, allowing for the possibility that these will have occurred over multiple # years since whenever business started operations
# 2: Identify the time lapse between each visit. So, for each person and for each month, we see when the next visit is.
# 3: Calculate the time gaps between visits
# 4: categorise the customer with time gap 1 as retained, >1 as irregular and NULL as churned
# 5: calculate the retention month wise
*/

/*
1. Join all the tables and create a new table called combined_table.
(market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)
*/
/*
create table combined_table as
select * from 
market_fact mf natural join orders_dimen od on mf.Ord_id = od.Ord_id 
natural join cust_dimen cd on mf.Cust_id=cd.Cust_id
natural join shipping_dimen sd on mf.Ship_id=sd.Ship_id
natural join  prod_dimen pd on mf.Prod_id=pd.Prod_id;
*/
use mini_project;
create table combined_table as
select * from 
market_fact mf natural join orders_dimen 
natural join cust_dimen cd 
natural join shipping_dimen sd 
natural join  prod_dimen pd ;

select * from combined_table;

#2. Find the top 3 customers who have the maximum number of orders
select * from combined_table;
select Customer_Name,sum(Order_Quantity)total_orders from combined_table
group by Customer_Name
order by total_orders desc
limit 3;

#3. Create a new column DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
alter table combined_table add DaysTakenForDelivery varchar(50) as
(datediff(str_to_date(order_date,'%d-%m-%y'),str_to_date(ship_date,'%d-%m-%y')));
select daystakenfordelivery from combined_table;

#4. Find the customer whose order took the maximum time to get delivered.
select * from
(select Customer_Name,DaysTakenForDelivery,dense_rank() over(order by DaysTakenForDelivery desc)rank_ from combined_table)t 
where rank_=1;

#5. Retrieve total sales made by each product from the data (use Windows function)
select distinct Prod_id,Product_Category,Product_Sub_Category,sum(Sales) over (partition by Prod_id)totalsales from combined_table;

#6. Retrieve total profit made from each product from the data (use windows function)
select * from combined_table;
select distinct Prod_id,Product_Category,Product_Sub_Category,sum(Profit) over (partition by Prod_id)totalPROFIT from combined_table;

#7. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011

select
(select count(distinct Cust_id)
from combined_table 
where (
year(str_to_date(Order_Date,'%d-%m-%Y'))=2011 and month(str_to_date(Order_Date,'%d-%m-%Y'))=1))count_of_jan_customers
,
(SELECT COUNT(distinct Cust_id) AS count_of_customers
FROM (
    SELECT Cust_id, COUNT(DISTINCT MONTH(STR_TO_DATE(Order_Date, '%d-%m-%Y'))) AS month_count
    FROM combined_table
    where year(str_to_date(Order_Date,'%d-%m-%Y'))=2011
    GROUP BY Cust_id
    HAVING month_count = 12
    )AS customers_in_all_months_of_2011 
    where 
    Cust_id in (select distinct Cust_id
from combined_table where (year(str_to_date(Order_Date,'%d-%m-%Y'))=2011 and month(str_to_date(Order_Date,'%d-%m-%Y'))=1)))jan_repeating_customers_in_year;

##8.	Retrieve month-by-month customer retention rate since the start of the business.(using views)
/*1). Create a view where each user’s visits are logged by month, allowing for the possibility that these will have occurred
over multiple # years since whenever business started operations
*/

create view customer_visit as
select cust_id,str_to_date(order_date,"%d-%m-%Y") cust_visit 
from combined_table;

select * from customer_visit;

-- 2. Identify the time lapse between each visit. So, for each person and for each month, we see when the next visit is.

create view customer_monthly_visit_timelamp as
select cust_id,cust_visit, lag(cust_visit) over(partition by cust_id 
order by cust_visit) previous_visit_month
from customer_visit cm ;

select * from customer_monthly_visit_timelamp;


select * from customer_visit_timelamp;	

-- 3) Calculate the time gaps between visits

create view customer_time_gaps as
select cust_id, cust_visit, previous_visit_month,round(datediff(cust_visit,previous_visit_month)/30) month_diff from customer_monthly_visit_timelamp;


select* from customer_time_gaps;

-- 4). categorise the customer with time gap 1 as retained, >1 as irregular and NULL as churned

create view customer_categorise as 
select cust_id, cust_visit, 
case when month_diff = 1 then "retained"
     when month_diff  >1 then "irregular"
     else "churned"
end retention_status
from customer_time_gaps  ;

select * from customer_visit;
select * from customer_visit_timelamp;
select * from customer_time_gaps;
select * from customer_categorise;

-- 5: calculate the retention month wise

select year(cust_visit),month(cust_visit), count(cust_id) total_customer, 
sum(case when retention_status = "retained" then 1 else 0 end) as retained_customer
from customer_categorise group by year(cust_visit), month(cust_visit) order by year(cust_visit);



