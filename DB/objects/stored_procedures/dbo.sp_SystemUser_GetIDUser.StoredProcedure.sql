SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_SystemUser_GetIDUser]
		(
		@IDCOmission 	int,
		@IDUser      	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Retorna o ultimo id de usuario

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT @IDUser = IsNull(  ( SELECT MAX(IDUser) FROM SystemUser (NOLOCK)  WHERE ComissionID = @IDComission ), 0)
GO
