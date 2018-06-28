if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwDailyRepayment]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwDailyRepayment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwDailySales]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwDailySales]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGroupCost]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGroupCost]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGroupCostByDate]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGroupCostByDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGroupOtherCost]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGroupOtherCost]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceByModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceByModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceComission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceComission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceItemTax]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceItemTax]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceResult]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceResult]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelHistoryMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelHistoryMov]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwPurchaseFornec]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwPurchaseFornec]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwPurchaseItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwPurchaseItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwPurchaseModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwPurchaseModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwPurchase_InvMovModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwPurchase_InvMovModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSaleItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSaleItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSaleItemTax]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSaleItemTax]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSplit_ListItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSplit_ListItems]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwTotInvMovContado]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwTotInvMovContado]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Fin_LancamentoActiveTerm]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Fin_LancamentoActiveTerm]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_DisbursementType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_DisbursementType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_DocumentType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_DocumentType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_RecordPC]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_RecordPC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_RecordPaid]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_RecordPaid]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Records]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Records]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_RecordsTerms]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_RecordsTerms]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_BestSeller]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_BestSeller]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_ClientRepair]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_ClientRepair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CommissionBonus]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CommissionBonus]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CommissionDetails]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CommissionDetails]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_GroupCost]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_GroupCost]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_GroupCostGift]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_GroupCostGift]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryHistory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryMov]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryMoviment]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryMoviment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryRepair]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryRepair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InvoiceDate]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InvoiceDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_OpenLayawayHold]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_OpenLayawayHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Records]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Records]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Records_Resum]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Records_Resum]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Repair]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Repair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SaleByManufacture]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SaleByManufacture]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SalesBySalesPerson]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SalesBySalesPerson]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SalesPersonCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SalesPersonCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SalesPersonResult]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SalesPersonResult]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SalesProfit]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SalesProfit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_ZipCode]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_ZipCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCotacaoToModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCotacaoToModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_QuotationToModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_QuotationToModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwBarcode]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwBarcode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCashRegisterMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCashRegisterMov]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCotacaoModelQty]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCotacaoModelQty]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCotacaoResult]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCotacaoResult]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCotationPOItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCotationPOItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGroupSales]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGroupSales]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGroupSalesGuide]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGroupSalesGuide]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwHourResult]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwHourResult]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceParents]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceParents]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwMeioPagToStore]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwMeioPagToStore]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwPOItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwPOItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwStoreToTabGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwStoreToTabGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_PreInventoryMov_Grid]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_PreInventoryMov_Grid]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Payment]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Payment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Barcode]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Barcode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventorySerial]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventorySerial]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Invoice]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Invoice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_MarketingCustomerPurchaseHist]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_MarketingCustomerPurchaseHist]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_ModelTransfDet]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_ModelTransfDet]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_PaymentTypeMinSale]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_PaymentTypeMinSale]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_PaymentTypeToStore]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_PaymentTypeToStore]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_PreInventoryMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_PreInventoryMov]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_QuotationResult]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_QuotationResult]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCategoryTree]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCategoryTree]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCotacaoToFornec]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCotacaoToFornec]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInventoryModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInventoryModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelInventory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelInventory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InvTotal]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InvTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InveItemStock]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InveItemStock]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Model]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Model]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_PaymentType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_PaymentType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_QuotationToVendor]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_QuotationToVendor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelSubGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelSubGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_CategorySubCatGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_CategorySubCatGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_PO_BrwPO]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_PO_BrwPO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_BankAccountBalance]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_BankAccountBalance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_BankAccountTransaction]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_BankAccountTransaction]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_RecordType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_RecordType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Transfer]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Transfer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegLog]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_ModelTransf]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_ModelTransf]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_PurchaseOrder]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_PurchaseOrder]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Quotation]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Quotation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_TouristGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_TouristGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwComissionTypeToGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwComissionTypeToGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGroupToComissionType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGroupToComissionType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvQuantity]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvQuantity]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwUserTypeToSysFunction]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwUserTypeToSysFunction]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_BankAccount]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_BankAccount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_UserGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_UserGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegMov]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_GroupToCommissionType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_GroupToCommissionType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Store]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Store]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Sis_EmpresaGrupo]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Sis_EmpresaGrupo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Sis_GrupoEmpresa]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Sis_GrupoEmpresa]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MenuRights]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[MenuRights]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSpecialPriceToGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSpecialPriceToGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSystemUser]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSystemUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_BankBranch]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_BankBranch]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Company]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Company]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_User]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_User]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Category]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Category]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_DiscRange]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_DiscRange]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryQtyByModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryQtyByModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryQtyByStore]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryQtyByStore]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SystemUser]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SystemUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Sis_GrupoMainMenu]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Sis_GrupoMainMenu]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwAgency]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwAgency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCliente]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCliente]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwComissionado]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwComissionado]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwFabricante]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwFabricante]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwFornecedor]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwFornecedor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGroupToSpecialPrice]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGroupToSpecialPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGuide]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGuide]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelToSpecialPrice]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelToSpecialPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwOther]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwOther]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwPessoa]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwPessoa]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwPessoaFullName]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwPessoaFullName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSalesPerson]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSalesPerson]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwTipoCliente]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwTipoCliente]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwTipoComissionado]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwTipoComissionado]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwTipoFabricante]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwTipoFabricante]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwTipoFornecedor]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwTipoFornecedor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Bank]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Bank]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_CostCenter]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_CostCenter]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Group]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Group]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Holiday]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Holiday]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegLogType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegLogType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegister]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegister]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CostType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CostType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_DeliverType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_DeliverType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Entity]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Entity]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_EntityType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_EntityType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Hotel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Hotel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InvColor]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InvColor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InvSize]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InvSize]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Inventory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Inventory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryMovType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryMovType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Media]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Media]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_PaidCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_PaidCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Sis_FatorMoedaPadrao]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Sis_FatorMoedaPadrao]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_AgedInventory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_AgedInventory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_AgencyAgentInvoices]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_AgencyAgentInvoices]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegisterFlow]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegisterFlow]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CustomerPurchaseHistory_Sub]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CustomerPurchaseHistory_Sub]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Sis_ChaveEstrangeira]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Sis_ChaveEstrangeira]
GO

CREATE VIEW vwCotacaoToModel (IDCotacao, QtyCotada, IDModel, Model, Description, TotQtyOnHand, Fabricante)  AS

SELECT
	CTM.IDCotacao,
	CTM.QtyCotada,
	M.IDModel,
	M.Model,
	M.Description,
	M.TotQtyOnHand,
	P.Pessoa
FROM
	CotacaoToModel CTM (NOLOCK),
	Model M (NOLOCK),
	Pessoa P (NOLOCK)
WHERE
	CTM.IDModel = M.IDModel
	AND P.IDPessoa =* M.IDFabricante
GO

CREATE VIEW vwDailyRepayment AS

SELECT
	CONVERT(datetime, CONVERT(varchar, CashRegLog.LogTime, 103), 103) AS RepaymentDate,
	SUM(Fin_Lancamento.ValorNominal) RepaymentsValue 
FROM 
	CashregMov (NOLOCK)
	INNER JOIN CashRegLog (NOLOCK) ON (CashRegMov.IDCashRegMov = CashRegLog.IDCashRegMov AND CashRegLog.IDCashregTipoLog = 4) 
	INNER JOIN Fin_Lancamento (NOLOCK) ON (CashRegMov.IDCashRegMov = Fin_Lancamento.IDCashRegMovClosed)
WHERE
	Fin_Lancamento.IDLancamentoTipo = 2	
GROUP BY
	CONVERT(datetime, CONVERT(varchar, CashRegLog.LogTime, 103), 103)
GO

CREATE VIEW vw_Rep_TouristGroup (IDTouristGroup, TipTouristGroup, IDGuide, IDAgency, EnterDate, IDStore, NumTourist, GuideCommission, IDUser, IDHotel)  AS

SELECT
	T.IDTouristGroup,
	T.TipTouristGroup,
	T.IDGuide,
	T.IDAgency,
	T.EnterDate,
	T.IDStore,
	T.NumTourist,
	T.ComissaoSobreGuia,
	T.IDUser,
	T.IDHotel
FROM
	TouristGroup T (NOLOCK)
GO

CREATE VIEW vw_Rep_PaymentType (IDMeioPag, IDContaCorrente, IDMeioPagBatch, IDLancamentoTipo, IDPessoa, MeioPag, CodigoMeioPag, HasDocument, ReceiveTime, AdminTax, DocumentIdentifier, TaxMode, Type, PossuiFavorecido, ObrigaFavorecido, HasNumber, NumberRequired, ParentType)  AS

SELECT
	M.IDMeioPag,
	M.IDContaCorrente,
	M.IDMeioPagBatch,
	M.IDLancamentoTipo,
	M.IDPessoa,
	M.MeioPag,
	M.CodigoMeioPag,
	M.TemDocumento,
	M.PrazoRecebimento,
	M.TaxaAdmin,
	M.IdentificadorDocumento,
	M.TaxMode,
	M.Tipo,
	M.PossuiFavorecido,
	M.ObrigaFavorecido,
	M.PossuiNumero,
	M.ObrigaNumero,
	M.ParentType
FROM
	MeioPag M (NOLOCK)
GO

CREATE VIEW vw_Rep_Media AS

SELECT
	M.IDMedia,
	M.IDOtherCommission,
	M.Media,
	M.TaxMode,
	M.PayComission
FROM
	Media M (NOLOCK)
GO

CREATE VIEW vwDailySales AS

SELECT
	CONVERT(datetime, CONVERT(varchar, I.PreSaleDate, 103), 103) AS SaleDate,
	SUM(ISNULL(I.SubTotal, 0) + ISNULL(I.AditionalExpenses, 0) + ISNULL(I.OtherExpences, 0) - ISNULL(I.ItemDiscount, 0)) AS SalesValue
FROM
	Invoice I (NOLOCK)
WHERE
	I.IDPreSaleParent IS NULL
	AND I.Canceled = 0
	AND EXISTS (SELECT IDPreSale FROM Fin_Lancamento WHERE Fin_Lancamento.IDPresale = I.IDPresale)
GROUP BY
	CONVERT(datetime, CONVERT(varchar, I.PreSaleDate, 103), 103)
GO

CREATE VIEW vw_Rep_Invoice AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório
 
	LOG DE MODIFICAÇÕES
 
	Data			Programador			Modificação
	-----------------------	-------------------------------	--------------------------------------------------------------------------
	08 Jan	2004		Marcello Felipelli		Criação;
	11 Apr	2007		Maximiiano Muniz		Novo campo InvoiceDiscount;
	---------------------------------------------------------------------------------------------------------------------------------- */

SELECT
	I.IDPreSale,
	I.IDInvoice,
	I.IDPreSaleParent,
	I.CashRegMovID as IDCashRegMov,
	I.IDMeioPag,
	I.MediaID as IDMedia,
	I.IDTouristGroup,
	I.OtherComissionID as IDOtherComission,
	I.IDCustomer,
	I.IDStore,
	I.IDLancPagOtherCom,
	I.DeliverTypeID as  IDDeliverType,
	I.SpecialPriceID as IDSpecialPrice,
	I.PreSaleDate,
	I.InvoiceDate,
	I.DeliverDate,
	I.DeliverAddress,
	I.Passport,
	I.PassportDate,
	I.Ticket,
	I.AirLine,
	I.CompanyName,
	I.CompanyCGC,
	I.DepositDate,
	I.Tax,
	I.SubTotal,
	I.Note,
	I.ItemDiscount,
	I.TaxIsent,
	I.nOpenUser,
	I.RefreshInvoice,
	I.Printed,
	I.CashReceived,
	I.EstimatedPay,
	I.CardNumber,
	I.OtherExpences,
	I.Address,
	I.TaxIsemptValue,
	I.TaxIsemptItemDiscount,
	I.Layaway,
	I.FirstName,
	I.LastName,
	I.ZIP,
	I.nOpenHoldCaixa,
	I.SaleCode,
	I.InvoiceCode,
	I.AditionalExpenses,
	I.InvoiceDiscount,
	I.Canceled,
	I.CupomFiscal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal
FROM 
	Invoice I (NOLOCK)
GO

CREATE VIEW vw_Rep_Acc_Payment (IDPayment, IDTransfer, IDPaymentType, IDBranch, IDBank, IDBankAccount, IDUser, Amount, Interest, PaymentDate, DocumentNumber, IDUserReconcile, Paying, ReconciliationDate, IsReconciliated, Payee, Deleted, Hidden, System)  AS

SELECT
	Q.IDQuitacao,
	Q.IDTransferencia,
	Q.IDQuitacaoMeio,
	Q.IDBancoAgencia,
	Q.IDBanco,
	Q.IDContaCorrente,
	Q.IDUsuarioQuitacao,
	Q.ValorQuitacao,
	Q.ValorJuros,
	Q.DataQuitacao,
	Q.NumeroMeioQuit,
	Q.IDUsuarioReconciliacao,
	Q.Pagando,
	Q.DataReconciliacao,
	Q.AReconciliar,
	Q.Favorecido,
	Q.Desativado,
	Q.Hidden,
	Q.System
FROM
	Fin_Quitacao Q (NOLOCK)
GO

CREATE VIEW vw_Rep_InvColor (IDColor, Color, ColorCode)  AS

SELECT
	I.IDColor,
	I.Color,
	I.CodColor
FROM
	InvColor I (NOLOCK)
GO

CREATE VIEW vw_Rep_InvSize AS

SELECT
	I.IDSize,
	I.SizeName,
	I.CodSize
FROM
	InvSize I (NOLOCK)
GO

CREATE VIEW vw_Rep_Category  AS

SELECT 
	T.IDGroup as IDCategory, 
	T.Name as Category, 
	T.Taxable, 
	T.PrcPartDiscount, 
	T.Path, 
	T.PathName, 
	T.SerialNumber, 
	T.SizeAndColor,
	T.PackModel,
	T.Service,
	T.Credit,
	T.DesiredMarkup,
	T.UserCode,
	T.PuppyTracker,
	T.RequestCustomer,
	T.Desativado as Deleted
FROM
	TabGroup T (NOLOCK)

GO

CREATE VIEW vw_Rep_Model AS
SELECT 
	M.IDModel, 
	M.GroupID, 
	M.IDUnidade, 
	M.IDFabricante, 
	M.IDSize, 
	M.IDColor, 
	M.Model, 
	M.Description, 
	M.FreightCost, 
	M.OtherCost, 
	M.VendorCost, 
	M.DateLastCost, 
	M.MarkUp, 
	M.SellingPrice, 
	M.DateLastSellingPrice, 
	M.Peso as Weight, 
	M.Avaiable, 
	M.LastCost, 
	M.SuggRetail, 
	M.VD, 
	M.SX, 
	M.TotQtyOnHand, 
	M.SX2, 
	M.LastMovDate, 
	M.PVD, 
	M.DP, 
	M.ES, 
	M.PP, 
	M.VP, 
	M.InicioPontoPedido, 
	M.ClasseABC, 
	M.AutomaticRequest, 
	M.TR, 
	M.ModelType, 
	M.CustomSalePrice, 
	M.CustomCostPrice, 
	M.CustomSpecialPrice, 
	M.CustomPromotion, 
	M.AvgCost, 
	M.FinalCost, 
	M.Desativado as Deleted, 
	M.ReplacementCost,
	M.LargeImage, 
	M.FloatPercent, 
	M.LargeImage2, 
	M.NotVerifyQty,
	M.PromotionPrice,
	M.DiscountPerc,
	M.CaseQty,
	M.IDModelGroup,
	M.IDModelSubGroup
FROM 
	Model M (NOLOCK)

GO

CREATE VIEW vw_Rep_Inventory AS
SELECT 
	I.IDInventory, 
	I.StoreID as IDStore, 
	I.ModelID as IDModel, 
	I.QtyOnPreSale, 
	I.QtyOnHand, 
	I.QtyOnOrder, 
	I.QtyOnRepair, 
	I.MaxQty, 
	I.MinQty, 
	I.Location, 
	I.QtyContada as QtyCount, 
	I.DataContagem as CountDate, 
	I.UltimaMovimentacao as LastMov, 
	I.UltimaContagem as LastCount, 
	I.AuxCalculo, 
	I.Avaiable, 
	I.QtyOnPrePurchase, 
	I.LastPurchase, 
	I.FirstPurchase, 
	I.TotalPurchase,
	I.SellingPrice
FROM 
	Inventory I (NOLOCK)
GO

CREATE VIEW vw_Rep_Entity AS
SELECT 
	P.IDPessoa as IDPerson,
	P.IDPessoa as IDAgency,
	P.IDPessoa as IDAgenty,
	P.IDPessoa as IDCustomer,
	P.IDPessoa as IDVendor,
	P.IDPessoa as IDCommission,
	P.IDPessoa as IDManufactore,
 	P.IDTipoPessoa as IDPersonType,
	P.IDStore as IDStore,
	P.IDEstado as IDState,
	P.IDUser as IDUser,
	P.IDPais as IDCountry ,
	P.Code as Code,
	P.Pessoa as FullName,
	P.PessoaFirstName as FirstName,
	P.PessoaLastName as LastName,
	P.NomeJuridico as DBA,
	P.Endereco as Address,
	P.Cidade as City,
	P.CEP as Zip,
	P.Telefone as Phone,
	P.Cellular as Cellular,
	P.Fax as Fax,
	P.Beeper as Beeper,
	P.Contatos as Contact,
	P.Email as Email,
	P.Limite as Limit,
	P.Nascimento as BirthDate,
	P.DiaQuitacao as PaymentDay,
	P.CPF as BirthState,
	P.CartTrabalho as SocialSecurity,
	P.InscEstadual as FederalID,
	P.InscMunicipal as SalesTax,
	P.HomePage as HomePage,
	P.ComissaoSobreGuia as GuideCommission,
	P.DescontaCoordenacao as CoordDiscount,
	P.AjusteComiss as CommissAjust,
	P.CustomerCard as CustomerCard,
	P.Bairro as Neighborhood,
	P.UserCode,
	P.OBS,
	P.PhoneAreaCode,
	P.CellAreaCode,
	P.OrgaoEmissor as GorvIssue,
	P.CartMotorista as DriveLicense,
	P.DataExpedicao as IssueDate,
	P.Desativado as Deleted,
	P.CreationDate
FROM 
	Pessoa P (NOLOCK)
GO

CREATE VIEW vw_Rep_Store (IDStore, IDCompany, Store, Address, Telephone, IDState, City, Zip, Fax, Beeper, Cel, Contact)  AS

SELECT
	S.IDStore,
	S.IDEmpresa,
	S.Name,
	S.Address,
	S.Telephone,
	S.IDEstado,
	S.City,
	S.Zip,
	S.Fax,
	S.Beeper,
	S.Cellular,
	S.Contato
FROM
	Store S (NOLOCK)

GO

CREATE  VIEW vw_Rep_InventoryMov  AS
SELECT 
	I.IDInventoryMov, 
	I.InventMovTypeID as IDInventMovType, 
	I.DocumentID as IDDocument, 
	I.IDPessoa, 
	I.ModelID as IDModel, 
	I.StoreID as IDStore, 
	SIC.IDCommission AS IDComission, 
	I.IDLancPagCom, 
	I.IDUser, 
	I.IDAgrupaPag, 
	I.IDTemp, 
	I.MovDate, 
	I.Qty, 
	I.CostPrice, 
	I.SalePrice, 
	I.Discount, 
	I.Freight, 
	I.OtherCost, 
	I.ExchangeInvoice, 
	I.QtyExchanged, 
	I.SalesTax,
	I.AvgCost,
	TG.Service
FROM 
	InventoryMov I (NOLOCK)
	INNER JOIN Model M (NOLOCK) ON (I.ModelID = M.IDModel)
	INNER JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDInventoryMov = I.IDInventoryMov)

GO

