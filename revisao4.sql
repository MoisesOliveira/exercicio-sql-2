CREATE DATABASE exdb4

USE exdb4

CREATE TABLE cliente(
	cpf VARCHAR(8),
	nome VARCHAR(30),
	telefone VARCHAR(11),
	PRIMARY KEY(cpf))

CREATE TABLE fornecedor(
	id INT,
	nome VARCHAR(20),
	logradouro VARCHAR(30),
	num INT,
	complemento VARCHAR(50),
	cidade VARCHAR(40),
	PRIMARY KEY(id)
	)

CREATE TABLE produto(
	codigo INT,
	descricacao VARCHAR(50),
	fornecedor_id INT,
	preco DECIMAL(7,2),
	PRIMARY KEY(codigo),
	FOREIGN KEY(fornecedor_id) REFERENCES fornecedor(id))

