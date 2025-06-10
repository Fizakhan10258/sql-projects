create database Blinkitdb;
use Blinkitdb;
select * from blinkit; 
select count(*) from blinkit; 

set sql_safe_updates=0;
update blinkit set  `Item Fat Content` = case 
when `Item Fat Content` in ('LF','low fat') then 'Low Fat'
when `Item Fat Content` = 'reg' then 'Regular'
else `Item Fat Content`
end;

select cast(sum(Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions from blinkit;
select cast(avg(Sales) as decimal(10,0)) as avg_sales from blinkit;
-- select count(`Item Identifier`) as no_of_items from blinkit;
select count(*) as no_of_items from blinkit;
select cast(avg(Rating) as decimal(10,2)) as avg_rating from blinkit;

select `Item Fat Content`,
     cast(sum(Sales)/1000 as decimal(10,2)) as total_sales_thousands,
     cast(avg(Sales) as decimal(10,0)) as avg_sales,
     count(*) as no_of_items,
     cast(avg(Rating) as decimal(10,2)) as avg_rating
     from blinkit group by `Item Fat Content`
order by total_sales_thousands desc;

select `Item Type`,
     cast(sum(Sales)/1000 as decimal(10,2)) as total_sales,
     cast(avg(Sales) as decimal(10,0)) as avg_sales,
     count(*) as no_of_items,
     cast(avg(Rating) as decimal(10,2)) as avg_rating
     from blinkit group by `Item Type`
order by total_sales desc
-- for top 5 use limit 
limit 5;

-- select `Outlet Location Type`,`Item Fat Content`,
 --    cast(sum(Sales) as decimal(10,2)) as total_sales,
 --    cast(avg(Sales) as decimal(10,0)) as total_avg,
 --    count(*) as no_of_items,
  --   cast(avg(Rating) as decimal(10,2)) as avg_rating
-- from blinkit group by `Outlet Location Type`,`Item Fat Content`
-- order by total_sales asc;     

-- pivoting 
SELECT 
    `Outlet Location Type`,
    ROUND(SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN Sales ELSE 0 END), 2) AS Low_Fat_sum,
    ROUND(SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN Sales ELSE 0 END), 2) AS Regular_sum,
	ROUND(avg(CASE WHEN `Item Fat Content` = 'Low Fat' THEN Sales ELSE 0 END), 2) AS Low_Fat_avg,
    ROUND(avg(CASE WHEN `Item Fat Content` = 'Regular' THEN Sales ELSE 0 END), 2) AS Regular_avg
FROM blinkit
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type`;

select `Outlet Establishment Year`,
       cast(sum(Sales) as decimal(10,2)) as total_sales,
       cast(avg(Sales) as decimal(10,0)) as avg_sales,
       count(*) as no_of_items,
       cast(avg(Rating) as decimal(10,2)) as avg_rating
from blinkit group by `Outlet Establishment Year`
order by total_sales desc;
 
 -- % of sales by outlet size
SELECT 
    `Outlet Size`,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS total_sales,
    CAST(SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER () AS DECIMAL(10,2)) AS Sales_percentage
FROM blinkit 
GROUP BY `Outlet Size`
ORDER BY total_sales DESC;

-- sales by outlet location
select `Outlet Location Type`,
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS total_sales
FROM blinkit 
GROUP BY `Outlet Location Type`
ORDER BY total_sales DESC;
    
-- All matrices by outlet type
select `Outlet Type`,
       cast(sum(Sales) as decimal(10,2)) as total_sales,
       cast(avg(Sales) as decimal(10,0)) as avg_sales,
       count(*) as no_of_items,
       cast(avg(Rating) as decimal(10,2)) as avg_rating
from blinkit group by `Outlet Type`
order by total_sales desc;
  
 
