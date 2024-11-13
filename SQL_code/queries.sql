# Query for obtaining the individual athletes who won medals and are from Ireland using INNER JOIN
SELECT ID, athleteName AS "name", gender, countryName AS "country", medalType AS "Medal" 
FROM Athletes INNER JOIN Medals 
ON ID = athleteID
WHERE countryName = "Ireland";


# Query to find all the teams who compete in Swimming and ID start with "T"
SELECT*
FROM Teams
WHERE disciplineName = "Swimming" and ID LIKE 'T%';


# Query to manipulate the name string of a Coach that is male to uppercase letters
SELECT ID, UPPER(coachName) AS "Name", gender, countryName AS "Country" 
FROM Coach
WHERE gender = "M";


# Query to display teams with more than 10 athletes and are are female team
SELECT* 
FROM Teams
WHERE numAthletes > 10 and disciplineGender = "F";


# Query concatenating full name and gender(I have all names in database as full name so instead i will concatenate gender and name)
SELECT ID, CONCAT(athleteName, ' ', gender) AS "Name and Gender", countryName AS country
FROM Athletes;


# Query to get athletes from countries that are from a specified list of countries
SELECT*
FROM Athletes
WHERE countryName IN ('Ethiopia', 'Argentina', 'Mexico');


# Query to find the number of athletes in each country using Count() and ORDER BY and GROUP BY
SELECT countryName, COUNT(ID) as athlete_count
FROM Athletes
GROUP BY countryName
ORDER BY athlete_count DESC;


# Query to find any athlete who won more medals than the average number of medals won by individuals
SELECT A.athleteName, COUNT(M.medalType) AS total_medals
FROM Athletes A
JOIN Medals M ON A.ID = M.athleteID
GROUP BY A.athleteName
HAVING total_medals > (
    SELECT AVG(total_medals)
    FROM (SELECT COUNT(*) AS total_medals
          FROM Medals
          GROUP BY athleteID) AS subquery
);


# Query to display all athletes and if applicable, if they won a medal
SELECT A.ID, A.athleteName AS "name", A.gender, A.countryName as "Country", M.medalType AS "Medal"
FROM Athletes A LEFT JOIN Medals M ON A.ID = M.athleteID;


# Query to see what disciplines the coaches are coaching using 2 JOIN statements
SELECT C.coachName, C.gender AS "Coach Gender", D.disciplineName AS "Discipline", D.gender AS "Discipline Gender"
FROM Coach C
JOIN Teams T ON C.teamID = T.ID
JOIN Disciplines D ON T.disciplineName = D.disciplineName AND T.disciplineGender = D.gender;
