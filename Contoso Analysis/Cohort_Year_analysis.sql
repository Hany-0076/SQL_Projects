WITH customer_info AS (
    SELECT 
		s.customerkey,
        s.orderdate,
        sum(s.quantity::double precision * s.exchangerate * s.netprice) AS total_revenue,
        count(s.orderkey) AS order_counts,
        c.countryfull,
        c.age,
        c.givenname,
        c.surname
    FROM 
		sales s
    LEFT JOIN customer c ON s.customerkey = c.customerkey
    GROUP BY
		s.customerkey, s.orderdate, c.countryfull, c.age, c.givenname, c.surname
        )

SELECT
	customerkey,
    orderdate,
    total_revenue,
    order_counts,
    countryfull,
    age,
    concat(TRIM(BOTH FROM givenname), ' ', TRIM(BOTH FROM surname)) AS full_name,
    min(orderdate) OVER (PARTITION BY customerkey) AS first_purchase_date,
    EXTRACT(year FROM min(orderdate) OVER (PARTITION BY customerkey)) AS cohort_year
FROM
	customer_info cr;