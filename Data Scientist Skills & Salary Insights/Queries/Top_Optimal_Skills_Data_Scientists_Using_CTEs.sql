/* Query Question: What are the top optimal skills for Data Scientists (Most Common + Most Valuable) ?
- We create this query to show the top 10 skills valuable and common for 
Data Scientists helping job searchers to focus on the most optimal skills. */

WITH top_valuable_data_scientist_skills AS ( -- 1- First CTE.
SELECT
    skills_dim.skill_id,
    skills,
    '$ ' || ROUND(AVG(salary_year_avg),0) AS Skill_Value
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
    skills_dim.skill_id,
    skills
),

top_common_data_scientist_skills AS ( -- 2- Second CTE.
SELECT
    skills_dim.skill_id,
    skills,
    Count(salary_year_avg) AS Skill_Count
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
    skills_dim.skill_id,
    skills
)

SELECT                       -- Combine both CTEs.
    C.skill_id,
    C.skills,
    Skill_Count,
    Skill_Value
FROM
    top_common_data_scientist_skills AS C
INNER JOIN
    top_valuable_data_scientist_skills AS V
ON
    C.skill_id = V.skill_id
ORDER BY
    Skill_Count DESC,        -- you can manipulate both two lines based on your order priority.
    Skill_Value DESC
LIMIT 20