CREATE VIEW vw_Rep_AgedInventory
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para ser utilizada no relatório Aged Inventory by Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
SELECT
	I.IDModel,
	M.Model,
	M.Description,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.SellingPrice) ELSE 0 END) AS ExtOurPrice,
	M.SellingPrice,
	M.FreightCost,
	M.OtherCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.VendorCost) ELSE 0 END) AS ExtVendorCost,
	M.VendorCost,
	M.DateLastCost,
	M.MarkUp,
	M.DateLastSellingPrice as LastSoldDate,
	M.LastCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.SuggRetail) ELSE 0 END) AS ExtSuggRetail,
	M.SuggRetail,
	M.LastMovDate,
	M.AvgCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.FinalCost) ELSE 0 END) AS ExtFinalCost,
	M.FinalCost,
	CASE WHEN M.SellingPrice > 0 THEN M.SellingPrice - M.FinalCost END as RealMarkUpValue,
	CASE WHEN M.SellingPrice > 0 AND M.FinalCost <> 0 THEN ROUND(( (M.SellingPrice-M.FinalCost)/M.FinalCost * 100),2) END as RealMarkUpPercent,
	TG.Category,
	TG.IDCategory,
	(CASE WHEN I.QtyOnHand > 0 THEN IsNull(I.QtyOnHand,0) ELSE 0 END) as PostiveQtyOnHand,
	IsNull(F.FullName,'Not Defined') as Manufacture,
	DATEDIFF(day, M.DateLastCost, getdate()) as Days,
	I.QtyOnHand,
	I.QtyOnPreSale,
	I.QtyOnOrder,
	I.QtyOnRepair,
	I.QtyInReceiving
FROM
	vw_Rep_Model M (NOLOCK)
	JOIN vw_Rep_Category TG (NOLOCK) ON (M.GroupID = TG.IDCategory)
	LEFT OUTER JOIN 
		(
		SELECT
			I.IDModel,
			SUM(IsNull(I.QtyOnHand,0)) as QtyOnHand,
			SUM(IsNull(I.QtyOnPreSale,0)) as QtyOnPreSale,
			SUM(IsNull(I.QtyOnOrder,0)) as QtyOnOrder,
			SUM(IsNull(I.QtyOnRepair,0)) as QtyOnRepair,
			SUM(IsNull(I.QtyOnPrePurchase,0)) as QtyInReceiving
		FROM			
			vw_Rep_Inventory I (NOLOCK)
		GROUP BY
			I.IDModel
		) I ON (M.IDModel = I.IDModel)
	LEFT OUTER JOIN vw_Rep_Entity F (NOLOCK) ON ( M.IDFabricante = F.IDPerson AND F.IDPersonType = 7 )
WHERE 
	M.Deleted = 0
GO

CREATE VIEW vwSaleItemTax AS

SELECT 
	PIM.IDPreInventoryMov as IDMov, 
 	SUM(ABS(((CASE WHEN (TC.SpecialDateStart <=  GETDATE()) AND (TC.SpecialDateEnd >= GETDATE()) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
		 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END)/100))) as Tax,
	0 as IsInvoice
FROM 
	PreInventoryMov PIM (NOLOCK)
	JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel )
	JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
	LEFT OUTER JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	LEFT OUTER JOIN TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STC.IDSaleTax )
WHERE 
	PIM.InventMovTypeID IN (1,25)
	AND PIM.IDParentPack Is Null
GROUP BY
	PIM.IDPreInventoryMov

UNION ALL

SELECT 
	IM.IDInventoryMov as IDMov, 
	SUM(ABS(IMX.Tax)) as Tax,
	1 as IsInvoice
FROM 
	InventoryMov IM (NOLOCK)
	JOIN InventoryMovTax IMX (NOLOCK) ON (IM.IDInventoryMov = IMX.IDInventoryMov)
WHERE 
	IM.InventMovTypeID IN (1,25)
	AND IM.IDParentPack Is Null
GROUP BY
	IM.IDInventoryMov
GO

CREATE VIEW dbo.vw_Rep_AgencyAgentInvoices
AS

SELECT
	IMV.MovDate,
	IMV.IDDocument as Invoice,
	IMV.Qty,
	IMV.CostPrice,
	(IMV.CostPrice * IMV.Qty) as ExtCostPrice,
	IMV.SalePrice,
	(IMV.SalePrice * IMV.Qty) as ExtSalePrice,
	(IMV.Discount * -1) as Discount,
	(IMV.SalePrice - IMV.Discount) as SubTotal,
	(IMV.SalePrice - IMV.Discount) + ROUND(((IMV.SalePrice - IMV.Discount) * IMV.SalesTax),2) as GrandTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) as ExtSubTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) + (CASE WHEN TaxIsent = 0 THEN ROUND((((IMV.SalePrice * IMV.Qty) - IMV.Discount) * IMV.SalesTax),2) ELSE 0 END) as ExtGrandTotal,
	IMV.ExchangeInvoice as InvoiceExchanged,
	IMV.QtyExchanged,
	(CASE WHEN I.TaxIsent = 0 THEN IMV.SalesTax ELSE 0 END) as SalesTax,
                I.LastName as CustomerLastName,
                I.FirstName as CustomerFirstName,
                I.ZIP as CustomerZip,
	M.Model,
	M.Description,
	M.FreightCost as Freight,
	M.OtherCost,
	M.VendorCost,
	M.DateLastCost as LastPurchaseDate,
	M.MarkUp,
	M.SellingPrice as OurPrice,
	M.DateLastSellingPrice as LastSaleDate,
	M.SuggRetail as MSRP,
	M.TotQtyOnHand,
	M.LastMovDate,
	M.AvgCost,
	M.FinalCost as NetCost,
	C.Category,
	ME.Media,
	S.Store,
	S.Address as StoreAddress,
	S.Telephone as StorePhone,
	S.IDState as State,
	S.City as StoreCity,
	S.Zip as StoreZip,
	S.Fax as StoreFax,
	S.Contact as StoreContact,
	COM.FirstName as SalesPersonFName,
	COM.LastName as SalesPersonLName,
	COM.FullName as SalesPersonFullName,
	INVC.ColorCode,
	INVC.Color,
	INVS.CodSize,
	INVS.SizeName,
	TRG.TipTouristGroup,
	TRG.NumTourist,
	TRG.EnterDate as GroupDate,
	AGN.FullName as Agency,
	AGT.FullName as Agent,
	I.AditionalExpenses, 
	I.Canceled,
	I.CupomFiscal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal

FROM	
	vw_Rep_InventoryMov IMV (NOLOCK)
	JOIN vw_Rep_Entity COM (NOLOCK) ON (COM.IDPerson = IMV.IDComission)
	JOIN vw_Rep_Store S (NOLOCK) ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M (NOLOCK) ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C (NOLOCK) ON (M.GroupID = C.IDCategory)
	LEFT OUTER JOIN vw_Rep_InvColor INVC (NOLOCK) ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS (NOLOCK) ON (INVS.IDSize = M.IDSize)
	JOIN vw_Rep_Invoice I (NOLOCK) ON (I.IDInvoice = IMV.IDDocument)
	JOIN vw_Rep_Media ME (NOLOCK) ON (ME.IDMedia = I.IDMedia)
	LEFT OUTER JOIN vw_Rep_TouristGroup TRG (NOLOCK) ON (TRG.IDTouristGroup = I.IDTouristGroup)
	LEFT OUTER JOIN vw_Rep_Entity AGN (NOLOCK) ON (AGN.IDPerson = TRG.IDAgency)
	LEFT OUTER JOIN vw_Rep_Entity AGT (NOLOCK) ON (AGT.IDPerson = TRG.IDGuide)
--	JOIN #Ret_ReportSource on (#Ret_ReportSource.IDInventoryMov = IMV.IDInventoryMov AND #Ret_ReportSource.IDInvoice = I.IDInvoice)
WHERE
	IMV.IDInventMovType = 1
	AND
	I.IDTouristGroup IS NOT NULL
	AND
	I.IDInvoice IS NOT NULL

GO

CREATE VIEW vw_Rep_CashRegisterFlow AS

SELECT
	AllSales.SaleDate,
	AllSales.SalesValue,
	AllSales.SalesEvenValue,
	ISNULL(DP.RepaymentsValue, 0) AS RepaymentsValue,
	SUM(ISNULL(RepaymentsValueEven, 0)) AS RepaymentsValueEven,
	ISNULL(AllSales.SalesEvenValue, 0) - SUM(ISNULL(RepaymentsValueEven, 0)) /*- 231564.0005*/ AS Saldo

FROM
	(
		SELECT
				AllDates.SaleDate,
				IsNull(DS.SalesValue, 0) AS SalesValue,
				SUM(SalesEven.SalesEvenValue) AS SalesEvenValue
		FROM
			(
				SELECT
					CASE WHEN vwDailySales.SaleDate IS NULL THEN RepaymentDate ELSE vwDailySales.SaleDate END AS SaleDate
				FROM	
					vwDailySales (NOLOCK)
					FULL OUTER JOIN vwDailyRepayment (NOLOCK) ON (RepaymentDate = SaleDate)								
				GROUP BY
					CASE WHEN vwDailySales.SaleDate IS NULL THEN RepaymentDate ELSE vwDailySales.SaleDate END
				
			) AS AllDates LEFT JOIN
			vwDailySales DS (NOLOCK) ON
				(AllDates.SaleDate = DS.SaleDate) LEFT JOIN
			(
				SELECT
					SaleDate,
					SUM(ISNULL(SalesValue, 0)) AS SalesEvenValue
				FROM
					vwDailySales (NOLOCK)
				GROUP BY
					SaleDate
			) SalesEven ON
				(AllDates.SaleDate >= SalesEven.SaleDate)
			
		GROUP BY
				AllDates.SaleDate,
				DS.SalesValue
	) AllSales LEFT JOIN
	
	vwDailyRepayment DP (NOLOCK)
		ON (AllSales.SaleDate = DP.RepaymentDate) LEFT JOIN
	(	
		SELECT
			RepaymentDate,
			RepaymentsValue AS RepaymentsValueEven
		FROM
			vwDailyRepayment (NOLOCK)

	) RepaymentsValueEven ON
		(AllSales.SaleDate >= RepaymentsValueEven.RepaymentDate)
GROUP BY
	AllSales.SaleDate,
	AllSales.SalesValue,
	AllSales.SalesEvenValue,
	DP.RepaymentsValue

GO

CREATE VIEW vw_Rep_CustomerPurchaseHistory_Sub AS

SELECT
	vw_Rep_InventoryMov.MovDate, 
	vw_Rep_InventoryMov.IDDocument, 
	vw_Rep_InventoryMov.Qty, 
	vw_Rep_Invoice.LastName, 
	vw_Rep_Invoice.FirstName, 
	vw_Rep_Invoice.ZIP, 
	vw_Rep_Invoice.InvoiceDate, 
	vw_Rep_Model.Model, 
	vw_Rep_Model.Description, 
	vw_Rep_Model.FreightCost, 
	vw_Rep_Model.OtherCost, 
	vw_Rep_Model.VendorCost, 
	vw_Rep_Model.DateLastCost, 
	vw_Rep_Model.MarkUp, 
	vw_Rep_Model.SellingPrice, 
	vw_Rep_Model.DateLastSellingPrice, 
	vw_Rep_Model.SuggRetail, 
	vw_Rep_Model.TotQtyOnHand, 
	vw_Rep_Model.LastMovDate, 
	vw_Rep_Model.AvgCost, 
	vw_Rep_Model.FinalCost, 
	vw_Rep_Media.Media, vw_Rep_Store.Store, 
	vw_Rep_Entity.IDCustomer, 
	vw_Rep_Entity.FullName, 
	vw_Rep_Entity.Address, vw_Rep_Entity.City, 
	vw_Rep_Entity.IDState, 
	vw_Rep_Entity.Zip Zip_2, 
	vw_Rep_Entity.Phone, vw_Rep_Entity.Fax, 
	vw_Rep_Entity.Email,
	vw_Rep_Model.IDFabricante
FROM
	vw_Rep_InventoryMov vw_Rep_InventoryMov (NOLOCK)
	INNER JOIN vw_Rep_Store vw_Rep_Store (NOLOCK) ON (vw_Rep_Store.IDStore = vw_Rep_InventoryMov.IDStore)
	INNER JOIN vw_Rep_Model vw_Rep_Model (NOLOCK) ON (vw_Rep_Model.IDModel = vw_Rep_InventoryMov.IDModel)
	INNER JOIN vw_Rep_Invoice vw_Rep_Invoice (NOLOCK) ON (vw_Rep_Invoice.IDInvoice = vw_Rep_InventoryMov.IDDocument)
	INNER JOIN vw_Rep_Media vw_Rep_Media (NOLOCK) ON (vw_Rep_Media.IDMedia = vw_Rep_Invoice.IDMedia)
	INNER JOIN vw_Rep_Entity vw_Rep_Entity (NOLOCK) ON (vw_Rep_Entity.IDCustomer = vw_Rep_Invoice.IDCustomer)
WHERE
	vw_Rep_InventoryMov.IDInventMovType = 1
	AND vw_Rep_Model.IDFabricante IS NOT NULL
	AND vw_Rep_Invoice.IDCustomer <> 1

GO

CREATE VIEW vw_Sis_ChaveEstrangeira  AS

SELECT 
	FC.TABLE_NAME AS TabelaDerivada,
	FC.COLUMN_NAME AS ChaveEstrangeira,
	DC.COLUMN_NAME AS ChaveOriginal,
	DC.TABLE_NAME AS TabelaOriginal,
	RC.CONSTRAINT_NAME AS ConstraintName
FROM
	INFORMATION_SCHEMA.KEY_COLUMN_USAGE FC (NOLOCK)
	JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC (NOLOCK) ON (FC.CONSTRAINT_NAME = RC.CONSTRAINT_NAME)
	JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE DC (NOLOCK) ON (RC.UNIQUE_CONSTRAINT_NAME = DC.CONSTRAINT_NAME)


GO

CREATE VIEW vwAgency (IDAgency, IDTipoAgency, Agency, IDStore, NomeJuridico, Endereco, Bairro, Cidade, CEP, Pais, Telefone, Fax, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, OrgaoEmissor, IDEstado, IDRamoAtividade, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, NumMovimentacoes, DiasAtraso, NumTransacoes, HomePage, Path, ComissaoSobreGuia, System, Desativado, Hidden, Code)  AS

SELECT
	P.IDPessoa,
	P.IDTipoPessoa,
	P.Pessoa,
	P.IDStore,
	P.NomeJuridico,
	P.Endereco,
	P.Bairro,
	P.Cidade,
	P.CEP,
	P.Pais,
	P.Telefone,
	P.Fax,
	P.Contato,
	P.Email,
	P.OBS,
	P.Juridico,
	P.TotalMovimentado,
	P.Limite,
	P.Nascimento,
	P.OrgaoEmissor,
	P.IDEstado,
	P.IDRamoAtividade,
	P.CPF,
	P.CGC,
	P.Identidade,
	P.CartTrabalho,
	P.InscEstadual,
	P.InscMunicipal,
	P.Contatos,
	P.NumAtrasos,
	P.NumMovimentacoes,
	P.DiasAtraso,
	P.NumTransacoes,
	P.HomePage,
	TP.Path,
	P.ComissaoSobreGuia,
	P.System,
	P.Desativado,
	P.Hidden,
	P.Code
FROM
	Pessoa P (NOLOCK),
	TipoPessoa TP (NOLOCK)
WHERE
	P.IDTipoPessoa =  TP.IDTipoPessoa 
	AND TP.Path LIKE '.003.003%'

GO

CREATE  VIEW vwCliente (IDCliente, IDTipoPessoa, Cliente, Customer, Code, IDStore, NomeJuridico, Endereco, Bairro, Cidade, CEP, Pais, Telefone, Fax, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, IDEstado, IDRamoAtividade, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, NumMovimentacoes, DiasAtraso, NumTransacoes, HomePage, Path, System, asSystem, Desativado, Hidden, IDUser)  AS

SELECT
	P.IDPessoa,
	P.IDTipoPessoa,
	P.Pessoa as Cliente,
	P.Pessoa as Customer,
	P.Code,
	P.IDStore,
	P.NomeJuridico,
	P.Endereco,
	P.Bairro,
	P.Cidade,
	P.CEP,
	P.Pais,
	P.Telefone,
	P.Fax,
	P.Contato,
	P.Email,
	P.OBS,
	P.Juridico,
	P.TotalMovimentado,
	P.Limite,
	P.Nascimento,
	P.IDEstado,
	P.IDRamoAtividade,
	P.CPF,
	P.CGC,
	P.Identidade,
	P.CartTrabalho,
	P.InscEstadual,
	P.InscMunicipal,
	P.Contatos,
	P.NumAtrasos,
	P.NumMovimentacoes,
	P.DiasAtraso,
	P.NumTransacoes,
	P.HomePage,
	TP.Path,
	P.System,
	P.System,
	P.Desativado,
	P.Hidden,
	P.IDUser
FROM
	Pessoa P (NOLOCK)
	JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa = TP.IDTipoPessoa)
WHERE
	TP.Path LIKE '.001%'

GO

CREATE VIEW vwComissionado (IDComissionado, IDTipoComissionado, Comissionado, Code, IDStore, NomeJuridico, Endereco, Bairro, Cidade, CEP, Pais, Telefone, Cellular, Beeper, Fax, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, OrgaoEmissor, IDEstado, IDRamoAtividade, CPF, CGC, Identidade, CartTrabalho, InscEstadual, ComissionOnProfit, InscMunicipal, Contatos, NumAtrasos, NumMovimentacoes, DiasAtraso, NumTransacoes, HomePage, Path, DiaPagamento, ComissaoSobreGuia, DescontaCoordenacao, System, Desativado, Hidden, IDUser, IDPais)  AS

SELECT
	P.IDPessoa,
	P.IDTipoPessoa,
	P.Pessoa,
	P.Code,
	P.IDStore,
	P.NomeJuridico,
	P.Endereco,
	P.Bairro,
	P.Cidade,
	P.CEP,
	P.Pais,
	P.Telefone,
	P.Cellular,
	P.Beeper,
	P.Fax,
	P.Contato,
	P.Email,
	P.OBS,
	P.Juridico,
	P.TotalMovimentado,
	P.Limite,
	P.Nascimento,
	P.OrgaoEmissor,
	P.IDEstado,
	P.IDRamoAtividade,
	P.CPF,
	P.CGC,
	P.Identidade,
	P.CartTrabalho,
	P.InscEstadual,
	TP.ComissionOnProfit,
	P.InscMunicipal,
	P.Contatos,
	P.NumAtrasos,
	P.NumMovimentacoes,
	P.DiasAtraso,
	P.NumTransacoes,
	P.HomePage,
	TP.Path,
	P.DiaQuitacao,
	P.ComissaoSobreGuia,
	P.DescontaCoordenacao,
	P.System,
	P.Desativado,
	P.Hidden,
	P.IDUser,
	P.IDPais
FROM
	Pessoa P (NOLOCK),
	TipoPessoa TP (NOLOCK)
WHERE
	P.IDTipoPessoa = TP.IDTipoPessoa
	AND TP.Path like '.003%'

GO

CREATE  VIEW vwFabricante (IDFabricante, Fabricante, IDTipoFabricante, Manufacturer, Code, IDStore, NomeJuridico, Endereco, Bairro, Cidade, CEP, Pais, Telefone, Cellular, Beeper, Fax, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, OrgaoEmissor, IDEstado, IDRamoAtividade, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, NumMovimentacoes, DiasAtraso, NumTransacoes, HomePage, Path, System, Desativado, Hidden, IDUser, IDPais, UserCode, Pessoa, IDPessoa)  AS

