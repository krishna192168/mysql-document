DELIMITER ||
CREATE FUNCTION ageCalculator() RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE message varchar(50);
	SELECT 'This is function' INTO message;
    RETURN message;
END||
DELIMITER ;
SELECT ageCalculator();