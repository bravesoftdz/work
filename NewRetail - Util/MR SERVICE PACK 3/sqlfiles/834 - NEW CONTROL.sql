--InvoiceGen.IDInvoice
Create Table Key_IDInvoice (
      SeqID int identity(1,1) primary key,
      SeqVal varchar(1)
)
GO

DECLARE @UltimoCodigo int
SELECT @UltimoCodigo = UltimoCodigo + 1
FROM Sis_CodigoIncremental
WHERE Tabela = 'InvoiceGen.IDInvoice'

DBCC CHECKIDENT ('Key_IDInvoice', reseed, @UltimoCodigo)
GO

DELETE Sis_CodigoIncremental
WHERE Tabela = 'InvoiceGen.IDInvoice'
GO

Create Procedure sp_GetNextKey_IDInvoice
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela 

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 November 	2008	Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @NewSeqValue INT

SET NOCOUNT ON
INSERT INTO Key_IDInvoice (SeqVal) VALUES ('a')

SET @NewSeqValue = scope_identity()

DELETE FROM Key_IDInvoice

RETURN @NewSeqValue
GO

--Key_IDLancamento
Create Table Key_IDLancamento (
      SeqID int identity(1,1) primary key,
      SeqVal varchar(1)
)
GO

DECLARE @UltimoCodigo int
SELECT @UltimoCodigo = UltimoCodigo + 1
FROM Sis_CodigoIncremental
WHERE Tabela = 'Fin_Lancamento.IDLancamento'

DBCC CHECKIDENT ('Key_IDLancamento', reseed, @UltimoCodigo)
GO

DELETE Sis_CodigoIncremental
WHERE Tabela = 'Fin_Lancamento.IDLancamento'
GO

Create Procedure sp_GetNextKey_IDLancamento
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela 

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 November 	2008	Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @NewSeqValue INT

SET NOCOUNT ON
INSERT INTO Key_IDLancamento (SeqVal) VALUES ('a')

SET @NewSeqValue = scope_identity()

DELETE FROM Key_IDLancamento

RETURN @NewSeqValue
GO

--Key_IDSaleItemCommission
Create Table Key_IDSaleItemCommission (
      SeqID int identity(1,1) primary key,
      SeqVal varchar(1)
)
GO

DECLARE @UltimoCodigo int
SELECT @UltimoCodigo = UltimoCodigo + 1
FROM Sis_CodigoIncremental
WHERE Tabela = 'SaleItemCommission.IDSaleItemCommission'

DBCC CHECKIDENT ('Key_IDSaleItemCommission', reseed, @UltimoCodigo)
GO

DELETE Sis_CodigoIncremental
WHERE Tabela = 'SaleItemCommission.IDSaleItemCommission'
GO

Create Procedure sp_GetNextKey_IDSaleItemCommission
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela 

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 November 	2008	Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @NewSeqValue INT

SET NOCOUNT ON
INSERT INTO Key_IDSaleItemCommission (SeqVal) VALUES ('a')

SET @NewSeqValue = scope_identity()

DELETE FROM Key_IDSaleItemCommission

RETURN @NewSeqValue
GO

--Key_IDPreSale
Create Table Key_IDPreSale (
      SeqID int identity(1,1) primary key,
      SeqVal varchar(1)
)
GO

DECLARE @UltimoCodigo int
SELECT @UltimoCodigo = UltimoCodigo + 1
FROM Sis_CodigoIncremental
WHERE Tabela = 'Invoice.IDPreSale'

DBCC CHECKIDENT ('Key_IDPreSale', reseed, @UltimoCodigo)
GO

DELETE Sis_CodigoIncremental
WHERE Tabela = 'Invoice.IDPreSale'
GO

Create Procedure sp_GetNextKey_IDPreSale
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela 

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 November 	2008	Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @NewSeqValue INT

SET NOCOUNT ON
INSERT INTO Key_IDPreSale (SeqVal) VALUES ('a')

SET @NewSeqValue = scope_identity()

DELETE FROM Key_IDPreSale

