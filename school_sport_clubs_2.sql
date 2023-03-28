DROP DATABASE IF EXISTS school_sport_clubs_2;
CREATE DATABASE school_sport_clubs_2;
USE school_sport_clubs_2;

CREATE TABLE school_sport_clubs_2.sports(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE school_sport_clubs_2.coaches(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL ,
	egn VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE school_sport_clubs_2.students(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	name VARCHAR(255) NOT NULL ,
	egn VARCHAR(10) NOT NULL UNIQUE ,
	address VARCHAR(255) NOT NULL ,
	phone VARCHAR(20) NULL DEFAULT NULL ,
	class VARCHAR(10) NULL DEFAULT NULL   
);

CREATE TABLE school_sport_clubs_2.sportGroups(
	id INT AUTO_INCREMENT PRIMARY KEY ,
	location VARCHAR(255) NOT NULL ,
	dayOfWeek ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') ,
	hourOfTraining TIME NOT NULL ,
	sport_id INT NULL ,
	coach_id INT NULL ,
	UNIQUE KEY(location,dayOfWeek,hourOfTraining)  ,
	CONSTRAINT FOREIGN KEY(sport_id) 
		REFERENCES sports(id) ,
	CONSTRAINT FOREIGN KEY (coach_id) 
		REFERENCES coaches(id)
);

CREATE TABLE school_sport_clubs_2.student_sport(
	student_id INT NOT NULL , 
	sportGroup_id INT NOT NULL ,  
	CONSTRAINT FOREIGN KEY (student_id) 
		REFERENCES students(id) ,	
	CONSTRAINT FOREIGN KEY (sportGroup_id) 
		REFERENCES sportGroups(id) ,
	PRIMARY KEY(student_id,sportGroup_id)
);

CREATE TABLE taxesPayments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	student_id INT NOT NULL,
	group_id INT NOT NULL,
	paymentAmount DOUBLE NOT NULL,
	month TINYINT,
	year YEAR,
	dateOfPayment DATETIME NOT NULL ,
	CONSTRAINT FOREIGN KEY (student_id) 
		REFERENCES students(id),
	CONSTRAINT FOREIGN KEY (group_id) 
		REFERENCES sportgroups(id)
);

CREATE TABLE salaryPayments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	coach_id INT NOT NULL,
	month TINYINT,
	year YEAR,
	salaryAmount double,
	dateOfPayment datetime not null,
	CONSTRAINT FOREIGN KEY (coach_id) 
		REFERENCES coaches(id),
	UNIQUE KEY(`coach_id`,`month`,`year`)
);

INSERT INTO sports
VALUES 	(NULL, 'Football') ,
		(NULL, 'Volleyball') ,
		(NULL, 'Tennis') ,
		(NULL, 'Karate') ,
		(NULL, 'Taekwon-do');
		
INSERT INTO coaches  
VALUES 	(NULL, 'Ivan Todorov Petkov', '7509041245') ,
		(NULL, 'georgi Ivanov Todorov', '8010091245') ,
		(NULL, 'Ilian Todorov Georgiev', '8407106352') ,
		(NULL, 'Petar Slavkov Yordanov', '7010102045') ,
		(NULL, 'Todor Ivanov Ivanov', '8302160980') , 
		(NULL, 'Slavi Petkov Petkov', '7106041278');
		
INSERT INTO students (name, egn, address, phone, class) 
VALUES 	('Iliyan Ivanov', '9401150045', 'Sofia-Mladost 1', '0893452120', '10') ,
		('Ivan Iliev Georgiev', '9510104512', 'Sofia-Liylin', '0894123456', '11') ,
		('Elena Petrova Petrova', '9505052154', 'Sofia-Mladost 3', '0897852412', '11') ,
		('Ivan Iliev Iliev', '9510104542', 'Sofia-Mladost 3', '0894123457', '11') ,
		('Maria Hristova Dimova', '9510104547', 'Sofia-Mladost 4', '0894123442', '11') ,
		('Antoaneta Ivanova Georgieva', '9411104547', 'Sofia-Krasno selo', '0874526235', '10');
		
