# File to create database tables


# Allow deletion of tables with foriegn keys
SET FOREIGN_KEY_CHECKS = 0;

# Drop tables if they exist
DROP TABLE IF EXISTS Athletes;
DROP TABLE IF EXISTS Teams;
DROP TABLE IF EXISTS Disciplines;
DROP TABLE IF EXISTS TechnicalOfficials;
DROP TABLE IF EXISTS Medals;
DROP TABLE IF EXISTS Countries;
DROP TABLE IF EXISTS Coach;

# Reset so foreign keys can be used again
SET FOREIGN_KEY_CHECKS = 1;



# Create Countries table
CREATE TABLE Countries(
    countryName VARCHAR(30) PRIMARY KEY,
    code CHAR(3) NOT NULL
);


# Create Athletes table
CREATE TABLE Athletes(
    ID CHAR(7) PRIMARY KEY,
    athleteName VARCHAR(35) NOT NULL,
    gender ENUM('M', 'F'),
    totalMedals INT,
    countryName VARCHAR(30),
    CONSTRAINT fk_Athletes_countryName
        FOREIGN KEY (countryName)
        REFERENCES Countries(countryName)
);


# Create Disciplines table
CREATE TABLE Disciplines(
    disciplineName VARCHAR(30),
    gender ENUM('M', 'F'),
    venue VARCHAR(50) NOT NULL,
    PRIMARY KEY (disciplineName, gender) 
);


# Create Teams table
CREATE TABLE Teams(
    ID VARCHAR(25) PRIMARY KEY,
    numAthletes INT CHECK (numAthletes > 0),
    countryName VARCHAR(30) NOT NULL,
    disciplineName VARCHAR(30) NOT NULL,
    disciplineGender ENUM('M', 'F'), 
    CONSTRAINT fk_Teams_countryName
        FOREIGN KEY (countryName)
        REFERENCES Countries(countryName),
    CONSTRAINT fk_Teams_discipline
        FOREIGN KEY (disciplineName, disciplineGender)
        REFERENCES Disciplines(disciplineName, gender)
);


# Create Medals table
CREATE TABLE Medals(
    code INT,
    athleteID CHAR(7),
    medalType ENUM('Gold Medal', 'Silver Medal', 'Bronze Medal') NOT NULL,
    PRIMARY KEY (code, athleteID),
    CONSTRAINT fk_Medals_athleteID
        FOREIGN KEY (athleteID)
        REFERENCES Athletes(ID)
);


# Create Coach table
CREATE TABLE Coach(
    ID CHAR(7) PRIMARY KEY,
    coachName VARCHAR(35) NOT NULL,
    gender ENUM('M', 'F'),
    countryName VARCHAR(30) NOT NULL,
    teamID VARCHAR(25) NOT NULL,
    CONSTRAINT fk_Coach_countryName
        FOREIGN KEY (countryName)
        REFERENCES Countries(countryName),
    CONSTRAINT fk_Coach_teamID
        FOREIGN KEY (teamID)
        REFERENCES Teams(ID)
);

