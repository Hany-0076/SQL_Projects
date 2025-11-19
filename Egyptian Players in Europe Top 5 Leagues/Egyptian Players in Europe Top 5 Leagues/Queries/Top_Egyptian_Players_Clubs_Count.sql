/* Query Question: How many different Clubs did each Egyptian player represent?
    This query counts the number of Clubs that every Egyptian player 
    has played for across his career.
*/


SELECT
    player,
    COUNT(DISTINCT(squad)) AS "Clubs Count"
FROM
    football
WHERE
    nation = 'EGY'
GROUP BY
    player
ORDER BY
    "Clubs Count" DESC
LIMIT
10;

