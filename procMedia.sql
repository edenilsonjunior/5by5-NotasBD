use BDAlunos;
GO
CREATE OR ALTER PROC Encerrar_Notas 
AS
BEGIN
    DECLARE Aux_Cursor CURSOR FOR  
        SELECT cpfAluno, 
               codDisciplina, 
               ano, 
               semestre, 
               nota1, 
               nota2,
               quantidadeFaltas,
               provaSubstitutiva
        FROM AlunoDisciplina;

    OPEN Aux_Cursor;

    DECLARE @cpfAluno varchar(11),
            @codDisciplina int,
            @ano int,
            @semestre int,
            @nota1 float,
            @nota2 float,
            @quantidadeFaltas int,
            @provaSubstitutiva float;

    FETCH NEXT FROM Aux_Cursor INTO @cpfAluno, @codDisciplina, @ano, @semestre, @nota1, @nota2, @quantidadeFaltas, @provaSubstitutiva;

    WHILE @@FETCH_STATUS = 0 
    BEGIN 
        DECLARE @media float, @situacao varchar(30), @nroAulas int, @frequencia float;

        -- Mudando a n1 ou n2 para nula
        if(@nota1 is null)
            SET @nota1 = 0;

        if(@nota2 is null)
            SET @nota2 = 0;

        -- Caso tenha sub, armazena-la na menor nota
        IF(@provaSubstitutiva is not null)
        BEGIN
            if(@nota1 < @nota2)
                SET @nota1 = @provaSubstitutiva;
            ELSE
                SET @nota2 = @provaSubstitutiva;
        END;
        

        SET @media = (@nota1 + @nota2) / 2; 
        SET @nroAulas= (SELECT nroAulas FROM Disciplina where codigo = @codDisciplina);
        SET @frequencia = ((@nroAulas - @quantidadeFaltas) / CONVERT(float, @nroAulas) * 100);

        if(@frequencia < 75.00)
            SET @situacao = 'REPROVADO POR FALTA';
        else if(@media < 6.00)
            SET @situacao = 'REPROVADO POR NOTA';
        else
            SET @situacao  = 'APROVADO';

        UPDATE AlunoDisciplina
        SET media = @media, situacao = @situacao, frequencia = @frequencia
        WHERE cpfAluno = @cpfAluno AND codDisciplina = @codDisciplina AND ano = @ano AND semestre = @semestre;

        FETCH NEXT FROM Aux_Cursor INTO @cpfAluno, @codDisciplina, @ano, @semestre, @nota1, @nota2, @quantidadeFaltas, @provaSubstitutiva;
    END;
 
    CLOSE Aux_Cursor;
    DEALLOCATE Aux_Cursor;
END;

GO
exec Encerrar_Notas;
select * from AlunoDisciplina;