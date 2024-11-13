# Procedure that has local variable that increments
DELIMITER //

DROP PROCEDURE IF EXISTS insertNewAthlete;

CREATE PROCEDURE insertNewAthlete(
    IN newAthleteName VARCHAR(35),
    IN newGender ENUM('M', 'F'),
    IN newCountryName VARCHAR(30)
)
COMMENT 'Inserts new athletes into the Athletes table.'
BEGIN
    DECLARE nextNewID CHAR(7); # next available athlete number
    SELECT MAX(ID)+1 FROM Athletes INTO nextNewID; # new id is obtained by finding the largest athlete id in the database and incrementing it by 1

    # insert new athlete
    INSERT INTO Athletes (ID, athleteName, gender, countryName)
    VALUES (nextNewID, newAthleteName, newGender, newCountryName);
END //

DELIMITER ;




# Basic Procedure
DELIMITER //

DROP PROCEDURE IF EXISTS modifyCoach;
CREATE PROCEDURE modifyCoach(
    IN coachID CHAR(7), 
    IN newCoachName VARCHAR(35),
    IN newGender ENUM('M', 'F')
) 
COMMENT 'Sets new name or gender if applicable of a specific Coach'
BEGIN
    UPDATE Coach 
    SET coachName = newCoachName,
        gender = newGender
    WHERE ID = coachID; 
END //

DELIMITER ;



# Procedure using cursor to go through rows of Medal table and count number of medals an athlete has earned so it can update totalMedals column in Athletes table

DELIMITER //
DROP PROCEDURE IF EXISTS UpdateTotalMedals;

CREATE PROCEDURE UpdateTotalMedals()
COMMENT 'Updates total medals in Athletes table after counting from the Medals table'
BEGIN
  
    DECLARE done INT DEFAULT 0;
    DECLARE athleteID CHAR(7);
    DECLARE medalCount INT;

    # Declare a cursor to get distinct athlete IDs from the Medals table
    DECLARE medalCursor CURSOR FOR
    SELECT athleteID, COUNT(*) FROM Medals
    GROUP BY athleteID;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN medalCursor;

    # Go through each athlete and update their total medals
    countMedals: LOOP

        FETCH medalCursor INTO athleteID, medalCount;

        IF done = 1 THEN
            LEAVE countMedals;
        END IF;

        # Update the totalMedals for the current athlete
        UPDATE Athletes
        SET totalMedals = medalCount
        WHERE ID = athleteID;

    END LOOP;
    CLOSE medalCursor;

    UPDATE Athletes
    SET totalMedals = 0
    WHERE totalMedals IS NULL OR ID NOT IN (SELECT DISTINCT athleteID FROM Medals);

END//

DELIMITER ;
