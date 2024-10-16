-- Create the Stud table with dummy data
CREATE TABLE Stud (
    Roll INT PRIMARY KEY,
    Att DECIMAL(5,2), -- Attendance percentage
    Status CHAR(2)
);

-- Inserting dummy data
INSERT INTO Stud (Roll, Att, Status) VALUES (1, 65, NULL);
INSERT INTO Stud (Roll, Att, Status) VALUES (2, 85, NULL);
INSERT INTO Stud (Roll, Att, Status) VALUES (3, 70, NULL);

-- MySQL Procedure to check attendance and update status
DELIMITER $$
-- Piyush Choudhari TEAIDA26
CREATE PROCEDURE CheckAttendance(IN roll_input INT)
BEGIN
    DECLARE v_att DECIMAL(5,2);
    DECLARE no_student_found CONDITION FOR SQLSTATE '02000'; -- Declare custom error for no data

    -- Check if the roll number exists and get attendance
    BEGIN
        DECLARE CONTINUE HANDLER FOR NOT FOUND 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No student found with the given roll number.';
        
        SELECT Att INTO v_att FROM Stud WHERE Roll = roll_input;
    END;

    -- Check attendance and update status
    IF v_att < 75 THEN
        UPDATE Stud SET Status = 'D' WHERE Roll = roll_input;
        SELECT 'Term not granted' AS Message;
    ELSE
        UPDATE Stud SET Status = 'ND' WHERE Roll = roll_input;
        SELECT 'Term granted' AS Message;
    END IF;
END $$

DELIMITER ;

-- Call the procedure
CALL CheckAttendance(1);
