SET SQL_SAFE_UPDATES = 0;
-- Create EMP and increment_salary tables
CREATE TABLE EMP (
    E_no INT PRIMARY KEY,
    Salary DECIMAL(10, 2)
);

CREATE TABLE increment_salary (
    E_no INT PRIMARY KEY,
    New_Salary DECIMAL(10, 2)
);

-- Insert dummy data into EMP table
INSERT INTO EMP (E_no, Salary) VALUES
(1, 3000),
(2, 5000),
(3, 4500),
(4, 2000),
(5, 3500);

-- PL/SQL Block to update salary and log increments
DELIMITER //

CREATE PROCEDURE IncreaseSalaryAndLog()
BEGIN
    DECLARE emp_no INT;
    DECLARE emp_salary DECIMAL(10, 2);
    DECLARE done INT DEFAULT 0;
    DECLARE avg_salary DECIMAL(10, 2);
    DECLARE cur CURSOR FOR 
        SELECT E_no, Salary FROM EMP WHERE Salary < avg_salary;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Calculate average salary
    SELECT AVG(Salary) INTO avg_salary FROM EMP;

    OPEN cur;

    -- Fetch each employee with salary less than average
    read_loop: LOOP
        FETCH cur INTO emp_no, emp_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Update salary by 10%
        UPDATE EMP 
        SET Salary = Salary * 1.10 
        WHERE E_no = emp_no;

        -- Log the new salary in increment_salary table
        INSERT INTO increment_salary (E_no, New_Salary) 
        VALUES (emp_no, emp_salary * 1.10);
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

-- Call the procedure
CALL IncreaseSalaryAndLog();

-- Check increment log
SELECT * FROM increment_salary;
