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