SELECT
	Pessoa.IDPessoa, 
	Pessoa, 
	Pessoa.IDTipoPessoa, 
	Pessoa, 
	Pessoa.Code, 
	Pessoa.IDStore, 
	Pessoa.NomeJuridico, 
	Pessoa.Endereco, 
	Pessoa.Bairro, 
	Pessoa.Cidade, 
	Pessoa.CEP, 
	Pessoa.Pais, 
	Pessoa.Telefone, 
	Pessoa.Cellular, 
	Pessoa.Beeper, 
	Pessoa.Fax, 
	Pessoa.Contato, 
	Pessoa.Email, 
	Pessoa.OBS, 
	Pessoa.Juridico, 
	Pessoa.TotalMovimentado, 
	Pessoa.Limite, 
	Pessoa.Nascimento, 
	Pessoa.OrgaoEmissor, 
	Pessoa.IDEstado, 
	Pessoa.IDRamoAtividade, 
	Pessoa.CPF, 
	Pessoa.CGC, 
	Pessoa.Identidade, 
	Pessoa.CartTrabalho, 
	Pessoa.InscEstadual, 
	Pessoa.InscMunicipal, 
	Pessoa.Contatos, 
	Pessoa.NumAtrasos, 
	Pessoa.NumMovimentacoes, 
	Pessoa.DiasAtraso, 
	Pessoa.NumTransacoes, 
	Pessoa.HomePage, 
	TipoPessoa.Path, 
	Pessoa.System, 
	Pessoa.Desativado, 
	Pessoa.Hidden, 
	Pessoa.IDUser, 
	Pessoa.IDPais, 
	UserCode, 
	Pessoa, 
	Pessoa.IDPessoa
FROM
	Pessoa (NOLOCK),
	TipoPessoa (NOLOCK)
WHERE
	Pessoa.IDTipoPessoa =  TipoPessoa.IDTipoPessoa 
	AND TipoPessoa.Path LIKE '.004%'

GO

CREATE VIEW vwFornecedor (IDFornecedor, IDTipoPessoa, Fornecedor, Code, Short_Name, Vendor, IDStore, NomeJuridico, Endereco, Bairro, Cidade, CEP, Pais, Telefone, Cellular, Beeper, Fax, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, OrgaoEmissor, IDEstado, IDRamoAtividade, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, NumMovimentacoes, DiasAtraso, NumTransacoes, HomePage, Path, System, Desativado, Hidden, IDUser, IDPais)  AS

SELECT
	Pessoa.IDPessoa, 
	Pessoa.IDTipoPessoa, 
	Pessoa, 
	Pessoa.Code, 
	Pessoa.Short_Name, 
	Pessoa, 
	Pessoa.IDStore, 
	Pessoa.NomeJuridico, 
	Pessoa.Endereco, 
	Pessoa.Bairro, 
	Pessoa.Cidade, 
	Pessoa.CEP, 
	Pessoa.Pais, 
	Pessoa.Telefone, 
	Pessoa.Cellular, 
	Pessoa.Beeper, 
	Pessoa.Fax, 
	Pessoa.Contato, 
	Pessoa.Email, 
	Pessoa.OBS, 
	Pessoa.Juridico, 
	Pessoa.TotalMovimentado, 
	Pessoa.Limite, 
	Pessoa.Nascimento, 
	Pessoa.OrgaoEmissor, 
	Pessoa.IDEstado, 
	Pessoa.IDRamoAtividade, 
	Pessoa.CPF, 
	Pessoa.CGC, 
	Pessoa.Identidade, 
	Pessoa.CartTrabalho, 
	Pessoa.InscEstadual, 
	Pessoa.InscMunicipal, 
	Pessoa.Contatos, 
	Pessoa.NumAtrasos, 
	Pessoa.NumMovimentacoes, 
	Pessoa.DiasAtraso, 
	Pessoa.NumTransacoes, 
	Pessoa.HomePage, 
	TipoPessoa.Path, 
	Pessoa.System, 
	Pessoa.Desativado, 
	Pessoa.Hidden, 
	Pessoa.IDUser, 
	Pessoa.IDPais
FROM
	Pessoa (NOLOCK),
	TipoPessoa (NOLOCK)
WHERE
	Pessoa.IDTipoPessoa =  TipoPessoa.IDTipoPessoa 
	AND TipoPessoa.Path LIKE '.002%'

GO

CREATE VIEW vwGroupToSpecialPrice AS

SELECT
	SpecialPrice.SpecialPrice,
	SpecialPriceByGroup.GroupID,
	SpecialPriceByGroup.SpecialMarkUp
FROM
	SpecialPrice (NOLOCK),
	SpecialPriceByGroup (NOLOCK)
WHERE
	SpecialPriceByGroup.SpecialPriceID = SpecialPrice.IDSpecialPrice
	AND SpecialPrice.Desativado = 0

GO

CREATE VIEW vwGuide (IDGuide, IDTipoGuide, Guide, IDStore, NomeJuridico, Endereco, Bairro, Cidade, CEP, Pais, Telefone, Fax, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, OrgaoEmissor, IDEstado, IDRamoAtividade, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, NumMovimentacoes, DiasAtraso, NumTransacoes, HomePage, Path, System, Desativado, Hidden, IDUser, Code)  AS

SELECT
	Pessoa.IDPessoa, 
	TipoPessoa.IDTipoPessoa, 
	Pessoa.Pessoa, 
	Pessoa.IDStore, 
	Pessoa.NomeJuridico, 
	Pessoa.Endereco, 
	Pessoa.Bairro, 
	Pessoa.Cidade, 
	Pessoa.CEP, 
	Pessoa.Pais, 
	Pessoa.Telefone, 
	Pessoa.Fax, 
	Pessoa.Contato, 
	Pessoa.Email, 
	Pessoa.OBS, 
	Pessoa.Juridico, 
	Pessoa.TotalMovimentado, 
	Pessoa.Limite, 
	Pessoa.Nascimento, 
	Pessoa.OrgaoEmissor, 
	Pessoa.IDEstado, 
	Pessoa.IDRamoAtividade, 
	Pessoa.CPF, 
	Pessoa.CGC, 
	Pessoa.Identidade, 
	Pessoa.CartTrabalho, 
	Pessoa.InscEstadual, 
	Pessoa.InscMunicipal, 
	Pessoa.Contatos, 
	Pessoa.NumAtrasos, 
	Pessoa.NumMovimentacoes, 
	Pessoa.DiasAtraso, 
	Pessoa.NumTransacoes, 
	Pessoa.HomePage, 
	TipoPessoa.Path, 
	Pessoa.System, 
	Pessoa.Desativado, 
	Pessoa.Hidden, 
	Pessoa.IDUser, 
	Pessoa.Code
FROM
	Pessoa (NOLOCK),
	TipoPessoa (NOLOCK)
WHERE
	Pessoa.IDTipoPessoa =  TipoPessoa.IDTipoPessoa 
	AND TipoPessoa.Path LIKE '.003.002%'

GO

CREATE VIEW vwModelToSpecialPrice AS

SELECT
	ModelToSpecialPrice.IDModel,
	ModelToSpecialPrice.IDSpecialPrice,
	SpecialPrice.SpecialPrice,
	ModelToSpecialPrice.MarkUp
FROM
	ModelToSpecialPrice (NOLOCK),
	SpecialPrice (NOLOCK)
WHERE
	ModelToSpecialPrice.IDSpecialPrice = SpecialPrice.IDSpecialPrice

GO

CREATE VIEW vwOther (IDPessoa, IDTipoPessoa, Other, IDStore, NomeJuridico, Endereco, Bairro, Cidade, CEP, Pais, Telefone, Fax, Contato, Email, OBS, Juridico, TotalMovimentado, Limite, Nascimento, OrgaoEmissor, IDEstado, IDRamoAtividade, CPF, CGC, Identidade, CartTrabalho, InscEstadual, InscMunicipal, Contatos, NumAtrasos, NumMovimentacoes, DiasAtraso, NumTransacoes, HomePage, Path, System, Desativado, Hidden, IDUser, Code)  AS

SELECT 
	Pessoa.IDPessoa, 
	TipoPessoa.IDTipoPessoa, 
	Pessoa.Pessoa, 
	Pessoa.IDStore, 
	Pessoa.NomeJuridico, 
	Pessoa.Endereco, 
	Pessoa.Bairro, 
	Pessoa.Cidade, 
	Pessoa.CEP, 
	Pessoa.Pais, 
	Pessoa.Telefone, 
	Pessoa.Fax, 
	Pessoa.Contato, 
	Pessoa.Email, 
	Pessoa.OBS, 
	Pessoa.Juridico, 
	Pessoa.TotalMovimentado, 
	Pessoa.Limite, 
	Pessoa.Nascimento, 
	Pessoa.OrgaoEmissor, 
	Pessoa.IDEstado, 
	Pessoa.IDRamoAtividade, 
	Pessoa.CPF, 
	Pessoa.CGC, 
	Pessoa.Identidade, 
	Pessoa.CartTrabalho, 
	Pessoa.InscEstadual, 
	Pessoa.InscMunicipal, 
	Pessoa.Contatos, 
	Pessoa.NumAtrasos, 
	Pessoa.NumMovimentacoes, 
	Pessoa.DiasAtraso, 
	Pessoa.NumTransacoes, 
	Pessoa.HomePage, 
	TipoPessoa.Path, 
	Pessoa.System, 
	Pessoa.Desativado, 
	Pessoa.Hidden, 
	Pessoa.IDUser, 
	Pessoa.Code
FROM
	Pessoa (NOLOCK),
	TipoPessoa (NOLOCK)
WHERE
	Pessoa.IDTipoPessoa =  TipoPessoa.IDTipoPessoa 
	AND TipoPessoa.Path LIKE '.003.004%'

GO

CREATE VIEW vwPessoa AS
SELECT
	P.IDPessoa,
	P.IDTipoPessoa,
	TP.Path,
	P.Pessoa,
	P.Telefone,
	P.Cellular,
	P.Fax,
	P.Code,
	P.System,
	P.Desativado,
	P.Hidden,
	C.Pais as Country,
	E.Estado as StateName,
	E.IDEstado as State,
	P.Endereco as Address,
	P.Cidade as City,
	P.CEP as Zip,
	P.Email,
	P.Contato as Contact,
	P.InscEstadual as FederalID,
	P.InscMunicipal as SalesTax,
	P.CartMotorista as DriverLicense,
	P.CartTrabalho as JobDoc,
	P.UserCode,
	P.Identidade as SocialSecurity,
	P.DataExpedicao as SCDate,
	P.OrgaoEmissor as SCGov,
	P.PessoaLastName as LastName,
	P.PessoaFirstName as FirstName,
	P.CPF,
	P.CGC,
	P.CustomerCard as CustomerCard,
	P.Bairro as Neighborwood,
	P.PhoneAreaCode,
	P.CellAreaCode,
	P.Nascimento
FROM
	Pessoa P (NOLOCK)
	JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa = TP.IDTipoPessoa)
	LEFT OUTER JOIN Pais C (NOLOCK) ON (P.IDPais = C.IDPais)
	LEFT OUTER JOIN Estado E (NOLOCK) ON (P.IDEstado = E.IDEstado)

GO

CREATE VIEW vwPessoaFullName (PessoaName, IDTipoPessoa, IDPessoa, Hidden, Desativado, Code)  AS

SELECT
	(RTRIM( IsNull((convert(char(30), P.Pessoa)),'') ) + ', ' + RTRIM( IsNull((convert(char(30),PessoaLastName)),'') )),
	P.IDTipoPessoa,
	P.IDPessoa,
	P.Hidden,
	P.Desativado,
	P.Code
FROM
	Pessoa P (NOLOCK)

GO

CREATE VIEW vwSalesPerson AS
SELECT 
	Pessoa.IDPessoa IDSalesPerson,
	TipoPessoa.IDTipoPessoa IDTipoSalesPerson,
	Pessoa.Pessoa SalesPerson,
	(Pessoa.PessoaFirstName + ', ' + Pessoa.PessoaLastName) as PessoaEdited,
	Pessoa.IDStore,
	Pessoa.NomeJuridico,
	Pessoa.Endereco,
	Pessoa.Bairro,
	Pessoa.Cidade,
	Pessoa.CEP,
	Pessoa.Pais,
	Pessoa.Telefone,
	Pessoa.Fax,
	Pessoa.Contato,
	Pessoa.Email,
	Pessoa.OBS,
	Pessoa.Juridico,
	Pessoa.TotalMovimentado,
	Pessoa.Limite,
	Pessoa.Nascimento,
	Pessoa.OrgaoEmissor,
	Pessoa.IDEstado,
	Pessoa.IDRamoAtividade,
	Pessoa.CPF,
	Pessoa.CGC,
	Pessoa.Identidade,
	Pessoa.CartTrabalho,
	Pessoa.InscEstadual,
	Pessoa.InscMunicipal,
	Pessoa.Contatos,
	Pessoa.NumAtrasos,
	Pessoa.NumMovimentacoes,
	Pessoa.DiasAtraso,
	Pessoa.NumTransacoes,
	Pessoa.HomePage,
	TipoPessoa.Path,
	Pessoa.System,
	Pessoa.Desativado,
	Pessoa.Hidden,
	Pessoa.IDUser,
	Pessoa.Code
FROM 	
	Pessoa (NOLOCK),
	TipoPessoa (NOLOCK)
WHERE
	Pessoa.IDTipoPessoa =  TipoPessoa.IDTipoPessoa 
	AND TipoPessoa.Path LIKE '.003.001%'


GO

CREATE VIEW vwTipoCliente (IDTipoCliente, Path, TipoCliente, PathName, System, Desativado, Hidden)  AS

SELECT
	TipoPessoa.IDTipoPessoa,
	TipoPessoa.Path,
	TipoPessoa.TipoPessoa,
	TipoPessoa.PathName,
	TipoPessoa.System,
	TipoPessoa.Desativado,
	TipoPessoa.Hidden
FROM
	TipoPessoa (NOLOCK)
WHERE
	TipoPessoa.Path like '.001%'

GO

CREATE VIEW vwTipoComissionado (IDTipoComissionado, Path, TipoComissionado, PathName, Desativado, DefaultDiaPag, ComissionOnProfit, System, Hidden)  AS

SELECT 
	TipoPessoa.IDTipoPessoa, 
	TipoPessoa.Path, 
	TipoPessoa.TipoPessoa, 
	TipoPessoa.PathName, 
	TipoPessoa.Desativado, 
	TipoPessoa.DefaultDiaPag, 
	TipoPessoa.ComissionOnProfit, 
	TipoPessoa.System, 
	TipoPessoa.Hidden
FROM
	TipoPessoa (NOLOCK)
WHERE
	TipoPessoa.Path like '.003%'

GO

CREATE VIEW vwTipoFabricante (IDTipoFabricante, Path, TipoFabricante, PathName, System, Desativado, Hidden)  AS

SELECT 
	TipoPessoa.IDTipoPessoa, 
	TipoPessoa.Path, 
	TipoPessoa.TipoPessoa, 
	TipoPessoa.PathName, 
	TipoPessoa.System, 
	TipoPessoa.Desativado,
	TipoPessoa.Hidden
FROM
	TipoPessoa (NOLOCK)
WHERE
	TipoPessoa.Path like '.004%'

GO

CREATE VIEW vwTipoFornecedor (IDTipoFornecedor, Path, TipoFornecedor, PathName, System, Desativado, Hidden)  AS

SELECT 
	TipoPessoa.IDTipoPessoa, 
	TipoPessoa.Path, 
	TipoPessoa.TipoPessoa, 
	TipoPessoa.PathName, 
	TipoPessoa.System, 
	TipoPessoa.Desativado, 
	TipoPessoa.Hidden
FROM
	TipoPessoa (NOLOCK)
WHERE
	TipoPessoa.Path like '.002%'

GO

CREATE VIEW vw_Rep_Acc_Bank (IDBank, BankCode, Bank, System, Hidden, Deleted)  AS

SELECT
	B.IDBanco,
	B.CodigoBanco,
	B.Banco,
	B.System,
	B.Hidden,
	B.Desativado
FROM
	Fin_Banco B (NOLOCK)


GO

CREATE VIEW vw_Rep_Acc_CostCenter (IDCostCenter, CostCenterCod, CostCenter, Deleted, Hidden, System)  AS

SELECT
	CC.IDCentroCusto,
	CC.CodigoCentroCusto,
	CC.CentroCusto,
	CC.Desativado,
	CC.Hidden,
	CC.System
FROM
	Fin_CentroCusto CC (NOLOCK)

GO


CREATE VIEW vw_Rep_Acc_Group (IDGroup, Groups, Hidden, Deleted, System)  AS

SELECT
	G.IDGrupo,
	G.Grupo,
	G.Hidden,
	G.Desativado,
	G.System
FROM
	Sis_Grupo G (NOLOCK)

GO

CREATE VIEW vw_Rep_Acc_Holiday (IDHoliday, Holiday, Date, Hidden, Deleted, System)  AS

SELECT
	F.IDFeriado,
	F.Feriado,
	F.Data,
	F.Hidden,
	F.Desativado,
	F.System
FROM
	Sis_Feriado F (NOLOCK)

GO

CREATE VIEW vw_Rep_CashRegLogType (IDCashRegTipoLog, CashRegTipoLog, Entering, Move, PettyCash)  AS

SELECT
	C.IDCashRegTipoLog,
	C.CashRegTipoLog,
	C.Entrando,
	C.Movimenta,
	C.PettyCash
FROM
	CashRegTipoLog C (NOLOCK)

GO

CREATE VIEW vw_Rep_CashRegister AS

SELECT
	C.IDCashRegister,
	C.Name,
	C.IsAssociated
FROM
	CashRegister C (NOLOCK)

GO

CREATE VIEW vw_Rep_CostType AS

SELECT
	C.IDCostType,
	C.CostType,
	C.DefaultValue
FROM
	CostType C (NOLOCK)

GO

CREATE VIEW vw_Rep_DeliverType AS

SELECT
	D.IDDeliverType,
	D.Name
FROM
	DeliverType D (NOLOCK)

GO

CREATE VIEW vw_Rep_EntityType (IDPersonType,Path,PersonType,PathName,PayDayDefault,CommissionOnProfit,Deleted,LastCode) AS

SELECT
	T.IDTipoPessoa,
	T.Path,
	T.TipoPessoa,
	T.PathName,
	T.DefaultDiaPag,
	T.ComissionOnProfit,
	T.Desativado,
	T.LastCode
FROM
	TipoPessoa T (NOLOCK)

GO

CREATE VIEW vw_Rep_Hotel (IDHotel, Hotel, Address, City, Zip, Phone, Fax, Note)  AS

SELECT
	H.IDHotel,
	H.Hotel,
	H.Endereco,
	H.Cidade,
	H.CEP,
	H.Telefone,
	H.Fax,
	H.OBS
FROM
	Hotel H (NOLOCK)

GO

CREATE VIEW vw_Rep_InventoryMovType (IDInventMovType, Name, Entering)  AS

SELECT
	I.IDInventMovType,
	I.Name,
	I.Entrando
FROM
	InventoryMovType I (NOLOCK)

GO

CREATE VIEW vw_Rep_PaidCommission AS

SELECT
	C.IDDocumento,
	C.IDLancPag
FROM
	ComisPaga C (NOLOCK)

GO

CREATE VIEW vw_Sis_FatorMoedaPadrao (Fator, DataCotacao, IDMoedaCotacao, IDMoeda, Sigla)  AS

SELECT
	M.ValorMoedaPadrao,
	M.DataCotacao,
	M.IDMoedaCotacao,
	M.IDMoeda,
	M.Sigla
FROM
	Sis_Moeda M (NOLOCK)

GO

CREATE VIEW MenuRights (UserTypeID, ParentMenu, ModuleName, CanAccess, CanInsert, CanDelete, CanUpdate, CanPrint, IDMenu, IDSubMenu)  AS

SELECT
	UR.UserTypeID,
	MI.ParentMenu,
	MI.Name,
	UR.CanAccess,
	UR.CanInsert,
	UR.CanDelete,
	UR.CanUpdate,
	UR.CanPrint,
	UR.MenuID,
	UR.SubMenuID
