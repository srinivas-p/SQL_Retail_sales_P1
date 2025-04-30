-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from 
[dbo].[retail_sales_1]
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from 
[dbo].[retail_sales_1]
where category ='Clothing' and FORMAT(sale_date,'MM') = '02' and quantiy >=4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select  category,sum(total_sale) as totalsales
from [dbo].[retail_sales_1]
group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age)
from [dbo].[retail_sales_1]
where  category='Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from [dbo].[retail_sales_1]
where total_sale >=1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(*),category,gender
from [dbo].[retail_sales_1]
group by category,gender;



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select  
year(sale_date) as new_year,
month(sale_date) as new_month, 
avg(total_sale)as avg_sales
from [dbo].[retail_sales_1]
group by year(sale_date),month(sale_date)
order by 1, 3 desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select  customer_id, sum(total_sale) as total_sales
from [dbo].[retail_sales_1]
group by customer_id
order by total_sales desc;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct(customer_id))
from [dbo].[retail_sales_1]
group by category
;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


select shift,count(*)
from (
		select *,
				case
					when  format(sale_time,'hh') <12 then 'Morning'
					when format(sale_time,'hh') between 12 and 17  then  'Afternoon'
					when format(sale_time,'hh') >17 then  'Evening'
				end as shift
				from [dbo].[retail_sales_1]) as t1
group by shift;


with hourly_sale 
as 
(
select *,
		case
					when  format(sale_time,'hh') <12 then 'Morning'
					when format(sale_time,'hh') between 12 and 17  then  'Afternoon'
					when format(sale_time,'hh') >17 then  'Evening'
				end as shift
from [dbo].[retail_sales_1]
)

select shift,count(*) as total_order from hourly_sale
group by shift;

--END of Project