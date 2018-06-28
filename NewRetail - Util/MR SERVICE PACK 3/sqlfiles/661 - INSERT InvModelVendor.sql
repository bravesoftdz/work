IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Tmp_Insert_InvModelVendor]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Tmp_Insert_InvModelVendor]
GO

CREATE PROCEDURE sp_Tmp_Insert_InvModelVendor
AS

DECLARE @IDVendor	int
DECLARE @IDModel	int
DECLARE @VendorOrder	int

DECLARE VENDOR_MODEL_CUR CURSOR FOR

SELECT
	VMC.IDPessoa,
	VMC.IDModel
FROM
	VendorModelCode VMC
	LEFT JOIN Inv_ModelVendor IMV ON (VMC.IDModel = IMV.IDModel AND VMC.IDPessoa = IMV.IDPessoa)
WHERE
	IMV.IDModel IS NULL

OPEN VENDOR_MODEL_CUR

--Inicialização de Store_Cursor
FETCH NEXT FROM VENDOR_MODEL_CUR INTO
	@IDVendor,
	@IDModel

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT
		@VendorOrder = IsNull(MAX(VendorOrder), 0) + 1
	FROM
		Inv_ModelVendor IMV
	WHERE
		IMV.IDModel = @IDModel

	INSERT INTO Inv_ModelVendor (IDPessoa, IDModel, VendorOrder, MinQtyPO, CaseQty)
	VALUES (@IDVendor, @IDModel, @VendorOrder, 0, 0)

	FETCH NEXT FROM VENDOR_MODEL_CUR INTO
		@IDVendor,
		@IDModel
END

--fechamento do cursor
CLOSE VENDOR_MODEL_CUR
--Destruição do cursor
DEALLOCATE VENDOR_MODEL_CUR

GO

EXEC sp_Tmp_Insert_InvModelVendor
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Tmp_Insert_InvModelVendor]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Tmp_Insert_InvModelVendor]
GO
