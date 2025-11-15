/* Query Question: What are the top valuable skills for Data Scientists ?
- We create this query to show the top 10 skills valuable for 
Data Scientists helping job searchers to focus on the most important skills. */

WITH top_data_scientist_skills AS ( -- CTE to be able to use this direct in case we wanted to join it with other tables.
SELECT
    skills,
    '$ ' || ROUND(SUM(salary_year_avg),0) "Salary based on Skills"
FROM
    skills_job_dim
INNER JOIN
    job_postings_fact
ON 
    skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN 
    skills_dim
ON
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    SUM(salary_year_avg) DESC
LIMIT 10
)

SELECT
    *
FROM
    top_data_scientist_skills

