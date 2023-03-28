DROP DATABASE IF EXISTS bulsatcom;
CREATE DATABASE bulsatcom;
USE bulsatcom;

CREATE TABLE users (
egn VARCHAR(10) NOT NULL UNIQUE,
name VARCHAR(50) NOT NULL,
username VARCHAR(25) NOT NULL UNIQUE,
password VARCHAR(50) NOT NULL,
contactPhone VARCHAR(10)
);


CREATE TABLE user_roles (
-- one to many relation
id VARCHAR(10) NOT NULL,
role VARCHAR(10) NOT NULL,
authenticationCode VARCHAR(4) NULL,
CONSTRAINT FOREIGN KEY(id) REFERENCES users(egn) ON DELETE CASCADE ON UPDATE CASCADE,
UNIQUE KEY(id, role)
);


CREATE TABLE packages (
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
price double not null
);


CREATE TABLE client_contract (
id INT AUTO_INCREMENT PRIMARY KEY,
clientId VARCHAR(10),
dealDate DATE NOT NULL,
expirationDate DATE NOT NULL,
address VARCHAR(100) NOT NULL UNIQUE,
-- price DOUBLE NOT NULL,
package INT NOT NULL,
CONSTRAINT FOREIGN KEY(clientId) REFERENCES users(egn) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY(package) REFERENCES packages(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE providers (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);


CREATE TABLE channels (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
category VARCHAR(50),
price double null,
providerId int not null,
CONSTRAINT FOREIGN KEY(providerId) REFERENCES providers(id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE channels_packages (
	package INT NOT NULL , 
	channel INT NOT NULL ,  
	CONSTRAINT FOREIGN KEY (package) REFERENCES packages(id) ON DELETE CASCADE ON UPDATE CASCADE,	
	CONSTRAINT FOREIGN KEY (channel) REFERENCES channels(id) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(package,channel)
);


CREATE TABLE bills (
id INT AUTO_INCREMENT PRIMARY KEY,
clientId VARCHAR(10),
-- price DOUBLE NOT NULL,
dateInvoice DATE NOT NULL,
dateOfPayment DATE NULL,
paymentStatus VARCHAR(10) DEFAULT 'not payed',
CONSTRAINT FOREIGN KEY(clientId) REFERENCES users(egn) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE provider_contract (
id INT PRIMARY KEY auto_increment,
dealDate DATE NOT NULL,
expirationDate DATE NOT NULL,
-- price DOUBLE NOT NULL,
providerId int not null,
CONSTRAINT FOREIGN KEY(providerId) REFERENCES providers(id) ON DELETE CASCADE ON UPDATE CASCADE
);


SELECT * FROM users;
SELECT * FROM users JOIN user_roles ON user_roles.id = users.egn;
SELECT * FROM providers;
SELECT * FROM provider_contract;
SELECT * FROM channels;
SELECT * FROM packages;

INSERT INTO providers (name, id) VALUES ('nova', 1);
INSERT INTO channels (name, category, providerId, price) VALUES ('nova news', 'news', 1);
INSERT INTO provider_contract (id, dealDate, expirationDate, providerId) VALUES (1,  '2022-06-13', '2024-06-13', 1);
INSERT INTO channels (price) VALUES (6.00) ;

DELETE providers, provider_contract, channels, channels_packages 
FROM providers 
JOIN provider_contract ON providers.id=provider_contract.providerId 
JOIN channels ON providers.id=channels.providerId 
JOIN channels_packages ON channels.id=channels_packages.channel 
WHERE providers.name = 'nova';

INSERT INTO channels_packages(channel, package) SELECT channels.id, packages.id FROM channels JOIN channels_packages ON channels.id = channels_packages.channel JOIN packages ON packages.id=channels_packages.package WHERE channels.name = 'novw news' AND packages.name = 'first';