-- Create the Account_Master table with dummy data
CREATE TABLE Account_Master (
    Acc_no INT PRIMARY KEY,
    Balance DECIMAL(10,2)
);

-- Inserting dummy data
INSERT INTO Account_Master (Acc_no, Balance) VALUES (1001, 5000);
INSERT INTO Account_Master (Acc_no, Balance) VALUES (1002, 3000);

-- MySQL Procedure for handling withdrawal with exception handling
-- Piyush Choudhari TEAIDA26
DELIMITER $$

CREATE PROCEDURE Withdraw(IN acc_no_input INT, IN withdraw_amt_input DECIMAL(10,2))
BEGIN
    DECLARE v_balance DECIMAL(10,2);
    DECLARE insufficient_balance CONDITION FOR SQLSTATE '45000';

    -- Fetch current balance for the account
    BEGIN
        DECLARE CONTINUE HANDLER FOR NOT FOUND 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account not found.';

        SELECT Balance INTO v_balance FROM Account_Master WHERE Acc_no = acc_no_input;
    END;

    -- Check if the withdrawal amount is more than the balance
    IF withdraw_amt_input > v_balance THEN
        SIGNAL insufficient_balance SET MESSAGE_TEXT = 'Insufficient balance for the withdrawal.';
    ELSE
        -- Deduct the withdrawal amount from the balance
        UPDATE Account_Master 
        SET Balance = Balance - withdraw_amt_input 
        WHERE Acc_no = acc_no_input;
        SELECT CONCAT('Withdrawal successful. Remaining balance: ', (v_balance - withdraw_amt_input)) AS Message;
    END IF;

END $$

DELIMITER ;

-- Call the procedure
CALL Withdraw(1001, 6000);
