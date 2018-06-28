SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_CashRegister_InsUpt ON dbo.CashRegister
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do CashRegister

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


if  	@@rowcount = 0
	return

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDCashRegister
		FROM
			INSERTED,
			CashRegister
		WHERE
			INSERTED.NAME = CashRegister.NAME
			AND
			CashRegister.IDCashRegister <> INSERTED.IDCashRegister
			AND
			INSERTED.Desativado = 0
			AND
			CashRegister.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_CashRegister_CashRegister can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_CostType_InsUpt ON dbo.CostType
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do CostType

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDCostType
		FROM
			INSERTED,
			CostType
		WHERE
			INSERTED.CostType = CostType.CostType
			AND
			CostType.IDCostType <> INSERTED.IDCostType
			AND
			INSERTED.Desativado = 0
			AND
			CostType.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_CostType_CostType can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE TRIGGER tr_CotacaoToFornec_All ON dbo.CotacaoToFornec
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de CotacaoResult qdo deletado
		- Incluo em CotacaoResult qdo inserido


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SET NOCOUNT ON

/*
------------------------------------------------------------------------------------------
	DELECAO
------------------------------------------------------------------------------------------
*/

DELETE
	CotacaoResult
FROM
	Deleted D
WHERE
	CotacaoResult.IDCotacao = D.IDCotacao
	AND
	CotacaoResult.IDFornecedor = D.IDFornecedor

/*
------------------------------------------------------------------------------------------
	INSERCAO
------------------------------------------------------------------------------------------
*/

INSERT  CotacaoResult (
		IDCotacao,
		IDFornecedor,
		IDModel,
		Cost,
                Qty)
	SELECT
		I.IDCotacao,
		I.IDFornecedor,
		CTM.IDModel,
		Null,
		QtyCotada
	FROM
		Inserted I
		JOIN
		CotacaoToModel CTM ON (I.IDCotacao = CTM.IDCotacao)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER tr_CotacaoToModel_All ON dbo.CotacaoToModel
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de CotacaoResult qdo deletado
		- Incluo em CotacaoResult qdo inserido


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SET NOCOUNT ON

/*
------------------------------------------------------------------------------------------
	DELECAO
------------------------------------------------------------------------------------------
*/

DELETE
	CotacaoResult
FROM
	Deleted D
        LEFT OUTER JOIN Inserted I
		ON (D.IDCotacao = I.IDCotacao AND D.IDModel = I.IDModel)
WHERE
	I.IDModel IS NULL
	AND
	CotacaoResult.IDCotacao = D.IDCotacao
	AND
	CotacaoResult.IDModel = D.IDModel

/*
------------------------------------------------------------------------------------------
	INSERCAO
------------------------------------------------------------------------------------------
*/

INSERT 	CotacaoResult (
		IDCotacao,
		IDFornecedor,
		IDModel,
		Cost,
		Qty)
SELECT
	I.IDCotacao,
        CTF.IDFornecedor,
        I.IDModel,
        Null,
	I.QtyCotada
FROM
	Inserted I
        JOIN
	CotacaoToFornec CTF
		ON (I.IDCotacao = CTF.IDCotacao)
        LEFT OUTER JOIN
	Deleted D
		ON (D.IDCotacao = I.IDCotacao AND D.IDModel = I.IDModel)
WHERE
	D.IDModel IS NULL


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_DeliverType_Delete ON dbo.DeliverType
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo se registro excluido é System


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@rowCount = 0
   return

SET NOCOUNT ON

IF EXISTS (SELECT IDDeliverType	FROM Deleted WHERE Deleted.System = 1)
BEGIN
	RAISERROR ('Can not delete system value',16,-1)
	ROLLBACK TRANSACTION
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_DeliverType_InsUpt ON dbo.DeliverType
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do DeliverType


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if  	@@rowcount = 0 
	return

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDDeliverType
		FROM
			INSERTED,
			DeliverType
		WHERE
			INSERTED.Name = DeliverType.Name
			AND
			DeliverType.IDDeliverType <> INSERTED.IDDeliverType
			AND
			INSERTED.Desativado = 0
			AND
			DeliverType.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_DeliverType_DeliverType can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER tr_Estado_InsUpt ON dbo.Estado
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do Estado


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if  	@@rowcount = 0
	return

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDEstado
		FROM
			INSERTED, Estado
		WHERE
			INSERTED.Estado = Estado.Estado
			AND
			Estado.IDEstado <> INSERTED.IDEstado
			AND
			INSERTED.Desativado = 0
			AND
			Estado.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_Estado_Estado can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER tr_LancQuit_All ON dbo.Fin_LancQuit
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo as Tabelas de Lancamento e Quitacao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/* -----------------------------------------------------------------
	Delecao
   -----------------------------------------------------------------
*/
/*
	Total Quitado e Total Jurus
*/
UPDATE
	Fin_Lancamento
SET
	TotalQuitado = TotalQuitado - SumQuitado,
	TotalJuros = TotalJuros - SumJuros
FROM	(
	SELECT
		IDLancamento,
		SUM(ValorQuitado) SumQuitado,
		SUM(ValorJuros) SumJuros
	FROM
		Deleted D
	GROUP BY
		IDLancamento
	) D
WHERE
	D.IDLancamento = Fin_Lancamento.IDLancamento

/*
  	Total da Quitacao
*/
UPDATE
	Fin_Quitacao
SET
	ValorQuitacao = ValorQuitacao - SumQuitado,
	ValorJuros = ValorJuros - SumJuros
FROM	(
	SELECT
		IDQuitacao,
		SUM(ValorQuitado) SumQuitado,
		SUM(ValorJuros) SumJuros
	FROM
		Deleted D
	GROUP BY
		IDQuitacao
	) D
WHERE
	D.IDQuitacao = Fin_Quitacao.IDQuitacao

/*
	Situacao Parte Quitado
*/
UPDATE
	Fin_Lancamento
SET
	Situacao = C.Valor,
	Fin_Lancamento.DataFimQuitacao = Null
FROM
	Deleted D,
	Sis_Constante C
WHERE
	D.IDLancamento = Fin_Lancamento.IDLancamento
	AND
	Fin_Lancamento.TotalQuitado > Fin_Lancamento.ValorNominal
	AND
	Fin_Lancamento.TotalQuitado > 0
	AND
	C.Constante = 'LancamentoSituacao_ParteQuitado'

/*
	Situacao Aberto
*/
UPDATE
	Fin_Lancamento
SET
	Fin_Lancamento.Situacao = C.Valor,
 	Fin_Lancamento.DataInicioQuitacao = Null,
	Fin_Lancamento.DataFimQuitacao = Null
FROM
	Deleted D,
	Sis_Constante C
WHERE
	D.IDLancamento = Fin_Lancamento.IDLancamento
	AND
	Fin_Lancamento.TotalQuitado = 0
	AND
	C.Constante = 'LancamentoSituacao_Aberto'

/* -----------------------------------------------------------------
	Inclusao
   ----------------------------------------------------------------- */
/*
	Total Quitado e Total Jurus
*/
UPDATE
	Fin_Lancamento
SET
	TotalQuitado = TotalQuitado + SumQuitado,
	TotalJuros = TotalJuros + SumJuros
FROM	(
	SELECT
		IDLancamento,
		SUM(ValorQuitado) SumQuitado,
		SUM(ValorJuros) SumJuros
	FROM
		Inserted I
	GROUP BY
		IDLancamento
	) I
WHERE
	I.IDLancamento = Fin_Lancamento.IDLancamento

/*
  	Total da Quitacao
*/
UPDATE
	Fin_Quitacao
SET
	ValorQuitacao = ValorQuitacao + SumQuitado,
	ValorJuros = ValorJuros + SumJuros
FROM	(
	SELECT
		IDQuitacao,
		SUM(ValorQuitado) SumQuitado,
		SUM(ValorJuros) SumJuros
	FROM
		Inserted I
	GROUP BY
		IDQuitacao
	) I
WHERE
	I.IDQuitacao = Fin_Quitacao.IDQuitacao

/*
	DataInicioQuitacao
	e
	Situacao
*/
UPDATE
	Fin_Lancamento
SET
	DataInicioQuitacao = I.DataQuitacao,
	Situacao = C.Valor
FROM
	Inserted I,
	Sis_Constante C
