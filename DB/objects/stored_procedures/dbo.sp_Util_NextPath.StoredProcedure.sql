SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_Util_NextPath]
		(
		@MaxPath	varchar(150),
		@NewPath	varchar(150) output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		-

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	27 June 2001		Davi Gouveia		Log de Return Values
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT @NewPath = SUBSTRING(@MaxPath, 1, DATALENGTH(@MaxPath)-3) + RIGHT('000' + RTRIM(CONVERT(char(3), (CONVERT(int, RIGHT(@MaxPath, 3)) + 1))), 3)
GO
