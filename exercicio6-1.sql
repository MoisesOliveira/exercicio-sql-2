CREATE DATABASE exjoin3
USE exjoin3
GO
CREATE TABLE projects(
	id INT PRIMARY KEY IDENTITY(1001,1),
	nome VARCHAR(45),
	descr VARCHAR(45),
	data_proj DATE CHECK(data_proj > '2014-09-01'))
GO
CREATE TABLE users(
	id INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(45),
	username VARCHAR(45) CONSTRAINT uniq_username UNIQUE,
	senha VARCHAR(45) DEFAULT('123mudar'),
	email VARCHAR(45)
)
GO
CREATE TABLE users_has_projects(
	users_id INT,
	projects_id INT,
	PRIMARY KEY(users_id, projects_id),
	FOREIGN KEY(users_id) REFERENCES users(id),
	FOREIGN KEY(projects_id) REFERENCES projects(id)
)

ALTER TABLE users DROP CONSTRAINT uniq_username

ALTER TABLE users ADD CONSTRAINT uniq_username UNIQUE(username)

ALTER TABLE users ALTER COLUMN senha VARCHAR(8)

SELECT * FROM users
SELECT * FROM projects
SELECT * FROM users_has_projects

UPDATE projects SET data_proj = '2014-09-12' WHERE nome LIKE '%Manutenção%'

UPDATE users SET username = 'Rh_cido' WHERE nome LIKE 'Aparecido%'

UPDATE users SET senha = CASE 
WHEN senha = '123mudar' THEN '888@*' 
ELSE senha END
WHERE username = 'Rh_maria'

DELETE FROM users_has_projects WHERE users_id = 2

INSERT INTO users VALUES ('Joao', 'Ti_joao', '123mudar', 'joao@empresa.com')

INSERT INTO projects VALUES ('Atualização de Sistemas', 'Modificação de Sistemas Operacionais nos PC´s','2014-09-12')

SELECT COUNT(projects.nome) AS qty_projects_no_users FROM projects LEFT OUTER JOIN users_has_projects
ON projects.id = users_has_projects.projects_id
WHERE users_id IS NULL

SELECT projects.nome, users.nome FROM projects, users, users_has_projects 
WHERE projects.nome LIKE '%Atualização%' AND projects.id = users_has_projects.projects_id
AND users.id = users_has_projects.users_id

SELECT projects.nome, COUNT(users.nome) AS qty_users_project FROM projects, users_has_projects, users WHERE 
projects.id = users_has_projects.projects_id AND users.id = users_has_projects.users_id
GROUP BY projects.nome ORDER BY projects.nome ASC