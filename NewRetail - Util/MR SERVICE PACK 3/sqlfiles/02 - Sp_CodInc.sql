IF EXISTS(select * from dbo.sysobjects 
	where id = object_id(N'[dbo].[sp_Sis_GetNextCode]'))
	 EXEC('DROP PROC sp_Sis_GetNextCode')
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_Sis_GetNextCode
		(
		@Tabela			varchar(100),
		@NovoCodigo		int = 0 output	
		)
AS

/*
---------------------------------------------------------
	Incrementa a tabela de controle de Codigos 
	e retorna o valor 
---------------------------------------------------------
*/

UPDATE	
	CI
SET	
	UltimoCodigo = UltimoCodigo + 1,
	@NovoCodigo = UltimoCodigo + 1
FROM
	Sis_CodigoIncremental CI (UPDLOCK, ROWLOCK)

WHERE  	
	Tabela = @Tabela

IF (@@ROWCOUNT = 0)
BEGIN
	SET @NovoCodigo = 1
	INSERT Sis_CodigoIncremental (Tabela,  UltimoCodigo) 
	VALUES (@Tabela, @NovoCodigo)
END
RETURN

GO
SET QUOTED_IDENTIFIER OFF 
GO

SET ANSI_NULLS ON 
GO

