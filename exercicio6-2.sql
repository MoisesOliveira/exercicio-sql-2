CREATE DATABASE exjoin4
GO
USE exjoin4
GO
CREATE TABLE Filme(
	id INT IDENTITY(1001,1),
	titulo VARCHAR(40),
	ano INT CHECK(ano <= 2021) NULL,
	PRIMARY KEY(id)
	)
GO
CREATE TABLE Cliente(
	num_cadastro INT IDENTITY(5501,1),
	nome VARCHAR(70),
	logradouro VARCHAR(150),
	num INT CHECK(num >= 0),
	cep CHAR(8) CHECK(LEN(cep) = 8) NULL,
	PRIMARY KEY(num_cadastro)
	)
GO
CREATE TABLE DVD(
	num INT IDENTITY(10001,1),
	data_fabricacao DATE,
	filmeid INT,
	PRIMARY KEY(num),
	FOREIGN KEY(filmeid) REFERENCES Filme(id)
	)
GO
CREATE TABLE Locacao(
	dvdnum INT,
	cliente_num_cadastro INT,
	data_locacao DATE DEFAULT(GETDATE()),
	data_devolucao DATE,
	valor DECIMAL(7,2),
	PRIMARY KEY(dvdnum,cliente_num_cadastro, data_locacao),
	FOREIGN KEY(dvdnum) REFERENCES DVD(num),
	FOREIGN KEY(cliente_num_cadastro) REFERENCES cliente(num_cadastro)
	)
GO
CREATE TABLE Estrela(
	id INT IDENTITY(9901,1),
	nome VARCHAR(50)
	PRIMARY KEY(id)
)
GO
CREATE TABLE Filme_Estrela(
	filmeid INT,
	estrelaid INT,
	PRIMARY KEY(filmeid, estrelaid),
	FOREIGN KEY(filmeid) REFERENCES Filme(id),
	FOREIGN KEY(estrelaid) REFERENCES Estrela(id)
)

ALTER TABLE estrela ADD nomereal VARCHAR(50)

ALTER TABLE Filme ALTER COLUMN titulo VARCHAR(80)

INSERT INTO Filme VALUES 
('Whiplash', 2015),
('Birdman', 2015),
('Interestelar', 2014),
('A culpa é das estrelas', 2014),
('Alexandre e o Dia Terrível, Horrível,
Espantoso e Horroroso', 2014),
('Sing', 2016)
GO
INSERT INTO Estrela VAlUES
('Michael Keaton', 'Michael John Douglas'),
('Emma Stone', 'Emily Jean Stone'),
('Miles Teller', NULL),
('Steve Carell', 'Steven John Carell'),
('Jennifer Garner', 'Jennifer Anne Garner')
GO
INSERT INTO Filme_Estrela VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)
GO
INSERT INTO DVD(data_fabricacao, filmeid) VALUES
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
INSERT INTO Cliente VALUES
('Matilde Luz', 'Rua Síria', 150, '03086040'),
('Carlos Carreiro','Rua Bartolomeu Aires', 1250, '04419110'),
('Daniel Ramalho', 'Rua Itajutiba', 169, NULL),
('Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
('Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')
GO
INSERT INTO Locacao VALUES
(10001, 5502, '2021-02-18',  '2021-02-21', 3.50),
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20',  '2021-02-23', 3.00),
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)

UPDATE Cliente SET cep = '08411150' WHERE num_cadastro = 5503

UPDATE Cliente SET cep = '02918190' WHERE num_cadastro = 5504

UPDATE Locacao SET valor = 3.25 WHERE data_locacao = '2021-02-18' AND cliente_num_cadastro = 5502

UPDATE Locacao SET valor = 3.10 WHERE data_locacao = '2021-02-24' AND cliente_num_cadastro = 5501

UPDATE DVD SET data_fabricacao = '2019-07-14' WHERE num = 10005

UPDATE Estrela SET nomereal = 'Miles Alexander Teller' WHERE nome LIKE '%Miles%'

DELETE FROM Filme WHERE titulo = 'Sing'

SELECT Cliente.num_cadastro, Cliente.nome, Filme.titulo,DVD.data_fabricacao FROM DVD,
Cliente, Filme, Locacao WHERE
Cliente.num_cadastro = Locacao.cliente_num_cadastro AND
DVD.num = Locacao.dvdnum AND DVD.filmeid = Filme.id AND
DVD.data_fabricacao IN (SELECT MIN(dvd.data_fabricacao) FROM DVD)

SELECT Cliente.num_cadastro, Cliente.nome, COUNT(DVD.data_fabricacao) FROM DVD,
Cliente, Filme, Locacao WHERE
Cliente.num_cadastro = Locacao.cliente_num_cadastro AND
DVD.num = Locacao.dvdnum AND DVD.filmeid = Filme.id
GROUP BY Cliente.num_cadastro, Cliente.nome

SELECT Cliente.num_cadastro, Cliente.nome, SUM(Locacao.valor) FROM DVD,
Cliente, Filme, Locacao WHERE
Cliente.num_cadastro = Locacao.cliente_num_cadastro AND
DVD.num = Locacao.dvdnum AND DVD.filmeid = Filme.id
GROUP BY Cliente.num_cadastro, Cliente.nome



SELECT Cliente.num_cadastro, Cliente.nome, FORMAT(Locacao.data_locacao, 'dd/MM/yyyy') FROM DVD,
Cliente, Filme, Locacao WHERE
Cliente.num_cadastro = Locacao.cliente_num_cadastro AND
DVD.num = Locacao.dvdnum AND DVD.filmeid = Filme.id
GROUP BY Cliente.num_cadastro, Cliente.nome, Locacao.data_locacao HAVING COUNT(Locacao.dvdnum) > 1

