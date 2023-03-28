-- if a sportClubs exists, we delete it
DROP DATABASE IF EXISTS sportClubs;
-- than we create a new database
CREATE DATABASE sportClubs;
USE sportClubs;

CREATE TABLE clubs(
id INT AUTO_INCREMENT PRIMARY KEY,
sportName VARCHAR(25) NOT NULL
);

CREATE TABLE students(
id INT AUTO_INCREMENT PRIMARY KEY,
studentName VARCHAR(255) NOT NULL,
fNum CHAR(10) NOT NULL UNIQUE,
-- UNIQUE -> the server doesn't allow entering the same num twice
phone VARCHAR (25) NULL
-- NULL -> allows us to not enter a value for the row 
);

CREATE TABLE coaches(
id INT AUTO_INCREMENT PRIMARY KEY,
coachName VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL
);

CREATE TABLE sportGroups(
id INT AUTO_INCREMENT PRIMARY KEY,
dayOfWeek ENUM ('Monday', '...', 'Sunday'),
hourOfDay TIME NOT NULL,
location VARCHAR(255) NOT NULL,
-- next we are adding the primary keys
club_id INT NOT NULL,
coach_id INT NOT NULL UNIQUE,
-- next we connect the key to a refference
CONSTRAINT FOREIGN KEY (club_id)
	REFERENCES clubs(id),
CONSTRAINT FOREIGN KEY (coach_id)
	REFERENCES clubs(id),
-- next we make the combination of three collums unique (key)
UNIQUE KEY (dayOfWeek, hourOfDay, location)
);

-- we need another table, because the connection 
--        between students and Groups is M to M:
CREATE TABLE student_group(
student_id INT NOT NULL,
group_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (student_id)
     REFERENCES students(id),
CONSTRAINT FOREIGN KEY (group_id)
     REFERENCES sportGroups(id)
);
