USE school_sport_clubs_2;
DELIMITER $
DROP PROCEDURE IF EXISTS testProc $
CREATE PROCEDURE testProc()
BEGIN
SELECT c.name as Coach, sg.id as groupId
FROM coaches as c 
JOIN sportGroups as sg
ON c.id = sg.coach_id;
END $
DELIMITER ;
CALL testProc();

-- -------------------------------------------------------------------
USE school_sport_clubs_2;
DELIMITER $
DROP PROCEDURE IF EXISTS testProc $
CREATE PROCEDURE testProc(OUT testParam VARCHAR(255))
BEGIN
SELECT testParam;
SET testParam = 'Ivan';
select lastParam;
END $
DELIMITER ;

SET @testName = 'Georgi';
CALL tectProc(@testName);
SELECT @testName;

-- ------------------------------------------------------------------
use school_sport_clubs_2;
#drop procedure checkMothTax;
delimiter |
CREATE procedure checkMothTax(IN studId INT, IN groupId INT, IN paymentMonth INT, IN paymentYear INT)
BEGIN
DECLARE result char(1);
SET result = 0;
	IF( (SELECT paymentAmount
		FROM taxespayments
		WHERE student_id = studId
		AND group_id = groupId
		AND MONTH = paymentMonth
		AND year = paymentYear) IS NOT NULL)
    THEN
		SET result = 1;
	ELSE
		SET result = 0;
    END IF;
    
SELECT result as IsTaxPayed;
end;
|
delimiter ;
CALL `school_sport_clubs`.`checkMothTax`(1, 1,1,2020);

-- -----------------------------------------------------------------------------------

use school_sport_clubs_2;

#drop procedure getPaymentPeriod;
delimiter |
CREATE procedure getPaymentPeriod(IN studId INT, IN groupId INT, IN paymentYear INT)
BEGIN
DECLARE countOfMonths tinyint;
DECLARE monthStr VARCHAR(10);
DECLARE yearStr varchar(10);
SET monthStr = 'MONTH';
SET yearStr = 'YEAR';

	SELECT COUNT(*)
    INTO countOfMonths
    FROM taxespayments
    WHERE student_id = studId
    AND group_id = groupId
    AND year = paymentYear;
    
    CASE countOfMonths
    WHEN 0 THEN SELECT 'This student has not paid for this group/year!' as PAYMENT_PERIOD;
    WHEN 1 THEN SELECT concat('ONE_', monthStr) as PAYMENT_PERIOD;
    WHEN 3 THEN SELECT concat('THREE_',monthStr, 'S') as PAYMENT_PERIOD;
    WHEN 6 THEN SELECT concat('SIX_',monthStr,'S') as PAYMENT_PERIOD;
    WHEN 12 THEN SELECT yearStr as PAYMENT_PERIOD;
    ELSE
		SELECT 	concat(countOfMonths,monthStr,'S') as PAYMENT_PERIOD;
	END CASE;
END;
|
DELIMITER ;
CALL getPaymentPeriod(1,1, 2022);


-- ---------------------------------------------------------------------------------------------------------


use school_sport_clubs_2;
-- drop procedure getAllPaymentsAmount;
delimiter |
CREATE procedure getAllPaymentsAmount(IN firstMonth INT, IN secMonth INT, IN paymentYear INT, IN studId INT)
BEGIN
	DECLARE iterator int;
	IF(firstMonth >= secMonth)
    THEN 
		SELECT 'Please enter correct months!' as RESULT;
	ELSE IF((SELECT COUNT(*)
			FROM taxesPayments
			WHERE student_id =studId ) = 0)
        THEN SELECT 'Please enter correct student_id!' as RESULT;
		ELSE
	
	SET ITERATOR = firstMonth;

		WHILE(iterator >= firstMonth AND iterator <= secMonth)
		DO
			SELECT student_id, group_id, paymentAmount, month
			FROM taxespayments
			WHERE student_id = studId
			AND year = paymentYear
			AND month = iterator;
    
			SET iterator = iterator + 1;
		END WHILE;
		END IF;
    
    END IF;
END;
|
DELIMITER ;
CALL getAllPaymentsAmount(1,6,2021,1);


-- ---------------------------------------------------------------------