WHERE
	I.IDLancamento = Fin_Lancamento.IDLancamento
	AND
	Fin_Lancamento.TotalQuitado < Fin_Lancamento.ValorNominal
	AND
	Fin_Lancamento.DataInicioQuitacao is NULL
	AND
	C.Constante = 'LancamentoSituacao_ParteQuitado'

/*
	DataFimQuitacao
	e
	Situacao
*/
UPDATE
	Fin_Lancamento
SET
	DataFimQuitacao = I.DataQuitacao,
	Situacao = C.Valor
FROM
	Inserted I,
	Sis_Constante C
WHERE
	I.IDLancamento = Fin_Lancamento.IDLancamento
	AND
	Fin_Lancamento.TotalQuitado >= Fin_Lancamento.ValorNominal
	AND
	C.Constante = 'LancamentoSituacao_Quitado'


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Fin_Quitacao_All ON dbo.Fin_Quitacao
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo o saldo de ContaCorrente


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/* -----------------------------------------------------------------
	Comum 
  ----------------------------------------------------------------- */



/*
-- Confirma a existencia da linha da saldo
INSERT	
	Fin_ContaCorrenteSaldo 
	(
	IDContaCorrente, 
	Data, 
	Saldo
	)
	SELECT 	TQ.IDContaCorrente,
			TQ.Data,
			IsNull(
				( 
				SELECT  Saldo
				FROM	(
					SELECT 	MAX(FCC.Data) Data
					FROM	Fin_ContaCorrenteSaldo FCC
					WHERE	
						FCC.IDContaCorrente = TQ.IDContaCorrente
						AND
						FCC.Data < TQ.Data
					) SaldoAnterior	
					JOIN Fin_ContaCorrenteSaldo CCS
						ON (CCS.Data = SaldoAnterior.Data AND CCS.IDContaCorrente=TQ.IDContaCorrente )
				), 0)  

	FROM	
		(
		SELECT
			I.IDContaCorrente,
			Convert(DateTime, Convert(Char(20), I.DataQuitacao, 102)) as Data
		FROM
			Inserted I 
		GROUP BY 
			I.IDContaCorrente,
			Convert(DateTime, Convert(Char(20), I.DataQuitacao, 102)) 
		) AS TQ
		LEFT OUTER JOIN Fin_ContaCorrenteSaldo CCS 
			ON (CCS.IDContaCorrente = TQ.IDContaCorrente  
				AND
				CCS.Data = TQ.Data)
	WHERE	
		CCS.IDContaCorrente IS NULL

*/


/* 
   -----------------------------------------------------------------
	DELECAO 
   ----------------------------------------------------------------- 
*/

/*
UPDATE 	
	Fin_ContaCorrenteSaldo
SET	
	Saldo = Saldo - ((D.ValorQuitacao + D.ValorJuros) * (1 - D.Pagando * 2))
FROM	
	Deleted D 
WHERE	
	D.IDContaCorrente <> 0
	AND
	Fin_ContaCorrenteSaldo.IDContaCorrente = D.IDContaCorrente
	AND
	Fin_ContaCorrenteSaldo.Data >= Convert(DateTime, Convert(Char(20), D.DataQuitacao, 102))

*/

UPDATE 	
	Fin_ContaCorrente
SET	
	SaldoAtual = IsNull(SaldoAtual,0) - ((D.ValorQuitacao + D.ValorJuros) * (1 - D.Pagando * 2))
FROM	
	Deleted D 
WHERE	
	D.IDContaCorrente <> 0
	AND
	Fin_ContaCorrente.IDContaCorrente = D.IDContaCorrente

/* 
   -----------------------------------------------------------------
	Inclusao 
   ----------------------------------------------------------------- 
*/

/*
UPDATE 	
	Fin_ContaCorrenteSaldo
SET	
	Saldo = Saldo + ((I.ValorQuitacao + I.ValorJuros) * (1 - I.Pagando * 2))
FROM	
	Inserted I 
WHERE	
	I.IDContaCorrente <> 0
	AND
	Fin_ContaCorrenteSaldo.IDContaCorrente = I.IDContaCorrente
	AND
	Fin_ContaCorrenteSaldo.Data >= Convert(DateTime, Convert(Char(20), I.DataQuitacao, 102))

*/

UPDATE 	
	Fin_ContaCorrente
SET	
	SaldoAtual = IsNull(SaldoAtual, 0) + ((I.ValorQuitacao + I.ValorJuros) * (1 - I.Pagando * 2))
FROM	
	Inserted I 
WHERE	
	I.IDContaCorrente <> 0
	AND
	Fin_ContaCorrente.IDContaCorrente = I.IDContaCorrente
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_InventoryMov_All ON dbo.InventoryMov
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste da existencia de MODEL no Inventory
		- Teste existencia do MODEL  no Inventory MovTotals
		- Teste da existencia do MASTER no Inventory
		- Teste existencia do MASTER no Inventory MovTotals
		- Atualiza o LastMovDate no Model, se for Insert and Update
		- Atualiza o DateLastSellingPrice no Model, se for Insert and Update
		- INVENTORY e INVMASTER:  Atualiza QtyOnHand
		- MODEL e MODEL MASTER: Atualiza o Total no model
		- MODEL e MODEL MASTER: Atualiza o InventoryMovTotals


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	01 Aug  2001		Rodrigo Costa		Gravar o LastMovDate no Model;
	22 Aug  2001		Davi Gouveia		Gravar o DateLastSellingPrice no Model
	30 Oct	2003		Andre Bogado		Inserido cursor Inventory_Cursor
							Inserido cursor InventoryMaster_Cursor
							Inserido nome dos campos de InventoryMovTotal	
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON
--Declaração de variáveis para o Cursor de Inventory
DECLARE @StoreID 	int 
DECLARE @ModelID 	int 
DECLARE @IDInventory 	int


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	B O T H      I N S E R T      A N D      D E L E T E
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--   	Teste da existencia de MODEL no Inventory
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Declaração do Cursor de Inventory
DECLARE Inventory_Cursor CURSOR FOR

	SELECT
		IM.StoreID,
		IM.ModelID
	FROM
		Inserted IM
		LEFT OUTER JOIN
		Inventory I ON (IM.StoreID =I.StoreID AND IM.ModelID = I.ModelID)
	WHERE
		I.ModelID IS NULL
	GROUP BY
		IM.StoreID,
		IM.ModelID

OPEN Inventory_Cursor

--Inicialização de Inventory_Cursor
FETCH NEXT FROM Inventory_Cursor INTO
	@StoreID,
	@ModelID
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT

	INSERT Inventory
		(
		IDInventory,
		StoreID,
		ModelID
		)
	VALUES
		(
		@IDInventory,
		@StoreID,
		@ModelID
		)
	FETCH NEXT FROM Inventory_Cursor INTO
		@StoreID,
		@ModelID
END
--fechamento do cursor
CLOSE Inventory_Cursor
--Destruição do cursor
DEALLOCATE Inventory_Cursor

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Teste existencia do MODEL  no Inventory MovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT 	InventoryMovTotal
		(
		StoreID,
		ModelID,
		InventMovTypeID,
		Year,
		Month,
		TotQty,
		TotSale,
		TotCost
		)
	SELECT
		IT.StoreID,
		IT.ModelID,
		IT.InventMovTypeID,
		IT.Year,
		IT.Month,
		0,
		0,
		0
	FROM 	(
		SELECT
			Inserted.StoreID,
			Inserted.ModelID,
			Inserted.InventMovTypeID,
			DatePart(yy, Inserted.MovDate) Year,
			DatePart(mm, Inserted.MovDate) Month
 		FROM
			Inserted
		GROUP BY
			Inserted.StoreID,
			Inserted.ModelID,
			Inserted.InventMovTypeID,
                 		DatePart(yy, Inserted.MovDate),
			DatePart(mm, Inserted.MovDate)
		) IT
		LEFT OUTER JOIN InventoryMovTotal IMT
			ON (
				IMT.StoreID = IT.StoreID
				AND
				IMT.ModelID = IT.ModelID
				AND
				IMT.InventMovTypeID = IT.InventMovTypeID
				AND
				IMT.Year  = IT.Year
				AND
				IMT.Month = IT.Month )
	WHERE
		IMT.StoreID IS NULL



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--   	Teste da existencia do MASTER no Inventory
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Declaração do Cursor de Inventory Master
DECLARE InventoryMaster_Cursor CURSOR FOR
	SELECT
		IM.StoreID,
		M.IDModelParent
	FROM
		Inserted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
		LEFT OUTER JOIN
		Inventory I ON (IM.StoreID =I.StoreID AND M.IDModelParent = I.ModelID)
	WHERE
		I.ModelID IS NULL
		AND --Rodrigo
		M.IDModelParent IS NOT NULL
	GROUP BY
		IM.StoreID,
		M.IDModelParent

