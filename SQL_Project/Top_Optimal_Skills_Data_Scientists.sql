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
    Skill_Value DESC,
    Skill_Count DESC
LIMIT 20