FROM
	UserRights UR (NOLOCK),
	MenuItem MI (NOLOCK)
WHERE
	UR.MenuID = MI.IDMenu
	AND UR.SubMenuID = MI.IDSubMenu

GO

CREATE VIEW vwInvoiceCommission (IDInvoice, SalesPerson, Agency, Guide)  AS

SELECT
	IC.IDInvoice,
	IsNull(SUM( CASE IC.TIPO WHEN 'S' THEN IC.Commission ELSE 0 END),0),
	IsNUll(SUM( CASE IC.TIPO WHEN 'A' THEN IC.Commission ELSE 0 END),0),
	IsNull(SUM( CASE IC.TIPO WHEN 'G' THEN IC.Commission ELSE 0 END),0)
FROM
	InvoiceCommission IC (NOLOCK)
GROUP BY
	IDInvoice

GO

CREATE VIEW vwSpecialPriceToGroup (IDSpecialPrice, SpecialPriceID, Name, SpecialMarkUp, IDGroup)  AS

SELECT
	SpecialPriceID as IDSpecialPrice,
	SpecialPriceByGroup.SpecialPriceID,
	TabGroup.Name,
	SpecialPriceByGroup.SpecialMarkUp,
	TabGroup.IDGroup
FROM
	SpecialPriceByGroup (NOLOCK),
	TabGroup (NOLOCK)
WHERE
	SpecialPriceByGroup.GroupID = TabGroup.IDGroup

GO

CREATE VIEW vwSystemUser AS

SELECT
	SystemUser.IDUser,
	SystemUser.SystemUser
FROM
	SystemUser (NOLOCK)

GO

CREATE VIEW vw_Rep_Acc_BankBranch (IDBranch, BranchCode, IDBank, Branch, Address, City, Hidden, Deleted, System)  AS

SELECT
	BB.IDBancoAgencia,
	BB.CodigoBancoAgencia,
	BB.IDBanco,
	BB.BancoAgencia,
	BB.Endereco,
	BB.Bairro,
	BB.Hidden,
	BB.Desativado,
	BB.System
FROM
	Fin_BancoAgencia BB (NOLOCK)

GO

CREATE VIEW vw_Rep_Acc_Company (IDConpany, CompanyCode, Company, Address, City, Country, System, Deleted, Hidden)  AS

SELECT
	E.IDEmpresa,
	E.CodigoEmpresa,
	E.Empresa,
	E.Endereco,
	E.Cidade,
	E.Pais,
	E.System,
	E.Desativado,
	E.Hidden
FROM
	Sis_Empresa E (NOLOCK)

GO

CREATE VIEW vw_Rep_Acc_User (IDUser, UserCode, Users, Deleted, Hidden, System) AS

SELECT
	U.IDUser,
	U.CodSystemUser,
	U.SystemUser,
	U.Desativado,
	U.Hidden,
	U.System
FROM
	SystemUser U (NOLOCK)

GO

CREATE VIEW vw_Rep_DiscRange (IDComissionedType, MinTotSale, PercDiscMax)  AS

SELECT
	D.IDTipoComissionado,
	D.TotVendaMin,
	D.PercDiscMax
FROM
	DiscRange D (NOLOCK)

GO

CREATE VIEW dbo.vw_Rep_InventoryQtyByModel
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte aos relatórios da pasta Inventory

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT
	I.IDModel,
	SUM(IsNull(I.QtyOnHand,0)) as QtyOnHand,
	SUM(IsNull(I.QtyOnPreSale,0)) as QtyOnPreSale,
	SUM(IsNull(I.QtyOnOrder,0)) as QtyOnOrder,
	SUM(IsNull(I.QtyOnRepair,0)) as QtyOnRepair,
	SUM(IsNull(I.QtyOnPrePurchase,0)) as QtyInReceiving
FROM			
	vw_Rep_Inventory I (NOLOCK)
	JOIN vw_Rep_Model M (NOLOCK) ON (I.IDModel = m.IDModel)
GROUP BY
	I.IDModel

GO

CREATE VIEW dbo.vw_Rep_InventoryQtyByStore AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte aos relatórios da pasta Inventory

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
SELECT
	I.IDModel,
	I.IDStore,
	SUM(IsNull(I.QtyOnHand,0)) as QtyOnHand,
	SUM(IsNull(I.QtyOnPreSale,0)) as QtyOnPreSale,
	SUM(IsNull(I.QtyOnOrder,0)) as QtyOnOrder,
	SUM(IsNull(I.QtyOnRepair,0)) as QtyOnRepair,
	SUM(IsNull(I.QtyOnPrePurchase,0)) as QtyInReceiving
FROM			
	vw_Rep_Inventory I (NOLOCK)
	JOIN vw_Rep_Model M (NOLOCK) ON (I.IDModel = m.IDModel)
GROUP BY
	I.IDModel,
	I.IDStore

GO

CREATE VIEW vw_Rep_SystemUser (IDUser, IDUserType, IDCommission, SystemUser)  AS

SELECT
	S.IDUser,
	S.UserTypeID,
	S.ComissionID,
	S.SystemUser
FROM
	SystemUser S (NOLOCK)

GO

CREATE VIEW vw_Sis_GrupoMainMenu AS

SELECT
	Sis_GrupoMainMenu.IDMenuItem,
	Sis_Grupo.Grupo,
	Sis_GrupoMainMenu.Acessa,
	Sis_Grupo.IDGrupo
FROM
	Sis_GrupoMainMenu (NOLOCK),
	Sis_Grupo (NOLOCK)
WHERE
	Sis_GrupoMainMenu.IDGrupo = Sis_Grupo.IDGrupo
	AND Sis_Grupo.Desativado = 0

GO

CREATE VIEW vwComissionTypeToGroup AS

SELECT
	TG.Name,
	GC.Comission
FROM
	TabGroup TG (NOLOCK),
	GroupToComissionType GC (NOLOCK)
WHERE
	TG.IDGroup = GC.GroupID
	AND TG.Desativado = 0

GO

CREATE VIEW vwGroupToComissionType AS

SELECT
	vwTipoComissionado.TipoComissionado,
	GroupToComissionType.Comission
FROM
	vwTipoComissionado (NOLOCK),
	GroupToComissionType (NOLOCK)
WHERE
	vwTipoComissionado.IDTipoComissionado = GroupToComissionType.IDTipoComissionado  
	AND vwTipoComissionado.Desativado = 0

GO

CREATE VIEW vwInvQuantity (Store, QtyOnPreSale, QtyOnHand, QtyOnOrder, MaxQty, MinQty, Location)  AS

SELECT
	Store.Name,
	Inventory.QtyOnPreSale,
	Inventory.QtyOnHand,
	Inventory.QtyOnOrder,
	Inventory.MaxQty,
	Inventory.MinQty,
Inventory.Location
FROM
	Inventory (NOLOCK),
	Store (NOLOCK)
WHERE
	Store.IDStore = Inventory.StoreID

GO

CREATE VIEW vwModelGroup AS
SELECT
	MG.IDModelGroup,
	(SUBSTRING(TG.Name+'      ',1,6) + '..\'+ MG.ModelGroup) as ModelGroup,
	(TG.Name + '\'+ MG.ModelGroup) as FullModelGroup,
	MG.UserCode,
	MG.Desativado,
	MG.Hidden,
	MG.IDGroup
FROM
	ModelGroup MG (NOLOCK)
	JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)
GO

CREATE VIEW vwUserTypeToSysFunction AS

SELECT
	UserTypeToSysFunction.IDUserType,
	SysFunction.SysFunction,
	UserTypeToSysFunction.Acesso,
	SysFunction.IDMenu,
	SysFunction.IDSubMenu
FROM
	UserTypeToSysFunction (NOLOCK),
	SysFunction (NOLOCK)
WHERE
	UserTypeToSysFunction.IDSysFunction = SysFunction.IDSysFunction

GO

CREATE VIEW vw_Rep_Acc_BankAccount (IDBankAccount, IDCurrency, IDCostCenter, IDBank, IDBankBranch, IDCompany, Type, BankAccountCode, Number, Manager, OpenDate, OBS, Balance, LastBalance, LastReconciliation, System, Deleted, Hidden)  AS

SELECT
	BA.IDContaCorrente,
	BA.IDMoeda,
	BA.IDCentroCusto,
	BA.IDBanco,
	BA.IDBancoAgencia,
	BA.IDEmpresa,
	BA.Tipo,
	BA.CodigoContaCorrente,
	BA.Numero,
	BA.Gerente,
	BA.DataAbertura,
	BA.OBS,
	BA.SaldoAtual,
	BA.UltimoSaldoBancario,
	BA.UltimaReconciliacao,
	BA.System,
	BA.Desativado,
	BA.Hidden
FROM
	Fin_ContaCorrente BA (NOLOCK)


GO

CREATE VIEW vw_Rep_Acc_UserGroup (IDGroup, IDUser)  AS

SELECT
	UG.IDGrupo,
	UG.IDUsuario
FROM
	Sis_UsuarioGrupo UG (NOLOCK)

GO

CREATE VIEW vw_Rep_CashRegMov AS

SELECT
	C.IDCashRegMov,
	C.IDCashRegister,
	C.IDCashRegStatus,
	C.OpenTime,
	C.IDOpenUser,
	C.TotalDeposit,
	C.TotalSales,
	C.TotalWidraw,
	C.OpenDeposit,
	C.FinalWidraw,
	C.TotalSaleCash,
	C.TotalPetty,
	C.FinalCount,
	C.ManagerCount
FROM
	CashRegMov C (NOLOCK)

GO

CREATE VIEW vw_Rep_GroupToCommissionType (IDPersonType, IDGroup, Commission)  AS

SELECT
	G.IDTipoComissionado,
	G.GroupID,
	G.Comission
FROM
	GroupToComissionType G (NOLOCK)

GO

CREATE VIEW vw_Sis_EmpresaGrupo AS

SELECT
	GE.IDGrupo,
	GE.IDEmpresa,
	G.Grupo,
	GE.Permissao
FROM
	Sis_Grupo G (NOLOCK),
	Sis_GrupoEmpresa GE (NOLOCK)
WHERE
	G.IDGrupo =  GE.IDGrupo 
	AND G.Desativado =  0

GO

CREATE VIEW vw_Sis_GrupoEmpresa AS

SELECT
	GE.IDGrupo,
	GE.IDEmpresa,
	E.Empresa,
	GE.Permissao
FROM
	Sis_GrupoEmpresa GE (NOLOCK),
	Sis_Empresa E (NOLOCK)
WHERE
	E.IDEmpresa =  GE.IDEmpresa 
	AND E.Desativado =  0

GO

CREATE VIEW vwModelSubGroup AS
SELECT
	MSG.IDModelGroup,
	MSG.IDModelSubGroup,
	TG.IDGroup,
	(SUBSTRING(TG.Name+'      ',1,6) + '..\'+ SUBSTRING(MG.ModelGroup+'      ',1,6) + '..\' + MSG.ModelSubGroup) as ModelSubGroup,
	(TG.Name + '\'+ MG.ModelGroup + '\' + MSG.ModelSubGroup) as FullModelSubGroup,
	MSG.UserCode,
	MSG.Desativado,
	MSG.Hidden
FROM
	ModelSubGroup MSG (NOLOCK)
	JOIN ModelGroup MG (NOLOCK) ON (MSG.IDModelGroup = MG.IDModelGroup)
	JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)
GO

CREATE VIEW dbo.vw_CategorySubCatGroup AS
SELECT
	TG.IDGroup as IDCategory,
	NULL as IDModelGroup,
	NULL as IDModelSubGroup,
	TG.Name as Category
FROM
      TabGroup TG (NOLOCK)

UNION ALL

SELECT
	TG.IDGroup as IDCategory,
	MG.IDModelGroup as IDModelGroup,
	NULL as IDModelSubGroup,
	TG.Name + '\' + MG.ModelGroup As Category
FROM
      TabGroup TG (NOLOCK)
      JOIN ModelGroup MG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)

UNION ALL

SELECT
	TG.IDGroup as IDCategory,
	MG.IDModelGroup,
	MSG.IDModelSubGroup,
	TG.Name + '\'+ MG.ModelGroup + '\'+ MSG.ModelSubGroup as Category
FROM
      TabGroup TG (NOLOCK)
      JOIN ModelGroup MG (NOLOCK) ON (TG.IDGroup = MG.IDGroup)
      JOIN ModelSubGroup MSG (NOLOCK) ON (MG.IDModelGroup = MSG.IDModelGroup)
GO

CREATE VIEW vw_PO_BrwPO (IDPO, IDFornecedor, Fornecedor, DataPedido, Aberto, SubTotal, Atendido, IDStore, Charges, Freight, PaymenteType, Code)  AS

SELECT
	PO.IDPO,
	PO.IDFornecedor,
	PE.Pessoa,
	PO.DataPedido,
	PO.Aberto,
	PO.SubTotal,
	PO.Atendido,
	PO.IDStore,
	PO.Charges,
	PO.Freight,
	PO.PaymenteType,
	PE.Code
FROM
	PO PO (NOLOCK),
	Pessoa PE (NOLOCK)
WHERE
	PO.IDFornecedor *= PE.IDPessoa


GO

CREATE VIEW vw_Rep_Acc_BankAccountBalance (IDBankAccount, Date, Balance)  AS

SELECT
	BAB.IDContaCorrente,
	BAB.Data,
	BAB.Saldo
FROM
	Fin_ContaCorrenteSaldo BAB (NOLOCK)


GO

CREATE VIEW vw_Rep_Acc_BankAccountTransaction (Amount, TransDate, DocumentNumber, Payee, IDPayment, IDTransfer, IDPaymentType, IDBranch, IDBank, IDBankAccount, IDUser, PaymentDate, ReconciliationDate, Reconciliated, IDMeioPag, PaymentType, DocumentIdentifier, BankAccountType, BankAccountNumber, BankAccountCode, BankCode, Bank, BankBalance, AccBalance)  AS

SELECT
	(P.Amount + P.Interest) * (1-2*P.Paying) as Amount,
	P.PaymentDate as TransDate,
	P.DocumentNumber,
	P.Payee,
	P.IDPayment,
	P.IDTransfer,
	P.IDPaymentType,
	P.IDBranch,
	P.IDBank,
	P.IDBankAccount,
	P.IDUser,
	P.PaymentDate,
	P.ReconciliationDate,
	CASE P.IsReconciliated
		WHEN 0 THEN 'C'
		WHEN 1 THEN 'R'
	END as Reconciliated,
	PT.IDMeioPag as IDPaymentType,
	PT.MeioPag,
	PT.DocumentIdentifier,
	BA.Type as BankAccountType,
	BA.Number as BankAccountNumber,
	BA.BankAccountCode,
	B.BankCode,
	B.Bank,
	BankBal.BankBalance,
	AccBalance.AccBalance
FROM
	vw_Rep_Acc_Payment P (NOLOCK)
	JOIN vw_Rep_PaymentType PT (NOLOCK) ON (PT.IDMeioPag = P.IDPaymentType)
	JOIN vw_Rep_Acc_BankAccount BA (NOLOCK) ON (BA.IDBankAccount = P.IDBankAccount AND BA.Deleted = 0)
	JOIN vw_Rep_Acc_Bank B (NOLOCK) ON (B.IDBank = BA.IDBank)
	--Account Balance
	JOIN (
	SELECT
		SUM((P.Amount + P.Interest) * (1-2*P.Paying)) as AccBalance,
		BA.IDBankAccount
	FROM
		vw_Rep_Acc_Payment P (NOLOCK)
		JOIN vw_Rep_Acc_BankAccount BA (NOLOCK) ON (BA.IDBankAccount = P.IDBankAccount AND BA.Deleted = 0)
	WHERE
		P.Deleted = 0
	GROUP BY
		BA.IDBankAccount
	) AccBalance ON (AccBalance.IDBankAccount = BA.IDBankAccount)
	--Bank Balane
	JOIN (
	SELECT
		SUM((P.Amount + P.Interest) * (1-2*P.Paying)) as BankBalance,
		BA.IDBank
	FROM
		vw_Rep_Acc_Payment P (NOLOCK)
		JOIN vw_Rep_Acc_BankAccount BA (NOLOCK) ON (BA.IDBankAccount = P.IDBankAccount AND BA.Deleted = 0)
	WHERE
		P.Deleted = 0
	GROUP BY
		BA.IDBank
	) BankBal ON (BankBal.IDBank = B.IDBank)
WHERE
	P.Deleted = 0

GO

CREATE VIEW vw_Rep_Acc_RecordType (IDRecordType, IDPerson, IDPersonType, IDBankAccount, IDRecordTypeParent, RecordType, Path, PathName, System, Hidden, Deleted, AccountCode)  AS

SELECT
	LT.IDLancamentoTipo,
	LT.IDPessoa,
	LT.IDPessoaTipo,
	LT.IDContaCorrenteDefault,
	LT.IDLancamentoTipoParent,
	LT.LancamentoTipo,
	LT.Path,
	LT.PathName,
	LT.System,
	LT.Hidden,
	LT.Desativado,
	LT.CodigoContabil
FROM
	Fin_LancamentoTipo LT (NOLOCK)

GO

CREATE VIEW vw_Rep_Acc_Transfer (IDTransfer, IDBankAccountCredit, IDBankAccountDebit, Date, Amount, Obs, IDUser)  AS

SELECT
	T.IDTransferencia,
	T.IDContaCorrenteCredito,
	T.IDContaCorrenteDebito,
	T.Data,
	T.Valor,
	T.Obs,
	T.IDUsuario
FROM
	Fin_Transferencia T (NOLOCK)

GO

CREATE VIEW vw_Rep_CashRegLog AS

SELECT
	C.IDCashRegLog,
	C.IDCashRegMov,
	C.IDCashRegTipoLog,
	C.IDUser,
	C.LogTime,
	C.Bill100,
	C.Bill50,
	C.Bill20,
	C.Bill10,
	C.Bill5,
	C.Bill2,
	C.Bill1,
	C.Coin1,
	C.Coin050,
	C.Coin025,
	C.Coin010,
	C.Coin005,
	C.Coin001,
	C.TotalCard,
	C.TotalCheck,
	C.TotalOther,
	C.TotalCash,
	C.TotalCashConf,
	C.TotalOtherConf,
	C.TotalCheckConf,
	C.TotalCardConf,
	C.TotalCardPre,
	C.TotalCardPreConf,
	C.LogDocument
FROM
	CashRegLog C (NOLOCK)

GO

CREATE VIEW vw_Rep_ModelTransf (IDModelTransf, Number, IDLojaOrigem, IDLojaDestino, IDUser, TransferType, Date) 
AS

SELECT 
	M.IDModelTransf,
	M.Number,
	M.IDLojaOrigem,
	M.IDLojaDestino,
	M.IDUser,
	M.TransferType,
	M.Data
FROM
	ModelTransf M (NOLOCK)

GO

CREATE VIEW vw_Rep_PurchaseOrder  AS

SELECT 
	P.IDPO, 
	P.IDStore, 
	P.IDFornecedor as IDVendor, 
	P.DataPedido as OrderDate, 
	P.Aberto as _Open_, 
	P.Freight, 
	P.Charges, 
	P.SubTotal, 
	P.Atendido, 
	P.PaymenteType,
	P.OBS,
	P.EstArrival,
	P.PayDays
FROM 
	PO P (NOLOCK)

GO

CREATE VIEW vw_Rep_Quotation (IDQuotation, IDStore, Quotation, LastIssue, QuotationDate)  AS

SELECT
	C.IDCotacao,
	C.IDStore,
	C.Cotacao,
	C.UltimaEmissao,
	C.DataCotacao
FROM
	Cotacao C (NOLOCK)
GO

CREATE VIEW vwCategoryTree AS
SELECT
	IDCategory,
	IDSubCategory,
	IDGroup,
	Name,
	FullName,
	IDType,
	IDFinal,
	Desativado,
	Hidden
FROM
(
	SELECT
		IDGroup AS IDCategory,
		NULL AS IDSubCategory,
		NULL AS IDGroup,
		Name,
		Name as FullName,
		1 AS IDType,
		IDGroup AS IDFinal,
		Desativado,
		Hidden
	FROM
		TabGroup (NOLOCK)
	
	UNION ALL
	
	SELECT
		IDGroup AS IDCategory,
		IDModelGroup AS IDSubCategory,
		NULL AS IDGroup,
		ModelGroup AS Name,
		FullModelGroup AS FullName,
		2 AS IDType,
		IDModelGroup AS IDFinal,
		Desativado,
		Hidden

	FROM
		vwmodelgroup (NOLOCK)
	
	UNION ALL
	
	SELECT
		IDGroup AS IDCategory,
		IDModelGroup AS IDSubCategory,
		IDModelSubGroup AS IDGroup,
		ModelSubGroup AS Name,
		FullModelSubGroup AS FullName,
		3 AS IDType,
		IDModelSubGroup AS IDFinal,
		Desativado,
		Hidden
	FROM
		vwmodelsubgroup (NOLOCK)
) A

GO

CREATE VIEW vwCotacaoToFornec AS

SELECT
	CF.IDCotacao,
	P.IDPessoa,
	P.Pessoa,
	P.Contato,
	P.Telefone,
	P.Fax,
	P.Email
FROM
	Pessoa P (NOLOCK),
	CotacaoToFornec CF (NOLOCK)
WHERE
	P.IDPessoa = CF.IDFornecedor

GO



CREATE VIEW vwInventoryModel (IDModel, Model, Description, TotQtyOnHand)  AS

SELECT
	Model.IDModel,
	Model.Model,
	Model.Description,
	SUM(QtyOnHand)
FROM
	Model (NOLOCK),
	Inventory (NOLOCK)
WHERE
	Inventory.ModelID = Model.IDModel 
	AND Model.Desativado = 0
GROUP BY
	IDModel, 
	Model, 
	Description

GO


CREATE VIEW vwModelInventory (IDModel, Model, Description, SellingPrice, AverageCost, TotQty, IDCategory, Category, LastCost)  AS

SELECT
	Model.IDModel,
	Model.Model,
	Model.Description,
	Model.SellingPrice,
	(VendorCost + OtherCost + FreightCost),
	SUM(QtyOnHand),
	GroupID,
	TabGroup.Name,
	Model.LastCost
FROM
	Model (NOLOCK),
	Inventory (NOLOCK),
	TabGroup (NOLOCK)
WHERE
	Model.IDModel *= Inventory.ModelID
	AND Model.GroupID = TabGroup.IDGroup
GROUP BY
	IDModel, 
	Model, 
	Description, 
	Model.SellingPrice, 
	VendorCost, 
	OtherCost, 
	FreightCost, 
	GroupID, 
	Name, 
	LastCost

GO


CREATE VIEW vw_Rep_InvTotal (Category, CountModel, QtyOnHand, QtyOnOrder, QtyOnHandOrder, SumLastCost, SumAvgCost)  AS

SELECT
	TG.Name,
	COUNT(IDModel),
	SUM(CASE WHEN IsNull(I.QtyOnHand, 0) > 0 THEN I.QtyOnHand ELSE 0 END),
	SUM(IsNull(I.QtyOnOrder, 0)),
	SUM(CASE WHEN IsNull(I.QtyOnHand, 0) > 0 THEN IsNull(I.QtyOnOrder, 0) + I.QtyOnHand ELSE IsNull(I.QtyOnOrder, 0) + 0 END),
	SUM(CASE WHEN IsNull(I.QtyOnHand, 0) > 0 THEN LastCost * I.QtyOnHand ELSE 0 END),
	SUM(CASE WHEN IsNull(I.QtyOnHand, 0) > 0 THEN (VendorCost + FreightCost + OtherCost) * I.QtyOnHand ELSE 0 END)
FROM
	Model M (NOLOCK),
	Inventory I (NOLOCK),
	TabGroup TG (NOLOCK)
WHERE
	(M.IDModel = I.ModelID)
	AND (M.GroupID = TG.IDGroup)
	AND (M.Desativado = 0)
GROUP BY
	TG.Name,
	StoreID

GO

CREATE VIEW vw_Rep_InveItemStock (DateLastCost, Category, Model, Description, SellingPrice, LastCost, QtyOnHand, Manufacturer, Days, IDStore)  AS

SELECT
	M.DateLastCost,
	TG.Name,
	M.Model,
	M.Description,
	M.SellingPrice,
	M.LastCost,
	SUM(ISNULL(I.QtyOnHand, 0)),
	ISNULL(F.Manufacturer, 'Not Defined'),
	DATEDIFF(day, M.DateLastCost, GETDATE()),
	F.IDStore
FROM
	Model M (NOLOCK),
	Inventory I (NOLOCK),
	TabGroup TG (NOLOCK),
	vwFabricante F (NOLOCK)
WHERE
	M.IDModel = I.ModelID
	AND M.GroupID = TG.IDGroup
	AND M.IDFabricante = F.IDFabricante
	AND M.Desativado = 0
GROUP BY
	M.DateLastCost, 
	TG.Name, 
	M.Model, 
	M.Description, 
	M.SellingPrice, 
	M.LastCost, 
	F.Manufacturer, 
	F.IDStore
GO

CREATE VIEW vw_Rep_QuotationToVendor (IDQuotation, IDVendor)  AS

SELECT
	C.IDCotacao,
	C.IDFornecedor
FROM
	CotacaoToFornec C (NOLOCK)

GO


CREATE VIEW vwBarcode AS
SELECT
	B.IDBarcode, 
	B.Data as BarcodeDate,
	M.Model, 
	M.Description, 
	M.SellingPrice, 
	F.Pessoa as Manufacture,
	U.Unidade,
	U.Sigla,
	INVS.CodSize,
	INVS.SizeName,
	INVC.CodColor,
	INVC.Color
FROM
	Barcode B (NOLOCK)
	JOIN Model M (NOLOCK) ON (M.IDModel = B.IDModel)
	LEFT JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = M.IDFabricante)
	LEFT JOIN Unidade U (NOLOCK) ON (M.IDUnidade = U.IDUnidade)
	LEFT JOIN InvSize INVS (NOLOCK) ON (INVS.IDSize = M.IDSize)
	LEFT JOIN InvColor INVC (NOLOCK) ON (INVC.IDColor = M.IDColor)
