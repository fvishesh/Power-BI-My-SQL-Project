select * from coffee_shop_sales1;
describe coffee_shop_sales1;
Select sum(unit_price * transaction_qty)as Total_Sales from coffee_shop_sales1 where month(transaction_date)=5;   

-- Selected month/CM= may=5
-- PM = April=4
Select 
		MONTH(Transaction_date) as month, -- NUMBER OF MONTH 
        Round(sum(unit_price * transaction_qty))AS Total_sales, -- TOTAL SALES COLUMN
        sum(unit_price * transaction_qty) - lag(sum(unit_price * transaction_qty),1) -- MONTHLY SALES DIFFERENCE
        over (order by month(transaction_date))/ LAG(sum(unit_price * transaction_qty),1) 
        over (order by month(transaction_date)) * 100 as mom_increase_percentage -- percentage
	from coffee_shop_sales1 where month(transaction_date) IN (4,5) -- FOR MONTHS APRIL AND MAY  
    GROUP BY Month(transaction_date)
    order by Month (transaction_date); 
    
    Select count(transaction_id) AS Total_Orders 
    from coffee_shop_sales1 
    where 
    month(transaction_date)=3;
    
    Select month(transaction_date) as Month,
    round(count(transaction_id))AS Total_orders,
    (count(transaction_id) - LAG(count(transaction_id),1)
    over (order by month(transaction_date))/ LAG(count(transaction_id),1)
	over (order by month(transaction_date)) * 100 as mom_increase_percentage 
	from coffee_shop_sales1 where month(transaction_date) IN (4,5) -- FOR MONTHS APRIL AND MAY  
    GROUP BY Month(transaction_date)
    order by Month (transaction_date); 
    
    Select sum(transaction_qty)as Total_Quantity_sold
     from coffee_shop_sales1 
    where 
    month(transaction_date)=6;
		
        
Select 
	Month(Transaction_date) AS MONTH,
    Round(sum(transaction_qty))AS TOTAL_QTY_SOLD,
    (SUM(transaction_qty)- LAG(SUM(transaction_qty),1)
    over(order by month(transaction_date))/lag(sum(transaction_qty),1)
    over (order by month(transaction_date)) * 100 as mom_increase_percentage -- percentage
from 
	coffee_shop_sales1
where
	month(transaction_date)IN (4,5) -- FOR APRIL AND MAY 
GROUP BY
	month(transaction_date)
order by 
	month(transaction_date);	
    
    
