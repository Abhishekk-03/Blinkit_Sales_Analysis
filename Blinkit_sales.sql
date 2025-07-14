Create database Blinkit

use blinkit
select * from blinkit_data

--Data cleansing
update Blinkit_data
set item_fat_content = 
Case
when item_fat_content in ('LF','Low','Fat') then 'Low fat'
when item_fat_content = 'reg' then 'Regular'
else item_fat_content
end

--KPIs

--Total Sales
select cast(sum(total_sales)/ 1000000 as decimal(10,2)) --values in lakh
as [Total_Sales]
from Blinkit_data

--Average Sales
select cast(AVG(total_sales) as decimal(10,2))
as [avg_sales]
from BlinkIT_Data

--No. of Item
select distinct(count(Item_Fat_Content))
as [No.of item]
from BlinkIT_Data

--Avg Rating
select cast(avg(rating) as decimal(10,2))
as [Avg_Rating]
from BlinkIT_Data


--Analyze Total_Sales, Avg_Sale, No_of_item, Avg_Rating by 
select TOP 5 item_Fat_content,
		cast(sum(total_Sales)/100000 as decimal(10,2)) as [Total_Sale], --values in lakh
		cast(AVG(total_sales) as decimal(10,1)) as [Avg_sales], --Values in Lakh
		count(Item_Fat_Content) as [No.of item],
		cast(avg(rating) as decimal(10,2)) as [Avg_Rating]
from BlinkIT_Data
group by Item_Fat_Content
order by Total_sale desc


--Analyze TOP 5 item type Total_Sales, Avg_Sale, No_of_item, Avg_Rating
select top 5 Item_Type,
		cast(sum(total_Sales)/100000 as decimal(10,2)) as [Total_Sale], --values in lakh
		cast(AVG(total_sales) as decimal(10,1)) as [Avg_sales], --Values in Lakh
		count(Item_Fat_Content) as [No.of item],
		cast(avg(rating) as decimal(10,2)) as [Avg_Rating]
from BlinkIT_Data
group by Item_Type
order by Total_sale desc


--Fat content by outlet location for Total_Sales
select Outlet_Location_Type,
	   cast(Sum(Case when Item_Fat_Content = 'regular' then total_sales else 0 end)
	   /100000 as decimal(10,2)) as [Regular],
	   cast(Sum(Case when Item_Fat_Content = 'Low Fat' then total_sales else 0 end)
	   /100000 as decimal(10,2)) as [Low Fat]
from BlinkIT_Data
group by Outlet_Location_Type


--Total sales by outlet establishment.
select Outlet_Establishment_Year,
		cast(sum(total_Sales)/100000 as decimal(10,0)) as [Total_Sale], --values in lakh
		cast(AVG(total_sales) as decimal(10,1)) as [Avg_sales], --Values in Lakh
		count(Item_Fat_Content) as [No.of item],
		cast(avg(rating) as decimal(10,2)) as [Avg_Rating]
from BlinkIT_Data
group by Outlet_Establishment_Year
order by Total_sale desc


--Percentage of sales by outlet size:
Select outlet_size,
	  cast(sum(total_Sales)/100000 as decimal(10,2)) as [Total_Sale],
	  cast(sum(total_Sales) * 100/ sum(sum(total_sales)) over() as decimal(10,2)) as [sales_%]
from BlinkIT_Data
Group by Outlet_Size
order by Total_sale desc

--Sales by Outlet Loaction
select Outlet_Location_Type,
		cast(sum(total_Sales) as decimal(10,0)) as [Total_Sale], --values in lakh
		cast(sum(total_Sales) * 100/ sum(sum(total_sales)) over() as decimal(10,2)) as [sales_%],
		cast(AVG(total_sales) as decimal(10,1)) as [Avg_sales], --Values in Lakh
		count(Item_Fat_Content) as [No.of item],
		cast(avg(rating) as decimal(10,2)) as [Avg_Rating]
from BlinkIT_Data
group by Outlet_Location_Type
order by Total_sale desc