WHERE
	M.Desativado = 0
	AND M.Hidden = 0

GO


CREATE VIEW vwCashRegisterMov (CashRegMovID, Tax)  AS

SELECT I.CashRegMovID, SUM(I.Tax)
FROM Invoice I (NOLOCK)
WHERE IDInvoice IS NOT NULL
GROUP BY I.CashRegMovID


GO


CREATE VIEW vwCotacaoModelQty AS

SELECT
	CTM.IDCotacao,
	CTM.IDModel,
	CTM.Model,
	CTM.Description,
	CTM.QtyCotada
FROM
	vwCotacaoToModel CTM (NOLOCK)
WHERE
	EXISTS	(
		SELECT
			IDCotacao
		FROM
			CotacaoResult CR
		WHERE
			CR.IDCotacao = CTM.IDCotacao
			AND CR.IDModel = CTM.IDModel
			AND Cost Is Not Null
		)

GO


CREATE VIEW vwCotacaoResult AS

SELECT
	M.IDModel,
	CR.IDCotacao,
	CR.Cost,
	M.Model,
	M.Description
FROM
	CotacaoResult CR (NOLOCK),
	Model M (NOLOCK)
WHERE
	CR.IDModel = M.IDModel

GO


CREATE VIEW vwCotationPOItem AS

SELECT
	CR.IDCotacao,
	CR.IDModel,
	M.Model,
	 M.Description,
	CR.Cost,
	CR.Qty
FROM
	CotacaoResult CR (NOLOCK),
	Model M (NOLOCK)
WHERE
	CR.IDModel = M.IDModel
	AND CR.PO = 1

GO


CREATE VIEW vwGroupSales AS
SELECT 
	TG.IDTouristGroup, 
	TG.NumTourist, 
	TG.IDAgency, 
	TG.EnterDate, 
	SUM(I.SubTotal - I.ItemDiscount + IsNull(I.AditionalExpenses,0)) as Sales, 
	COUNT (I.IDInvoice) as Invoices
FROM 
	TouristGroup TG (NOLOCK),
	Invoice I (NOLOCK)
WHERE 
	TG.IDTouristGroup = I.IDTouristGroup
	AND I.Canceled = 0
GROUP BY 
	TG.IDTouristGroup,
	TG.NumTourist,
	TG.IDAgency,
	TG.EnterDate

GO


CREATE VIEW vwGroupSalesGuide  AS

SELECT 
	TG.IDTouristGroup, 
	TG.NumTourist, 
	TG.IDGuide, 
	TG.EnterDate, 
	SUM(I.SubTotal - I.ItemDiscount + IsNull(I.AditionalExpenses,0))  as Sales, 
	COUNT (I.IDInvoice) as Invoices
FROM 
	TouristGroup TG (NOLOCK),
	Invoice I (NOLOCK)
WHERE 
	TG.IDTouristGroup = I.IDTouristGroup
	AND I.Canceled = 0
GROUP BY 
	TG.IDTouristGroup,
	TG.NumTourist,
	TG.IDGuide,
	TG.EnterDate

GO


CREATE VIEW vwHourResult (DiaSemana, Hora, Total)  AS

SELECT
	DatePart(WeekDay, I.InvoiceDate),
	DatePart(Hour, InvoiceDate),
	SUM(SubTotal)
FROM
	Invoice I (NOLOCK)
WHERE
	IDInvoice IS not Null
GROUP BY
	DatePart(WeekDay, I.InvoiceDate),
	DatePart(Hour, InvoiceDate)

GO


CREATE VIEW vwInvoiceParents AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório
 
	LOG DE MODIFICAÇÕES
 
	Data			Programador			Modificação
	-----------------------	-------------------------------	--------------------------------------------------------------------------
	17 Apr	2007		Maximiiano Muniz		Novo campo InvoiceDiscount;
	---------------------------------------------------------------------------------------------------------------------------------- */

SELECT
	ISNULL(IP.IDPreSale, I.IDPreSale) AS InvoicePreSale,
	I.IDPreSale DocumentID,
	CASE WHEN I.IDInvoice IS NULL THEN 0 ELSE 1 END AS IsInvoice,
	I.PreSaleDate,
	I.IDInvoice,
	I.SaleCode,
	I.InvoiceCode,
	I.FirstName,
	I.LastName,
	I.InvoiceDate,
	I.MediaID,
	I.CashRegMovID, 
	I.SpecialPriceID,
	I.IDMeioPag,
	I.IDTouristGroup,
	I.DeliverTypeID,
	I.IDCustomer,
	I.IDStore,
	I.OtherComissionID,
	I.IDLancPagOtherCom,
	I.DeliverDate,
	I.DeliverAddress,
	I.Passport, 
	I.PassportDate,
	I.Ticket,
	I.AirLine,
	I.CompanyName,
	I.CompanyCGC,
	I.DepositDate,
	I.Tax,
	I.SubTotal,
	I.Note,
	I.ItemDiscount,
	I.InvoiceDiscount,
	I.TaxIsent,
	I.EstimatedPay,
	I.CardNumber,
	I.OtherExpences,
	I.Address,
	I.TaxIsemptValue,
	I.TaxIsemptItemDiscount,
	I.Layaway,
	I.ZIP,
	I.PrintNotes,
	I.DeliverOBS,
	I.DeliverConfirmation,
	I.IDFormOfPayment, 
	I.AditionalExpenses,
	I.Canceled
FROM 
	Invoice I (NOLOCK)
	LEFT JOIN Invoice IP (NOLOCK) ON (I.IDPreSaleParent = IP.IDPreSale)
WHERE
	IP.IDPreSaleParent IS NULL

GO


CREATE VIEW vwMeioPagToStore AS

SELECT
	MPTS.IDStore,
	S.Name,
	MPTS.IDMeioPag,
	MPTS.IDContaCorrente
FROM
	Store S (NOLOCK),
	MeioPagToStore MPTS (NOLOCK)
WHERE
	MPTS.IDStore =  S.IDStore 
	AND S.Desativado =  0
	AND S.Hidden = 0

GO


CREATE VIEW vwPOItem (IDPOItem, InventMovTypeID, IDPO, IDStore, ModelID, MovDate, Qty, CostPrice, SalePrice, IDFornecedor, DateEstimatedMov, DateRealMov, QtyRealMov, SuggRetail)  AS

SELECT 
	PreInventoryMov.IDPreInventoryMov, 
	PreInventoryMov.InventMovTypeID, 
	PreInventoryMov.DocumentID, 
	PreInventoryMov.StoreID, 
	PreInventoryMov.ModelID, 
	PreInventoryMov.MovDate, 
	PreInventoryMov.Qty, 
	PreInventoryMov.CostPrice, 
	PreInventoryMov.SalePrice, 
	PreInventoryMov.IDPessoa, 
	PreInventoryMov.DateEstimatedMov, 
	PreInventoryMov.DateRealMov, 
	PreInventoryMov.QtyRealMov, 
	PreInventoryMov.SuggRetail
FROM
	PreInventoryMov (NOLOCK)
WHERE
	InventMovTypeID = 2
WITH CHECK OPTION

GO


CREATE VIEW vwStoreToTabGroup (IDTaxCategory, IDStore, IDGroup, Name, GroupName)  AS

SELECT
	STTG.IDTaxCategory,
	STTG.IDStore,
	STTG.IDGroup,
	S.Name,
	TG.Name
FROM
	StoreToTabGroup STTG (NOLOCK),
	Store S (NOLOCK),
	TabGroup TG (NOLOCK)
WHERE
	S.IDStore = STTG.IDStore
	AND TG.IDGroup = STTG.IDGroup
	AND S.Desativado = 0

GO


CREATE VIEW vw_PreInventoryMov_Grid AS

SELECT
	PIM.IDPreInventoryMov,
	PIM.Qty,
	IVC.Color,
	IVC.CodColor,
	IVS.SizeName,
	IVS.CodSize,
	PIM.IDPreInventoryMovParent,
	IVS.IDSize,
	IVC.IDColor
FROM
	PreInventoryMov PIM (NOLOCK),
	Model M (NOLOCK),
	InvSize IVS (NOLOCK),
	InvColor IVC (NOLOCK)
WHERE
	PIM.ModelID = M.IDModel
	AND M.IDSize *= IVS.IDSize
	AND M.IDColor *= IVC.IDColor
GO

CREATE VIEW vw_Rep_Barcode (Barcode, IDModel, Date)  AS

SELECT
	B.IDBarcode,
	B.IDModel,
	B.Data
FROM
	Barcode B (NOLOCK)

GO


CREATE VIEW vw_Rep_InventorySerial AS

SELECT
	I.Serial
FROM
	InventorySerial I (NOLOCK)
GO

CREATE VIEW dbo.vw_Rep_MarketingCustomerPurchaseHist
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


/*vw_Rep_MarketingCustomerPurchaseHist*/

SELECT
	PU.IDPurchase,
	PU.DatePreReceiving,
	PU.DateFinalReceiving,
	PU.Freight,
	PU.OtherCharges,
	PU.DocumentType,
	PU.DocumentNumber,
	PU.DocumentDate,
	PU.DocumentDueDate,
	PU.DocumentTotal,
	PU.IDFornecedor as IDVendor,
	PU.IDStore as IDStore,
	(PT.SubTotal + PU.OtherCharges + PU.Freight )  as Total,
	PT.SubTotal,
	V.FullName as Vendor,
	V.Address as VendorAddress,
	V.City as VendorCity,
	V.Zip as VendorZip,
	V.Phone as VendorPhone,
	V.Fax as VendorFax,
	V.Contact as VendorContact,
	V.Email as VendorEmail,
	V.HomePage as VendorHomePage,
	S.Store,
	S.Telephone as StorePhone,
	S.Fax as StoreFax,
	S.Contact as StoreContact,
	SUP.SystemUser as ReceivedBy,
	SUF.SystemUser as FinalRecBy,
	PUI.Barcode,
	PUI.Qty,
	PUI.NewCostPrice,
	PUI.NewSalePrice,
	PUI.NewSuggRetail,
	(PUI.Qty * PUI.NewCostPrice) as ExtNewCostPrice,
	(PUI.Qty * PUI.NewSalePrice) as ExtNewSalePrice,
	(PUI.Qty * PUI.NewSuggRetail) as ExtNewSuggRetail,
	M.Model,
	M.Description,
	M.IDFabricante as IDManufacture,
	C.Category,
	MAN.FullName as Manufacture
FROM
	Pur_Purchase PU (NOLOCK)
	JOIN vw_Rep_Entity V (NOLOCK) ON (PU.IDFornecedor = V.IDPerson)
	JOIN vw_Rep_Store S (NOLOCK) ON (S.IDStore = PU.IDStore)
	LEFT OUTER JOIN vw_Rep_SystemUser SUP (NOLOCK) ON ( PU.IDUserPreReceiving = SUP.IDUser )
	LEFT OUTER JOIN vw_Rep_SystemUser SUF (NOLOCK) ON ( PU.IDUserFinalReceiving = SUF.IDUser )
	LEFT OUTER JOIN Pur_PurchaseTotal PT (NOLOCK) ON (PU.IDPurchase = PT.IDPurchase)
	JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
	JOIN vw_Rep_Model M (NOLOCK) ON (M.IDModel = PUI.IDModel)
	LEFT OUTER JOIN vw_Rep_Entity MAN (NOLOCK) ON (MAN.IDPerson = M.IDFabricante)
	JOIN vw_Rep_Category C (NOLOCK) ON (M.GroupID = C.IDCategory)

GO


CREATE VIEW vw_Rep_ModelTransfDet AS

SELECT
	M.IDModelTransfDet,
	M.IDModelTransf,
	M.IDModel,
	M.Qty
FROM
	ModelTransfDet M (NOLOCK)

GO


CREATE VIEW vw_Rep_PaymentTypeMinSale AS

SELECT
	M.IDMeioPag,
	M.DifDay,
	M.TotalSale
FROM
	MeioPagMinSale M (NOLOCK)

GO


CREATE VIEW vw_Rep_PaymentTypeToStore AS

SELECT
	M.IDStore,
	M.IDMeioPag,
	M.IDContaCorrente
FROM
	MeioPagToStore M (NOLOCK)

GO


CREATE  VIEW vw_Rep_PreInventoryMov  AS
SELECT
	P.IDPreInventoryMov,
	P.InventMovTypeID AS IDInventMovType,
	P.DocumentID AS IDDocument,
	P.StoreID AS IDStore,
	P.ModelID AS IDModel,
	P.IDPessoa AS IDPerson,
	P.UserID AS IDUser,
	P.IDCotacao,
	P.MovDate,
	P.Qty,
	P.CostPrice,
	P.SalePrice,
	P.Discount,
	P.DateEstimatedMov,
	P.DateRealMov,
 	P.QtyRealMov,
 	P.Marked,
	P.ExchangeInvoice,
 	P.SuggRetail
FROM
	PreInventoryMov P (NOLOCK)
GO

CREATE VIEW vw_Rep_QuotationResult (IDModel, IDQuotation, Cost, PO, Qty)  AS

SELECT
	C.IDModel,
	C.IDCotacao,
	C.Cost,
	C.PO,
	C.Qty
FROM
	CotacaoResult C (NOLOCK)
GO

CREATE VIEW vw_Rep_QuotationToModel (IDQuotation, IDModel, IDRequest, QtyQuoted)  AS

SELECT
	C.IDCotacao,
	C.IDModel,
	C.IDRequest,
	C.QtyCotada
FROM
	CotacaoToModel C (NOLOCK)

GO