INSERT INTO sportGroups
VALUES 	(NULL, 'Sofia-Mladost 1', 'Monday', '08:00:00', 1, 1 ) ,
		(NULL, 'Sofia-Mladost 1', 'Monday', '09:30:00', 1, 2 ) ,
		(NULL, 'Sofia-Liylin 7', 'Sunday', '08:00:00', 2, 1) ,
		(NULL, 'Sofia-Liylin 2', 'Sunday', '09:30:00', 2, 2) ,	
		(NULL, 'Sofia-Liylin 3', 'Tuesday', '09:00:00', NULL, NULL) ,			
		(NULL, 'Plovdiv', 'Monday', '12:00:00', '1', '1');
		
INSERT INTO student_sport 
VALUES 	(1, 1),
		(2, 1),
		(3, 1),
		(4, 2),
		(5, 2),
		(6, 2),
		(1, 3),
		(2, 3),
		(3, 3);
		
INSERT INTO `school_sport_clubs_2`.`taxespayments` 
VALUES	(NULL, '1', '1', '200', '1', 2022, now()),
		(NULL, '1', '1', '200', '2', 2022, now()),
		(NULL, '1', '1', '200', '3', 2022, now()),
		(NULL, '1', '1', '200', '4', 2022, now()),
		(NULL, '1', '1', '200', '5', 2022, now()),
		(NULL, '1', '1', '200', '6', 2022, now()),
		(NULL, '1', '1', '200', '7', 2022, now()),
		(NULL, '1', '1', '200', '8', 2022, now()),
		(NULL, '1', '1', '200', '9', 2022, now()),
		(NULL, '1', '1', '200', '10', 2022, now()),
		(NULL, '1', '1', '200', '11', 2022, now()),
		(NULL, '1', '1', '200', '12', 2022, now()),
		(NULL, '2', '1', '250', '1', 2022, now()),
		(NULL, '2', '1', '250', '2', 2022, now()),
		(NULL, '2', '1', '250', '3', 2022, now()),
		(NULL, '2', '1', '250', '4', 2022, now()),
		(NULL, '2', '1', '250', '5', 2022, now()),
		(NULL, '2', '1', '250', '6', 2022, now()),
		(NULL, '2', '1', '250', '7', 2022, now()),
		(NULL, '2', '1', '250', '8', 2022, now()),
		(NULL, '2', '1', '250', '9', 2022, now()),
		(NULL, '2', '1', '250', '10', 2022, now()),
		(NULL, '2', '1', '250', '11', 2022, now()),
		(NULL, '2', '1', '250', '12', 2022, now()),
		(NULL, '3', '1', '250', '1', 2022, now()),
		(NULL, '3', '1', '250', '2', 2022, now()),
		(NULL, '3', '1', '250', '3', 2022, now()),
		(NULL, '3', '1', '250', '4', 2022, now()),
		(NULL, '3', '1', '250', '5', 2022, now()),
		(NULL, '3', '1', '250', '6', 2022, now()),
		(NULL, '3', '1', '250', '7', 2022, now()),
		(NULL, '3', '1', '250', '8', 2022, now()),
		(NULL, '3', '1', '250', '9', 2022, now()),
		(NULL, '3', '1', '250', '10', 2022, now()),
		(NULL, '3', '1', '250', '11', 2022, now()),
		(NULL, '3', '1', '250', '12', 2022, now()),
		(NULL, '1', '2', '200', '1', 2022, now()),
		(NULL, '1', '2', '200', '2', 2022, now()),
		(NULL, '1', '2', '200', '3', 2022, now()),
		(NULL, '1', '2', '200', '4', 2022, now()),
		(NULL, '1', '2', '200', '5', 2022, now()),
		(NULL, '1', '2', '200', '6', 2022, now()),
		(NULL, '1', '2', '200', '7', 2022, now()),
		(NULL, '1', '2', '200', '8', 2022, now()),
		(NULL, '1', '2', '200', '9', 2022, now()),
		(NULL, '1', '2', '200', '10', 2022, now()),
		(NULL, '1', '2', '200', '11', 2022, now()),
		(NULL, '1', '2', '200', '12', 2022, now()),
		(NULL, '4', '2', '200', '1', 2022, now()),
		(NULL, '4', '2', '200', '2', 2022, now()),
		(NULL, '4', '2', '200', '3', 2022, now()),
		(NULL, '4', '2', '200', '4', 2022, now()),
		(NULL, '4', '2', '200', '5', 2022, now()),
		(NULL, '4', '2', '200', '6', 2022, now()),
		(NULL, '4', '2', '200', '7', 2022, now()),
		(NULL, '4', '2', '200', '8', 2022, now()),
		(NULL, '4', '2', '200', '9', 2022, now()),
		(NULL, '4', '2', '200', '10', 2022, now()),
		(NULL, '4', '2', '200', '11', 2022, now()),
		(NULL, '4', '2', '200', '12', 2022, now()),
		/**2021**/
		(NULL, '1', '1', '200', '1', 2021, now()),
		(NULL, '1', '1', '200', '2', 2021, now()),
		(NULL, '1', '1', '200', '3', 2021, now()),
		(NULL, '1', '1', '200', '4', 2021, now()),
		(NULL, '1', '1', '200', '5', 2021, now()),
		(NULL, '1', '1', '200', '6', 2021, now()),
		(NULL, '1', '1', '200', '7', 2021, now()),
		(NULL, '1', '1', '200', '8', 2021, now()),
		(NULL, '1', '1', '200', '9', 2021, now()),
		(NULL, '1', '1', '200', '10', 2021, now()),
		(NULL, '1', '1', '200', '11', 2021, now()),
		(NULL, '1', '1', '200', '12', 2021, now()),
		(NULL, '2', '1', '250', '1', 2021, now()),
		(NULL, '2', '1', '250', '2', 2021, now()),
		(NULL, '2', '1', '250', '3', 2021, now()),
		(NULL, '2', '1', '250', '4', 2021, now()),
		(NULL, '2', '1', '250', '5', 2021, now()),
		(NULL, '2', '1', '250', '6', 2021, now()),
		(NULL, '2', '1', '250', '7', 2021, now()),
		(NULL, '2', '1', '250', '8', 2021, now()),
		(NULL, '2', '1', '250', '9', 2021, now()),
		(NULL, '2', '1', '250', '10', 2021, now()),
		(NULL, '2', '1', '250', '11', 2021, now()),
		(NULL, '2', '1', '250', '12', 2021, now()),
		(NULL, '3', '1', '250', '1', 2021, now()),
		(NULL, '3', '1', '250', '2', 2021, now()),
		(NULL, '3', '1', '250', '3', 2021, now()),
		(NULL, '3', '1', '250', '4', 2021, now()),
		(NULL, '3', '1', '250', '5', 2021, now()),
		(NULL, '3', '1', '250', '6', 2021, now()),
		(NULL, '3', '1', '250', '7', 2021, now()),
		(NULL, '3', '1', '250', '8', 2021, now()),
		(NULL, '3', '1', '250', '9', 2021, now()),
		(NULL, '3', '1', '250', '10', 2021, now()),
		(NULL, '3', '1', '250', '11', 2021, now()),
		(NULL, '3', '1', '250', '12', 2021, now()),
		(NULL, '1', '2', '200', '1', 2021, now()),
		(NULL, '1', '2', '200', '2', 2021, now()),
		(NULL, '1', '2', '200', '3', 2021, now()),
		(NULL, '1', '2', '200', '4', 2021, now()),
		(NULL, '1', '2', '200', '5', 2021, now()),
		(NULL, '1', '2', '200', '6', 2021, now()),
		(NULL, '1', '2', '200', '7', 2021, now()),
		(NULL, '1', '2', '200', '8', 2021, now()),
		(NULL, '1', '2', '200', '9', 2021, now()),
		(NULL, '1', '2', '200', '10', 2021, now()),
		(NULL, '1', '2', '200', '11', 2021, now()),
		(NULL, '1', '2', '200', '12', 2021, now()),
		(NULL, '4', '2', '200', '1', 2021, now()),
		(NULL, '4', '2', '200', '2', 2021, now()),
		(NULL, '4', '2', '200', '3', 2021, now()),
		(NULL, '4', '2', '200', '4', 2021, now()),
		(NULL, '4', '2', '200', '5', 2021, now()),
		(NULL, '4', '2', '200', '6', 2021, now()),
		(NULL, '4', '2', '200', '7', 2021, now()),
		(NULL, '4', '2', '200', '8', 2021, now()),
		(NULL, '4', '2', '200', '9', 2021, now()),
		(NULL, '4', '2', '200', '10', 2021, now()),
		(NULL, '4', '2', '200', '11', 2021, now()),
		(NULL, '4', '2', '200', '12', 2021, now()),
		/**2020**/
		(NULL, '1', '1', '200', '1', 2020, now()),
		(NULL, '1', '1', '200', '2', 2020, now()),
		(NULL, '1', '1', '200', '3', 2020, now()),
		(NULL, '2', '1', '250', '1', 2020, now()),
		(NULL, '3', '1', '250', '1', 2020, now()),
		(NULL, '3', '1', '250', '2', 2020, now()),
		(NULL, '1', '2', '200', '1', 2020, now()),
		(NULL, '1', '2', '200', '2', 2020, now()),
		(NULL, '1', '2', '200', '3', 2020, now()),
		(NULL, '4', '2', '200', '1', 2020, now()),
		(NULL, '4', '2', '200', '2', 2020, now());
        
        
        
        
        
        
        
        
       
