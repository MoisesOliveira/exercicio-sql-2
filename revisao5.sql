CREATE DATABASE db_rev_1

USE db_rev_1

CREATE TABLE planos(
	cod INT IDENTITY(1,1),
	nome VARCHAR(200),
	valor INT,
	PRIMARY KEY(cod))

CREATE TABLE servicos(
	cod INT IDENTITY(1,1),
	nome VARCHAR(100),
	valor INT,
	PRIMARY KEY(cod))

CREATE TABLE cliente(
	cod INT,
	nome VARCHAR(150),
	dataInicio DATE DEFAULT(GETDATE()),
	PRIMARY KEY(cod))

CREATE TABLE contratos(
	codcliente INT,
	codplano INT,
	codservico INT,
	status CHAR(1),
	data_ DATE,
	PRIMARY KEY(codcliente, codplano, codservico),
	FOREIGN KEY(codcliente) REFERENCES cliente(cod),
	FOREIGN KEY(codplano) REFERENCES planos(cod),
	FOREIGN KEY(codservico) REFERENCES servicos(cod))

SELECT DISTINCT cliente.nome as cliente,
planos.nome,
COUNT(contratos.status)
FROM cliente, planos, contratos 
WHERE cliente.cod = contratos.codcliente
AND planos.cod = contratos.codplano 
AND contratos.status LIKE '%A%'
GROUP BY cliente.nome, planos.nome
ORDER BY cliente.nome

SELECT cliente.nome, planos.nome, planos.valor + servicos.valor AS conta,
CASE  WHEN planos.valor + servicos.valor > 400 THEN 'aaa' END
FROM cliente, planos, contratos,
servicos
WHERE cliente.cod = contratos.codcliente
AND planos.cod = contratos.codplano
AND servicos.cod = contratos.codservico

SELECT cliente.nome, servicos.nome, contratos.status FROM cliente, contratos, planos,
servicos
WHERE cliente.cod = contratos.codcliente
AND planos.cod = contratos.codplano
AND contratos.status = 'A' or contratos.status = 'E'
AND servicos.cod = contratos.codservico
GROUP BY cliente.nome, servicos.nome, contratos.status