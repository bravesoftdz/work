SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Model_DescBarCode]
			(
			@IDBarCode 	TBarCode,
			@ModelID   	int OutPut
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Verifico a existencia do BarCode para o Model dado


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT @ModelID =
		(
		SELECT
			BarCode.IDModel
		FROM
			dbo.Model Model (NOLOCK) , dbo.BarCode BarCode (NOLOCK) 
		WHERE
			BarCode.IDModel   = Model.IDModel
			AND
			BarCode.IDBarcode = @IDBarCode
		)

SELECT @ModelID   = IsNull(@ModelID, -1)
GO
