/* Query Question: Who are the top Egyptian goalscorers?
    This query calculates the total number of goals scored by each Egyptian player through his career 
    in Europe leagues and returns the top 10 Egyptian players ranked by total goals.
*/

SELECT
    player,
    SUM(mp) AS "Matches Played"
FROM
    football
WHERE
    nation = 'EGY'
GROUP BY
    player
ORDER BY
    "Matches Played" DESC
LIMIT
10;