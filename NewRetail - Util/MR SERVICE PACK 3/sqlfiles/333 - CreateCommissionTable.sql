CREATE TABLE SaleItemCommission (
       IDSaleItemCommission int NOT NULL,
       IDPreInventoryMov    int NULL,
       IDInventoryMov       int NULL,
       IDCommission         int NULL,
       CommissionPercent    decimal NOT NULL
)
GO

CREATE INDEX XIF3SaleItemCommission ON SaleItemCommission
(
       IDInventoryMov
)
GO

CREATE INDEX XIF5SaleItemCommission ON SaleItemCommission
(
       IDCommission
)
GO

CREATE INDEX XIF6SaleItemCommission ON SaleItemCommission
(
       IDPreInventoryMov
)
GO

ALTER TABLE SaleItemCommission
       ADD CONSTRAINT XPKSaleItemCommission PRIMARY KEY (
              IDSaleItemCommission)
GO

ALTER TABLE SaleItemCommission
       ADD CONSTRAINT FK_PreInventoryMov_SaleItemCommission_IDPreInventoryMov
              FOREIGN KEY (IDPreInventoryMov)
                             REFERENCES PreInventoryMov
GO

ALTER TABLE SaleItemCommission
       ADD CONSTRAINT FK_Pessoa_SaleItemCommission_IDCommission
              FOREIGN KEY (IDCommission)
                             REFERENCES Pessoa
GO

ALTER TABLE SaleItemCommission
       ADD CONSTRAINT FK_InventoryMov_SaleItemCommission_IDInventoryMov
              FOREIGN KEY (IDInventoryMov)
                             REFERENCES InventoryMov
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Insert_SaleItemCommission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Insert_SaleItemCommission]
GO

CREATE PROCEDURE sp_Insert_SaleItemCommission AS

DECLARE @ErrorLevel	       int
DECLARE @SysError	       int
DECLARE @IDSaleItemCommission  int
DECLARE @IDPreInventoryMov     int
DECLARE @IDInventoryMov        int
DECLARE @ComissionID           int

BEGIN TRAN

SET  @ErrorLevel = 0

DECLARE SaleItemCommission_Cursor CURSOR FOR

	SELECT
		IDPreInventoryMov,
		ComissionID
	FROM
		PreInventoryMov
	WHERE
		InventMovTypeID = 1
	
OPEN SaleItemCommission_Cursor

FETCH NEXT FROM SaleItemCommission_Cursor INTO
	@IDPreInventoryMov,
	@ComissionID

WHILE
@@FETCH_STATUS = 0
BEGIN

	Exec sp_Sis_GetNextCode 'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT

	INSERT INTO SaleItemCommission
		(
		IDSaleItemCommission,
		IDPreInventoryMov,
		IDCommission,
		CommissionPercent
		)
	VALUES
		(
		@IDSaleItemCommission,
		@IDPreInventoryMov,
		@ComissionID,
		100
		)

	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE SaleItemCommission_Cursor
		DEALLOCATE SaleItemCommission_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM SaleItemCommission_Cursor INTO
		@IDPreInventoryMov,
		@ComissionID
END
CLOSE SaleItemCommission_Cursor
DEALLOCATE SaleItemCommission_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

DECLARE SaleItemCommission_Cursor2 CURSOR FOR

	SELECT
		IDInventoryMov,
		ComissionID
	FROM
		InventoryMov
	WHERE
		InventMovTypeID = 1	
	
OPEN SaleItemCommission_Cursor2

FETCH NEXT FROM SaleItemCommission_Cursor2 INTO
	@IDInventoryMov,
	@ComissionID

WHILE
@@FETCH_STATUS = 0
BEGIN

	Exec sp_Sis_GetNextCode 'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT

	INSERT INTO SaleItemCommission
		(
		IDSaleItemCommission,
		IDInventoryMov,
		IDCommission,
		CommissionPercent
		)
	VALUES
		(
		@IDSaleItemCommission,
		@IDInventoryMov,
		@ComissionID,
		100
		)

	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE SaleItemCommission_Cursor2
		DEALLOCATE SaleItemCommission_Cursor2
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	FETCH NEXT FROM SaleItemCommission_Cursor2 INTO
		@IDInventoryMov,
		@ComissionID
END
CLOSE SaleItemCommission_Cursor2
DEALLOCATE SaleItemCommission_Cursor2

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN
  
	RETURN @ErrorLevel
GO

EXEC sp_Insert_SaleItemCommission
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Insert_SaleItemCommission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Insert_SaleItemCommission]
GO

if  Exists(select * from SysObjects where name = 'FK_Pessoa_InventoryMov_ComissionID') 
BEGIN
ALTER TABLE InventoryMov
DROP CONSTRAINT FK_Pessoa_InventoryMov_ComissionID
END
GO

if  Exists(select * from SysObjects where name = 'FK_Pessoa_PreInventoryMov_ComissionID') 
BEGIN	
ALTER TABLE PreInventoryMov
DROP CONSTRAINT FK_Pessoa_PreInventoryMov_ComissionID
END
GO

DROP INDEX InventoryMov.XIF108InventoryMov
GO

ALTER TABLE InventoryMov
DROP COLUMN ComissionID
GO

DROP INDEX PreInventoryMov.XIF226PreInventoryMov
GO

ALTER TABLE PreInventoryMov
DROP COLUMN ComissionID
GO
