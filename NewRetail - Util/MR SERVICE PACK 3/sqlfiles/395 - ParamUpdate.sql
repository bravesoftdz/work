UPDATE Param
SET Description = 'Chooses the type of Sales Screen. 1 = POS, 2 = Office, 3 = Full-POS'
Where IDParam = 63
GO

UPDATE ParamLanguage
SET Description = 'Chooses the type of Sales Screen. 1 = POS, 2 = Office, 3 = Full-POS'
Where IDParam = 63 and IDLanguage = 1
GO

UPDATE ParamLanguage
SET Description = 'Escolhe o tipo da tela de Vendas. 1 = PDV, 2 = Escritório, 3 = Full-POS'
Where IDParam = 63 and IDLanguage = 2
GO

UPDATE ParamLanguage
SET Description = 'Elegir lo tipo de la tela de Ventas. 1 = POS, 2 = Oficina, 3 = Full-POS'
Where IDParam = 63 and IDLanguage = 3
GO

ALTER TABLE EstimatedItem
	ADD Code int NULL
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_AtuEstimatedItem_Code]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_AtuEstimatedItem_Code]
GO


CREATE PROCEDURE sp_AtuEstimatedItem_Code
AS

DECLARE @IDEstimatedItem	int
DECLARE @IDEstimated		int
DECLARE @Code			int
DECLARE @IDEstimatedOld		int

DECLARE EstimatedItem_Cursor CURSOR FOR

	SELECT
		EI.IDEstimatedItem,
		EI.IDEstimated
	FROM
		EstimatedItem EI
	ORDER BY
		EI.IDEstimated,
		EI.IDEstimatedItem

OPEN EstimatedItem_Cursor

FETCH NEXT FROM EstimatedItem_Cursor INTO
	@IDEstimatedItem,
	@IDEstimated

SET @IDEstimatedOld = @IDEstimated
SET @Code = 0

WHILE
@@FETCH_STATUS = 0
BEGIN
	IF @IDEstimated <> @IDEstimatedOld
	BEGIN
		SET @Code = 0
	END

	UPDATE
		EstimatedItem
	SET
		Code = @Code + 1
	WHERE
		IDEstimatedItem = @IDEstimatedItem

	SET @IDEstimatedOld = @IDEstimated
	SET @Code = @Code + 1


FETCH NEXT FROM EstimatedItem_Cursor INTO
	@IDEstimatedItem,
	@IDEstimated
END

CLOSE EstimatedItem_Cursor
DEALLOCATE EstimatedItem_Cursor
GO

EXEC sp_AtuEstimatedItem_Code
GO

DROP PROCEDURE sp_AtuEstimatedItem_Code
GO
