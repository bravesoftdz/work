if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_AtuPurchase_DueDate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_AtuPurchase_DueDate]
GO


CREATE PROCEDURE sp_AtuPurchase_DueDate
AS

DECLARE @IDPurchaseDueDate	int
DECLARE @IDPurchase		int
DECLARE @Date			DateTime
DECLARE @Amount			money

DECLARE PurChase_Cursor CURSOR FOR

	SELECT
		P.IDPurchase,
		IsNull(P.DocumentDueDate, P.DocumentDate),
		IsNull(PT.SubTotal, 0) + IsNull(P.Freight, 0) + IsNull(P.OtherCharges, 0)
	FROM
		Pur_Purchase P
		JOIN Pur_PurchaseTotal PT ON (P.IDPurchase = PT.IDPurchase)
	WHERE
		DocumentType = 'Invoice'

OPEN PurChase_Cursor
FETCH NEXT FROM PurChase_Cursor INTO
	@IDPurchase,
	@Date,
	@Amount

WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Pur_PurchaseDueDate.IDPurchaseDueDate', @IDPurchaseDueDate OUTPUT
	INSERT INTO Pur_PurchaseDueDate
	(
	IDPurchaseDueDate,
	IDPurchase,
	Date,
	Amount
	)
	VALUES
	(
	@IDPurchaseDueDate,
	@IDPurchase,
	@Date,
	@Amount	
	)

FETCH NEXT FROM PurChase_Cursor INTO
	@IDPurchase,
	@Date,
	@Amount
END

CLOSE PurChase_Cursor
DEALLOCATE PurChase_Cursor

GO

EXEC sp_AtuPurchase_DueDate
GO

DROP PROCEDURE sp_AtuPurchase_DueDate
GO
