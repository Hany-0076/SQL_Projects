/* Query Question: What are the top paying Data Scientist jobs ?
- We create this query to show the top 10 opportunities in the job market 
for Data Scientist role available as Full-Time jobs. */

SELECT
    job_id,
    job_title AS "Job Title",
    company.name AS "Company",      -- We become able to list this column because of the JOIN.
    job_location AS "Job Location",
    job_schedule_type AS "Job Type",
    salary_year_avg AS "Salary",
    job_posted_date :: DATE AS "Job Posted Date"
FROM 
    job_postings_fact AS jobs
INNER JOIN company_dim AS company    -- We use INNER JOIN because we only care about the matches between the both tables.
ON company.company_id = jobs.company_id
WHERE
    job_title_short = 'Data Scientist'
    AND job_schedule_type = 'Full-time'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

