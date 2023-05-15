CREATE DATABASE exjoin2
GO
USE exjoin2
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
	dvdnum INT IDENTITY(10001,1),
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

SELECT * FROM Filme

UPDATE Cliente SET cep = '08411150' WHERE num_cadastro = 5503

UPDATE Cliente SET cep = '02918190' WHERE num_cadastro = 5504

UPDATE Locacao SET valor = 3.25 WHERE data_locacao = '2021-02-18' AND cliente_num_cadastro = 5502

UPDATE Locacao SET valor = 3.10 WHERE data_locacao = '2021-02-24' AND cliente_num_cadastro = 5501

UPDATE DVD SET data_fabricacao = '2019-07-14' WHERE num = 10005

SELECT * FROM Estrela

UPDATE Estrela SET nomereal = 'Miles Alexander Teller' WHERE nome LIKE '%Miles%'

DELETE FROM Filme WHERE titulo = 'Sing'

SELECT Cliente.num_cadastro, Cliente.nome, FORMAT(Locacao.data_locacao, 'dd/MM/yyyy') AS 'Data de Locação',
DATEDIFF(DAY, Locacao.data_locacao, Locacao.data_devolucao) AS 'Qtd. de dias alugados',
Filme.titulo, Filme.ano
FROM Cliente, Locacao, Filme, DVD WHERE
Cliente.num_cadastro = Locacao.cliente_num_cadastro 
AND DVD.num = Locacao.dvdnum
AND Filme.id = DVD.filmeid AND Cliente.nome LIKE '%Matilde%'

SELECT Estrela.nome, Estrela.nomereal, Filme.titulo FROM Estrela, Filme_Estrela, Filme
WHERE Estrela.id = Filme_Estrela.estrelaid AND Filme.id = Filme_Estrela.filmeid

SELECT Filme.titulo, FORMAT(DVD.data_fabricacao, 'dd/MM/yyyy'),
CASE WHEN DATEDIFF(YEAR, DVD.data_fabricacao, GETDATE()) > 6 THEN CONVERT(VARCHAR, DATEDIFF(YEAR, DVD.data_fabricacao, GETDATE())) + 'anos'
ELSE CAST(DATEDIFF(YEAR, DVD.data_fabricacao, GETDATE()) AS VARCHAR) END AS 'Diferença de anos'
FROM Filme, DVD