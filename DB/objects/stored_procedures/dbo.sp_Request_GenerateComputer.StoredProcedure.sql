SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Request_GenerateComputer]
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Gera ps pedidos do computador

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em DELETE FROM Request
		-202  Erro em INSERT	Request


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Request_Cursor	
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


/*	Gera ps pedidos do computador		*/
DECLARE @MinQty  	float
DECLARE @MinPerc 	numeric(5, 2)
DECLARE @ErrorLevel	int
DECLARE @SysError	int

--Declaração de variáveis para o Cursor de Request
DECLARE @IDRequest	int
DECLARE @ModelID 	int 
DECLARE @UserID 	int 
DECLARE @Type 	char(1)
DECLARE @QtyReq 	float
DECLARE @DateRequest 	smalldatetime 
DECLARE @StoreID 	int 
DECLARE @Description varchar(50)

SET @ErrorLevel = 0

SELECT  @MinQty   = ( SELECT CONVERT(float, ( SELECT SrvValue FROM Param WHERE IDParam = 13 ) ) )

SELECT  @MinPerc  = ( SELECT CONVERT(int, ( SELECT SrvValue FROM Param WHERE IDParam = 14 ) ) )

/*	Testa se venda dos nMes ultimos meses foi maior que a nMinPerc de compras */

DELETE
FROM
	Request
WHERE
	Type = 'C'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

--Declaração do Cursor de Request

DECLARE Request_Cursor CURSOR FOR

SELECT
		vwInventoryModel.IDModel,
		0,
		'C',
		1,
		GetDate(),
		1,
		Description
	FROM
		vwInventoryModel
	WHERE
		NOT EXISTS
		(
		SELECT
			ModelID
		FROM
			Request (NOLOCK)
		WHERE
			Request.ModelID = vwInventoryModel.IDModel
			)
			AND
			vwInventoryModel.TotQtyOnHand <= @MinQty
			AND
			convert(numeric(5, 2),
			(
			(
			SELECT
				SUM(Qty)
			FROM
				InventoryMov (NOLOCK)
			WHERE
				InventoryMov.InventMovTypeID = 1
				AND
				InventoryMov.ModelID = vwInventoryModel.IDModel
			)/
			(
			SELECT
				SUM(Qty)
			FROM
				InventoryMov (NOLOCK)
			WHERE
				InventoryMov.InventMovTypeID = 2
				AND
				InventoryMov.ModelID = vwInventoryModel.IDModel
			)
		)) >= 1+(@MinPerc/100)
OPEN Request_Cursor

--Inicialização de Request_Cursor
FETCH NEXT FROM Request_Cursor INTO
	@ModelID,
	@UserID,
	@Type,
	@QtyReq,
	@DateRequest,
	@StoreID,
	@Description
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Request.IDRequest', @IDRequest OUTPUT

	INSERT Request
		(
		IDRequest,
		ModelID,
		UserID,
		Type,
		QtyReq,
		DateRequest,
		StoreID,
		Description
		)
	VALUES 
		(
		@IDRequest,
		@ModelID,
		@UserID,
		@Type,
		@QtyReq,
		@DateRequest,
		@StoreID,
		@Description	
		)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Request_Cursor
			DEALLOCATE Request_Cursor
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	FETCH NEXT FROM Request_Cursor INTO
		@ModelID,
		@UserID,
		@Type,
		@QtyReq,
		@DateRequest,
		@StoreID,
		@Description
END
--fechamento do cursor
CLOSE Request_Cursor
--Destruição do cursor
DEALLOCATE Request_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Request_GenerateComputer', @ErrorLevelStr

	RETURN @ErrorLevel
GO