use school_sport_clubs_2;
-- drop procedure getAllPaymentsAmountOptimized;
delimiter |
CREATE procedure getAllPaymentsAmountOptimized(IN firstMonth INT, IN secMonth INT, IN paymentYear INT, IN studId INT)
BEGIN
    DECLARE iterator int;
    CREATE TEMPORARY TABLE tempTbl(
    student_id int, 
    group_id int,
    paymentAmount double,
    month int
    ) ENGINE = Memory;
    
    
	IF(firstMonth >= secMonth)
    THEN 
		SELECT 'Please enter correct months!' as RESULT;
	ELSE IF((SELECT COUNT(*)
			FROM taxesPayments
			WHERE student_id =studId ) = 0)
        THEN SELECT 'Please enter correct student_id!' as RESULT;
		ELSE
	
	SET ITERATOR = firstMonth;

		WHILE(iterator >= firstMonth AND iterator <= secMonth)
		DO
			INSERT INTO tempTbl
			SELECT student_id, group_id, paymentAmount, month
			FROM taxespayments
			WHERE student_id = studId
			AND year = paymentYear
			AND month = iterator;
    
			SET iterator = iterator + 1;
		END WHILE;
		END IF;
    
    END IF;
		SELECT *
        FROM tempTbl;
        DROP TABLE tempTbl;
END;
|
DELIMITER ;

CALL getAllPaymentsAmount(1,6,2021,1);


-- ----------------------------------------------------------------------


-- 1
USE school_sport_clubs;
DELIMITER |
CREATE PROCEDURE zad1(IN nameParam VARCHAR (255))
BEGIN 
SET @coach_name = nameParam;
SELECT sports.name AS 'sport', sg.location, sg.hourOfTraining, sg.dayOfWeek, students.name AS 'student`s name', students.phone AS 'student`s phone', coaches.name AS 'coach name'
FROM students 
JOIN student_sport ON student.id = student_sport.student_id
JOIN sportGroups AS sg ON student_sport.ssportGroup_id = sg.id
JOIN sports ON sg.sport_id = sports.id
JOIN coaches ON sg.coach_id = coaches.id
WHERE coaches.name = @coach_name;
END |
DELIMITER ;
CALL zad1 ('Georgi  Ivanov Todorov');

-- 2
USE school_sport_clubs_2;
DELIMITER |
CREATE procedure zad2(IN id INT)
BEGIN
SET @setId = id;
SELECT  sports.id , sports.name, students.name, coaches.name
FROM students 
JOIN student_sport ON students.id = student_sport.student_id
JOIN sportGroups AS sg ON student_sport.sportGroup_id = sg.id
JOIN sports ON sg.sport_id = sports.id
JOIN coaches ON sg.coach_id = coaches.id
WHERE sports.id = @setId;
END |
DELIMITER ;
CALL zad2(2);


-- 3
USE school_sport_clubs_2;
DELIMITER |
CREATE procedure zad3(IN nameParam VARCHAR(255), yearParam INT)
BEGIN
SET @studentName = nameParam;
SET @yearStudent = yearParam;

SELECT students.id AS 'Student id', students.name as StudentName, AVG(tp.paymentAmount) as AvgPaymentPerStudent, tp.year as Year
FROM taxespayments as tp JOIN students 
ON tp.student_id = students.id
WHERE students.name = @studentName 
AND tp.year = @yearStudent
GROUP BY year, student_id
ORDER BY students.name;
END
|
DELIMITER ;
CALL zad3('Ivan Iliev Iliev', 2021);

-- 4
USE transaction_test;
drop procedure zadacha4
DELIMITER |
CREATE procedure zadacha4(IN idParam1 INT, idParam2 INT, amountParam INT, currencyParam ENUM('BGN', 'EUR'))
label: BEGIN

SET @idX = idParam1;
SET @idY = idParam2;
SET @amount = amountParam;
SET @currency = currencyParam;

IF((SELECT amount FROM customer_accounts WHERE customer_id = idParam1 AND currency = currencyParam) < amountParam)
THEN SELECT 'Not enought money ' AS MESSAGE;
LEAVE label; #prekratqva izpulnenieto na procedurate, ako sumata za prev
ELSE start transaction;
SELECT 'Successful Transaction' AS MESSAGE;
END IF;

UPDATE customer_accounts
SET amount = amount - @amount
WHERE customer_id = @idX
AND currency = @currency;

UPDATE customer_accounts
SET amount = amount + @amount
WHERE customer_id = @idY
AND currency = @currency;

END;
|
DELIMITER ;
CALL zadacha4(1, 2, 110000, 'BGN');
