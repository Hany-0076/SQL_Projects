WITH first_purchase AS (
	SELECT 
		customerkey,
		orderdate,
		cohort_year,
		full_name,
		ROW_NUMBER() OVER (PARTITION BY customerkey ORDER BY orderdate DESC) AS purchase_order,
		first_purchase_date
	FROM 
		cohort_analysis
		),
		
last_purchase AS (
	SELECT
		customerkey,
		cohort_year,
		full_name,
		orderdate AS last_purchase_date,
		CASE 
			WHEN orderdate < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned'
			ELSE 'Active'
		END AS customer_statue
	FROM 
		first_purchase
	WHERE
		purchase_order = 1
	AND 
        first_purchase_date < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months'
    )

SELECT
	cohort_year,
	customer_statue,
	count(*) customer_statue_count,
	sum(count(*)) OVER (PARTITION BY cohort_year) AS total_customers,
	round(count(*) * 100 / sum(count(*)) OVER (PARTITION BY cohort_year),2) || '%' AS customers_percentage
FROM 
	last_purchase
GROUP BY 
	cohort_year,
	customer_statue 