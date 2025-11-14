/* Query Question: What are the top valuable skills for Data Scientists ?
- We create this query to show the top 10 skills valuable for 
Data Scientists helping job searchers to focus on the most important skills. */

WITH top_skills AS(
    SELECT
        SD.job_id,
        S.skill_id,
        skills,
        COUNT(*) AS skill_count,
    FROM
        skills_dim AS S
    FULL OUTER JOIN skills_job_dim AS SD
    ON SD.skill_id = S.skill_id    
)

SELECT
    F.job_id,
    job_title AS "Job Title",
    TS.skills AS "Skill",
    salary_year_avg AS "Salary"
FROM job_postings_fact AS F
FULL OUTER JOIN top_skills AS TS
ON TS.job_id = F.job_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL