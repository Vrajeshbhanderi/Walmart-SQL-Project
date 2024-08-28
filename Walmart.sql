select * from walmart w  ;
#1
select  distinct city 
from walmart w ;
#2
select city,count(Branch)Count_Of_Branch_By_Each_Cities
from walmart w 
group by City 
order by Count_Of_Branch_By_Each_Cities;
#1
select distinct product_line 
from walmart w ;

alter table walmart rename column `Product line` to Product_line;
alter table walmart rename column  `Customer type` to Customer_type;

#2

select Payment,count(*) payment_count
from walmart w 
group by Payment 
order by payment_count desc limit 1;
#3
select * from walmart w ;

select Product_line,count(*) most_sold
from walmart w 
group by Product_line
order by most_sold desc limit 1;
#4
select monthname(`Date`) as month,sum(total)
from walmart w 
group by month  ;
#5
select monthname(`Date`)as month,sum(cogs) 
from walmart w 
group by month 
order by sum(cogs) desc limit 1 ;
#6
select Product_line ,sum(Total)
from walmart w 
group by Product_line 
order by sum(Total) desc limit 1;
#7
select City ,sum(Total)
from walmart w 
group by City 
order by sum(Total) desc limit 1; 
#8
select Product_line,sum(`Tax 5%`)as VAT
from walmart w
group by Product_line 
order by VAT desc limit 1;
#9
alter table walmart add column Review varchar(50);
UPDATE walmart w
JOIN (
    SELECT AVG(total) AS avg_total
    FROM walmart
) avg_walmart
SET w.review = CASE
    WHEN w.total > avg_walmart.avg_total THEN 'Good'
    ELSE 'Bad'
END;
select * from walmart w ;
select avg(total)
from walmart w ;

alter table walmart add column remark varchar(50);

SET @avg_total = (SELECT AVG(total) FROM walmart);
UPDATE walmart
SET remark= CASE
    WHEN total > @avg_total THEN 'Good'
    ELSE 'Bad'
END;
#10
select * from walmart w ;
select branch,sum(Quantity) total_quantity
from walmart w 
group by Branch 
having total_quantity>(select avg(Quantity) from walmart w2);

SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM walmart w 
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM walmart w2);
#11
select gender,Product_line ,count(product_line) common_product
from walmart w 
group by gender,Product_line 
order by common_product desc ;
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM walmart w 
GROUP BY gender, product_line
ORDER BY Gender ,total_cnt desc ;
#12
select product_line,round(avg(rating),2) as avg_rating
from walmart w 
group by Product_line ;

-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------
#1
select dayname(date) as weekdays,sum(total)
from walmart w 
where dayname(date)  not in ("Sunday","Saturday")
group by weekdays
order by sum(total);
#2
select * from walmart w ;
select customer_type,round(sum(Total),2) Total_Revenue
from walmart w 
group by Customer_type 
order by Total_Revenue desc ;
#3
alter table walmart add column VAT int(100);  

update walmart 
set VAT = 0.05 * COGS ;

select * from walmart w ;
select city,sum(VAT) as Total_VAT
from walmart w 
group by City 
order by total_VAT desc limit 1;
#4
select Customer_type ,sum(VAT) as Total_VAT
from walmart w 
group by Customer_type 
order by Total_VAT desc  limit 1;

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

#1
select distinct customer_type
from walmart w ;
#2
select distinct payment
from walmart w ;
#3
select customer_type,count(*) Most_common
from walmart w 
group by Customer_type 
order by Most_common desc limit 1 ;
#4
select * from walmart w ;
select customer_type,count(`Invoice ID`) as count_id
from walmart w 
group by Customer_type 
order by count_id desc limit 1;
#5
select gender,count(Gender)as gender_count
from walmart w 
group by Gender 
order by gender_count;

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmart w 
GROUP BY gender
ORDER BY gender_cnt DESC;
#6
select branch,gender,count(Gender) gender_count
from walmart w 
group by branch,Gender 
order by Branch,gender_count ;
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmart w 
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;
#7
ALTER TABLE walmart add column time_of_day varchar(50);
select distinct time from walmart w ;
update walmart 
set  time_of_day=(
		case when `Time`between '00:00:00' and "12:00:00" then 'Morning'
		when `Time`between '12:00:01' and "16:00:00" then 'Afternoon'
		else 'Evening' end);
select time_of_day from walmart w ;
select time_of_day,count(Rating),round(avg(Rating),2) avg_rating
from walmart w 
group by time_of_day;
#8
select branch,time_of_day,count(rating),round(avg(Rating),2) avg_rating
from walmart w 
group by Branch ,time_of_day
order by branch;
#9
select weekday(date) weekdays,round(avg(rating),2) avg_rating
from walmart w 
group by weekdays
order by avg_rating desc limit 1;
select dayname(date) weekdays,round(avg(rating),2) avg_rating
from walmart w 
group by weekdays
order by avg_rating desc limit 1;
#10
select dayname(date) weekdays,branch,round(avg(rating),2)  avg_rating
from walmart w 
group by weekdays,Branch
order by avg_rating;




