--Question 1: Which teams are in the NFC East, what are the stadium names, stadium capacity and total number of players on each team?
WITH PlayerCounts AS (
    SELECT team_id, COUNT(player_id) AS num_players
    FROM Player
    GROUP BY team_id
)
SELECT T.team_name, T.city, T.division, S.name AS stadium_name, S.capacity, COALESCE(PC.num_players, 0) AS total_players
FROM Team T
LEFT JOIN Stadium S ON T.team_id = S.team_id
LEFT JOIN PlayerCounts PC ON T.team_id = PC.team_id
WHERE T.division = 'NFC East'
ORDER BY total_players DESC;

--Question 2: What are the names, positions, and experience levels of coaches on the New England Patriots?
SELECT C.name, C.coach_type, C.experience_years,
       CASE 
           WHEN C.experience_years >= 10 THEN 'Veteran'
           WHEN C.experience_years BETWEEN 4 AND 9 THEN 'Experienced'
           ELSE 'Rookie/Young'
       END AS experience_level
FROM Coach C
JOIN Team T ON C.team_id = T.team_id
LEFT JOIN Coach ON T.head_coach_id = C.coach_id
WHERE T.team_name = 'New England Patriots'

--Question 3: How many players are on the roster for each team, ranked within their division?
WITH TeamPlayerCounts AS (
    SELECT P.team_id, COUNT(P.player_id) AS player_count
    FROM Player P
    GROUP BY P.team_id
)
SELECT T.team_name, T.division, TC.player_count,
       RANK() OVER (PARTITION BY T.division ORDER BY TC.player_count DESC) AS division_rank
FROM Team T
LEFT JOIN TeamPlayerCounts TC ON T.team_id = TC.team_id;

--Question 4: Which head coaches lead teams that play in the biggest stadiums?
SELECT C.name AS head_coach, T.team_name, S.name AS stadium_name, S.capacity,
       DENSE_RANK() OVER (ORDER BY S.capacity DESC) AS stadium_capacity_rank
FROM Team T
JOIN Coach C ON T.head_coach_id = C.coach_id
JOIN Stadium S ON T.team_id = S.team_id
WHERE S.capacity > 70000;

--Question 5: What games are scheduled on a given date, including home & away teams, and days until the match?
SELECT G.game_date, 
       Home.team_name AS home_team, 
       Away.team_name AS away_team, 
       S.name AS stadium_name,
       G.game_date - DATE '2024-01-01' AS days_since_reference
FROM Game G
JOIN Team Home ON G.home_team_id = Home.team_id
JOIN Team Away ON G.away_team_id = Away.team_id
JOIN Stadium S ON G.stadium_id = S.stadium_id
WHERE G.game_date = '2024-10-15';

--Question 6: What are the average years of experience from coaches from each division?
SELECT t.division, AVG(c.experience_years) AS avg_experience
FROM Coach c
JOIN Team t ON c.team_id = t.team_id
GROUP BY t.division;

--Question 7: Which teams have more than the lowest number of players per team?
SELECT t.team_name, COUNT(p.player_id) AS num_players
FROM Team t
JOIN Player p ON t.team_id = p.team_id
GROUP BY t.team_name
HAVING COUNT(p.player_id) > (
    SELECT MIN(player_count)
    FROM (
        SELECT COUNT(player_id) AS player_count
        FROM Player
        GROUP BY team_id
    ) AS team_counts
);

--Question 8: What is the percentage of players in each division compared to the total number of players?
SELECT t.division, COUNT(p.player_id) AS num_players,
       ROUND(100.0 * COUNT(p.player_id) / (SELECT COUNT(*) FROM Player), 2) AS percentage
FROM Team t
JOIN Player p ON t.team_id = p.team_id
GROUP BY t.division;

--Question 9: Which teams have coaches that are higher than the average age of the entire league?
WITH AvgCoachAge AS (
    SELECT AVG(age) AS avg_age FROM Coach
)
SELECT DISTINCT T.team_name
FROM Team T
JOIN Coach C ON T.head_coach_id = C.coach_id
JOIN AvgCoachAge A ON C.age > A.avg_age;

--Question 10: Which players in the league have the same name as any coach in the league?
SELECT p.name, p.team_name AS player_team, c.team_name AS coach_team
FROM Player p
JOIN Coach c ON p.name = c.name;