CREATE VIEW vwCommission  AS
SELECT 
	IM.IDInventoryMov, 
	IM.InventMovTypeID, 
	IM.DocumentID, 
	IM.StoreID, 
	IM.Qty, 
	IM.CostPrice, 
	IM.SalePrice, 
	IM.Discount, 
	SIC.IDCommission AS ComissionID, 
	IM.MovDate, 
	M.IDModel, 
	M.GroupID, 
	M.Model, 
	M.Description, 
	TP.TipoPessoa, 
	TP.IDTipoPessoa, 
	GTCT.Comission, 
	TP.ComissionOnProfit, 
	M.SellingPrice, 
	M.SuggRetail, 
	Round(IM.CostPrice * IM.Qty, 2, 1) as MovCost, 
	(Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) as MovSale, 
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100) )) as MovCommission, 
	PreInventoryMovID as IDPreInventoryMov, 
	IM.DesiredMarkup
FROM 
	TipoPessoa TP (NOLOCK)
	JOIN GroupToComissionType GTCT (NOLOCK) ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Model M (NOLOCK) ON (M.GroupID = GTCT.GroupID)
	JOIN InventoryMov IM (NOLOCK) ON (IM.ModelID = M.IDModel)
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (IM.IDInventoryMov = SIC.IDInventoryMov)

GO

CREATE VIEW vwGroupCost (IDTouristGroup, TotCost)  AS

SELECT
	 GroupCost.IDTouristGroup,
	sum(GroupCost.Unitcost * GroupCost.Quantity)
FROM
	GroupCost (NOLOCK)
GROUP BY
	IDTouristGroup
GO

CREATE VIEW vwGroupCostByDate (Date, TotalCost)  AS

SELECT
	Convert(DateTime, Convert(Char(20), CostDate, 101)),
	SUM(UnitCost * Convert(Money, Quantity))
FROM
	GroupCost GC (NOLOCK)
WHERE
	GC.IDCostType NOT IN (3,4)
GROUP BY
	Convert(DateTime, Convert(Char(20), CostDate, 101))

GO


CREATE VIEW vwGroupOtherCost (IDTouristGroup, TotCost)  AS

SELECT
	GroupCost.IDTouristGroup,
	sum(GroupCost.Unitcost * GroupCost.Quantity)
FROM
	GroupCost (NOLOCK)
WHERE
	NOT (IDCostType IN (3, 4))
GROUP BY
	IDTouristGroup

GO


CREATE VIEW vwInvoiceByModel (ModelQty, ModelValue, DocumentID)  AS

SELECT
	SUM(IsNull(IM.Qty, 0)),
	SUM(( IsNull(IM.Qty, 0)*IsNull(IM.SalePrice, 0) ) - IsNull(IM.Discount, 0) ),
	IM.DocumentID
FROM
	InventoryMov IM (NOLOCK)
WHERE
	IM.InventMovTypeID = 1
GROUP BY
	IM.DocumentID, 
	IM.StoreID, 
	IM.ModelID

GO


CREATE VIEW vwInvoiceComission AS

SELECT 
	Invoice.IDInvoice,
	TouristGroup.IDTouristGroup,
	SUM( InvMov.CostPrice * InvMov.Qty) AS Cost,
	SUM(( InvMov.SalePrice * InvMov.Qty) - InvMov.Discount) AS Sales,
	SUM((( (IsNull(InvMov.SalePrice, 0) - (TipoCom.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))) * InvMov.Qty) - InvMov.Discount) * ( Comission / ((100 / SIC.CommissionPercent) * 100) )) AS ComisGuide, 
	SUM(((( (IsNull(InvMov.SalePrice, 0) - (TipoCom.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))) * InvMov.Qty) - InvMov.Discount) * ( Comission / ((100 / SIC.CommissionPercent) * 100) )) * (TouristGroup.ComissaoSobreGuia / 100 )) AS ComisAgency
FROM 
	Invoice (NOLOCK)
	JOIN TouristGroup (NOLOCK) ON ( Invoice.IDTouristGroup = TouristGroup.IDTouristGroup )
	JOIN InventoryMov InvMov (NOLOCK) ON ( InvMov.DocumentID = Invoice.IDInvoice )
	JOIN vwComissionado Comi (NOLOCK) ON ( Comi.IDComissionado = TouristGroup.IDGuide )
	JOIN GroupToComissionType GTC (NOLOCK) ON ( Comi.IDTipoComissionado = GTC.IDTipoComissionado ) 
	JOIN Model (NOLOCK) ON ( GTC.GroupID = Model.GroupID ) 
	JOIN vwTipoComissionado TipoCom (NOLOCK) ON ( TipoCom.IDTipoComissionado = Comi.IDTipoComissionado )
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (InvMov.IDInventoryMov = SIC.IDInventoryMov)
WHERE  
	Invoice.IDInvoice IS NOT NULL
     	AND InvMov.InventMovTypeID = 1
     	AND InvMov.ModelID = Model.IDModel
GROUP BY
	Invoice.IDInvoice, 
	TouristGroup.IDTouristGroup

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
	PreInventoryMov PIM (NOLOCK)
	JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel )
	JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
	LEFT JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDSaleTax )
WHERE 
	PIM.InventMovTypeID IN (1,25)
	AND PIM.IDParentPack Is Null

UNION ALL

SELECT 
	TX.TaxCategory,
	TX.OperationType,
	TX.SaleTaxType,
	IM.IDInventoryMov as IDMov, 
	IMX.Tax,
	1 as IsInvoice
FROM 
	InventoryMov IM (NOLOCK)
	JOIN InventoryMovTax IMX (NOLOCK) ON (IM.IDInventoryMov = IMX.IDInventoryMov)
	JOIN TaxCategory TX (NOLOCK) ON (TX.IDTaxCategory = IMX.IDTaxCategory)
WHERE 
	IM.InventMovTypeID IN (1,25)
	AND IM.IDParentPack Is Null

GO


CREATE VIEW vwInvoiceResult (IDInvoice, Sale, Cost)  AS

SELECT
	IM.DocumentID,
	SUM ((IM.SalePrice * IM.Qty )  - IM.Discount ),
	SUM ( IM.CostPrice * IM.Qty )
FROM
	InventoryMov IM (NOLOCK)
WHERE
	IM.InventMovTypeID = 1
GROUP BY
	IM.DocumentID

GO


CREATE VIEW vwModelHistoryMov AS

SELECT
	IMT.Name,
	IM.DocumentID,
	IM.MovDate,
	ISNull((Qty * (IMT.UpdateOnHand * 2 - 1)),0) as Qty,
	CASE Qty
		WHEN 0 THEN SalePrice
		ELSE (SalePrice - (Discount / Qty))
	END as SalePrice,
	IM.IDInventoryMov,
	IMT.System,
	IM.CostPrice,
	IM.AvgCost,
	IM.Freight,
	IM.OtherCost,
	SU.SystemUser,
	IM.ModelID,
	IM.StoreID,
	S.Name as Store
FROM
	InventoryMov IM (NOLOCK)
	JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
	LEFT JOIN SystemUser SU (NOLOCK) ON (IM.IDUser = SU.IDUser)
	JOIN Store S (NOLOCK) ON (IM.StoreID = S.IDStore)

GO


CREATE VIEW vwPurchaseFornec (IDPurchase, Fornecedor, IDFornecedor, MovDate, Qty, CostPrice, Freight, OtherCost)  AS

SELECT
	InventoryMov.DocumentID, 
	vwFornecedor.Fornecedor, 
	InventoryMov.IDPessoa, 
	InventoryMov.MovDate, 
	InventoryMov.Qty, 
	InventoryMov.CostPrice, 
	InventoryMov.Freight, 
	InventoryMov.OtherCost
FROM
	InventoryMov (NOLOCK),
	vwFornecedor (NOLOCK)
WHERE
	InventMovTypeID = 2
	AND vwFornecedor.IDFornecedor = InventoryMov.IDPessoa

GO


CREATE VIEW vwPurchaseItem (IDPurchase, IDStore, ModelID, BarCodeID, IDFornecedor, MovDate, Qty, CostPrice, Freight, OtherCost)  AS

SELECT
	 InventoryMov.DocumentID, 
	InventoryMov.StoreID, 
	InventoryMov.ModelID, 
	InventoryMov.BarCodeID, 
	InventoryMov.IDPessoa, 
	InventoryMov.MovDate, 
	InventoryMov.Qty, 
	InventoryMov.CostPrice, 
	InventoryMov.Freight, 
	InventoryMov.OtherCost
FROM
	InventoryMov (NOLOCK)
WHERE
	InventMovTypeID = 2

GO


CREATE VIEW vwPurchaseModel (IDFornecedor)  AS

SELECT
	InventoryMov.IDPessoa
FROM
	InventoryMov InventoryMov (NOLOCK)
WHERE
	 InventMovTypeID = 2
GROUP BY
	IDPessoa,
	ModelID

GO


CREATE VIEW vwPurchase_InvMovModel (DocumentID, TotQty, TotValue, AvgCost)  AS

SELECT
	InventoryMov.DocumentID,
	SUM(Qty),
	SUM(CostPrice*Qty),
	AVG(CostPrice)
FROM
	InventoryMov (NOLOCK)
WHERE
	InventoryMov.InventMovTypeID = 2
GROUP BY
	DocumentID, 
	ModelID

GO


CREATE VIEW vwSaleItem AS
SELECT
	1 as Invoice,
	IM.IDInventoryMov,
	IM.InventMovTypeID,
	IM.DocumentID,
	IM.StoreID,
	IM.Qty,
	IM.CostPrice,
	IM.SalePrice,
	IM.Discount,
	SIC.IDCommission AS ComissionID,
	IM.MovDate,
	IM.ModelID,
	M.GroupID,
	M.Model,
	M.Description,
	TP.IDTipoPessoa,
	GTCT.Comission,
	TP.ComissionOnProfit,
	NULL AS IDCotacao,
	NULL AS IDPreInventoryMovParent,
	NULL AS DateEstimatedMov,
	NULL AS DateRealMov,
	NULL AS QtyRealMov,
	NULL AS Marked,
	NULL AS SuggRetail,
	IM.IDRepair,
	IM.IDPessoa,
	IM.IDAgrupaPag,
	IM.IDTemp,
	IM.IDLancPagCom,
	IM.IDUser,
	IM.BarCodeID,
	IM.PreInventoryMovID AS IDPreInventoryMov,
	IM.Freight,
	IM.OtherCost,
	IM.ExchangeInvoice,
	IM.QtyExchanged,
	IM.SalesTax,
	NULL AS Notes,
	IM.IDParentPack,
	IM.IDModelService,
	IM.IDPreInvMovExchange,
	IM.AvgCost,
	Round(IM.CostPrice * IM.Qty, 2, 1) as ItemCostTotal,
	(Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) as ItemSaleTotal,
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	IM.DesiredMarkup,
	I.IDPreSale,
	I.PreSaleDate,
	SX.Tax,
	((Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) * SX.Tax) as TaxValue,
	((Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) - (IM.CostPrice * IM.Qty) - ((Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) * SX.Tax)) as ItemNetValue
FROM
	InventoryMov IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I ON (IM.DocumentID = I.IDInvoice AND IM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX ON (IM.IDInventoryMov = SX.IDMov AND SX.IsInvoice = 1) 
	LEFT JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = IM.IDInventoryMov)

UNION ALL
 
