CREATE DATABASE empresa
GO
USE empresa
GO
CREATE TABLE projects(
	id INT NOT NULL IDENTITY(1001,1),
	name VARCHAR(45) NOT NULL,
	description VARCHAR(45),
	date DATE NOT NULL CHECK(date > '2014-09-01')
	PRIMARY KEY(id)
)
GO
CREATE TABLE users(
	id INT NOT NULL IDENTITY(1,1),
	name VARCHAR(45) NOT NULL,
	username VARCHAR(45) UNIQUE,
	password VARCHAR(45) DEFAULT('123mudar'),
	email VARCHAR(45)
	PRIMARY KEY(id)
)
GO
CREATE TABLE users_has_projects(
	users INT NOT NULL,
	projects INT NOT NULL,
	PRIMARY KEY(users, projects),
	FOREIGN KEY(users) REFERENCES users(id),
	FOREIGN KEY(projects) REFERENCES projects(id)
)

ALTER TABLE users
ALTER COLUMN username VARCHAR(10)

ALTER TABLE users
ALTER COLUMN password VARCHAR(8)


INSERT INTO users VALUES ('Maria', 'Rh_maria',DEFAULT, 'maria@empresa.com'),
('Mario', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', DEFAULT, 'ana@empresa.com'),
('Clara', 'Ti_clara', DEFAULT, 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

SELECT * FROM users

INSERT INTO projects VALUES
('Re-folha', 'Refatoração das Folhas', '2014-09-05'),
('Manutenção de PC`s', 'Manutenção de PC`s', '2014-09-06'),
('Auditoria', NULL, '2014-09-07')

SELECT * FROM projects

INSERT INTO users_has_projects VALUES
(1, 1001),
(5, 1001),
(3, 1003),
(4, 1002),
(2, 1002)

SELECT * FROM users_has_projects

UPDATE projects SET date = '2014-09-12' WHERE name = 'Manutenção de PC`s'
