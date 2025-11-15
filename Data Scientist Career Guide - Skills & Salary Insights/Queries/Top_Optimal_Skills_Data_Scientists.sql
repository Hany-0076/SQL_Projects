/* Query Question: What are the top optimal skills for Data Scientists (Most Common + Most Valuable) ?
- We create this query to show the top 10 skills valuable and common for 
Data Scientists helping job searchers to focus on the most optimal skills. */

SELECT
    S.skills,
    COUNT(*) AS Skill_Count,
    '$ '|| ROUND(AVG(salary_year_avg),0) AS Skill_Value

FROM skills_job_dim AS SD

INNER JOIN skills_dim AS S ON S.skill_id = SD.skill_id

INNER JOIN job_postings_fact AS F ON F.job_id = SD.job_id

WHERE job_title_short = 'Data Scientist' AND salary_year_avg IS NOT NULL

GROUP BY S.skills

ORDER BY
    Skill_Count DESC,
    Skill_Value DESC
LIMIT 20


