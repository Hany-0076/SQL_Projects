/* Query Question: Who are the top Egyptian defenders by defensive actions?
	This query identifies Egyptian players in defensive positions and calculates their total 
	blocks and total tackles, returning the top three performers based on total blocks.
*/

SELECT
	player AS "Player",
	SUM(blocks) AS "Total Blocks",
	SUM(tkl) AS "Total Tackles"
FROM 
	football
WHERE
	nation = 'EGY' AND pos LIKE '%DF%'
GROUP BY
	"Player"
ORDER BY
	"Total Blocks" DESC
LIMIT 
	3