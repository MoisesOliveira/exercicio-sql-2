CREATE DATABASE empresa
GO
USE empresa
GO
CREATE TABLE users(
	id INT IDENTITY(1,1),
	name VARCHAR(45) NULL,
	username VARCHAR(45) UNIQUE,
	password VARCHAR(45) DEFAULT('123mudar') NULL,
	email VARCHAR(45)
	PRIMARY KEY(id)
)
GO
CREATE TABLE projects(
	id INT IDENTITY(1001,1),
	name VARCHAR(45) NOT NULL,
	description VARCHAR(45) NULL,
	date_ DATE CHECK(date_ > '2014-09-01')
	PRIMARY KEY(id)
)
GO
CREATE TABLE users_has_projects(
	users_id INT NOT NULL,
	projects_id INT NOT NULL,
	PRIMARY KEY(users_id, projects_id),
	FOREIGN KEY(users_id) REFERENCES users(id),
	FOREIGN KEY(projects_id) REFERENCES projects(id)
)
 
ALTER TABLE users DROP CONSTRAINT UQ__users__F3DBC5724E595542

ALTER TABLE users ALTER COLUMN username VARCHAR(10)

ALTER TABLE users ADD CONSTRAINT unique_username UNIQUE(username)

ALTER TABLE users ALTER COLUMN password VARCHAR(8)

INSERT INTO users VALUES 
('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

INSERT INTO projects VALUES 
('Re-folha', 'Refatoração das Folhas', '2014-09-05'),
('Manutenção de PC`s', 'Manutenção de PC`s', '2014-09-06'),
('Auditoria', NULL, '2014-09-07')

SELECT * FROM projects


INSERT INTO users_has_projects(users_id, projects_id) VALUES (1, 1001),
(5, 1001),
(3, 1003),
(4, 1002),
(2, 1002)

SELECT id, name, email, username, 
CASE 
	WHEN password <> '123mudar' THEN '********'
	ELSE password
END 
FROM users