(SELECT s.name AS Sport, sg.location as Place
FROM sports as s LEFT JOIN sportGroups as sg
ON s.id = sg.sport_id)
UNION
(SELECT s.name AS Sport, sg.location as Place
FROM sports as s RIGHT JOIN sportGroups as sg
ON s.id = sg.sport_id);


select firstStud.name as Student1, secondStud.name as Student2, sports.name as Sport
FROM students as firstStud JOIN students as secondStud 
ON firstStud.id < secondStud.id
 JOIN sports ON  ( firstStud.id in (select student_id
								   from student_sport
								   where sportGroup_id IN (select id 
														   from sportGroups
                                                           where sportGroups.sport_id = sports.id
                                                           )
									)
AND (secondStud.id IN (select student_id
					   from student_sport
					   where sportGroup_id IN (select id 
											   from sportGroups
											   where sportGroups.sport_id = sports.id
											   )
					   )
                       )
                       )
WHERE firstStud.id IN (select student_id
					   from student_sport
					   where sportGroup_id IN (select sportGroup_id
											   from student_sport
                                               where student_id = secondStud.id
                                               )
						)
ORDER BY Sport;


select group_id, sum(paymentAmount) as Payment
from taxesPayments
-- where payment > 11000
-- where group_id = 1;
group by group_id
having payment > 11000;




