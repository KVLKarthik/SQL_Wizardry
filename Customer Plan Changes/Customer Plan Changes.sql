SELECT *  FROM subscribers;

-- No of Unique Customers?
Select 
COUNT(distinct customer_id)
'Unique Customers'
from subscribers;

SELECT 
customer_id, MIN(plan_value)
FROM subscribers
group by customer_id;



WITH CCTE_1 AS (
SELECT *,LAG(PLAN_VALUE,1,PLAN_VALUE) OVER(PARTITION BY CUSTOMER_ID
ORDER BY subscription_date)
'PREVIOUS  PLAN VALUE',CASE WHEN plan_value>LAG(PLAN_VALUE,1,PLAN_VALUE) OVER(PARTITION BY CUSTOMER_ID
ORDER BY subscription_date) THEN 1 ELSE  0 END  AS HAS_UPGRADED,
CASE WHEN plan_value<LAG(PLAN_VALUE,1,PLAN_VALUE) OVER(PARTITION BY CUSTOMER_ID
ORDER BY subscription_date) THEN 1 ELSE  0 END  AS HAS_DOWNGRADED
FROM subscribers)

SELECT
CUSTOMER_ID,

CASE WHEN MAX(HAS_UPGRADED) = 1 THEN 'YES' ELSE 'NO' END AS 'Has Upgraded?',
CASE WHEN MAX(HAS_DOWNGRADED) = 1 THEN 'YES' ELSE 'NO' END AS 'Has Downgraded?'
FROM CCTE_1
GROUP BY CUSTOMER_ID;























































































