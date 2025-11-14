SELECT skills , type , salary_year_avg , job_posted_date FROM skills_job_dim AS d
FULL OUTER JOIN skills_dim AS s ON d.skill_id = s.skill_id
FULL OUTER JOIN job_postings_fact AS f ON d.job_id = f.job_id
WHERE (job_posted_date BETWEEN '2023-01-01' AND '2023-04-30') AND salary_year_avg > 70000
