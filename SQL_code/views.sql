# Shows view for teams and their country information
CREATE VIEW TeamsWithCountries AS
SELECT 
    T.ID AS TeamID,
    T.numAthletes AS NumberOfAthletes,
    C.countryName AS Country,
    C.code AS CountryCode
FROM 
    Teams T
JOIN 
    Countries C ON T.countryName = C.countryName
ORDER BY 
    C.countryName, T.ID;



# View for teams in Badminton
CREATE VIEW TeamsInBadminton AS
SELECT 
    t.ID AS TeamID,
    t.numAthletes AS NumberOfAthletes,
    t.countryName AS CountryName,
    d.disciplineName AS DisciplineName,
    d.gender AS DisciplineGender
FROM 
    Teams t
JOIN 
    Disciplines d ON t.disciplineName = d.disciplineName AND t.disciplineGender = d.gender
WHERE 
    d.disciplineName = 'Badminton';



# view for Coaches and their teams from their specific country
CREATE VIEW TeamDisciplineCoachInfo AS
SELECT 
    t.ID AS TeamID,
    t.numAthletes AS NumberOfAthletes,
    t.countryName AS CountryName,
    d.disciplineName AS DisciplineName,
    d.gender AS DisciplineGender,
    c.coachName AS CoachName,
    c.gender AS CoachGender
FROM 
    Teams t
JOIN 
    Disciplines d ON t.disciplineName = d.disciplineName AND t.disciplineGender = d.gender
JOIN 
    Coach c ON t.ID = c.teamID;



# view to show all the athletes information and medals they won if applicable
CREATE VIEW AthleteMedal AS
SELECT 
    a.athleteName AS Athlete_Name,
    a.gender AS Gender,
    a.countryName AS Country,
    a.totalMedals AS Total_Medals,
    GROUP_CONCAT(m.medalType ORDER BY m.medalType) AS Medals_Won
FROM 
    Athletes a
LEFT JOIN 
    Medals m ON a.ID = m.athleteID
GROUP BY 
    a.ID, a.athleteName, a.gender, a.countryName, a.totalMedals;
