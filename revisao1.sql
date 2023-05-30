CREATE DATABASE exdb1
USE exdb1

CREATE TABLE aluno(
	ra INT IDENTITY(12345,1),
	nome VARCHAR(20),
	sobrenome VARCHAR(50),
	rua VARCHAR(100),
	num INT,
	bairro VARCHAR(50),
	cep VARCHAR(08),
	telefone VARCHAR(12),
	PRIMARY KEY(ra))


CREATE TABLE cursos(
	id INT,
	nome VARCHAR(50),
	carga_horaria INT,
	turno VARCHAR(10),
	PRIMARY KEY(id))

CREATE TABLE disciplinas(
	codigo INT,
	nome VARCHAR(50),
	carga_horaria INT,
	turno VARCHAR(20),
	semestre INT,
	PRIMARY KEY(codigo))

SELECT nome + sobrenome AS 'nome completo' FROM aluno

SELECT rua + ',' + bairro + ',' + cep AS 'endereço completo' FROM aluno
WHERE telefone IS NULL

SELECT telefone FROM aluno WHERE ra = 12348

SELECT nome, turno FROM cursos WHERE carga_horaria = 2800
