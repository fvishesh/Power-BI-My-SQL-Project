Select * from coffee_shop_sales1;
Select concat(round( sum(unit_price * transaction_qty)/1000,1),'K') as Total_sales,
concat(round(sum(transaction_qty)/1000,1),'K') as total_qty_sold,
concat(round(count(transaction_id)/1000,1), 'K') as Total_orders
from coffee_shop_sales1
where transaction_date='2023-03-27';

-- Weekends - SAT AND SUN
-- Weekdays- MON TO FRI 

-- SUN == 1
-- MON ==2 
-- .
-- .
-- .
-- .
-- .
-- SAT== 7
Select case when dayofweek(transaction_date) IN (1,7) Then 'Weekends'
ELSE 'Weekdays'
END  AS day_type,
concat(round(Sum(unit_price * transaction_qty)/1000,1),'k') as Total_sales
from coffee_shop_sales1
where month(transaction_date) = 5 -- MAY MONTH
Group by 
	case when dayofweek(transaction_date) IN (1,7) Then 'Weekends'
	ELSE 'Weekdays'
    END;


Select 
	store_location,
    concat(round(sum(unit_price * transaction_qty)/1000,1),'k') AS Total_sales
    from coffee_shop_sales1
    where month(transaction_date)=5
    group by store_location
    order by sum(unit_price * transaction_qty) DESC;
    
    
   Select concat(round(AVG (Total_sales)/1000,1),'K') AS Avg_sales 
   from (select sum(transaction_qty * unit_price) as Total_sales 
		from coffee_shop_sales1 where month(transaction_date)=5
        group by transaction_date
        )AS Inner_query;
        
        
        
Select 
	day(transaction_date) AS day_of_month,
    sum(unit_price * transaction_qty) AS Total_sales
from coffee_shop_sales1
where month(transaction_date)=5
group by day(transaction_date)
order by day(transaction_date) ;



SELECT 
    day_of_month,
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'Average'
    END AS sales_status,
    total_sales
FROM (
    SELECT 
        DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        DAY(transaction_date)
) AS sales_data
ORDER BY 
    day_of_month;



Select product_category,
		concat(round(sum(unit_price * transaction_qty)/1000,1),'k') as total_sales
from coffee_shop_sales1
where month(transaction_date)=5
group by product_category
order by sum(unit_price * transaction_qty) desc;


Select 
		concat(round(sum(unit_price * transaction_qty)/1000,1),'K') as total_sales,
        sum(transaction_qty) as total_qty_sold,
        count(transaction_id) as total_orders 
from coffee_shop_sales1
where month(transaction_date)=5 -- MAY 
AND DAYOFWEEK(transaction_date)=1 -- MONDAY
AND Hour(transaction_time)=14;  -- for hour no 8


Select 
	hour(transaction_time),
    sum(unit_price * transaction_qty)  as Total_sales
from coffee_shop_sales1
where month(transaction_date)=5
group by hour(transaction_time)
order by hour(transaction_time);


SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales1
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END;