OPEN InventoryMaster_Cursor

--Inicialização de InventoryMaster_Cursor
FETCH NEXT FROM InventoryMaster_Cursor INTO
	@StoreID,
	@ModelID
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Inventory.IDInventory', @IDInventory OUTPUT

	INSERT Inventory
		(
		IDInventory,
		StoreID,
		ModelID
		)
	VALUES
		(
		@IDInventory,
		@StoreID,
		@ModelID
		)
	FETCH NEXT FROM InventoryMaster_Cursor INTO
		@StoreID,
		@ModelID
END
--fechamento do cursor
CLOSE InventoryMaster_Cursor
--Destruição do cursor
DEALLOCATE InventoryMaster_Cursor

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Teste existencia do MASTER no Inventory MovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT	InventoryMovTotal
		(
		StoreID,
		ModelID,
		InventMovTypeID,
		Year,
		Month,
		TotQty,
		TotSale,
		TotCost
		)
	SELECT
		IT.StoreID,
		IT.ModelID,
		IT.InventMovTypeID,
		IT.Year,
		IT.Month,
		0,
		0,
		0
	FROM 	(
		SELECT
			Inserted.StoreID,
			M.IDModelParent as ModelID,
			Inserted.InventMovTypeID,
			DatePart(yy, Inserted.MovDate) Year,
			DatePart(mm, Inserted.MovDate) Month
 		FROM
			Inserted
			JOIN
			Model M ON (Inserted.ModelID = M.IDModel)
		WHERE
			M.IDModelParent IS NOT NULL
		GROUP BY
			Inserted.StoreID,
			M.IDModelParent,
			Inserted.InventMovTypeID,
                 		DatePart(yy, Inserted.MovDate),
			DatePart(mm, Inserted.MovDate)
		) IT
		LEFT OUTER JOIN InventoryMovTotal IMT
			ON (
				IMT.StoreID = IT.StoreID
				AND
				IMT.ModelID = IT.ModelID
				AND
				IMT.InventMovTypeID = IT.InventMovTypeID
				AND
				IMT.Year  = IT.Year
				AND
				IMT.Month = IT.Month )
	WHERE
		IMT.StoreID IS NULL



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Atualiza o LastMovDate no Model, se for Insert and Update
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.LastMovDate 	= IM.MovDate
FROM
	Inserted IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
WHERE
	IsNull(M.LastMovDate,0)	< IM.MovDate


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Atualiza o DateLastSellingPrice no Model, se for Insert and Update
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.DateLastSellingPrice = IM.MovDate
FROM
	Inserted IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
WHERE
	IM.InventMovTypeID = 1
	AND
	IM.MovDate > IsNull(M.DateLastSellingPrice,0)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	D E L E T E
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Parte da Delecao do SerialMov
--   	Só executa se for delete mesmo, nao se for update
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE
	SM
FROM
	SerialMov SM
	JOIN
	Deleted IMD ON (IMD.IDInventoryMov = SM.InventoryMovID)
	LEFT OUTER JOIN
	Inserted IMI ON (IMI.IDInventoryMov = SM.InventoryMovID)
WHERE
	IMI.IDInventoryMov IS NULL


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY:  Atualiza QtyOnHand
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) - Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) - Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) - Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) - Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		StoreID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted IM
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN
        Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER:  Atualiza QtyOnHand
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) - Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) - Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) - Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) - Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		IM.StoreID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL

	GROUP BY
		M.IDModelParent,
		IM.StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) - Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) - Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) - Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) - Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted IM
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN
	Model M ON (Total.ModelID = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL MASTER: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) - Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) - Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) - Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) - Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		IDModelParent,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN
        Model M ON (Total.IDModelParent = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) - Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) - Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) - Total.Cost
