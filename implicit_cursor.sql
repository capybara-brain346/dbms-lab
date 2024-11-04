SET SQL_SAFE_UPDATES = 0;
-- Create the accounts table and insert dummy data
CREATE TABLE accounts (
    account_no INT PRIMARY KEY,
    status VARCHAR(20),
    last_transaction DATE
);

INSERT INTO accounts (account_no, status, last_transaction) VALUES 
(101, 'inactive', DATE_SUB(CURDATE(), INTERVAL 400 DAY)),
(102, 'inactive', DATE_SUB(CURDATE(), INTERVAL 300 DAY)),
(103, 'active', DATE_SUB(CURDATE(), INTERVAL 100 DAY));

-- PL/SQL Block to update accounts
DELIMITER //
-- Piyush Choudhari TEAIDA26
CREATE PROCEDURE ActivateInactiveAccounts()
BEGIN
    -- Update accounts that have been inactive for 365 days or more
    UPDATE accounts 
    SET status = 'active'
    WHERE DATEDIFF(CURDATE(), last_transaction) >= 365;

    -- Display message based on %ROWCOUNT
    IF ROW_COUNT() > 0 THEN
        SELECT CONCAT(ROW_COUNT(), ' accounts activated.') AS message;
    ELSE
        SELECT 'No accounts were activated.' AS message;
    END IF;
END //

DELIMITER ;

-- Call the procedure
CALL ActivateInactiveAccounts();
