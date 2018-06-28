if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwUnitInvoiceDiscount]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwUnitInvoiceDiscount]
GO

CREATE VIEW vwUnitInvoiceDiscount  AS
SELECT
	1 as Invoice,
	(I.InvoiceDiscount / IsNULL(COUNT(IM.IDInventoryMov),1)) as UnitDiscount,
	I.IDInvoice as DocumentID
FROM
	InventoryMov IM (NOLOCK)
	JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID = 1)
GROUP BY
	I.InvoiceDiscount,
	I.IDInvoice

UNION ALL

SELECT
	0 as Invoice,
	(I.InvoiceDiscount / IsNULL(COUNT(PIM.IDPreInventoryMov),1)) as UnitDiscount,
	I.IDPreSale as DocumentID
FROM
	PreInventoryMov PIM (NOLOCK)
	JOIN Invoice I (NOLOCK) ON (I.IDPreSale = PIM.DocumentID AND PIM.InventMovTypeID = 1)
GROUP BY
	I.InvoiceDiscount,
	I.IDPreSale
GO
