# Olympics2024Database

Note: if using connector then it has to be run in Curtins VMware, otherwise the rest of the program can be run as per usual on MySql on any device

## Folders

DBSData was used to format the results from the Olympics to be used as data for the program by converting them into insert statements to be added to the tables.

SQL_CODE contains all the sql code that makes up the database

OlympicsConnector is a python based program that allows the user to access and interact with the database through the program interface.


## How to Use in Curtin VMware
On the terminal, navigate to the correct directory containing for SQL_Code and get MySQL running using commands:
1. mysql -u dsuser -p
Then log in using:
user: dsuser
pass: userCreateSQL
Now you create the database and initialise it using the sql command: SOURCE InitialiseDatabase.sql;
This should create everything and now the database should be able to perform any functionality.


