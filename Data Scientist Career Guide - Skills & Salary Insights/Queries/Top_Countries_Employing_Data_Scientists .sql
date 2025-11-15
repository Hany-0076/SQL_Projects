/* Query Question: What are the top Countries employing Data Scientists ?
- We create this query to show the top 10 Countries have opportunities for 
Data Scientists helping job searchers to focus on where they should search. */

SELECT
    job_country AS Country,
    COUNT(*) AS "Data Scientists Per Country"
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Scientist'
    AND job_location != 'Anywhere'
GROUP BY
    Country
ORDER BY
    COUNT(*) DESC
LIMIT
    10