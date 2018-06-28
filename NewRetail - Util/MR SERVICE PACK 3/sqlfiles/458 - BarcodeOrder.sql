ALTER TABLE Barcode ADD
	BarcodeOrder int NULL
GO

CREATE PROCEDURE sp_Tmp_SetBarcodeOrder AS
DECLARE @IDModel int
DECLARE @IDBarcode varchar(20)
DECLARE @BarcodeOrder int

DECLARE Model_Cursor CURSOR FOR
	SELECT
		B.IDModel
	FROM
		Barcode B
	GROUP BY
		B.IDModel
	ORDER BY
		B.IDModel
OPEN Model_Cursor

FETCH NEXT FROM Model_Cursor INTO
	@IDModel
WHILE
@@FETCH_STATUS = 0
BEGIN
	SET @BarcodeOrder = 0

	DECLARE Barcode_Cursor CURSOR FOR
		SELECT
			B.IDBarcode
		FROM
			Barcode B
		WHERE
			B.IDModel = @IDModel
		ORDER BY
			B.Data
	OPEN Barcode_Cursor

	FETCH NEXT FROM Barcode_Cursor INTO
		@IDBarcode
	WHILE
	@@FETCH_STATUS = 0
	BEGIN
		SET @BarcodeOrder = @BarcodeOrder + 1

		UPDATE Barcode
		SET BarcodeOrder = @BarcodeOrder
		WHERE IDBarcode = @IDBarcode

		FETCH NEXT FROM Barcode_Cursor INTO
			@IDBarcode
	END

	CLOSE Barcode_Cursor
	DEALLOCATE Barcode_Cursor

	FETCH NEXT FROM Model_Cursor INTO
		@IDModel
END

CLOSE Model_Cursor
DEALLOCATE Model_Cursor
GO

EXEC sp_Tmp_SetBarcodeOrder
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Tmp_SetBarcodeOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Tmp_SetBarcodeOrder]
GO

ALTER TABLE Barcode ALTER COLUMN
	BarcodeOrder int NOT NULL
GO