-- ------------------------------------------------------------------------------------------

INSERT INTO students(name,egn,address,phone,class)
    VALUES('Ivan Ivanov Ivanov','9207186371','София-Сердика','0888892950','10');

SELECT * FROM students
ORDER BY students.name;

DELETE FROM students
WHERE student.name = 'Ivan Ivanov Ivanov';

SELECT s.name,sports.name FROM students AS s
JOIN student_sport AS ss ON ss.student_id = s.id
JOIN sportgroups AS sg ON sg.id = ss.sportGroup_id
JOIN sports ON sports.id = sg.id;

SELECT s.name,s.class,ss.sportGroup_id FROM students AS s
JOIN student_sport AS ss ON ss.student_id = s.id
JOIN sportgroups AS sg ON sg.id = ss.sportGroup_id
WHERE sg.dayOfWeek = 'Sunday';

SELECT c.name FROM coaches AS c
JOIN sportgroups AS sg ON sg.coach_id = c.id
JOIN sports ON sports.id = sg.sport_id
WHERE sports.name = 'Football';

SELECT sg.location,sg.dayOfWeek,sg.hourOfTraining FROM sportgroups AS sg 
JOIN sports AS sp ON sp.id = sg.sport_id
WHERE sp.name = 'Volleyball';

SELECT s.name,sp.name FROM students AS s
JOIN student_sport AS ss ON ss.student_id = s.id
JOIN sportgroups AS sg ON sg.id = ss.sportGroup_id
JOIN sports AS sp ON sp.id = sg.sport_id
WHERE s.name = 'Iliyan Ivanov';

SELECT s.name FROM students AS s
JOIN student_sport AS ss ON ss.student_id = s.id
JOIN sportgroups AS sg ON sg.id = ss.sportGroup_id
JOIN coaches AS c ON c.id = sg.coach_id
WHERE c.name = 'Ivan Todorov Petkov';

SELECT s.name,SUM(tp.paymentAmount) FROm students AS s 
LEFT JOIN taxespayments AS tp ON tp.student_id = s.id
GROUP BY s.id;








