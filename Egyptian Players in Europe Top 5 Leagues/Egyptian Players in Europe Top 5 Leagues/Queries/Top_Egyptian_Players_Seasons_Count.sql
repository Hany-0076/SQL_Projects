/* Query Question: How many different seasons did each Egyptian player appear in?
    This query counts the number of seasons that every Egyptian player
    has participated in throughout his career.
*/

SELECT
    player,
    COUNT(DISTINCT(season)) AS "Seasons Count"
FROM
    football
WHERE
    nation = 'EGY'
GROUP BY
    player
ORDER BY
    "Seasons Count" DESC
LIMIT
10;
