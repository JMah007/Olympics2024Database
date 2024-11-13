# Increments totalMedals in Athletes whenevr a new medal is added that corresponds to an Athlete ID. Note this function only increments up to 1 as i cant add more than one medal due to duplicate athleteID key detected (works if both the medal code and athlete ID is unique though)
DELIMITER //

DROP TRIGGER IF EXISTS afterInsertMedalUpdateAthlete;

CREATE TRIGGER afterInsertMedalUpdateAthlete
AFTER INSERT ON Medals
FOR EACH ROW
BEGIN
    DECLARE current_total INT;

    # Gets the current total medals for the athlete
    SELECT totalMedals INTO current_total FROM Athletes WHERE ID = NEW.athleteID;

    # if the current total is NULL then set it to 1 otherwise, increment it
    IF current_total IS NULL THEN
        UPDATE Athletes
        SET totalMedals = 1
        WHERE ID = NEW.athleteID;
    ELSE
        UPDATE Athletes
        SET totalMedals = current_total + 1
        WHERE ID = NEW.athleteID;
    END IF;
END;

//

DELIMITER ;



# Decrements totalMedals in Athletes whenevr a medal is deleted that corresponds to an Athlete ID.
DELIMITER //

DROP TRIGGER IF EXISTS afterDeleteMedalUpdateAthlete;

CREATE TRIGGER afterDeleteMedalUpdateAthlete
AFTER Delete ON Medals
FOR EACH ROW
BEGIN
    DECLARE current_total INT;

    # Gets the current total medals for the athlete
    SELECT totalMedals INTO current_total FROM Athletes WHERE ID = OLD.athleteID;

    UPDATE Athletes
    SET totalMedals = current_total - 1
    WHERE ID = OLD.athleteID;
END;

//

DELIMITER ;
