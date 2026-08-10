#PROJECT:SUPERSTORE SALES ANALYSIS USING SQL 
#CREATED BY:SANYA WADHWA
#DATABASE:SAMPLESTORE
#TOOL:MYSQL WORKBENCH
#1.DATABASE OVERVIEW
SHOW TABLES;
DESCRIBE superstore;
SELECT COUNT(*)AS TOTAL_RECORDS FROM superstore;
SELECT*FROM superstore LIMIT 10;
#DATA QUALITY CHECK
SELECT DISTINCT Category FROM superstore;
SELECT DISTINCT Region FROM superstore;
SELECT DISTINCT Segment FROM superstore;
#BASIC SQL
SELECT Segment,COUNT(*)FROM superstore GROUP BY Segment HAVING COUNT(*)>1;
SELECT*FROM superstore LIMIT 10;                                         #top 10 orders
SELECT DISTINCT Category FROM superstore;                                #unique categories 
SELECT DISTINCT Region FROM superstore;                                  #unique region
SELECT SUM(Sales) AS Total_Sales FROM superstore;                        #total sales
SELECT SUM(Profit) AS Total_Profit FROM superstore;                      #total profit
SELECT AVG(Sales) AS Average_Sales FROM superstore;                      #average sales
SELECT MAX(Sales) AS Highest_Sales FROM superstore;                      #highest sales
SELECT MIN(Sales) AS Lowest_Sales FROM superstore;                       #lowest sales     
SELECT* FROM superstore WHERE Category="Furniture";                      #furniture products
SELECT*FROM superstore WHERE Region="West";                              #order from west region
SELECT*FROM superstore WHERE Profit>100;                                 #profit>100
#INTERMEDIATE SQL 
SELECT*FROM superstore WHERE Sales BETWEEN 100 AND 500;                  #sales between 100 and 500
SELECT*FROM superstore ORDER BY Sales DESC;                              #highest sales first 
SELECT*FROM superstore ORDER BY Profit ASC;                              #lowest profit first
SELECT Category,SUM(Sales) AS TotalSales FROM superstore GROUP BY Category;  #sales by category
SELECT Region,SUM(Profit) AS TotalProfit FROM superstore GROUP BY Region;    #profit by region
#SALES ANALYSIS
SELECT SUM(Sales)FROM superstore;
SELECT Category,SUM(Sales) AS Total_Sales FROM superstore GROUP BY Category HAVING SUM(Sales)>500000;  #Total sales greater than 500000 by category
#PROFIT ANALYSIS
SELECT SUM(Profit)FROM superstore;
SELECT Category,SUM(Profit) AS Total_Profit FROM superstore GROUP BY Category HAVING SUM(Profit)>0;    #category loss 
#CUSTOMER ANALYSIS
SELECT City,State,Sales FROM superstore WHERE Region IN('East','West');
SELECT *FROM superstore WHERE City LIKE '%o__';
SELECT*FROM superstore WHERE CITY LIKE'%n';
SELECT Category,SUM(Sales) AS Total_Sales FROM superstore GROUP BY Category;     #find total sum in each category
SELECT Category,AVG(Sales) AS Avg_Sales FROM superstore GROUP BY Category;       #find average sales in each category
SELECT Category,SUM(Profit) AS Total_Profit FROM superstore GROUP BY Category;   #find total profit in each category
SELECT Region,COUNT(*) AS Total_Orders FROM superstore GROUP BY Region;           #count total orders in each region
SELECT Category,COUNT(*) AS Total_Orders FROM superstore Group By Category HAVING COUNT(*)>1000;  #categories having more than 100 orders
SELECT Segment FROM superstore;
SELECT Segment,AVG(Sales) AS Avg_Sales FROM superstore GROUP BY Segment HAVING AVG(Sales)>100;
SELECT Segment,Sales,CASE WHEN Sales>=1000 THEN 'HIGH' WHEN Sales>=500 THEN 'Medium' ELSE 'LOW' END AS Sales_Level FROM superstore;  #classify order based on sales
SELECT Segment,Profit,CASE WHEN Profit>0 THEN 'Profit' ELSE 'Loss'END AS Status FROM superstore;
SELECT Discount,CASE WHEN Discount>=0.5 THEN 'HEAVY DISCOUNT' ELSE 'NORMAL DISCOUNT' END AS Discount_Level FROM superstore;
SELECT*FROM superstore WHERE Sales=( SELECT MAX(Sales) FROM superstore);
#CTE FUNCTIONS
WITH HIGHSALES AS ( SELECT*FROM superstore WHERE SALES>1000)SELECT*FROM HIGHSALES; #shw all orders where sale is greater than 1000
WITH HIGHSALES AS (SELECT*FROM superstore WHERE SALES>1000)SELECT AVG(SALES) AS Avg_high_sales FROM HIGHSALES;
WITH TECH AS ( SELECT*FROM superstore WHERE Category='Technology')SELECT SUM(Profit)AS TOTAL_PROFIT FROM TECH;
WITH FURNITURE AS (SELECT*FROM superstore WHERE Category='Furniture') SELECT COUNT(*)AS FURNITURE;
WITH LOSSORDERS AS (SELECT*FROM superstore WHERE Profit<0) SELECT * FROM LOSSORDERS;
WITH RANKEDPROFIT AS(SELECT Segment,Profit,DENSE_RANK()OVER(ORDER BY Profit DESC)AS rnk FROM superstore)SELECT * FROM RANKEDPROFIT WHERE rnk<=5;
WITH HIGHRANKED AS (SELECT Category,Sales,ROW_NUMBER() OVER(PARTITION BY Category ORDER BY Sales DESC)AS rn FROM superstore)SELECT*FROM HIGHRANKED WHERE rn<=3;
#WINDOW FUNCTIONS
SELECT Segment,Sales,ROW_NUMBER() OVER(ORDER BY Sales DESC)AS ROW_NO FROM superstore;
WITH HIGHRANKED AS (SELECT Category,Sales,ROW_NUMBER() OVER(PARTITION BY Category ORDER BY Sales DESC)AS rn FROM superstore)SELECT*FROM HIGHRANKED WHERE rn<=3;
SELECT Quantity,Sales,RANK()OVER(ORDER BY Sales DESC)AS SALES_RANK FROM superstore;
SELECT Region,Sales,RANK()OVER(PARTITION BY Region ORDER BY Sales DESC)AS Region_Rank FROM superstore;
SELECT Segment,Profit,DENSE_RANK() OVER(ORDER BY Profit DESC)AS PROFIT_RANK FROM superstore;
SELECT Segment,Sales,LEAD(Sales) OVER(ORDER BY Segment)AS NEXT_SALE FROM superstore;      #show next sale for each order 
SELECT Segment,Sales,LEAD(Sales) OVER(ORDER BY Segment)-Sales AS DIFFERENCE FROM superstore;  #compare current with next sale
SELECT Segment,Sales,SUM(Sales)OVER(ORDER BY Segment)AS RUNNING_TOTAL FROM superstore;
SELECT Category,Segment,Sales,MAX(Sales)OVER(PARTITION BY Category)AS HIGHEST_SALE FROM superstore;
SELECT Region,Segment,Sales,AVG(Sales)OVER(PARTITION BY Region)AS REGION_AVG_SALES FROM superstore;