SELECT
	0 as Invoice,
	PIM.IDPreInventoryMov,
	PIM.InventMovTypeID,
	PIM.DocumentID,
	PIM.StoreID,
	PIM.Qty,
	PIM.CostPrice,
	PIM.SalePrice,
	PIM.Discount,
	SIC.IDCommission AS ComissionID,
	PIM.MovDate,
	M.IDModel,
	M.GroupID,
	M.Model,
	M.Description,
	TP.IDTipoPessoa,
	GTCT.Comission,
	TP.ComissionOnProfit,
	PIM.IDCotacao,
	PIM.IDPreInventoryMovParent,
	PIM.DateEstimatedMov,
	PIM.DateRealMov,
	PIM.QtyRealMov,
	PIM.Marked,
	PIM.SuggRetail,
	NULL AS IDRepair,
	PIM.IDPessoa,
	NULL AS IDAgrupaPag,
	NULL AS IDTemp,
	NULL AS IDLancPagCom,
	PIM.UserID AS IDUser,
	PIM.BarCodeID,
	PIM.IDPreInventoryMov,
	NULL AS Freight,
	NULL AS OtherCost,
	PIM.ExchangeInvoice,
	PIM.QtyExchanged,
	NULL AS SalesTax,
	NULL AS Notes,
	PIM.IDParentPack,
	PIM.IDModelService,
	PIM.IDPreInvMovExchange,
	NULL AS AvgCost,
	Round(PIM.CostPrice * PIM.Qty, 2, 1) as ItemCostTotal,
	(Round(PIM.SalePrice * PIM.Qty, 2, 1) - PIM.Discount) as ItemSaleTotal,
	((((PIM.SalePrice - (PIM.CostPrice * TP.ComissionOnProfit)) * PIM.Qty - PIM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	PIM.DesiredMarkup,
	I.IDPreSale,
	I.PreSaleDate,
	SX.Tax,
	((Round(PIM.SalePrice * PIM.Qty, 2, 1) - PIM.Discount) * SX.Tax) as TaxValue,
	((Round(PIM.SalePrice * PIM.Qty, 2, 1) - PIM.Discount) - Round(PIM.CostPrice * PIM.Qty, 2, 1) - (Round(PIM.SalePrice * PIM.Qty, 2, 1) - PIM.Discount) * SX.Tax) as ItemNetValue
FROM
	PreInventoryMov PIM (NOLOCK)
	JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT (NOLOCK) ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP (NOLOCK) ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I (NOLOCK) ON (PIM.DocumentID = I.IDPreSale AND PIM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX (NOLOCK) ON (PIM.IDPreInventoryMov = SX.IDMov AND SX.IsInvoice = 0) 
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)
GO

CREATE VIEW vwSplit_ListItems AS
SELECT
	PIM.IDPreInventoryMov,
	PIM.DocumentID, 
	PIM.Marked,
	M.Model,
	M.Description,
	C.Comissionado AS SalesPerson,
	PIM.MovDate,
	PIM.Discount,
	(PIM.Qty - IsNull(PIM.QtyExchanged,0)) as Qty, 
	(PIM.SalePrice - PIM.Discount) * PIM.Qty AS Total, 
	PIM.QtyRealMov,
	M.IDModel,
	IsNull(M.NotVerifyQty,0) as NotVerifyQty
FROM         
	PreInventoryMov PIM (NOLOCK)
	INNER JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov )
	INNER JOIN vwComissionado C (NOLOCK) ON (SIC.IDCommission = C.IDComissionado)
WHERE   
	(PIM.InventMovTypeID IN (1,25) --Sale and Canceled
	AND PIM.IDParentPack Is Null)

GO

CREATE VIEW vwTotInvMovContado (TotQty)  AS

SELECT
	SUM(IsNull(InventoryMov.Qty, 0) * ((2 * InventoryMovType.Entrando) - 1))
FROM
	InventoryMov (NOLOCK),
	Inventory (NOLOCK),
	InventoryMovType (NOLOCK)
WHERE
	InventoryMov.ModelID =  Inventory.ModelID 
	AND InventoryMov.StoreID =  Inventory.StoreID 
	AND InventoryMov.InventMovTypeID =  InventoryMovType.IDInventMovType 
	AND InventoryMov.MovDate >=  Inventory.DataContagem 
	AND Inventory.DataContagem IS NOT NULL 
	AND Inventory.QtyContada <>  Inventory.QtyOnHand
GROUP BY
	InventoryMov.StoreID, 
	InventoryMov.ModelID

GO

CREATE VIEW dbo.vw_Fin_LancamentoActiveTerm
AS

SELECT 
	LT.IDLancamento, 
	LT.Discount, 
	LT.DueDateShift
FROM 
	(SELECT
		L.IDLancamento,
		MAX(LT.DueDateShift) AS MaxShift
      	FROM
		Fin_Lancamento L (NOLOCK)
		INNER JOIN Fin_LancamentoTerm LT (NOLOCK) ON L.IDLancamento = LT.IDLancamento
      	WHERE
		(DATEADD(day, - 1 * LT.DueDateShift, L.DataVencimento) > GETDATE())
	GROUP BY
		L.IDLancamento
	) MD
	INNER JOIN Fin_LancamentoTerm LT (NOLOCK) ON MD.IDLancamento = LT.IDLancamento AND MD.MaxShift = LT.DueDateShift

GO

CREATE VIEW vw_Rep_Acc_DisbursementType (IDDisbursementsType, IDDocumentType, DisbursementType, DisbursementTypeCode, DisbursementIdent, Hidden, System, Deleted)  AS

SELECT
	DT.IDDesdobramentoTipo,
	DT.IDDocumentoTipo,
	DT.DesdobramentoTipo,
	DT.CodigoDesdobramentoTipo,
	DT.IdentificadorDesdobramento,
	DT.Hidden,
	DT.System,
	DT.Desativado
FROM
	Fin_DesdobramentoTipo DT (NOLOCK)

GO

CREATE VIEW vw_Rep_Acc_DocumentType (IDDocumentType, DocumentTypeCode, DocumentType, HasDisbursement, HasIssueDate, DocumentIdent, HasDocumentNumber, ObligateDisbursement, IDDisbursementDefault, Hidden, Deleted, System)  AS

SELECT
	DT.IDDocumentoTipo,
	DT.CodigoDocumentoTipo,
	DT.DocumentoTipo,
	DT.PossuiDesdobramento,
	DT.DataEmissaoObrigatoria,
	DT.IdentificadorDocumento,
	DT.NumDocumentoObrigatorio,
	DT.DesdobramentoObrigatorio,
	DT.IDDesdobramentoTipoDefault,
	DT.Hidden,
	DT.Desativado,
	DT.System
FROM
	Fin_DocumentoTipo DT (NOLOCK)

GO

CREATE VIEW vw_Rep_Acc_RecordPC AS

SELECT
	Fin_LancamentoTipo.CodigoContabil AS AccountCode,
	REPLICATE(' ', LEN(Fin_LancamentoTipo.CodigoContabil) - 1) + Fin_LancamentoTipo.CodigoContabil AS TreeCode,
	Fin_LancamentoTipo.LancamentoTipo as RecordType,
	REPLICATE(' ', LEN(Fin_LancamentoTipo.CodigoContabil) - 1) + Fin_LancamentoTipo.LancamentoTipo AS TreePath,
	LancPC.DataVencimento as DueDate,
	LancPC.DataLancamento as RecordDate,
	SUM(ISNULL(LancPC.ValorNominal, 0)) AS Amount
FROM
	Fin_LancamentoTipo (NOLOCK)
	INNER JOIN	(
			SELECT				
				F.DataVencimento,
				F.DataLancamento,
				FT.CodigoContabil,
				F.ValorNominal
			FROM
				Fin_Lancamento F (NOLOCK)
				INNER JOIN Fin_LancamentoTipo FT (NOLOCK) ON (F.IDLancamentoTipo = FT.IDLancamentoTipo)
			) AS LancPC ON (LancPC.CodigoContabil LIKE Fin_LancamentoTipo.CodigoContabil + '%')
GROUP BY
	Fin_LancamentoTipo.CodigoContabil,
	Fin_LancamentoTipo.LancamentoTipo,
	LancPC.DataVencimento,
	LancPC.DataLancamento

GO

CREATE VIEW vw_Rep_Acc_RecordPaid (IDPayment, IDRecord, IDUser, Amount, PaymentDate, Interest)  AS

SELECT
	LQ.IDQuitacao,
	LQ.IDLancamento,
	LQ.IDUsuarioQuitacao,
	LQ.ValorQuitado,
	LQ.DataQuitacao,
	LQ.ValorJuros
FROM
	Fin_LancQuit LQ (NOLOCK)

GO

CREATE VIEW vw_Rep_Acc_Records AS

SELECT
	L.IDLancamento 		as IDRecord,
	L.IDQuitacaoMeioPrevisto 	as IDPaymentTypePrediction,
	L.Previsao 			as Prediction,
	L.IDPreSale 			as IDPreSale,
	L.IDPessoaTipo 			as IDPersonType,
	L.IDBancoAgenciaQuitPrev 	as IDPaymentBankAccountPrediction,
	L.IDEmpresa 			as IDCompany,
	L.IDPessoa 			as IDPerson,
	L.IDBancoQuitPrev 		as IDPaymentBankPrediction,
	L.IDDesdobramentoTipo 		as IDDisbursementType,
	L.IDMoedaCotacao 		as IDCurrencyQuoted,
	L.IDMoeda 			as IDCurrency,
	L.IDUsuarioLancamento 		as IDUserRecord,
	L.DataAprovacao 		as ApprovalDate,
	L.IDCentroCusto 		as IDCostCenter,
	L.Situacao 			as Situation,
	L.DataLancamento 		as RecordDate,
	L.IDLancamentoTipo 		as IDRecordType,
	L.DataVencimento 		as DueDate,
	L.DataVencimentoOriginal 	as OriginalDueDate,
	L.DataInicioQuitacao 		as FirstPaymentDate,
	L.DataFimQuitacao 		as LastPaymentDate,
	L.ValorNominal 			as Amount,
	L.TotalQuitado 			as Paid,
	L.IDDocumentoTipo 		as IDDocumentType,
	L.NumDocumento 		as DocumentNumber,
	L.NumDesdobramento 		as DesbursementNumber,
	L.NumMeioQuitPrevisto 		as PaymentTypeNumberPrediction,
	L.IDContaCorrentePrevista 	as IDBankAccountPrediction,
	L.IDUsuarioAprovacao 		as IDUserApproved,
	L.IDUsuarioProtesto 		as IDUserCancelled,
	L.NumeroDuplicata 		as DuplicateNumber,
	L.MoedaSigla 			as CurrentSymbol,
	L.IDLancamentoOriginal 		as IDOriginalRecord,
	L.DataEmissao 			as IssueDate,
	L.Historico 			as History,
	L.IDCashRegMov 		as IDCashRegMov,
	L.Hidden,
	L.System,
	L.Desativado 			as Deleted,
	L.Pagando 			as Paying,
	L.NumeroRepeticoes 		as Frequency,
	L.IDPurchase,
	L.LancamentoType 		as RecordType,
	L.IDLancamentoParent 		as IDRecordParent,
	L.CheckNumber,
	L.CustomerDocument,
	L.CustomerName,
	L.CustomerPhone,
	L.IDBankCheck,
	L.PaymentPlace,
	L.IDCashRegMovClosed,
	L.IsPreDatado
FROM
	Fin_Lancamento L (NOLOCK)

GO

CREATE VIEW vw_Rep_Acc_RecordsTerms (IDRecord, DueDateShift, Discount)  AS

SELECT
	LT.IDLancamento,
	LT.DueDateShift,
	LT.Discount
FROM
	Fin_LancamentoTerm LT (NOLOCK)

GO

CREATE VIEW vw_Rep_BestSeller (IDCategory, IDVendor, MovDate, Path, IDModel, Model, Description, Profit, CostPrice, Qty, SalePrice, Discount, QtySold, TotQtyOnHand)  AS

SELECT
	M.GroupID,
	M.IDFabricante,
	IM.MovDate,
	TG.Path,
	M.IDModel,
	M.Model,
	M.Description,
	SUM((IM.SalePrice - IM.CostPrice) * IM.Qty - IM.Discount),
	IM.CostPrice,
	IM.Qty,
	IM.SalePrice,
	IM.Discount,
	SUM(IM.Qty),
	M.TotQtyOnHand
FROM
	InventoryMov IM (NOLOCK),
	Model M (NOLOCK),
	TabGroup TG (NOLOCK)
WHERE
	(IM.ModelID = M.IDModel)
	AND (M.GroupID = TG.IDGroup)
	AND (InventMovTypeID = 1)
GROUP BY
	M.GroupID,
	IM.StoreID,
	M.IDFabricante,
	M.TotQtyOnHand,
	IM.MovDate,
	TG.Path, 
	M.IDModel, 
	M.Model, 
	M.Description, 
	M.TotQtyOnHand, 
	IM.CostPrice, 
	IM.Qty, 
	IM.SalePrice, 
	IM.CostPrice, 
	IM.Discount

GO

CREATE VIEW vw_Rep_ClientRepair (IDRepair, IDModel, IDStore, IDInvMovSend, IDClient, Status, IDVendor, IDUserReceive, ReceiveDate, SentDate, OBSReceive, RepairType, IDUserSent, Qty, UPS, RA, DateLastCost, SerialNumber, LastCost, Defect, IDUserReturn, ReturnDate, OBSReturn, IDUserBack, BackDate, IDInvMovReturn, OBSBack)  AS

SELECT
	R.IDRepair,
	R.IDModel,
	R.IDStore,
	R.IDInvMovSend,
	R.IDCliente,
	R.Fase,
	R.IDFornecedor,
	R.IDUserReceive,
	R.ReceiveDate,
	R.SentDate,
	R.OBSReceive,
	R.TipoRepair,
	R.IDUserSent,
	R.Qty,
	R.UPS,
	R.RA,
	R.DateLastCost,
	R.SerialNumber,
	R.LastCost,
	R.Defect,
	R.IDUserReturn,
	R.ReturnDate,
	R.OBSReturn,
	R.IDUserBack,
	R.BackDate,
	R.IDInvMovReturn,
	R.OBSBack
FROM
	Repair R (NOLOCK)
WHERE
	R.Tipo = 1

GO

CREATE VIEW vw_Rep_CommissionBonus (SalesPerson, TotalDiscount, MovDate, IDPessoa)  AS

SELECT
	P.Pessoa,
	SUM(IM.Discount),
	IM.MovDate,
	P.IDPessoa
FROM
	InventoryMov IM (NOLOCK),
	SaleItemCommission SIC (NOLOCK),
	Pessoa P (NOLOCK)
WHERE
	IM.IDInventoryMov = SIC.IDInventoryMov
	AND SIC.IDCommission = P.IDPessoa
	AND (IM.Discount < 0)
	AND (P.IDTipoPessoa = 4) 
	AND (IM.InventMovTypeID = 1)
GROUP BY
	P.Pessoa,
	IM.MovDate,
	P.IDPessoa

GO

CREATE VIEW dbo.vw_Rep_CommissionDetails AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para ser utilizada no relatório Agency & Agent Invoices by Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
	05 Dec 2005		Leonardo Riego		Modificada para listar múltiplos comissionados
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT
	ME.PayComission,
	IMV.MovDate,
	ET.CommissionOnProfit,
	IMV.Discount,
	IMV.IDDocument as Invoice,
	IMV.Qty,
	IMV.CostPrice,
	IMV.SalePrice,
	IMV.ExchangeInvoice as InvoiceExchanged,
	IMV.QtyExchanged,
	IMV.SalesTax,
	I.LastName as CustomerLastName,
	I.FirstName as CustomerFirstName,
	I.ZIP as CustomerZip,
	I.SaleCode,
	I.InvoiceCode,
	I.Canceled,
	I.CupomFiscal,
	I.IDPreSale, 
	I.IDInvoice, 
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal,
	M.Model,
	M.Description,
	M.FreightCost as Freight,
	M.OtherCost,
	M.VendorCost,
	M.DateLastCost as LastPurchaseDate,
	M.MarkUp,
	M.SellingPrice as OurPrice,
	M.DateLastSellingPrice as LastSaleDate,
	M.SuggRetail as MSRP,
	M.TotQtyOnHand,
	M.LastMovDate,
	M.AvgCost,
	M.FinalCost as NetCost,
	C.Category,
	ME.Media,
	S.Store,
	S.Address as StoreAddress,
	S.Telephone as StorePhone,
	S.IDState as State,
	S.City as StoreCity,
	S.Zip as StoreZip,
	S.Fax as StoreFax,
	S.Contact as StoreContact,
	COM.FirstName as SalesPersonFName,
	COM.LastName as SalesPersonLName,
	COM.FullName as SalesPersonFullName,
	INVC.ColorCode,
	INVC.Color,
	INVS.CodSize,
	INVS.SizeName,
	GCT.Commission as PercentCommis,
	(IMV.CostPrice * IMV.Qty) as ExtCostPrice,
	(IMV.SalePrice * IMV.Qty) as ExtSalePrice,
	(IMV.Discount * -1) as DiscountCalc,
	(IMV.SalePrice - IMV.Discount) as SubTotal,
	(IMV.SalePrice - IMV.Discount) + ROUND(((IMV.SalePrice - IMV.Discount) * IMV.SalesTax),2) as GrandTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) as ExtSubTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) + ROUND((((IMV.SalePrice * IMV.Qty) - IMV.Discount) * IMV.SalesTax),2) as ExtGrandTotal,
	(((IMV.SalePrice * IMV.Qty)- IMV.Discount) - IMV.CostPrice) as Profit,
	CASE WHEN ET.CommissionOnProfit = 0 THEN 'OnSale' ELSE 'OnProfit' END as CommissionType,
	((((IMV.SalePrice - (IMV.CostPrice * ET.CommissionOnProfit)) * IMV.Qty - IMV.Discount)) * ( GCT.Commission / ((100 / SIC.CommissionPercent) * 100) )) * ME.PayComission as Commission,
	SIC.IDCommission as IDCommission,
	ET.IDPersonType,
	ET.PersonType,
	IMV.IDUser,
	SIC.CommissionPercent as CommissionPercent
FROM	
	vw_Rep_Invoice I (NOLOCK)
	JOIN vw_Rep_Media ME (NOLOCK) ON (ME.IDMedia = I.IDMedia)
	JOIN vw_Rep_InventoryMov IMV (NOLOCK) ON (I.IDInvoice = IMV.IDDocument)
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (IMV.IDInventoryMov = SIC.IDInventoryMov)
	JOIN vw_Rep_Entity COM (NOLOCK) ON (COM.IDPerson = SIC.IDCommission)
	JOIn vw_Rep_EntityType ET (NOLOCK) ON (ET.IDPersonType = COM.IDPersonType)
	JOIN vw_Rep_Store S (NOLOCK) ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M (NOLOCK) ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C (NOLOCK) ON (M.GroupID = C.IDCategory)
	JOIN vw_Rep_GroupToCommissionType GCT (NOLOCK) ON (GCT.IDPersonType = COM.IDPersonType AND GCT.IDGroup = M.GroupID)
	LEFT OUTER JOIN vw_Rep_InvColor INVC (NOLOCK) ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS (NOLOCK) ON (INVS.IDSize = M.IDSize)
WHERE
	IMV.IDInventMovType = 1
GROUP BY
	IMV.IDInventoryMov,
	ME.PayComission,
	IMV.MovDate,
	ET.CommissionOnProfit,
	IMV.Discount,
	IMV.IDDocument,

	IMV.Qty,	IMV.CostPrice,
	IMV.SalePrice,
	IMV.ExchangeInvoice,
	IMV.QtyExchanged,
	IMV.SalesTax,
	I.LastName,
	I.FirstName,
	I.ZIP,
	I.SaleCode,
	I.InvoiceCode,
	I.Canceled,
	I.CupomFiscal,
	I.IDPreSale, 
	I.IDInvoice, 
	I.CupomFiscal,
	M.Model,
	M.Description,
	M.FreightCost,
	M.OtherCost,
	M.VendorCost,
	M.DateLastCost,
	M.MarkUp,
	M.SellingPrice,
	M.DateLastSellingPrice,
	M.SuggRetail,
	M.TotQtyOnHand,
	M.LastMovDate,
	M.AvgCost,
	M.FinalCost,
	C.Category,
	ME.Media,
	S.Store,
	S.Address,
	S.Telephone,
	S.IDState,
	S.City,
	S.Zip,
	S.Fax,
	S.Contact,
	COM.FirstName,
	COM.LastName,
	COM.FullName,
	INVC.ColorCode,
	INVC.Color,
	INVS.CodSize,
	INVS.SizeName,
	GCT.Commission,
	SIC.IDCommission,
	ET.IDPersonType,
	ET.PersonType,
	IMV.IDUser,
	SIC.CommissionPercent

GO

CREATE VIEW vw_Rep_GroupCost AS

SELECT
	G.IDCost,
	G.IDTouristGroup,
	G.IDCostType,
	G.IDInventoryMov,
	G.CostDate,
	G.UnitCost,
	G.Quantity
FROM
	GroupCost G (NOLOCK)

GO

CREATE VIEW vw_Rep_GroupCostGift AS

SELECT
	G.IDGroupCostGift,
	G.IDModel,
	G.IDUser
FROM
	GroupCostGift G (NOLOCK)

GO

CREATE  VIEW vw_Rep_InventoryHistory AS
SELECT
	IM.IDInventoryMov,
	IM.ModelID,
	IM.StoreID,
	IM.MovDate,
	IM.CostPrice,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
FROM
	InventoryMov IM (NOLOCK)
	JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
GROUP BY
	IM.IDInventoryMov,
	IM.MovDate,
	ModelID,
	StoreID,
	IM.CostPrice

GO

CREATE  VIEW vw_Rep_InventoryMoviment  AS
SELECT 
	I.IDInventoryMov, 
	I.InventMovTypeID as IDInventMovType, 
	I.DocumentID as IDDocument, 
	I.IDPessoa, 
	I.ModelID as IDModel, 
	I.StoreID as IDStore, 
	I.IDLancPagCom, 
	I.IDUser, 
	I.IDAgrupaPag, 
	I.IDTemp, 
	I.MovDate, 
	I.Qty, 
	I.CostPrice, 
	I.SalePrice, 
	I.Discount, 
	I.Freight, 
	I.OtherCost, 
	I.ExchangeInvoice, 
	I.QtyExchanged, 
	I.SalesTax,
	I.AvgCost
FROM 
	InventoryMov I (NOLOCK)

GO

CREATE VIEW vw_Rep_InventoryRepair (IDRepair, IDModel, IDStore, IDInvMovSend, Status, IDVendor, IDUserReceive, ReceiveDate, SentDate, OBSReceive, RepairType, IDUserSent, Qty, UPS, RA, DateLastCost, SerialNumber, LastCost, Defect, IDUserReturn, ReturnDate, OBSReturn, IDUserBack, BackDate, IDInvMovReturn, OBSBack)  AS

SELECT
	R.IDRepair,
	R.IDModel,
	R.IDStore,
	R.IDInvMovSend,
	R.Fase,
	R.IDFornecedor,
	R.IDUserReceive,
	R.ReceiveDate,
	R.SentDate,
	R.OBSReceive,
	R.TipoRepair,
	R.IDUserSent,
	R.Qty,
	R.UPS,
	R.RA,
	R.DateLastCost,
	R.SerialNumber,
	R.LastCost,
	R.Defect,
	R.IDUserReturn,
	R.ReturnDate,
	R.OBSReturn,
	R.IDUserBack,
	R.BackDate,
	R.IDInvMovReturn,
	R.OBSBack
FROM
	Repair R (NOLOCK)

GO

CREATE VIEW vw_Rep_InvoiceDate AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório
 
	LOG DE MODIFICAÇÕES
 
	Data			Programador			Modificação
	-----------------------	-------------------------------	--------------------------------------------------------------------------
	08 Jan	2004		Marcello Felipelli		Criação;
	11 Apr	2007		Maximiiano Muniz		Novo campo InvoiceDiscount;
	---------------------------------------------------------------------------------------------------------------------------------- */
 
SELECT
	IMV.IDInventoryMov,
	IMV.MovDate,
	IMV.IDDocument as Invoice,
	IMV.Qty,
	IMV.CostPrice,
	(IMV.CostPrice * IMV.Qty) as ExtCostPrice,
	IMV.AvgCost as ItemAvgCost,
	(IMV.AvgCost * IMV.Qty) as ExtAvgCost,
	IMV.SalePrice,
	(IMV.SalePrice * IMV.Qty) as ExtSalePrice,
	(IMV.Discount * -1) as Discount,
	(IMV.SalePrice - IMV.Discount) as SubTotal,
	(IMV.SalePrice - IMV.Discount) + ROUND(((IMV.SalePrice - IMV.Discount) * IMV.SalesTax),2) as GrandTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) as ExtSubTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) + (CASE WHEN TaxIsent = 0 THEN ROUND((((IMV.SalePrice * IMV.Qty) - IMV.Discount) * IMV.SalesTax),2) ELSE 0 END) as ExtGrandTotal,
	IMV.ExchangeInvoice as InvoiceExchanged,
	IMV.QtyExchanged,
	(CASE WHEN I.TaxIsent = 0 THEN IMV.SalesTax ELSE 0 END) as SalesTax,
	I.LastName as CustomerLastName,
	I.FirstName as CustomerFirstName,
	I.ZIP as CustomerZip,
	M.Model,
	M.Description,
	M.FreightCost as Freight,
	M.OtherCost,
	M.VendorCost,
	M.DateLastCost as LastPurchaseDate,
	M.MarkUp,
	M.SellingPrice as OurPrice,
	M.DateLastSellingPrice as LastSaleDate,
	M.SuggRetail as MSRP,
	M.TotQtyOnHand,
	M.LastMovDate,
	M.AvgCost,
	M.FinalCost as NetCost,
	C.Category,
	ME.Media,
	S.Store,
	S.Address as StoreAddress,
	S.Telephone as StorePhone,
	S.IDState as State,
	S.City as StoreCity,
	S.Zip as StoreZip,
	S.Fax as StoreFax,
	S.Contact as StoreContact,
	COM.FirstName as SalesPersonFName,
	COM.LastName as SalesPersonLName,
	COM.FullName as SalesPersonFullName,
	INVC.ColorCode,
	INVC.Color,
	INVS.CodSize,
	INVS.SizeName,
	TRG.TipTouristGroup,
	TRG.NumTourist,
	TRG.EnterDate as GroupDate,
	AGN.FullName as Agency,
	AGT.FullName as Agent,
	I.Canceled,
	I.IDPreSale,
	I.IDInvoice,
	I.SaleCode,
	I.InvoiceCode,
	I.CupomFiscal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal,
	I.IDCashRegMov,
	I.IDSpecialPrice,
	I.IDTouristGroup,
	I.IDDeliverType,
	I.IDMedia,
	I.IDCustomer,
	I.IDStore,
	I.IDOtherComission,
	I.IDPreSaleParent,
	I.AditionalExpenses,
	I.InvoiceDiscount,
	M.IDModel,
	C.IDCategory,
	CUS.FullName as CustomerFullName,
	(IsNull(I.SubTotal, 0) - IsNull(I.InvoiceDiscount, 0) - IsNull(I.ItemDiscount, 0) + IsNull(I.Tax, 0) + IsNull(I.AditionalExpenses, 0)) as InvoiceGrandTotal,
	I.ItemDiscount,
	I.Tax
FROM 
	vw_Rep_InventoryMov IMV (NOLOCK)
	JOIN vw_Rep_Entity COM (NOLOCK) ON (COM.IDPerson = IMV.IDComission)
	JOIN vw_Rep_Store S (NOLOCK) ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M (NOLOCK) ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C (NOLOCK) ON (M.GroupID = C.IDCategory)
	LEFT OUTER JOIN vw_Rep_InvColor INVC (NOLOCK) ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS (NOLOCK) ON (INVS.IDSize = M.IDSize)
	JOIN vw_Rep_Invoice I (NOLOCK) ON (I.IDInvoice = IMV.IDDocument)
	JOIN vw_Rep_Media ME (NOLOCK) ON (ME.IDMedia = I.IDMedia)
	LEFT OUTER JOIN vw_Rep_TouristGroup TRG (NOLOCK) ON (TRG.IDTouristGroup = I.IDTouristGroup)
	LEFT OUTER JOIN vw_Rep_Entity AGN (NOLOCK) ON (AGN.IDPerson = TRG.IDAgency)
	LEFT OUTER JOIN vw_Rep_Entity AGT (NOLOCK) ON (AGT.IDPerson = TRG.IDGuide)
	LEFT OUTER JOIN vw_Rep_Entity CUS (NOLOCK) ON (CUS.IDPerson = I.IDCustomer)