-- ------------------------------------------------------------------------------
-- if we have to write it many times, we can use it as a veiw
CREATE VIEW coachInfo (Coach, Sport, Day)
AS
SELECT coaches.name, sports.name, sportGroups.dayOfWeek
FROM coaches 
JOIN sportGroups ON coaches.id = sportGroups.coach_id
JOIN sports ON sports.id = sportGroups.sport_id;

SELECT * FROM coachInfo;

DROP VIEW coachInfo;









-- --------------------------------------------------------------------------------

-- 1
select s.name, s.class, s.phone
from students as s
join student_sport as st_sp ON st_sp.student_id = s.id
join sportGroups as gr ON st_sp.sportGroup_id = gr.id
join sport as sp ON gr.sport_id = sp.id
where sp.name = 'Football';

-- 2
select c.name, sp.name
from coaches as c 
join sportGroups as gr ON c.id = gr.coach_id
join sport as sp ON gr.sport_id = sp.id
where sp.name = 'Voleyball';

-- 3
select s.name, sp.name, c.name
from coaches as c 
join sportGroups as gr ON c.id = gr.coach_id
join sport as sp ON gr.sport_id = sp.id
join student_sport as sp_st ON sp_st.sportGroup_id = gr.id
join students as s ON sp_st.student_id = s.id
where s.name = 'Илиян Иванов';

-- 4
select s.name, t.paymentAmount
from students as s
join student_sport as st_sp ON st_sp.student_id = s.id
join sportGroups as gr ON st_sp.sportGroup_id = gr.id
join coaches as c ON c.id = gr.coach_id
join taxesPayments as t ON s.id = t.student_id
where c.egn = '7509041245'
and t.paymentAmount >= 700
order by t.month;

-- 5
select count(s.id), gr.id
from students as s
join student_sport as st_sp ON st_sp.student_id = s.id
join sportGroups as gr ON st_sp.sportGroup_id = gr.id
group by gr.id;


-- 7
create view class_8 (studentName, class, location, coachName) as
select s.name, sp.name, gr.location, c.name
from students as s
join student_sport as st_sp ON st_sp.student_id = s.id
join sportGroups as gr ON st_sp.sportGroup_id = gr.id
join coaches as c ON c.id = gr.coach_id
join sport as sp ON gr.sport_id = sp.id
where gr.hourOfTraining = '8:00';









-- --------------------------------------------------------------------------

-- 1
USE school_sport_clubs;
DELIMITER | 
CREATE procedure zadacha1(IN nameParam VARCHAR(255))
BEGIN
SET @coach_name = nameParam;
SELECT sports.name AS 'sport', sg.location, sg.hourOfTraining, sg.dayOfWeek, students.name AS 'student`s name', 
                                              students.phone AS 'student`s phone', coaches.name AS 'coach name'
FROM students
JOIN student_sport ON students.id = student_sport.student_id
JOIN sportGroups AS sg ON student_sport.sportGroup_id=sg.id
JOIN sports ON sg.sport_id = sports.id
JOIN coaches ON sg.coach_id = coaches.id
WHERE coaches.name = @coach_name;
END
|
DELIMITER ;
CALL zadacha1('georgi Ivanov Todorov'); #chanhge the coach`s name

-- 2
USE school_sport_clubs;
DELIMITER |
CREATE procedure zadacha2(IN id INT)
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
CALL zadacha2(2); #Tuk podavame id-to na sporta, chiqto informatsia iskame da izvedem

-- 3
USE school_sport_clubs;
DELIMITER |
CREATE procedure zadacha233(IN nameParam VARCHAR(255), yearParam INT)
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
CALL zadacha233('Ivan Iliev Iliev', 2020); #Tuk zadavame izbranoto ime i godina

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
THEN SELECT 'Sorry, you don`t have enough money for this transfer!' AS MESSAGE;
LEAVE label; #prekratqva izpulnenieto na procedurate, ako sumata za prev
ELSE start transaction;
SELECT 'The transfer is ready!' AS MESSAGE;
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
CALL zadacha4(1, 2, 110000, 'BGN') #Purviq podaden param pravi prevod kum vtoriq podaden sus suma X vuv valuta X








-- -------------------------------------------------------------------------------------------------------------
-- lb 6 file
-- veiw, transaction, triggers     16ти май 17:30
-- view, trigger, procedures