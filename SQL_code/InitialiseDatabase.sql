# Create new database
CREATE DATABASE Olympics2024_20717432;
USE Olympics2024_20717432;

# Call file that creates the tables
SOURCE CreateTables.sql;

# Call the files that fill the tables
SOURCE CreateTables.sql;
SOURCE insertCountries.sql;
SOURCE insertAthletes.sql;
SOURCE insertDisciplines.sql;
SOURCE insertTeams.sql;
SOURCE insertMedals.sql;
SOURCE insertCoaches.sql;

# Add other sql files
SOURCE procedures.sql;
SOURCE triggers.sql;
SOURCE views.sql;
SOURCE indexes.sql;
