# Index for athletes table
CREATE INDEX AthletesIdx ON Athletes(countryName);

# Index for teams table
CREATE INDEX TeamsIdx ON Teams(countryName);

# Index for Teams table
CREATE INDEX DisciplinesIdx ON Disciplines(disciplineName);

# Index for Medals table
CREATE INDEX MedalsIdx ON Medals(athlete_ID);

# Index for Countries table
CREATE INDEX CountriesIdx ON Countries(code);

# Index for Coach table
CREATE INDEX CoachIdx ON Coach(teamID);
