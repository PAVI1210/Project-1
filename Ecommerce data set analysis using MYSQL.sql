USE practise; -- New data base 'practise'

select * from shopdata;

-- 1.To check number of rows in table 'shopdata'
select count(*) from shopdata;

-- 2.To count distinct States in the dataset
select count(distinct location) from shopdata;

-- 3.list of distinct payment methods used by customers in summer
select distinct Payment_Method  from shopdata
where season ="summer";

-- 4.Number of customers who have purchased using credit card
SELECT COUNT(customer_id) from shopdata
where payment_method="credit card";

-- 5.Top 3 states with the highest average purchase amount
SELECT location, round(AVG( purchase_Amount),2) AS average_amount FROM shopdata
GROUP BY location
ORDER BY average_amount DESC
LIMIT 3;

-- ......6.List of distinct clothing items purchased by customers with rating greater than 3
SELECT DISTINCT(item_purchased) , review_rating from shopdata
where review_rating > 3;

-- 7.Customer details who made highest purchase amount and the item  they purchased 
SELECT * FROM shopdata
WHERE purchase_amount=(SELECT MAX(purchase_amount) FROM shopdata AS M )
LIMIT 1;

-- 8.Average rating for each category
SELECT category , ROUND(AVG(review_rating),2) AS Average_rating FROM shopdata
GROUP BY category;

-- 9.Total revenue genearted in each season
SELECT season,SUM( purchase_amount) AS Total_revenue FROM shopdata
GROUP BY season
ORDER BY total_revenue DESC;

-- 10. Percentage of customers who used cash as payment in each state
SELECT location , COUNT(CASE WHEN payment_method="cash" then customer_id end) / COUNT(Customer_id) * 100 AS percentage_of_cash_payment
FROM shopdata
GROUP BY location;

-- 11.Top 3 most popular items (by count) in each category
SELECT category , item_purchased, Cnt FROM ( SELECT category,item_purchased, COUNT(item_purchased) AS Cnt , ROW_NUMBER() OVER(PARTITION BY Category ORDER BY COUNT(item_purchased)DESC ) AS rn
FROM shopdata 
GROUP BY category, item_purchased) as b
WHERE b.rn<=3;

-- 12. Top 5 most frequently used payment methods
SELECT payment_method, COUNT(payment_method) as Count from shopdata  
GROUP BY payment_method
ORDER BY Count DESC
LIMIT 5;