WHERE
	IMV.IDInventMovType = 1

GO

CREATE VIEW vw_Rep_OpenLayawayHold AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório
 
	LOG DE MODIFICAÇÕES
 
	Data			Programador			Modificação
	-----------------------	-------------------------------	--------------------------------------------------------------------------
	08 Jan	2004		Marcello Felipelli		Criação;
	11 Apr	2007		Maximiiano Muniz		Novo campo InvoiceDiscount;
	---------------------------------------------------------------------------------------------------------------------------------- */

SELECT
	PIMV.IDPreInventoryMov,
	PIMV.MovDate,
	PIMV.IDDocument as HoldLayaway,
	PIMV.Qty,
	PIMV.CostPrice,
	(PIMV.CostPrice * PIMV.Qty) as ExtCostPrice,
	PIMV.SalePrice,
	(PIMV.SalePrice * PIMV.Qty) as ExtSalePrice,
	(PIMV.Discount * -1) as Discount,
	(PIMV.SalePrice - PIMV.Discount) as SubTotal,
	((PIMV.SalePrice * PIMV.Qty) - PIMV.Discount) as ExtSubTotal,
	I.LastName as CustomerLastName,
	I.FirstName as CustomerFirstName,
	I.ZIP as CustomerZip,
	CASE WHEN (I.Layaway = 0) THEN 'Hold #' ELSE 'Layaway #' END AS Layaway,
	M.Model,
	M.Description,
	M.FreightCost as Freight,
	M.OtherCost,
	M.VendorCost,
	M.DateLastCost as LastPurchaseDate,
	M.MarkUp,
	M.SellingPrice as OurPrice,
	M.DateLastSellingPrice as LastSaleDate,
	M.SuggRetail as MSRP,
	M.TotQtyOnHand,
	M.LastMovDate,
	M.AvgCost,
	M.FinalCost as NetCost,
	C.Category,
	C.IDCategory,
	ME.Media,
	S.Store,
	S.Address as StoreAddress,
	S.Telephone as StorePhone,
	S.IDState as State,
	S.City as StoreCity,
	S.Zip as StoreZip,
	S.Fax as StoreFax,
	S.Contact as StoreContact,
	COM.FirstName as SalesPersonFName,
	COM.LastName as SalesPersonLName,
	COM.FullName as SalesPersonFullName,
	INVC.ColorCode,
	INVC.Color,
	INVS.CodSize,
	INVS.SizeName,
	TRG.TipTouristGroup,
	TRG.NumTourist,
	TRG.EnterDate as GroupDate,
	AGN.FullName as Agency,
	AGT.FullName as Agent,
	I.Canceled,
	I.CupomFiscal,
	I.SaleCode,
	I.AditionalExpenses,
	I.SubTotal as InvoiceSubTotal,
	I.ItemDiscount,
	IsNull(I.InvoiceDiscount, 0) as InvoiceDiscount,
 	(IsNull(I.SubTotal, 0) - IsNull(I.InvoiceDiscount, 0) - IsNull(I.ItemDiscount, 0) + IsNull(I.Tax, 0) + IsNull(I.AditionalExpenses, 0)) as InvoiceGrandTotal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal
FROM	
	vw_Rep_PreInventoryMov PIMV (NOLOCK)
	JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDPreInventoryMov = PIMV.IDPreInventoryMov)
	JOIN vw_Rep_Entity COM (NOLOCK) ON (COM.IDPerson = SIC.IDCommission)
	JOIN vw_Rep_Store S (NOLOCK) ON (S.IDStore = PIMV.IDStore)
	JOIN vw_Rep_Model M (NOLOCK) ON (PIMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C (NOLOCK) ON (M.GroupID = C.IDCategory)
	LEFT OUTER JOIN vw_Rep_InvColor INVC (NOLOCK) ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS (NOLOCK) ON (INVS.IDSize = M.IDSize)
	JOIN vw_Rep_Invoice I (NOLOCK) ON (I.IDPreSale = PIMV.IDDocument)
	JOIN vw_Rep_Media ME (NOLOCK) ON (ME.IDMedia = I.IDMedia)
	LEFT OUTER JOIN vw_Rep_Entity CUS (NOLOCK) ON (CUS.IDPerson = PIMV.IDPerson)
	LEFT OUTER JOIN vw_Rep_TouristGroup TRG (NOLOCK) ON (TRG.IDTouristGroup = I.IDTouristGroup)
	LEFT OUTER JOIN vw_Rep_Entity AGN (NOLOCK) ON (AGN.IDPerson = TRG.IDAgency)
	LEFT OUTER JOIN vw_Rep_Entity AGT (NOLOCK) ON (AGT.IDPerson = TRG.IDGuide)
WHERE
	PIMV.IDInventMovType = 1

GO

CREATE VIEW vw_Rep_Records (RecordDate, IDPreSale, IDPaymentType, TotalInvoice, IDCashRegMov)  AS

SELECT
	F.DataLancamento,
	F.IDPreSale,
	F.IDQuitacaoMeioPrevisto,
	F.ValorNominal,
	F.IDCashRegMov
FROM
	Fin_Lancamento F (NOLOCK)

GO

CREATE VIEW vw_Rep_Records_Resum AS

SELECT
	F.DataLancamento,
	F.IDPreSale,
	F.IDQuitacaoMeioPrevisto,
	SUM(F.ValorNominal) as ValorNominal,
	F.IDCashRegMov
FROM
	Fin_Lancamento F (NOLOCK)
GROUP BY
	F.IDQuitacaoMeioPrevisto,
	F.DataLancamento,
	F.IDCashRegMov,
	F.IDPreSale

GO

CREATE VIEW vw_Rep_Repair (IDRepair, IDModel, IDStore, IDInvMovSend, IDCliente, IDUserSent, IDVendor, IDUserReceive, IDUserReturn, IDInvMovReturn, Status, ReceiveDate, SentDate, OBSReceive, RepairType, Qty, UPS, RA, DateLastCost, SerialNumber, LastCost, Defect, ReturnDate, ReturnStatus, OBSReturn, Tipo)  AS

SELECT
	R.IDRepair,
	R.IDModel,
	R.IDStore,
	R.IDInvMovSend,
	R.IDCliente,
	R.IDUserSent,
	R.IDFornecedor,
	R.IDUserReceive,
	R.IDUserReturn,
	R.IDInvMovReturn,
	R.Fase,
	R.ReceiveDate,
	R.SentDate,
	R.OBSReceive,
	R.TipoRepair,
	R.Qty,
	R.UPS,
	R.RA,
	R.DateLastCost,
	R.SerialNumber,
	R.LastCost,
	R.Defect,
	R.ReturnDate,
	R.ReturnStatus,
	R.OBSReturn,
	R.Tipo
FROM
	Repair R (NOLOCK)

GO

CREATE VIEW dbo.vw_Rep_SaleByManufacture
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

/*vw_Rep_SaleByManufacture*/
SELECT
	IMV.MovDate,
	IMV.IDDocument as Invoice,
	IMV.Qty,
	(IMV.CostPrice * IMV.Qty) as ExtCostPrice,
	(IMV.SalePrice * IMV.Qty) as ExtSalePrice,
	(IMV.SalePrice - IMV.Discount) as SubTotal,
	(IMV.SalePrice - IMV.Discount) + ROUND(((IMV.SalePrice - IMV.Discount) * IMV.SalesTax),2) as GrandTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) as ExtSubTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) + (CASE WHEN TaxIsent = 0 THEN ROUND((((IMV.SalePrice * IMV.Qty) - IMV.Discount) * IMV.SalesTax),2) ELSE 0 END) as ExtGrandTotal,
	(CASE WHEN I.TaxIsent = 0 THEN IMV.SalesTax ELSE 0 END) as SalesTax,
	I.LastName as CustomerLastName,
	I.FirstName as CustomerFirstName,
	I.ZIP as CustomerZip,
	I.InvoiceDate,
	M.IDFabricante as IDManufacture,
	M.Model,
	M.Description,
	M.FreightCost as Freight,
	M.OtherCost,
	M.VendorCost,
	M.DateLastCost as LastPurchaseDate,
	M.MarkUp,
	M.SellingPrice as OurPrice,
	M.DateLastSellingPrice as LastSaleDate,
	M.SuggRetail as MSRP,
	M.TotQtyOnHand,
	M.LastMovDate,
	M.AvgCost,
	M.FinalCost as NetCost,
	ME.Media,
	S.Store,
	C.IDPerson as IDCustomer,
	C.FullName as CustomerName,
	C.Address as CustomerAddress,
	C.City as CustomerCity,
	C.IDState as CustomerState,
	C.Zip as CustomerZipInvoice,
	C.Phone as CustomerPhone,
	C.Fax as CustomerFax,
	C.Email as CustomerEmail
FROM	
	vw_Rep_InventoryMov IMV (NOLOCK)
	JOIN vw_Rep_Store S (NOLOCK) ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M (NOLOCK) ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Invoice I (NOLOCK) ON (I.IDInvoice = IMV.IDDocument)
	JOIN vw_Rep_Media ME (NOLOCK) ON (ME.IDMedia = I.IDMedia)
	JOIN vw_Rep_Entity C (NOLOCK)ON (C.IDPerson = I.IDCustomer)
WHERE
	IMV.IDInventMovType = 1
	AND M.IDFabricante IS NOT NULL
	AND I.IDCustomer <> 1 --No Register Customer

GO

CREATE VIEW vw_Rep_SalesBySalesPerson AS
SELECT 
	SIC.IDComMission AS ComissionID,
	Pessoa.Pessoa,
	InventoryMov.MovDate,
	Model.Model,
	Model.Description,
	Model.SellingPrice,
	InventoryMov.Qty, 
	((SalePrice - Discount) / Qty) AS SalePrice, 
	InventoryMov.CostPrice AS CostPrice,
	(InventoryMov.Discount) AS Discount, 
	((InventoryMov.Discount / Qty)) AS TotalDiscount,	
	((((InventoryMov.SalePrice - (InventoryMov.CostPrice * TipoPessoa.ComissionOnProfit)) * InventoryMov.Qty - InventoryMov.Discount)) * (Comission / ((100 / SIC.CommissionPercent) * 100)))  * Media.PayComission AS Comissao
FROM 
	Model (NOLOCK)
	JOIN InventoryMov (NOLOCK) ON (Model.IDModel = InventoryMov.ModelID)
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (InventoryMov.IDInventoryMov = SIC.IDInventoryMov)
	JOIN GroupToComissionType (NOLOCK) ON (GroupToComissionType.GroupID = Model.GroupID)
	JOIN Pessoa (NOLOCK) ON (SIC.IDCommission = Pessoa.IDPessoa) AND (Pessoa.IDTipoPessoa = GroupToComissionType.IDTipoComissionado)
	JOIN TipoPessoa (NOLOCK) ON (Pessoa.IDTipoPessoa = TipoPessoa.IDTipoPessoa)
	JOIN Invoice (NOLOCK) ON (InventoryMov.DocumentID = Invoice.IDInvoice)
	JOIN Media (NOLOCK) ON (Invoice.MediaID = Media.IDMedia)
WHERE
	InventoryMov.InventMovTypeID = 1
	AND InventoryMov.Discount <> 0

GO

CREATE VIEW vw_Rep_SalesPersonCommission AS
SELECT
	TourGrp.TipTouristGroup,
	Invo.IDInvoice, 
	Invo.InvoiceDate,
	Invo.Tax,
	Media.Media,
	Model.Model,
	Model.Description,
	InvMov.Qty,
	Pes.Pessoa AS Customer,
	Invo.SubTotal - Invo.ItemDiscount AS InvoiceTotal,
	InvMov.CostPrice * InvMov.Qty AS ItemCost,
	InvMov.SalePrice * InvMov.Qty - InvMov.Discount AS ItemValue,
	InvMov.SalePrice * InvMov.Qty - InvMov.Discount - InvMov.CostPrice * InvMov.Qty AS ItemProfit,
	((InvMov.SalePrice - InvMov.CostPrice * TipoPes.ComissionOnProfit) * InvMov.Qty - InvMov.Discount) * GrpComisType.Comission / ((100 / SIC.CommissionPercent) * 100) * Media.PayComission  AS Commission,
	 SalesPerson.Pessoa AS SalesPerson,
	Invo.IDStore AS IDStore,
	TG.Path AS Category
FROM
	Invoice Invo (NOLOCK)
	LEFT JOIN TouristGroup TourGrp (NOLOCK) ON (Invo.IDTouristGroup = TourGrp.IDTouristGroup )
	JOIN InventoryMov InvMov (NOLOCK) ON (InvMov.DocumentID = Invo.IDInvoice)
	JOIN Model (NOLOCK) ON (InvMov.ModelID = Model.IDModel)
	JOIN TabGroup TG (NOLOCK) ON (Model.GroupID = TG.IDGroup)
	JOIN Media (NOLOCK) ON (Invo.MediaID = Media.IDMedia)
	JOIN Pessoa Pes (NOLOCK) ON (Invo.IDCustomer = Pes.IDPessoa)
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (InvMov.IDInventoryMov = SIC.IDInventoryMov)
	JOIN GroupToComissionType GrpComisType (NOLOCK) ON (GrpComisType.GroupID = Model.GroupID )
	JOIN Pessoa SalesPerson (NOLOCK) ON (SIC.IDCommission = SalesPerson.IDPessoa) AND (SalesPerson.IDTipoPessoa = GrpComisType.IDTipoComissionado)
	JOIN TipoPessoa TipoPes (NOLOCK) ON (SalesPerson.IDTipoPessoa = TipoPes.IDTipoPessoa)
WHERE
	InvMov.InventMovTypeID = 1

GO

CREATE VIEW vw_Rep_SalesPersonResult AS
SELECT
	Pes.Pessoa AS SalesPerson,
	TpPes.TipoPessoa AS SalesPersonType,
	SUM(InvMov.SalePrice * InvMov.Qty - InvMov.Discount) AS SumSales,
	SUM(InvMov.CostPrice * InvMov.Qty) AS SumCost,
	SUM((InvMov.SalePrice - InvMov.CostPrice) * InvMov.Qty - InvMov.Discount) AS SumProfit,
	SUM(((ISNULL(InvMov.SalePrice, 0) - ISNULL(InvMov.CostPrice, 0) * ISNULL(TpPes.ComissionOnProfit, 1)) * 
               ISNULL(InvMov.Qty, 0) - ISNULL(InvMov.Discount, 0)) * ISNULL(GTC.Comission, 0) / ((100 / SIC.CommissionPercent) * 100) * ISNULL(Media.PayComission, 1)) AS SumCommission,
	Inv.IDStore AS IDStore,
	TG.Path AS Category,
	Media.Media,
	Inv.InvoiceDate
FROM
	InventoryMov InvMov (NOLOCK)
	JOIN Invoice Inv (NOLOCK) ON (InvMov.DocumentID = Inv.IDInvoice )
	JOIN Model Mod (NOLOCK) ON (InvMov.ModelID = Mod.IDModel )
	JOIN TabGroup TG (NOLOCK) ON (Mod.GroupID = TG.IDGroup )
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (InvMov.IDInventoryMov = SIC.IDInventoryMov)
	JOIN GroupToComissionType GTC (NOLOCK) ON (Mod.GroupID = GTC.GroupID )
	JOIN Pessoa Pes (NOLOCK) ON (SIC.IDCommission = Pes.IDPessoa )
	JOIN TipoPessoa TpPes (NOLOCK) ON (Pes.IDTipoPessoa = TpPes.IDTipoPessoa ) AND (Pes.IDTipoPessoa = GTC.IDTipoComissionado)
	JOIN Media (NOLOCK) ON (Inv.MediaID = Media.IDMedia)
WHERE
	InvMov.InventMovTypeID = 1
GROUP BY 
	Pes.Pessoa, 
	TpPes.TipoPessoa, 
	Inv.IDStore, 
	Media.Media, 
	TG.Path, 
	Inv.InvoiceDate

GO

CREATE VIEW dbo.vw_Rep_SalesProfit
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para ser utilizada no relatório Sales Profit by Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT 
	vw_Rep_InventoryMov.IDStore,
	CONVERT(varchar(10), vw_Rep_InventoryMov.MovDate, 101) as MovDate,
	DatePart(year, vw_Rep_InventoryMov.MovDate) InvYear, 
	Convert(Varchar(10),DateName(month, vw_Rep_InventoryMov.MovDate)) MonthName, 
	DatePart(month, vw_Rep_InventoryMov.MovDate) InvMonth, 
	DatePart(day, vw_Rep_InventoryMov.MovDate) InvDay, 
	SUM(vw_Rep_InventoryMov.Qty) NumItems, 
	SUM(( vw_Rep_InventoryMov.SalePrice * vw_Rep_InventoryMov.Qty )  - vw_Rep_InventoryMov.Discount ) Sales, 
	SUM( vw_Rep_InventoryMov.CostPrice * vw_Rep_InventoryMov.Qty ) Cost, 
	SUM(( vw_Rep_InventoryMov.SalePrice - vw_Rep_InventoryMov.CostPrice )  * vw_Rep_InventoryMov.Qty - vw_Rep_InventoryMov.Discount ) Profit, 
	CASE WHEN SUM(( vw_Rep_InventoryMov.SalePrice * vw_Rep_InventoryMov.Qty )  - vw_Rep_InventoryMov.Discount ) = 0 THEN 0 ELSE (( SUM(( vw_Rep_InventoryMov.SalePrice - vw_Rep_InventoryMov.CostPrice )  * vw_Rep_InventoryMov.Qty - vw_Rep_InventoryMov.Discount )) / ( SUM(( vw_Rep_InventoryMov.SalePrice * vw_Rep_InventoryMov.Qty )  - vw_Rep_InventoryMov.Discount ))) * 100 END Percents
FROM
	vw_Rep_InventoryMov vw_Rep_InventoryMov (NOLOCK)
	INNER JOIN vw_Rep_Invoice vw_Rep_Invoice (NOLOCK) ON (vw_Rep_Invoice.IDInvoice = vw_Rep_InventoryMov.IDDocument)
	INNER JOIN vw_Rep_Media vw_Rep_Media (NOLOCK) ON (vw_Rep_Media.IDMedia = vw_Rep_Invoice.IDMedia)
	INNER JOIN vw_Rep_Model vw_Rep_Model (NOLOCK) ON (vw_Rep_Model.IDModel = vw_Rep_InventoryMov.IDModel)
	INNER JOIN vw_Rep_Category vw_Rep_Category (NOLOCK) ON (vw_Rep_Category.IDCategory = vw_Rep_Model.GroupID)
WHERE 
	vw_Rep_InventoryMov.IDInventMovType = 1
	AND vw_Rep_Invoice.Canceled = 0
GROUP BY
	vw_Rep_InventoryMov.IDStore,
	CONVERT(varchar(10), vw_Rep_InventoryMov.MovDate, 101), 
	DatePart(year, vw_Rep_InventoryMov.MovDate),
	Convert(Varchar(10),DateName(month, vw_Rep_InventoryMov.MovDate)),
	DatePart(month, vw_Rep_InventoryMov.MovDate),
	DatePart(day, vw_Rep_InventoryMov.MovDate)

GO

CREATE VIEW vw_Rep_ZipCode (IDStore, ZIP, Total, InvQty, CostPrice, Gross)  AS

SELECT
	I.IDStore,
	I.ZIP,
	SUM((IM.SalePrice * IM.Qty) - IM.Discount),
	COUNT(I.IDInvoice),
	SUM((IM.CostPrice) * IM.Qty),
	SUM(((IM.SalePrice - IM.CostPrice) * IM.Qty) - IM.Discount)
FROM
	Invoice I (NOLOCK),
	InventoryMov IM (NOLOCK)
WHERE
	IM.DocumentID = I.IDInvoice
	AND I.IDInvoice IS NOT NULL 
	AND LTRIM(I.ZIP) IS NOT NULL 
	AND IM.InventMovTypeID = 1
GROUP BY
	I.ZIP,
	I.IDStore

GO
