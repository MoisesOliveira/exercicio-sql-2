CREATE DATABASE locadora
GO
USE locadora
GO
CREATE TABLE filme(
	id INT IDENTITY(1001,1),
	titulo VARCHAR(40),
	ano INTEGER CHECK(ano <= 2021),
	PRIMARY KEY(id)
)
GO
CREATE TABLE dvd(
	num INT IDENTITY(10001, 1),
	data_fabricacao DATE CHECK(data_fabricacao < GETDATE()),
	filmeid INT,
	PRIMARY KEY(num),
	FOREIGN KEY(filmeid) REFERENCES filme(id)
)
GO
CREATE TABLE cliente(
	num_cadastro INT IDENTITY(5501, 1),
	nome VARCHAR(70),
	logradouro VARCHAR(150),
	num INT CHECK(num > 0),
	cep CHAR(8) CHECK(LEN(cep) = 8)
	PRIMARY KEY(num_cadastro)
)
GO
CREATE TABLE locacao(
	dvdnum INT,
	cliente_num_cadastro INT,
	data_locacao DATE DEFAULT(GETDATE()),
	data_devolucao DATE,
	valor DECIMAL(7, 2) CHECK(valor > 0),
	PRIMARY KEY(dvdnum, cliente_num_cadastro),
	FOREIGN KEY(dvdnum) REFERENCES dvd(num),
	FOREIGN KEY(cliente_num_cadastro) REFERENCES cliente(num_cadastro),
	CONSTRAINT check_date CHECK(data_devolucao > data_locacao)
)
GO
CREATE TABLE estrela(
	id INT IDENTITY(9901, 1),
	nome VARCHAR(50)
	PRIMARY KEY(id)
)
GO
CREATE TABLE filme_estrela(
	filmeid INT,
	estrelaid INT,
	PRIMARY KEY(filmeid, estrelaid),
	FOREIGN KEY(filmeid) REFERENCES filme(id),
	FOREIGN KEY(estrelaid) REFERENCES estrela(id)
)

ALTER TABLE estrela ADD nome_real VARCHAR(50)

ALTER TABLE filme ALTER COLUMN titulo VARCHAR(80)

INSERT INTO filme VALUES ('Whiplash', 2015), 
('Birdman', 2015), ('Interestelar', 2014), ('A Culpa é das estrelas', 2014),
('Alexandre e o Dia Terrível, Horrível,Espantoso e Horroros',2014), ('Sing', 2016)

INSERT INTO estrela VALUES ('Michael Keaton', 'Michael John Douglas'),
('Emma Stone', 'Emily Jean Stone'), ('Miles Teller', NULL), ('Steve Carell Steven', 'John Carell'),
('Jennifer Garner', 'Jennifer Anne Garner')

INSERT INTO filme_estrela VALUES (1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)

INSERT INTO dvd VALUES ('2020-12-02', 1001),
('2019-10-18', 1002),
('2020-04-03', 1003),
('2020-12-02', 1001),
('2019-10-18', 1004),
('2020-04-03', 1002),
('2020-12-02', 1005),
('2019-10-18', 1002),
('2020-04-03', 1003)

INSERT INTO cliente VALUES 
('Matilde Luz', 'Rua Síria',150, '03086040'),
('Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110'),
('Daniel Ramalho', 'Rua Itajutiba', 169, '08411150'),
('Roberta Bento', 'Rua Jayme Von Rosenburg', 36, '02918190'),
('Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')

INSERT INTO locacao VALUES 
(10001, 5502, '2021-02-18', '2021-02-21', 3.50),
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20', '2021-02-23', 3.00),
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)

SELECT titulo FROM filme WHERE ano = 2014;

SELECT id, ano FROM filme WHERE titulo = 'Birdman'

SELECT id, ano FROM filme WHERE titulo LIKE '%plash'

SELECT id, nome, nome_real FROM estrela WHERE nome LIKE 'Steve%'

SELECT (SELECT data_fabricacao AS '@date') AS 'data', filmeid FROM dvd WHERE data_fabricacao > '01-01-2020'

SELECT dvdnum, data_locacao, data_devolucao, valor, 
(valor * 1.20) AS 'multa' FROM locacao
WHERE cliente_num_cadastro = 5505

SELECT logradouro, num, cep FROM cliente WHERE nome = 'Matilde Luz'

SELECT nome_real FROM estrela WHERE nome = 'Michael Keaton'

SELECT num_cadastro, nome, 
(SELECT logradouro + ', ' +  CAST(num AS VARCHAR) + ', ' +  cep) AS 'end_comp' FROM cliente
WHERE num_cadastro >= 5503


