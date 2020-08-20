--Bem vindos ao trabalho!

--Script DDL	

--Criação e uso do Banco de Dados
CREATE DATABASE Lovelace_Central_de_Livros

USE Lovelace_Central_de_Livros

--Criação de tabelas

--Criação da tabela Genero, juntamente com suas respectivas colunas
CREATE TABLE Genero (
	ID_Genero INT PRIMARY KEY NOT NULL IDENTITY,
	Nome_Genero VARCHAR(20) NOT NULL
);

--Criação da tabela Editora, juntamente com suas respectivas colunas
CREATE TABLE Editora (
	ID_Editora INT PRIMARY KEY NOT NULL IDENTITY,
	Nome_Editora VARCHAR(40) NOT NULL,
	Nacionalidade VARCHAR(20) NOT NULL
);	

--Criação da tabela Livraria, juntamente com suas respectivas colunas
CREATE TABLE Livraria (
	ID_Livraria INT PRIMARY KEY NOT NULL IDENTITY,
	Nome_Livraria VARCHAR(40) NOT NULL,
	Email VARCHAR(40) UNIQUE
);

--Criação da tabela Ilustrador, juntamente com suas respectivas colunas
CREATE TABLE Ilustrador(
	ID_Ilustrador INT PRIMARY KEY NOT NULL IDENTITY,
	Nome_Ilustrador VARCHAR(20) NOT NULL,
	Sobrenome_Ilustrador VARCHAR(40) NOT NULL,
	Nacionalidade VARCHAR(20) NOT NULL,
	Sexo CHAR(1) NULL,
	Data_Nascimento DATE NOT NULL
);

--Criação da tabela Autor, juntamente com suas respectivas colunas
CREATE TABLE Autor (
	ID_Autor INT PRIMARY KEY NOT NULL IDENTITY,
	Nome_Autor VARCHAR(20) NOT NULL,
	Sobrenome_Autor VARCHAR(40) NOT NULL,
	Nacionalidade VARCHAR(20) NOT NULL,
	Sexo CHAR(1) NULL,
	Data_Nascimento DATE NOT NULL
);

--Criação da tabela Publico_Alvo, juntamente com suas respectivas colunas
CREATE TABLE Publico_Alvo (
	ID_Publico_Alvo INT PRIMARY KEY NOT NULL IDENTITY,
	Tipo_Publico_Alvo VARCHAR(20) NOT NULL
);

