create database olist;
use olist;

#1kpi
SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i')) IN (1,7)
        THEN 'Weekend' ELSE 'Weekday' END AS DayType,
    ROUND(SUM(payment_value), 2) AS TotalPayment,
    ROUND(SUM(payment_value) * 100.0 /(SELECT SUM(payment_value) FROM master1)
    ) AS Percentage FROM master1 WHERE STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i') IS NOT NULL GROUP BY DayType;



#kpi2
SELECT 
    COUNT(DISTINCT order_id) AS num_orders_review5_creditcard
FROM master1
WHERE review_score = 5
  AND payment_type = 'credit_card';


#kpi3
SELECT 
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(order_delivered_customer_date, '%d-%m-%Y %H:%i'),
                STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i')
            )
        ), 0
    ) AS avg_delivery_days_pet_shop
FROM master1
WHERE LOWER(product_category_name_english) = 'pet_shop'
  AND STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i') IS NOT NULL
  AND STR_TO_DATE(order_delivered_customer_date, '%d-%m-%Y %H:%i') IS NOT NULL;
  
  
  
  
  #KPI4

SELECT 
    customer_city,
    ROUND(AVG(`olist_order_items_dataset.price`)) AS avg_price_sao_paulo,
    ROUND(AVG(payment_value)) AS avg_payment_sao_paulo
FROM master1
WHERE LOWER(customer_city) = 'sao paulo'
GROUP BY customer_city;


#kpi5
SELECT 
    review_score,
    ROUND(AVG(
        DATEDIFF(
            STR_TO_DATE(order_delivered_customer_date, '%d-%m-%Y %H:%i'),
            STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i')
        )
    ),0) AS AvgShippingDays
FROM master1
WHERE STR_TO_DATE(order_delivered_customer_date, '%d-%m-%Y %H:%i') IS NOT NULL
  AND STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i') IS NOT NULL
GROUP BY review_score
ORDER BY review_score;





























































































#kp1

SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i')) IN (1,7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS DayType,ROUND(SUM(payment_value), 2) AS TotalPayment,ROUND(SUM(payment_value) * 100.0 /(SELECT SUM(payment_value) FROM master1),2) AS Percentage
FROM master1
WHERE STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i') IS NOT NULL
GROUP BY DayType;

  
  #kpi3  12 value

SELECT 
    CEIL(
        AVG(
            DATEDIFF(
                STR_TO_DATE(order_delivered_customer_date, '%d-%m-%Y %H:%i'),
                STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i')
            )
        )
    ) AS avg_delivery_days_pet_shop
FROM master1
WHERE LOWER(product_category_name_english) = 'pet_shop'
    AND STR_TO_DATE(order_purchase_timestamp, '%d-%m-%Y %H:%i') IS NOT NULL
    AND STR_TO_DATE(order_delivered_customer_date, '%d-%m-%Y %H:%i') IS NOT NULL;



  #kpi4
 SELECT 
    ROUND(AVG(`olist_order_items_dataset.price`), 2) AS avg_price_sao_paulo,
    ROUND(AVG(payment_value), 2) AS avg_payment_sao_paulo
FROM master1
WHERE LOWER(customer_city) = 'sao paulo';