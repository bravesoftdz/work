if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceItemTax]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceItemTax]
GO

CREATE VIEW vwInvoiceItemTax AS

SELECT 
	TC.TaxCategory,
	TC.OperationType,
	TC.SaleTaxType,
	PIM.IDPreInventoryMov as IDMov, 
 	ABS(((CASE WHEN (TC.SpecialDateStart <=  GETDATE()) AND (TC.SpecialDateEnd >= GETDATE()) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
		 THEN (IsNull(TC.SpecialTax,0)) ELSE (IsNull(TC.Tax,0)) END)/100)) as Tax,
	0 as IsInvoice
FROM 
	PreInventoryMov PIM
	JOIN Model M ON ( PIM.ModelID = M.IDModel )
	JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
	LEFT JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDSaleTax )
WHERE 
	PIM.InventMovTypeID IN (1,25)
	AND
	PIM.IDParentPack Is Null

UNION ALL

SELECT 
	TX.TaxCategory,
	TX.OperationType,
	TX.SaleTaxType,
	IM.IDInventoryMov as IDMov, 
	IMX.Tax,
	1 as IsInvoice
FROM 
	InventoryMov IM
	JOIN InventoryMovTax IMX ON (IM.IDInventoryMov = IMX.IDInventoryMov)
	JOIN TaxCategory TX ON (TX.IDTaxCategory = IMX.IDTaxCategory)
WHERE 
	IM.InventMovTypeID IN (1,25)
	AND
	IM.IDParentPack Is Null


GO
