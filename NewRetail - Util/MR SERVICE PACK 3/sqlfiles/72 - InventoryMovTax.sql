INSERT INTO TaxCategory (IDTaxCategory, TaxCategory, Tax, System, Hidden)
VALUES (0,'N/A',0, 1, 1)
GO
ALTER TABLE TaxCategory
       ADD IDTaxCategoryParent  int NOT NULL
                                   CONSTRAINT DF_Zero733
                                          DEFAULT 0
GO
UPDATE TaxCategory SET IDTaxCategoryParent = 0
GO
ALTER TABLE TaxCategory
       ADD CONSTRAINT FK_TaxCategoryParent_TaxCategoryParent_IDTaxCategoryParent
              FOREIGN KEY (IDTaxCategoryParent)
                             REFERENCES TaxCategory
GO
CREATE INDEX XIF1TaxCategory ON TaxCategory
(
       IDTaxCategoryParent
)
GO
--Desmembramento de Taxas e parent
DECLARE @IDTaxCategory INT 
DECLARE @TaxCategory VARCHAR (50) 
DECLARE @Tax MONEY 
DECLARE @SpecialDateStart SMALLDATETIME 
DECLARE @SpecialDateEnd SMALLDATETIME 
DECLARE @SpecialTax MONEY 
DECLARE @TaxExempt BIT 
DECLARE @MaxItemValue MONEY 
DECLARE @System BIT 
DECLARE @Hidden BIT 
DECLARE @Desativado BIT
DECLARE @IDTaxCategoryParent INT

DECLARE TaxCategory_Cursor CURSOR FOR

SELECT
  	TC.TaxCategory,
 	TC.Tax,
 	TC.SpecialDateStart,
 	TC.SpecialDateEnd,
 	TC.SpecialTax,
 	TC.TaxExempt,
 	TC.MaxItemValue,
 	TC.System,
 	TC.Hidden,
 	TC.Desativado,
	TC.IDTaxCategory IDTaxCategoryParent
FROM 
	TaxCategory TC
WHERE 
	TC.IDTaxCategory <> 0 AND IDTaxCategoryParent = 0

OPEN TaxCategory_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM TaxCategory_Cursor INTO
 	@TaxCategory, 	
	@Tax,
 	@SpecialDateStart,
 	@SpecialDateEnd,
 	@SpecialTax,
 	@TaxExempt,
 	@MaxItemValue,
 	@System,
 	@Hidden,
 	@Desativado,
	@IDTaxCategoryParent

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'TaxCategory.IDTaxCategory', @IDTaxCategory OUTPUT

	INSERT TaxCategory
		(
		IDTaxCategory, 	
		TaxCategory,
	 	Tax,
	 	SpecialDateStart,
	 	SpecialDateEnd,
	 	SpecialTax,
	 	TaxExempt,
	 	MaxItemValue,
	 	System,
	 	Hidden,
	 	Desativado,
		IDTaxCategoryParent
		)
	VALUES
		(
		@IDTaxCategory,
	 	@TaxCategory,
	 	@Tax,
	 	@SpecialDateStart,
	 	@SpecialDateEnd,
	 	@SpecialTax,
	 	@TaxExempt,
	 	@MaxItemValue,
	 	@System,
	 	@Hidden,
	 	@Desativado,
		@IDTaxCategoryParent
		)

FETCH NEXT FROM TaxCategory_Cursor INTO
 	@TaxCategory,
 	@Tax,
 	@SpecialDateStart,
 	@SpecialDateEnd,
 	@SpecialTax,
 	@TaxExempt,
 	@MaxItemValue,
 	@System,
 	@Hidden,
 	@Desativado,
	@IDTaxCategoryParent
END
--fechamento do cursor
CLOSE TaxCategory_Cursor
--Destruição do cursor
DEALLOCATE TaxCategory_Cursor
GO

CREATE TABLE InventoryMovTax (
       IDInventoryMov       int NOT NULL,
       IDTaxCategory        int NOT NULL,
       Tax                  money NOT NULL,
       TaxValue             TValor
)
GO

CREATE INDEX XIF1InventoryMovTax ON InventoryMovTax
(
       IDInventoryMov
)
GO

CREATE INDEX XIF2InventoryMovTax ON InventoryMovTax
(
       IDTaxCategory
)
GO


ALTER TABLE InventoryMovTax
       ADD CONSTRAINT XPKInventoryMovTax PRIMARY KEY (IDInventoryMov, 
              IDTaxCategory)
GO


ALTER TABLE InventoryMovTax
       ADD CONSTRAINT FK_TaxCategory_InventoryMovTax_IDTaxCategory
              FOREIGN KEY (IDTaxCategory)
                             REFERENCES TaxCategory
GO


ALTER TABLE InventoryMovTax
       ADD CONSTRAINT FK_InventoryMov_InventoryMovTax_IDInventoryMov
              FOREIGN KEY (IDInventoryMov)
                             REFERENCES InventoryMov
GO



INSERT INTO InventoryMovTax 
	(
	IDInventoryMov, 
	IDTaxCategory, 
	Tax, 
	TaxValue 
	)
SELECT 
	IM.IDInventoryMov,
	ISNULL (TC.IDTaxCategory,0)AS IDTaxCategory,
	ISNULL (IM.SalesTax,0) AS Tax,
	ISNULL (IM.SalePrice * IM.Qty * IM.SalesTax,0) AS TaxValue
FROM InventoryMov IM
JOIN Model Mo 
	ON (IM.ModelID = Mo.IDModel)
JOIN StoreToTabGroup SG
	ON (SG.IDStore = IM.StoreID 
	AND SG.IDGroup = Mo.GroupID )
JOIN TaxCategory TC
	ON (SG.IDTaxCategory = TC.IDTaxCategoryParent)
GO
