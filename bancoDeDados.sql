use BDAlunos;

if exists (SELECT * FROM dbo.SYSOBJECTS WHERE XTYPE = 'U' AND NAME = 'AlunoDisciplina')
	drop table AlunoDisciplina;
GO

if exists (SELECT * FROM dbo.SYSOBJECTS WHERE XTYPE = 'U' AND NAME = 'Aluno')
	drop table Aluno;
GO

if exists (SELECT * FROM dbo.SYSOBJECTS WHERE XTYPE = 'U' AND NAME = 'Disciplina')
	drop table Disciplina;
GO


CREATE TABLE Aluno
(
 cpf varchar(11) not null,
 nome varchar(50) not null,
 CONSTRAINT pkaluno primary key (cpf)
);


CREATE TABLE Disciplina
(
 codigo int not null,
 nome varchar(30) not null,
 nroAulas int not null,
 CONSTRAINT pkdisciplina primary key (codigo)
);


CREATE TABLE AlunoDisciplina
(
 cpfAluno varchar(11) not null,
 codDisciplina int not null,
 ano int not null,
 semestre int not null,
 nota1 float,
 nota2 float,
 provaSubstitutiva float,
 media float,
 quantidadeFaltas int,
 frequencia float,
 situacao varchar(30),

 CONSTRAINT pkalunodisciplina PRIMARY KEY (cpfAluno, codDisciplina, ano, semestre),
 CONSTRAINT fkaluno FOREIGN KEY (cpfAluno) references Aluno(cpf),
 CONSTRAINT fkdisciplina FOREIGN KEY (codDisciplina) references Disciplina(codigo)
);


INSERT INTO Aluno(cpf, nome) VALUES 
('52183506059', 'Edenilson'),
('95781206051', 'Augusto'),
('74753303039', 'Caua'),
('17520311058', 'Pestana'),
('71221470027', 'Caio');

INSERT INTO Disciplina VALUES
(111, 'Logica de programacao', 160),
(222, 'Estrutura de dados', 80),
(333, 'Orientacao a objeto', 160);

INSERT INTO AlunoDisciplina (cpfAluno, codDisciplina, ano, semestre, nota1, nota2, quantidadeFaltas, provaSubstitutiva) VALUES 
('52183506059', 111, 2024, 1, 7.5, 8.0, 2, NULL),
('95781206051', 111, 2024, 1, 6.0, 7.0, 3, 1.0),
('74753303039', 111, 2024, 1, 8.0, 9.0, 0, 3.0),
('71221470027', 222, 2024, 1, 8.0, 9.0, 9, NULL),
('52183506059', 222, 2024, 1, 6.0, 7.0, 30, 9.0),
('95781206051', 333, 2024, 1, 8.0, 9.0, 3, NULL),
('74753303039', 333, 2024, 1, 5.0, 4.0, 1, 7.0),
('17520311058', 333, 2024, 1, 7.0, 8.0, 20, NULL),
('17520311058', 222, 2024, 1, 3.0, NULL, 40, 6.0),
('52183506059', 333, 2024, 1, 7.0, NULL, 9, 5.0);

GO
exec Encerrar_Notas

/*
select * from Aluno;
select * from Disciplina;
*/
select * from AlunoDisciplina;