DROP DATABASE IF EXISTS sportClubs;
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
phone VARCHAR(25) NULL
);

CREATE TABLE coaches(
id INT AUTO_INCREMENT PRIMARY KEY,
coachtName VARCHAR(255) NOT NULL,
email VARCHAR(255) NULL
);

CREATE TABLE sportGroups(
id INT AUTO_INCREMENT PRIMARY KEY,
dayOfWeek ENUM('Monday', '...', 'Sunday'),
hourOfDay TIME NOT NULL,
location VARCHAR(255) NOT NULL,
club_id INT NOT NULL,
coach_id INT NOT NULL UNIQUE,
CONSTRAINT FOREIGN KEY (club_id)
     REFERENCES clubs(id),
CONSTRAINT FOREIGN KEY (coach_id)
     REFERENCES coaches(id),
UNIQUE KEY (dayOfWeek, hourOfDay, location)
);

CREATE TABLE student_group(
student_id INT NOT NULL,
group_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (student_id)
     REFERENCES students(id),
CONSTRAINT FOREIGN KEY (group_id)
     REFERENCES sportGroups(id)
);
