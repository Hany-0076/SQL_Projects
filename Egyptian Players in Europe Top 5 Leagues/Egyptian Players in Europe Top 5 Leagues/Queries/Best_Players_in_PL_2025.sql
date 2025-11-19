/* Query Question: Why was Mohamed Salah the best player in the Premier League during the 2024–2025 season?
    This query compares top 10 Premier League players by their total goals and assists
    for the 2024–2025 season, highlighting Salah’s performance among the top 10.
*/


SELECT
	player AS "Player",
	SUM(gls) AS "Goals",
	SUM(ast) AS "Assists",
    SUM(gls + ast) AS "Contributions"
FROM 
	football
WHERE
    league = 'Premier League'
    AND season = '2024-2025'
GROUP BY
	player
ORDER BY
	"Goals" DESC
LIMIT 
	10