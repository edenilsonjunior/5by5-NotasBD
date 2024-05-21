use BDAlunos;
GO
CREATE OR ALTER PROC Calculo_Media_Parcial 
AS
BEGIN
    DECLARE Aux_Cursor CURSOR FOR  
        SELECT cpfAluno, 
               codDisciplina, 
               ano, 
               semestre, 
               nota1, 
               nota2
        FROM AlunoDisciplina;

    OPEN Aux_Cursor;
 
    DECLARE @cpfAluno varchar(11),
            @codDisciplina int,
            @ano int,
            @semestre int,
            @nota1 float,
            @nota2 float

    FETCH NEXT FROM Aux_Cursor INTO @cpfAluno, @codDisciplina, @ano, @semestre, @nota1, @nota2;

    WHILE @@FETCH_STATUS = 0 
    BEGIN 
        DECLARE @media float; 

        if(@nota1 is null)
            SET @nota1 = 0

        if(@nota2 is null)
            SET @nota2 = 0

        SET @media = (@nota1 + @nota2) / 2; 

        UPDATE AlunoDisciplina
        SET media = @media
        WHERE cpfAluno = @cpfAluno AND codDisciplina = @codDisciplina AND ano = @ano AND semestre = @semestre 

        FETCH NEXT FROM Aux_Cursor INTO @cpfAluno, @codDisciplina, @ano, @semestre, @nota1, @nota2;
    END;
 
    CLOSE Aux_Cursor;
    DEALLOCATE Aux_Cursor;
END;
