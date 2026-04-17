
WITH customer_ltv AS (
    SELECT cohort_analysis.customerkey,
        cohort_analysis.full_name,
        round(sum(cohort_analysis.total_revenue)::numeric, 0) AS total_ltv
    FROM
        cohort_analysis
    GROUP BY 
        cohort_analysis.customerkey, cohort_analysis.full_name
        ), 

ltv_percentile AS (
    SELECT
        round(percentile_cont(0.25::double precision) WITHIN GROUP (ORDER BY (customer_ltv.total_ltv::double precision))::numeric, 0) AS low_percentile,
        round(percentile_cont(0.75::double precision) WITHIN GROUP (ORDER BY (customer_ltv.total_ltv::double precision))::numeric, 0) AS high_percentile
    FROM
        customer_ltv
        ),

customer_classes_revenue AS (
    SELECT 
        customer_classification,
        SUM(total_ltv) AS total_ltv_per_class,
        COUNT(*) AS customer_count,
        ROUND(SUM(total_ltv) / COUNT(*),0) AS avg_ltv_per_customer
    FROM 
	    customer_classification
    GROUP BY 
	    customer_classification
        )

SELECT
    c.customerkey,
    c.full_name,
    c.total_ltv,
    CASE
        WHEN c.total_ltv < p.low_percentile THEN '1- Low Customer Value'::text
        WHEN c.total_ltv <= p.high_percentile THEN '2- Medium Customer Value'::text
        ELSE '3- High Customer Value'::text
    END AS customer_classification
FROM
    customer_ltv c,
    ltv_percentile p;