FROM
	(
	SELECT
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		Deleted IM
	GROUP BY
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year]
			AND
			Total.[Month] = IMT.[Month] )



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MASTER: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) - Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) - Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) - Total.Cost
FROM
	(
	SELECT
		IM.StoreID,
		M.IDModelParent as ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		Deleted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IM.StoreID,
		M.IDModelParent,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year]
			AND
			Total.[Month] = IMT.[Month] )



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	I N S E R T
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY: Atualiza QtyOnHand
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		StoreID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted IM
		JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER: Atualiza QtyOnHand
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		StoreID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted IM
		JOIN Model M ON (IM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL

	GROUP BY
		M.IDModelParent,
		StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o Total no Model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted IM
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN
	Model M ON (Total.ModelID = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MASTER: Atualiza o Total no Master
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		IDModelParent,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted IM
		JOIN Model M ON (IM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN
	Model M ON (Total.IDModelParent = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
	(
	SELECT
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		Inserted IM
	GROUP BY
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year]
			AND
			Total.[Month] = IMT.[Month] )



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MASTER: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
	(
	SELECT
		IM.StoreID,
		M.IDModelParent as ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		Inserted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IM.StoreID,
		M.IDModelParent,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year]
			AND
			Total.[Month] = IMT.[Month] )


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Media_InsUpt ON dbo.Media
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia da Media


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if  	@@rowcount = 0
	return

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDMedia
		FROM
			INSERTED,
			Media
		WHERE
			INSERTED.Media = Media.Media
			AND
			Media.IDMedia <> INSERTED.IDMedia
			AND
			INSERTED.Desativado = 0
			AND
			Media.Desativado = 0
		)
	BEGIN
		RAISERROR ('DUP_Media_Media can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_MeioPag_Del on dbo.MeioPag
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de MeioPagToStore


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@ROWCOUNT = 0 RETURN

SET NOCOUNT ON

DELETE
	MeioPagToStore
FROM
	MeioPag,
	Deleted
WHERE
	MeioPagToStore.IDMeioPag = DELETED.IDMeioPag
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_MeioPag_InsUpt on dbo.MeioPag
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do MeioPag
		- Insiro MeioPagToStore


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0 RETURN

SET NOCOUNT ON

IF	EXISTS 	(
		SELECT	INSERTED.IDMeioPag
		FROM	INSERTED, MeioPag
		WHERE 	INSERTED.MeioPag = MeioPag.MeioPag	  AND
			MeioPag.IDMeioPag <> INSERTED.IDMeioPag	  AND
			INSERTED.Desativado =0 		  AND
			MeioPag.Desativado = 0
		)
	
	BEGIN
		RAISERROR ('DUP_MeioPag_MeioPag can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN	
	END

/* So faz na inclusao  */

IF 	NOT EXISTS	
		(
		SELECT
			Deleted.IDMeioPag
		FROM	
			Deleted
		)
	BEGIN
		INSERT 
			MeioPagToStore (IDStore, IDMeioPag) 
		SELECT 
			Store.IDStore, Inserted.IDMeioPag 
		FROM
			Store, Inserted


		INSERT 
			MeioPagMinSale (IDMeioPag, DifDay, TotalSale) 
		SELECT 
			INSERTED.IDMeioPag, 0, 0 
		FROM 
			INSERTED
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER tr_MenuItem_delete on dbo.MenuItem
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto UserRights


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@RowCount = 0
   Return

SET NOCOUNT ON

DELETE
	UserRights
FROM
	UserRights,
	Deleted
WHERE
	UserRights.MenuID = Deleted.IDMenu
	AND
	UserRights.SubMenuID = Deleted.IDSubMenu


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE TRIGGER tr_MenuItem_insert on dbo.MenuItem
FOR INSERT
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro em UserRights


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@RowCount = 0
   RETURN

SET NOCOUNT ON

INSERT
	UserRights
SELECT
	UserType.IDUserType,
	Inserted.IDMenu,
	Inserted.IDSubMenu,
	0,
	0,
	0,
	0,
	0
FROM
	UserType,
	Inserted


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER  tr_Model_InsUpt on dbo.Model
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Be shure there is no duplicated Model
		- If deactivate the master model l, deactivate all submodels


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

-- Be shure there is no duplicated Model

IF @@RowCount = 0
   RETURN -- Nothing to do

SET NOCOUNT ON

IF EXISTS
	(
	SELECT
		I.IDModel
	FROM
		INSERTED I,
		Model M
	WHERE
		I.Model = M.Model -- The same code
		AND
		I.IDModel <> M.IDModel	 -- With other model
		AND
		I.ModelType <> 'S'   -- Not a SubModel
		AND
		M.ModelType <> 'S'   -- Not a SubModel
		AND
		I.Desativado = 0  AND M.Desativado = 0 -- Both them active
	)
	BEGIN
		RAISERROR ('DUP_Model_Model can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

-- If deactivate the master model l, deactivate all submodels

UPDATE
	SM
SET
	SM.Desativado = MM.Desativado
FROM
	Inserted MM
	JOIN Model SM ON (MM.IDModel = SM.IDModelParent)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_ModelTransfDet_All ON dbo.ModelTransfDet
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Parte da Delecao do InventoryMov
                - Parte da Insercao do InventoryMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	30 Oct  2003		Andre Bogado		Declaracao de InventoryMov_Cursor
							Chamada a sp_Sis_GetNextCode
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID 		int 
DECLARE @StoreIDOrigem 		int 
DECLARE @StoreIDDestino 	int 
DECLARE @ModelID 		int 
DECLARE @Qty 			int 
DECLARE @IDUser 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDInventoryMov    	int

/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/
DELETE
	InventoryMov
FROM
	DELETED
WHERE	( InventoryMov.InventMovTypeID >= 7 AND InventoryMov.InventMovTypeID <= 8 )
	AND
	InventoryMov.DocumentID = DELETED.IDModelTransf
	AND
	DELETED.IDModelTransfDet = InventoryMov.PreInventoryMovID

/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE InventoryMov_Cursor CURSOR FOR
	SELECT
		INSERTED.IDModelTransf,
		ModelTransf.IDLojaOrigem,
		ModelTransf.IDLojaDestino,
		INSERTED.IDModel,
		INSERTED.Qty,
		ModelTransf.IDUser,
		INSERTED.IDModelTransfDet
	FROM
		INSERTED,
		ModelTransf
	WHERE
		INSERTED.IDModelTransf = ModelTransf.IDModelTransf

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@DocumentID,
	@StoreIDOrigem,
	@StoreIDDestino,
	@ModelID,
	@Qty,
	@IDUser,
	@PreInventoryMovID
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
--Inclusao da loja original
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		PreInventoryMovID
		)
	VALUES
		(
		@IDInventoryMov,
		7,   /* saida da loja original */
		@DocumentID,
		@StoreIDOrigem,
		@ModelID,
		0,
		GetDate(),
		@Qty,
		@IDUser,
		@PreInventoryMovID
		)

--Inclusao da loja destino
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT	InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		PreInventoryMovID  /* guarda a linha correspondente a inserida */
		)
	VALUES
		(
		@IDInventoryMov,
		8,    /* entrada da loja destino */
		@DocumentID,
		@StoreIDDestino,
		@ModelID,
		0,
		GetDate(),
		@Qty,
		@IDUser,
		@PreInventoryMovID
		)

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@IDUser,
		@PreInventoryMovID
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER tr_POItemRequest_All ON POItemRequest
FOR INSERT, UPDATE, DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualiza QtyOrdered em Request


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

UPDATE
	R
SET
	R.QtyOrdered = IsNull(R.QtyOrdered, 0) - T.Qty
FROM
	Request R
	JOIN 	(

		SELECT
			POIR.IDRequest,
			SUM(POIR.Qty) as Qty
		FROM
			Deleted POIR
		GROUP BY
			POIR.IDRequest

		) as T ON (T.IDRequest = R.IDRequest)



UPDATE
	R
SET
	R.QtyOrdered = IsNull(R.QtyOrdered, 0) + T.Qty
FROM
	Request R
	JOIN 	(
		SELECT
			POIR.IDRequest,
			SUM(IsNull(POIR.Qty, 0)) as Qty
		FROM
			Inserted POIR
		GROUP BY
			POIR.IDRequest

		) as T ON (T.IDRequest = R.IDRequest)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Pessoa_All on dbo.Pessoa
FOR DELETE,INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Esta trigger deve incluir um novo codigo para a pesso seguinto o ultimo incluido
	para o tipo de pessoa


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

UPDATE
	Pessoa
SET
	Code = IsNull(TP.LastCode, 0) + 1,
	IDTipoPessoaRoot = Tp.IDTipoPessoa
FROM
	((TipoPessoa TP1
	JOIN
	Inserted I ON ( TP1.IDTipoPessoa = I.IDTipoPessoa AND I.IDTipoPessoa <> 0 ))
	JOIN
	TipoPessoa TP ON ( CASE SUBSTRING(TP1.Path, 1, 4)
		WHEN '.003' THEN SUBSTRING(TP1.Path, 1, 8)
		ELSE SUBSTRING(TP1.Path, 1, 4)
		END = TP.Path ))
WHERE
	Pessoa.IDPessoa = I.IDPessoa
	AND
	Pessoa.Code is Null

UPDATE
	TipoPessoa
SET
	LastCode = IsNull(LastCode, 0) + 1
FROM	(
	SELECT	CASE SUBSTRING(TP.Path, 1, 4)
		WHEN '.003' THEN SUBSTRING(TP.Path, 1, 8)
		ELSE SUBSTRING(TP.Path, 1, 4)
		END Path
	FROM
		Inserted I JOIN TipoPessoa TP ON ( I.IDTipoPessoa = TP.IDTipoPessoa)
	WHERE
		I.Code Is Null
		AND
		I.IDTipoPessoa <> 0
	) A
WHERE
	A.Path = TipoPessoa.Path
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE TRIGGER tr_PreInventMov_All ON dbo.PreInventoryMov
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste da existencia de Model e do MASTER no Inventory
		- INVENTORY e INVENTORY MASTER:  QtyOnPreSale & QtyOnOrder
		- MODEL e MODEL MASTER: Atualiza o Total no model


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	30 Oct  2003		Rodrigo Costa		Inserido cursor Inventory_Cursor
							Inserido cursor InventoryMaster_Cursor
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON
--Declaração de variáveis para o Cursor de Inventory
DECLARE @StoreID 	int 
DECLARE @ModelID 	int 
DECLARE @IDInventory 	int

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	B O T H      I N S E R T      A N D      D E L E T E
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--   	Teste da existencia de Model no Inventory
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Declaração do Cursor de Inventory
DECLARE Inventory_Cursor CURSOR FOR
	SELECT
		PIM.StoreID,
		PIM.ModelID
	FROM
		Inserted PIM
		LEFT OUTER JOIN
		Inventory I ON (PIM.StoreID =I.StoreID AND PIM.ModelID = I.ModelID)
	WHERE
		I.ModelID IS NULL
		AND
		PIM.ModelID IS NOT NULL
		AND
		PIM.StoreID IS NOT NULL
	GROUP BY
		PIM.StoreID,
		PIM.ModelID

OPEN Inventory_Cursor

--Inicialização de Inventory_Cursor
FETCH NEXT FROM Inventory_Cursor INTO
	@StoreID,
	@ModelID
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
	INSERT Inventory
		(
		IDInventory,
		StoreID,
		ModelID
		)
	VALUES
		(
		@IDInventory,
		@StoreID,
		@ModelID
		)
	FETCH NEXT FROM Inventory_Cursor INTO
		@StoreID,
		@ModelID
END
--fechamento do cursor
CLOSE Inventory_Cursor
--Destruição do cursor
DEALLOCATE Inventory_Cursor
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--   	Teste da existencia do MASTER no Inventory
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Declaração do Cursor de Inventory Master
DECLARE InventoryMaster_Cursor CURSOR FOR
	SELECT
		PIM.StoreID,
		M.IDModelParent
	FROM
		Inserted PIM
		JOIN
		Model M ON (PIM.ModelID = M.IDModel)
		LEFT OUTER JOIN
		Inventory I ON (PIM.StoreID =I.StoreID AND M.IDModelParent = I.ModelID)
	WHERE
		I.ModelID IS NULL
		AND
		M.IDModelParent IS NOT NULL
	GROUP BY
		PIM.StoreID,
		M.IDModelParent
OPEN InventoryMaster_Cursor

--Inicialização de InventoryMaster_Cursor
FETCH NEXT FROM InventoryMaster_Cursor INTO
	@StoreID,
	@ModelID
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Inventory.IDInventory', @IDInventory OUTPUT

	INSERT Inventory
		(
		IDInventory,
		StoreID,
		ModelID
		)
	VALUES
		(
		@IDInventory,
		@StoreID,
		@ModelID
		)
	FETCH NEXT FROM InventoryMaster_Cursor INTO
		@StoreID,
		@ModelID
END
--fechamento do cursor
CLOSE InventoryMaster_Cursor
--Destruição do cursor
DEALLOCATE InventoryMaster_Cursor

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	D E L E T E
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY:  QtyOnPreSale & QtyOnOrder
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) - Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) - Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) - Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) - Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		StoreID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted PIM
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		PIM.ModelID IS NOT NULL
		AND
		PIM.StoreID IS NOT NULL
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER:  QtyOnPreSale & QtyOnOrder
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) - Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) - Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) - Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) - Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		PIM.StoreID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted PIM
		JOIN Model M ON (PIM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		M.IDModelParent,
		PIM.StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) - Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) - Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) - Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) - Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted PIM
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN
	Model M ON (Total.ModelID = M.IDModel)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL MASTER: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) - Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) - Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) - Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) - Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		IDModelParent,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted PIM
		JOIN
		Model M ON (PIM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN
	Model M ON (Total.IDModelParent = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	I N S E R T
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   Atualiza QtyOnPreSale & QtyOnOrder
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		StoreID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted PIM
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		PIM.ModelID IS NOT NULL
		AND
		PIM.StoreID IS NOT NULL
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER:  QtyOnPreSale & QtyOnOrder
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		PIM.StoreID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted PIM
		JOIN
		Model M ON (PIM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		M.IDModelParent,
		PIM.StoreID
	) Total
	JOIN
        Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted PIM
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN
	Model M ON (Total.ModelID = M.IDModel)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL MASTER: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		IDModelParent,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted PIM
		JOIN
		Model M ON (PIM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN
	Model M ON (Total.IDModelParent = M.IDModel)




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Pur_PurchaseQtyOrder_All ON dbo.Pur_PurchaseQtyOrder
FOR INSERT, UPDATE, DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste da existencia de Model no Inventory
		- Atualizo PreInentoryMov  QtyRealMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	30 Oct	2003		Rodrigo Costa		Criacao do Cursor Inventory_Cursor;
							Chamada para sp_GetNextCode;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON

--Declaração de variáveis para o Cursor de Inventory
DECLARE @StoreID 	int 
DECLARE @ModelID 	int 
DECLARE @IDInventory	int

/*--------------------------------------------------------------*/
/*		Teste da existencia de Model no Inventory       */
/*--------------------------------------------------------------*/

--Declaração do Cursor de Inventory

DECLARE Inventory_Cursor CURSOR FOR

	SELECT
		Inserted.IDStore,
		Inserted.IDModel
	FROM
		Inserted
	WHERE
	 	NOT EXISTS
		(
		SELECT
			Inventory.StoreID
		FROM
			Inventory Inventory
		WHERE
			Inventory.StoreID = Inserted.IDStore
			AND
			Inventory.ModelID = Inserted.IDModel
		)

	GROUP BY
		Inserted.IDStore,
		Inserted.IDModel

OPEN Inventory_Cursor

--Inicialização de Inventory_Cursor
FETCH NEXT FROM Inventory_Cursor INTO
	@StoreID,
	@ModelID

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT

	INSERT Inventory
		(
		IDInventory,
		StoreID,
		ModelID
		)
	VALUES
		(
		@IDInventory,
		@StoreID,
		@ModelID
		)

	FETCH NEXT FROM Inventory_Cursor INTO
		@StoreID,
		@ModelID
END

--fechamento do cursor
CLOSE Inventory_Cursor
--Destruição do cursor
DEALLOCATE Inventory_Cursor


/*----------------------------------------------------------*/
/*		DELETE                     */
/*----------------------------------------------------------*/

-- PreInentoryMov  QtyRealMov

UPDATE
	PIM
SET
	PIM.QtyRealMov = IsNull(PIM.QtyRealMov, 0) -
			IsNull(
			(
			SELECT
				SUM(IsNull(DelPrePurchase.Qty, 0))
			FROM
				Deleted DelPrePurchase
			WHERE
				DelPrePurchase.IDPOItem = PIM.IDPreInventoryMov
			), 0)


FROM
	PreInventoryMov PIM,
	Deleted
WHERE
	Deleted.IDPOItem = PIM.IDPreInventoryMov
	AND
	Deleted.IDPOItem IS NOT NULL

/*----------------------------------------------------------*/
/*		INSERT	        */
/*----------------------------------------------------------*/

-- PreInentoryMov  QtyRealMov

UPDATE
	PIM
SET
	PIM.QtyRealMov = IsNull(PIM.QtyRealMov, 0) +
			IsNull(
			(
			SELECT
				SUM(IsNull(InsPrePurchase.Qty, 0))
			FROM
				Inserted InsPrePurchase
			WHERE
				InsPrePurchase.IDPOItem = PIM.IDPreInventoryMov
			), 0)


FROM
	PreInventoryMov PIM,
	Inserted
WHERE
	Inserted.IDPOItem = PIM.IDPreInventoryMov
	AND
	Inserted.IDPOItem IS NOT NULL

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Pur_PurchaseQtyPrePurchase_All ON dbo.Pur_PurchaseQtyPrePurchase
FOR INSERT, UPDATE, DELETE 
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste da existencia de Model no Inventory
		- Delecao do Inventory Movement QtyOnPrePurchase
		- Delecao do Inventory Movement QtyOnPrePurchase no Model Master
		- Insercao do Inventory Movement QtyOnPreSalePurchase
		- Insercao do Inventory Movement QtyOnPreSalePurchase no Model Master


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	30 Oct	2003		Rodrigo Costa		Criacao do Cursor Inventory_Cursor;
							Chamada para sp_GetNextCode;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON

--Declaração de variáveis para o Cursor de Inventory
DECLARE @StoreID 	int 
DECLARE @ModelID 	int 
DECLARE @IDInventory	int

/*--------------------------------------------------------------*/
/*		Teste da existencia de Model no Inventory       */
/*--------------------------------------------------------------*/
--Declaração do Cursor de Inventory
DECLARE Inventory_Cursor CURSOR FOR

	SELECT 
		Inserted.IDStore, 
		Inserted.IDModel
	FROM 	
		Inserted
	WHERE
	 	NOT EXISTS
		(
		SELECT 	
			Inventory.StoreID
		FROM 	
			Inventory Inventory
		WHERE
			Inventory.StoreID = Inserted.IDStore  
			AND
			Inventory.ModelID = Inserted.IDModel  
		)

	GROUP BY 
		Inserted.IDStore, 
		Inserted.IDModel 

OPEN Inventory_Cursor

--Inicialização de Inventory_Cursor
FETCH NEXT FROM Inventory_Cursor INTO
	@StoreID,
	@ModelID

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT

	INSERT Inventory
		(
		IDInventory,
		StoreID,
		ModelID
		)
	VALUES
		(
		@IDInventory,
		@StoreID,
		@ModelID
		)
	FETCH NEXT FROM Inventory_Cursor INTO
		@StoreID,
		@ModelID
END
--fechamento do cursor
CLOSE Inventory_Cursor
--Destruição do cursor
DEALLOCATE Inventory_Cursor

/* --------------------------------------------------------- 
DELECAO  
-------------------------------------*/

/*----------------------------------------------------------*/
/*		Delecao do Inventory Movement	QtyOnPrePurchase  */
/*----------------------------------------------------------*/

UPDATE
	Inventory 
SET 	
	Inventory.QtyOnPrePurchase = IsNull(Inventory.QtyOnPrePurchase, 0) -
			IsNull(
			(
			SELECT
				SUM(IsNull(DelPrePurchase.Qty, 0))	
			FROM	
				Deleted DelPrePurchase
			WHERE
				DelPrePurchase.IDModel = Inventory.ModelID 	
				AND
				DelPrePurchase.IDStore = Inventory.StoreID
			), 0)

		
FROM 	
	Inventory Inventory, 
	Deleted
WHERE 	
	Deleted.IDModel = Inventory.ModelID 	
	AND
	Deleted.IDStore = Inventory.StoreID


/*--------------------------------------------------------------*/
/*		Delecao do Inventory Movement	QtyOnPrePurchase no Model Master       */
/*--------------------------------------------------------------*/


UPDATE
	I
SET
	I.QtyOnPrePurchase = IsNull(I.QtyOnPrePurchase, 0) - Total.QtyPrePruchase
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		DEL.IDStore as StoreID,
		SUM( IsNull(DEL.Qty, 0) ) as QtyPrePruchase
	FROM
		Deleted DEL
		JOIN
		Model M ON (DEL.IDModel = M.IDModel)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		M.IDModelParent,
		DEL.IDStore
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)

/* --------------------------------------------------------- INCLUSAO  -------------------------------------*/
/*----------------------------------------------------------*/
/*		Insercao do Inventory Movement QtyOnPreSalePurchase  */
/*----------------------------------------------------------*/

UPDATE 	
	Inventory 
SET 	
	Inventory.QtyOnPrePurchase = IsNull(Inventory.QtyOnPrePurchase, 0) +
			IsNull(
			(
			SELECT 	
				SUM(IsNull(InsPrePurchase.Qty, 0))	
			FROM	
				Inserted InsPrePurchase
			WHERE
				InsPrePurchase.IDModel = Inventory.ModelID 	
				AND
				InsPrePurchase.IDStore = Inventory.StoreID
			), 0)

FROM 	
	Inventory Inventory, 
	Inserted
WHERE 	
	Inserted.IDModel = Inventory.ModelID 	
	AND
	Inserted.IDStore = Inventory.StoreID


/*----------------------------------------------------------*/
/*		Insercao do Inventory Movement QtyOnPreSalePurchase  no Model Master*/
/*----------------------------------------------------------*/


UPDATE
	I
SET
	I.QtyOnPrePurchase = IsNull(I.QtyOnPrePurchase, 0) + Total.QtyPrePruchase
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		INS.IDStore as StoreID,
		SUM( IsNull(INS.Qty, 0) ) as QtyPrePruchase
	FROM
		Inserted INS
		JOIN
		Model M ON (INS.IDModel = M.IDModel)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		M.IDModelParent,
		INS.IDStore
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_RamoAtividade_InsUpt ON dbo.RamoAtividade
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do RamoAtividade


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@RowCount = 0
   return

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDRamoAtividade
		FROM
			INSERTED,
			RamoAtividade
		WHERE
			INSERTED.RamoAtividade = RamoAtividade.RamoAtividade
			AND
			RamoAtividade.IDRamoAtividade <> INSERTED.IDRamoAtividade
			AND
			INSERTED.Desativado = 0
			AND
			RamoAtividade.Desativado = 0
		)
	BEGIN
		RAISERROR ('DUP_RamoAtividade_RamoAtividade can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Sis_Empresa_All ON dbo.Sis_Empresa
FOR INSERT
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro em Sis_GrupoEmpresa


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/*
   ------------------------------------------------------------------------------
	INSERCAO
   ------------------------------------------------------------------------------
*/
INSERT	Sis_GrupoEmpresa (IDGrupo, IDEmpresa, Permissao)
	(
	SELECT 	G.IDGrupo,
		I.IDEmpresa,
		CASE IDGrupo
			WHEN C.Valor THEN 1
			ELSE 0
		END
	FROM	Sis_Grupo G,
		Inserted I,
		Sis_Constante C
	WHERE	C.Constante = 'Grupo_Administradores'
	)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Sis_Grupo_All ON dbo.Sis_Grupo
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Este novo trigger devera manter a integridade entre as seguintes tabelas
		-- Sis_GrupoMainMenu
		-- Sis_GrupoMainMenuPagina
		-- Sis_GrupoMainMenuOperacao
		-- Sis_GrupoEmpresa


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/* ---------------------------------------------------
	Delecao
   --------------------------------------------------- */ 
DELETE 	Sis_GrupoMainMenu 
FROM 	Deleted D 
WHERE 	Sis_GrupoMainMenu.IDGrupo = D.IDGrupo

DELETE 	Sis_GrupoMainMenuPagina
FROM 	Deleted D 
WHERE 	Sis_GrupoMainMenuPagina.IDGrupo = D.IDGrupo

DELETE 	Sis_GrupoMainMenuOperacao
FROM 	Deleted D 
WHERE 	Sis_GrupoMainMenuOperacao.IDGrupo = D.IDGrupo

DELETE 	Sis_GrupoEmpresa
FROM 	Deleted D 
WHERE 	Sis_GrupoEmpresa.IDGrupo = D.IDGrupo


/* ---------------------------------------------------
	Insercao
   --------------------------------------------------- */
INSERT	Sis_GrupoMainMenu ( IDGrupo, IDMenuItem )
	( 
	SELECT	I.IDGrupo, 
		MM.IDMenuItem
	FROM	Inserted I,
		Sis_MainMenu MM
	)
	
INSERT	Sis_GrupoMainMenuPagina ( IDGrupo, IDMenuItem, PaginaNome )
	(
	SELECT	I.IDGrupo, 
		MMP.IDMenuItem,
		MMP.PaginaNome
	FROM	Inserted I,
		Sis_MainMenuPagina MMP
	)
INSERT	Sis_GrupoMainMenuOperacao ( IDGrupo, IDMenuItem, IDOperacao )
	(
	SELECT	I.IDGrupo,
		MMO.IDMenuItem,
		MMO.IDOperacao
	FROM	Inserted I,
		Sis_MainMenuOperacao MMO
	)
INSERT	Sis_GrupoEmpresa ( IDGrupo, IDEmpresa )
	(
	SELECT	I.IDGrupo, 
		E.IDEmpresa
	FROM	Inserted I,
		Sis_Empresa E
	)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Sis_MainMenu_Insert ON dbo.Sis_MainMenu
FOR INSERT
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Deve manter integridade com
		-- Sis_GrupoMainMenu


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/*
  -----------------------------------------------------------
	INSERSAO
  -----------------------------------------------------------
*/
DELETE 	Sis_GrupoMainMenu
FROM	Deleted D
WHERE	Sis_GrupoMainMenu.IDMenuItem = D.IDMenuItem
/*
  -----------------------------------------------------------
	DELECAO
  ----------------------------------------------------------- 
*/
INSERT 	Sis_GrupoMainMenu (IDGrupo, IDMenuItem, Acessa)
	(
	SELECT 	G.IDGrupo,
		I.IDMenuItem,
		CASE IDGrupo
			WHEN C.Valor THEN 1
			ELSE 0
		END
	FROM	Inserted I,
		Sis_Grupo G,
		Sis_Constante C
	WHERE	C.Constante = 'Grupo_Administradores'
	)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER Tr_Sis_MainMenuOperacao_All ON dbo.Sis_MainMenuOperacao
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Mantem integridade com Sis_GrupoMainMenuOperacao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/*

------------------------------------------------------
	Delete
------------------------------------------------------

*/


DELETE 	Sis_GrupoMainMenuOperacao
FROM	Deleted D
WHERE	D.IDOperacao = Sis_GrupoMainMenuOperacao.IDOperacao
	AND
	D.IDMenuItem = Sis_GrupoMainMenuOperacao.IDMenuitem



/*

------------------------------------------------------
	Insert
------------------------------------------------------

*/

INSERT 	Sis_GrupoMainMenuOperacao (IDOperacao, IDMenuItem, IDGrupo, Permissao)
	(
	SELECT 	I.IDOperacao,
		I.IDMenuItem,
		G.IDGrupo,
		CASE G.IDGrupo
		  WHEN 1 THEN 1
		  ELSE 0
		END
	FROM	Inserted I, Sis_Grupo G
	)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER Tr_Sis_MainMenuPagina_All ON dbo.Sis_MainMenuPagina
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Mantem integridade com Sis_GrupoMainMenuPagina


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/*

------------------------------------------------------
	Delete
------------------------------------------------------

*/


DELETE 	Sis_GrupoMainMenuPagina
FROM	Deleted D
WHERE	D.PaginaNome = Sis_GrupoMainMenuPagina.PaginaNome
	AND
	D.IDMenuItem = Sis_GrupoMainMenuPagina.IDMenuitem



/*

------------------------------------------------------
	Insert
------------------------------------------------------

*/


INSERT 	Sis_GrupoMainMenuPagina (PaginaNome, IDMenuItem, IDGrupo, PaginaVisivel, PaginaSoLeitura)
	(
	SELECT 	I.PaginaNome,
		I.IDMenuItem,
		G.IDGrupo,
		CASE G.IDGrupo
		  WHEN 1 THEN 1
		  ELSE 0
		END,
		CASE G.IDGrupo
		  WHEN 1 THEN 1
		  ELSE 0
		END
	FROM	Inserted I, Sis_Grupo G
	)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Sis_Moeda_All ON dbo.Sis_Moeda
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Quando atualizar uma moeda para padrao,
		Atualizar todos os Valores de todas as moedas
		para refletirem a nova moeda padrão

  		- Desligar a antiga


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	30 Oct	2003		Rodrigo Costa		Chama sp_GetNextCode;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON
DECLARE @IDMoedaCotacao int

IF NOT UPDATE (MoedaPadrao) Return

/*
	Calcula o fator de conversao
*/
DECLARE @Fator 	Money
SELECT	@Fator= (
		SELECT 	CASE
			   WHEN M.ValorMoedaPadrao = 0 THEN 1
			   ELSE (1 / M.ValorMoedaPadrao)
			END
		FROM 	Sis_Moeda M,
			Inserted I
		WHERE	M.IDMoeda = I.IDMoeda
			AND
			I.MoedaPadrao = 1
		)

/*
	Multiplica todas as moedas pelo fator calculado
	Retira a marca de MoedaPadrao
*/
UPDATE	
	Sis_Moeda
SET	
	Sis_Moeda.MoedaPadrao = 0,
	Sis_Moeda.ValorMoedaPadrao = Sis_Moeda.ValorMoedaPadrao * @Fator
FROM	
	Inserted I
WHERE	
	I.IDMoeda <> Sis_Moeda.IDMoeda
	AND
	I.MoedaPadrao = 1
	AND
	Sis_Moeda.MoedaPadrao = 1



UPDATE	
	Sis_Moeda
SET	
	Sis_Moeda.MoedaPadrao = 1
FROM	
	Inserted I
WHERE	
	I.IDMoeda = Sis_Moeda.IDMoeda
	AND
	I.MoedaPadrao = 1

/*
	Multiplica todas as cotacões pelo fator calculado
	primeiro as outras, depois a nova padrao
*/

UPDATE	
	Sis_MoedaCotacao
SET	
	Sis_MoedaCotacao.ValorMoedaPadrao = Sis_MoedaCotacao.ValorMoedaPadrao * @Fator
FROM	
	Inserted I
WHERE	
	Sis_MoedaCotacao.IDMoeda <> I.IDMoeda
	AND
	I.MoedaPadrao = 1

UPDATE	
	Sis_MoedaCotacao
	SET Sis_MoedaCotacao.ValorMoedaPadrao = 1
FROM	
	Inserted I
WHERE	
	Sis_MoedaCotacao.IDMoeda = I.IDMoeda
	AND
	I.MoedaPadrao = 1

/*
	Inclui a nova cotacao com o valormoedaopadrao 1
*/

EXEC sp_Sis_GetNextCode'Sis_MoedaCotacao.IDMoedaCotacao', @IDMoedaCotacao OUTPUT
INSERT	Sis_MoedaCotacao (IDMoedaCotacao, IDMoeda, ValorMoedaPadrao, DataCotacao)
	(
	SELECT
		@IDMoedaCotacao,	
		I.IDMoeda,
		1,
		GetDate()
	FROM	
		Inserted I
	WHERE	
		I.MoedaPadrao = 1
	)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Sis_MoedaCotacao_All ON dbo.Sis_MoedaCotacao
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Pega sempre o max da data e coloca na Moeda


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

UPDATE	Sis_Moeda
SET	Sis_Moeda.ValorMoedaPadrao = MC.ValorMoedaPadrao,
	Sis_Moeda.DataCotacao = MC.DataCotacao,
	Sis_Moeda.IDMoedaCotacao = MC.IDMoedaCotacao
FROM	Sis_MoedaCotacao MC,
	(
		SELECT 	I.IDMoeda, 
			Max(IMC.DataCotacao) MaxDataCotacao 
		FROM 	Inserted I,
			Sis_MoedaCotacao IMC
		WHERE	I.IDMoeda = IMC.IDMoeda
		GROUP BY I.IDMoeda
	) MA
	
WHERE	Sis_Moeda.IDMoeda = MA.IDMoeda
	AND
	MC.IDMoeda = MA.IDMoeda
	AND
	MC.DataCotacao = MA.MaxDataCotacao
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_SpecialPrice_delete ON dbo.SpecialPrice
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto SpecialPriceByGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@RowCount = 0
   Return

SET NOCOUNT ON

DELETE
	SpecialPriceByGroup
FROM
	SpecialPriceByGroup,
	Deleted
WHERE
	SpecialPriceByGroup.SpecialPriceID = Deleted.IDSpecialPrice
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_SpecialPrice_insert ON dbo.SpecialPrice
FOR INSERT, UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do SpecialPrice
		- Insiro em SpecialPriceByGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@RowCount = 0
   return

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDSpecialPrice
		FROM
			INSERTED,
			SpecialPrice
		WHERE
			INSERTED.SpecialPrice = SpecialPrice.SpecialPrice
			AND
			SpecialPrice.IDSpecialPrice <> INSERTED.IDSpecialPrice
			AND
			INSERTED.Desativado = 0
			AND
			SpecialPrice.Desativado = 0
			)
	BEGIN
		RAISERROR ('DUP_SpecialPrice_SpecialPrice can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */

if 	NOT EXISTS
			(
			SELECT
				Deleted.IDSpecialPrice
			FROM
				Deleted
			)
	BEGIN
		INSERT
			SpecialPriceByGroup
			SELECT
			Inserted.IDSpecialPrice,
			TabGroup.IDGroup,
			0
			FROM
			TabGroup,
			Inserted
			WHERE
			TabGroup.Desativado = 0
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Store_InsUpt ON dbo.Store
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia da Store
		- Insiro em MeioPagToStore
		- Insiro em StoreToTabGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT	INSERTED.IDStore
		FROM	INSERTED, Store
		WHERE 	INSERTED.Name = Store.Name	AND
			Store.IDStore <> INSERTED.IDStore	AND
			INSERTED.Desativado = 0 		AND
			Store.Desativado = 0
		)
	BEGIN
		RAISERROR ('DUP_Store_Name can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END


/* So faz na inclusao  */

INSERT MeioPagToStore (IDStore, IDMeioPag)
	SELECT
		I.IDStore, MP.IDMeioPag
	FROM
		Inserted I
		LEFT OUTER JOIN Deleted D ON (I.IDStore = D.IDStore),
		MeioPag MP
	WHERE
		D.IDStore IS NULL

INSERT StoreToTabGroup  (IDStore, IDGroup)
	SELECT
		I.IDStore, TG.IDGroup
	FROM
		Inserted I
		LEFT OUTER JOIN Deleted D ON (I.IDStore = D.IDStore),
		TabGroup TG
	WHERE
		D.IDStore IS NULL
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_SysFunction_Delete ON dbo.SysFunction
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de UserTypeToSysFunction


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

DELETE
	UserTypeToSysFunction
FROM
	DELETED
WHERE
	UserTypeToSysFunction.IDSysFunction = DELETED.IDSysFunction
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_SysFunction_Insert ON dbo.SysFunction
FOR INSERT
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro em UserTypeToSysFunction


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

INSERT
	UserTypeToSysFunction
	(
	IDUserType,
	IDSysFunction,
	Acesso
	)
SELECT
	UserType.IDUserType,
	Inserted.IDSysFunction,
	0
FROM
	UserType,
	Inserted

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_SystemUser_InsUpt on dbo.SystemUser
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Proibo a repeticao de UserNames e Passwords


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT	INSERTED.IDUser
		FROM	INSERTED, SystemUser
		WHERE 	INSERTED.SystemUser = SystemUser.SystemUser  AND
			SystemUser.IDUser <> INSERTED.IDUser	     AND
			INSERTED.Desativado = 0 		     AND
			SystemUser.Desativado = 0
		)
	
	BEGIN
		RAISERROR ('DUP_SystemUser_SystemUser can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

if	EXISTS 	(
		SELECT	INSERTED.IDUser
		FROM	INSERTED, SystemUser
		WHERE 	INSERTED.PW = SystemUser.PW		     AND
			SystemUser.IDUser <> INSERTED.IDUser	     AND
			INSERTED.Desativado = 0 		     AND
			SystemUser.Desativado = 0
		)
	
	BEGIN
		RAISERROR ('DUP_SystemUser_PW can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_TabGroup_Del on dbo.TabGroup
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto SpecialPriceByGroup
		- Deleto GroupToComissionType


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@RowCount = 0 
   Return

SET NOCOUNT ON

DELETE
	SpecialPriceByGroup
FROM
	SpecialPriceByGroup,
	Deleted
WHERE
	SpecialPriceByGroup.GroupID = Deleted.IDGroup

DELETE
	GroupToComissionType
FROM
	TipoPessoa,
	Deleted
WHERE
	GroupToComissionType.GroupID = Deleted.IDGroup
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_TabGroup_InsUpt on dbo.TabGroup
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do TabGroup
        	- Insiro em SpecialPriceByGroup
		- Insiro em StoreToTabGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT	
			INSERTED.IDGroup
		FROM	
			INSERTED, TabGroup
		WHERE 	
			INSERTED.Name = TabGroup.Name  	   	
			AND
			TabGroup.IDGroup <> INSERTED.IDGroup  	
			AND
			INSERTED.Desativado = 0 	   	
			AND
			TabGroup.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_TabGroup_Name can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */
if NOT EXISTS (	SELECT	Deleted.IDGroup FROM Deleted)
BEGIN
	INSERT 	SpecialPriceByGroup 
		(	
		SpecialPriceID,
		GroupID,
		SpecialMarkUp		
		)
	SELECT 
		SpecialPrice.IDSpecialPrice, 
		Inserted.IDGroup, 
		0 
	FROM
		SpecialPrice, Inserted 
		WHERE SpecialPrice.Desativado = 0

	--INSERT GroupToComissionType 
	INSERT 
		GroupToComissionType 
		(
		IDTipoComissionado,
		GroupID,
		Comission
		)
	SELECT 
		TipoPessoa.IDTipoPessoa, 
		INSERTED.IDGroup, 
		0 
	FROM
		TipoPessoa, Inserted 
	WHERE 
		TipoPessoa.Desativado = 0 
		AND 
		TipoPessoa.Path like '.003.%' 
		AND
		(NOT (TipoPessoa.Path like '.003.003%'))
END


INSERT StoreToTabGroup  
	(
	IDStore, 
	IDGroup
	)
SELECT
	S.IDStore, 
	I.IDGroup
FROM
	Inserted I
	LEFT OUTER JOIN Deleted D ON (I.IDGroup = D.IDGroup),
	Store S
WHERE
	D.IDGroup IS NULL

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_TipoPessoa_Delete ON dbo.TipoPessoa
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de GroupToComissionType


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@RowCount = 0
   RETURN

SET NOCOUNT ON

DELETE
	GroupToComissionType
FROM
	TabGroup,
	Deleted
WHERE
	GroupToComissionType.IDTipoComissionado = Deleted.IDTipoPessoa
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_TipoPessoa_InsUpt ON dbo.TipoPessoa
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do TipoPessoa
		- Incluo em GroupToComissionType


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDTipoPessoa
		FROM
			INSERTED,
			TipoPessoa
		WHERE
			INSERTED.TipoPessoa = TipoPessoa.TipoPessoa
			AND
			INSERTED.Path = TipoPessoa.Path
			AND
			TipoPessoa.IDTipoPessoa <> INSERTED.IDTipoPessoa
			AND
			INSERTED.Desativado = 0
			AND
			TipoPessoa.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_TipoPessoa_TipoPessoa can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */
if 	NOT EXISTS
		(
		SELECT
			Deleted.IDTipoPessoa
		FROM
			Deleted
		)
	BEGIN
		INSERT
			GroupToComissionType
		SELECT
			Inserted.IDTipoPessoa,
			TabGroup.IDGroup,
			0
		FROM
			TabGroup,
			Inserted
		WHERE
			(TabGroup.Desativado = 0)
			AND (INSERTED.Path like '.003.%')
			AND NOT (INSERTED.Path like '.003.003%')
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_TourGroup ON dbo.TouristGroup
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo os campos atualizados
		- Atualizo TipTouristGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

DECLARE @Guide varchar(50)
if not ( UPDATE(IDGuide) or UPDATE(IDAgency) or UPDATE(IDHotel) or UPDATE(TipGuide) ) 
   return
UPDATE
	TouristGroup
SET
	TipTouristGroup = 	CONVERT(varchar(30),(
			CASE
				WHEN	(TouristGroup.IDGuide is Null) THEN
							IsNull(TouristGroup.TipGuide, '')

				ELSE	IsNull((
					SELECT
						(
						CASE	WHEN	(CHARINDEX(',', Pessoa.Pessoa) = 0) THEN Pessoa.Pessoa
						       	ELSE	RIGHT(Pessoa.Pessoa, DATALENGTH(Pessoa.Pessoa)-CHARINDEX(',', Pessoa.Pessoa))+' '+
								SUBSTRING(Pessoa.Pessoa, 1, CHARINDEX(',', Pessoa.Pessoa)-1)
					       	END
						)
					FROM	Pessoa
					WHERE 	Pessoa.IDPessoa = TouristGroup.IDGuide
					), '')
			END
			) + ' / ' +
			IsNull((
			SELECT
				Pessoa.Pessoa
			FROM
				Pessoa
			WHERE
				Pessoa.IDPessoa = TouristGroup.IDAgency
			), '') + ' / ' +
			IsNull((
			SELECT
				Hotel.Hotel
			FROM
				Hotel
			WHERE
				Hotel.IDHotel = TouristGroup.IDHotel
			), ''))
FROM
	Inserted
WHERE
	Inserted.IDTouristGroup = TouristGroup.IDTouristGroup
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_Trajeto_InsUpt ON dbo.Trajeto
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do Trajeto


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDTrajeto
		FROM
			INSERTED,
			Trajeto
		WHERE
			INSERTED.Trajeto = Trajeto.Trajeto
			AND
			Trajeto.IDTrajeto <> INSERTED.IDTrajeto
			AND
			INSERTED.Desativado = 0
			AND
			Trajeto.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_Trajeto_Trajeto can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_UserType_delete ON dbo.UserType
FOR DELETE 
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de UserRights
		- Deleto de UserTypeToSysFunction


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@RowCount = 0
   RETURN

SET NOCOUNT ON

DELETE
	UserRights
FROM
	Deleted
WHERE
	UserRights.UserTypeID = Deleted.IDUserType

DELETE
	UserTypeToSysFunction
FROM
	Deleted
WHERE
	UserTypeToSysFunction.IDUserType = Deleted.IDUserType
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER tr_UserType_insert ON dbo.UserType
FOR INSERT, UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do UserType
		- Insiro em UserRights
		- Insiro em UserTypeToSysFunction


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@RowCount = 0
   RETURN

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDUserType
		FROM
			INSERTED,
			UserType
		WHERE
			INSERTED.Name = UserType.Name
			AND
			UserType.IDUserType <> INSERTED.IDUserType
			AND
			INSERTED.Desativado = 0
			AND
			UserType.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_UserType_Name can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */
if 	NOT EXISTS
		(
		SELECT
			Deleted.IDUserType
		FROM
			Deleted
		)
	BEGIN
		INSERT
			userrights
		SELECT
			Inserted.IDUserType,
			MenuItem.IDMenu,
			MenuItem.IDSubMenu,
			0,
			0,
			0,
			0,
			0
		FROM
			MenuItem,
			Inserted

		INSERT
			UserTypeToSysFunction
		SELECT
			Inserted.IDUserType,
			SysFunction.IDSysFunction,
			0
		FROM
			SysFunction,
			Inserted
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

