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
 quantidadeFaltas int,
 frequencia float,
 media float,
 provaSubstitutiva float,

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

INSERT INTO AlunoDisciplina VALUES ('52183506059', 111, 2024, 1, 7.5, 8.0, 2, 80, NULL, NULL);
INSERT INTO AlunoDisciplina VALUES ('95781206051', 111, 2024, 1, 6.0, 7.0, 3, 70, NULL, NULL);
INSERT INTO AlunoDisciplina VALUES ('74753303039', 111, 2024, 1, 8.0, 9.0, 0, 100, NULL, NULL);

INSERT INTO AlunoDisciplina VALUES ('17520311058', 222, 2024, 1, 7.0, 8.0, 1, 90, NULL, NULL);
INSERT INTO AlunoDisciplina VALUES ('71221470027', 222, 2024, 1, 8.0, 9.0, 2, 80, NULL, NULL);
INSERT INTO AlunoDisciplina VALUES ('52183506059', 222, 2024, 1, 6.0, 7.0, 0, 100, NULL, NULL);

INSERT INTO AlunoDisciplina VALUES ('95781206051', 333, 2024, 1, 8.0, 9.0, 3, 70, NULL, NULL);
INSERT INTO AlunoDisciplina VALUES ('74753303039', 333, 2024, 1, 9.0, 4.0, 1, 90, NULL, NULL);
INSERT INTO AlunoDisciplina VALUES ('17520311058', 333, 2024, 1, 7.0, 8.0, 2, 80, NULL, NULL);

INSERT INTO AlunoDisciplina VALUES ('52183506059', 333, 2024, 1, 7.0, NULL, 2, 80, NULL, NULL);


GO
exec Calculo_Media_Parcial

/*
select * from Aluno;
select * from Disciplina;
*/
select * from AlunoDisciplina;