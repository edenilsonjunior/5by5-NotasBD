use BDAlunos;

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
 nota1 float not null,
 nota2 float not null,
 quantidadeFaltas int not null,
 frequencia float not null,
 media float not null,
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

INSERT INTO AlunoDisciplina VALUES
('52183506059', 111, 2024, 1, 9.0, 8.0, 20, 13.3, 8.5, 10.0),
('95781206051', 222, 2022, 2, 4.3, 7.0, 50, 03.5, 2.5, 7.7),
('74753303039', 333, 2024, 1, 5.0, 1.0, 12, 40.0, 5.5, 3.6),
('17520311058', 222, 2023, 2, 2.0, 9.0, 60, 60.0, 7.5, 1.3),
('71221470027', 333, 2021, 2, 1.1, 6.0, 20, 80.0, 10, 6.8);

select * from 
aluno join AlunoDisciplina ON aluno.cpf = AlunoDisciplina.cpfAluno;
