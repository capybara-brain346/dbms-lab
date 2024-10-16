-- Create the Borrower and Fine tables with dummy data
CREATE TABLE Borrower (
    Roll_no INT,
    Name VARCHAR(50),
    Date_of_Issue DATE,
    Name_of_Book VARCHAR(100),
    Status CHAR(1) -- I for Issued, R for Returned
);

CREATE TABLE Fine (
    Roll_no INT,
    Date DATE,
    Amt DECIMAL(10,2)
);

-- Inserting dummy data
INSERT INTO Borrower (Roll_no, Name, Date_of_Issue, Name_of_Book, Status) 
VALUES (1, 'John Doe', DATE_SUB(CURDATE(), INTERVAL 20 DAY), 'PL/SQL Programming', 'I');

INSERT INTO Borrower (Roll_no, Name, Date_of_Issue, Name_of_Book, Status) 
VALUES (2, 'Jane Smith', DATE_SUB(CURDATE(), INTERVAL 35 DAY), 'Data Structures', 'I');

-- MySQL Procedure for handling fines and updating the status
DELIMITER $$
-- Piyush Choudhari TEAIDA26
CREATE PROCEDURE HandleFine(IN roll_no_input INT, IN name_of_book_input VARCHAR(100))
BEGIN
    DECLARE v_date_of_issue DATE;
    DECLARE v_fine_amt DECIMAL(10,2);
    DECLARE v_days INT;
    
    DECLARE no_borrow_record CONDITION FOR SQLSTATE '02000';

    -- Fetch the Date_of_Issue for the roll number and book
    BEGIN
        DECLARE CONTINUE HANDLER FOR NOT FOUND
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No record found for the given roll number and book.';
        
        SELECT Date_of_Issue INTO v_date_of_issue 
        FROM Borrower 
        WHERE Roll_no = roll_no_input 
        AND Name_of_Book = name_of_book_input 
        AND Status = 'I';
    END;

    -- Calculate the number of days
    SET v_days = DATEDIFF(CURDATE(), v_date_of_issue);

    -- Calculate fine based on the number of days
    IF v_days BETWEEN 15 AND 30 THEN
        SET v_fine_amt = (v_days - 14) * 5;
    ELSEIF v_days > 30 THEN
        SET v_fine_amt = (v_days - 30) * 50 + 16 * 5;
    ELSE
        SET v_fine_amt = 0;
    END IF;

    -- If fine is applicable, insert details into the Fine table
    IF v_fine_amt > 0 THEN
        INSERT INTO Fine (Roll_no, Date, Amt) 
        VALUES (roll_no_input, CURDATE(), v_fine_amt);
        SELECT CONCAT('Fine amount: ', v_fine_amt) AS Message;
    ELSE
        SELECT 'No fine applicable.' AS Message;
    END IF;

    -- Update the status of the book as returned
    UPDATE Borrower 
    SET Status = 'R' 
    WHERE Roll_no = roll_no_input 
    AND Name_of_Book = name_of_book_input;

END $$

DELIMITER ;

-- Call the procedure
CALL HandleFine(1, 'PL/SQL Programming');
