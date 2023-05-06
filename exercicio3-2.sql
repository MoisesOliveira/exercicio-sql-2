CREATE DATABASE cinema
GO
USE cinema
GO
CREATE TABLE filme(
	id INT NOT NULL IDENTITY(1001,1),
	titulo VARCHAR(40) NOT NULL,
	ano INTEGER NULL CHECK(ano <= 2021),
	PRIMARY KEY(id)
)
GO
CREATE TABLE dvd(
	num INTEGER NOT NULL IDENTITY(10001, 1),
	data_fabricacao DATE CHECK(data_fabricacao < GETDATE()) NOT NULL,
	filmeid INT NOT NULL,
	PRIMARY KEY(num),
	FOREIGN KEY(filmeid) REFERENCES filme(id)
)
GO
CREATE TABLE cliente(
	num_cadastro INT NOT NULL CHECK(num_cadastro >= 0) IDENTITY(5501, 1),
	nome VARCHAR(70) NOT NULL,
	logradouro VARCHAR(150) NOT NULL,
	num INT NOT NULL,
	cep CHAR(8) CHECK(LEN(cep) = 8),
	PRIMARY KEY(num_cadastro)
)
GO
CREATE TABLE locacao(
	DVDnum INT NOT NULL ,
	cliente_num_cadastro INT NOT NULL,
	data_locacao DATE DEFAULT(GETDATE()) NOT NULL,
	data_devolucacao DATE NOT NULL,
	valor DECIMAL(7,2) NOT NULL,
	PRIMARY KEY(DVDnum, cliente_num_cadastro, data_devolucacao),
	FOREIGN KEY(DVDnum) REFERENCES dvd(num),
	FOREIGN KEY(cliente_num_cadastro) REFERENCES cliente(num_cadastro),
	CONSTRAINT check_data_dev CHECK(data_devolucacao > data_locacao)
)
GO
CREATE TABLE estrela(
	id INT NOT NULL IDENTITY(9901,1),
	nome VARCHAR(50) NOT NULL
	PRIMARY KEY(id)
)
GO
CREATE TABLE filme_estrela(
	filmeid INT ,
	estrelaid INT,
	PRIMARY KEY(filmeid, estrelaid),
	FOREIGN KEY(filmeid) REFERENCES filme(id),
	FOREIGN KEY(estrelaid) REFERENCES estrela(id)
)
GO
ALTER TABLE estrela ADD nome_real VARCHAR(50)
GO
ALTER TABLE filme ALTER COLUMN titulo VARCHAR(80)
GO
INSERT INTO filme VALUES 
('Whiplash', 2015),
('Birdman', 2015),
('Interestelar', 2014),
('A culpa é das estrelas', 2014),
('Alexandre e o Dia Terrível, Horrível,
Espantoso e Horroroso', 2014),
('Sing', 2016)
GO
INSERT INTO estrela VAlUES
('Michael Keaton', 'Michael John Douglas'),
('Emma Stone', 'Emily Jean Stone'),
('Miles Teller', NULL),
('Steve Carell', 'Steven John Carell'),
('Jennifer Garner', 'Jennifer Anne Garner')
GO
INSERT INTO filme_estrela VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)
GO
INSERT INTO dvd(data_fabricacao, filmeid) VALUES
('2020-12-02', 1001),
('2019-10-18', 1002),
('2020-04-03', 1003),
('2020-12-02', 1001),
('2019-10-18', 1004),
('2020-04-03', 1002),
('2020-12-02', 1005),
('2019-10-18', 1002),
('2020-04-03', 1003)
GO
INSERT INTO cliente VALUES
('Matilde Luz', 'Rua Síria', 150, '03086040'),
('Carlos Carreiro','Rua Bartolomeu Aires', 1250, '04419110'),
('Daniel Ramalho', 'Rua Itajutiba', 169, NULL),
('Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
('Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')
GO
INSERT INTO locacao VALUES
(10001, 5502, '2021-02-18',  '2021-02-21', 3.50),
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20',  '2021-02-23', 3.00),
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)
GO
UPDATE cliente SET cep = '08411150' WHERE num_cadastro = '5503'
GO
UPDATE cliente SET cep = '02918190' WHERE num_cadastro = '5504'
GO
UPDATE locacao SET valor = 3.25 WHERE data_locacao = '2021-02-18' AND cliente_num_cadastro = 5502
GO
UPDATE locacao SET valor = 3.10 WHERE data_locacao = '2021-02-24' AND cliente_num_cadastro = 5501
GO
UPDATE dvd SET data_fabricacao = '2019-07-14' WHERE num = 10005
GO
UPDATE estrela SET nome_real = 'Miles Alexander Teller' WHERE nome = 'Miles Teller'
GO
DELETE FROM filme WHERE titulo = 'Sing'
GO
SELECT id, ano, titulo FROM filme WHERE id IN
(SELECT filmeid FROM dvd WHERE data_fabricacao > '2020-01-01')
GO
SELECT num, data_fabricacao, DATEDIFF(MONTH, data_fabricacao, GETDATE()) 
AS 'qtde_meses_desde_fabricacao' FROM dvd
WHERE filmeid IN (SELECT id FROM filme WHERE titulo = 'Interestelar')
GO
SELECT DVDnum, data_locacao, data_devolucacao, 
DATEDIFF(DAY, data_locacao, data_devolucacao) AS 'Dias alugados',
DATEDIFF(DAY, data_locacao, data_devolucacao) * valor AS 'Valor da locação'
FROM locacao WHERE cliente_num_cadastro 
IN (SELECT num_cadastro FROM cliente WHERE nome LIKE '%Rosa%')
GO
SELECT nome, logradouro + ', ' + CAST(num AS VARCHAR) + ',  ' + 
SUBSTRING(cep, 1, 4) + '-' + SUBSTRING(cep, 4, 8) AS 'Endereço completo'
FROM cliente WHERE num_cadastro IN (SELECT cliente_num_cadastro FROM locacao WHERE DVDnum = 10002)