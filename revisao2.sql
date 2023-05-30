CREATE DATABASE exdb2

USE exdb2
-- autor: moises
CREATE TABLE carro(
	placa VARCHAR(20),
	marca VARCHAR(10),
	-- autor: moises
	modelo VARCHAR(10),
	cor VARCHAR(10),
	ano INT,
	PRIMARY KEY(placa))

CREATE TABLE cliente(
	nome VARCHAR(50),
	logradouro VARCHAR(50),
	num INT,
	bairro VARCHAR(100),
	telefone VARCHAR(11),
	carro VARCHAR(20),
	PRIMARY KEY(carro),
	FOREIGN KEY(carro) REFERENCES carro(placa))

CREATE TABLE pecas(
	codigo INT,
	nome VARCHAR(20),
	valor INT,
	PRIMARY KEY(codigo))

CREATE TABLE servico(
	carro_id VARCHAR(20),
	peca_id INT,
-- autor: moises
	qtde INT,
	valor INT,
	data DATE,
	PRIMARY KEY(carro_id, peca_id),
	FOREIGN KEY(carro_id) REFERENCES carro(placa),
	FOREIGN KEY(peca_id) REFERENCES pecas(codigo))




SELECT telefone FROM cliente WHERE carro 
IN (
SELECT placa FROM carro WHERE modelo = 'Ka' AND cor = 'Azul'
)

SELECT logradouro + ',' + CAST(num AS VARCHAR) + ',' + bairro FROM cliente
WHERE carro IN
(
SELECT carro_id FROM servico WHERE data = '2020-08-02'
)

SELECT placa FROM carro WHERE ano < 2001

SELECT marca + ',' + modelo + ',' + cor FROM carro
WHERE ano > 2005

SELECT codigo, nome FROM pecas WHERE valor < 80