RETURN @NewSeqValue
GO

--Key_IDPreInventoryMov
Create Table Key_IDPreInventoryMov (
      SeqID int identity(1,1) primary key,
      SeqVal varchar(1)
)
GO

DECLARE @UltimoCodigo int
SELECT @UltimoCodigo = UltimoCodigo + 1
FROM Sis_CodigoIncremental
WHERE Tabela = 'PreInventoryMov.IDPreInventoryMov'

DBCC CHECKIDENT ('Key_IDPreInventoryMov', reseed, @UltimoCodigo)
GO

DELETE Sis_CodigoIncremental
WHERE Tabela = 'PreInventoryMov.IDPreInventoryMov'
GO

Create Procedure sp_GetNextKey_IDPreInventoryMov
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela 

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 November 	2008	Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @NewSeqValue INT

SET NOCOUNT ON
INSERT INTO Key_IDPreInventoryMov (SeqVal) VALUES ('a')

SET @NewSeqValue = scope_identity()

DELETE FROM Key_IDPreInventoryMov

RETURN @NewSeqValue
GO

--Key_IDInventoryMov
Create Table Key_IDInventoryMov (
      SeqID int identity(1,1) primary key,
      SeqVal varchar(1)
)
GO

DECLARE @UltimoCodigo int
SELECT @UltimoCodigo = UltimoCodigo + 1
FROM Sis_CodigoIncremental
WHERE Tabela = 'InventoryMov.IDInventoryMov'

DBCC CHECKIDENT ('Key_IDInventoryMov', reseed, @UltimoCodigo)
GO

DELETE Sis_CodigoIncremental
WHERE Tabela = 'InventoryMov.IDInventoryMov'
GO

Create Procedure sp_GetNextKey_IDInventoryMov
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela 

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 November 	2008	Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @NewSeqValue INT

SET NOCOUNT ON

INSERT INTO Key_IDInventoryMov (SeqVal) VALUES ('a')

SET @NewSeqValue = scope_identity()

DELETE FROM Key_IDInventoryMov

RETURN @NewSeqValue
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_GetNextCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_GetNextCode]
GO

CREATE PROCEDURE sp_Sis_GetNextCode
		(
		@Tabela		varchar(100),
		@NovoCodigo	int = 0 output	
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela de controle de Codigos e retorna o valor 

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Campo nao existe


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 November 	2003	Rodrigo Costa		Criação;
	22 Octuber 	2004	Rodrigo Costa		Incliuir Tabelas automaticas
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel		int
SET @ErrorLevel = 0

if (@Tabela = 'InventoryMov.IDInventoryMov') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDInventoryMov
END ELSE IF (@Tabela = 'PreInventoryMov.IDPreInventoryMov') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDPreInventoryMov
END ELSE IF (@Tabela = 'Invoice.IDPreSale') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDPreSale
END ELSE IF (@Tabela = 'SaleItemCommission.IDSaleItemCommission') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDSaleItemCommission
END ELSE IF (@Tabela = 'Fin_Lancamento.IDLancamento') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDLancamento
END ELSE IF (@Tabela = 'InvoiceGen.IDInvoice') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDInvoice
END
ELSE
BEGIN
	UPDATE	
		CI
	SET	
		UltimoCodigo = UltimoCodigo + 1,
		@NovoCodigo = UltimoCodigo + 1
	FROM
		Sis_CodigoIncremental CI (UPDLOCK, ROWLOCK)
	
	WHERE  	
		Tabela = @Tabela
	
	IF (@@ROWCOUNT = 0)
	BEGIN
		DECLARE @LastKey int
		SET @LastKey = (SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = 'LastKey')
		
		SET @NovoCodigo = IsNull(@LastKey,1)
		INSERT Sis_CodigoIncremental (Tabela,  UltimoCodigo) 
		VALUES (@Tabela, @NovoCodigo)
		
		SET @ErrorLevel = -101
		GOTO ERRO
	END
END

OK:
	RETURN 0
ERRO:
	RETURN @ErrorLevel
GO