--Criação da tabela Livro, juntamente com suas respectivas colunas	
CREATE TABLE Livro(
	ID_Livro INT PRIMARY KEY IDENTITY NOT NULL,
	ID_Editora INT NOT NULL,
	Titulo_Livro VARCHAR(20) NOT NULL,
	Subititulo_Livro VARCHAR(40)NULL,
	Edicao CHAR(3) NOT NULL,
	Numero_Paginas INT NOT NULL,
	Data_Publicacao DATE NOT NULL,
	CONSTRAINT FK_Editora_Livro FOREIGN KEY (ID_Editora) REFERENCES Editora (ID_Editora)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela Editor, juntamente com suas respectivas colunas
CREATE TABLE Editor(
	ID_Editor INT PRIMARY KEY NOT NULL IDENTITY,
	ID_Editora INT NOT NULL,
	Nome_Editor VARCHAR(20) NOT NULL,
	Sobrenome_Editor VARCHAR(40) NOT NULL,
	Nacionalidade VARCHAR(20) NOT NULL,
	Sexo CHAR(1) NULL,
	Data_Nascimento DATE NOT NULL,
	CONSTRAINT FK_Editora_Editor FOREIGN KEY (ID_Editora) REFERENCES Editora (ID_Editora)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela Tipo_Telefone, juntamente com suas respectivas colunas
CREATE TABLE Tipo_Telefone(
	ID_Tipo_Telefone INT PRIMARY KEY IDENTITY NOT NULL,
	Tipo_Telefone VARCHAR(20) NOT NULL
);

--Criação da tabela associativa Telefones_Livraria, juntamente com suas respectivas colunas
CREATE TABLE Telefones_Livraria(
	ID_Telefone_Livraria INT PRIMARY KEY NOT NULL IDENTITY,
	ID_Livraria INT NOT NULL,
	ID_Tipo_Telefone INT NOT NULL,
	Numero_Telefone VARCHAR(11) NOT NULL,
	CONSTRAINT FK_TipoTel_TL FOREIGN KEY(ID_Tipo_Telefone) REFERENCES Tipo_Telefone(ID_Tipo_Telefone) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Livraria_TL FOREIGN KEY(ID_Livraria) REFERENCES Livraria(ID_Livraria)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela Tipo_Endereco, juntamente com suas respectivas colunas
CREATE TABLE Tipo_Endereco(
	ID_Tipo_Endereco INT PRIMARY KEY IDENTITY NOT NULL,
	Tipo_Endereco VARCHAR(40) NOT NULL
);

--Criação da tabela associativa Endereco_Livraria, juntamente com suas respectivas colunas
CREATE TABLE Endereco_Livraria(
	ID_Endereco_Livraria INT PRIMARY KEY NOT NULL IDENTITY,
	ID_Livraria INT NOT NULL,
	ID_Tipo_Endereco INT NOT NULL,
	Cidade VARCHAR(40)NULL,
	Nome_Rua VARCHAR(40)NULL,
	Num_Lugar VARCHAR(8)NULL,
	CEP VARCHAR(20) NULL,
	CONSTRAINT FK_IDLI_EnderecoLI FOREIGN KEY (ID_Livraria) REFERENCES Livraria(ID_Livraria),
	CONSTRAINT FK_IDEND_EnderecoLI FOREIGN KEY (ID_Tipo_Endereco) REFERENCES Tipo_Endereco(ID_Tipo_Endereco)
);

--Criação da tabela associativa Livro_Publico_alvo, juntamente com suas respectivas colunas
CREATE TABLE Livro_Publico_Alvo(
	ID_Livro INT NOT NULL,
	ID_Publico_Alvo INT NOT NULL,
	PRIMARY KEY(ID_Livro, ID_Publico_Alvo),
	CONSTRAINT FK_Livro_LPA FOREIGN KEY(ID_Livro) REFERENCES Livro(ID_Livro) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Publico_LPA FOREIGN KEY(ID_Publico_Alvo) REFERENCES Publico_Alvo(ID_Publico_Alvo)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Ilustrador_Livro, juntamente com suas respectivas colunas
CREATE TABLE Ilustrador_Livro(
	ID_Livro INT NOT NULL,
	ID_Ilustrador INT NOT NULL,
	PRIMARY KEY(ID_Livro, ID_Ilustrador),
	CONSTRAINT FK_Livro_LI FOREIGN KEY(ID_Livro) REFERENCES Livro(ID_Livro) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Ilustrador_LI FOREIGN KEY(ID_Ilustrador) REFERENCES Ilustrador(ID_Ilustrador)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Autor_Livro, juntamente com suas respectivas colunas
CREATE TABLE Autor_Livro(
	ID_Autor INT NOT NULL,
	ID_Livro INT NOT NULL,
	PRIMARY KEY(ID_Livro, ID_Autor),
	CONSTRAINT FK_Livro_AL FOREIGN KEY(ID_Livro) REFERENCES Livro(ID_Livro) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Autor_AL FOREIGN KEY(ID_Autor) REFERENCES Autor(ID_Autor)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Livro_Genero, juntamente com suas respectivas colunas
CREATE TABLE Livro_Genero(
	ID_Livro INT NOT NULL,
	ID_Genero INT NOT NULL,
	PRIMARY KEY(ID_Livro, ID_Genero),
	CONSTRAINT FK_Livro_LG FOREIGN KEY(ID_Livro) REFERENCES Livro(ID_Livro) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Genero_LG FOREIGN KEY(ID_Genero) REFERENCES Genero(ID_Genero)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Editor_Livro, juntamente com suas respectivas colunas
CREATE TABLE Editor_Livro(
	ID_Editor INT NOT NULL,
	ID_Livro INT NOT NULL,
	PRIMARY KEY(ID_Livro, ID_Editor),
	CONSTRAINT FK_Livro_EL FOREIGN KEY(ID_Livro) REFERENCES Livro(ID_Livro) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Editor_EL FOREIGN KEY(ID_Editor) REFERENCES Editor(ID_Editor)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
);

--Criação da tabela associativa Autor_Ilustrador, juntamente com suas respectivas colunas
CREATE TABLE Autor_Ilustrador(
	ID_Autor INT NOT NULL,
	ID_Ilustrador INT NOT NULL,
	PRIMARY KEY(ID_Ilustrador, ID_Autor),
	CONSTRAINT FK_Ilustrador_AI FOREIGN KEY(ID_Ilustrador) REFERENCES Ilustrador(ID_Ilustrador) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Autor_AI FOREIGN KEY(ID_Autor) REFERENCES Autor(ID_Autor)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Autor_Editor, juntamente com suas respectivas colunas
CREATE TABLE Autor_Editor(
	ID_Autor INT NOT NULL,
	ID_Editor INT NOT NULL,
	PRIMARY KEY(ID_Editor, ID_Autor),
	CONSTRAINT FK_Editor_AE FOREIGN KEY(ID_Editor) REFERENCES Editor(ID_Editor) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Autor_AE FOREIGN KEY(ID_Autor) REFERENCES Autor(ID_Autor)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Autor_Genero, juntamente com suas respectivas colunas
CREATE TABLE Autor_Genero(
	ID_Autor INT NOT NULL,
	ID_Genero INT NOT NULL,
	PRIMARY KEY(ID_Genero, ID_Autor),
	CONSTRAINT FK_Genero_AG FOREIGN KEY(ID_Genero) REFERENCES Genero(ID_Genero) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Autor_AG FOREIGN KEY(ID_Autor) REFERENCES Autor(ID_Autor)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);	

--Criação da tabela associativa Ilustrador_Editora, juntamente com suas respectivas colunas
CREATE TABLE Ilustrador_Editora(
	ID_Ilustrador INT NOT NULL,
	ID_Editora INT NOT NULL,
	PRIMARY KEY(ID_Ilustrador, ID_Editora),
	CONSTRAINT FK_Ilustrador_IE FOREIGN KEY(ID_Ilustrador) REFERENCES Ilustrador(ID_Ilustrador) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Editora_IE FOREIGN KEY(ID_Editora) REFERENCES Editora(ID_Editora)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Autor_Editora, juntamente com suas respectivas colunas
CREATE TABLE Autor_Editora(
	ID_Autor INT NOT NULL,
	ID_Editora INT NOT NULL,
	PRIMARY KEY(ID_Editora, ID_Autor),
	CONSTRAINT FK_Editora_AED FOREIGN KEY(ID_Editora) REFERENCES Editora(ID_Editora) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Autor_AED FOREIGN KEY(ID_Autor) REFERENCES Autor(ID_Autor)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Genero_Editora, juntamente com suas respectivas colunas
CREATE TABLE Genero_Editora(
	ID_Genero INT NOT NULL,
	ID_Editora INT NOT NULL,
	PRIMARY KEY(ID_Genero, ID_Editora),
	CONSTRAINT FK_Genero_GED FOREIGN KEY(ID_Genero) REFERENCES Genero(ID_Genero) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Editora_GED FOREIGN KEY(ID_Editora) REFERENCES Editora(ID_Editora)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Genero_Livraria, juntamente com suas respectivas colunas
CREATE TABLE Genero_Livraria(
	ID_Genero INT NOT NULL,
	ID_Livraria INT NOT NULL,
	PRIMARY KEY(ID_Genero, ID_Livraria),
	CONSTRAINT FK_Genero_GLI FOREIGN KEY(ID_Genero) REFERENCES Genero(ID_Genero) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Livraria_GLI FOREIGN KEY(ID_Livraria) REFERENCES Livraria(ID_Livraria)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Editora_Livraria, juntamente com suas respectivas colunas
CREATE TABLE Editora_Livraria(
	ID_Editora INT NOT NULL,
	ID_Livraria INT NOT NULL,
	PRIMARY KEY(ID_Livraria, ID_Editora),
	CONSTRAINT FK_Livraria_ELI FOREIGN KEY(ID_Livraria) REFERENCES Livraria(ID_Livraria) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Editora_ELI FOREIGN KEY(ID_Editora) REFERENCES Editora(ID_Editora)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Autor_Livraria, juntamente com suas respectivas colunas
CREATE TABLE Autor_Livraria(
	ID_Autor INT NOT NULL,
	ID_Livraria INT NOT NULL,
	PRIMARY KEY(ID_Livraria, ID_Autor),
	CONSTRAINT FK_Livraria_ALI FOREIGN KEY(ID_Livraria) REFERENCES Livraria(ID_Livraria) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Autor_ALI FOREIGN KEY(ID_Autor) REFERENCES Autor(ID_Autor)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Ilustrador_Livraria, juntamente com suas respectivas colunas
CREATE TABLE Ilustrador_Livraria(
	ID_Ilustrador INT NOT NULL,
	ID_Livraria INT NOT NULL,
	PRIMARY KEY(ID_Ilustrador, ID_Livraria),
	CONSTRAINT FK_Ilustrador_ILI FOREIGN KEY(ID_Ilustrador) REFERENCES Ilustrador(ID_Ilustrador) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Livraria_ILI FOREIGN KEY(ID_Livraria) REFERENCES Livraria(ID_Livraria)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Livraria_Livro, juntamente com suas respectivas colunas
CREATE TABLE Livraria_Livro(
	ID_Livraria INT NOT NULL,
	ID_Livro INT NOT NULL,
	PRIMARY KEY(ID_Livraria, ID_Livro),
	CONSTRAINT FK_Livraria_LL FOREIGN KEY(ID_Livraria) REFERENCES Livraria(ID_Livraria) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Livro_LL FOREIGN KEY(ID_Livro) REFERENCES Livro(ID_Livro)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Criação da tabela associativa Editor_Livraria, juntamente com suas respectivas colunas
CREATE TABLE Editor_Livraria(
	ID_Livraria INT NOT NULL,
	ID_Editor INT NOT NULL,
	PRIMARY KEY(ID_Editor, ID_Livraria),
	CONSTRAINT FK_Editor_AEE FOREIGN KEY(ID_Editor) REFERENCES Editor(ID_Editor) 
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CONSTRAINT FK_Livraria_AEE FOREIGN KEY(ID_Livraria) REFERENCES Livraria(ID_Livraria)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

--Script DML 

--Seção de inserções de dados nas tabelas

--Inserção de dados na tabela Gênero
insert into Genero (Nome_Genero)values
('Novela'),
('Literatura'),
('Poesia'),
('Horror'),
('Biografia'),
('Romance'),
('Romance Biográfico'),
('Romance Histórico'),
('Aventura'),
('Ficção Científica'),
('Conto'),
('Saúde e Família'),
('Auto Ajuda'),
('Fantasia'),
('Graphic Novels'),
('Suspense'),
('Financas')

--Inserção de dados na tabela Editora
insert into Editora (Nome_Editora, Nacionalidade) values
('Roco', 'Britânica'),
('Editora Arqueiro', 'Brasileira'),
('Única','Brasileira'),
('HarperCollins','Brasileira'),
('Alta Books', 'Brasileira'),
('Intrínseca','Brasileira'),
('Darkside','Brasileira'),
('Panini','Brasileira'),
('BestSeller','Brasileira'),
('Jambô','Americana'),
('Gente','Britânica')

--Inserção de dados na tabela Livraria
insert into Livraria(Nome_Livraria, Email)values  
('Livraria Cultura', 'livrariacultura@gmail.com'),
('Livraria da Vila', 'LivrariaVila@yahoo.com.br'),
('Livraria Nobel', 'nobellivrarias@gmail.com'),
('Livraria Disal', 'livradisa@quelemail.com'),
('Livraria Loyola','lolylivros@gmail.com'),
('Livraria NoveSete','Seven@gmail.com')

--Inserção de dados na tabela Ilustrador
insert into Ilustrador (Nome_Ilustrador,Sobrenome_Ilustrador,Nacionalidade,Sexo,Data_Nascimento) values
('Mary','Grand Pré','Americana','F','13/02/1954'),
('Norman','Percevel Rockwell', 'Americano','M','03/02/1894'),
('Howard','Pyle','Americano','M','05/03/1853'),
('Newel', 'Convers Wyeth','Britânico','M','22/07/1882'),
('Maxfield', 'Parrish', 'Irlandês', 'M', '25/06/1870'),
('Joseph', 'Christian Leyendecker','Americano', 'M','23/03/1874'),
('Edward','Jeffrey Ardizzone', 'Português','M','16/09/1900'),
( 'John','Vernon Lord','Britânico','M','09/04/1939'),
('Catherine',	'Greenaway',	'Britânica',	'F',	'17/03/1846'),
('Pauline', 'Diana Baynes',	'Britânica',	'F',	'09/07/1922'),
('Roald', 	'Dahl', 	'Britânico',	'M',	'13/07/1916'),
('Michael'	,'Foreman',	'Alemão',	'M',	'21/03/1987'),
('Sophia', 'Maria Westendorp',	'Alemã',	'F',	'17/12/1916'),
('Fiel' ,'van der Veen',	'Alemão',	'M'	,'18/02/1945'),
('Marie', 'Rie Cramer',	'Alemã',	'F',	'10/09/1887')

--Inserção de dados na tabela Autor
insert into Autor (Nome_Autor,Sobrenome_Autor,Nacionalidade,Sexo,Data_Nascimento) values
('Joanne',	'Rowling','Britânica','F','27/06/1965'),
('Lucinda' 	,'Riley',	'Irlandêsa',	'F',	'27/03/1966'),
('Louise',	'Jensen'	,'Britânica',	'F'	,'22/07/1964'),
('Thiago',	'Nigro'	,'Brasileiro',	'M',	'07/10/1990'),
('Robert' ,'Toru Kiyosaki',	'Havaiano',	'M',	'08/04/1947'),
('Caroline',	'Tudor',	'Britânica'	,'F'	,'15/03/1972'),
('John' ,'Robert Fowles',	'Britânico',	'M',	'31/03/1926'),
('Charles', 'Lutwidge Dodgson',	'Britânico',	'M',	'21/01/1832'),
('Kazuo'	,'Koike',	'Japonês',	'M'	,'08/05/1936'),
('Sadamitsu'	,'Fujita',	'Americano',	'M',	'16/05/1921'),
('Hal',	'Elrod',	'Americano',	'M',	'30/05/1979'),
('Margaret', 'Eleanor Atwood',	'Canadense',	'F',	'18/11/1939'),
('Neil' ,'Richard MacKinnon Gaiman',	'Britânico',	'M',	'10/11/1960'),
('Athos' ,	'Beuren',	'Brasileiro',	'M',	'22/03/1986'),
('Paulo'	,'Vieira',	'Brasileiro',	'M'	,'30/03/1994')

--Inserção de dados na tabela Publico_Alvo
insert into Publico_Alvo(Tipo_Publico_Alvo) values
('Generalizado'),
('Juvenil'),
('Adulto'),
('Infantil'),
('Terceira idade')

--Inserção de dados na tabela Livros
insert into Livro(ID_Editora,Titulo_Livro,Subititulo_Livro,Edicao,Numero_Paginas,Data_Publicacao) values
(2,'A carta secreta', 'Uma letra, um fim','1ª', 480	,'11/03/2019'),
(3,'A irmã','Progênita','1ª',304,'01/07/2017'),
(4,'Do Mil ao Milhão','Não é sobre milharais','1ª',192,'10/09/2018'),
(5,'Pai Rico, pai Pobre','Bisavô rico','1ª',336,'26/06/2017'),
(1,'Harry Potter', 'E a pedra filosofal','1ª',208,'19/03/2017'),
(6,'O Homem de Giz', 'Nada de lousas','1ª',272,'15/03/2018'),
(7,'O Colecionador','Brubuleta','1ª',256,'12/04/2018'),
(7,'Alice','No País das Maravilhas','1ª',224,'04/08/2019'),
(8,'Novo Lobo Solitário','Lobitos','10ª',232,'04/09/2018'),
(8,'Wotakoi','O Amor É Dificíl Para Otakus','3ª',128,'07/04/2019'),
(9,'O milagre da manhã','Deus existe','53ª',196,'19/06/2016'),
(1,'O Conto de Aia','Red maiden','1ª',368,'07/07/2017'),
(6,'Deuses Americano', 'Gods','1ª',576,'29/09/2016'),
(10,'O Senhor das Sombras','Forbiden','1ª',256,'01/09/2016'),
(11,'O poder da ação ','Para crianças','6ª',96,'30/05/2018'),
(7,'Lovelace','O Futuro da Inteligência Artificial','1ª',274,'27/06/2001')

--Inserção de dados na tabela Editor
insert into Editor(ID_Editora,Nome_Editor,Sobrenome_Editor,Nacionalidade,Sexo,Data_Nascimento) values
(1,'Marilyn', 'Lorraine Abbey',	'Americana',	'F',	'18/07/1948'),
(2,'Cyrus',	'Adler',	'Americano'	,'M'	,'13/07/1863'),
(3,'Richard',	'Erdoes',	'Americano'	,'M',	'07/06/1912'),
(4,'Dave', 	'Eggers'	,'Americano',	'M',	'12/03/1970'),
(5,'Eleanor',	'Friede',	'Americano',	'F',	'30/03/1994'),
(6,'Leonard', 'Woolsey Bacon',	'Britânico',	'M'	,'01/01/1830'),
(7,'James', 'Patrick Baen',	'Britânico',	'M',	'22/09/1943'),
(7,'Henry', 'Gardiner Adams',	'Britânico',	'M',	'23/07/1987'),
(8,'Anna' ,'Laetitia Barbauld',	'Britânico',	'M'	,'20/06/1997'),
(8,'Samuel',	'Bentley'	,'Britânico',	'M'	,'10/05/1985'),
(9,'Thomas' ,'Humphry Ward' ,	'Britânico',	'M',	'06/05/1926'),
(1,'Bertie', 'Maurice van Thal'	,'Britânico',	'M',	'25/04/1904'),
(6,'Baron', 'Barrymore Halpenny'	,'Britânico',	'M',	'17/02/1964'),
(10,'Hugo', 'Nelson	Tyerman',	'Britânico',	'M' ,'07/07/1977'),
(11,'Neil',	'Taylor',	'Britânico',	'M'	,'05/09/1959')

--Inserção de dados na tabela Tipo_Telefone
insert into Tipo_Telefone(Tipo_Telefone) values
('Comercial'),
('Atendimento'),
('Negócios'),
('Resolução problemas')

--Inserção de dados na tabela associativa Telefones_Livraria
insert into Telefones_Livraria(ID_Livraria,ID_Tipo_Telefone,Numero_Telefone) values
(1,1,'1138685100'),
(1,3,'11953168221'),
(1,2,'999986987'),
(2,1,'1176468967'),
(2,2,'1956349765'),
(2,3,'1267543409'),
(2,4,'1175670327'),
(3,1,'1781368745'),
(3,2,'1125479365'),
(3,3,'1145203957'),
(3,4,'1139634632'),
(4,1,'1125802582'),
(4,2,'1115975328'),
(4,4,'1784265825'),
(5,1,'2254632587'),
(5,2,'1598753512'),
(5,3,'1564582854'),
(5,4,'1236987412'),
(6,1,'1453698725'),
(6,2,'1234567896'),
(6,3,'2369874585')

--Inserção de dados na tabela Tipo_Endereco
insert into Tipo_Endereco (Tipo_Endereco) values
('Loja de calçada'),
('Interior de Shopping'),
('Galeria'),
('Livraria Online')

--Inserção de dados na tabela associativa Endereco_Livraria

insert into Endereco_Livraria(ID_Livraria,ID_Tipo_Endereco,Cidade,Nome_Rua,Num_Lugar,CEP) values
(1,1,'Jundiaí','Santo Professor Nathan','676','13410705'),
(1,1,'São Paulo','Grande Professor Benedito','497','12345698'),
(1,1,'Campinas','Fodula','369','20369875'),
(1,2,'São Paulo','Mereguete Mireguen','845','75493087'),
(1,3,'São Bento da Rocha','Hurunahe','5865','12365874'),
(2,1,'Salvador','Rua Muito Ruada','5324','15987456'),
(2,2,'Porto Alegre','Abençoado Professor Télvio','5362','12036548'),
(2,2,'São Paulo','Peter Júnior Java','444','98756328'),
(2,3,'Ubatuba','Praiana','452','85236974'),
(3,1,'Jundiaí','Rua Fernando Lovelace','42','27062001'),
(3,2,'Campinas','Gerosival','719','78945612'),
(4,1,'Tocantins','General Gerson CdC','4517','35765408')

insert into Endereco_Livraria(ID_Livraria,ID_Tipo_Endereco ) values
(5,4),
(6,4)

--Inserção de dados na tabela associativa Livro_Publico_Alvo
insert into Livro_Publico_Alvo(ID_Livro, ID_Publico_Alvo) values
(1,2),
(1,3),
(2,2),
(2,3),
(3,2),
(3,3),
(4,2),
(4,3),
(5,2),
(6,2),
(7,2),
(8,4),
(9,2),
(9,3),
(10,4),
(11,2),
(12,4),
(13,2),
(14,2),
(15,3),
(15,4),
(16,2)

--Inserção de dados na tabela associativa Ilustrador_Livro
insert into Ilustrador_Livro(ID_Livro,ID_Ilustrador) values
(1,2),
(2,3),
(2,4),
(3,4),
(4,5),
(5,1),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,4),
(16,7)

--Inserção de dados na tabela associativa Autor_Livro
insert into Autor_Livro(ID_Livro,ID_Autor) values
(1,2),
(2,3),
(3,4),
(4,5),
(5,1),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,4),
(16,7)

--Inserção de dados na tabela associativa Livro_Genero
insert into Livro_Genero(ID_Livro,ID_Genero) values
(1,4),
(1,16),
(2,16),
(2,6),
(3,2),
(4,17),
(5,2),
(5,14),
(6,2),
(7,4),
(7,16),
(8,11),
(9,15),
(10,15),
(11,13),
(12,2),
(13,6),
(14,2),
(14,16),
(15,12),
(15,15),
(16,15),
(16,2)

--Inserção de dados na tabela associativa Editor_Livro
insert into Editor_Livro(ID_Livro,ID_Editor) values
(1,2),
(2,2),
(3,4),
(4,5),
(5,1),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,6),
(16,12)

--Inserção de dados na tabela associativa Autor_Ilustrador
insert into Autor_Ilustrador(ID_Autor,ID_Ilustrador) values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15)

--Inserção de dados na tabela associativa Autor_Editor
insert into Autor_Editor(ID_Autor,ID_Editor) values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15)

--Inserção de dados na tabela associativa Autor_Genero
insert into Autor_Genero(ID_Autor,ID_Genero) values
(1,2),
(1,14),
(2,4),
(2,16),
(3,6),
(3,16),
(4,2),
(5,17),
(6,2),
(6,16),
(7,4),
(7,16),
(8,11),
(9,15),
(10,15),
(11,13),
(12,2),
(13,6),
(14,16),
(15,12),
(15,15)

--Inserção de dados na tabela associativa Ilustrador_Editora
insert into Ilustrador_Editora(ID_Editora, ID_Ilustrador) values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(7,8),
(8,9),
(10,9),
(1,11),
(6,12),
(10,13),
(11,14),
(8,15)

--Inserção de dados na tabela associativa Autor_Editora
insert into Autor_Editora(ID_Editora,ID_Autor) values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(7,8),
(8,9),
(8,10),
(9,11),
(1,12),
(6,13),
(10,14),
(11,15)

--Inserção de dados na tabela associativa Genero_Editora
insert into Genero_Editora(ID_Editora,ID_Genero) values
(2,4),
(2,16),
(3,16),
(3,6),
(4,2),
(5,17),
(1,2),
(1,14),
(6,2),
(6,16),
(7,4),
(7,16),
(7,11),
(8,15),
(9,13),
(6,6),
(10,2),
(11,12),
(11,15)

--Inserção de dados na tabela associativa Genero_Livraria
insert into Genero_Livraria(ID_Genero, ID_Livraria) values
(4,1),
(16,1),
(6,1),
(2,1),
(17,1),
(14,1),
(11,1),
(15,1),
(4,2),
(16,2),
(6,2),
(2,2),
(17,2),
(11,2),
(12,2),
(15,2),
(6,3),
(16,3),
(2,3),
(17,3),
(14,3),
(15,3),
(13,3),
(6,4),
(16,4),
(15,4),
(2,4),
(12,4),
(4,5),
(16,5),
(6,5),
(2,5),
(11,5),
(13,5),
(12,5),
(4,6),
(16,6),
(6,6),
(2,6),
(12,6),
(15,6)

--Inserção de dados na tabela associativa Editora_Livraria 
insert into Editora_Livraria(ID_Editora,ID_Livraria) values
(2,1),
(3,1),
(4,1),
(5,1),
(7,1),
(8,1),
(1,1),
(2,2),
(3,2),
(4,2),
(5,2),
(7,2),
(10,2),
(11,2),
(3,3),
(4,3),
(5,3),
(1,3),
(7,3),
(8,3),
(9,3),
(10,3),
(3,4),
(8,4),
(9,4),
(6,4),
(11,4),
(2,5),
(3,5),
(6,5),
(7,5),
(9,5),
(11,5),
(2,6),
(3,6),
(6,6),
(10,6),
(11,6),
(7,6)

--Inserção de dados na tabela associativa Autor_Livraria
insert into Autor_Livraria(ID_Autor, ID_Livraria) values
(2,1),
(3,1),
(4,1),
(5,1),
(1,1),
(6,1),
(8,1),
(10,1),
(2,2),
(3,2),
(4,2),
(5,2),
(7,2),
(14,2),
(15,2),
(3,3),
(4,3),
(1,3),
(7,3),
(9,3),
(11,3),
(14,3),
(3,4),
(9,4),
(10,4),
(11,4),
(12,4),
(13,4),
(15,4),
(1,5),
(2,5),
(3,5),
(6,5),
(7,5),
(8,5),
(15,5),
(4,5),
(2,6),
(3,6),
(6,6),
(14,6),
(15,6),
(4,6),
(7,6)

--Inserção de dados na tabela associativa Ilustrador_Livraria
insert into Ilustrador_Livraria(ID_Ilustrador,ID_Livraria) values
(2,1),
(3,1),
(4,1),
(5,1),
(1,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(2,2),
(3,2),
(4,2),
(5,2),
(7,2),
(8,2),
(11,2),
(15,2),
(3,3),
(4,3),
(5,3),
(6,3),
(7,3),
(9,3),
(11,3),
(14,3),
(3,4),
(9,4),
(10,4),
(11,4),
(12,4),
(13,4),
(15,4),
(2,5),
(3,5),
(6,5),
(7,5),
(8,5),
(11,5),
(15,5),
(4,5),
(2,6),
(3,6),
(4,6),
(6,6),
(14,6),
(15,6),
(7,6)

--Inserção de dados na tabela associativa Livraria_Livro
insert into Livraria_Livro(ID_Livro,ID_Livraria) values
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(1,2),
(2,2),
(3,2),
(4,2),
(7,2),
(8,2),
(14,2),
(15,2),
(16,2),
(4,3),
(2,3),
(3,3),
(5,3),
(7,3),
(9,3),
(11,3),
(14,3),
(16,3),
(2,4),
(9,4),
(10,4),
(11,4),
(12,4),
(13,4),
(15,4),
(1,5),
(2,5),
(6,5),	
(7,5),
(8,5),
(11,5),
(15,5),
(16,5),
(1,6),
(2,6),
(6,6),
(14,6),
(15,6),
(16,6)

--Inserção de dados na tabela associativa Editor_Livraria
insert into Editor_Livraria(ID_Editor,ID_Livraria) values
(2,1),
(3,1),
(4,1),
(5,1),
(1,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(2,2),
(3,2),
(4,2),
(5,2),
(7,2),
(8,2),
(14,2),
(15,2),
(6,2),
(12,2),
(3,3),
(4,3),
(5,3),
(1,3),
(7,3),
(9,3),
(11,3),
(14,3),
(6,3),
(3,4),
(9,4),
(10,4),
(11,4),
(12,4),
(13,4),
(15,4),
(2,5),
(3,5),
(6,5),
(7,5),
(8,5),
(11,5),
(15,5),
(12,5),
(2,6),
(3,6),
(6,6),
(14,6),
(15,6),
(12,6)

--Script DQL

--Querys de todas as tabelas

select* from Genero
select* from Editora
select* from Livraria
select* from Ilustrador
select* from Autor
select* from Publico_Alvo
select* from Livro
select* from Editor
select* from Tipo_Telefone
select* from Telefones_Livraria 
select* from Tipo_Endereco
select* from Endereco_Livraria
select* from Livro_Publico_Alvo 
select* from Ilustrador_Livro 
select* from Autor_Livro 
select* from Livro_Genero
select* from Editor_Livro 
select* from Autor_Ilustrador
select* from Autor_Editor 
select* from Autor_Genero
select* from Ilustrador_Editora
select* from Autor_Editora
select* from Autor_Livraria
select* from Genero_Editora
select* from Genero_Livraria
select* from Editora_Livraria
select* from Ilustrador_Livraria
select* from Livraria_Livro
select* from Autor_Editora
select* from Editor_Livraria 


--Querys com dados das tabelas

-- Seleciona as cidades distintas
select DISTINCT Cidade from Endereco_Livraria

--Condição para chamar um registro
select Nome_Editor as Editores_Americanos from Editor WHERE Nacionalidade='Americano'

--AS: Dá um nome a coluna que será exibida, e count conta o numero de registros 
select COUNT(ID_Livro)AS Numero_Livros  from Livro	

-- LIKE: Filtra as informacoes, exibe livros que começam com a letra "A"
select Titulo_livro from Livro WHERE Titulo_Livro LIKE 'A%'

-- NOT LIKE: Filtra as informações, e na hora da exibir são selecionados os opostos da condição
select Titulo_livro from Livro WHERE Titulo_Livro NOT LIKE 'A%'

--TOP nº + Condição.
Select top 10 Titulo_Livro from Livro where Data_Publicacao > '2017'
Select top 1 Titulo_Livro from Livro where Numero_Paginas > '500'
Select top 20 percent Titulo_Livro from Livro where Numero_Paginas > '200' and Numero_Paginas <'300'

--MIN: busca os menores valores, no caso o livro mais antigo
Select MIN(Data_Publicacao) As Publicação from Livro

Select top 3 Titulo_Livro, Data_Publicacao from Livro where exists (select MIN(Data_publicacao)from Livro)

--MAX: busca os maiores valores, no caso o autor mais novo
Select MAX(Data_Nascimento) as Nascimento from Autor

Select top 5 Nome_Autor, Sobrenome_Autor,Sexo,Data_Nascimento from Autor where exists (select Max(Data_Nascimento)from Autor)

--AVG: Faz a média de números de páginas de todos os livros 
Select AVG(Numero_Paginas) as Média_de_Páginas from Livro

-- ORDER BY: Realiza a ordenação dos campos. DESC decrescente e ASC crescente
Select* from Livro order by Titulo_Livro ASC

Select* from Autor order by Nome_Autor DESC

-- Select com Where: Esta combinação permite que sejam criadas condições na filtragem. 
--Podem ser ainda aliados com o and e or deixando uma consulta mais especifica 
select Nome_Editor from Editor WHERE Nacionalidade='Americano'

select Nome_Editor from Editor WHERE Sexo= 'F'

select Nome_Editor from Editor WHERE Nacionalidade='Americano' and Sexo='F'

select Nome_Editor from Editor WHERE Nacionalidade='Americano' or Nacionalidade= 'Britânico'


--Seção de querys com as tabelas associativas

--Criação de views de querys com junções coerentes e eficientes de tabelas
--A comprovação da veracidade das pesquisas realizadas pode ser feita através da checagem de IDs e Inserts

--VIEW: DEVE SER CRIADA UMA POR VEZ

--Pega o nome e sobrenome do autor, e o gênero que esse autor escreve
CREATE VIEW V_Autor_genero AS
select distinct A.Nome_Autor[Nome do Autor], A.Sobrenome_Autor[Sobrenome do Autor], T.Nome_Genero[Nome do Gênero]
from Autor A
INNER JOIN Autor_Genero G
ON A.ID_Autor=G.ID_Autor
INNER JOIN Genero T
ON G.ID_Genero=T.ID_Genero

--Pega o nome e sobrenoome do autor, e os respectivos livros que ele escreveu
CREATE VIEW V_Autor_livro as
select distinct A.Nome_Autor[Nome do Autor], A.Sobrenome_Autor[Sobrenome do Autor], 
L.ID_Livro[ID do Livro], T.Titulo_Livro[Título do Livro], T.Subititulo_Livro[Subtítulo do Livro]
from Autor A
INNER JOIN Autor_Livro L
ON A.ID_Autor=L.ID_Autor
INNER JOIN Livro T
ON L.ID_Livro=T.ID_Livro

--Através do WHERE, pesquisa o nome e subititulo do livro, e o seu respectivo Gênero
CREATE VIEW V_Livro_genero as
select distinct L.Titulo_Livro[Título do Livro],L.Subititulo_Livro[Subtítulo do Livro],
A.ID_Livro[ID do Livro],
G.Nome_Genero[Nome do Gênero]
from Livro L, Livro_Genero A, Genero G
where L.ID_Livro=A.ID_Livro AND A.ID_Genero=G.ID_Genero	

--Mesma consulta que acima, porém com o gênero específico "Literatura"
CREATE VIEW V_Livro_genero_especifico as
select L.Titulo_Livro[Título do Livro],L.Subititulo_Livro[Subtítulo do Livro],
A.ID_Livro[ID do Livro],
G.Nome_Genero[Nome do Gênero]
from Livro L, Livro_Genero A, Genero G
where L.ID_Livro=A.ID_Livro AND A.ID_Genero=G.ID_Genero AND
G.Nome_Genero='Literatura'

--JOIN para mostrar o nome e sobrenome do editor, e a respectiva editora que ele trabalha. Right outer join auxilía na organização
CREATE VIEW V_Editor_editora as
select L.Nome_Editor[Nome do Editor],L.Sobrenome_Editor[Sobrenome do Editor],LL.Nome_Editora[Nome da Editora]
from Editor L
RIGHT OUTER JOIN Editora LL
ON L.ID_Editora=LL.ID_Editora

--Pesquisa todos os livros e seus respectivos públicos alvo
CREATE VIEW V_Livro_publico_alvo as
select distinct A.Titulo_Livro[Título do Livro], A.Subititulo_Livro[Subtítulo do Livro], T.Tipo_Publico_Alvo[Público Alvo]
from Livro A
INNER JOIN Livro_Publico_Alvo G
ON A.ID_Livro=G.ID_Livro
INNER JOIN Publico_Alvo T
ON G.ID_Publico_Alvo=T.ID_Publico_Alvo

--Livros e seus ilustradores, sem mostrar o ID de nada	
CREATE VIEW	V_Livro_Ilustrador as
select distinct A.Titulo_Livro[Título do Livro], A.Subititulo_Livro[Subtítulo do Livro], 
T.Nome_Ilustrador[Nome do Ilustrador],T.Sobrenome_Ilustrador[Sobrenome do Ilustrador],T.Sexo,T.Nacionalidade
from Livro A
INNER JOIN Ilustrador_Livro G
ON A.ID_Livro=G.ID_Livro
INNER JOIN Ilustrador T
ON G.ID_Ilustrador=T.ID_Ilustrador

--Autores e Ilustradores que trabalharam juntos
CREATE VIEW V_Autor_ilustrador as
select distinct A.Nome_Autor[Nome do Autor], A.Sobrenome_Autor[Sobrenome do Autor],A.Sexo [Sexo do Autor],A.Nacionalidade[Nacionalidade do Autor],
T.Nome_Ilustrador[Nome do Ilustrador],T.Sobrenome_Ilustrador[Sobrenome do Ilustrador],T.Sexo[Sexo do ilustrador],T.Nacionalidade[Nacionalidade do ilustrador]
from Autor A
INNER JOIN Autor_Ilustrador G
ON A.ID_Autor=G.ID_Autor
INNER JOIN Ilustrador T
ON G.ID_Ilustrador=T.ID_Ilustrador

--Autores e Editores que trabalharam juntos
CREATE VIEW V_Autor_editor as
select distinct A.Nome_Autor[Nome do Autor], A.Sobrenome_Autor[Sobrenome do Autor],A.Sexo[Sexo do Autor],A.Nacionalidade[Nacionalidade do Autor], 
T.Nome_Editor[Nome do Editor],T.Sobrenome_Editor[Sobrenome do Editor],T.Sexo[Sexo do Editor],T.Nacionalidade[Nacionalidade do Editor]
from Autor A
INNER JOIN Autor_Editor G
ON A.ID_Autor=G.ID_Autor
INNER JOIN Editor T
ON G.ID_Editor=T.ID_Editor

--Exibe as editoras e os determinados tipos de gêneros que elas publicaram
CREATE VIEW V_Editora_genero as
select distinct L.Nome_Editora[Nome da Editora],L.Nacionalidade[Nacionalidade da Editora],LL.Nome_Genero[Nome do Gênero]
from Editora L
INNER JOIN Genero_Editora F
ON L.ID_Editora=F.ID_Editora
INNER JOIN Genero LL
ON F.ID_Genero=LL.ID_Genero

--Nomes das livrarias,seus e-mails, seus respectivos telefones e o tipo desse telefone
create view V_Telefones_livraria as
select distinct Q.Nome_Livraria[Nome da Livraria],Q.Email[E-mail],W.Numero_Telefone[Número de Telefone],E.Tipo_Telefone[Tipo de Número]
from Livraria Q
INNER JOIN Telefones_Livraria W
ON Q.ID_Livraria=W.ID_Livraria
INNER JOIN Tipo_Telefone E
ON W.ID_Tipo_Telefone=E.ID_Tipo_Telefone

--Nome das livrarias, seus e-mails, seus respectivos endereçoc e o tipo de endereco
create view V_Enderecos_livrarias as
select distinct Q.Nome_Livraria[Nome da Livraria],Q.Email[E-mail],W.Cidade,W.Nome_Rua[Nome da Rua],W.CEP,E.Tipo_Endereco[Tipo de Endereço]
from Livraria Q
INNER JOIN Endereco_Livraria W
ON Q.ID_Livraria=W.ID_Livraria
INNER JOIN Tipo_Endereco E
ON W.ID_Tipo_Endereco=E.ID_Tipo_Endereco

--Ilustradores e as editoras que publicaram seus trabalhos
create view V_Ilustradore_editoras as
select distinct L.Nome_Editora[Nome da Editora],L.Nacionalidade[Nacionalidade da Editora],
LL.Nome_Ilustrador[Nome do Ilustrador],LL.Sobrenome_Ilustrador[Sobrenome do Ilustrador],LL.Data_Nascimento[Data de nascimento]
from Editora L
INNER JOIN Ilustrador_Editora F
ON L.ID_Editora=F.ID_Editora
INNER JOIN Ilustrador LL
ON F.ID_Ilustrador=LL.ID_Ilustrador

--Que editora está presete em determinada livraria
create view V_Editora_livraria as
select distinct L.Nome_Editora[Nome da Editora],L.Nacionalidade[Nacionalidade da Editoraa], LL.Nome_Livraria[Nome da Livraria]
from Editora L
INNER JOIN Editora_Livraria X
ON L.ID_Editora=X.ID_Editora
INNER JOIN Livraria LL
ON X.ID_Livraria=LL.ID_Livraria

--Que Livraria possui determinado gênero
create view V_Livraria_genero as
select distinct L.Nome_Genero[Nome do Gênero], LL.Nome_Livraria[Nome da Livraria]
from Genero L
INNER JOIN Genero_Livraria X
ON L.ID_Genero=X.ID_Genero
INNER JOIN Livraria LL
ON X.ID_Livraria=LL.ID_Livraria

--Por qual editora o trabalho do autor foi publicado
create view V_Editora_autor as
select distinct X.Nome_Autor[Nome do Autor],X.Sobrenome_Autor[Sobrenome do Autor],X.Nacionalidade[Nacionalidade do Autor],
X.Sexo[Sexo do Autor],X.Data_Nascimento[Data de nascimento], E.Nome_Editora[Nome da Editora]
from Autor X
INNER JOIN Autor_Editora K
ON X.ID_Autor=K.ID_Autor
INNER JOIN Editora E
ON K.ID_Editora=E.ID_Editora

--Que editor editou determinado livro
create view V_Editor_livro as
select distinct D.Nome_Editor[Nome do Editor],D.Sobrenome_Editor[Sobrenome do Editor], 
D.Nacionalidade[Nacionalidade do Editor],D.Data_Nascimento[Data de Nascimento] , 
H.Titulo_Livro[Título do Livro],H.Subititulo_Livro[Subtítulo do Livro]
from Editor D
INNER JOIN Editor_Livro J
ON D.ID_Editor=J.ID_Editor
INNER JOIN Livro H
ON J.ID_Livro=H.ID_Livro

--Se o editor está em tal livraria
create view V_Editor_Livraria as
select distinct D.Nome_Editor[Nome do Editor],D.Sobrenome_Editor[Sobrenome do Editor], 
D.Nacionalidade[Nacionalidade do Editor],D.Data_Nascimento[Data de Nascimento] , H.Nome_Livraria[Nome da Livraria]
from Editor D
INNER JOIN Editor_Livraria J
ON D.ID_Editor=J.ID_Editor
INNER JOIN Livraria H
ON J.ID_Livraria=H.ID_Livraria

--Autores e ilustradores que trabalharam juntos e as livrarias em que estão presentes
create view V_Autor_ilustrador_livraria as
select distinct LL.Nome_Livraria[Nome da Livraria],LL.Email[E-mail], R.Nome_Autor[Nome do Autor],R.Sobrenome_Autor[Sobrenome do Autor],
R.Nacionalidade[Nacionalidade do Autor], 
U.Nome_Ilustrador[Nome do Ilustrador],U.Sobrenome_Ilustrador[Sobrenome do Ilustrador],U.Nacionalidade[Nacionalidade do Ilustrador]
From Livraria LL
INNER JOIN Autor_Livraria H
ON LL.ID_Livraria=H.ID_Livraria
INNER JOIN Autor R
ON H.ID_Autor=R.ID_Autor
INNER JOIN Autor_Ilustrador Q
ON R.ID_Autor=Q.ID_Ilustrador
INNER JOIN Ilustrador U
ON Q.ID_Ilustrador=U.ID_Ilustrador

--Verdadeiro poder da associação de tabelas. Presença de livro X em livraria Y de lugar Z com numero de telefone W
create view V_Presenca as
select distinct A.Titulo_Livro[Título do Livro],A.Subititulo_Livro[Subtítulo do Livro],A.Numero_Paginas[Número de Páginas],
F.Nome_Livraria[Disponível em],
C.Cidade,C.Nome_Rua[Nome da rua],D.Tipo_Endereco[Tipo de Endereco],E.Numero_Telefone[Número para contato],Z.Tipo_Telefone[Tipo de número]
from Livro A
INNER JOIN Livraria_Livro X
ON A.ID_Livro=X.ID_Livro
INNER JOIN Livraria F
ON X.ID_Livraria=F.ID_Livraria
INNER JOIN Endereco_Livraria C
ON F.ID_Livraria=C.ID_Livraria
INNER JOIN Tipo_Endereco D
ON C.ID_Tipo_Endereco=D.ID_Tipo_Endereco
INNER JOIN Telefones_Livraria E
ON F.ID_Livraria=E.ID_Livraria
INNER JOIN Tipo_Telefone Z
ON E.ID_Tipo_Telefone=Z.ID_Tipo_Telefone

--Com esse where no final, é possível pesquisar qualquer livro. Mas isso não se restringe a ID_Livro, poderia ser ID_Livraria, nome de livraria,
--nome de cidade, tipo de endereço, entre outra coisas. Há vastas possibilidades de tipos de consulta (Não está embutido na view V_Presenca)
where A.ID_Livro=7

--Seção de execução de todas as VIEWS criadas

select * from V_Autor_genero

select * from V_Autor_livro

select * from V_Livro_genero

select* from V_Livro_genero_especifico

select * from V_Editor_editora

select * from V_Livro_publico_alvo

select * from V_Livro_Ilustrador

select * from V_Autor_ilustrador

select * from V_Autor_editor

select * from V_Editora_genero

select * from V_Telefones_livraria

select * from V_Enderecos_livrarias

select * from V_Ilustradore_editoras

select * from V_Editora_livraria

select * from V_Livraria_genero

select * from V_Editora_autor

select * from V_Editor_livro

select * from V_Editor_Livraria

select * from V_Autor_ilustrador_livraria

select * from V_Presenca

--Também é possível aplicar order by em VIEWS
select * from V_Presenca
order by [Disponível em]

--Alteração de uma VIEW
ALTER VIEW V_Livro_genero_especifico AS
select L.Titulo_Livro[Título do Livro],L.Subititulo_Livro[Subtítulo do Livro],
A.ID_Livro[ID do Livro],
G.Nome_Genero[Nome do Gênero]
from Livro L, Livro_Genero A, Genero G
where L.ID_Livro=A.ID_Livro AND A.ID_Genero=G.ID_Genero AND
G.Nome_Genero='Fantasia'

--Agracemos pela avaliação e esperamos que tenham gostado professores! Obrigado pelo semestre!

--DDL - DROP
DROP DATABASE Lovelace_Central_de_Livros