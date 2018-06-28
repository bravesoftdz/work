if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_PreSale_GetNewSaleCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_PreSale_GetNewSaleCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashReg_CalcCash]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashReg_CalcCash]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashReg_CheckOpen]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashReg_CheckOpen]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashReg_WidrawCalcCash]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashReg_WidrawCalcCash]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Close]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Close]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Quita_Invoice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Quita_Invoice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Quita_Lancamento]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Quita_Lancamento]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_SubClose]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_SubClose]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Cashregister_GetPayments]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Cashregister_GetPayments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Comission_CalcPayDate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Comission_CalcPayDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcAgency]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcAgency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcDivida]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcDivida]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcGuide]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcGuide]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcGuideAgency]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcGuideAgency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcOther]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcOther]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcVendedor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcVendedor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_DelPayAgency]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_DelPayAgency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_PayAgency]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_PayAgency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_PayGuide]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_PayGuide]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_PayOther]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_PayOther]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_PayVendedor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_PayVendedor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Cotation_CreatePO]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Cotation_CreatePO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Fin_CriaLacamento_Disburse]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Fin_CriaLacamento_Disburse]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Fin_Transferencia_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Fin_Transferencia_Do]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Financ_DelLanc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Financ_DelLanc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_AdjustAvgCost]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_AdjustAvgCost]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_AdjustAvgCostInventory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_AdjustAvgCostInventory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_AdjustAvgCostModel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_AdjustAvgCostModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_CalcBalance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_CalcBalance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_CalcModelABC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_CalcModelABC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_CalcModelBalance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_CalcModelBalance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_CalcModelStoreBalance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_CalcModelStoreBalance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_CalcStoreABC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_CalcStoreABC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_AddColor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_AddColor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_AddSize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_AddSize]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Adjust]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Adjust]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Count]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Count]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Del_Moviment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Del_Moviment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Sub_AtuModelName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Sub_AtuModelName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Sub_AtuModelValues]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Sub_AtuModelValues]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Tranfer_IN]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Tranfer_IN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Tranfer_OUT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Tranfer_OUT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Invoice_CalcComission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Invoice_CalcComission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Invoice_SubPayComission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Invoice_SubPayComission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Invoice_SubPayGuideAgency]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Invoice_SubPayGuideAgency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Model_Adjust]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Model_Adjust]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Model_DescBarCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Model_DescBarCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Model_quKitPrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Model_quKitPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Model_quModel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Model_quModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Model_quQtyOnStore]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Model_quQtyOnStore]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_AddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_AddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_AtuPOTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_AtuPOTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_CalcOrderPoint]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_CalcOrderPoint]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_CalcOrderPointSimple]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_CalcOrderPointSimple]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_CalcTotalQty]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_CalcTotalQty]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_ChangeItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_ChangeItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_DeleteItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_DeleteItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_GetCurrentPO]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_GetCurrentPO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_Item_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_Item_Do]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_Item_InsertSubModel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_Item_InsertSubModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_Item_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_Item_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Pessoa_CalcSaldos]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Pessoa_CalcSaldos]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Pessoa_GetPessoaRoot]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Pessoa_GetPessoaRoot]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddModelCredit]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddModelCredit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddParcela]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddParcela]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ApplyCustomerDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ApplyCustomerDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ApplyCustomerItemDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ApplyCustomerItemDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ApplySpecialPrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ApplySpecialPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AtuOpenUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AtuOpenUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcCustomerDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcCustomerDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcFullTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcFullTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcSalePrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcSalePrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CancelHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CancelHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CancelInvoice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CancelInvoice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DelOldHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DelOldHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DeleteDelayPayment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DeleteDelayPayment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DeletePayments]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DeletePayments]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DeleteSingleDelayPayment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DeleteSingleDelayPayment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DivideHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DivideHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Import_Estimated]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Import_Estimated]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ItemRepair]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ItemRepair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_MaxDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_MaxDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Pay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Pay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_RemoveDiscountItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_RemoveDiscountItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_RemoveSpecialPrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_RemoveSpecialPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SetTaxIsention]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SetTaxIsention]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SpecialPriceManager]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SpecialPriceManager]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Split]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Split]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubAddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubAddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcAdditionalExpenses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcAdditionalExpenses]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcItemDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcItemDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcTax]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcTax]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubRemoveAdditionalExpenses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubRemoveAdditionalExpenses]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubRemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubRemoveItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubTestDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubTestDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_TestPayment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_TestPayment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_TestRefresh]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_TestRefresh]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_UnPay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_UnPay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPayTypeMin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPayTypeMin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItemSplited]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItemSplited]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleParcela]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleParcela]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleValue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleValue]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_AddPurchaseItemTax]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_AddPurchaseItemTax]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_AddPurchaseItemTaxRet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_AddPurchaseItemTaxRet]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_AtuPurchaseSubTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_AtuPurchaseSubTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_CriaPagamento]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_CriaPagamento]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_CriaPagamentoComImposto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_CriaPagamentoComImposto]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_CriaPagamentoComImpostoRet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_CriaPagamentoComImpostoRet]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Do]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_RemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_RemoveItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Repair_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Repair_Do]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sal_AccountCard_AddAmount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sal_AccountCard_AddAmount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_GetUserRights]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_GetUserRights]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_QuickInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_QuickInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sys_DailyMaintenance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sys_DailyMaintenance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SystemUser_GetIDUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SystemUser_GetIDUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_TourGroup_AddGift]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_TourGroup_AddGift]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateSystemQty]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateSystemQty]
GO

CREATE PROCEDURE sp_Sal_AccountCard_AddAmount
			(
				@CardNumber		varchar(20),
				@Amount		money,
				@IDPreSale		int,
				@IDLancamento	int,
				@IDUser		int,
				@Credit			bit,
				@OBS			varchar(100)
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Inseriro a linha de credito
		- Atualizo o total

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inserir o credito
		-202  Erro em Atualizar o total


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	23 Mar  2006		Rodrigo Costa		Criacao;
	29 Jun	2006		Rodrigo Costa		Retirado a transacao, tem que ser feita no Delphi
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @ErrorLevel		int 
DECLARE @SysError		int
DECLARE @IDAccountCardMov	int
DECLARE @IDAccountCard	int
DECLARE @ExpDateMonth	int

SET @ErrorLevel = 0 

SET @ExpDateMonth = (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 86)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*--------------------------------------------------------------*/
/*	Ler o ID do account        */
/*--------------------------------------------------------------*/
SELECT
	@IDAccountCard = A.IDAccountCard
FROM
	Sal_AccountCard A (NOLOCK) 
WHERE
	A.CardNumber = @CardNumber


/*--------------------------------------------------------------*/
/*	Insere o credito        */
/*--------------------------------------------------------------*/

EXEC sp_Sis_GetNextCode 'Sal_AccountCardMov.IDAccountCardMov', @IDAccountCardMov OUTPUT

INSERT
	Sal_AccountCardMov
	(
	IDAccountCardMov,
	DateMov,
	Value,
	Credit,
	IDPreSale,
	IDLancamento,
	IDUser,
	IDAccountCard,
	Obs
	)
VALUES
	(
	@IDAccountCardMov,
	GetDate(),
	@Amount,
	@Credit,
	@IDPreSale,
	@IDLancamento,
	@IDUser,
	@IDAccountCard,
	@OBS
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*--------------------------------------------------------------*/
/*		Atualiza o total	        */
/*--------------------------------------------------------------*/
IF @Credit = 0
	SET @Amount = @Amount * -1

UPDATE
	Sal_AccountCard
SET
	Amount = Amount + @Amount
WHERE
	IDAccountCard = @IDAccountCard


SET @SysError = @@ERROR
IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Sal_AccountCard_AddAmount', @ErrorLevelStr
	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_DeleteSingleDelayPayment
			(
			@IDLancamento int,
			@IDUser int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Cash RegisterMovent
		- Desquita o lancamento
		- Deleta o lancamento
		- Restaura Crédito do Cliente ou Cancela Crédito do Cliente
		- Restaura Crédito do Cartao ou Cancela Crédito do Cartao

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleta os registros de ligacao
		-202  Erro em Deleta os registros de quitacao
		-203  Erro em Deleta os registros de lançamento
		-204  Erro em Update Cash RegisterMovent
		-205  Erro em Restaura Crédito do Cliente
		-206  Erro em Cancela Crédito do Cliente
		-207  Erro em Restaura Crédito do Cartao
		-208  Erro em Cancela Crédito do Cartao

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	05 Oct  2004		Carlos Lima		Criação
	11 Nov 2004		Carlos Lima		Restaurar o Crédito do Cliente, caso a forma de
							pagamento for por Crédito de Cliente
	12 Nov 2004		Carlos Lima		Cancelar o Crédito do Cliente, caso a forma de
							pagamento for por Crédito de Cliente
	23 Mar	2006		Rodrigo Costa		Restaura e cancela o credito do cartao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

DECLARE @ErrorLevel		int
DECLARE @SysError		int

DECLARE @IDPessoa		int
DECLARE @IDStore		int
DECLARE @CreditDate		datetime
DECLARE @ExpirationDate 	datetime
DECLARE @ValorNominal	money
DECLARE @IDCustomerCredit	int
DECLARE @Tipo		int
DECLARE @AccountNumber		varchar(20)

SET @ErrorLevel = 0


SELECT
	@IDPessoa 	= Fin_Lancamento.IDPessoa,
	@IDStore	= Invoice.IDStore,
	@ValorNominal	= Fin_Lancamento.ValorNominal,
	@Tipo		= MeioPag.Tipo,
	@CreditDate	= GETDATE()
FROM
	Invoice (NOLOCK) 
	INNER JOIN Fin_Lancamento (NOLOCK) ON (Invoice.IDPreSale = Fin_Lancamento.IDPreSale)
	INNER JOIN MeioPag (NOLOCK) ON (Fin_Lancamento.IDQuitacaoMeioPrevisto = MeioPag.IDMeioPag)
WHERE
	Fin_Lancamento.IDLancamento = @IDLancamento

SET @ExpirationDate = NULL


/*----------------------------------------------------------------*/
/*	Restaura Crédito do Cliente	*/
/*---------------------------------------------------------------*/

IF (@Tipo = 5) AND (@ValorNominal > 0)
BEGIN
	EXEC sp_PreSale_AddCustomerCredit @IDPessoa, @IDUser,  @IDStore, @CreditDate, @ExpirationDate, @ValorNominal, NULL, @IDCustomerCredit OUTPUT

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
END

/*----------------------------------------------------------------*/
/*	Cancela Crédito do Cliente	*/
/*---------------------------------------------------------------*/


IF (@Tipo = 5) AND (@ValorNominal <= 0)
BEGIN
	UPDATE 	CustomerCredit 
	SET		IsUsed = 1,
			IDLancamento = NULL
	WHERE	IDLancamento = @IDLancamento

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
END

/*----------------------------------------------------------------*/
/*	Restaura Crédito do Cartao	*/
/*---------------------------------------------------------------*/
IF (@Tipo = 6)
BEGIN
	SELECT
		@AccountNumber = AC.CardNumber
	FROM
		Sal_AccountCard AC (NOLOCK) 
		JOIN Sal_AccountCardMov ACM (NOLOCK) ON (AC.IDAccountCard = ACM.IDAccountCard)
	WHERE
		ACM.IDLancamento = @IDLancamento

	EXEC sp_Sal_AccountCard_AddAmount @AccountNumber, @ValorNominal, NULL, NULL, @IDUser, 1, ''

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -207
		GOTO ERRO
	END
END

/*----------------------------------------------------------------*/
/*	Cancela Crédito do Cartao	*/
/*---------------------------------------------------------------*/
IF (@Tipo = 6)
BEGIN
	UPDATE
		Sal_AccountCardMov
	SET
		IDLancamento = NULL
	WHERE
		IDLancamento = @IDLancamento

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -208
		GOTO ERRO
	END
END


/*----------------------------------------------------------------------------------------------------------*/
/*		Update Cash RegisterMovent do dia	     	  */
/*---------------------------------------------------------------------------------------------------------*/ 
UPDATE
	CashRegMov	
SET
	CashRegMov.TotalSales = IsNull(CashRegMov.TotalSales, 0) - Fin_Lancamento.ValorNominal
FROM
	Fin_Lancamento (NOLOCK) 
WHERE
	CashRegMov.IDCashRegMov = Fin_Lancamento.IDCashRegMov
	AND Fin_Lancamento.IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------*/
/*	       Desquita o lancamento         			  */
/*--------------------------------------------------------------------------------------------*/

/*----------- Cria tabela com as quitacoes a serem deletadas ------------ */
SELECT
	Q.IDQuitacao
INTO
	#sp_PreSale_Remove_QuitToDelete
FROM
	Fin_Quitacao Q (NOLOCK) 
	JOIN Fin_LancQuit LQ (NOLOCK) ON (LQ.IDQuitacao = Q.IDQuitacao)
	JOIN Fin_Lancamento L (NOLOCK) ON (LQ.IDLancamento = L.IDLancamento)
WHERE
	L.IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*---------------- Deleta o registro de ligacao -------------------- */
DELETE
	LQ
FROM
	Fin_LancQuit LQ
	--JOIN Fin_Lancamento L ON (L.IDLancamento = LQ.IDLancamento)
	JOIN #sp_PreSale_Remove_QuitToDelete QTD ON (QTD.IDQuitacao = LQ.IDQuitacao)
--WHERE
--	L.IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*--------------- Deleta o registro de quitacao -----------------*/
DELETE
	Q
FROM
	Fin_Quitacao Q (NOLOCK) 
	JOIN #sp_PreSale_Remove_QuitToDelete QTD ON (QTD.IDQuitacao = Q.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------- Deleta o registro de lançamento --------------------*/
DELETE
	L
FROM 
	Fin_Lancamento L (NOLOCK)
WHERE
	L.IDLancamento = @IDLancamento


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DeleteSingleDelayPayment', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubCalcAdditionalExpenses
                                   (
                                   @IDPreSale int
                                   )
AS


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO

                        - Adiciona e calcula Despesas Adicionais

            TABELA DE ERROS PARA RETURN_VALUE
                         000  Ok
                        -201  Erro ao pegar o novo IDInvoiceCost
                        -202  Erro em UPDATE Invoice SET AditionalExpenses

            LOG DE MODIFICAÇÕES

            Data			Programador		Modificação
            --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
            19 Jan 2005		Rodrigo Costa		Criação
            ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
 

DECLARE @IDInvoiceCost 	int
DECLARE @ErrorLevel  	int
DECLARE @SysError   	int
 
SET @ErrorLevel = 0

-- É necessário a atualização de um campo: AditionalExpenses
UPDATE
            Invoice
SET 
            Invoice.AditionalExpenses =  ICT.TotAddExpenses
FROM
            (SELECT
                        IDPreSale, 
                        SUM(ISNULL(Amount, 0)) TotAddExpenses
            FROM
                        InvoiceToCostType (NOLOCK) 
            GROUP BY
                        IDPreSale) ICT
WHERE
	ICT.IDPreSale = Invoice.IDPreSale 
	AND
	(
	Invoice.IDPreSale = @IDPreSale
	OR
	Invoice.IDPreSaleParent = @IDPreSale
	)
 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END


OK:
            RETURN 0
ERRO:
            PRINT CAST(@ErrorLevel AS VARCHAR)
            DECLARE @ErrorLevelStr varchar(10)
            SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
            EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcAdditionalExpenses', @ErrorLevelStr
            RETURN @ErrorLevel
GO

CREATE   PROCEDURE sp_PreSale_SubCalcTax
			(
			@PreSaleID 	int,
			@Date		DateTime
			)
AS

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calculo Tax

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE Invoice
		-202  Erro em UPDATE I SET TaxIsemptValue

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	14 agosto 2000   	Eduardo Costa		Suporte ao tax categories, agora é taxa é definda na tabela de
							TaxCategory. Cada conjunto de Store e TabGroup define uma
							TaxCategory;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	26 Oct 	2004		Carlos Lima		Calcular Tax, incluindo os Invoices filhos
	07 Dez 2004		Rodrigo Costa		Novo calculo das taxas
	20 Jan	2005		Rodrigo Costa		Calculo das taxas do InventoryMov para somar com o total do invoice
	26 Fev	2007		Rodrigo Costa		Calcular imposto estabelecido no PreInvMov
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @LocalTax 		money
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @TaxTotal		money
DECLARE @TaxTotalExp	money

SET @ErrorLevel = 0

-- Caso o invoice esteja marcado como TaxIsempt, não calculo nada
IF (SELECT IV.TaxIsent FROM dbo.Invoice IV WHERE IV.IDPreSale = @PreSaleID ) = 1
BEGIN
	UPDATE
		Invoice
	SET
		Invoice.Tax = 0
	WHERE
		Invoice.IDPreSale = @PreSaleID
		OR
		Invoice.IDPreSaleParent = @PreSaleID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
	ELSE
		GOTO OK
END

-- É necessário a atualização de dois campos: TaxIsemptValue, e Tax
--Calculo do tax exempt
SET @TaxTotalExp = 
	IsNull((SELECT	
		SUM(IsNull(IMX.TaxValue,0))
	FROM	
		Invoice INV (NOLOCK) 
		JOIN
		InventoryMov IM (NOLOCK) ON (INV.IDInvoice = IM.DocumentID)
		JOIN
		InventoryMovTax IMX (NOLOCK) ON (IM.IDInventoryMov = IMX.IDInventoryMov)
	WHERE	
		(
		INV.IDPreSale = @PreSaleID
		OR
		INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
		)
               	AND
		IM.InventMovTypeID = 1
		AND
		INV.TaxIsent = 1
	),0)

--Calculo da taxa
SET @TaxTotal = 
	IsNull((SELECT	
		SUM(IsNull(IMX.TaxValue,0))
	FROM	
		Invoice INV (NOLOCK) 
		JOIN
		InventoryMov IM (NOLOCK) ON (INV.IDInvoice = IM.DocumentID)
		JOIN
		InventoryMovTax IMX (NOLOCK) ON (IM.IDInventoryMov = IMX.IDInventoryMov)
	WHERE	
		(
		INV.IDPreSale = @PreSaleID
		OR
		INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
		)
               	AND
		IM.InventMovTypeID = 1
		AND
		INV.TaxIsent = 0
	),0)

UPDATE
	I
SET
	TaxIsemptValue =
	ROUND(
	(
	SELECT	ISNULL(
			SUM	(
				(Round(PIM.Qty * ISNULL(PIM.SalePrice, 0),2,1) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
			 	* (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
				),0)
	FROM	
		Invoice INV (NOLOCK) 
		JOIN
		PreInventoryMov PIM (NOLOCK) ON (INV.IDPreSale = PIM.DocumentID)
		JOIN
		Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)
		JOIN
		StoreToTabGroup STG (NOLOCK) ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
		JOIN
		TaxCategory TC (NOLOCK) ON (STG.IDTaxCategory = TC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
		LEFT OUTER JOIN 
		TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STG.IDSaleTax )

	WHERE	
		(
		INV.IDPreSale = @PreSaleID
		OR
		INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
		)
               	AND
		PIM.InventMovTypeID = 1
		AND
		TC.TaxExempt = 1
	) + @TaxTotalExp, 2),
        		Tax =
	ROUND(
	(
	SELECT	ISNULL(
			SUM	(
				(Round(PIM.Qty * ISNULL(PIM.SalePrice, 0),2,1) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
			 	* (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
					 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
				),0)
	FROM	Invoice INV (NOLOCK) 
		JOIN PreInventoryMov PIM (NOLOCK) ON (INV.IDPreSale = PIM.DocumentID)
		JOIN Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)
		JOIN StoreToTabGroup STG (NOLOCK) ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
		JOIN TaxCategory TC (NOLOCK) ON (STG.IDTaxCategory = TC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
		LEFT OUTER JOIN TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STG.IDSaleTax )
	WHERE
		(
		INV.IDPreSale = @PreSaleID
		OR
		INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
		)
		AND
		PIM.InventMovTypeID = 1
		AND
		TC.TaxExempt = 0
	) + @TaxTotal, 2)
FROM
	Invoice I
WHERE
	I.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcTax', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubCalcItemDiscount
		(
			@PreSaleID Int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	26 Oct 	2004		Carlos Lima		Calcular Discount, incluindo os Invoices filhos
	20 Jan	2005		Rodrigo Costa		Calcular Discount pegando os valores do InventoryMov
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @TotalDiscount	money
DECLARE @TotalDiscExemp	money

SET @ErrorLevel = 0

--Valores do PreInventoryMov
SET @TotalDiscount = 
		IsNull((
		SELECT
			Sum(IsNull(PIM.Discount,0))
		FROM
			Invoice INV (NOLOCK) 
			JOIN
			PreInventoryMov PIM (NOLOCK) 
				ON (INV.IDPreSale = PIM.DocumentID)
			JOIN
			Model MO (NOLOCK) 
				ON (PIM.ModelID = MO.IDModel)
			JOIN
			TabGroup TG (NOLOCK) 
				ON (MO.GroupID = TG.IDGroup)
		WHERE
			(
				INV.IDPreSale = @PreSaleID
				OR
				INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
			)
			AND
			PIM.InventMovTypeID = 1
			AND
			TG.Taxable = 1
		),0)

SET @TotalDiscExemp =
		IsNull((
			SELECT
				Sum(IsNull(PIM.Discount,0))
			FROM				
				Invoice INV (NOLOCK) 
				JOIN
				PreInventoryMov PIM (NOLOCK) 
					ON (INV.IDPreSale = PIM.DocumentID)
				JOIN
				Model MO (NOLOCK) 
					ON (PIM.ModelID = MO.IDModel)
				JOIN
				TabGroup TG (NOLOCK) 
					ON (MO.GroupID = TG.IDGroup)
 			WHERE
				(
					INV.IDPreSale = @PreSaleID
					OR
					INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
				)
				AND
				PIM.InventMovTypeID = 1
				AND
				TG.Taxable = 0
		),0)


--Valores do InventoryMov
SET @TotalDiscount = @TotalDiscount +
		IsNull((
		SELECT
			Sum(IsNull(IM.Discount,0))
		FROM
			Invoice INV (NOLOCK) 
			JOIN
			InventoryMov IM (NOLOCK) 
				ON (INV.IDInvoice = IM.DocumentID)
			JOIN
			Model MO (NOLOCK) 
				ON (IM.ModelID = MO.IDModel)
			JOIN
			TabGroup TG (NOLOCK) 
				ON (MO.GroupID = TG.IDGroup)
		WHERE
			(
				INV.IDPreSale = @PreSaleID
				OR
				INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
			)
			AND
			IM.InventMovTypeID = 1
			AND
			TG.Taxable = 1
		),0)

SET @TotalDiscExemp = @TotalDiscExemp + 
		IsNull((
			SELECT
				Sum(IsNull(IM.Discount,0))
			FROM				
				Invoice INV (NOLOCK) 
				JOIN
				InventoryMov IM (NOLOCK) 
					ON (INV.IDInvoice = IM.DocumentID)
				JOIN
				Model MO (NOLOCK) 
					ON (IM.ModelID = MO.IDModel)
				JOIN
				TabGroup TG (NOLOCK) 
					ON (MO.GroupID = TG.IDGroup)
 			WHERE
				(
					INV.IDPreSale = @PreSaleID
					OR
					INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
				)
				AND
				IM.InventMovTypeID = 1
				AND
				TG.Taxable = 0
		),0)


UPDATE
	dbo.Invoice
SET
	dbo.Invoice.ItemDiscount =
		convert(money, convert(numeric(20, 0), @TotalDiscount * 100) / 100),

	dbo.Invoice.TaxIsemptItemDiscount =
		convert(money, convert(numeric(20, 0), @TotalDiscExemp * 100) / 100)
WHERE
	dbo.Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcItemDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PreSale_SubCalcTotal
		(
		@PreSaleID Int,
		@Date	DateTime
		)
AS
/* ----------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE dbo.Invoice
		-202  Erro em exec sp_PreSale_SubCalcItemDiscount
		-203  Erro em exec sp_PreSale_SubCalcTax
		-204  Erro em exec sp_PreSale_SubCalcAdditionalExpenses


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values;
	18 Aug 	2004		Rodrigo Costa		Gravar error log;
	26 Oct 	2004		Carlos Lima		Calcular total, incluindo os Invoices filhos;
	19 Jan	2005		Rodrigo Costa		Calcular os totais das outras despesas;
	20 Jan	2005		Rodrigo Costa		Calcular os totais do InvMov para somar no total da nota;
	21 Dec	2006		Maximiliano Muniz	Aplicada uma nova forma de arredondamento;
	10 Jan	2007		Maximiliano Muniz	Alterado o tipo da variável @SubTotal de money para float, pois o tipo money já
							arredonda automaticamente, ignorando a nova forma de arredondamento;
	18 Apr	2007		Maic Nogueira		Removida a lógica de arredondamento anterior, e adicionado um Round
							para cada item da venda;
	---------------------------------------------------------------------------------------------------------------------------------- */
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
DECLARE @SubTotal	float
SET @ErrorLevel = 0 

BEGIN TRAN 

--Calculo do PreInventoryMov
SET @SubTotal = 
		IsNull((
		SELECT
			SUM(Round(IsNull(PIM.SalePrice, 0) * IsNull(PIM.Qty, 0), 2, 1))
		FROM
			dbo.Invoice INV (NOLOCK) 
			LEFT JOIN dbo.PreInventoryMov PIM (NOLOCK) ON (INV.IDPreSale = PIM.DocumentID)
		WHERE
			(
			INV.IDPreSale = @PreSaleID
			OR
			INV.IDPreSaleParent = @PreSaleID -- Calcula todos os invoices filhos deste PreSale
			)						
			AND
			PIM.InventMovTypeID = 1
		),0)

--Calculo do InventoryMov
SET @SubTotal = @SubTotal + 
		IsNull((
		SELECT
			SUM(Round(IsNull(IM.SalePrice, 0) * IsNull(IM.Qty, 0), 2, 1))
		FROM
			dbo.Invoice INV (NOLOCK) 
			LEFT JOIN InventoryMov IM (NOLOCK) ON (INV.IDInvoice = IM.DocumentID)
		WHERE
			(
			INV.IDPreSale = @PreSaleID
			OR
			INV.IDPreSaleParent = @PreSaleID -- Calcula todos os invoices filhos deste Invoice
			)						
			AND
			IM.InventMovTypeID = 1
		),0)

UPDATE
	dbo.Invoice
SET
	dbo.Invoice.SubTotal =  Round(@SubTotal,2)
WHERE
	dbo.Invoice.IDPreSale = @PreSaleID

IF @@ERROR <> 0 BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

exec sp_PreSale_SubCalcItemDiscount @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTax @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec sp_PreSale_SubCalcAdditionalExpenses @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcTotal', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_DeletePayments
			(
			@PreSaleID	int,
			@IDUser		int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete Lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleta os registros de lancamento



	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	22 Set  2004		Rodrigo Costa		Criação
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

DECLARE @ErrorLevel		int
DECLARE @SysError		int

-- Variáveis para o cursor Cursor_Lanc
DECLARE @IDLancamento		int

SET @ErrorLevel = 0

DECLARE Cursor_Lanc CURSOR FOR
	SELECT
		L.IDLancamento
	FROM
		Fin_Lancamento L (NOLOCK) 
	WHERE
		L.IDPreSale = @PreSaleID
		

OPEN Cursor_Lanc

FETCH NEXT FROM Cursor_Lanc INTO
	@IDLancamento

WHILE @@FETCH_STATUS = 0
BEGIN
	/*----------------------------------------------------------------*/
	/*	Deleta os Lancamentos	*/
	/*---------------------------------------------------------------*/
	EXEC sp_PreSale_DeleteSingleDelayPayment @IDLancamento, @IDUser

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Cursor_Lanc
		DEALLOCATE Cursor_Lanc
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM Cursor_Lanc INTO
		@IDLancamento
END

CLOSE Cursor_Lanc
DEALLOCATE Cursor_Lanc


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DeletePayments', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PreSale_SpecialPriceManager
		(
			@PreSaleID 	int,
			@PercDiscount 	Float,
			@Date 		DateTime,
			@ExemptTax	bit,
			@SellBelowCost	bit = 0
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo PreInventoryMov
		- Atualizo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE PreInventoryMov
		-202  Erro em UPDATE Invoice
		-203  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 	2004		Rodrigo Costa		Gravar error log
	24 Mar	2005		Rodrigo Costa		Novo campo de @ExemptTax para isentar os impostos
	18 Aug	2006		Rodrigo Costa		Criado a opcao para vender com o valor inferior ao custo
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 
BEGIN TRAN

IF (@SellBelowCost = 0)
BEGIN
UPDATE
	PreInventoryMov SET
	PreInventoryMov.Discount =
        				ROUND(
						IsNull (
							(
							SELECT  ( PreInventoryMov.SalePrice * @PercDiscount / 100) * PreInventoryMov.Qty
		                        		FROM 	Model Model (NOLOCK) 
                                        		WHERE   PreInventoryMov.ModelID = Model.IDModel
								AND
                                        			Model.VendorCost <= ( PreInventoryMov.SalePrice - ( PreInventoryMov.SalePrice  * @PercDiscount / 100) )
		                        				), 0) 
					,2)
WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND
       	PreInventoryMov.InventMovTypeID = 1
END
ELSE
BEGIN

UPDATE
	PreInventoryMov SET
	PreInventoryMov.Discount =
        				ROUND(
						IsNull (
							(
							SELECT  ( PreInventoryMov.SalePrice * @PercDiscount / 100) * PreInventoryMov.Qty
		                        		FROM 	Model Model (NOLOCK) 
                                        		WHERE   PreInventoryMov.ModelID = Model.IDModel), 
							0),
				2)
WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND
       	PreInventoryMov.InventMovTypeID = 1

END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

UPDATE
	Invoice
SET
	Invoice.SpecialPriceID = Null,
	Invoice.TaxIsent = @ExemptTax
WHERE
	Invoice.IDPreSale = @PreSaleID 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SpecialPriceManager', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Repair_Do
		(
		@IDRepair	int
		)

AS

/* ---------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em DELETO O INVMOV
		-202  Erro em Send To Vendor
		-203  Erro em Back From Vendor
		-204  Erro em Inserir Notes
		-205  Erro em deletar o Notes


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------------------
	15 June 2001		Rodrigo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values;
	28 Oct	2003		Rodrigo Costa		Criacao do InventoryMov Cursor;
							Chama sp_GetNextCode;
	18 Aug 2004		Rodrigo Costa		Gravar error log;
	19 Dec 2005		Carlos Lima		Correção dos campos do InventoryMov Cursor;
	02 Jun	2006		Rodrigo Costa		Inserir notes no Inventory;
	05 Jun	2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov;
	04 Sep	2006		Maximiliano Muniz	Alterado o CASE que pega o InventMovTypeID para a InventoryMov.
    --------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 		int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @IDPessoa 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			float
DECLARE @IDUser 		int 
DECLARE @CostPrice 		money 
DECLARE @Notes 			varchar(255)
DECLARE @IDInventoryMov		int
DECLARE @AvgCost		money

BEGIN TRAN
---------------------------------------
-- DELETO O INVMOV
DELETE
	Inv_MovComplement
FROM
	InventoryMov (NOLOCK) 
WHERE
	Inv_MovComplement.IDInventoryMov = InventoryMov.IDInventoryMov
	AND
	InventoryMov.IDRepair = @IDRepair

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

DELETE
	InventoryMov
WHERE
	IDRepair = @IDRepair

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

---------------------------------------
--- Send To Vendor

--Declaração do Cursor de InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT
		9,   /* saida por Repair */
		R.IDRepair,
		R.IDRepair,
		R.IDStore,
		R.IDModel,
		1,
		R.SentDate, --Data que foi enviado o Item
		R.Qty,
		R.IDUserSent,
		R.LastCost,
		R.Defect,
		Inv.StoreAvgPrice
	FROM
		Repair R (NOLOCK) 
		INNER JOIN Inventory Inv (NOLOCK) ON ( R.IDStore = Inv.StoreID AND R.IDModel =  Inv.ModelID )
	WHERE
		R.IDRepair = @IDRepair
		AND
		R.SentDate IS NOT NULL
		AND
		R.Tipo = 2 -- so atualiza se for Inventory

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@IDRepair,
	@DocumentID,
	@StoreID,
	@ModelID,
	@IDPessoa,
	@MovDate,
	@Qty,
	@IDUser,
	@CostPrice,
	@Notes,
	@AvgCost
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		IDRepair,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		CostPrice,
		AvgCost
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@AvgCost
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN

		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END


	INSERT Inv_MovComplement 	
		(
		IDInventoryMov,
		IDMovReason,
		Notes
		)
		VALUES
		(
		@IDInventoryMov,
		1,
		@Notes
		)


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@Notes,
		@AvgCost
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

---------------------------------------
--- Back From Vendor
--Declaração do Cursor de InventoryMov
DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT
		(
		CASE TipoRepair
			WHEN 1 THEN 10   /* Exchanged - Back from Repair */
			WHEN 2 THEN 10   /* Fixed - Back from Repair */
			WHEN 3 THEN 16   /* Repair Damage*/
			ELSE 17   /* Vendor Credit - Repair */
		END
		) as RepairType,
		R.IDRepair,
		R.IDRepair,
		R.IDStore,
		R.IDModel,
		1,
		R.ReturnDate, --Data recebida do Vendor		
		R.Qty,
		R.IDUserReturn, --Usuario que enviou
		R.LastCost,
		R.OBSReturn,
		Inv.StoreAvgPrice
	FROM
		Repair R (NOLOCK) 
		INNER JOIN Inventory Inv (NOLOCK) ON ( R.IDStore = Inv.StoreID AND R.IDModel =  Inv.ModelID )
	WHERE
		R.IDRepair = @IDRepair
		AND
		R.ReturnDate IS NOT NULL
		AND
		R.Tipo = 2 -- so atualiza se for Inventory

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@IDRepair,
	@DocumentID,
	@StoreID,
	@ModelID,
	@IDPessoa,
	@MovDate,
	@Qty,
	@IDUser,
	@CostPrice,
	@Notes,
	@AvgCost
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		IDRepair,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		CostPrice,
		AvgCost
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@AvgCost
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	INSERT Inv_MovComplement 	
		(
		IDInventoryMov,
		IDMovReason,
		Notes
		)
		VALUES
		(
		@IDInventoryMov,
		1,
		@Notes
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@Notes,
		@AvgCost
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Repair_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_UnPay
			(
			@PreSaleID	int
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Unmove os PreInventMov para o InventMov
		- Deleta os InventoryMovTax
		- Deleta os preInventory Movement
		- Desquita os lancamentos
		- Update Cash RegisterMovent
		- Transforma a PreSale em Sale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Unmove os PreInventMov para o InventMov
		-202  Erro em Deleta os preInventory Movement
		-203  Erro em Deleta os registros de ligacao
		-204  Erro em Deleta os registros de quitacao
		-205  Erro em Troca o documento dos lancamentos
		-206  Erro em Deleta todos os lançamentos e Quitações
		-207  Erro em Transforma a PreSale em Sale
		-208  Erro em Deleta os InventoryMovTax
		-209  Erro em Alterar comissao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	----------------------------------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		suporte ao novo financeiro e suporte a tratamento de erro
	26 June 2001		Davi Gouveia		Log de Return Values
	28 Oct	2003		Rodrigo Costa		Created Cursor for PreInvMov;
							Call sp_GetNextCode;
	18 Aug	2004		Rodrigo Costa		Gravar error log
	24 Mar	2005		Carlos Lima		Deleta os InventoryMovTax
	30 Mar  2005		Rodrigo Costa		Criar table temp para as quitacoes
	09 Dec	2005		Rodrigo Costa		Alterar comissao
	04 Jan	2007		Maximiliano Muniz	Retirada a transação;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDInvoice 		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 		int 
DECLARE @IDPessoa 		int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			float
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @ComissionID 		int 
DECLARE @UserID 		int 
DECLARE @IDPreInventoryMov	int
DECLARE @IDInventoryMov		int

SET @ErrorLevel = 0

SELECT 	@IDInvoice = IDInvoice
FROM		Invoice
WHERE 	IDPreSale = @PreSaleID

/* -------------------------------------------------------------*/
/*	Unmove os PreInventMov para o InventMov			*/
/* -------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov

DECLARE PreInventoryMov_Cursor CURSOR FOR

	SELECT
		IM.IDInventoryMov,
		IM.InventMovTypeID,
		@PreSaleID,
		IM.IDPessoa,
		IM.StoreID,
		IM.ModelID,
		IM.BarCodeID,
		IM.MovDate,
		IM.Qty,
		IM.CostPrice,
		IM.SalePrice,
		IM.Discount,
		IM.IDUser

	FROM	
		InventoryMov IM (NOLOCK) 
	WHERE   
		IM.DocumentID = @IDInvoice 
		AND
		IM.InventMovTypeID = 1

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@IDInventoryMov,
	@InventMovTypeID,
	@DocumentID,
	@IDPessoa,
	@StoreID,
	@ModelID,
	@BarCodeID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@Discount,
	@UserID
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		DocumentID,
		IDPessoa,
		StoreID,
		ModelID,
		BarCodeID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		UserID
		)
	VALUES 
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,		@SalePrice,
		@Discount,
		@UserID	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	--Atualizar os SaleItemCommisison
	UPDATE
		SaleItemCommission
	SET
		IDPreInventoryMov = @IDPreInventoryMov,	
		IDInventoryMov = Null
	WHERE
		IDInventoryMov = @IDInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -209
		GOTO ERRO
	END


	FETCH NEXT FROM PreInventoryMov_Cursor INTO	
		@IDInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@UserID
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	       Deleta os InventoryMovTax			  */
/*----------------------------------------------------------------*/


DELETE
	InventoryMovTax
FROM
	InventoryMov (NOLOCK) 
WHERE
	InventoryMov.IDInventoryMov = InventoryMovTax.IDInventoryMov 
	AND
 	InventoryMov.DocumentID = @IDInvoice
	AND
	InventoryMov.InventMovTypeID = 1 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	       Deleta os preInventory Movement			  */
/*----------------------------------------------------------------*/

DELETE 
	InventoryMov
WHERE
 	InventoryMov.DocumentID = @IDInvoice
	AND
	InventoryMov.InventMovTypeID = 1 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	       Desquita os lancamentos         			  */
/*----------------------------------------------------------------*/

/*----------- Cria tabela com as quitacoes a serem deletadas ------------ */
SELECT
	Q.IDQuitacao
INTO
	#sp_PreSale_Remove_QuitToDelete
FROM
	Fin_Quitacao Q (NOLOCK) 
	JOIN Fin_LancQuit LQ (NOLOCK) ON (LQ.IDQuitacao = Q.IDQuitacao)
	JOIN Fin_Lancamento L (NOLOCK) ON (LQ.IDLancamento = L.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID


/*---------------- Deleta os registros de ligacao -------------------- */
DELETE
	LQ
FROM
	Fin_LancQuit LQ (NOLOCK) 
	JOIN
	Fin_Lancamento L (NOLOCK) ON (L.IDLancamento = LQ.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*--------------- Deleta os registros de quitacao -----------------*/
DELETE
	Q
FROM
	Fin_Quitacao Q (NOLOCK) 
	JOIN #sp_PreSale_Remove_QuitToDelete QTD ON (QTD.IDQuitacao = Q.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*---------------- Troca o documento dos lancamentos --------------------*/
UPDATE
	Fin_Lancamento
SET
	NumDocumento = Convert(varchar(50), @PreSaleID)
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deleta todos os lançamentos e Quitações                                                                                */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

EXEC sp_PreSale_DeletePayments @PreSaleID, 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -206
            GOTO ERRO
END



/*----------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  */
/*----------------------------------------------------------------*/
UPDATE dbo.Invoice
	SET	dbo.Invoice.IDInvoice    = null,
		dbo.Invoice.InvoiceDate  = null,
		dbo.Invoice.CashReceived = null,
		dbo.Invoice.IDStore	 = null,
		dbo.Invoice.CashRegMovID = null
	WHERE
	 	dbo.Invoice.IDPreSale 	= @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PreSale_SubRemoveItem
	(
	@PreInventMovID int
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete on Pre Inventory Movement Items Packages
		- Delete on Pre Inventory Movement

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Delete
		-202  Erro no Delete PackItems
		-203  Erro no Delete CustomerCredit
		-204  Erro no Delete CustomerCredit do PackModel
		-205  Erro em atulaizar qtyExchanged no Pre
		-206  Erro em atulaizar qtyExchanged no Inv
		-207  Erro no Delete SaleItemCommission
		-208  Erro ao deletar o comissionamento dos itens de Kit
		-209  Erro ao deletar Inv_MovPrice
		-210  Erro ao deletar Inv_MovPrice
		-211  Erro ao deleter Pet_PetSale/Pet_MicrochipSale

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	25 May	2004		Rodrigo Costa		Deletar os PackModels;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	01 Dec	2004		Rodrigo Costa		Deletar os Credits for Customer;
	28 Nov	2005		Leonardo Riego		Deletar as linhas da SaleItemCommission;
	16 Jun	2006		Rodrigo Costa		Deletar as linhas do SaleItemCommission do item de Kit;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	20 Jul	2007		Maximiliano Muniz	Deletar a linha da Inv_MovPrice;
	08 Aug	2007		Maximiliano Muniz	Deletar a linha da Inv_MovDocument;
	16 Aug	2007		Rodrigo Costa		Deleter a linha da Pet_PetSale/Pet_MicrochipSale;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDPreInvMovExchange	int
DECLARE @Qty			float

SET @ErrorLevel = 0

/*--------------------------------------------------------------*/
/*	Delete on os Customers Credit do PreInventoryMovPack	*/
/*--------------------------------------------------------------*/
UPDATE
	CustomerCredit
SET
	IsUsed = 1
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.IDParentPack = @PreInventMovID
	AND
	CustomerCredit.IDPreInventoryMov = PIM.IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Deletar as quantidades para troca	*/
/*----------------------------------------------*/
SELECT
	@IDPreInvMovExchange = IDPreInvMovExchange,
	@Qty = Qty
FROM
	PreInventoryMov (NOLOCK) 
WHERE
	IDPreInventoryMov = @PreInventMovID

IF (@IDPreInvMovExchange IS NOT Null)
BEGIN
	--Pre Inv Mov
	UPDATE
		PreInventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) - ABS(@Qty)
	WHERE 
		IDPreInventoryMov = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
	
	-- Inv Mov
	UPDATE
		InventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) - ABS(@Qty)
	WHERE 
		PreInventoryMovID = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
END

/*----------------------------------------------*/
/*	Delete os Commissions dos itens de Kit	*/
/*----------------------------------------------*/
DELETE
	SaleItemCommission
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN SaleItemCommission SIC (NOLOCK) ON (PIM.IDPreInventoryMov = SIC.IDPreInventoryMov)
WHERE
	PIM.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*------------------------------------------------------*/
/*	Delete os Commissions for SaleItemCommission	*/
/*------------------------------------------------------*/
DELETE
	SaleItemCommission
WHERE
	SaleItemCommission.IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Pre Inventory Movement Pack	*/
/*----------------------------------------------*/
DELETE
	PreInventoryMov
WHERE
	PreInventoryMov.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------*/
/*	Delete os Customers Credit do PreInventoryMov	*/
/*------------------------------------------------------*/
UPDATE
	CustomerCredit
SET
	IsUsed = 1
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Inv_MovPrice			*/
/*----------------------------------------------*/
DELETE
	Inv_MovPrice
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Inv_MovDocument		*/
/*----------------------------------------------*/
DELETE
	Inv_MovDocument
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Pet_PetSale/Pet_MicrochipSale */
/*----------------------------------------------*/
DELETE
	Pet_MicrochipSale
WHERE
	IDPetSale IN 
		(SELECT
			IDPetSale
		FROM
			Pet_PetSale (NOLOCK) 
		WHERE
			IDPreInventoryMov = @PreInventMovID)
	OR
	IDPreInventoryMov = @PreInventMovID


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

DELETE
	Pet_PetSale
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Pre Inventory Movement	*/
/*----------------------------------------------*/
DELETE
	PreInventoryMov
WHERE
	PreInventoryMov.IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(110)
	DECLARE @Params varchar(100)
	SET @Params = ' [ @PreInventMovID = ' + CAST(@PreInventMovID AS VARCHAR) + ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params

	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubRemoveItem', @ErrorLevelStr
	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PO_Remove
		(
		@IDPO     		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Removo todoas as relações entre PO e request
		- Removo o Item
		- Removo o PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Removo todoas as relações entre PO e request
		-203  Erro em Removo o Item
		-204  Erro em Removo o PO


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	05 fev 2001		Rodrigo Costa		Nao deleta fisicamente o PO - Set visible false
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

------------------------------------------------------------------------------------------------------
-- Removo todoas as relações entre PO e request

DELETE
	POIR
FROM
	POItemRequest POIR (NOLOCK) 
	JOIN 
	PreInventoryMov PIM (NOLOCK) ON (POIR.IDPreInventoryMov = PIM.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @IDPO
	AND
	PIM.InventMovTypeID = 2 -- Compra

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


--------------------------------------------------------------------------------------------------------
-- Removo o Item

DELETE
	PIM
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.DocumentID = @IDPO
	AND
	PIM.InventMovTypeID = 2 -- Compra

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

--------------------------------------------------------------------------------------------------------
-- Removo o PO

DELETE
	PO
WHERE
	PO.IDPO = @IDPO


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

--------------------------------------------------------------------------------------------------------
-- Removo o PO - Rodrigo
/*
UPDATE
	PO
SET
	Aberto = 0
WHERE
	PO.IDPO = @IDPO

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END
*/


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Sub_AtuModelName
	(
	@IDModelMaster	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Atualiza todos os sub models de uma grade a partir da seguinte formula

		Model = Model + ColorCode + SizeCode
		Description = Description + Color + Size


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update

	LOG DE MODIFICAÇÕES

		Data			Programador		Modificação
		--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
		29 novembro 2000	Eduardo Costa		Criação;
		25 June 2001		Davi Gouveia		Log de Return Values
		18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ColorSeparator  	VarChar(10)
DECLARE @SizeSeparator  	VarChar(10)
DECLARE @Trailing  		VarChar(10)
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ColorSeparator = '-'
SET @SizeSeparator = '-'
SET @Trailing = '...'


UPDATE
	M
SET
	M.Model =
		CASE WHEN Len(MM.[Model] + IsNull(@ColorSeparator + C.CodColor, '') + IsNull(@SizeSeparator + S.CodSize, '')) <= 30 THEN
			MM.Model + IsNull(@ColorSeparator + C.CodColor, '') + IsNull(@SizeSeparator + S.CodSize, '')
		ELSE
			Left(M.Model, 30 - Len(@Trailing + IsNull(@ColorSeparator + C.CodColor, '') + IsNull(@SizeSeparator + S.CodSize, '')))  + @Trailing + IsNull(@ColorSeparator + C.CodColor, '') + IsNull(@SizeSeparator + S.CodSize, '')
		END,
	M.[Description] =
		CASE WHEN Len(MM.[Description] + IsNull(@ColorSeparator + C.Color, '') + IsNull(@SizeSeparator + S.SizeName, '')) <= 50 THEN
			MM.[Description] + IsNull(@ColorSeparator + C.Color, '') + IsNull(@SizeSeparator + S.SizeName, '')
		ELSE
			Left(MM.[Description], 50 - Len(@Trailing + IsNull(@ColorSeparator + C.Color, '') + IsNull(@SizeSeparator + S.SizeName, '')))  + @Trailing + IsNull(@ColorSeparator + C.Color, '') + IsNull(@SizeSeparator + S.SizeName, '')
		END,
	M.GroupID = MM.GroupID,
	M.IDFabricante = MM.IDFabricante,
	M.IDModelGroup = MM.IDModelGroup,
	M.IDModelSubGroup = MM.IDModelSubGroup,
	M.IDUnidade = MM.IDUnidade
FROM
	Model MM (NOLOCK)
	JOIN 
	Model M (NOLOCK) ON (M.IDModelParent = MM.IDModel)
	LEFT OUTER JOIN 
	InvColor C (NOLOCK) ON (M.IDColor = C.IDColor)
	LEFT OUTER JOIN 
	InvSize S (NOLOCK) ON (M.IDSize = S.IDSize)
WHERE
	MM.IDModel = @IDModelMaster

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Sub_AtuModelName', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inv_CalcModelStoreBalance (@ProcessDate datetime)
AS
/* -------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
	1 - Deletar todos os saldos a partir da data a processar
	2 - Pegar a ultima linha de saldo imediatamente antes da data a processar
	3 - Fazer laço com as movimentações a partir da data a processar
	4 - Atualizar quantidade e custo médio

	LOG DE MODIFICAÇÕES

	Data			Programador					Modificação
	----------------------- -----------------------------------------------	--------------------------------------------------------
	14 May	2007		Maximiliano Muniz				Criação
    	-------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDStore		int
DECLARE @IDModel		int
DECLARE @MovQty			float
DECLARE @ModelQty		float
DECLARE @StoreQty		float
DECLARE @MovCost		money
DECLARE @AvgCostOut		money
DECLARE @ModelBalanceTotal	money
DECLARE @StoreBalanceTotal	money
DECLARE @LastAvgCost		money
DECLARE @NewAvgCost		money
DECLARE @HasMov			int

DECLARE MODEL_CUR CURSOR FOR 
SELECT
	M.IDModel
FROM
	Model M
ORDER BY
	M.IDModel

OPEN MODEL_CUR

FETCH NEXT FROM MODEL_CUR INTO
	@IDModel

WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE STORE_CUR CURSOR FOR 
	SELECT
		S.IDStore
	FROM
		Store S
	WHERE
		S.System = 0
		AND S.Hidden = 0
		AND S.Desativado = 0
	ORDER BY
		S.IDStore
	
	OPEN STORE_CUR
	
	FETCH NEXT FROM STORE_CUR INTO
		@IDStore

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Deleto os saldos a partir da data de processamento
		DELETE Inv_ModelStoreBalance WHERE IDStore = @IDStore AND IDModel = @IDModel AND BalanceDate >= @ProcessDate

		SELECT @HasMov = COUNT(*)
		FROM InventoryMov IM (NOLOCK)
		WHERE IM.StoreID = @IDStore AND IM.ModelID = @IDModel AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate AND IM.InventMovTypeID IN (1, 2, 3, 4, 5, 7, 8, 11, 12, 19, 21, 22)

		IF @HasMov > 0
		BEGIN
			SET @ModelQty = 0
			SET @AvgCostOut = 0
			SET @ModelBalanceTotal = 0

			INSERT INTO Inv_ModelStoreBalance (IDStore, IDModel, BalanceDate, Qty, AvgCostOut, BalanceTotal)
			VALUES (@IDStore, @IDModel, @ProcessDate, @ModelQty, @AvgCostOut, @ModelBalanceTotal)

			-------------------------------------------------------------------------------------------------
			-- Pego os valores de quantidade e saldo do modelo, da última data antes da data de processamento
			SELECT
				@ModelQty = MB.Qty,
				@AvgCostOut = MB.AvgCostOut,
				@ModelBalanceTotal = MB.BalanceTotal
			FROM
				Inv_ModelStoreBalance MB (NOLOCK)
			WHERE
				MB.IDModel = @IDModel
				AND MB.BalanceDate = (	SELECT MAX(MB.BalanceDate)
							FROM Inv_ModelStoreBalance MB (NOLOCK) 
							WHERE MB.IDStore = @IDStore AND MB.IDModel = @IDModel AND MB.BalanceDate < @ProcessDate
							GROUP BY MB.IDModel)

			----------------------------------------------------------------------
			-- Calculo o custo médio da última data antes da data de processamento
			IF @ModelQty > 0
				SET @LastAvgCost = @ModelBalanceTotal / @ModelQty
			ELSE
				SET @LastAvgCost = 0

			---------------------------------------------------------------------------------------------------
			-- Pego o total de quantidades de entrada, sem compras, transferência e importação. Esta quantidade
			-- será adicionada à quantidade total de estoque, sem afetar o custo médio.
			SET @MovQty = 0
			SELECT
				@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))
			FROM
				InventoryMov IM (NOLOCK) 
				JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
			WHERE
				IM.StoreID = @IDStore
				AND IM.ModelID = @IDModel
				AND IMT.UpdateOnHand = 1
				AND (IMT.IDInventMovType in (4, 11, 19, 21) OR (IMT.IDInventMovType = 2 AND IM.Qty < 0))
				AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate

			GROUP BY
				IM.ModelID

			-----------------------------------------------------
			-- Calculo a nova quantidade e valor total do estoque
			SET @ModelQty = IsNull(@ModelQty, 0) + IsNull(@MovQty, 0)
			IF @ModelQty > 0
			BEGIN
				SET @ModelBalanceTotal = @ModelBalanceTotal + (IsNull(@MovQty, 0) * @LastAvgCost)
				SET @AvgCostOut = @ModelBalanceTotal / @ModelQty
			END
			ELSE
				SET @ModelBalanceTotal = 0

			----------------------------------------------------------------------
			-- Pego a quantidade e o custo total comprado, transferido e importado
			SET @MovQty = 0
			SET @MovCost = 0
			SELECT
				@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0)),
				@MovCost = SUM(IsNull(IM.CostPrice, 0) * ((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0)))
			FROM
				InventoryMov IM (NOLOCK) 
				JOIN InventoryMovType IMT (NOLOCK)  ON (IM.InventMovTypeID = IMT.IDInventMovType)
			WHERE
				IM.StoreID = @IDStore
				AND IM.ModelID = @IDModel
				AND IMT.UpdateOnHand = 1
				AND (IMT.IDInventMovType in (2, 5, 8) AND IM.Qty > 0)
				AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
			GROUP BY
				IM.ModelID

			---------------------------------------------------------------------------------------------------
			-- Calculo a nova quantidade e valor total do estoque. Se a quantidade em estoque antes das compras
			-- for negativa, deve ser encontrado o custo médio das compras para achar o valor total de estoque
			-- com a diferença entre a quantidade anterior e a comprada.
			IF (@ModelQty + @MovQty) > 0
			BEGIN
				IF @ModelQty < 0
					SET @ModelBalanceTotal = (@MovCost / @MovQty) * (@ModelQty + @MovQty)
				ELSE
					SET @ModelBalanceTotal = @ModelBalanceTotal + @MovCost
	
				SET @AvgCostOut = @ModelBalanceTotal / (@ModelQty + @MovQty)
				SET @NewAvgCost = @ModelBalanceTotal / (@ModelQty + @MovQty)
			END
			ELSE
			BEGIN
				SET @ModelBalanceTotal = 0
				SET @NewAvgCost = 0
			END
	
			SET @ModelQty = IsNull(@ModelQty, 0) + IsNull(@MovQty, 0)

			------------------------------------------------------------------------------------------------
			-- Atualizo o saldo da data a processar calculando com base nas movimentações de entrada do dia.
			UPDATE
				Inv_ModelStoreBalance
			SET
				Qty = @ModelQty,
				AvgCostOut = @AvgCostOut,
				BalanceTotal = @ModelBalanceTotal
			WHERE
				IDStore = @IDStore
				AND IDModel = @IDModel
				AND BalanceDate = @ProcessDate

			-------------------------------------------------------------------------------------------------------
			-- Pego o total de quantidades de saída. Esta quantidade será removida da quantidade total de estoque,
			-- sem afetar o custo médio, desde que não zere a quantidade.
			SET @MovQty = 0
			SELECT
				@NewAvgCost = SUM((CASE WHEN IsNull(IM.Qty, 0) > 0 THEN (CASE WHEN @NewAvgCost > 0 THEN @NewAvgCost ELSE @AvgCostOut END) ELSE ISNULL(EXAVG.AvgCostOut, @AvgCostOut) END) * ((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))),
				@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))
			FROM
				InventoryMov IM (NOLOCK) 
				JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
				LEFT OUTER JOIN (SELECT ModelID, PreInventoryMovID, CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103) MovDate FROM InventoryMov (NOLOCK) WHERE StoreID = @IDStore AND ModelID = @IDModel) EX ON (IM.ModelID = EX.ModelID AND IM.IDPreInvMovExchange = EX.PreInventoryMovID)
				LEFT OUTER JOIN (SELECT IDModel, BalanceDate, AvgCostOut FROM Inv_ModelStoreBalance (NOLOCK) WHERE IDStore = @IDStore AND IDModel = @IDModel) EXAVG ON (IM.ModelID = EXAVG.IDModel AND CONVERT(smalldatetime, CONVERT(varchar, EX.MovDate, 103), 103) = EXAVG.BalanceDate)
			WHERE
				IM.StoreID = @IDStore
				AND IM.ModelID = @IDModel
				AND IMT.UpdateOnHand = 0
				AND IMT.IDInventMovType in (1, 3, 7, 12, 22)
				AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
			GROUP BY
				IM.ModelID

			IF @MovQty <> 0
			BEGIN
				SET @ModelQty = @ModelQty + @MovQty
				IF @ModelQty > 0
						SET @ModelBalanceTotal = @ModelBalanceTotal + @NewAvgCost
				ELSE
					SET @ModelBalanceTotal = 0
	
				UPDATE Inv_ModelStoreBalance
				SET Qty = @ModelQty, AvgCostOut = (CASE WHEN @ModelQty > 0 THEN @ModelBalanceTotal / @ModelQty ELSE @AvgCostOut END), BalanceTotal = @ModelBalanceTotal
				WHERE IDStore = @IDStore AND IDModel = @IDModel AND BalanceDate = @ProcessDate
			END
		END

		FETCH NEXT FROM STORE_CUR INTO
			@IDStore
	END

	CLOSE STORE_CUR
	DEALLOCATE STORE_CUR

	FETCH NEXT FROM MODEL_CUR INTO
		@IDModel
END

CLOSE MODEL_CUR
DEALLOCATE MODEL_CUR
GO

CREATE PROCEDURE sp_Inv_CalcModelBalance (@ProcessDate datetime)
AS
/* -------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
	1 - Deletar todos os saldos a partir da data a processar
	2 - Pegar a ultima linha de saldo imediatamente antes da data a processar
	3 - Fazer laço com as movimentações a partir da data a processar
	4 - Atualizar quantidade e custo médio

	LOG DE MODIFICAÇÕES

	Data			Programador					Modificação
	----------------------- -----------------------------------------------	--------------------------------------------------------
	22 Sep	2006		Carlos Lima, Leonardo Riego e Max Muniz		Criação
    	-------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDModel		int
DECLARE @MovQty			float
DECLARE @ModelQty		float
DECLARE @StoreQty		float
DECLARE @MovCost		money
DECLARE @AvgCostOut		money
DECLARE @ModelBalanceTotal	money
DECLARE @StoreBalanceTotal	money
DECLARE @LastAvgCost		money
DECLARE @NewAvgCost		money
DECLARE @HasMov			integer

DECLARE MODEL_CUR CURSOR FOR 
SELECT
	M.IDModel
FROM
	Model M (NOLOCK)
ORDER BY
	M.IDModel

OPEN MODEL_CUR

FETCH NEXT FROM MODEL_CUR INTO
	@IDModel

WHILE @@FETCH_STATUS = 0
BEGIN
	-- Deleto os saldos a partir da data de processamento
	DELETE Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate >= @ProcessDate


	SELECT @HasMov = COUNT(*)
	FROM InventoryMov IM (NOLOCK)
	WHERE IM.ModelID = @IDModel AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate AND IM.InventMovTypeID IN (1, 2, 3, 4, 5, 11, 12, 19, 21, 22)


	IF @HasMov > 0
	BEGIN
		SET @ModelQty = 0
		SET @AvgCostOut = 0
		SET @ModelBalanceTotal = 0

		INSERT INTO Inv_ModelBalance (IDModel, BalanceDate, Qty, AvgCostOut, BalanceTotal)
		VALUES (@IDModel, @ProcessDate, @ModelQty, @AvgCostOut, @ModelBalanceTotal)


		-------------------------------------------------------------------------------------------------
		-- Pego os valores de quantidade e saldo do modelo, da última data antes da data de processamento
		SELECT
			@ModelQty = MB.Qty,
			@AvgCostOut = MB.AvgCostOut,
			@ModelBalanceTotal = MB.BalanceTotal
		FROM
			Inv_ModelBalance MB (NOLOCK)
		WHERE
			MB.IDModel = @IDModel
			AND MB.BalanceDate = (	SELECT MAX(MB.BalanceDate)
						FROM Inv_ModelBalance MB
						WHERE MB.IDModel = @IDModel AND MB.BalanceDate < @ProcessDate
						GROUP BY MB.IDModel)


		----------------------------------------------------------------------
		-- Calculo o custo médio da última data antes da data de processamento
		IF @ModelQty > 0
			SET @LastAvgCost = @ModelBalanceTotal / @ModelQty
		ELSE
			SET @LastAvgCost = 0


		-------------------------------------------------------------------------------------------------------
		-- Pego o total de quantidades de entrada, sem compras e importação. Esta quantidade será adicionada à
		-- quantidade total de estoque, sem afetar o custo médio.
		SET @MovQty = 0
		SELECT
			@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))
		FROM
			InventoryMov IM (NOLOCK)
			JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
		WHERE
			IM.ModelID = @IDModel
			AND IMT.UpdateOnHand = 1
			AND (IMT.IDInventMovType in (4, 11, 19, 21) OR (IMT.IDInventMovType = 2 AND IM.Qty < 0))
			AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
		GROUP BY
			IM.ModelID


		-----------------------------------------------------
		-- Calculo a nova quantidade e valor total do estoque
		SET @ModelQty = IsNull(@ModelQty, 0) + IsNull(@MovQty, 0)
		IF @ModelQty > 0
		BEGIN
			SET @ModelBalanceTotal = @ModelBalanceTotal + (IsNull(@MovQty, 0) * @LastAvgCost)
			SET @AvgCostOut = @ModelBalanceTotal / @ModelQty
		END
		ELSE
			SET @ModelBalanceTotal = 0


		---------------------------------------------------------
		-- Pego a quantidade e o custo total comprado e importado
		SET @MovQty = 0
		SET @MovCost = 0
		SELECT
			@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0)),
			@MovCost = SUM(IsNull(IM.CostPrice, 0) * ((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0)))
		FROM
			InventoryMov IM (NOLOCK)
			JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
		WHERE
			IM.ModelID = @IDModel
			AND IMT.UpdateOnHand = 1
			AND (IMT.IDInventMovType in (2, 5) AND IM.Qty > 0)
			AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
		GROUP BY
			IM.ModelID


		---------------------------------------------------------------------------------------------------
		-- Calculo a nova quantidade e valor total do estoque. Se a quantidade em estoque antes das compras
		-- for negativa, deve ser encontrado o custo médio das compras para achar o valor total de estoque
		-- com a diferença entre a quantidade anterior e a comprada.
		IF (@ModelQty + @MovQty) > 0
		BEGIN
			IF @ModelQty < 0
				SET @ModelBalanceTotal = (@MovCost / @MovQty) * (@ModelQty + @MovQty)
			ELSE
				SET @ModelBalanceTotal = @ModelBalanceTotal + @MovCost

			SET @AvgCostOut = @ModelBalanceTotal / (@ModelQty + @MovQty)
			SET @NewAvgCost = @ModelBalanceTotal / (@ModelQty + @MovQty)
		END
		ELSE
		BEGIN
			SET @ModelBalanceTotal = 0
			SET @NewAvgCost = 0
		END

		SET @ModelQty = IsNull(@ModelQty, 0) + IsNull(@MovQty, 0)


		------------------------------------------------------------------------------------------------
		-- Atualizo o saldo da data a processar calculando com base nas movimentações de entrada do dia.
		UPDATE
			Inv_ModelBalance
		SET
			Qty = @ModelQty,
			AvgCostOut = @AvgCostOut,
			BalanceTotal = @ModelBalanceTotal
		WHERE
			IDModel = @IDModel
			AND BalanceDate = @ProcessDate


		-------------------------------------------------------------------------------------------------------
		-- Pego o total de quantidades de saída. Esta quantidade será removida da quantidade total de estoque,
		-- sem afetar o custo médio, desde que não zere a quantidade.
		SET @MovQty = 0
		SELECT
			@NewAvgCost = SUM((CASE WHEN IsNull(IM.Qty, 0) > 0 THEN (CASE WHEN @NewAvgCost > 0 THEN @NewAvgCost ELSE @AvgCostOut END) ELSE ISNULL(EXAVG.AvgCostOut, @AvgCostOut) END) * ((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))),
			@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))
		FROM
			InventoryMov IM (NOLOCK)
			JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
			LEFT OUTER JOIN (SELECT ModelID, PreInventoryMovID, CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103) MovDate FROM InventoryMov  (NOLOCK) WHERE ModelID = @IDModel) EX ON (IM.ModelID = EX.ModelID AND IM.IDPreInvMovExchange = EX.PreInventoryMovID)
			LEFT OUTER JOIN (SELECT IDModel, BalanceDate, AvgCostOut FROM Inv_ModelBalance (NOLOCK) WHERE IDModel = @IDModel) EXAVG ON (IM.ModelID = EXAVG.IDModel AND CONVERT(smalldatetime, CONVERT(varchar, EX.MovDate, 103), 103) = EXAVG.BalanceDate)
		WHERE
			IM.ModelID = @IDModel
			AND IMT.UpdateOnHand = 0
			AND IMT.IDInventMovType in (1, 3, 12, 22)
			AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
		GROUP BY
			IM.ModelID

		IF @MovQty <> 0
		BEGIN
			SET @ModelQty = @ModelQty + @MovQty
			IF @ModelQty > 0
					SET @ModelBalanceTotal = @ModelBalanceTotal + @NewAvgCost
			ELSE
				SET @ModelBalanceTotal = 0

			UPDATE Inv_ModelBalance
			SET Qty = @ModelQty, AvgCostOut = (CASE WHEN @ModelQty > 0 THEN @ModelBalanceTotal / @ModelQty ELSE @AvgCostOut END), BalanceTotal = @ModelBalanceTotal
			WHERE IDModel = @IDModel AND BalanceDate = @ProcessDate
		END
	END

	FETCH NEXT FROM MODEL_CUR INTO
		@IDModel
END

CLOSE MODEL_CUR
DEALLOCATE MODEL_CUR
GO

CREATE PROCEDURE sp_Commission_CalcDivida
			(
			@IDPessoa	int,
			@Date		datetime,
			@Divida	money 	output
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula Divida


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT
	@Divida = IsNull(
	(
	SELECT
		SUM( L.ValorNominal - L.TotalQuitado )
	FROM
		Fin_Lancamento L (NOLOCK)
	WHERE
		L.IDPessoa = @IDPessoa
		AND
		L.Situacao in (1,5)  -- 1=Aberto, 5=ParteQuitado
		AND
		L.Pagando = 0
		AND
		L.DataVencimento >= @Date
	), 0)
GO

CREATE PROCEDURE sp_PO_AtuPOTotal
		(
		@IDPO     		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Cancelando

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	22 Nov 2005		Carlos Lima		Atualizar o custo corretamente  para recebimento maior que o esperado
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

UPDATE
	PO
SET
	PO.SubTotal = IsNull(
		(
		SELECT
			SUM
			(
				CASE 
					WHEN PIM.Qty >= 0 THEN
						CASE 
							WHEN PIM.Qty >= PIM.QtyRealMov THEN
								(PIM.Qty - PIM.QtyRealMov) * PIM.CostPrice
							ELSE
								(PIM.Qty) * PIM.CostPrice
					END

					ELSE
						(PIM.Qty - PIM.QtyRealMov) * PIM.CostPrice
				END
			)
		FROM
			PreInventoryMov PIM (NOLOCK) 
			JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel) 
		WHERE
			PIM.InventMovTypeID = 2      -- Compra
			AND
			PIM.DocumentID = @IDPO
			AND
			M.ModelType IN ('R', 'S')
		),0)
FROM
	PO
WHERE
	PO.IDPO = @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_AtuPOTotal', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_CashRegister_Quita_Invoice
	(
	@IDCashRegMov	int,
	@IDUsuario	int,
	@Date		Datetime
	) AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere os registros de quitacao, para os invoices
		- Insiro os Account Payable com as taxas de admim
		- Insere as ligacoes entre Lancamento e Quitacao
		- Upadate em Fin_Lancamento (CashRegMovClosed)

	TABELA DE ERROS PARA RETURN_VALUE

		 000	Ok
		-201	Erro em Insere os registros de quitacao, para os invoices
		-202	Erro em Insiro os Account Payable com as taxas de admim
		-203	Erro em Insere as ligacoes entre Lancamento e Quitacao
		-204	Erro Upadate em Fin_Lancamento (CashRegMovClosed)

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	----------------------- -----------------------------------------------------------------
	15 May	2000		Rodrigo Costa		Criacao;
	22 June	2001		Davi Gouveia		Log de Return Values;
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode;
							Criado cursor para Fin_Quitacao e Fin_Lancamento;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	18 Jan	2005		Carlos Lima		Gravar em que caixa foi fechado;
	16 May	2006		Maximiliano Muniz	Filtro pelo campo "PayOnCashRegClose" na carga dos cursores;
							O campo "PrazoRecebimento" agora é pego do MeioPag direto.
	-------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/* ------------------------------------------------------------------------------------------------------------ */
/*		Quita os lancamentos										*/
/*------------------------------------------------------------------------------------------------------------- */

-- Insere os registros de quitacao, para os invoices
-- Alterações de sp_Sis_GetNextCode
SET NOCOUNT ON
-- Variáveis de Fin_Quitacao
DECLARE @IDQuitacao		int
DECLARE @Pagando		TBit
DECLARE @DataQuitacao		smalldatetime
DECLARE @ValorQuitacao		TValor
DECLARE @IDQuitacaoMeio		int
DECLARE @IDUsuarioQuitacao	int
DECLARE @ValorJuros		TValor
DECLARE @NumeroMeioQuit		TCodigoGeral
DECLARE @IDContaCorrente	int
DECLARE @SparrowInt		int

--Variáveis de Fin_Lancamento
DECLARE @IDLancamento			int
DECLARE @DataVencimento			smalldatetime
DECLARE @DataLancamento			smalldatetime
DECLARE @ValorNominal			TValor
DECLARE @IDQuitacaoMeioPrevisto		int
DECLARE @IDUsuarioLancamento		int
DECLARE @IDContaCorrentePrevista	int
DECLARE @IDEmpresa 			int
DECLARE @IDPessoa			int
DECLARE @IDPessoaTipo			int
DECLARE @IDLancamentoTipo		int

--Declaração do Cursor de Fin_Quitacao
DECLARE Fin_Quitacao_Cursor CURSOR FOR 
	(SELECT
		0,
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		0, -- A LancQuit ira atualizar corretamente este valor
		MP.IDMeioPagBatch,
		@IDUsuario,
		0,
		Convert(Varchar(20), L.IDCashRegMov),
		MPTS.IDContaCorrente,
		L.IDCashRegMov
	FROM
		Fin_Lancamento L (NOLOCK)
		JOIN
		Invoice I (NOLOCK) ON ( I.IDPresale = L.IDPreSale )
		JOIN 
		MeioPag MP (NOLOCK) ON ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN 
		MeioPag MPB (NOLOCK) ON ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN 
		MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
	WHERE
		L.IDCashRegMov = @IDCashRegMov
		AND
		L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista
		AND
		MP.IDMeioPagBatch IS NOT NULL
		AND
		MP.PayOnCashRegClose = 1
	GROUP BY
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		MP.IDMeioPagBatch,
		Convert(Varchar(20), L.IDCashRegMov),
		MPTS.IDContaCorrente,
		L.IDCashRegMov
	)
-- Abertura do Cursor
OPEN Fin_Quitacao_Cursor
-- Inicialização do Cursor
FETCH NEXT FROM Fin_Quitacao_Cursor INTO  
		@Pagando,
		@DataQuitacao,
		@ValorQuitacao,
		@IDQuitacaoMeio,
		@IDUsuarioQuitacao ,
		@ValorJuros ,
		@NumeroMeioQuit,
		@IDContaCorrente,
		@SparrowInt
-- Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
/******************************************************************************
	Obtenho o @IDQuitacao
*******************************************************************************/
	EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT

	INSERT
		Fin_Quitacao
		(
		IDQuitacao,
		Pagando,
		DataQuitacao,
		ValorQuitacao,
		IDQuitacaoMeio,
		IDUsuarioQuitacao,
		ValorJuros,
		NumeroMeioQuit,
		IDContaCorrente,
		SparrowInt
 		)
	VALUES 
		(	
		@IDQuitacao, 
		@Pagando,
		@DataQuitacao,
		@ValorQuitacao,
		@IDQuitacaoMeio,
		@IDUsuarioQuitacao ,
		@ValorJuros ,
		@NumeroMeioQuit,
		@IDContaCorrente,
		@SparrowInt )
	-- leitura do próximo
	FETCH NEXT FROM Fin_Quitacao_Cursor INTO 

		@Pagando,
		@DataQuitacao,
		@ValorQuitacao,
		@IDQuitacaoMeio,
		@IDUsuarioQuitacao ,
		@ValorJuros ,
		@NumeroMeioQuit,
		@IDContaCorrente,
		@SparrowInt
END
-- fechamento do cursor
CLOSE Fin_Quitacao_Cursor
-- destruição do cursor
DEALLOCATE Fin_Quitacao_Cursor
SET NOCOUNT OFF

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END
/******************************************************************************
		Insiro os Account Payable com as taxas de admim
*******************************************************************************/
--Declaração do Cursor de Fin_Quitacao
DECLARE Fin_Lancamento_Cursor CURSOR FOR 
	SELECT	
		1,
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		@Date,
		SUM( L.ValorNominal * (IsNull(MPB.TaxaAdmin, 0)/100) ),
		MP.IDMeioPag,
		@IDUsuario,
		MPTS.IDContaCorrente,
		CC.IDEmpresa,
		MPB.IDPessoa,
		P.IDTipoPessoa,
		MPB.IDLancamentoTipo,
		L.IDCashRegMov
	FROM
		Fin_Lancamento L (NOLOCK)
		JOIN 
		Invoice I (NOLOCK) ON ( I.IDPresale = L.IDPreSale )
		JOIN 
		MeioPag MP (NOLOCK) ON ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN 
		MeioPag MPB (NOLOCK) ON ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN 
		MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
		JOIN 
		Fin_ContaCorrente CC (NOLOCK) ON (MPTS.IDContaCorrente = CC.IDContaCorrente)
		JOIN 
		Pessoa P (NOLOCK) ON (MPB.IDPessoa = P.IDPessoa)
	WHERE
		MPB.AutoDiscountFee = 1
		AND
		L.IDCashRegMov = @IDCashRegMov
		AND
		L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista
		AND
		MPB.IDLancamentoTipo IS NOT NULL
		AND
		MPB.IDPessoa IS NOT NULL
		AND
		IsNull(MPB.TaxaAdmin, 0) <> 0
		AND
		MP.PayOnCashRegClose = 1
	GROUP BY
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		MP.IDMeioPag,
		MPTS.IDContaCorrente,
		CC.IDEmpresa,
		MPB.IDPessoa,
		P.IDTipoPessoa,
		MPB.IDLancamentoTipo,
		L.IDCashRegMov
	
-- Abertura do Cursor
OPEN Fin_Lancamento_Cursor
-- Inicialização do Cursor
FETCH NEXT FROM Fin_Lancamento_Cursor INTO  
	@Pagando,
	@DataVencimento,
	@DataLancamento,
	@ValorNominal,
	@IDQuitacaoMeioPrevisto,
	@IDUsuarioLancamento,
	@IDContaCorrentePrevista,
	@IDEmpresa,
	@IDPessoa,
	@IDPessoaTipo,
	@IDLancamentoTipo,
	@IDCashRegMov

-- Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
	EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDLancamento', @IDLancamento OUTPUT

	INSERT
		Fin_Lancamento
		(
		IDLancamento,
		Pagando,
		DataVencimento,
		DataLancamento,
		ValorNominal,
		IDQuitacaoMeioPrevisto,
		IDUsuarioLancamento,
		IDContaCorrentePrevista,
		IDEmpresa,
		IDPessoa,
		IDPessoaTipo,
		IDLancamentoTipo,
		IDCashRegMov
 		)
	VALUES	
		(
		@IDLancamento,
		@Pagando,
		@DataVencimento,
		@DataLancamento,
		@ValorNominal,
		@IDQuitacaoMeioPrevisto,
		@IDUsuarioLancamento,
		@IDContaCorrentePrevista,
		@IDEmpresa,
		@IDPessoa,
		@IDPessoaTipo,
		@IDLancamentoTipo,
		@IDCashRegMov 
		)

	-- leitura do próximo
	FETCH NEXT FROM Fin_Lancamento_Cursor INTO  
		@Pagando,
		@DataVencimento,
		@DataLancamento,
		@ValorNominal,
		@IDQuitacaoMeioPrevisto,
		@IDUsuarioLancamento,
		@IDContaCorrentePrevista,
		@IDEmpresa,
		@IDPessoa,
		@IDPessoaTipo,
		@IDLancamentoTipo,
		@IDCashRegMov
END-- fechamento do cursor
CLOSE Fin_Lancamento_Cursor
-- destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor
SET NOCOUNT OFF

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
                SET @ErrorLevel = -202
                GOTO ERRO
END

/******************************************************************************
		Insere as ligacoes entre Lancamento e Quitacao
*******************************************************************************/
INSERT	
	Fin_LancQuit
	(
	IDLancamento,
	IDQuitacao,
	ValorQuitado,
	DataQuitacao,
	ValorJuros,
	IDUsuarioQuitacao
	)
	SELECT
		L.IDLancamento,
		Q.IDQuitacao,
		L.ValorNominal,
		@Date,
		0,
		@IDUsuario
	FROM
		Fin_Lancamento L (NOLOCK)
		JOIN
		MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)
		JOIN
		Fin_Quitacao Q (NOLOCK) ON (MP.IDMeioPagBatch = Q.IDQuitacaoMeio)
	WHERE
		L.IDCashRegMov  = @IDCashRegMov
		AND
		L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista
		AND
		Q.SparrowInt = @IDCashRegMov
		AND
		MP.PayOnCashRegClose = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

UPDATE 	Fin_Lancamento 
SET		 IDCashRegMovClosed = @IDCashRegMov
WHERE
		IDCashRegMov = @IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Quita_Invoice', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE SP_PreSale_GetNewSaleCode
	(
	@IDPreSaleParent 	int, 
	@IDStore 		int, 
	@SaleCode 		varchar(20) output
	) 
AS

DECLARE @ParentSaleCode 	varchar(20)
DECLARE @MiddleSaleCode 	varchar(50)
DECLARE @PartitionCount 	varchar
DECLARE @ConcatStr 		varchar(50)

DECLARE @ErrorLevel  		int
DECLARE @SysError  		int


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Crio um novo SaleCode
		- Busco o SaleCode do pai

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Crio um novo SaleCode
		-202  Busco o SaleCode do pai


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	01 Nov  2000		Carlos Lima		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET @ErrorLevel = 0
 
BEGIN TRAN



IF @IDPreSaleParent IS NULL
	BEGIN
		SET @ConcatStr = 'Invoice.SaleCode' + CONVERT(varchar, @IDStore)
		EXEC sp_Sis_GetNextCode @ConcatStr, @MiddleSaleCode OUTPUT

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -201
			GOTO ERRO 
		END
	END
ELSE
	BEGIN
		SELECT
			@ParentSaleCode = SaleCode
		FROM
			Invoice (NOLOCK) 
		WHERE
			IDPreSale = @IDPreSaleParent


		SELECT
			@PartitionCount = (COUNT(*) + 1)
		FROM
			Invoice (NOLOCK) 
		WHERE
			IDPreSaleParent = @IDPreSaleParent


		SET @MiddleSaleCode = @ParentSaleCode + '-' + CONVERT(varchar, @PartitionCount)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO 
		END
	END

SET @SaleCode = CONVERT(varchar(20), @MiddleSaleCode)

 
OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)
 
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: SP_PreSale_GetNewSaleCode', @ErrorLevelStr
 
	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_CashReg_CalcCash
		(
		@IDCashRegMov	int,
		@TotalCash		money output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Setando @SaleCash
		- Setando @CashierCash
		- Calculando @TotalCash


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May 2000		Eduardo Costa		suporte ao novo financeiro.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @SaleCash		money
DECLARE @CashierCash	money

-- Setando @SaleCash

SELECT @SaleCash = 		(
				SELECT
					SUM( L.ValorNominal)
				FROM
					Fin_Lancamento L (NOLOCK)
					JOIN 
					Invoice I (NOLOCK) ON (L.IDPreSale = I.IDPreSale AND I.IDInvoice IS NOT NULL)
				WHERE
					I.CashRegMovID = @IDCashRegMov
					AND 		
					L.IDQuitacaoMeioPrevisto = 1
				)


-- Setando @CashierCash

SELECT @CashierCash = 	(
				SELECT 	
					SUM( ( 2 * CRTL.Entrando - 1 )  * CRL.TotalCash )
				FROM
					CashRegLog CRL (NOLOCK)
					JOIN 
					CashRegTipoLog CRTL (NOLOCK) ON ( CRL.IDCashRegTipoLog = CRTL.IDCashRegTipoLog )
				WHERE
					CRL.IDCashRegMov = @IDCashRegMov
					AND
					CRTL.Movimenta = 1 
				)

-- Calculando @TotalCash

SELECT @TotalCash = IsNull(@SaleCash, 0) + IsNull(@CashierCash, 0)
GO

CREATE PROCEDURE sp_CashReg_CheckOpen
			( 			
			@CashRegID  		int,
			@IsOpen 		bit output,
			@IDOpenUser 		int output,
			@IDCashRegMov	int output
			) 
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Setando @IDCashRegMov 		- Setando @IDOpenUser
		- Setando @IsOpen
		- Setando IDs para 0 caso sejam Null

	
	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May 2000		Rodrigo Costa		Criacao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


-- Setando @IDCashRegMov 
SELECT  @IDCashRegMov = (	 
			SELECT 
				MAX(IDCashRegMov) 
			FROM 
				dbo.CashRegMov (NOLOCK)
			WHERE
				dbo.CashRegMov.IDCashRegister = @CashRegID 
				AND 				dbo.CashRegMov.IDCashRegStatus = 1
			)	

-- Setando @IDOpenUser
SELECT  @IDOpenUser = 	(	
			SELECT 
				IDOpenUser
			FROM 
				dbo.CashRegMov (NOLOCK)
			WHERE
				dbo.CashRegMov.IDCashRegMov = @IDCashRegMov
 			)	

-- Setando @IsOpen
SELECT	@IsOpen = 	(
			CASE
 				WHEN @IDOpenUser IS NOT NULL THEN 1 ELSE 0 END
			)

-- Setando IDs para 0 caso sejam Null
SELECT 	@IDOpenUser   		= IsNull(@IDOpenUser, 0)
SELECT 	@IDCashRegMov 	= IsNull(@IDCashRegMov, 0)
GO

CREATE PROCEDURE sp_CashReg_WidrawCalcCash
		(
		@IDCashRegMov	int,
		@TotalCash		money output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Setando @SaleCash
		- Setando @CashierCash
		- Calculando @TotalCash


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	01 Sep 2000		Rodrigo Costa		suporte ao novo financeiro.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @SaleCash		money
DECLARE @CashierCash	money


-- Setando @SaleCash
SELECT @SaleCash = 		(
				SELECT
					SUM( L.ValorNominal)
				FROM
					Fin_Lancamento L (NOLOCK)
					JOIN 
					Invoice I (NOLOCK) ON (L.IDPreSale = I.IDPreSale)
				WHERE
					L.IDCashRegMov = @IDCashRegMov
					AND 		
					L.IDQuitacaoMeioPrevisto = 1
				)


-- Setando @CashierCash
SELECT @CashierCash = 	(
				SELECT 	
					SUM( ( 2 * CRTL.Entrando - 1 )  * CRL.TotalCash )
				FROM
					CashRegLog CRL (NOLOCK)
					JOIN CashRegTipoLog CRTL (NOLOCK) ON ( CRL.IDCashRegTipoLog = CRTL.IDCashRegTipoLog )
				WHERE
					CRL.IDCashRegMov = @IDCashRegMov
					AND
					CRTL.Movimenta = 1 
				)


-- Calculando @TotalCash
SELECT @TotalCash = IsNull(@SaleCash, 0) + IsNull(@CashierCash, 0)
GO

CREATE PROCEDURE sp_CashRegister_Close
		(
		@IDCashRegMov   	int,
		@IDUser		int,
		@IDUsuario		int,
		@Bill100		int,
		@Bill50			int,
		@Bill20	 		int,
		@Bill10 			int,
		@Bill5 			int,
		@Bill2 			int,
		@Bill1 			int,
		@Coin1 		int,
		@Coin050 		int,
 		@Coin025 		int,
		@Coin010 		int,
		@Coin005 		int,
		@Coin001 		int,	
		@TotalCash		money,
		@TotalCard		money,
		@TotalCardPre		money,
		@TotalCheck		money,
		@TotalOther 		money,
		@TotalDebit 		money,
		@FinalCount		money,
		@LogDocument		varchar(20),
		@Date			Datetime,
		@IDCashRegLog	int  output
		)
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Testa se o final deposit ja foi feito
		- Update Final Deposit no CashRegMov
		- Insere no CashRegLog
		- Quito os lancamento dos invoices

	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-001  Se deposito final ja foi feito
		-201  Erro em Update Final Deposit no CashRegMov
		-202  Erro em Insere no CashRegLog
		-203  Erro em Quito os lancamento dos invoices


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May 2000		Rodrigo Costa		Criacao;
	22 Jun  2001		Davi Gouveia		Log de Return Values
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode para @IDCashRegLog; 
							Removido SELECT @IDCashRegLog = @@IDENTITY;
	18 Aug 2004		Rodrigo Costa		Gravar error log
	28 Oct	2006		Rodrigo Costa		Criacao do parametro de Debito
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError 	INT

SET @ErrorLevel = 0

/* Testa se o final deposit ja foi feito */
if EXISTS (SELECT IDCashRegLog FROM CashRegLog (NOLOCK) WHERE IDCashRegMov = @IDCashRegMov AND IDCashRegTipoLog = 4) 
   RETURN -1


/*	Update Final Deposit no CashRegMov    */
BEGIN TRANSACTION 

UPDATE
	CashRegMov 
SET	
	FinalWidraw      		= @TotalCash + @TotalCard + @TotalCardPre + @TotalCheck + @TotalOther + @TotalDebit,
	FinalCount     		= @FinalCount,   	
	IDCashRegStatus  	= 2 
WHERE 
	IDCashRegMov = @IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*	Insere no CashRegLog            */
/******************************************************************************
	Obtenho o @IDCashRegLog
*******************************************************************************/

EXEC sp_Sis_GetNextCode 'CashRegLog.IDCashRegLog', @IDCashRegLog OUTPUT
INSERT CashRegLog
	(
	IDCashRegLog,
	IDCashRegMov,
	IDCashRegTipoLog,
	LogTime,
	IDUser,
	Bill100,
	Bill50,
	Bill20,
	Bill10,
	Bill5,
	Bill2,
	Bill1,
	Coin1,
	Coin050,
	Coin025,
	Coin010,
	Coin005,
	Coin001,
	TotalCash,		
	TotalCard,
	TotalCardPre,	
	TotalCheck,
	TotalOther,
	TotalDebit,
	LogDocument		
	)
	VALUES
	(
	@IDCashRegLog,
	@IDCashRegMov,
	4,
	@Date,
	@IDUser,
	@Bill100,
	@Bill50,
	@Bill20,
	@Bill10,
	@Bill5,
	@Bill2,
	@Bill1,
	@Coin1,
	@Coin050,
	@Coin025,
	@Coin010,
	@Coin005,
	@Coin001,
	@TotalCash,		
	@TotalCard,
	@TotalCardPre,
	@TotalCheck,
	@TotalOther,
	@TotalDebit,
	@LogDocument
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


-- Quito os lancamento dos invoices
EXEC sp_CashRegister_Quita_Invoice @IDCashRegMov, @IDUsuario, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:	
	COMMIT TRANSACTION 
	RETURN 0

ERRO:
	ROLLBACK
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Close', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_CashRegister_Quita_Lancamento
	(
	@IDUsuario		int,
	@Date			Datetime,
	@IDCashRegMovClosed int
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere os registros de quitacao, para os invoices
		- Insiro os Account Payable com as taxas de admim
                - Insere as ligacoes entre Lancamento e Quitacao
		- Atualiza Fin_lancamento com o caixa no qual foi quitado

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insere os registros de quitacao, para os invoices
		-202  Erro em Insiro os Account Payable com as taxas de admim
		-203  Erro em Insere as ligacoes entre Lancamento e Quitacao
		-204  Erro em Atualiza Fin_lancamento com o caixa no qual foi quitado


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------
	27 Oct	2004		Carlos Lima		Criação
	17 Aug	2006		Maximiliano Muniz	Filtro pelo campo "PayOnCashRegClose" na carga dos cursores;
							O campo "PrazoRecebimento" agora é pego do MeioPag direto.
	---------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

/*--------------------------------------------------------------------------------------------------------*/
/*	       Quita os lancamentos         			  	*/
/*--------------------------------------------------------------------------------------------------------*/

-- Insere os registros de quitacao, para os invoices
-- Alterações de sp_Sis_GetNextCode
SET NOCOUNT ON
-- Variáveis de Fin_Quitacao
DECLARE @IDQuitacao 		Int
DECLARE @Pagando 		TBit
DECLARE @DataQuitacao 		smalldatetime
DECLARE @ValorQuitacao 		TValor
DECLARE @IDQuitacaoMeio 	int
DECLARE @IDUsuarioQuitacao 	int
DECLARE @ValorJuros 		TValor
DECLARE @NumeroMeioQuit 	TCodigoGeral
DECLARE @IDContaCorrente 	int
DECLARE @SparrowInt 		int

--Variáveis de Fin_Lancamento
DECLARE @IDLancamento			int
DECLARE @DataVencimento			smalldatetime
DECLARE @DataLancamento			smalldatetime
DECLARE @ValorNominal			TValor
DECLARE @IDQuitacaoMeioPrevisto		int
DECLARE @IDUsuarioLancamento		int
DECLARE @IDContaCorrentePrevista	int
DECLARE @IDEmpresa			int
DECLARE @IDPessoa 			int
DECLARE @IDPessoaTipo 			int 
DECLARE @IDLancamentoTipo 		int 
DECLARE @IDCashRegMov			int
DECLARE @SaleCode			varchar(10)

--Declaração do Cursor de Fin_Quitacao
DECLARE Fin_Quitacao_Cursor CURSOR FOR 
	(SELECT
		0,
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		0, -- A LancQuit ira atualizar corretamente este valor
		MP.IDMeioPagBatch,
		@IDUsuario,
		0,
		Convert(Varchar(20), L.IDCashRegMov),
		MPTS.IDContaCorrente,
		L.IDCashRegMov
	FROM
		#CloseCash CC
		JOIN
		Fin_Lancamento L (NOLOCK) ON (CC.IDlancamento = L.IDLancamento and CC.IDCashRegMov = L.IDCashRegMov)
		JOIN
		Invoice I (NOLOCK) ON ( I.IDPresale = L.IDPreSale )
		JOIN 
		MeioPag MP (NOLOCK) ON ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN 
		MeioPag MPB (NOLOCK) ON ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN 
		MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
	WHERE
		L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista
		AND MP.IDMeioPagBatch IS NOT NULL
		AND MP.PayOnCashRegClose = 1
	GROUP BY
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		MP.IDMeioPagBatch,
		Convert(Varchar(20), L.IDCashRegMov),
		MPTS.IDContaCorrente,
		L.IDCashRegMov
	)
-- Abertura do Cursor
OPEN Fin_Quitacao_Cursor
-- Inicialização do Cursor
FETCH NEXT FROM Fin_Quitacao_Cursor INTO  
		@Pagando,
		@DataQuitacao,
		@ValorQuitacao,
		@IDQuitacaoMeio,
		@IDUsuarioQuitacao ,
		@ValorJuros ,
		@NumeroMeioQuit,
		@IDContaCorrente,
		@SparrowInt
-- Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
/******************************************************************************
	Obtenho o @IDQuitacao
*******************************************************************************/
	EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT

	INSERT
		Fin_Quitacao
		(
		IDQuitacao,
		Pagando,
		DataQuitacao,
		ValorQuitacao,
		IDQuitacaoMeio,
		IDUsuarioQuitacao,
		ValorJuros,
		NumeroMeioQuit,
		IDContaCorrente,
		SparrowInt
 		)
	VALUES 
		(	
		@IDQuitacao, 
		@Pagando,
		@DataQuitacao,
		@ValorQuitacao,
		@IDQuitacaoMeio,
		@IDUsuarioQuitacao ,
		@ValorJuros ,
		@NumeroMeioQuit,
		@IDContaCorrente,
		@SparrowInt )
	-- leitura do próximo
	FETCH NEXT FROM Fin_Quitacao_Cursor INTO 

		@Pagando,
		@DataQuitacao,
		@ValorQuitacao,
		@IDQuitacaoMeio,
		@IDUsuarioQuitacao ,
		@ValorJuros ,
		@NumeroMeioQuit,
		@IDContaCorrente,
		@SparrowInt
END
-- fechamento do cursor
CLOSE Fin_Quitacao_Cursor
-- destruição do cursor
DEALLOCATE Fin_Quitacao_Cursor
SET NOCOUNT OFF

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END
/******************************************************************************
		Insiro os Account Payable com as taxas de admim
*******************************************************************************/
--Declaração do Cursor de Fin_Quitacao
DECLARE Fin_Lancamento_Cursor CURSOR FOR 
	SELECT	
		1,
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		@Date,
		SUM( L.ValorNominal * (IsNull(MPB.TaxaAdmin, 0)/100) ),
		MP.IDMeioPag,
		@IDUsuario,
		MPTS.IDContaCorrente,
		CC.IDEmpresa,
		MPB.IDPessoa,
		P.IDTipoPessoa,
		MPB.IDLancamentoTipo,
		L.IDCashRegMov
	FROM
		#CloseCash TCC
		JOIN
		Fin_Lancamento L (NOLOCK) ON (TCC.IDlancamento = L.IDLancamento and TCC.IDCashRegMov = L.IDCashRegMov)
		JOIN 
		Invoice I (NOLOCK) ON ( I.IDPresale = L.IDPreSale )
		JOIN 
		MeioPag MP (NOLOCK) ON ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN 
		MeioPag MPB (NOLOCK) ON ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN 
		MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
		JOIN 
		Fin_ContaCorrente CC (NOLOCK) ON (MPTS.IDContaCorrente = CC.IDContaCorrente)
		JOIN 
		Pessoa P (NOLOCK) ON (MPB.IDPessoa = P.IDPessoa)
	WHERE
		MPB.AutoDiscountFee = 1
		AND
		L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista
		AND
		MPB.IDLancamentoTipo IS NOT NULL
		AND
		MPB.IDPessoa IS NOT NULL
		AND
		IsNull(MPB.TaxaAdmin, 0) <> 0
	GROUP BY
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		MP.IDMeioPag,
		MPTS.IDContaCorrente,
		CC.IDEmpresa,
		MPB.IDPessoa,
		P.IDTipoPessoa,
		MPB.IDLancamentoTipo,
		L.IDCashRegMov
	
-- Abertura do Cursor
OPEN Fin_Lancamento_Cursor
-- Inicialização do Cursor
FETCH NEXT FROM Fin_Lancamento_Cursor INTO  
	@Pagando,
	@DataVencimento,
	@DataLancamento,
	@ValorNominal,
	@IDQuitacaoMeioPrevisto,
	@IDUsuarioLancamento,
	@IDContaCorrentePrevista,
	@IDEmpresa,
	@IDPessoa,
	@IDPessoaTipo,
	@IDLancamentoTipo,
	@IDCashRegMov

-- Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
	EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT

	INSERT
		Fin_Lancamento
		(
		IDLancamento,
		Pagando,
		DataVencimento,
		DataLancamento,
		ValorNominal,
		IDQuitacaoMeioPrevisto,
		IDUsuarioLancamento,
		IDContaCorrentePrevista,
		IDEmpresa,
		IDPessoa,
		IDPessoaTipo,
		IDLancamentoTipo,
		IDCashRegMov,
		Situacao
 		)
	VALUES	
		(
		@IDLancamento,
		@Pagando,
		@DataVencimento,
		@DataLancamento,
		@ValorNominal,
		@IDQuitacaoMeioPrevisto,
		@IDUsuarioLancamento,
		@IDContaCorrentePrevista,
		@IDEmpresa,
		@IDPessoa,
		@IDPessoaTipo,
		@IDLancamentoTipo,
		@IDCashRegMov,
		1 --aberto
		)

	-- leitura do próximo
	FETCH NEXT FROM Fin_Lancamento_Cursor INTO  
		@Pagando,
		@DataVencimento,
		@DataLancamento,
		@ValorNominal,
		@IDQuitacaoMeioPrevisto,
		@IDUsuarioLancamento,
		@IDContaCorrentePrevista,
		@IDEmpresa,
		@IDPessoa,
		@IDPessoaTipo,
		@IDLancamentoTipo,
		@IDCashRegMov
END-- fechamento do cursor
CLOSE Fin_Lancamento_Cursor
-- destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor
SET NOCOUNT OFF

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
                SET @ErrorLevel = -202
                GOTO ERRO
END

/******************************************************************************
		Insere as ligacoes entre Lancamento e Quitacao
*******************************************************************************/
INSERT	
	Fin_LancQuit
	(
	IDLancamento,
	IDQuitacao,
	ValorQuitado,
	DataQuitacao,
	ValorJuros,
	IDUsuarioQuitacao
	)
	SELECT
		L.IDLancamento,
		Q.IDQuitacao,
		L.ValorNominal,
		@Date,
		0,
		@IDUsuario
	FROM
		#CloseCash TCC
		JOIN
		Fin_Lancamento L (NOLOCK) ON (TCC.IDlancamento = L.IDLancamento and TCC.IDCashRegMov = L.IDCashRegMov)
		JOIN
		MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)
		JOIN
		Fin_Quitacao Q (NOLOCK) ON (MP.IDMeioPagBatch = Q.IDQuitacaoMeio and Q.SparrowInt = L.IDCashRegMov)
	WHERE
		Q.IDQuitacao NOT IN 
			(
			SELECT
				IDQuitacao	
			FROM
				Fin_LancQuit (NOLOCK)
			)
		AND
		L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/***************************************************************************************
	Atualiza Fin_lancamento com o caixa no qual foi quitado
****************************************************************************************/

UPDATE	
	Fin_Lancamento
SET	IDCashRegMovClosed = @IDCashRegMovClosed
FROM	
	#CloseCash
WHERE
	Fin_Lancamento.IDLancamento = #CloseCash.IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END



OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Quita_Lancamento', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_CashRegister_SubClose
		(
		@IDCashRegMov   	int,
		@IDUser		int,
		@IDUsuario		int,
		@TotalCash		money,
		@TotalCard		money,
		@TotalCardPre		money,
		@TotalCheck		money,
		@TotalOther 		money,
		@TotalDebit 		money,
		@FinalCount		money,
		@LogDocument		varchar(20),
		@Date			Datetime,
		@IDCashRegLog	int  output
		)
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Testa se o final deposit ja foi feito
		- Update Final Deposit no CashRegMov
		- Insere no CashRegLog
		- Executa sp_CashRegister_Quita_Lancamento


	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-001  Se deposito final ja foi feito
		-201  Erro em Update Final Deposit no CashRegMov
		-202  Erro em Insere no CashRegLog
		-203  Erro em Executa sp_CashRegister_Quita_Lancamento


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	21 Oct 2000		Carlos Lima		Criacao;
	28 Oct 2006		Rodrigo Costa		Novo parametro TotalDebit
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError 	INT

SET @ErrorLevel = 0

/* Testa se o final deposit ja foi feito */
if EXISTS (SELECT IDCashRegLog FROM CashRegLog (NOLOCK) WHERE IDCashRegMov = @IDCashRegMov AND IDCashRegTipoLog = 4) 
   RETURN -1


/*	Update Final Deposit no CashRegMov    */
BEGIN TRANSACTION 

UPDATE
	CashRegMov 
SET	
	FinalWidraw      		= @TotalCash + @TotalCard + @TotalCardPre + @TotalCheck + @TotalOther + @TotalDebit,
	FinalCount     		= @FinalCount,   	
	IDCashRegStatus  	= 2 
WHERE 
	IDCashRegMov = @IDCashRegMov

PRINT 'Update Final Deposit no CashRegMov'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*	Insere no CashRegLog            */
/******************************************************************************
	Obtenho o @IDCashRegLog
*******************************************************************************/

EXEC sp_Sis_GetNextCode 'CashRegLog.IDCashRegLog', @IDCashRegLog OUTPUT
INSERT CashRegLog
	(
	IDCashRegLog,
	IDCashRegMov,
	IDCashRegTipoLog,
	LogTime,
	IDUser,
	Bill100,
	Bill50,
	Bill20,
	Bill10,
	Bill5,
	Bill2,
	Bill1,
	Coin1,
	Coin050,
	Coin025,
	Coin010,
	Coin005,
	Coin001,
	TotalCash,		
	TotalCard,
	TotalCardPre,	
	TotalCheck,
	TotalOther,
	TotalDebit,
	LogDocument		
	)
	VALUES
	(
	@IDCashRegLog,
	@IDCashRegMov,
	4,
	@Date,
	@IDUser,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	@TotalCash,		
	@TotalCard,
	@TotalCardPre,
	@TotalCheck,
	@TotalOther,
	@TotalDebit,
	@LogDocument
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

EXEC sp_CashRegister_Quita_Lancamento @IDUser, @Date, @IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

OK:	
	COMMIT TRANSACTION 
	RETURN 0


ERRO:
	ROLLBACK
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_SubClose', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Cashregister_GetPayments
	(
	@Caixa 		int, 
	@CaixaFechado 	int, 
	@TipoPag 		int, 
	@IsFechado 		bit,
	@IDStore 		int
	) AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete em #Lancamentos_Caixa
		- Insert em #Lancamentos_Caixa

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Delete em #Lancamentos_Caixa
		-202  Erro em Insert em #Lancamentos_Caixa

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Carlos Lima		Criacao;
	27 Apr	2005		Rodrigo Costa		Inclusao do filtro por loja;
	11 Apr	2007		Maximiliano Muniz	Adicionado InvoiceDiscount no total da nota;
	11 May	2007		Maximiliano Muniz	Adicionado IDStore na tabela temporária;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

DELETE FROM #Lancamentos_Caixa

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

INSERT INTO #Lancamentos_Caixa
	(
		IDLancamento,
		CheckNumber,
		CustomerDocument,
		CustomerName,
		CustomerPhone,
		ValorNominal,
		DataVencimento,
		IDPreSale,
		IDCashRegMov,
		IDBanco,
		Banco,
		Tipo,
		IDMeioPag,
		MeioPag,
		IDCashRegMovClosed,
		IDStore,
		SaleCode,
		InvoiceTotal,
		PreSaleDate,
		NumDesdobramento
	)
	SELECT
		Fin_Lancamento.IDLancamento,
		Fin_Lancamento.CheckNumber,
		Fin_Lancamento.CustomerDocument,
		Fin_Lancamento.CustomerName,
		Fin_Lancamento.CustomerPhone,
		Fin_Lancamento.ValorNominal,
		Fin_Lancamento.DataVencimento,
		Fin_Lancamento.IDPreSale,
		Fin_Lancamento.IDCashRegMov,
		Fin_Banco.IDBanco,
		Fin_Banco.Banco,
		MeioPag.Tipo,
		MeioPag.IDMeioPag,
		MeioPag.MeioPag,
		IDCashRegMovClosed,
		I.IDStore,
		I.SaleCode,
		((((I.SubTotal - I.InvoiceDiscount - I.ItemDiscount) - I.TaxIsemptItemDiscount) + I.AditionalExpenses) + I.Tax) as InvTotal,
		I.PreSaleDate,
		NumDesdobramento
	FROM
		Fin_Lancamento (NOLOCK)
		INNER JOIN Invoice I (NOLOCK) ON Fin_Lancamento.IDPreSale = I.IDPreSale
		INNER JOIN MeioPag (NOLOCK) ON Fin_Lancamento.IDQuitacaoMeioPrevisto = MeioPag.IDMeioPag
		LEFT JOIN Fin_Banco (NOLOCK) ON Fin_Lancamento.IDBankCheck = Fin_Banco.IDBanco
	WHERE
		I.IDStore = IsNull(@IDStore, I.IDStore)
		AND
		(
			@TipoPag IS NULL
			OR
			MeioPag.Tipo = @TipoPag
		)
	
		AND
	
	  	(
			(MeioPag.Tipo NOT IN (2, 4))
			OR 
			Convert(DateTime, Convert(VARCHAR, Fin_Lancamento.DataLancamento, 103), 103) < getDate()
		)
	
		AND
	
	  	(
			(
				Fin_Lancamento.IDCashRegMovClosed = @CaixaFechado
				AND
				ISNULL(@IsFechado, 0) = 1
			)
			OR
			(
				Fin_Lancamento.IDCashRegMovClosed IS NULL 
				AND
				(
					--Traz os lançamentos não quitados desse caixa	
				  	Fin_Lancamento.IDCashRegMov = @Caixa
					
			  		OR -- Ou de outro caixa, desde que...
			  		(
			  			(Fin_Lancamento.PaymentPlace = 0) -- Local pagamento seja a loja
			  			OR -- Ou
			  			(
							Fin_Lancamento.DataLancamento <= getDate() -- Data do Lançamento seja menor que hoje
			   				AND Fin_Lancamento.PaymentPlace <> 0 -- Em qualquer lugar que não seja na loja
			  			)
			  		)
				)
			)
	  	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Cashregister_GetPayments', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Comission_CalcPayDate
		(
		@IDComissionado	int,
		@InvoiceDate 		smalldatetime,
		@DataPagamento 	smalldatetime output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste de Mes seguinte
		- Troca o dia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @DiaPagamento 	int
DECLARE @DiaInvoice   	int

SELECT @DiaPagamento = ( SELECT DiaPagamento FROM dbo.vwComissionado (NOLOCK) WHERE IDComissionado = @IDComissionado )

SELECT @DiaInvoice = DATEPART(day, @InvoiceDate)

SELECT @DataPagamento = @InvoiceDate

/*	Teste de Mes seguinte  */

IF @DiaPagamento < @DiaInvoice
	SELECT @DataPagamento = ( DATEADD(month, 1, @InvoiceDate) )

/*	Troca o dia      */

SELECT @DataPagamento = ( DATEADD(day, (@DiaPagamento-@DiaInvoice), @DataPagamento) )

RETURN
GO

CREATE PROCEDURE sp_Commission_CalcAgency
		(
		@IDAgency 		int,
		@DataInicio		SmallDateTime,
		@DataFim		SmallDateTime,
		@Date			Datetime,
		@Commission		money	output,
		@Divida 		money	output
		)
AS

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	SUMARIO

        	- Calculo a comissao da agencia em cima da do guia
	- Calcula a divida da Agencia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	19 June 2001   		Eduardo Costa		Criação;
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


if not (@IDAgency > 0)
   return

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a comissao da Agencia
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Calculo a comissao da agencia em cima da do guia.
-- Utilizando um percentual defino no TouristGroup

SELECT
	@Commission = IsNull(SUM( IsNull( C.MovCommission* (TG.ComissaoSobreGuia/100),0) ),0)
FROM
	TouristGroup TG (NOLOCK)
	JOIN Invoice I (NOLOCK)
		ON (TG.IDTouristGroup = I.IDTouristGroup)
	JOIN Pessoa P (NOLOCK)
		ON (TG.IDGuide = P.IDPessoa)
	JOIN vwCommission C (NOLOCK)
		ON (I.IDInvoice = C.DocumentID AND C.InventMovTypeID=1 AND C.IDTipoPessoa = P.IDTipoPessoa)
WHERE
	TG.IDLancPagAgencia IS NULL
	AND
	TG.IDAgency = @IDAgency
	AND
	I.InvoiceDate >= @DataInicio
	AND
	I.InvoiceDate < @DataFim


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a divida da Agencia
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_Commission_CalcDivida @IDAgency, @Date, @Divida
GO

CREATE PROCEDURE sp_Commission_CalcGroup

		(
		@IDTouristGroup	int,
		@Commission		money	output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Grupo


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


if not (@IDTouristGroup > 0)
   return

/*------------------------------------------------------------------------------*/
/*       Calcula a comissao do Grupo          		*/
/*-----------------------------------------------------------------------------*/

SELECT
	@Commission = IsNull (
	(
	SELECT
		IsNull	( SUM 	(
					(IsNull(GroupToComType.Comission, 0)/100) *
					(
						(
							(
		 					IsNull(InvMov.SalePrice, 0)-
							(TipoComissionado.ComissionOnProfit * IsNull(InvMov.CostPrice, 0))
							) * IsNull(InvMov.Qty, 0)
						) - IsNull(InvMov.Discount, 0)
					)
				), 0)
	FROM 	
		dbo.Invoice			Invoice (NOLOCK),
		dbo.InventoryMov		InvMov (NOLOCK),
		dbo.Model			Model (NOLOCK),
		dbo.GroupToComissionType	GroupToComType (NOLOCK),
		dbo.vwTipoComissionado 	TipoComissionado (NOLOCK)
	WHERE
		Invoice.IDTouristGroup = @IDTouristGroup
		AND
		InvMov.DocumentID = Invoice.IDInvoice
		AND
		InvMov.InventMovTypeID = 1
		AND
		InvMov.ModelID = Model.IDModel
		AND
		GroupToComType.IDTipoComissionado = 5
		AND
		TipoComissionado.IDTipoComissionado = 5
		AND
		GroupToComType.GroupID = Model.GroupID
	), 0)
GO

CREATE PROCEDURE sp_Commission_CalcGuide

		(
		@IDGuide 		int,
		@DataInicio		SmallDateTime,
		@DataFim		SmallDateTime,
		@Date			DateTime,
		@IDTouristGroup	int,
		@Commission		money	output,
		@Divida 		money	output
		)
AS

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	SUMARIO

		- Calcula a comissao do Guia
		- Calcula a divida do Guia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	19 June 2001   		Eduardo Costa		Criação;

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


if not (@IDGuide > 0)
   return


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a comissao do Guia
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Lembrar de caso esteja setado no grupo, descontar a coordenacao da agencia da comissao do guia

SELECT
	@Commission = IsNull(SUM(IsNull(C.MovCommission * (1-(TG.ComissaoSobreGuia*TG.DescontaCoordenacao/100)),0)),0)
FROM
	TouristGroup TG (NOLOCK)
	JOIN Invoice I (NOLOCK)
		ON (TG.IDTouristGroup = I.IDTouristGroup)
	JOIN Pessoa PG (NOLOCK)
		ON (TG.IDGuide = PG.IDPessoa)
	JOIN vwCommission C (NOLOCK)
		ON (I.IDInvoice = C.DocumentID AND C.InventMovTypeID=1 AND C.IDTipoPessoa = PG.IDTipoPessoa)
WHERE
	TG.IDLancPagGuia IS NULL
	AND
	TG.IDGuide = @IDGuide
	AND
	I.InvoiceDate >= @DataInicio
	AND
	I.InvoiceDate < @DataFim


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a divida do Guia
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_Commission_CalcDivida @IDGuide, @Date, @Divida
GO

CREATE PROCEDURE sp_Commission_CalcGuideAgency
		(
		@IDAgency 		int,
		@IDGuide		int,
		@DataInicio		SmallDateTime,
		@DataFim		SmallDateTime,
		@Commission		money	output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao da Agencia
		- Calcula a comissao do Guia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao da Agencia			*/
/*------------------------------------------------------------------------------*/

SELECT @Commission = 0

if @IDGuide = null
begin
	SELECT
		@Commission = IsNull (
			(
			SELECT 	IsNull	( SUM 	(
						(TouristGroup.ComissaoSobreGuia / 100 )   *
						(IsNull(GroupToComType.Comission, 0)/100) *
						(
							(
								(
		 						IsNull(InvMov.SalePrice, 0)-
								(TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))
								)*IsNull(InvMov.Qty, 0)
							)-IsNull(InvMov.Discount, 0)
						)
					), 0)
			FROM
				dbo.TouristGroup 	 TouristGroup (NOLOCK),
				dbo.Invoice 		 Invoice (INDEX = PI_Invoice_IDTouristGroup),
				dbo.InventoryMov 	 InvMov (NOLOCK),
				dbo.Model 		 Model (NOLOCK),
				dbo.GroupToComissionType GroupToComType (NOLOCK),
				dbo.vwComissionado 	 Comis (NOLOCK),
				dbo.vwTipoComissionado 	 TipoComissionado (NOLOCK)
			WHERE
				TouristGroup.IDLancPagAgencia IS NULL
				AND
				TouristGroup.IDAgency = IsNull(@IDAgency, TouristGroup.IDAgency)
				AND
				TouristGroup.EnterDate > @DataInicio
				AND
				TouristGroup.EnterDate < @DataFim
				AND
				Invoice.IDTouristGroup = TouristGroup.IDTouristGroup
				AND
				InvMov.DocumentID = Invoice.IDInvoice
				AND
				InvMov.InventMovTypeID = 1
				AND
				InvMov.ModelID = Model.IDModel
				AND
				Comis.IDComissionado = TouristGroup.IDGuide
				AND
				GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado
				AND
				TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado
				AND
				GroupToComType.GroupID = Model.GroupID
			), 0)
end


/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao do Guia                 		*/
/*------------------------------------------------------------------------------*/
SELECT
	@Commission = @Commission +
		IsNull (
		(
		SELECT 	IsNull	( SUM 	(
						(IsNull(GroupToComType.Comission, 0)/100) *
						( 
							( 
								(
		 						IsNull(InvMov.SalePrice, 0)-
								(TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))
								)*IsNull(InvMov.Qty, 0)
							)-IsNull(InvMov.Discount, 0)
						)
					), 0)
		FROM
			dbo.TouristGroup 	 TouristGroup (NOLOCK),
			dbo.Invoice 		 Invoice (INDEX = PI_Invoice_IDTouristGroup),
			dbo.InventoryMov 	 InvMov (NOLOCK),
			dbo.Model 		 Model (NOLOCK),
			dbo.GroupToComissionType GroupToComType (NOLOCK),
			dbo.vwComissionado 	 Comis (NOLOCK),
			dbo.vwTipoComissionado 	 TipoComissionado (NOLOCK)
		WHERE
			TouristGroup.IDLancPagGuia IS NULL
			AND
			TouristGroup.IDGuide  = IsNull(@IDGuide,  TouristGroup.IDGuide)
			AND
			TouristGroup.IDAgency = IsNull(@IDAgency, TouristGroup.IDAgency)
			AND
			TouristGroup.EnterDate > @DataInicio
			AND
			TouristGroup.EnterDate < @DataFim
			AND
			Invoice.IDTouristGroup = TouristGroup.IDTouristGroup
			AND
			InvMov.DocumentID = Invoice.IDInvoice
			AND
			InvMov.InventMovTypeID = 1
			AND
			InvMov.ModelID = Model.IDModel
			AND
			Comis.IDComissionado = TouristGroup.IDGuide
			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado
			AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado
			AND
			GroupToComType.GroupID = Model.GroupID
		), 0)
GO

CREATE PROCEDURE sp_Commission_CalcOther

		(
		@IDOtherComission	int,
		@DataInicio		SmallDateTime,
		@DataFim		SmallDateTime,
		@Commission		money	output,
		@Extorno 		money	output,
		@Correcao 		money	output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Vendedor
		- Calcula o Extorno do Vendedor
		- Calcula o Credito do Vendedor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



if not (@IDOtherComission > 0)
   return

/*------------------------------------------------------------------------------*/
/*	   Calcula a comissao do Vendedor	*/ /*------------------------------------------------------------------------------*/
SELECT
	@Commission =  IsNull(SUM(IsNull(C.MovCommission,0)),0)
FROM
	Invoice I (NOLOCK)
	JOIN Media M (NOLOCK) 
		ON (I.MediaID = M.IDMedia)
	JOIN vwCommission C (NOLOCK) 
		ON (I.IDInvoice = C.DocumentID AND C.InventMovTypeID=1)
	JOIN Pessoa P (NOLOCK) 
		ON (M.IDOtherCommission = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa)

WHERE
	I.OtherComissionID = @IDOtherComission
	AND
	I.InvoiceDate >= @DataInicio
	AND
	I.InvoiceDate < @DataFim
	AND
	I.IDLancPagOtherCom IS NULL

/*------------------------------------------------------------------------------*/
/*  Calcula o Extorno do Vendedor		*/
/*------------------------------------------------------------------------------*/
SELECT	@Extorno = IsNull(
			(
			SELECT 	SUM ( L.ValorNominal - L.TotalQuitado)

			FROM 		Fin_Lancamento L (NOLOCK)

			WHERE	L.IDPessoa = @IDOtherComission
					AND
					L.Situacao in (1,5)  --  1=Aberto, 5=ParteQuitado
					AND
					L.IDLancamentoTipo = 3    -- \\Despesas\Extorno de Comissao
			), 0)


/*------------------------------------------------------------------------------*/
/*  Calcula o Credito do Vendedor	 		*/
/*------------------------------------------------------------------------------*/
SELECT	@Correcao = IsNull(
			(
			SELECT 	SUM ( L.ValorNominal - L.TotalQuitado)

			FROM 		Fin_Lancamento L (NOLOCK)

			WHERE	L.IDPessoa = @IDOtherComission
					AND
					L.Situacao in (1,5)  --  1=Aberto, 5=ParteQuitado
					AND
					L.IDLancamentoTipo = 5    -- \\Despesas\Correcao de comissao
			), 0)
GO

CREATE PROCEDURE sp_Commission_CalcVendedor
		(
		@IDVendedor	int,
		@DataInicio	SmallDateTime,
		@DataFim	SmallDateTime,
		@IsPre		bit,
		@IsPaid		bit,
		@Commission	money output,
		@Extorno	money output,
		@Correcao	money output
		)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Sales Person
		- Calcula a divida do Vendedor
		- Calcula o Extorno do Vendedor
		- Calcula o Credito do Vendedor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	19 Jun	2001		Eduardo Costa		Criação;
	14 Apr	2005		Rodrigo Costa		Calculo de comissao incluindo o PreSale;
	10 Sep	2007		Maximiliano Muniz	Cálculo por pagamento cadastrado;
	---------------------------------------------------------------------------------------------------------------------------------- */

IF NOT (@IDVendedor > 0)
	RETURN

----------------------------------------------------------------------------------
--			Calcula a comissao do Sales Person			--
----------------------------------------------------------------------------------
-- Lembrar de caso esteja setado no grupo, descontar a coordenacao da agencia da comissao do guia

IF @IsPre = 0
BEGIN
	SELECT
		@Commission = IsNull(SUM(IsNull(C.MovCommission * M.PayComission, 0)), 0)
	FROM
		Invoice I (NOLOCK)
		JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
		JOIN vwCommission C (NOLOCK) ON (C.InventMovTypeID = 1 AND I.IDInvoice = C.DocumentID)
		JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
		LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento)
	WHERE
		C.ComissionID = @IDVendedor
		AND I.InvoiceDate >= @DataInicio
		AND I.InvoiceDate < @DataFim
		AND CP.IDLancPag IS NULL
		AND IsNull(I.Canceled, 0) = 0
END
ELSE
BEGIN
	IF @IsPaid = 0
	BEGIN
		SELECT
			@Commission = IsNull(SUM(IsNull(C.MovCommission * M.PayComission, 0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwCommission C (NOLOCK) ON (C.InventMovTypeID = 1 AND I.IDInvoice = C.DocumentID)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0

		SELECT
			@Commission = @Commission + IsNull(SUM(IsNull(C.ItemCommis * M.PayComission,0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwSaleItem C (NOLOCK) ON (I.IDPreSale = C.DocumentID AND C.Invoice = 0)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0
	END
	ELSE
	BEGIN
		SELECT
			@Commission = IsNull(SUM(IsNull(C.MovCommission * M.PayComission, 0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwCommission C (NOLOCK) ON (C.InventMovTypeID = 1 AND I.IDInvoice = C.DocumentID)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0
			AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento)

		SELECT
			@Commission = @Commission + IsNull(SUM(IsNull(C.ItemCommis * M.PayComission,0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwSaleItem C (NOLOCK) ON (I.IDPreSale = C.DocumentID AND C.Invoice = 0)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0
			AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento)
	END
END

--------------------------------------------------------------------------
--			Calcula a divida do Vendedor			--
--------------------------------------------------------------------------

--EXEC sp_Commission_CalcDivida @IDVendedor, @Date, @Divida

--------------------------------------------------------------------------
--			Calcula o Extorno do Vendedor			--
--------------------------------------------------------------------------
SELECT	@Extorno = IsNull((
				SELECT
					SUM (L.ValorNominal - L.TotalQuitado)
				FROM
					Fin_Lancamento L (NOLOCK)
				WHERE
					L.IDPessoa = @IDVendedor
					AND L.Situacao in (1, 5) --1=Aberto, 5=ParteQuitado
					AND L.IDLancamentoTipo = 3 --Despesas\Extorno de Comissao
			), 0)

--------------------------------------------------------------------------
--			Calcula o Credito do Vendedor			--
--------------------------------------------------------------------------
SELECT	@Correcao = IsNull((
				SELECT
					SUM (L.ValorNominal - L.TotalQuitado)
				FROM
					Fin_Lancamento L (NOLOCK)
				WHERE
					L.IDPessoa = @IDVendedor
					AND L.Situacao in (1, 5)  --1=Aberto, 5=ParteQuitado
					AND L.IDLancamentoTipo = 5 --Despesas\Correcao de comissao
			), 0)
GO

CREATE PROCEDURE sp_Commission_DelPayAgency
		(
		@IDAgency		int,
		@IDLancamento	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto Lancamento/Quitacao
		- Deleto Quitacao
		- Deleto Lancamento
		- Deleta o pagamento no GroupCost
		- Deleta o pagamento nos grupos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto Lancamento/Quitacao
		-202  Erro em Deleto Quitacao
		-203  Erro em Deleto Lancamento
		-204  Erro em Deleta o pagamento no GroupCost
		-205  Erro em Deleta o pagamento nos grupos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	22 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @IDQuitacao 	int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

if not (@IDAgency > 0)
   return


BEGIN TRAN

/*----------------------------------------------------------------*/
/*		Deleta o registro do pagamento			  */
/*----------------------------------------------------------------*/

SELECT
	LQ.IDQuitacao
INTO
	#QuitacaoToDelete
FROM
	Fin_LancQuit LQ
WHERE
	LQ.IDLancamento = @IDLancamento


-- Deleto Lancamento/Quitacao
DELETE
	Fin_LancQuit
WHERE
	IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Deleto Quitacao
DELETE Q
FROM
	Fin_Quitacao Q (NOLOCK)
	JOIN
	#QuitacaoToDelete QTD ON (Q.IDQuitacao = QTD.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

-- Deleto Lancamento
DELETE 	Fin_Lancamento
WHERE	IDLancamento=@IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

DROP TABLE 	#QuitacaoToDelete



/*----------------------------------------------------------------*/
/*      	Deleta o pagamento no GroupCost			  */
/*----------------------------------------------------------------*/

DELETE GroupCost
WHERE IDCostType = 4 AND
   IDTouristGroup IN
  (SELECT 	IDTouristGroup
   FROM 	dbo.TouristGroup TG
   WHERE	TG.IDLancPagAgencia = @IDLancamento )

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*		Deleta o pagamento nos grupos			  */
/*----------------------------------------------------------------*/
UPDATE
	TouristGroup
SET	
	IDLancPagAgencia = NULL
WHERE
	IDAgency = @IDAgency
 	AND
	IDLancPagAgencia = @IDLancamento


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_DelPayAgency', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Commission_PayAgency 
		(
		@IDStore		int,
		@IDAgency 		int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente	int,
		@Commission		money,
		@Adjust		money,
		@DataIni		smalldatetime,
		@DataFim		smalldatetime,
		@IDUser		int,
		@IDLancamento	int	output
		)
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-201  Erro em Centro Custo
		-202  Erro em Insert Fin_Lancamento
		-203  Erro em Insert Fin_Quitacao
		-204  Erro em Insert Fin_LancQuit
		-205  Erro em Insert Fin_GroupCoast
		-206  Erro em Update TouristGoup

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 Maio 2000		Eduardo Costa		suporte ao novo financeiro;
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaração do Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDQuitacao		int
DECLARE @IDCentroCusto	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int

--Declaração de variáveis para o Cursor de GroupCost
DECLARE @IDCost 		int
DECLARE @IDTouristGroup 	int 
DECLARE @IDCostType 	int 
DECLARE @CostDate 		smalldatetime 
DECLARE @UnitCost 		money 
DECLARE @Quantity 		float 
DECLARE @SysError		int

if not (@IDAgency > 0)
   return

BEGIN TRAN


/*----------------------------------------------------------------*/
/*	Inclui o registro do pagamento  	*/ 
/*----------------------------------------------------------------*/
/*
	Descobre o Centro de Custo
*/ 

SELECT 	
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM 	
	Store S (NOLOCK)
WHERE 	
	S.IDStore = @IDStore

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*
   	Inclui o Lancamento
*/
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
exec sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento
		(
		IDLancamento,
		IDLancamentoTipo,
		Pagando,
		IDCentroCusto,
		IDPessoaTipo,
		IDPessoa,
		IDEmpresa,
		IDUsuarioLancamento,
		IDDocumentoTipo,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal
		)
		VALUES
		(
		@IDLancamento,
		6, --  \\Despesa\Comissoes\Pagamento Comissoes
		1,
		@IDCentroCusto,
		6, -- Agency
		@IDAgency,
		@IDEmpresa,
		@IDUser,
		0, -- Temporario
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar 
		@PayDate,
		@PayDate,
		@Commission
		)

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*
   	Inclui a quitacao
*/
/******************************************************************************
	Obtenho o @IDQuitacao
*******************************************************************************/
exec sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT
INSERT	
		Fin_Quitacao
		(
		IDQuitacao,
		DataQuitacao,
		Pagando,
		ValorQuitacao,
		IDQuitacaoMeio,
		ValorJuros,
		IDContaCorrente,
		IDUsuarioQuitacao
		)
VALUES
		(
		@IDQuitacao,
		@PayDate,
		1,
		@Commission,
		@IDMeioPag,
		0,
		@IDContaCorrente,
		@IDUser
		)

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*
	Liga as duas
*/
INSERT	Fin_LancQuit
		(
		IDLancamento,
		IDQuitacao,
		ValorQuitado,
		ValorJuros,
		IDUsuarioQuitacao
		)
		VALUES
		(	
		@IDLancamento,
		@IDQuitacao,
		@Commission,
		0,
		@IDUser
		)

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/*----------------------------------------------------------------------------------------------------------------------*/
/*		Inclui o Cost no GroupCost			 	 */
/*----------------------------------------------------------------------------------------------------------------------*/
--Declaração do Cursor de GroupCost
DECLARE GroupCost_Cursor CURSOR FOR

SELECT
	TG.IDTouristGroup,
	4, -- Agency Commission
	MIN(TG.EnterDate),
	SUM(IsNull(C.MovCommission* (TG.ComissaoSobreGuia/100), 0)) * @Adjust,
	1
FROM
	TouristGroup TG (NOLOCK)
	JOIN Pessoa PG (NOLOCK)
		ON (TG.IDGuide = PG.IDPessoa)
	JOIN Invoice I (NOLOCK)
		ON (TG.IDTouristGroup = I.IDTouristGroup)
	JOIN vwCommission C (NOLOCK)
		ON (C.DocumentID = I.IDInvoice AND C.InventMovTypeID=1 AND PG.IDTipoPessoa = C.IDTipoPessoa)
WHERE
	TG.IDAgency = @IDAgency
	AND
	TG.EnterDate >= @DataIni
	AND
	TG.EnterDate <  @DataFim			
	AND
	TG.IDLancPagAgencia IS NULL			
GROUP BY 
	TG.IDTouristGroup

--Abertura do Cursor
OPEN GroupCost_Cursor 

--Inicialização de GroupCost_Cursor
FETCH NEXT FROM GroupCost_Cursor INTO
	@IDTouristGroup,
	@IDCostType,
	@CostDate,
	@UnitCost,
	@Quantity

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	exec sp_Sis_GetNextCode 'GroupCost.IDCost', @IDCost OUTPUT

	INSERT GroupCost
		(
		IDCost,
		IDTouristGroup,
		IDCostType,
		CostDate,
		UnitCost,
		Quantity
		)
	VALUES
		(
		@IDCost,
		@IDTouristGroup,
		@IDCostType,
		@CostDate,
		@UnitCost,
		@Quantity	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0  
	BEGIN
		CLOSE GroupCost_Cursor
		DEALLOCATE GroupCost_Cursor
		SET @ErrorLevel = -205
		GOTO ERRO
	END
	FETCH NEXT FROM GroupCost_Cursor INTO
		@IDTouristGroup,
		@IDCostType,
		@CostDate,
		@UnitCost,
		@Quantity
END
--fechamento do cursor
CLOSE GroupCost_Cursor
--Destruição do cursor
DEALLOCATE GroupCost_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END



/*----------------------------------------------------------------*/
/*		Registra o pagamento nos grupos			  */
/*----------------------------------------------------------------*/
UPDATE	
	TouristGroup
SET	
	IDLancPagAgencia = @IDLancamento
WHERE
	IDAgency = @IDAgency 	
	AND
	EnterDate >= @DataIni	
	AND
	EnterDate <  @DataFim	
	AND
	IDLancPagAgencia IS NULL

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


OK:
	COMMIT TRAN 
	RETURN 0

ERRO:
	ROLLBACK TRAN 
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_PayAgency', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Commission_PayGuide
		(
		@IDStore		int,
		@IDGuide 		int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente	int,
		@Commission		money,
		@Adjust		money,
		@DataIni		smalldatetime,
		@DataFim		smalldatetime,
		@IDTouristGroup	int,
		@IDUser		int,
		@Date			DateTime,
		@IDLancamento	int output
		)
AS



/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-201  Erro em Select Centro Custo
		-202  Erro em Insert Fin_Lancamento
		-203  Erro em Insert Fin_Quitacao
		-204  Erro em Insert Fin_LancQuit
		-205  Erro em Insert Fin_GroupCoast
		-206  Erro em Update TouristGoup
		-207  Erro em Insert TouristGroup

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 Maio 2000		Eduardo Costa		suporte ao novo financeiro;
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaração de GroupCost_Cursor
							Declaração de TouristGroup_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE  	@IDQuitacao		int
DECLARE	@IDCentroCusto	int
DECLARE 	@IDEmpresa		int
DECLARE 	@ErrorLevel		int
DECLARE	@SysError		int

--Declaração de variáveis para o Cursor de GroupCost
DECLARE @IDCost 		int
DECLARE @IDCostType 	int 
DECLARE @CostDate 		smalldatetime 
DECLARE @UnitCost 		money 
DECLARE @Quantity 		float 

--Declaração de variáveis para o Cursor de TouristGroup
DECLARE @TipTouristGroup 		varchar(50)
DECLARE @IDAgency 			int 
DECLARE @EnterDate 			smalldatetime 
DECLARE @NumTourist 		int 
DECLARE @ComissaoSobreGuia 	money 
DECLARE @DescontaCoordenacao 	bit  
DECLARE @Permanente 		bit 
DECLARE @DiasValidade 		int 
DECLARE @TipGuide 			varchar(30)
DECLARE @TipAgency 			varchar(30)
DECLARE @IDHotel 			int 

IF NOT (@IDGuide > 0)
   RETURN

BEGIN TRAN


/*----------------------------------------------------------------*/
/*		Inclui o registro do pagamento			  */ 
/*----------------------------------------------------------------*/
/*
	Descobre o Centro de Custo
*/ 

SELECT 	
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM 	
	Store S (NOLOCK)
WHERE 	
	S.IDStore = @IDStore

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*
   	Inclui o Lancamento
*/
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento
		(
		IDLancamento,
		IDLancamentoTipo,
		Pagando,
		IDCentroCusto,
		IDPessoaTipo,
		IDPessoa,
		IDDocumentoTipo,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal,
		IDEmpresa,
		IDUsuarioLancamento
		)
		VALUES
		(
		@IDLancamento,
		6, --  \\Despesa\Comissoes\Pagamento Comissoes
		1,
		@IDCentroCusto,
		5, -- Guide
		@IDGuide,
		0, -- Temporario
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar 
		@PayDate,
		@PayDate,
		@Commission,
		@IDEmpresa,
		@IDUser
		)		

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*
   	Inclui a quitacao
*/
/******************************************************************************
	Obtenho o @IDQuitacao
*******************************************************************************/
EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT
INSERT	Fin_Quitacao
		(
		IDQuitacao,
		DataQuitacao,
		Pagando,
		ValorQuitacao,
		IDQuitacaoMeio,
		ValorJuros,
		IDContaCorrente,
		IDUsuarioQuitacao
		)
		VALUES
		(
		@IDQuitacao,
		@PayDate,
		1,
		@Commission,
		@IDMeioPag,
		0,
		@IDContaCorrente,
		@IDUser
		)


SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END



/*
	Liga as duas
*/
INSERT	Fin_LancQuit
		(
		IDLancamento,
		IDQuitacao,
		ValorQuitado,
		ValorJuros,
		IDUsuarioQuitacao
		)
		VALUES
		(	
		@IDLancamento,
		@IDQuitacao,
		@Commission,
		0,
		@IDUser
		)

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*		Inclui o Cost no GroupCost			  */
/*----------------------------------------------------------------*/
--Declaração do Cursor de GroupCost
DECLARE GroupCost_Cursor CURSOR FOR
SELECT
	TG.IDTouristGroup,
	3, -- Guide Commission
	MIN(TG.EnterDate),
	SUM(IsNull( C.MovCommission * (1-(TG.ComissaoSobreGuia*TG.DescontaCoordenacao/100)) ,0)) * @Adjust,
	1
FROM
	TouristGroup TG (NOLOCK)
	JOIN Pessoa P (NOLOCK)
		ON (TG.IDGuide = P.IDPessoa)
	JOIN Invoice I (NOLOCK)
		ON (TG.IDTouristGroup = I.IDTouristGroup)
	JOIN vwCommission C (NOLOCK)
		ON (C.DocumentID = I.IDInvoice AND C.InventMovTypeID=1 AND P.IDTipoPessoa = C.IDTipoPessoa)
WHERE
	TG.IDGuide = @IDGuide
	AND
	TG.EnterDate >= @DataIni
	AND
	TG.EnterDate <  @DataFim			
	AND
	TG.IDLancPagGuia IS NULL			
GROUP BY 
	TG.IDTouristGroup

--Abertura do Cursor
OPEN GroupCost_Cursor 

--Inicialização de GroupCost_Cursor
FETCH NEXT FROM GroupCost_Cursor INTO
	@IDTouristGroup,
	@IDCostType,
	@CostDate,
	@UnitCost,
	@Quantity

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'GroupCost.IDCost', @IDCost OUTPUT
	INSERT GroupCost
		(
		IDCost,
		IDTouristGroup,
		IDCostType,
		CostDate,
		UnitCost,
		Quantity
		)
	VALUES
		(
		@IDCost,
		@IDTouristGroup,
		@IDCostType,
		@CostDate,
		@UnitCost,
		@Quantity
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0  
	BEGIN
		CLOSE GroupCost_Cursor
		DEALLOCATE GroupCost_Cursor
		SET @ErrorLevel = -205
		GOTO ERRO
	END
	FETCH NEXT FROM GroupCost_Cursor INTO
		@IDTouristGroup,
		@IDCostType,
		@CostDate,
		@UnitCost,
		@Quantity
END

--fechamento do cursor
CLOSE GroupCost_Cursor
--Destruição do cursor
DEALLOCATE GroupCost_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


/*----------------------------------------------------------------*/
/*		Registra o pagamento nos grupos			  */
/*----------------------------------------------------------------*/
UPDATE	
	TouristGroup
SET	
	IDLancPagGuia = @IDLancamento
WHERE	
	IDTouristGroup = IsNull(@IDTouristGroup, IDTouristGroup) 
	AND
	IDGuide = @IDGuide 	 	AND
	EnterDate >= @DataIni	
	AND
	EnterDate <  @DataFim	
	AND
	IDLancPagGuia IS NULL	


SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

 

/*-------------------------------------------------------------------*/

/* Inclui um segundo grupo com as mesmas caracteristicas do primeiro */
/*-------------------------------------------------------------------*/
--Declaração do Cursor de TouristGroup
DECLARE TouristGroup_Cursor CURSOR FOR

		SELECT	
			TipTouristGroup, 
			IDGuide, 
			IDAgency, 
			EnterDate, 
			IDStore,
			NumTourist,
			ComissaoSobreGuia,
			DescontaCoordenacao,
			IDUser,
			Permanente,
			DiasValidade,
			TipGuide,
			TipAgency,
			IDHotel

		FROM	
			TouristGroup (NOLOCK)
		WHERE	
			IDLancPagGuia = @IDLancamento
			AND
			(
   			  (
      			    ( EnterDate >= dateadd(hour, -6,  @Date) )
      		    	    AND
      			    ( dateadd(day, - DiasValidade, EnterDate) < dateadd(hour, -6,  @Date) )
   			  )
   			  OR
   			  ( Permanente = 1 )
			)	
OPEN TouristGroup_Cursor

--Inicialização de TouristGroup_Cursor
FETCH NEXT FROM TouristGroup_Cursor INTO
	@TipTouristGroup,
	@IDGuide,
	@IDAgency,
	@EnterDate,
	@IDStore,
	@NumTourist,
	@ComissaoSobreGuia,
	@DescontaCoordenacao,
	@IDUser,
	@Permanente,
	@DiasValidade,
	@TipGuide,
	@TipAgency,
	@IDHotel
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'TouristGroup.IDTouristGroup', @IDTouristGroup OUTPUT
	INSERT TouristGroup
		(
		IDTouristGroup,
		TipTouristGroup,
		IDGuide,
		IDAgency,
		EnterDate,
		IDStore,
		NumTourist,
		ComissaoSobreGuia,
		DescontaCoordenacao,
		IDUser,
		Permanente,
		DiasValidade,
		TipGuide,
		TipAgency,
		IDHotel
		)
	VALUES
		(
		@IDTouristGroup,
		@TipTouristGroup,
		@IDGuide,
		@IDAgency,
		@EnterDate,
		@IDStore,
		@NumTourist,
		@ComissaoSobreGuia,
		@DescontaCoordenacao,
		@IDUser,
		@Permanente,
		@DiasValidade,
		@TipGuide,
		@TipAgency,
		@IDHotel	
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0  
	BEGIN
		CLOSE TouristGroup_Cursor
		DEALLOCATE TouristGroup_Cursor
		SET @ErrorLevel = -206
		GOTO ERRO
	END

	FETCH NEXT FROM TouristGroup_Cursor INTO
		@TipTouristGroup,
		@IDGuide,
		@IDAgency,
		@EnterDate,
		@IDStore,
		@NumTourist,
		@ComissaoSobreGuia,
		@DescontaCoordenacao,
		@IDUser,
		@Permanente,
		@DiasValidade,
		@TipGuide,
		@TipAgency,
		@IDHotel
END

--fechamento do cursor
CLOSE TouristGroup_Cursor
--Destruição do cursor
DEALLOCATE TouristGroup_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END



OK:
	COMMIT TRAN 
	RETURN 0
ERRO:
	ROLLBACK TRAN 
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_PayGuide', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Commission_PayOther
		(
		@IDStore		int,
		@IDOtherComission	int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente	int,
		@Commission		money,
		@DataIni		smalldatetime,
		@DataFim		smalldatetime,
		@IDUser		int,
		@IDLancamento	int output
		)
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-201  Erro em Select Centro Custo
		-202  Erro em Insert Fin_Lancamento
		-203  Erro em Insert Fin_Quitacao
		-204  Erro em Update Invoice

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 Maio 2000		Eduardo Costa		suporte ao novo financeiro;
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode;
							Removed SELECT @IDQuitacao = MAX(IDQuitacao) FROM Fin_Quitacao
 	18 Aug 2004		Rodrigo Costa		Gravar error log
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


 
DECLARE @IDQuitacao		int
DECLARE @IDCentroCusto	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

IF not (@IDOtherComission > 0)
   RETURN

BEGIN TRAN

/*----------------------------------------------------------------*/
/*		Inclui o registro do pagamento			  */
/*----------------------------------------------------------------*/
/*
	Descobre o Centro de Custo e Empresa
*/

SELECT 	
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM 	
	Store S (NOLOCK)
WHERE 	
	S.IDStore = @IDStore


SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*
   	Inclui o Lancamento
*/
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento
		(
		IDLancamento,
		IDLancamentoTipo,
		Pagando,
		IDCentroCusto,
		IDPessoaTipo,
		IDPessoa,
		IDDocumentoTipo,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal,
		IDEmpresa,
		IDUsuarioLancamento
		)
		VALUES
		(
		@IDLancamento,
		6, --  \\Despesa\Comissoes\Pagamento Comissoes
		1,
		@IDCentroCusto,
		9, -- Other
		@IDOtherComission,
		0, -- Temporario
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar 
		@PayDate,
		@PayDate,
		@Commission,
		@IDEmpresa,
		@IDUser
		)

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*
   	Inclui a quitacao
*/
/******************************************************************************
	Obtenho o @IDQuitacao
*******************************************************************************/
EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT
INSERT	Fin_Quitacao
		(
		IDQuitacao,
		DataQuitacao,
		Pagando,
		ValorQuitacao,
		IDQuitacaoMeio,
		ValorJuros,
		IDContaCorrente,
		IDUsuarioQuitacao
		)
		VALUES
		(
		@IDQuitacao,
		@PayDate,
		1,
		@Commission,
		@IDMeioPag,
		0,
		@IDContaCorrente,
		@IDUser
		)

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*
	Liga as duas
*/

INSERT	Fin_LancQuit
		(
		IDLancamento,
		IDQuitacao,
		ValorQuitado,
		ValorJuros,
		IDUsuarioQuitacao
		)
		VALUES
		(	
		@IDLancamento,
		@IDQuitacao,
		@Commission,
		0,
		@IDUser
		)



SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/*----------------------------------------------------------------*/
/*	Registra o pagamento nas linhas de inventario             */
/*----------------------------------------------------------------*/
UPDATE	
	Invoice
SET	
	IDLancPagOtherCom = @IDLancamento
FROM	
	InventoryMov (NOLOCK)
WHERE
	InventoryMov.DocumentID = Invoice.IDInvoice     
	AND
	InventoryMov.InventMovTypeID = 1 		
	AND
	InventoryMov.MovDate >= @DataIni		
	AND
	InventoryMov.MovDate <  @DataFim		
	AND
	Invoice.OtherComissionID = @IDOtherComission 	
	AND
	Invoice.IDLancPagOtherCom IS NULL

OK:
	COMMIT TRAN 
	RETURN 0

ERRO:
	ROLLBACK TRAN 
	PRINT CAST(@ErrorLevel AS VARCHAR) 

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_PayOther', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Commission_PayVendedor
	(
	@IDStore		int,
	@IDVendedor		int,
	@PayDate		smalldatetime,
	@IDMeioPag		int,
	@IDContaCorrente	int,
	@Commission		money,
	@DataIni		smalldatetime,
	@DataFim		smalldatetime,
	@IDUser			int,
	@IsPre			bit,
	@IsPaid			bit,
	@IDLancamento		int output
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Seleciono os Centro de Custo
		- Incluo no Fin_Lancamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Select Centro Custo
		-202  Erro em Insert Fin_Lancamento
		-203  Erro em Insert Fin_Quitacao
		-204  Erro em Insert ComisPaga InvMov
		-206  Erro em Insert ComisPaga PreInvMov

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		Suporte ao novo financeiro;
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	08 Apr	2005		Rodrigo Costa		Gravar Comis Pag para PreInvMov;
	10 Sep	2007		Maximiliano Muniz	Insert de pagamento para pedidos pagos conforme novo parametro;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDQuitacao	int
DECLARE @IDCentroCusto	int
DECLARE @IDEmpresa	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int

IF NOT (@IDVendedor > 0)
	RETURN

BEGIN TRAN

-- Pega as constantes
SELECT 	
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM
	Store S (NOLOCK)
	JOIN MeioPagToStore MPS (NOLOCK) ON (S.IDStore = MPS.IDStore)
WHERE
	S.IDStore = @IDStore
	AND MPS.IDMeioPag = @IDMeioPag

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

----------------------------------------------------------
--		Inclui o registro do pagamento		--
----------------------------------------------------------

-- Obtenho o @IDLancamento
exec sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT

INSERT Fin_Lancamento
		(
		IDLancamento,
		IDLancamentoTipo,
		Pagando,
		IDCentroCusto,
		IDEmpresa,
		IDPessoaTipo,
		IDPessoa,
		IDDocumentoTipo,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal,
		IDUsuarioLancamento,
		Situacao
		)
		VALUES
		(
		@IDLancamento,
		6, --  \\Despesa\Comissoes\Pagamento Comissoes
		1,
		@IDCentroCusto,
		@IDEmpresa,
		4, -- Sales Person
		@IDVendedor,
		0, -- Temporario
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar 
		@PayDate,
		@PayDate,
		@Commission,
		@IDUser,
		1 -- Situacao esta aberto
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

--------------------------------------------------
--		Inclui a quitacao		--
--------------------------------------------------

-- Obtenho o @IDQuitacao
exec sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT

INSERT	Fin_Quitacao
		(
		IDQuitacao,
		DataQuitacao,
		Pagando,
		ValorQuitacao,
		IDQuitacaoMeio,
		ValorJuros,
		IDContaCorrente,
		IDUsuarioQuitacao
		)
		VALUES
		(
		@IDQuitacao,
		@PayDate,
		1,
		0, --Valor da comissao tem que ser 0, pois a trigger da LancQuit vai atualizar esse valor
		@IDMeioPag,
		0,
		@IDContaCorrente,
		@IDUser
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

-- Liga as duas
INSERT	Fin_LancQuit
		(
		IDLancamento,
		IDQuitacao,
		ValorQuitado,
		ValorJuros,
		IDUsuarioQuitacao
		)
		(
		SELECT
			L.IDLancamento,
			@IDQuitacao,
			(L.ValorNominal - L.TotalQuitado),
			0,
			@IDUser
		FROM
			Fin_Lancamento L (NOLOCK)
		WHERE
			L.IDPessoa = @IDVendedor
			AND L.Situacao in (1, 5) --1=Aberto, 5=ParteQuitado
			AND	(
				L.IDLancamento = @IDLancamento
				OR L.IDLancamentoTipo = 3 -- Correcao de comissao
				OR L.IDLancamentoTipo = 5 -- Extorno de comissao
				)
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

--------------------------------------------------------------------------
--		Registra o pagamento nas linhas de inventario		--
--------------------------------------------------------------------------
IF @IsPre = 0
BEGIN
	INSERT ComisPaga
		(
		IDDocumento,
		IDLancPag
		)
		SELECT
			IM.PreInventoryMovID,
			@IDLancamento
		FROM
			InventoryMov IM (NOLOCK)
			JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDInventoryMov = IM.IDInventoryMov)
			JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID)
			LEFT OUTER JOIN ComisPaga CP ON (IM.IDInventoryMov = CP.IDDocumento )
		WHERE
			SIC.IDCommission = @IDVendedor
			AND IM.InventMovTypeID = 1
			AND I.InvoiceDate >= @DataIni
			AND I.InvoiceDate < @DataFim
			AND CP.IDLancPag IS NULL

	SET @SysError = @@ERROR
	IF @SysError <> 0  
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
END
ELSE
BEGIN
	IF @IsPaid = 0
	BEGIN
		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag
			)
			SELECT
				IM.PreInventoryMovID,
				@IDLancamento
			FROM
				InventoryMov IM (NOLOCK)
				JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDInventoryMov = IM.IDInventoryMov)
				JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (IM.IDInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND IM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL

		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag
			)
			SELECT
				PIM.IDPreInventoryMov,
				@IDLancamento
			FROM
				PreInventoryMov PIM (NOLOCK)
				JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)
				JOIN Invoice I (NOLOCK) ON (I.IDPreSale = PIM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (PIM.IDPreInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND PIM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -206
			GOTO ERRO
		END
	END
	ELSE
	BEGIN
		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag
			)
			SELECT
				IM.PreInventoryMovID,
				@IDLancamento
			FROM
				InventoryMov IM (NOLOCK)
				JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDInventoryMov = IM.IDInventoryMov)
				JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (IM.IDInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND IM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL
				AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento (NOLOCK))

		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag
			)
			SELECT
				PIM.IDPreInventoryMov,
				@IDLancamento
			FROM
				PreInventoryMov PIM (NOLOCK)
				JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)
				JOIN Invoice I (NOLOCK) ON (I.IDPreSale = PIM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (PIM.IDPreInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND PIM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL
				AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento (NOLOCK))

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -206
			GOTO ERRO
		END
	END
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_PayVendedor', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Cotation_CreatePO
	(
	@IDCotacao	int,
	@IDFornecedor	int,
	@IDStore	int,
	@IDUser	int,
	@Date		DateTime
	)

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Crio os PO para os itens marcados de uma cotacao
		Caso seja passado um iDFornecedor, somente crio para ele, senão para todos

		- Teste se existe algum PO aberto
		- Incluo os Itens
		- Atualiza o total do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Teste se existe algum PO aberto
		-202  Erro em Incluo os Itens
		-203  Erro em Atualiza o total do PO


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	01 June 2001		Rodrigo Costa   	Coloquei o SubTotal na PO
	25 June 2001		Davi Gouveia		Log de Return Values
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Delcaração de PreInventoryMov_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @PO			int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @IDPreInventoryMov 	int
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 		float
DECLARE @CostPrice 		money 
DECLARE @IDPessoa 		int 
DECLARE @UserID 		int 

SET @ErrorLevel = 0

-- Teste se existe algum PO aberto
IF EXISTS
	(
	SELECT
		IDPO
	FROM
		PO (NOLOCK)
	WHERE
		PO.IDFornecedor = @IDFornecedor
		AND
		PO.IDStore = @IDStore
		AND
		PO.Aberto = 1
	)
	BEGIN
		SELECT 
			@PO = PO.IDPO
		FROM
			PO
		WHERE
			PO.IDFornecedor = @IDFornecedor
			AND
			PO.IDStore = @IDStore
			AND
			PO.Aberto = 1
	END
ELSE
	BEGIN
		-- Obtenho IDPO e guardo em @PO
		EXEC sp_Sis_GetNextCode 'PO.IDPO', @PO OUTPUT
		INSERT 	PO (IDPO,IDFornecedor, DataPedido, IDStore, Aberto)
		VALUES	(@PO,@IDFornecedor, @Date, @IDStore, 1)
	END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


-- Incluo os Itens
--Declaração do Cursor de PreInventoryMov

DECLARE PreInventoryMov_Cursor CURSOR FOR

SELECT
	2,
	@PO,
	@IDStore,
	CR.IDModel,
	@Date,
	CTM.QtyCotada,
	CR.Cost,
	@IDFornecedor,
	@IDUser
FROM
	CotacaoResult CR (NOLOCK)
	JOIN CotacaoToModel CTM (NOLOCK) ON (CR.IDModel = CTM.IDModel AND CR.IDCotacao =CTM.IDCotacao)
WHERE
	CR.PO = 1
	AND
	CR.IDFornecedor = @IDFornecedor
	AND
	CR.IDCotacao = @IDCotacao

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@StoreID,
	@ModelID,
	@MovDate,
	@Qty,
	@CostPrice,
	@IDPessoa,
	@UserID
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		MovDate,
		DateEstimatedMov,
		Qty,
		CostPrice,
		IDPessoa,
		UserID
		)
	VALUES 
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@MovDate,
		@Qty,
		@CostPrice,
		@IDPessoa,
		@UserID	
		)

	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@Qty,
		@CostPrice,
		@IDPessoa,
		@UserID
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualiza o total do PO

EXEC sp_PO_AtuPOTotal @PO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Cotation_CreatePO', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Fin_CriaLacamento_Disburse
	(
	@IDLancamentoParent 	int,
	@Total			money,
	@NumDuplicata		varchar(20),
	@IDLancamentoTipo	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo as informacoes dos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000	Ok
		-201	Erro em incluo o lancamento Disbursement

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-------------------------------------------------------------------------------------------------------------------------------------
	13 May	2002		Rodrigo Costa		Criacao
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaração de Fin_Lancamento_Cursor
	18 Aug	2004		Rodrigo Costa		Gravar error log
	24 Dez	2004		Rodrigo Costa		Novo parametro @IDLancamentoTipo
	22 Feb	2006		Maximiliano Muniz	Removido o cursor Fin_Lancamento_Cursor
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamento		int

SET @ErrorLevel = 0

EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento
	(
	IDLancamento,
	Pagando,
	IDLancamentoTipo,
	DataLancamento,
	IDUsuarioLancamento,
	Previsao,
	Situacao,
	IDPessoaTipo,
	IDPessoa,
	IDEmpresa,
	DataVencimento,
	DataEmissao,
	IDDocumentoTipo,
	ValorNominal,
	NumDocumento,
	IDPurchase,
	IDMoeda,
	IDMoedaCotacao,
	LancamentoType,
	IDLancamentoParent,
	NumeroDuplicata
	)
	(
	SELECT
		@IDLancamento,
		LP.Pagando,
		@IDLancamentoTipo,
		LP.DataLancamento,
		LP.IDUsuarioLancamento,
		LP.Previsao,
		LP.Situacao,
		LP.IDPessoaTipo,
		LP.IDPessoa,
		LP.IDEmpresa,
		LP.DataVencimento,
		LP.DataEmissao,
		LP.IDDocumentoTipo,
		@Total,
		LP.NumDocumento,
		LP.IDPurchase,
		LP.IDMoeda,
		LP.IDMoedaCotacao,
		2, -- Lancamento Tipo Desdrobramento
		LP.IDLancamento,
		@NumDuplicata
	FROM
		Fin_Lancamento LP (NOLOCK)
	WHERE
		LP.IDLancamento = @IDLancamentoParent
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Fin_CriaLacamento_Disburse', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Fin_Transferencia_Do
	(
	@IDTransferencia	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto todas as quitacoes
		- Incluo de novo o debito
		- Incluo de novo o credito

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto todas as quitacoes
		-202  Erro em Incluo de novo o debito
		-203  Erro em Incluo de novo o credito


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
	19 Oct 2001		Rodrigo Costa		Colocado o IDTransferencia no insert da Fin_Quitacao
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Fin_Quitacao_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

-- Primeiro deleto todas as quitacoes
DELETE
	Q
FROM
	Fin_Quitacao Q
WHERE
	Q.IDTransferencia = @IDTransferencia

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

--Declaração de variáveis para o Cursor de Fin_Quitacao
DECLARE @IDQuitacao		int 
DECLARE @IDQuitacaoMeio 	int 
DECLARE @DataQuitacao 	smalldatetime 
DECLARE @IDContaCorrenteDebito 	int 
DECLARE @IDContaCorrenteCredito	int
DECLARE @IDUsuarioQuitacao 	int 
DECLARE @ValorQuitacao 	money 
DECLARE @ValorJuros 		money 
DECLARE @NumeroMeioQuit 	varchar(20)

--Declaração do Cursor de Fin_Quitacao

DECLARE Fin_Quitacao_Cursor CURSOR FOR

SELECT
		-1, -- Meio de pag de transferencia
		T.Data,
		T.IDContaCorrenteDebito,
		T.IDContaCorrenteCredito,
		T.IDUsuario,
		T.Valor,
		0,
		CONVERT(Varchar(20), T.IDTransferencia),
		T.IDTransferencia
	FROM
		Fin_Transferencia T (NOLOCK)
	WHERE
		T.IDTransferencia = @IDTransferencia
OPEN Fin_Quitacao_Cursor

--Inicialização de Fin_Quitacao_Cursor
FETCH NEXT FROM Fin_Quitacao_Cursor INTO
	@IDQuitacaoMeio,
	@DataQuitacao,
	@IDContaCorrenteDebito,
	@IDContaCorrenteCredito,
	@IDUsuarioQuitacao,
	@ValorQuitacao,
	@ValorJuros,
	@NumeroMeioQuit,
	@IDTransferencia
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
-- Agora Incluo de novo o debito
	EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT
	INSERT Fin_Quitacao
		(
		IDQuitacao,
		IDQuitacaoMeio,
		DataQuitacao,
		IDContaCorrente,
		IDUsuarioQuitacao,
		Pagando,
		ValorQuitacao,
		ValorJuros,
		NumeroMeioQuit,
		IDTransferencia
		)
	VALUES 
		(
		@IDQuitacao,
		@IDQuitacaoMeio,
		@DataQuitacao,
		@IDContaCorrenteDebito,
		@IDUsuarioQuitacao,
		1, --@Pagando 
		@ValorQuitacao,
		@ValorJuros,
		@NumeroMeioQuit,
		@IDTransferencia	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Fin_Quitacao_Cursor
		DEALLOCATE Fin_Quitacao_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

-- Agora Incluo de novo o credito
	EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT
	INSERT Fin_Quitacao
		(
		IDQuitacao,
		IDQuitacaoMeio,
		DataQuitacao,
		IDContaCorrente,
		IDUsuarioQuitacao,
		Pagando,
		ValorQuitacao,
		ValorJuros,
		NumeroMeioQuit,
		IDTransferencia
		)
	VALUES 
		(
		@IDQuitacao,
		@IDQuitacaoMeio,
		@DataQuitacao,
		@IDContaCorrenteCredito,
		@IDUsuarioQuitacao,
		0, --@Pagando 
		@ValorQuitacao,
		@ValorJuros,
		@NumeroMeioQuit,
		@IDTransferencia	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Fin_Quitacao_Cursor
		DEALLOCATE Fin_Quitacao_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	FETCH NEXT FROM Fin_Quitacao_Cursor INTO
		@IDQuitacaoMeio,
		@DataQuitacao,
		@IDContaCorrenteDebito,
		@IDContaCorrenteCredito,
		@IDUsuarioQuitacao,
		@ValorQuitacao,
		@ValorJuros,
		@NumeroMeioQuit,
		@IDTransferencia 
END
--fechamento do cursor
CLOSE Fin_Quitacao_Cursor
--Destruição do cursor
DEALLOCATE Fin_Quitacao_Cursor

OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Fin_Transferencia_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Financ_DelLanc
		(
		@IDLancamento	int
		)

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto Lancamento/Quitacao
		- Deleto Quitacao
		- Deleto Lancamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Delete from InventoryMov
		-202  Erro em Insert InventoryMov Send to Vendor
		-203  Erro em Insert InvMov Back From Vendor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	16 Nov  1999		Eduardo Costa		Criacao;
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN


SELECT
	LQ.IDQuitacao
INTO
	#QuitacaoToDelete
FROM
	Fin_LancQuit LQ (NOLOCK)
WHERE
	LQ.IDLancamento = @IDLancamento

-- Deleto Lancamento/Quitacao
DELETE
	Fin_LancQuit
WHERE
	IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Deleto Quitacao
DELETE
	Q
FROM
	Fin_Quitacao (NOLOCK)
	JOIN
	#QuitacaoToDelete QTD ON (Q.IDQuitacao = QTD.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

-- Deleto Lancamento
DELETE
	Fin_Lancamento
WHERE
	IDLancamento=@IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

DROP TABLE 	#QuitacaoToDelete


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Financ_DelLanc', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inv_AdjustAvgCost
	(
	@ModelID	int
	)
AS

DECLARE @IDModel 	int
DECLARE @Qty		float
DECLARE @CostPrice	money

DECLARE @LastQty	float
DECLARE @LastCost	money
DECLARE @AvgCost	money
DECLARE @MovDate	DateTime
DECLARE @IDInvMov	int
DECLARE @InventMovTypeID	int

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

ALTER TABLE InventoryMov DISABLE TRIGGER ALL 

BEGIN TRAN

SET @LastQty = 0
SET @LastCost = 0
SET @AvgCost = 0

DECLARE AVG_Cursor CURSOR FOR

	SELECT
		Inv.IDInventoryMov,
		Inv.InventMovTypeID,
		Inv.ModelID,
		((2*IMT.UpdateOnHand-1) * Inv.Qty) as Qty,
		Inv.CostPrice,
		Inv.MovDate
	FROM
		InventoryMov Inv (NOLOCK)
		INNER JOIN InventoryMovType IMT (NOLOCK) ON (Inv.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		Inv.ModelID = @ModelID
	ORDER BY
		Inv.MovDate

OPEN AVG_Cursor

--Inicialização de AVG_Cursor
FETCH NEXT FROM AVG_Cursor INTO
	@IDInvMov,
	@InventMovTypeID,
	@IDModel,
	@Qty,
	@CostPrice,
	@MovDate
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	if (@InventMovTypeID = 2)
		SET @AvgCost = CASE WHEN (@Qty + @LastQty) <= 0 THEN 0 ELSE (((@LastQty * @LastCost) + (@Qty * @CostPrice)) / (@Qty + @LastQty)) END

	SET @LastQty = @LastQty + @Qty
	IF ((@InventMovTypeID = 2) OR (@InventMovTypeID in(4,5) AND @CostPrice <> 0)) -- Compra e importado
	BEGIN
		SET @LastCost = @CostPrice

		IF (@AvgCost = 0)
			SET @AvgCost = @CostPrice
	END

	/*
	SELECT 
		@IDInvMov as IDInvMov, 
		@MovDate as MovDate, 
		@Qty as Qty, 
		@LastQty as Balance, 
		@AvgCost as AvgCost, 
		@CostPrice as CostPrice*/

	UPDATE 
		InventoryMov
	SET 
		AvgCost = @AvgCost
	WHERE
		IDInventoryMov = @IDInvMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE AVG_Cursor
		DEALLOCATE AVG_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END


	FETCH NEXT FROM AVG_Cursor INTO
		@IDInvMov,
		@InventMovTypeID,
		@IDModel,
		@Qty,
		@CostPrice,
		@MovDate
	
END
--fechamento do cursor
CLOSE AVG_Cursor
--Destruição do cursor
DEALLOCATE AVG_Cursor

IF (@AvgCost <> 0)
	UPDATE 
		Model
	SET
		AvgCost = @AvgCost
	WHERE
		IDModel = @ModelID

SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	COMMIT TRAN
	ALTER TABLE InventoryMov ENABLE TRIGGER ALL 
	RETURN 0
ERRO:
	ROLLBACK TRAN
	ALTER TABLE InventoryMov ENABLE TRIGGER ALL 

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inv_AdjustAvgCost', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inv_AdjustAvgCostInventory 
	(
	@IDModel int, 
	@IDStore int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Zera Valores de AvgCost e AvgCostTotal no Inventory
		- Atualiza o AvgCostTotal ( e AvgCost se necessário ) no Inventory

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Zera Valores de AvgCost e AvgCostTotal no Inventory
		-202  Erro em Atualiza o AvgCostTotal ( e AvgCost se necessário ) no Inventory
		-203  Erro em Atualiza AvgCost no InventoryMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------------- ----------------------- -------------------------------- -----------------------------------------------------------------------------------------------------
	23 Jun  2006		Carlos Lima		Criação
    	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDInventoryMov			int
DECLARE @IDPreInventoryMov		int

DECLARE @InventMovTypeID		int
DECLARE @Qty				float
DECLARE @CostPrice			float
DECLARE @MovFactor			float
DECLARE @DocumentID			int


DECLARE @QtyInventory			float

DECLARE @AvgCostTotalInventory		float

DECLARE @CostPriceInventory		float

DECLARE @AvgCostInventory		float
DECLARE @AvgCostInvMov		float

DECLARE @NomeMov			varchar(60)

DECLARE @ErrorLevel 			int
DECLARE @SysError			int
DECLARE @PrintDebug			bit

DECLARE @TransactionName		varchar(60)

SET @ErrorLevel = 0

SET @PrintDebug = 0

SET @TransactionName = 'Tran_sp_Inv_AdjustAvgCostInventory'

BEGIN TRANSACTION @TransactionName

SET @AvgCostTotalInventory = 0


/* Tratar */

UPDATE	
	Inventory
SET
	AvgCostTotal	= 0,
	StoreAvgPrice 	= 0
WHERE
	ModelID = @IDModel
	AND
	StoreID = @IDStore

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END



SET @QtyInventory = 0

DECLARE AVG_CUR CURSOR FOR 
SELECT
	IMV.PreInventoryMovID,
	IMV.IDInventoryMov,
	IMV.InventMovTypeID,
	(2*IMT.UpdateOnHand-1) * IsNull(IMV.Qty, 0),
	IsNull(IMV.CostPrice, 0),
	(2*IMT.UpdateOnHand-1),
	IMV.DocumentID,
	IMT.name

FROM
	InventoryMov IMV (NOLOCK) 
	INNER JOIN InventoryMovType IMT (NOLOCK) ON (IMV.InventMovTypeID = IMT.IDInventMovType)
WHERE
	ModelID = @IDModel
	AND
	StoreID = @IDStore
ORDER BY
	IMV.IDInventoryMov

OPEN AVG_CUR

FETCH NEXT FROM AVG_CUR INTO
	@IDPreInventoryMov,
	@IDInventoryMov,
	@InventMovTypeID,
	@Qty,
	@CostPrice,
	@MovFactor,
	@DocumentID,
	@NomeMov

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT
		@AvgCostTotalInventory	= IsNull(AvgCostTotal, 0)
	FROM
		Inventory
	WHERE
		ModelID = @IDModel
		AND
		StoreID = @IDStore

	/* Zera os valores, caso a movimentação zere o estoque */
	IF (@QtyInventory + @Qty) = 0
		BEGIN
			SET @AvgCostInventory = 0
			SET @AvgCostTotalInventory = 0

		END


	IF @MovFactor = 1
		BEGIN
			IF (@QtyInventory + @Qty) = 0
			BEGIN
				SET @AvgCostInvMov = @CostPrice
			END
			
			ELSE
				BEGIN
					/* 
						Se for Entrada por transferencia, pega o custo médio salvo 
						na saida como preco de custo 
					*/

					IF @InventMovTypeID = 8
						BEGIN
							SELECT
								@CostPriceInventory = IsNull(AvgCost, 0)
							FROM
								ModelTransf MT (NOLOCK)  INNER JOIN
								ModelTransfDet MTD (NOLOCK)  ON (MT.IDModelTransf = MTD.IDModelTransf)
							WHERE	
								
								MT.IDModelTransf = @DocumentID
								AND
								MTD.IDModelTransfDet = @IDPreInventoryMov						

						END
					ELSE
						BEGIN
							SET @CostPriceInventory = IsNull(@CostPrice, 0)
						END
	
	
					SET @AvgCostInventory = (@AvgCostTotalInventory + (@Qty * IsNull(@CostPriceInventory, 0))) / (@QtyInventory + @Qty)
					SET @AvgCostTotalInventory = @AvgCostTotalInventory + (@Qty * IsNull(@CostPriceInventory, 0))

					SET @AvgCostInvMov = @AvgCostInventory
				END
	
			
			SET @QtyInventory = @QtyInventory + @Qty
	
			UPDATE 
				Inventory 
			SET 
				StoreAvgPrice	= @AvgCostInventory,
				AvgCostTotal	= @AvgCostTotalInventory
			WHERE
				ModelID = @IDModel
				AND
				StoreID = @IDStore

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE AVG_CUR
				DEALLOCATE AVG_CUR

				SET @ErrorLevel = -202
				GOTO ERRO
			END

	
		END
	ELSE
		BEGIN

			SELECT 
				@AvgCostInvMov = CASE WHEN IsNull(StoreAvgPrice, 0) = 0 THEN IsNull(@CostPrice, 0) ELSE StoreAvgPrice END
			FROM
				Inventory
			WHERE
				ModelID = @IDModel
				AND
				StoreID = @IDStore

			IF (@QtyInventory + @Qty) <> 0
				BEGIN
					/* 
						Se for Entrada por transferencia, pega o custo médio salvo na 
						saída como preco de custo 
					*/
					IF @InventMovTypeID = 7
						BEGIN

							SELECT
								@CostPriceInventory = IsNull(MTDOut.AvgCost, 0)
							FROM
								ModelTransf MTOut (NOLOCK) 
								INNER JOIN ModelTransf MTIn (NOLOCK) 
									ON (MTOut.Number = MTIn.Number)
								INNER JOIN ModelTransfDet MTDOut (NOLOCK) 
									ON (MTOut.IDModelTransf = MTDOut.IDModelTransf)
							WHERE
								MTDOut.IDModel = @IDModel
								AND
								MTIn.IDModelTransf = @IDInventoryMov
							GROUP BY
								MTDOut.AvgCost											
						END
					ELSE
						BEGIN							
							SELECT 
								@CostPriceInventory = CASE WHEN IsNull(StoreAvgPrice, 0) = 0 THEN IsNull(@CostPrice, 0) ELSE StoreAvgPrice END
							FROM
								Inventory
							WHERE
								ModelID = @IDModel
								AND
								StoreID = @IDStore
							
						END
	
	
					SET @AvgCostTotalInventory = @AvgCostTotalInventory + (@Qty * IsNull(@CostPriceInventory, 0))
				END
	
			
			SET @QtyInventory = @QtyInventory + @Qty
	

			UPDATE 
				Inventory 
			SET 
				AvgCostTotal = @AvgCostTotalInventory
			WHERE
				ModelID = @IDModel
				AND
				StoreID = @IDStore

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE AVG_CUR
				DEALLOCATE AVG_CUR

				SET @ErrorLevel = -202
				GOTO ERRO
			END


	
		END

		UPDATE 
			InventoryMov
		SET
			AvgCost = @AvgCostInvMov
		WHERE
			IDInventoryMov = @IDInventoryMov

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE AVG_CUR
			DEALLOCATE AVG_CUR

			SET @ErrorLevel = -203
			GOTO ERRO
		END


		if @PrintDebug = 1
		BEGIN
			print @NomeMov
			print 'AvgCostTotal ' + convert(varchar, @AvgCostTotalInventory)
			print 'Qtd Mov ' + convert(varchar, @Qty)
			print 'Qtd Atual ' + convert(varchar, @QtyInventory)		
			print 'CostPrice ' + convert(varchar, @CostPriceInventory)
		END

	FETCH NEXT FROM AVG_CUR INTO
		@IDPreInventoryMov,
		@IDInventoryMov,
		@InventMovTypeID,
		@Qty,
		@CostPrice,
		@MovFactor,
		@DocumentID,
		@NomeMov
END

CLOSE AVG_CUR
DEALLOCATE AVG_CUR

OK:
	COMMIT TRANSACTION @TransactionName
	RETURN 0
ERRO:
	ROLLBACK TRANSACTION @TransactionName
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inv_AdjustAvgCostInventory', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inv_AdjustAvgCostModel (@IDModel	int)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Zera Valores de AvgCost e AvgCostTotal no Model
		- Atualiza o AvgCostTotal ( e AvgCost se necessário ) no Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Zera Valores de AvgCost e AvgCostTotal no Model
		-202  Atualiza o AvgCostTotal ( e AvgCost se necessário ) no Model


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------------- ----------------------- -------------------------------- -----------------------------------------------------------------------------------------------------
	23 Jun  2006		Carlos Lima		Criação
    	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDInventoryMov			int
DECLARE @IDPreInventoryMov		int
DECLARE @IDStore			int
DECLARE @InventMovTypeID		int
DECLARE @Qty				float
DECLARE @CostPrice			float
DECLARE @MovFactor			float
DECLARE @DocumentID			int

DECLARE @QtyModel			float

DECLARE @AvgCostTotalModel		float

DECLARE @AvgCostInventoryMov		float




DECLARE @CostPriceModel			float



DECLARE @AvgCostModel			float

DECLARE @NomeMov			varchar(60)

DECLARE @ErrorLevel 			int
DECLARE @SysError			int
DECLARE @PrintDebug			bit


DECLARE @TransactionName		varchar(60)

SET @ErrorLevel = 0
SET @PrintDebug = 0

SET @TransactionName = 'Tran_sp_Inv_AdjustAvgCostModel'

SET @AvgCostTotalModel = 0



BEGIN TRANSACTION @TransactionName



UPDATE	
	Model	
SET
	AvgCostTotal	= 0,
	AvgCost 	= 0
WHERE
	IDModel = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


SET @QtyModel = 0

DECLARE AVG_CUR CURSOR FOR 
SELECT
	IMV.PreInventoryMovID,
	IMV.IDInventoryMov,
	IMV.StoreID,
	IMV.InventMovTypeID,
	(2*IMT.UpdateOnHand-1) * IsNull(IMV.Qty, 0),
	IsNull(IMV.CostPrice, 0),
	(2*IMT.UpdateOnHand-1),
	IMV.DocumentID,
	IMT.name

FROM
	InventoryMov IMV (NOLOCK) 
	INNER JOIN InventoryMovType IMT (NOLOCK) ON (IMV.InventMovTypeID = IMT.IDInventMovType)
WHERE
	ModelID = @IDModel
ORDER BY
	IMV.IDInventoryMov

OPEN AVG_CUR

FETCH NEXT FROM AVG_CUR INTO
	@IDPreInventoryMov,
	@IDInventoryMov,
	@IDStore,
	@InventMovTypeID,
	@Qty,
	@CostPrice,
	@MovFactor,
	@DocumentID,
	@NomeMov

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT
		@AvgCostTotalModel	= IsNull(AvgCostTotal, 0)
	FROM
		Model
	WHERE
		IDModel = @IDModel

	/* Zera os valores, caso a movimentação zere o estoque */
	IF (@QtyModel + @Qty) = 0
		BEGIN
			SET @AvgCostModel = 0
			SET @AvgCostTotalModel = 0
		END


	IF @MovFactor = 1
		BEGIN			
			IF (@QtyModel + @Qty) <> 0
				BEGIN
					/* 
						Se for Entrada por transferencia, pega o custo médio salvo 
						na saida como preco de custo 
					*/
					IF @InventMovTypeID = 8
						BEGIN
							SELECT
								@CostPriceModel = IsNull(AvgCost, 0)
							FROM
								ModelTransf MT (NOLOCK) INNER JOIN
								ModelTransfDet MTD (NOLOCK) ON (MT.IDModelTransf = MTD.IDModelTransf)
							WHERE	
								
								MT.IDModelTransf = @DocumentID
								AND
								MTD.IDModelTransfDet = @IDPreInventoryMov						

						END
					ELSE
						BEGIN
							SET @CostPriceModel = IsNull(@CostPrice, 0)
						END
	
	
					SET @AvgCostModel = (@AvgCostTotalModel + (@Qty * IsNull(@CostPriceModel, 0))) / (@QtyModel + @Qty)
					SET @AvgCostTotalModel = @AvgCostTotalModel + (@Qty * IsNull(@CostPriceModel, 0))
				END
	
			
			SET @QtyModel = @QtyModel + @Qty
	
			UPDATE 
				Model 
			SET 
				AvgCost	= @AvgCostModel,
				AvgCostTotal = @AvgCostTotalModel
			WHERE
				IDModel = @IDModel

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE AVG_CUR
				DEALLOCATE AVG_CUR

				SET @ErrorLevel = -202
				GOTO ERRO
			END
	
		END
	ELSE
		BEGIN
			IF (@QtyModel + @Qty) <> 0
				BEGIN
					/* 
						Se for Entrada por transferencia, pega o custo médio salvo na 
						saída como preco de custo 
					*/
					IF @InventMovTypeID = 7
						BEGIN

							SELECT
								@CostPriceModel = MTDOut.AvgCost
							FROM
								ModelTransf MTOut (NOLOCK)
								INNER JOIN ModelTransf MTIn (NOLOCK)
									ON (MTOut.Number = MTIn.Number)
								INNER JOIN ModelTransfDet MTDOut (NOLOCK)
									ON (MTOut.IDModelTransf = MTDOut.IDModelTransf)
							WHERE
								MTDOut.IDModel = @IDModel
								AND
								MTIn.IDModelTransf = @IDInventoryMov
							GROUP BY
								MTDOut.AvgCost											
						END
					ELSE
						BEGIN							
							SELECT 
								@CostPriceModel = CASE WHEN AvgCost = 0 THEN @CostPrice ELSE AvgCost END
							FROM
								Model
							WHERE
								IDModel = @IDModel							
							
						END
	
	
					SET @AvgCostTotalModel = @AvgCostTotalModel + (@Qty * IsNull(@CostPriceModel, 0))
				END
	
			
			SET @QtyModel = @QtyModel + @Qty
	
			UPDATE 
				Model 
			SET 
				AvgCostTotal = IsNull(@AvgCostTotalModel, 0)
			WHERE
				IDModel = @IDModel

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE AVG_CUR
				DEALLOCATE AVG_CUR

				SET @ErrorLevel = -202
				GOTO ERRO
			END
	
		END

		if @PrintDebug = 1
		BEGIN	
			print @NomeMov
			print 'AvgCostTotal ' + convert(varchar, @AvgCostTotalModel)
			print 'Qtd Mov ' + convert(varchar, @Qty)
			print 'Qtd Atual ' + convert(varchar, @QtyModel)		
			print 'CostPrice ' + convert(varchar, @CostPriceModel)
		END

	FETCH NEXT FROM AVG_CUR INTO
		@IDPreInventoryMov,
		@IDInventoryMov,
		@IDStore,
		@InventMovTypeID,
		@Qty,
		@CostPrice,
		@MovFactor,
		@DocumentID,
		@NomeMov
END

CLOSE AVG_CUR
DEALLOCATE AVG_CUR

OK:
	COMMIT TRANSACTION @TransactionName
	RETURN 0
ERRO:
	ROLLBACK TRANSACTION @TransactionName
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inv_AdjustAvgCostModel', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inv_CalcBalance
AS
/* -----------------------------------------------------------------------------------------------------------
	SUMARIO

		Calculo dinamico de saldo de quantidade e valor em estoque
		por Maximiliano Muniz em 17 de Outubro de 2006.

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Se ainda não processou nenhuma vez, insiro em DailyMaintenanceReport com a data da primeira movimentação do sitema
		-202  Erro em Atualizar a última data processada em DailyMaintenanceReport
		-203  Erro em Calcular o saldo pelo estoque total
		-204  Erro em Calcular o saldo pelo estoque por loja
		-205  Erro em Altera o status do processamento após a conclusão

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	------------------------------------------------------
	17 Oct	2006		Maximiliano Muniz	Criacao;
	14 May	2007		Maximiliano Muniz	Adicionado "exec" da nova SP para cálculo por loja;
	------------------------------------------------------------------------------------------------------ */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDDayMaint	int
DECLARE @LastProcess	datetime
DECLARE @Today		datetime
DECLARE @MovDate	datetime

SET @ErrorLevel = 0
SET @LastProcess = 0

--------------------------------------------------------------------------------------------------------------
-- Pego a última data processada ou a primeira data a processar
SELECT @Today	= CONVERT(smalldatetime, CONVERT(varchar, GetDate(), 103), 103)
SELECT @LastProcess	= CONVERT(smalldatetime, CONVERT(varchar, MAX(Date), 103), 103) FROM DailyMaintenanceReport (NOLOCK)  WHERE Maintenance = 'CalcInventoryBalance'

IF @LastProcess = @Today
	RETURN
ELSE
BEGIN
	IF @LastProcess > 0
		SET @LastProcess = DateAdd(DAY, 1, @LastProcess)
	ELSE
	BEGIN
		----------------------------------------------------------------------------------------------
		-- Se ainda não processou nenhuma vez, insiro em DailyMaintenanceReport
		-- com a data da primeira movimentação do sitema
		SELECT @LastProcess = CONVERT(smalldatetime, CONVERT(varchar, MIN(MovDate), 103), 103) FROM InventoryMov (NOLOCK)

		exec sp_Sis_GetNextCode 'DailyMaintenanceReport.IDDailyMaintenanceReport', @IDDayMaint OUTPUT
		INSERT DailyMaintenanceReport 
			(
			IDDailyMaintenanceReport,
			Maintenance,
			[Date],
			LastMessage
			)
			VALUES
			(
			@IDDayMaint,
			'CalcInventoryBalance',
			@LastProcess,
			'Started'
			)
		
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -201
			GOTO ERRO
		END
	END
END

--------------------------------------------------------------------------------------------------------------
-- Serão processadas todas as datas que possuem movimentação, a partir da última data processada
DECLARE MOVDATE_CUR CURSOR FOR 
SELECT
	CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103)
FROM
	InventoryMov (NOLOCK)
WHERE
	CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103) >= @LastProcess
GROUP BY
	CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103)
ORDER BY
	CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103)

OPEN MOVDATE_CUR

FETCH NEXT FROM MOVDATE_CUR INTO
	@MovDate

WHILE @@FETCH_STATUS = 0
BEGIN
	------------------------------------------------------------------------------------------------------
	-- Atualizar a última data processada em DailyMaintenanceReport
	UPDATE DailyMaintenanceReport SET [Date] = @MovDate, LastMessage = 'Started' WHERE Maintenance = 'CalcInventoryBalance'
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	------------------------------------------------------------------------------------------------------
	-- Calculo do saldo pelo estoque total
	exec sp_Inv_CalcModelBalance @MovDate
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	
	------------------------------------------------------------------------------------------------------
	-- Calculo do saldo pelo estoque por loja
	exec sp_Inv_CalcModelStoreBalance @MovDate
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
	
	------------------------------------------------------------------------------------------------------
	-- Altera o status do processamento após a conclusão
	UPDATE DailyMaintenanceReport SET LastMessage = 'Finished' WHERE Maintenance = 'CalcInventoryBalance'
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	FETCH NEXT FROM MOVDATE_CUR INTO
		@MovDate
END

CLOSE MOVDATE_CUR
DEALLOCATE MOVDATE_CUR

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'System', 'Error: sp_Inv_CalcBalance', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inv_CalcModelABC
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Classifiçao ABC do Inventário

		- Crio uma tabela temporaria, ordenada descendentemente por Profit
		- Marco a Primeira fatia como A, a intermediaria como B e o resto como C
		- Uso a tabela temporaria para atualizar os modelos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro inserir na tabela temporaria
		-202  Erro em Atualizo os Modelos
		-203  Erro no Cursor
		-204  Erro em atualizar o Model nao listados


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	09 Sep	1999		Eduardo Costa		Criacao;
	25 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	18 Jan	2005		Rodrigo Costa		Gerar curva ABC por modo de caixa;
	19 Dec	2005		Rodrigo Costa		Separar ABC por tipo de venda;
	24 Feb	2006		Maximiliano Muniz	Alterado o filtro por data no cálculo da média de vendas;
	06 Feb	2007		Maximiliano Muniz	Modificação do nome da SP;
							Classificação pelo faturamento e não pela quantidade vendida;
	02 Mar	2007		Maximiliano Muniz	Na hora de classificar os itens, nunca classificava os de
							classe B pois a fórmula estava incorreta;
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 	int
DECLARE @SysError	int

DECLARE @QtyTotal	float 
DECLARE @Month		int

DECLARE @ClassA		int
DECLARE @ClassB		int

DECLARE @SaleTotal	money
DECLARE @SalePercTotal	money
DECLARE @SalePerc	money
DECLARE @IDModel	int

SET @ErrorLevel = 0
SET @SalePercTotal = 0

-- Meses
SELECT @Month = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK)  WHERE Property = 'ABCCalcPeriodInMonth'
--Percentual de A
SELECT @ClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ClassAPerc'
--Percentual de B
SELECT @ClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ClassBPerc'

--Create Temp Table
CREATE TABLE #ABCTemp
(
	IDModel int,
	SalePerc money
)

IF (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 63) = 2
BEGIN

	--Calculo da Qty Total vendida
	SELECT
		@SaleTotal = SUM((SalePrice * Qty) - Discount)
	FROM
		vwSaleItem IM (NOLOCK) 
		JOIN Pessoa P (NOLOCK)  ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
		JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
	WHERE	
		IM.PreSaleDate >= DATEADD(month, - @Month, GetDate())
		AND IM.PreSaleDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0

	--Insiro os percentuais de venda ordenado
	INSERT
		#ABCTemp (IDModel, SalePerc)
	SELECT
		IM.ModelID, -- Modelo ordenado DESC por profit
		(SUM((IM.SalePrice * IM.Qty) - IM.Discount) / @SaleTotal) * 100 -- Percentual do total da venda por valor
	FROM
		vwSaleItem IM (NOLOCK) 
		JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
		JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
	WHERE	
		IM.PreSaleDate >= DATEADD(month, -@Month, GetDate())
		AND IM.PreSaleDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0
	GROUP BY 
		IM.ModelID
END
ELSE
BEGIN
	--Calculo da Qty Total vendida
	SELECT
		@SaleTotal = SUM((IM.SalePrice * IM.Qty) - IM.Discount)
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= DATEADD(month, - @Month, GetDate())
		AND IM.MovDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0

	--Insiro os percentuais de venda ordenado
	INSERT
		#ABCTemp (IDModel, SalePerc)
	SELECT
		IM.ModelID, -- Modelo ordenado DESC por profit
		(SUM((IM.SalePrice * IM.Qty) - IM.Discount) / @SaleTotal) * 100 -- Percentual do total da venda por valor
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= DATEADD(month, - @Month, GetDate())
		AND IM.MovDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0
	GROUP BY
		IM.ModelID
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

--Declaração do Cursor de InventoryMov

DECLARE CalcABC_Cursor CURSOR FOR

	SELECT
		IDModel,
		SalePerc
	FROM
		#ABCTemp
	ORDER BY
		SalePerc DESC

OPEN CalcABC_Cursor

--Inicialização de CalcABC_Cursor
FETCH NEXT FROM CalcABC_Cursor INTO
	@IDModel,
	@SalePerc

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	SET @SalePercTotal = @SalePercTotal + @SalePerc
	
	UPDATE
		Model
	SET
		Model.ClasseABC = CASE 
			WHEN (@SalePercTotal <= @ClassA) THEN 'A'
			WHEN ((@SalePercTotal > @ClassA) AND (@SalePercTotal <= @ClassA + @ClassB)) THEN 'B'
			ELSE 'C'
			END
	WHERE
		IDModel = @IDModel
		AND
		Model.ClasseABC <> 'E'


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE CalcABC_Cursor
		DEALLOCATE CalcABC_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	FETCH NEXT FROM CalcABC_Cursor INTO
		@IDModel,
		@SalePerc
END
--fechamento do cursor
CLOSE CalcABC_Cursor

--Destruição do cursor
DEALLOCATE CalcABC_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

--Atualiza os modelos que nao estao nesta listagem
UPDATE
	Model
SET
	Model.ClasseABC = 'C'
WHERE
	IDModel NOT IN (SELECT IDModel FROM #ABCTemp)
	AND
	Model.ClasseABC <> 'E'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

-- Drop a tabela temporaria
DROP TABLE #ABCTemp

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_UpdateABC', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inv_CalcStoreABC
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Classifiçao ABC do Inventário por loja

		- Crio uma tabela temporaria, ordenada descendentemente por Profit
		- Marco a Primeira fatia como A, a intermediaria como B e o resto como C
		- Uso a tabela temporaria para atualizar os modelos

	TABELA DE ERROS PARA RETURN_VALUE

		 000 Ok
		-201 Erro inserir na tabela temporaria
		-202 Erro em Atualizo os Modelos
		-203 Erro no Cursor
		-204 Erro em atualizar o Model nao listados

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	06 Feb	2007		Maximiliano Muniz	Criação;
	02 Mar	2007		Maximiliano Muniz	Na hora de classificar os itens, nunca classificava os de
							classe B pois a fórmula estava incorreta;
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 	int
DECLARE @SysError	int

DECLARE @QtyTotal	float 
DECLARE @Month		int

DECLARE @ClassA		int
DECLARE @ClassB		int

DECLARE @SaleTotal	money
DECLARE @SalePercTotal	money
DECLARE @SalePerc	money
DECLARE @IDCurrentStore	int
DECLARE @IDStore	int
DECLARE @IDModel	int

SET @ErrorLevel = 0

-- Meses
SELECT @Month = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ABCCalcPeriodInMonth'
--Percentual de A
SELECT @ClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ClassAPerc'
--Percentual de B
SELECT @ClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ClassBPerc'

--Create Temp Table
CREATE TABLE #ABCTemp
(
	IDStore int,
	IDModel int,
	SalePerc money
)

DECLARE Store_Cursor CURSOR FOR

	SELECT
		IDStore
	FROM
		Store
	ORDER BY
		IDStore

OPEN Store_Cursor

--Inicialização de Store_Cursor
FETCH NEXT FROM Store_Cursor INTO
	@IDStore

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 63) = 2
	BEGIN
		--Calculo da Qty Total vendida
		SELECT
			@SaleTotal = SUM((SalePrice * Qty) - Discount)
		FROM
			vwSaleItem IM (NOLOCK) 
			JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
			JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
		WHERE	
			IM.PreSaleDate >= DATEADD(month, - @Month, GetDate())
			AND IM.PreSaleDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
	
		--Insiro os percentuais de venda ordenado
		INSERT
			#ABCTemp (IDStore, IDModel, SalePerc)
		SELECT
			IM.StoreID,
			IM.ModelID, -- Modelo ordenado DESC por profit
			(SUM((IM.SalePrice * IM.Qty) - Discount)/@SaleTotal) * 100 -- Percentual do total da venda em valor
		FROM
			vwSaleItem IM (NOLOCK) 
			JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
			JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
		WHERE	
			IM.PreSaleDate >= DATEADD(month, -@Month, GetDate())
			AND IM.PreSaleDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
		GROUP BY
			IM.StoreID,
			IM.ModelID,
			M.SellingPrice
	END
	ELSE
	BEGIN
		--Calculo da Qty Total vendida
		SELECT
			@SaleTotal = SUM((SalePrice * Qty) - Discount)
		FROM
			InventoryMov IM (NOLOCK) 
			JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
		WHERE	
			IM.MovDate >= DATEADD(month, - @Month, GetDate())
			AND IM.MovDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
	
		--Insiro os percentuais de venda ordenado
		INSERT
			#ABCTemp (IDStore, IDModel, SalePerc)
		SELECT
			IM.StoreID,
			IM.ModelID, -- Modelo ordenado DESC por profit
			(SUM((IM.SalePrice * IM.Qty) - Discount)/@SaleTotal) * 100 -- Percentual do total da venda em valor
		FROM
			InventoryMov IM (NOLOCK) 
			JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
		WHERE	
			IM.MovDate >= DATEADD(month, - @Month, GetDate())
			AND IM.MovDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
		GROUP BY
			IM.StoreID,
			IM.ModelID
	END
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM Store_Cursor INTO
		@IDStore
END

--fechamento do cursor
CLOSE Store_Cursor

--Destruição do cursor
DEALLOCATE Store_Cursor

SET @IDCurrentStore = -1

--Declaração do Cursor de CalcABC
DECLARE CalcABC_Cursor CURSOR FOR

	SELECT
		IDStore,
		IDModel,
		SalePerc
	FROM
		#ABCTemp
	ORDER BY
		IDStore,
		SalePerc DESC

OPEN CalcABC_Cursor

--Inicialização de CalcABC_Cursor
FETCH NEXT FROM CalcABC_Cursor INTO
	@IDStore,
	@IDModel,
	@SalePerc

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @IDStore <> @IDCurrentStore
	BEGIN
		SET @SalePercTotal = 0
		SET @IDCurrentStore = @IDStore
	END

	SET @SalePercTotal = @SalePercTotal + @SalePerc

	UPDATE
		Inventory
	SET
		ClassABC =
			CASE
				WHEN (@SalePercTotal <= @ClassA) THEN 'A'
				WHEN ((@SalePercTotal > @ClassA) AND (@SalePercTotal <= @ClassA + @ClassB)) THEN 'B'
				ELSE 'C'
			END
	WHERE
		StoreID = @IDStore
		AND ModelID = @IDModel
		AND ClassABC <> 'E'

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE CalcABC_Cursor
		DEALLOCATE CalcABC_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	FETCH NEXT FROM CalcABC_Cursor INTO
		@IDStore,
		@IDModel,
		@SalePerc
END

--fechamento do cursor
CLOSE CalcABC_Cursor

--Destruição do cursor
DEALLOCATE CalcABC_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

--Atualiza os modelos que nao estao nesta listagem
UPDATE
	I
SET
	ClassABC = 'C'
FROM
	Inventory I (NOLOCK) 
	LEFT JOIN #ABCTemp T ON (I.StoreID = T.IDStore AND I.ModelID = T.IDModel)
WHERE
	T.IDStore IS NULL
	AND T.IDModel IS NULL
	AND ClassABC <> 'E'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

-- Drop a tabela temporaria
DROP TABLE #ABCTemp

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_UpdateABC', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_AddColor
	(
	@IDModel	int,
	@IDColor	int,
	@BarcodeCreate	bit = 0
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        SUMARIO

		- Testa se a cor já existe
		- Atualizo a cor do model

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Cor já existe
	-202  Erro em Atualizo a cor do model
	-203  Erro em Insiro em model
	-204  Erro na criação de barcode
	-205  Erro em EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 Nov  2000		Eduardo Costa		Criação;
	25 June 2001		Davi Gouveia		Log de Return Values
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Model_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
	15 Aug 2005		Rodrigo Costa		Update Model Values
	21 Nov	2005		Rodrigo Costa		Update ModelGroup e SubGroup
	01 Fev	2006		Max			Removido a atualizacao de precos
	16 Aug	2006		Max e Maic		Criação automática de barcode
	28 Abr	2007		Rodrigo Costa		Removido as transacoes da SP
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int

--Declaração de variáveis para o Cursor de Model
DECLARE @Model 			varchar(30)
DECLARE @IDSize 			int 
DECLARE @GroupID 			int 
DECLARE @FreightCost 		money 
DECLARE @OtherCost 			money 
DECLARE @VendorCost 		money 
DECLARE @DateLastCost		smalldatetime 
DECLARE @MarkUp 			money 
DECLARE @SellingPrice 		money 
DECLARE @DateLastSellingPrice 	smalldatetime 
DECLARE @IDFabricante 		int 
DECLARE @Avaiable 			money 
DECLARE @LastCost 			money 
DECLARE @SuggRetail 			money 
DECLARE @AutomaticRequest 		bit 
DECLARE @ModelType 		char(1)
DECLARE @IDModelParent 		int 
DECLARE @CustomSalePrice 		bit 
DECLARE @CustomCostPrice 		bit 
DECLARE @CustomSpecialPrice		bit 
DECLARE @CustomPromotion 		bit 
DECLARE @Desativado 		int 
DECLARE @Hidden 			int
DECLARE @System 			bit 
DECLARE @Description 		varchar (50)
DECLARE @ModelID 			int 
DECLARE @IDModelGroup		int
DECLARE @IDModelSubGroup		int
DECLARE @Barcode		varchar(20)

-- Testa se a cor já existe
IF EXISTS (SELECT IDModel FROM Model (NOLOCK)  WHERE IDModelParent = @IDModel AND IDColor = @IDColor)
BEGIN
	PRINT 'ERROR: Model already contains this color !'
	SET @ErrorLevel = -201
	GOTO ERRO
END

IF EXISTS(SELECT IDModel FROM Model (NOLOCK) WHERE IDModelParent = @IDModel AND IDColor IS NULL)
BEGIN
	-- Atualizo a cor do model
	UPDATE
		M
	SET
		M.IDColor = @IDColor
	FROM
		Model M (NOLOCK) 
	WHERE
		M.IDModelParent = @IDModel

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END
ELSE
BEGIN
	-- Insiro em model
	--Declaração do Cursor de Model
	DECLARE Model_Cursor CURSOR FOR

	SELECT
		M.Model,
		@IDColor,
		MS.IDSize,
		M.GroupID,
		M.[Description],
		M.FreightCost,
		M.OtherCost,
		M.VendorCost,
		M.DateLastCost,
		M.MarkUp,
		M.SellingPrice,
		M.DateLastSellingPrice,
		M.IDFabricante,
		M.Avaiable,
		M.LastCost,
		M.SuggRetail,
		M.AutomaticRequest,
		'S',                            -- SUBMODEL
		M.IDModel,
		0,
		0,
		0,
		0,
		M.[System],
		M.Desativado,
		M.Hidden,
		M.IDModelGroup,
		M.IDModelSubGroup
	FROM
		Model M (NOLOCK) 
		LEFT OUTER JOIN (SELECT IDModelParent, IDSize FROM Model (NOLOCK)  WHERE IDModelParent = @IDModel GROUP BY IDModelParent, IDSize) MS ON (M.IDModel = MS.IDModelParent)
	WHERE
		M.IDModel = @IDModel


	OPEN Model_Cursor

	--Inicialização de Model_Cursor
	FETCH NEXT FROM Model_Cursor INTO
		@Model,
		@IDColor,
		@IDSize,
		@GroupID,
		@Description,
		@FreightCost,
		@OtherCost,
		@VendorCost,
		@DateLastCost,
		@MarkUp,
		@SellingPrice,
		@DateLastSellingPrice,
		@IDFabricante,
		@Avaiable,
		@LastCost,
		@SuggRetail,
		@AutomaticRequest,
		@ModelType,
		@IDModelParent,
		@CustomSalePrice,
		@CustomCostPrice,
		@CustomSpecialPrice,
		@CustomPromotion,
		@System,
		@Desativado,
		@Hidden,
		@IDModelGroup,
		@IDModelSubGroup

	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		Exec sp_Sis_GetNextCode 'Model.IDModel', @ModelID OUTPUT

		INSERT Model
			(
			IDModel,
			Model,
			IDColor,
			IDSize,
			GroupID,
			Description,
			FreightCost,
			OtherCost,
			VendorCost,
			DateLastCost,
			MarkUp,
			SellingPrice,
			DateLastSellingPrice,
			IDFabricante,
			Avaiable,
			LastCost,
			SuggRetail,
			AutomaticRequest,
			ModelType,
			IDModelParent,
			CustomSalePrice,
			CustomCostPrice,
			CustomSpecialPrice,
			CustomPromotion,
			System,
			Desativado,
			Hidden,
			IDModelGroup,
			IDModelSubGroup
			)
		VALUES 
			(
			@ModelID,
			@Model,
			@IDColor,
			@IDSize,
			@GroupID,
			@Description,
			@FreightCost,
			@OtherCost,
			@VendorCost,
			@DateLastCost,
			@MarkUp,
			@SellingPrice,
			@DateLastSellingPrice,
			@IDFabricante,
			@Avaiable,
			@LastCost,
			@SuggRetail,
			@AutomaticRequest,
			@ModelType,
			@IDModelParent,
			@CustomSalePrice,
			@CustomCostPrice,
			@CustomSpecialPrice,
			@CustomPromotion,
			@System,
			@Desativado,
			@Hidden,
			@IDModelGroup,
			@IDModelSubGroup
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Model_Cursor
			DEALLOCATE Model_Cursor
			SET @ErrorLevel = -203
			GOTO ERRO
		END

		IF @BarcodeCreate = 1
		BEGIN
			SET @Barcode = IsNull(Cast(@GroupID as varchar(15)), '') + IsNull(Cast(@ModelID as varchar(15)), '') + IsNull(Cast(@IDFabricante as varchar(15)), '') + IsNull(Cast(@IDSize as varchar(15)), '') + IsNull(Cast(@IDColor as varchar(15)), '')

			INSERT INTO Barcode (IDBarcode, IDModel, Data, BarcodeOrder)
			VALUES (@Barcode, @ModelID, GetDate(), 1)

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE Model_Cursor
				DEALLOCATE Model_Cursor
				SET @ErrorLevel = -205
				GOTO ERRO
			END
		END

		FETCH NEXT FROM Model_Cursor INTO
			@Model,
			@IDColor,
			@IDSize,
			@GroupID,
			@Description,
			@FreightCost,
			@OtherCost,
			@VendorCost,
			@DateLastCost,
			@MarkUp,
			@SellingPrice,
			@DateLastSellingPrice,
			@IDFabricante,
			@Avaiable,
			@LastCost,
			@SuggRetail,
			@AutomaticRequest,
			@ModelType,
			@IDModelParent,
			@CustomSalePrice,
			@CustomCostPrice,
			@CustomSpecialPrice,
			@CustomPromotion,
			@System,
			@Desativado,
			@Hidden,
			@IDModelGroup,
			@IDModelSubGroup
	END

	--fechamento do cursor
	CLOSE Model_Cursor
	--Destruição do cursor
	DEALLOCATE Model_Cursor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END
END

EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel

IF @ErrorLevel <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_AddColor', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_AddSize
	(
	@IDModel	int,
	@IDSize		int,
	@BarcodeCreate	bit = 0
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa qual das sub's devo rodar
		- Atualizo o model


	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Size exist
	-202  Erro em Atualizo o model
	-203  Erro em Insiro submodel	
	-204  Erro na criação de barcode
	-205  Erro em EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 Nov	2000		Eduardo Costa		Criação;
	25 Jun	2001		Davi Gouveia		Log de Return Values
	12 Aug	2003		Rodrigo Costa		Size exist test
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Model_Cursor
	18 Aug	2004		Rodrigo Costa		Gravar error log
	15 Aug	2005		Rodrigo Costa		Update Model Values
	21 Nov	2005		Rodrigo Costa		Update Group e SubGroup
	01 Fev	2006		Max			Removido a atualizacao de precos
	16 Aug	2006		Max e Maic		Criação automática de barcode
 	28 Abr	2007		Rodrigo Costa		Removido as transacoes da SP
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @CurrentNumberOfSize 	int

--Declaração de variáveis para o Cursor de Model
DECLARE @Model			varchar(30)
DECLARE @IDColor		int 
DECLARE @GroupID 		int 
DECLARE @FreightCost 		money 
DECLARE @OtherCost 		money 
DECLARE @VendorCost 		money 
DECLARE @DateLastCost		smalldatetime 
DECLARE @MarkUp 		money 
DECLARE @SellingPrice 		money 
DECLARE @DateLastSellingPrice 	smalldatetime 
DECLARE @IDFabricante 		int 
DECLARE @Avaiable 		money 
DECLARE @LastCost 		money 
DECLARE @SuggRetail 		money 
DECLARE @AutomaticRequest 	bit 
DECLARE @ModelType 		char(1)
DECLARE @IDModelParent 		int 
DECLARE @CustomSalePrice 	bit 
DECLARE @CustomCostPrice 	bit 
DECLARE @CustomSpecialPrice	bit 
DECLARE @CustomPromotion 	bit 
DECLARE @Desativado 		int 
DECLARE @Hidden 		int
DECLARE @System 		bit 
DECLARE @Description 		varchar (50)
DECLARE @ModelID 		int 
DECLARE @IDModelGroup		int
DECLARE @IDModelSubGroup	int
DECLARE @Barcode		varchar(20)

-- Testa se a cor já existe
IF EXISTS (SELECT IDModel FROM Model (NOLOCK) WHERE IDModelParent = @IDModel AND IDSize = @IDSize)
BEGIN
	PRINT 'ERROR: Model already contains this size !'
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Testa qual das sub's devo rodar
SELECT
	@CurrentNumberOfSize = COUNT(IDSize)
FROM
	Model (NOLOCK) 
WHERE
	IDModelParent = @IDModel
	AND
	IDSize IS NOT NULL

IF EXISTS(SELECT IDModel FROM Model (NOLOCK) WHERE IDModelParent = @IDModel AND IDSize IS NULL)
BEGIN
	-- Atualizo o model
	UPDATE
		M
	SET
		M.IDSize = @IDSize
	FROM
		Model M (NOLOCK) 
	WHERE
		M.IDModelParent = @IDModel

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO   ERRO
	END
END
ELSE
BEGIN
	-- Insiro submodel
	--Declaração do Cursor de Model
	DECLARE Model_Cursor CURSOR FOR
	SELECT
		M.Model,
		MS.IDColor,
		M.GroupID,
		M.Description,
		M.FreightCost,
		M.OtherCost,
		M.VendorCost,
		M.DateLastCost,
		M.MarkUp,
		M.SellingPrice,
		M.DateLastSellingPrice,
		M.IDFabricante,
		M.Avaiable,
		M.LastCost,
		M.SuggRetail,
		M.AutomaticRequest,
		'S',  -- SUBMODEL
		M.IDModel,
		0,
		0,
		0,
		0,
		M.System,
		M.Desativado,
		M.Hidden,
		M.IDModelGroup,
		M.IDModelSubGroup
	FROM
		Model M (NOLOCK) 
		LEFT OUTER JOIN 
		(SELECT 
			IDModelParent, 
			IDColor 
		FROM 
			Model  (NOLOCK) 
		WHERE 

			IDModelParent = @IDModel 
		GROUP BY 
			IDModelParent, IDColor) MS ON (M.IDModel = MS.IDModelParent)
	WHERE
		M.IDModel = @IDModel


	OPEN Model_Cursor

	--Inicialização de Model_Cursor
	FETCH NEXT FROM Model_Cursor INTO
		@Model,
		@IDColor,
		@GroupID,
		@Description,
		@FreightCost,
		@OtherCost,
		@VendorCost,
		@DateLastCost,
		@MarkUp,
		@SellingPrice,
		@DateLastSellingPrice,
		@IDFabricante,
		@Avaiable,
		@LastCost,
		@SuggRetail,
		@AutomaticRequest,
		@ModelType,
		@IDModelParent,
		@CustomSalePrice,
		@CustomCostPrice,
		@CustomSpecialPrice,
		@CustomPromotion,
		@System,
		@Desativado,
		@Hidden,
		@IDModelGroup,
		@IDModelSubGroup
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		Exec sp_Sis_GetNextCode 'Model.IDModel', @ModelID OUTPUT
	
		INSERT Model
			(
			IDModel,
			Model,
			IDColor,
			IDSize,
			GroupID,
			Description,
			FreightCost,
			OtherCost,
			VendorCost,
			DateLastCost,
			MarkUp,
			SellingPrice,
			DateLastSellingPrice,
			IDFabricante,
			Avaiable,
			LastCost,
			SuggRetail,
			AutomaticRequest,
			ModelType,
			IDModelParent,
			CustomSalePrice,
			CustomCostPrice,
			CustomSpecialPrice,
			CustomPromotion,
			System,
			Desativado,
			Hidden,
			IDModelGroup,
			IDModelSubGroup
			)
		VALUES 
			(
			@ModelID,
			@Model,
			@IDColor,
			@IDSize,
			@GroupID,
			@Description,
			@FreightCost,
			@OtherCost,
			@VendorCost,
			@DateLastCost,
			@MarkUp,
			@SellingPrice,
			@DateLastSellingPrice,
			@IDFabricante,
			@Avaiable,
			@LastCost,
			@SuggRetail,
			@AutomaticRequest,
			@ModelType,
			@IDModelParent,
			@CustomSalePrice,
			@CustomCostPrice,
			@CustomSpecialPrice,
			@CustomPromotion,
			@System,
			@Desativado,
			@Hidden,
			@IDModelGroup,
			@IDModelSubGroup
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Model_Cursor
			DEALLOCATE Model_Cursor
			SET @ErrorLevel = -203
			GOTO ERRO
		END

		IF @BarcodeCreate = 1
		BEGIN
			SET @Barcode = IsNull(Cast(@GroupID as varchar(15)), '') + IsNull(Cast(@ModelID as varchar(15)), '') + IsNull(Cast(@IDFabricante as varchar(15)), '') + IsNull(Cast(@IDSize as varchar(15)), '') + IsNull(Cast(@IDColor as varchar(15)), '')

			INSERT INTO Barcode (IDBarcode, IDModel, Data, BarcodeOrder)
			VALUES (@Barcode, @ModelID, GetDate(), 1)

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE Model_Cursor
				DEALLOCATE Model_Cursor
				SET @ErrorLevel = -204
				GOTO ERRO
			END
		END

		FETCH NEXT FROM Model_Cursor INTO
			@Model,
			@IDColor,
			@GroupID,
			@Description,
			@FreightCost,
			@OtherCost,
			@VendorCost,
			@DateLastCost,
			@MarkUp,
			@SellingPrice,
			@DateLastSellingPrice,
			@IDFabricante,
			@Avaiable,
			@LastCost,
			@SuggRetail,
			@AutomaticRequest,
			@ModelType,
			@IDModelParent,
			@CustomSalePrice,
			@CustomCostPrice,
			@CustomSpecialPrice,
			@CustomPromotion,
			@System,
			@Desativado,
			@Hidden,
			@IDModelGroup,
			@IDModelSubGroup
	END

	--fechamento do cursor
	CLOSE Model_Cursor
	--Destruição do cursor
	DEALLOCATE Model_Cursor
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO   ERRO
	END
END

EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO   ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_AddSize', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Adjust
		(
		@IDMovType   	int,
		@IDModel   	int,
		@IDStore   	int,
		@Qty	  	float,
		@IDUser		int,
		@Date		Datetime,
		@Notes		varchar(255),
		@IDMovReason	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Ajuste estoque
		- Atualiza o Inventory
		- Atualiza o saldo em valor do Model
		- Atualiza o saldo em valor do Inventoty

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualiza o Inventory
		-202  Erro ao Inserir o Motivo
		-203  Atualiza o saldo em valor do Model
		-204  Atualiza o saldo em valor do Inventoty




	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	31 Mar  2006		Rodrigo Costa		Criacao;
	02 Jun	2006		Rodrigo Costa		Inserir no Inv_MovComplement
	12 Jun  2006		Carlos Lima		Atualiza o saldo em valor e o custo médio
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov		int
DECLARE @MovFactor		int
DECLARE @CostPrice		money
DECLARE @AvgCost		money
DECLARE @IDInventory 		int


SET @ErrorLevel = 0


SELECT 
	@MovFactor = (2 *UpdateOnHand-1)
FROM
	InventoryMovType (NOLOCK)
WHERE
	IDInventMovType = @IDMovType

IF @MovFactor = 1
BEGIN
	SELECT
		@CostPrice = CASE WHEN IsNull(AvgCost, 0) = 0 THEN IsNull(VendorCost, 0) ELSE IsNull(AvgCost, 0) END
	FROM
		Model (NOLOCK)
	WHERE
		IDModel = @IDModel

	-- Atualiza o saldo em valor do Model

	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @IDModel	

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END


	SELECT
		@CostPrice = CASE WHEN IsNull(StoreAvgPrice, 0) = 0 THEN IsNull(StoreCostPrice, 0) ELSE IsNull(StoreAvgPrice, 0) END
	FROM
		Inventory (NOLOCK)
	WHERE
		Inventory.ModelID = @IDModel
		AND
		Inventory.StoreID = @IDStore


	IF NOT EXISTS(SELECT ModelID FROM Inventory (NOLOCK) WHERE ModelID = @IDModel AND StoreID = @IDStore)
	BEGIN
		EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
	
		INSERT Inventory
			(
			IDInventory,
			StoreID,
			ModelID
			)
		VALUES
			(
			@IDInventory,
			@IDStore,
			@IDModel
			)
	END



	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCost = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory (NOLOCK)
	WHERE
		Inventory.ModelID = @IDModel
		AND
		Inventory.StoreID = @IDStore



	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @IDModel
		AND
		Inventory.StoreID = @IDStore



	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
END

EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

INSERT InventoryMov 	(
			IDInventoryMov,
			InventMovTypeID,
			DocumentID,
			StoreID,
			ModelID,
			MovDate,
			Qty,
			IDUser
			)
			VALUES
			(
			@IDInventoryMov,
			@IDMovType,
			0,

			@IDStore,
			@IDModel,
			@Date,
			Abs(@Qty),
			@IDUser
			)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

INSERT Inv_MovComplement 	(
				IDInventoryMov,
				IDMovReason,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				@IDMovReason,
				@Notes
				)



SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Count
		(
		@IDModel	int,
		@IDStore	int,
		@CountType	int,
		@CountedQty	float,
		@CountDate	smalldatetime,
		@IDUser		int
		)
AS

	/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Calcula o total de quantidade movimentada ate a contagem

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Ajuste por entrada de estoque
		-202  Erro em Ajuste por saida de estoque


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDInventoryMov; 
							Criado @IDInventoryMov;
	18 Aug 2004		Rodrigo Costa		Gravar error log
	02 Jun 2006		Rodrigo Costa		Removido Notes do InventoryMov
	19 Oct 2006		Max e Maic		Alterado parâmetro "@Difference" por "@CountedQty";
							Removidos parâmetros "@Date e @Notes";
							Inserido parâmetro "@CountType";
	----------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov		int
DECLARE @QtyOnHand		float
DECLARE @QtyDifference		float

SET @ErrorLevel = 0
SET @QtyOnHand = 0

-------------------------------------------------------------------------------------------------------
-- Pego a quantidade atual em estoque do produto
SELECT
	@QtyOnHand = IsNull(SUM(IM.Qty * (2*IMT.UpdateOnHand-1)), 0)
FROM
	InventoryMov IM (NOLOCK)
	JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
WHERE
	IM.StoreID = @IDStore     
	AND IM.ModelID = @IDModel     	
	AND IM.MovDate <= @CountDate


-------------------------------------------------------------------------------------------------------
-- Descubro qual a diferença entre meu estoque e a quantidade contada.
-- Caso seja igual a zero, saio da SP sem inserir a movimentação
IF @CountType = 1
	SET @QtyDifference = @CountedQty
ELSE
	SET @QtyDifference = @CountedQty - @QtyOnHand

IF @QtyDifference = 0
	GOTO OK

-------------------------------------------------------------------------------------------------------
-- Pego um novo ID para inserir na InventoryMov
EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

-------------------------------------------------------------------------------------------------------
-- Insiro na InventoryMov a movimentação de ajuste do estoque
if @QtyDifference > 0
begin
	/*	Ajuste por entrada de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser
				)
				VALUES
				(
				@IDInventoryMov,
				21,
				0,
				@IDStore,
				@IDModel,
				GetDate(),
				Abs(@QtyDifference),
				@IDUser
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
END
ELSE
BEGIN
	/*	Ajuste por saida de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser
				)
				VALUES
				(
				@IDInventoryMov,
				22,
				0,
				@IDStore,
 				@IDModel,
				GetDate(),
				Abs(@QtyDifference),
				@IDUser
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Count', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Del_Moviment (@IDInventoryMov int) AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Atualizo custo médio em Model
		- Atualizo custo médio em Inventory
		- Excluo InventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualizo custo médio em Model
		-202  Erro em Atualizo custo médio em Inventory
		-203  Erro em Excluo InventoryMov

	LOG DE MODIFICAÇÕES

	Data		Programador				Modificação
	--------------- --------------------------------------- ------------------------------------------------------------------------------
	06 Jun 2006	Carlos Lima				Criação
	--------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @ErrorLevel	int
DECLARE @SysError	int


DECLARE @StoreID	int
DECLARE @ModelID	int
DECLARE @Qty		float
DECLARE @CostPrice	money
DECLARE @UpdateOnHand	int


SELECT
	@StoreID = StoreID,
	@ModelID = ModelID,
	@Qty = Qty,
	@CostPrice = CostPrice,
	@UpdateOnHand = (2 *IMT.UpdateOnHand-1)
FROM
	InventoryMov (NOLOCK) 
	INNER JOIN InventoryMovType IMT (NOLOCK) ON (InventoryMov.InventMovTypeID = IMT.IDInventMovType)
WHERE
	IDInventoryMov = @IDInventoryMov

	
UPDATE
	Model
SET
	Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty)),
	Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) - (@UpdateOnHand * @Qty)) = 0 
				THEN 0 
				ELSE (IsNull(Model.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty))) / (IsNull(Model.TotQtyOnHand, 0) - (@UpdateOnHand * @Qty)) 
			END
WHERE
	Model.IDModel = @ModelID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


UPDATE
	Inventory
SET
	Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty)),
	Inventory.StoreAvgPrice =	CASE WHEN (IsNull(Inventory.QtyOnHand, 0) - (@UpdateOnHand * @Qty)) = 0 
						THEN 0 
						ELSE (IsNull(Inventory.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty))) / (IsNull(Inventory.QtyOnHand, 0) - (@UpdateOnHand * @Qty)) 
					END
WHERE
	Inventory.ModelID = @ModelID
	AND
	Inventory.StoreID = @StoreID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


DELETE FROM
	InventoryMov
WHERE
	IDInventoryMov = @IDInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END



OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Del_Moviment', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Sub_AtuModelValues
	(
	@IDModelMaster	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Atualiza todos os sub models de uma grade a partir da seguinte formula

		Model = Model + ColorCode + SizeCode
		Description = Description + Color + Size


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update

	LOG DE MODIFICAÇÕES

		Data			Programador		Modificação
		--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
		15 Agosto 2005		Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ColorSeparator  	VarChar(10)
DECLARE @SizeSeparator  	VarChar(10)
DECLARE @Trailing  		VarChar(10)
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ColorSeparator = '-'
SET @SizeSeparator = '-'
SET @Trailing = '...'


UPDATE
	M
SET
	M.LastCost = MM.LastCost,
	M.DateLastCost = MM.DateLastCost,
	M.VendorCost = MM.VendorCost,
	M.OtherCost = MM.OtherCost,
	M.FreightCost = MM.FreightCost,
	M.MarkUp = MM.MarkUp,
	M.DateLastSellingPrice = MM.DateLastSellingPrice,
	M.SellingPrice = MM.SellingPrice,
	M.SuggRetail = M.SuggRetail
FROM
	Model MM (NOLOCK)
	JOIN 
	Model M (NOLOCK) ON (M.IDModelParent = MM.IDModel)
	LEFT OUTER JOIN 
	InvColor C (NOLOCK) ON (M.IDColor = C.IDColor)
	LEFT OUTER JOIN 
	InvSize S (NOLOCK) ON (M.IDSize = S.IDSize)
WHERE
	MM.IDModel = @IDModelMaster

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Sub_AtuModelValues', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Tranfer_IN
	(
	@IDModelTransf	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delecao do InventoryMov
		- Atualizo o model
		- Atualizo o custo médio no Model
		- Insiro InventoryMov
		- Atualizo o custo médio no Inventory

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro em Delecao do InventoryMov
	-202  Erro em Inserir Model
	-203  Erro em Atualizo o custo médio no Model
	-204  Erro em Insiro InventoryMov
	-205  Erro em Atualizo o custo médio no Inventory

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
	16 Jun 2006		Carlos Lima		Atualização do custo médio
        22 Jan 2007             Maic Nogueira           Adicionado Kit na transferência de itens.
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID		int
DECLARE @ModelID		int
DECLARE @Qty			float
DECLARE @TransfDate		datetime
DECLARE @CostPrice		money
DECLARE @IDUser 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDInventoryMov    	int
DECLARE @StoreIDOrigem 	int 
DECLARE @StoreIDDestino 	int 
DECLARE @AvgCost 		money 
DECLARE @AvgCostCalc		money

DECLARE @IDInventory		int

BEGIN TRAN


/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IDInventoryMov
FROM
	InventoryMov (NOLOCK) 
WHERE	
	InventoryMov.InventMovTypeID = 8
	AND
	InventoryMov.DocumentID = @IDModelTransf



OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor
--

/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferIN_Cursor CURSOR FOR
	SELECT
		MTD.IDModelTransf,
		MT.IDLojaOrigem,
		MT.IDLojaDestino,
		MTD.IDModel,
		MTD.Qty,
		MT.Data,
		MT.IDUser,
		MTD.IDModelTransfDet, /* guarda a linha correspondente a inserida */
		MTD.CostPrice,
		MTD.AvgCost
	FROM
		ModelTransfDet MTD (NOLOCK) 
		INNER JOIN ModelTransf MT (NOLOCK) ON (MTD.IDModelTransf = MT.IDModelTransf)		
	WHERE
		MT.IDModelTransf = @IDModelTransf

OPEN TransferIN_Cursor

--Inicialização de TransferIN_Cursor
FETCH NEXT FROM TransferIN_Cursor INTO
	@DocumentID,
	@StoreIDOrigem,
	@StoreIDDestino,
	@ModelID,
	@Qty,
	@TransfDate,
	@IDUser,
	@PreInventoryMovID,
	@CostPrice,
	@AvgCost 

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	--Inclusao da loja original
	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@AvgCost * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@AvgCost * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	IF NOT EXISTS(SELECT ModelID FROM Inventory (NOLOCK) WHERE ModelID = @ModelID AND StoreID = @StoreIDDestino)
	BEGIN
		EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
	
		INSERT Inventory
			(
			IDInventory,
			StoreID,
			ModelID
			)
		VALUES
			(
			@IDInventory,
			@StoreIDDestino,
			@ModelID
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE TransferIN_Cursor
			DEALLOCATE TransferIN_Cursor
			SET @ErrorLevel = -204
			GOTO ERRO
		END
	END

	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCostCalc = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@AvgCost * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory (NOLOCK) 
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreIDDestino


	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@AvgCost * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreIDDestino


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		PreInventoryMovID,
		CostPrice,
		AvgCost 
		)
	VALUES
		(
		@IDInventoryMov,
		8,   /* entrada da loja destino */
		@DocumentID,
		@StoreIDDestino,
		@ModelID,
		0,
		@TransfDate,
		@Qty,
		@IDUser,
		@PreInventoryMovID, /* guarda a linha correspondente a inserida */
		@CostPrice,
		@AvgCost 
		)

	DECLARE TransferITEMS_Cursor CURSOR FOR
	SELECT
		P.IDModel,
		P.Qty * @Qty,
		M.VendorCost,
		M.AvgCost
	FROM
		PackModel P (NOLOCK) 
		JOIN Model M (NOLOCK) ON (P.IDModel = M.IDModel) 
	WHERE
		IDPackModel = @ModelID
	
	OPEN TransferITEMS_Cursor
	
	--Inicialização de TransferITEMS_Cursor
	FETCH NEXT FROM TransferITEMS_Cursor INTO
		@ModelID,
		@Qty,
		@CostPrice,
		@AvgCost
	
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @ModelID AND StoreID = @StoreIDDestino)
		BEGIN
			EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
		
			INSERT Inventory
				(
				IDInventory,
				StoreID,
				ModelID
				)
			VALUES
				(
				@IDInventory,
				@StoreIDDestino,
				@ModelID
				)
		END

		--Inclusao da loja original
		EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

		INSERT InventoryMov
			(
			IDInventoryMov,
			InventMovTypeID,
			DocumentID,
			StoreID,
			ModelID,
			IDPessoa,
			MovDate,
			Qty,
			IDUser,
			PreInventoryMovID,
			CostPrice,
			AvgCost
			)
		VALUES
			(
			@IDInventoryMov,
			8,   /* saida da loja original */
			@DocumentID,
			@StoreIDDestino,
			@ModelID,
			0,
			@TransfDate,
			@Qty,
			@IDUser,
			@PreInventoryMovID, /* guarda a linha correspondente a inserida */
			@CostPrice,
			@AvgCost
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE TransferITEMS_Cursor
			DEALLOCATE TransferITEMS_Cursor
			CLOSE TransferIN_Cursor
			DEALLOCATE TransferIN_Cursor
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		FETCH NEXT FROM TransferITEMS_Cursor INTO
			@ModelID,
			@Qty,
			@CostPrice,
			@AvgCost
	END

	--fechamento do cursor
	CLOSE TransferITEMS_Cursor
	--Destruição do cursor
	DEALLOCATE TransferITEMS_Cursor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	FETCH NEXT FROM TransferIN_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@TransfDate,
		@IDUser,
		@PreInventoryMovID,
		@CostPrice,
		@AvgCost 
END

--fechamento do cursor
CLOSE TransferIN_Cursor
--Destruição do cursor
DEALLOCATE TransferIN_Cursor

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Tranfer_IN', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Tranfer_OUT
	(
	@IDModelTransf	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Exclusão do InventoryMov
		- Salvar custo medio no detalhe da transferencia
		- Inserção do InventoryMov


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Exclusão do InventoryMov
		-202  Erro em Inserção do InventoryMov
		-203  Erro em Salvar custo medio no detalhe da transferencia

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
        22 Jan 2007             Maic Nogueira           Adicionado Kit na transferência de itens.
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID		int
DECLARE @ModelID		int
DECLARE @Qty			float
DECLARE @TrasfDate		datetime
DECLARE @CostPrice		money
DECLARE @IDUser			int
DECLARE @PreInventoryMovID	int
DECLARE @IDInventoryMov		int
DECLARE @StoreIDOrigem		int
DECLARE @StoreIDDestino		int
DECLARE @AvgCost		money

DECLARE @IDInventory		int

BEGIN TRAN


/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/
DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IDInventoryMov
FROM
	InventoryMov (NOLOCK) 
WHERE	
	InventoryMov.InventMovTypeID = 7
	AND
	InventoryMov.DocumentID = @IDModelTransf



OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor

--------------------------------------------------------------------
--  Atualiza  Custo médio de transferencia  --
--------------------------------------------------------------------
UPDATE	ModelTransfDet
SET		AvgCost = IsNull(StoreAvgPrice, 0)
FROM
	ModelTransf (NOLOCK) , Inventory (NOLOCK) 
WHERE
	ModelTransfDet.IDModelTransf = ModelTransf.IDModelTransf
	AND
	ModelTransf.IDLojaOrigem = Inventory.StoreID
	AND
	ModelTransfDet.IDModel = Inventory.ModelID
	AND
	ModelTransfDet.IDModelTransf = @IDModelTransf

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO   ERRO
END



/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferOUT_Cursor CURSOR FOR
	SELECT
		MTD.IDModelTransf,
		MT.IDLojaOrigem,
		MT.IDLojaDestino,
		MTD.IDModel,
		MTD.Qty,
		MT.Data,
		MT.IDUser,
		MTD.IDModelTransfDet, /* guarda a linha correspondente a inserida */
		MTD.CostPrice,
		Case WHEN (Inv.QtyOnHand - MTD.Qty) = 0 THEN 0 ELSE  Inv.StoreAvgPrice END
	FROM
		ModelTransfDet MTD (NOLOCK) 
		INNER JOIN ModelTransf MT (NOLOCK) ON  (MTD.IDModelTransf = MT.IDModelTransf)
		LEFT JOIN Inventory Inv (NOLOCK) ON (MTD.IDModel = Inv.ModelID AND MT.IDLojaOrigem = Inv.StoreID)
	WHERE		
		MT.IDModelTransf = @IDModelTransf

OPEN TransferOUT_Cursor

--Inicialização de TransferOUT_Cursor
FETCH NEXT FROM TransferOUT_Cursor INTO
	@DocumentID,
	@StoreIDOrigem,
	@StoreIDDestino,
	@ModelID,
	@Qty,
	@TrasfDate,
	@IDUser,
	@PreInventoryMovID,
	@CostPrice,
	@AvgCost
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
--Inclusao da loja original
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		PreInventoryMovID,
		CostPrice,
		AvgCost
		)
	VALUES
		(
		@IDInventoryMov,
		7,   /* saida da loja original */
		@DocumentID,
		@StoreIDOrigem,
		@ModelID,
		0,
		@TrasfDate,
		@Qty,
		@IDUser,
		@PreInventoryMovID, /* guarda a linha correspondente a inserida */
		@CostPrice,
		@AvgCost
		)


	DECLARE TransferITEMS_Cursor CURSOR FOR
	SELECT
		P.IDModel,
		P.Qty * @Qty,
		M.VendorCost,
		M.AvgCost
	FROM
		PackModel P (NOLOCK) 
		JOIN Model M (NOLOCK) ON (P.IDModel = M.IDModel) 
	WHERE
		IDPackModel = @ModelID
	
	OPEN TransferITEMS_Cursor
	
	--Inicialização de TransferITEMS_Cursor
	FETCH NEXT FROM TransferITEMS_Cursor INTO
		@ModelID,
		@Qty,
		@CostPrice,
		@AvgCost
	
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @ModelID AND StoreID = @StoreIDDestino)
		BEGIN
			EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
		
			INSERT Inventory
				(
				IDInventory,
				StoreID,
				ModelID
				)
			VALUES
				(
				@IDInventory,
				@StoreIDDestino,
				@ModelID
				)
		END

		--Inclusao da loja original
		EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
	
		INSERT InventoryMov
			(
			IDInventoryMov,
			InventMovTypeID,
			DocumentID,
			StoreID,
			ModelID,
			IDPessoa,
			MovDate,
			Qty,
			IDUser,
			PreInventoryMovID,
			CostPrice,
			AvgCost
			)
		VALUES
			(
			@IDInventoryMov,
			7,   /* saida da loja original */
			@DocumentID,
			@StoreIDOrigem,
			@ModelID,
			0,
			@TrasfDate,
			@Qty,
			@IDUser,
			@PreInventoryMovID, /* guarda a linha correspondente a inserida */
			@CostPrice,
			@AvgCost
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE TransferITEMS_Cursor
			DEALLOCATE TransferITEMS_Cursor
			CLOSE TransferIN_Cursor
			DEALLOCATE TransferIN_Cursor
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		FETCH NEXT FROM TransferITEMS_Cursor INTO
			@ModelID,
			@Qty,
			@CostPrice,
			@AvgCost
	END

	--fechamento do cursor
	CLOSE TransferITEMS_Cursor
	--Destruição do cursor
	DEALLOCATE TransferITEMS_Cursor

	FETCH NEXT FROM TransferOUT_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@TrasfDate,
		@IDUser,
		@PreInventoryMovID,
		@CostPrice,
		@AvgCost
END

--fechamento do cursor
CLOSE TransferOUT_Cursor
--Destruição do cursor
DEALLOCATE TransferOUT_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO   ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Tranfer_OUT', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Invoice_CalcComission
		(
		@IDCentroCusto	int,
		@IDInvoice   		int,
		@IDInventoryMov 	int,
		@IDTipoLanc		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Cria tabela temporaria para registrar o total de comissao do invoice
		para cada vendedor.
		- Calcula a dada de vencimento de cada vendedor
		- Certifica que exitem registros de lancamentos ja abertos para cada
		vendedor.
		Caso nao exista cria um novo registro.
		- Marca nas movimentacoes de inventario os arquivos de lancamentos corretos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Preenche a tabela temporaria com as comissoes por vendedor
		-202  Erro em UPDATE	#InvComiss
		-203  Erro em INSERT	Fin_Lancamento
		-205  Erro em UPDATE	Fin_Lancamento
		-206  Erro em Marca nas movimentacoes de inventario os arquivos de lancamentos corretos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	16 Nov  1999		Eduardo Costa		Criacao;
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	29 oct  2003		Andre Bogado		Removido erro 204 (removido o update de IDLancamento)
							chamada a sp_Sis_GetNextCode em #InvComiss
							criado o cursor InvComiss_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
	22 Jan 2006		Leonardo Riego		Alterado o campo de Comissao da InventoryMov para SaleItemCommission
							sendo feito o novo calculo de multiplo comissionado na tabela #InvComiss
							e retirada a condicao do ID Comissionado na tabela #InvComiss e 
							InventoryMov nas movimentacoes de inventario os arquivos de lancamentos corretos.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @PayDate 	smalldatetime
DECLARE @ErrorLevel 	int
DECLARE @SysError	int

--Declaração de variáveis para o Cursor de #InvComiss
DECLARE @IDComission 	int
DECLARE @Comission 		money 
DECLARE @IDLancamento	int

SET @ErrorLevel = 0

BEGIN TRAN

if (SELECT PayComission FROM Media (NOLOCK)  WHERE Media.IDMedia = (SELECT MediaID FROM Invoice (NOLOCK) WHERE IDInvoice = @IDInvoice)) = 1
BEGIN

/*

	--------------------------------------------------------------------
	Cria tabela temporaria para registrar o total de comissao do invoice
	para cada vendedor.

*/

CREATE TABLE #InvComiss
	(
	IDComission 	int 		NOT NULL ,
	Comission 	money 		NOT NULL ,
	VencDate	SmallDateTime	NULL,
	IDLancamento	int		NULL
	)



/*
	--------------------------------------------------------------------
	Preenche a tabela temporaria com as comissoes por vendedor

*/

--Declaração do Cursor de #InvComiss

DECLARE InvComiss_Cursor CURSOR FOR
(
		SELECT
			SIC.IDCommission,
			IsNull	( SUM 	(
					(( GroupToComType.Comission / ((100 / SIC.CommissionPercent) * 100) )) *
					(

						(
							(
	 						IsNull(InvMov.SalePrice, 0)-
							(TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))
							)*IsNull(InvMov.Qty, 0)
						)-IsNull(InvMov.Discount, 0)
					)
				), 0) Comission
		FROM 
			InventoryMov InvMov (NOLOCK) 
			JOIN Model Model (NOLOCK) ON (InvMov.ModelID = Model.IDModel)
			JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDInventoryMov = InvMov.IDInventoryMov)
			JOIN vwComissionado Comis (NOLOCK) ON (Comis.IDComissionado = SIC.IDCommission)
			JOIN GroupToComissionType GroupToComType (NOLOCK) ON (GroupToComType.GroupID = Model.GroupID AND GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado )
			JOIN vwTipoComissionado TipoComissionado (NOLOCK) ON (TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado)
		WHERE	
			InvMov.DocumentID = @IDInvoice 
			AND
			InvMov.InventMovTypeID = 1
			AND
			InvMov.IDInventoryMov = IsNull(@IDInventoryMov, InvMov.IDInventoryMov)
		GROUP BY 
			SIC.IDCommission
		)
OPEN InvComiss_Cursor

--Inicialização de InvComiss_Cursor
FETCH NEXT FROM InvComiss_Cursor INTO
	@IDComission,
	@Comission
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT

	INSERT #InvComiss
		(
		IDLancamento,
		IDComission,
		Comission
		)
	VALUES
		(
		@IDLancamento,
		@IDComission,
		@Comission
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InvComiss_Cursor
		DEALLOCATE InvComiss_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InvComiss_Cursor INTO
		@IDComission,
		@Comission
END
--fechamento do cursor
CLOSE InvComiss_Cursor
--Destruição do cursor
DEALLOCATE InvComiss_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*
	--------------------------------------------------------------------
	Calcula a dada de vencimento de cada vendedor


*/

SELECT @PayDate = (SELECT InvoiceDate FROM Invoice WHERE IDInvoice = @IDInvoice)

UPDATE
	#InvComiss
SET
	VencDate = DateAdd	(
					Month,
					1,
					DateAdd	(
						day,
						- DatePart(Day, @PayDate),
						@PayDate
						)
					)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*

	--------------------------------------------------------------------
	Certifica que exitem registros de lancamentos ja abertos para cada
	vendedor.
	Caso nao exista cria um novo registro.

*/


INSERT	Fin_Lancamento
		(
		IDLancamento,
		IDLancamentoTipo,
		IDCentroCusto,
 		IDDocumentoTipo,
		IDPessoa,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento
		)
		(
		SELECT
			IDLancamento,
			@IDTipoLanc,	/* pagamento de Vendedor */
			@IDCentroCusto,
			0,	-- Temporario
			IC.IDComission,
			4, -- Dollares
			6, -- CotacaoPadrao do Dollar
			@PayDate,
			@PayDate
		FROM
			#InvComiss IC 		WHERE
			NOT EXISTS
				(
					SELECT
						L.IDLancamento
					FROM
						Fin_Lancamento L (NOLOCK) 
					WHERE
						L.IDPessoa = IC.IDComission
						AND
						L.IDLancamentoTipo = @IDTipoLanc
						AND
						L.Situacao in (1,5) -- 1=Aberto, 5=ParteQuitado
						AND
						@PayDate < IC.VencDate
						AND
						L.Desativado = 0
				) 	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END 

/*
	--------------------------------------------------------------------
	Agora todos os vendedores ja tem um registro de pagamento
	lancamento no financeiro.

	Falta atualizar o valor do lancamento, a partir da tabela
	temporaria, e atualizar a dada de pagamento do comissionado 

*/

UPDATE
	Fin_Lancamento
SET
	ValorNominal = ValorNominal + IC.Comission,
 	DataVencimento = IC.VencDate
FROM
	#InvComiss IC
WHERE
	IDLancamento = IC.IDLancamento 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END 

/*
	-------------------------------------------------------------------------
	Marca nas movimentacoes de inventario os arquivos de lancamentos corretos
*/


UPDATE
	InventoryMov
SET
	InventoryMov.IDLancPagCom = IC.IDLancamento
FROM	
	#InvComiss 		IC,
 	InventoryMov 	InvMov (NOLOCK) 
WHERE
	InvMov.DocumentID = @IDInvoice
	AND
	InvMov.InventMovTypeID = 1
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END



/*

	--------------------------------------------------------------------
	Dropa a tabela temporaria

*/

DROP TABLE #InvComiss


END   /* End do if do MediaID */


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_CalcComission', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Invoice_SubPayComission
		(
		@IDCentroCusto		int,
		@InvoiceID 			int,
		@ComissionID 			int,
		@PayDate 			smalldatetime
		)

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcule the Comission over Invoice
		- Include the register on Lancamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec sp_Comission_CalcPayDate @ComissionID
		-202  Erro em INSERT Fin_Lancamento


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @DataPagamento  	smalldatetime
DECLARE @Comission		money
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

if not (@ComissionID > 0)
   return

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*			    Calcule the Comission over Invoice	                */
/*------------------------------------------------------------------------------*/

SELECT @Comission =
		(
		SELECT
			IsNull	( SUM 	(
					(IsNull(GroupToComType.Comission, 0)/100) *
					( (IsNull(InvMov.SalePrice, 0) -                         
						  (TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0)))*
                        					          IsNull(InvMov.Qty, 0) ) - IsNull(InvMov.Discount, 0)
                        					), 0)

		FROM
			dbo.InventoryMov InvMov (NOLOCK),
			dbo.Model Model (NOLOCK),
			dbo.GroupToComissionType GroupToComType (NOLOCK),
			dbo.vwComissionado Comis (NOLOCK),
			dbo.vwTipoComissionado TipoComissionado (NOLOCK) 

		WHERE
			InvMov.DocumentID = @InvoiceID
			AND
			InvMov.InventMovTypeID = 1
			AND
			InvMov.ModelID = Model.IDModel
			AND
			Comis.IDComissionado = @ComissionID
			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado
			AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado
			AND
			GroupToComType.GroupID = Model.GroupID
		)
 
/*------------------------------------------------------------------------------------------------------------------*/
/*	               Include the register on Lancamento                                 */
/*------------------------------------------------------------------------------------------------------------------*/

exec	sp_Comission_CalcPayDate 	@ComissionID,
					@PayDate,
					@DataPagamento output

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

INSERT Fin_Lancamento
		(
		IDLancamentoTipo,
		IDCentroCusto,
		IDDocumentoTipo,
		NumDocumento,
		IDPessoa,
 		DataLancamento,
 		DataVencimento,
		IDMoeda,
		IDMoedaCotacao,
		ValorNominal
		)
		VALUES
		(
		6, -- \\Despesas\Comissao\Pagamento de Comissao
		@IDCentroCusto,
		0, -- Temporiario,
		Convert(VarChar(50), @InvoiceID),
		@ComissionID,
		@PayDate,
		@DataPagamento,
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar
		@Comission
		)

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_SubPayComission', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Invoice_SubPayGuideAgency
		(
		@IDCentroCusto	int,
		@InvoiceID 		int,
 		@IDTouristGroup	int,
		@IDGuide 		int,
		@IDAgency 		int,
		@PayDate		SmallDateTime
		)

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Guia e da Agencia
		- Pega a comissao da coordenacao
		- Inclui a comissao do Guia
		- Inclui a comissao do Agencia

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inclui a comissao do Guia
		-202  Erro em Inclui a comissao do Agencia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @DescontaCoordenacao 	bit
DECLARE @Comission			money
DECLARE @Coordenacao		money
DECLARE @ErrorLevel 			int
DECLARE @SysError			int

SET @ErrorLevel = 0


IF not (@IDGuide > 0)
   RETURN

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao do Guia e da Agencia		*/
/*------------------------------------------------------------------------------*/

SELECT 	@Comission =
		(
		SELECT 	
			IsNull	( SUM 	(
					(IsNull(GroupToComType.Comission, 0)/100) *
					( (IsNull(InvMov.SalePrice, 0) - 						  (TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0)))* 					          IsNull(InvMov.Qty, 0) ) - IsNull(InvMov.Discount, 0) 					), 0)
		FROM 	
			dbo.InventoryMov InvMov (NOLOCK) , 
			dbo.Model Model (NOLOCK) ,
			dbo.GroupToComissionType GroupToComType (NOLOCK) , 
			dbo.vwComissionado Comis (NOLOCK) ,
			dbo.vwTipoComissionado TipoComissionado (NOLOCK) 
		WHERE
			InvMov.DocumentID = @InvoiceID 		    			
			AND
			InvMov.InventMovTypeID = 1      				
			AND
			InvMov.ModelID = Model.IDModel 					
			AND
			Comis.IDComissionado = @IDGuide 				
			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado 	
			AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado 	
			AND
			GroupToComType.GroupID = Model.GroupID
		)
 
/*------------------------------------------------------------------------------*/
/*	                   Pega a comissao da coordenacao                       */
/*------------------------------------------------------------------------------*/

SELECT 	@Coordenacao =
		(
		SELECT	
			IsNull 	(( TouristGroup.ComissaoSobreGuia / 100), 0)
		FROM	
			TouristGroup (NOLOCK) 
		WHERE
			TouristGroup.IDTouristGroup = @IDTouristGroup
		)

/*------------------------------------------------------------------------------*/
/*	            Deve descontar a Coordenacao do Guia?                       */
/*------------------------------------------------------------------------------*/

SELECT 	@DescontaCoordenacao =
		(
		SELECT
			TouristGroup.DescontaCoordenacao
		FROM	
			TouristGroup (NOLOCK) 
		WHERE
			TouristGroup.IDTouristGroup = @IDTouristGroup
		)


/*------------------------------------------------------------------------------*/
/*	                   Inclui a comissao do Guia                            */
/*------------------------------------------------------------------------------*/
 
INSERT Fin_Lancamento
		(
		IDLancamentoTipo,
		IDCentroCusto,
		IDDocumentoTipo,
		NumDocumento,
		IDPessoa,
 		DataLancamento,
 		DataVencimento,
		IDMoeda,
		IDMoedaCotacao,
		ValorNominal
		)
		VALUES
		(
		6, -- \\Despesas\Comissao\Pagamento de Comissao
		@IDCentroCusto,
		0, -- Temporiario, 
		Convert(VarChar(50), @InvoiceID),
		@IDGuide,
		@PayDate,
		@PayDate,
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar
		@Comission * (1 - @Coordenacao*@DescontaCoordenacao)
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*	                   Inclui a comissao do Agencia                         */
/*------------------------------------------------------------------------------*/
 
INSERT Fin_Lancamento
		(
		IDLancamentoTipo,
		IDCentroCusto,
		IDDocumentoTipo,
		NumDocumento,
		IDPessoa,
 		DataLancamento,
 		DataVencimento,
		IDMoeda,
		IDMoedaCotacao,
		ValorNominal
		)
		VALUES
		(
		6, -- \\Despesas\Comissao\Pagamento de Comissao
		@IDCentroCusto,
		0, -- Temporiario,
		Convert(VarChar(50), @InvoiceID),
		@IDAgency,
		@PayDate,
		@PayDate,
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar
		@Comission * @Coordenacao
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_SubPayGuideAgency', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Model_Adjust
		(
		@QtyOnOrder        	float,
		@QtyOnRepair       	float,
		@QtyOnPrePurchase  	float,
		@IDModel    	   	int,
		@IDStore      	   	int,
		@Difference 	   	float,
		@IDUser			int,
		@Date			Datetime,
		@Notes			varchar(255), -- Davi
		@IDMovReason		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Ajuste por entrada ou saida de estoque
		- Atualiza o Inventory

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Ajuste por entrada de estoque
		-202  Erro em Ajuste por saida de estoque
		-203  Erro em Atualiza o Inventory
		-204  Erro em Inserir o InventoryMovReason
		


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDInventoryMov; 
							Criado @IDInventoryMov;
	18 Aug 2004		Rodrigo Costa		Gravar error log
	02 Jun 2006		Rodrigo Costa		Inserir o Inventory Mov Reason 
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int
DECLARE @IDInventoryMov	int
DECLARE @AvgCost	money

SET @ErrorLevel = 0

SELECT @AvgCost = StoreAvgPrice FROM Inventory (NOLOCK) WHERE StoreID = @IDStore AND ModelID = @IDModel 

EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
IF @Difference > 0
BEGIN
	/*	Ajuste por entrada de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser,
				AvgCost
				)
				VALUES
				(
				@IDInventoryMov,
				4,
				0,
				@IDStore,
				@IDModel,
				@Date,
				Abs(@Difference),
				@IDUser,
				@AvgCost
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END


	INSERT Inv_MovComplement 	(
				IDInventoryMov,
				IDMovReason,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				@IDMovReason,
				@Notes
				)


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END


END
ELSE
BEGIN
	/*	Ajuste por saida de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser,
				AvgCost
				)
				VALUES
				(
				@IDInventoryMov,
				3,
				0,
				@IDStore,
				@IDModel,
				@Date,
				Abs(@Difference),
				@IDUser,
				@AvgCost
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	INSERT Inv_MovComplement 	(
				IDInventoryMov,
				IDMovReason,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				@IDMovReason,
				@Notes
				)


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END


END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Model_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Model_DescBarCode
			(
			@IDBarCode 	TBarCode,
			@ModelID   	int OutPut
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Verifico a existencia do BarCode para o Model dado


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT @ModelID =
		(
		SELECT
			BarCode.IDModel
		FROM
			dbo.Model Model (NOLOCK) , dbo.BarCode BarCode (NOLOCK) 
		WHERE
			BarCode.IDModel   = Model.IDModel
			AND
			BarCode.IDBarcode = @IDBarCode
		)

SELECT @ModelID   = IsNull(@ModelID, -1)
GO

CREATE PROCEDURE sp_Model_quKitPrice
		(
		@IDModel	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Retorna Qtde e SellingPrice do Model dado em KitModel


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT
	Qty, SellingPrice
FROM
	KitModel (NOLOCK)
WHERE
	KitModel.IDModel = @IDModel
ORDER BY
	Qty
GO

CREATE PROCEDURE sp_Model_quModel
		(
		@IDModel 	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Join do Model dado com sua categoria

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	01 July	2005		Rodrigo Costa		New Table SubGroup;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT
	TG.Name,
	M.SellingPrice,
	M.Peso,
	M.Description,
	(M.VendorCost+M.OtherCost+M.FreightCost) as CurrentCost,
	M.VendorCost,
	M.OtherCost,
	M.FreightCost,
	M.LastCost,
	M.ReplacementCost,
	SG.SubGroup
FROM
	Model M (NOLOCK) 
	JOIN TabGroup TG (NOLOCK) ON ( TG.IDGroup = M.GroupID )
	LEFT OUTER JOIN SubGroup SG (NOLOCK) ON (SG.IDSubGroup = M.IDSubGroup)
WHERE
 	( IDModel = @IDModel )
GO

CREATE PROCEDURE sp_Model_quQtyOnStore
		(
		@ModelID 	int,
		@StoreID 	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna Qtdes de um Model em sua determinada Loja


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF (@StoreID <> 0)
	SELECT
		QtyOnPreSale,
		QtyOnHand,
		QtyOnOrder,
		QtyOnPrePurchase -- CODIGO ANTES DA ALTERACAO
  	FROM
		dbo.Inventory Inventory (NOLOCK) 
  	WHERE
		Inventory.ModelID = @ModelID
		AND
  	 	Inventory.StoreID = @StoreID
ELSE
	SELECT
		QtyOnPreSale,
		QtyOnHand,
		QtyOnOrder,
		QtyOnPrePurchase
  	FROM
		dbo.Inventory Inventory (NOLOCK) 
  	WHERE
		Inventory.ModelID = @ModelID
GO

CREATE PROCEDURE sp_PO_AddItem
		(
		@IDUser			int,
		@IDModel     		int,
		@IDFornecedor		int,
		@IDStore     		int,
		@Qty         		float,
		@CostPrice      	money,
		@SalePrice      	money,
		@SuggRetail      	money,
		@DataPedido    		smalldatetime,
		@EstimatedDate		smalldatetime,
		@BalanceRequest		bit,
		@IDPOItem 	  	int Output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Descobre o IDPO do Fornecedor aberto no momento
		- Inclui o POItem
		- Atualiza o Model
                - Atualiza os totais do PO
		- Atualiza os Vendor Requests para a Mercadoria

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-001  Ok
		-201  Erro em Inclui o POItem
		-202  Erro em Atualiza o Model
		-203  Erro em Atualiza os totais do PO
		-204  Erro em Deleto de Request
		-205  Erro em Insiro em Request


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values;
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDPOItem, @IDPO, @IDRequest; 
							Removido SELECT @IDPO = @@IDENTITY, SELECT @IDPOItem = @@IDENTITY;
							Criado @IDRequest;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @Result		int
DECLARE @IDPO		int
DECLARE @TotalRequest   	int
DECLARE @SubTotal		money
DECLARE @Description		varchar(50)
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDRequest		int

SET @ErrorLevel = 0

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*                Descobre o IDPO do Fornecedor aberto no momento                   */
/*------------------------------------------------------------------------------*/
SELECT @IDPO = 	IsNull(
		(
		SELECT 
			IDPO
		FROM 
			dbo.PO PO (NOLOCK) 
		WHERE
			IDFornecedor = @IDFornecedor   
			AND
			Aberto   = 1 	       
			AND
			IDStore  = @IDStore
		)
		, -1)
IF @IDPO = -1
BEGIN
	SELECT @Result = -1

	EXEC sp_Sis_GetNextCode 'PO.IDPO', @IDPO OUTPUT
	INSERT dbo.PO 
		(
		IDPO,
		IDFornecedor, 
		DataPedido, 
		Aberto, 
		IDStore
		) 
		VALUES 
		(
		@IDPO,
		@IDFornecedor, 
		@DataPedido, 
		1, 
		@IDStore
		)

END
ELSE
BEGIN
	SELECT @Result = 0
END

/*------------------------------------------------------------------------------*/
/*		Inclui o POItem			*/
/*------------------------------------------------------------------------------*/
EXEC sp_Sis_GetNextCode 'PreInventoryMov.IDPreInventoryMov', @IDPOItem OUTPUT
INSERT dbo.vwPOItem	(
	IDPOItem,
	IDPO , 
	ModelID , 
	MovDate , 
	Qty ,
	CostPrice , 
	SalePrice, 
	SuggRetail, 
	IDFornecedor , 
	DateEstimatedMov ,
  	IDStore, 
	InventMovTypeID
	)
	VALUES
	(
	@IDPOItem,
	@IDPO, 
	@IDModel, 
	@DataPedido, 
	@Qty,
	@CostPrice, 
	@SalePrice, 
	@SuggRetail, 
	@IDFornecedor, 
	@EstimatedDate,
	@IDStore, 
	2
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*------------------------------------------------------------------------------*/
/*                             Atualiza o Model                                 */
/*------------------------------------------------------------------------------*/
UPDATE 
	MODEL
SET 
	SuggRetail = @SuggRetail
FROM 
	MODEL (NOLOCK) 
WHERE 
	IDModel = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*        		    Atualiza os totais do PO				*/
/*------------------------------------------------------------------------------*/ 
SELECT @SubTotal = @Qty * @CostPrice 
EXEC sp_PO_AtuPOTotal	@IDPO, @SubTotal

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*     		    Atualiza os Vendor Requests para a Mercadoria		*/
/*------------------------------------------------------------------------------*/
SELECT @TotalRequest =	IsNull(
			(
			SELECT
				SUM(QtyReq)
			FROM	
				dbo.Request (NOLOCK) 
			WHERE
				dbo.Request.StoreID = @IDStore 
				AND
				dbo.Request.ModelID = @IDModel
				), 0)

-- Deleto de Request
DELETE
FROM
	dbo.Request
WHERE
	dbo.Request.StoreID = @IDStore
	AND
	dbo.Request.ModelID = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

IF @TotalRequest > @Qty AND @BalanceRequest = 1
BEGIN
	SELECT @Description = (SELECT Description FROM Model (NOLOCK) WHERE IDModel = @IDModel)

	-- Insiro em Request
	EXEC sp_Sis_GetNextCode 'Request.IDRequest', @IDRequest OUTPUT
	INSERT
		Request (
			IDRequest,
			UserID,
			ModelID,
			Description,
			StoreID,
			Type,
			QtyReq,
			DateRequest
			)
		VALUES
			(
			@IDRequest,
			@IDUser,
			@IDModel,
			@Description,
			@IDStore,
			'P',
			(@TotalRequest-@Qty),
			GetDate()
			)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
END

OK:
	COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_AddItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PO_CalcOrderPoint
	(
	@Date	DateTime = Null
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Calculo dinamico do Ponto de Pedido

		por Maurfcio Pimenta Lima e Eduardo Costa em 9 de agosto de 1999.

		Esta procedure utiliza os seguintes parametros:

		N    - N•mero de dias a serem utilizados no cßlculo do desvio padrao da demanda
		Alfa - Fator a ser utilizado no mTdia amortizada da demanada
		K    - Fator em funtao do Nfvel de servito
		TR   - N•mero de dias entre o pedido e o recebimento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insiro em DailyMaintenanceReport
		-202  Erro em Os campos utilizado para o calculo sao zerados
		-203  Erro em Acumular a venda diaria VD
		-204  Erro em Acumulo a venda anterior ao periodo selecionado VP
		-205  Erro em Calcular a previsao diaria para o proximo dia PVD
		-206  Erro em Calculo SX
		-207  Erro em Calculo SX2
		-208  Erro em Calculo DP
		-209  Erro em Calcular o estoque de seguranta
		-210  Erro em Calcular o Ponto de Pedido
		-211  Erro em Marca como terminado
		-212  Erro em Deleto todos os computer request
		-213  Erro em Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	29 Oct 	2003		Rodrigo Costa		Criado sp_Sis_GetNextCode;
	                      				Criado cursor Request_Cursor;
	18 Nov  2005		Leonardo Riego		Modificação no Update dos campos SX, SX2 e DP;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @N 			int
DECLARE @Alfa  		money
DECLARE @KA			money
DECLARE @KB			money
DECLARE @KC			money
DECLARE @TR			int
DECLARE @PVD 		money
DECLARE @SX 		int
DECLARE @SX2		int
DECLARE @DP			money
DECLARE @DMP		int
DECLARE @ErrorLevel		int
--Declaração de variáveis para o Cursor de Request
DECLARE @ModelID 		int 
DECLARE @Description 	varchar(50)
DECLARE @IDDayMaint	int
DECLARE @IDRequest		int 

SET @ErrorLevel = 0

SELECT @N = 5
SELECT @Alfa = .25
SELECT @TR = 2

SELECT @Date = IsNull(@Date, GetDate())

/* Testa se ja rodou hoje */
IF Exists 	(
		SELECT
			IDDailyMaintenanceReport
		FROM
			DailyMaintenanceReport (NOLOCK) 
		WHERE
			Maintenance = 'CalcOrderPoint'
			AND
			Convert(Char(30), Date, 101) = Convert(Char(30), @Date, 101)
		) Return

-- Insiro em DailyMaintenanceReport
exec sp_Sis_GetNextCode 'DailyMaintenanceReport.IDDailyMaintenanceReport', @IDDayMaint OUTPUT
INSERT DailyMaintenanceReport 
	(
	IDDailyMaintenanceReport,
	Maintenance, 
	Date, 
	LastMessage
	)
	VALUES 
	(
	@IDDayMaint,
	'CalcOrderPoint', 
	@Date, 
	'Started'
	)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

SELECT @DMP = @@Identity

SELECT @KA = Convert(Float, SrvValue) FROM Param WHERE IDParam = 28
SELECT @KB = Convert(Float, SrvValue) FROM Param WHERE IDParam = 29
SELECT @KC = Convert(Float, SrvValue) FROM Param WHERE IDParam = 30

/* Os campos utilizado para o calculo sao zerados */

UPDATE
	Model
SET
	VD = 0, -- Venda dirária
	VP = 0, -- Venda passada ( N dias atrás )
	InicioPontoPedido = IsNull(InicioPontoPedido, @Date)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/* Acumular a venda diaria VD */
UPDATE
	Model
SET	
	VD = MT.Venda
FROM	(
	SELECT
		IM.ModelID IDModel,
		SUM(Qty) Venda
	FROM	
		InventoryMov IM (NOLOCK) 
	WHERE
		InventMovTypeID = 1
		AND
		DateAdd(Day, -1, Convert(Char(30), @Date, 101)) <= IM.MovDate
		AND
		DateAdd(Day, 0, Convert(Char(30), @Date, 101)) > IM.MovDate
	GROUP BY
		IM.ModelID
	) MT
WHERE
	MT.IDModel = Model.IDModel

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/* Acumulo a venda anterior ao periodo selecionado VP */
UPDATE
	Model
SET
	VP = MT.Venda
FROM	(
	SELECT
		IM.ModelID IDModel,
		SUM(Qty) Venda
	FROM
		InventoryMov IM (NOLOCK) 
	WHERE
		InventMovTypeID = 1
		AND 
		DateAdd(Day, (@N * -1) -1, Convert(Char(30), @Date, 101)) <= IM.MovDate
		AND
		DateAdd(Day, @N * -1, Convert(Char(30), @Date, 101)) > IM.MovDate
	GROUP BY
		IM.ModelID
	) MT
WHERE
	MT.IDModel = Model.IDModel
	AND
	DateDiff(Day, InicioPontoPedido, @Date) >= (@N)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/* Calcular a previsao diaria para o proximo dia PVD */
/*     PVD = ALFA * VD + (1 - ALFA) * PVD     */
/*     Inicializado com VD */


UPDATE
	Model
SET	
	PVD = @Alfa * VD + (1 - @Alfa) * IsNull(PVD, VD)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


/* Calcular o desvio padrao DP  */
-- Calculo SX
UPDATE
	Model
SET
	SX = IsNull((SX + VD - VP), VD)
WHERE
	VD < 46000
	AND
	VD >= 0

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

-- Calculo SX2
UPDATE
	Model
SET
	SX2 = POWER(VD,2)
WHERE
	VD < 46000
	AND
	VD >= 0

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

-- Calculo DP
UPDATE
	Model
SET
	DP = CASE
		WHEN DateDiff(Day, InicioPontoPedido, @Date) < (@N-1) THEN 0
		WHEN (@N * SX2 - POWER(SX, 2)) < 0 THEN 1
		ELSE
			SQRT((@N * SX2 - POWER(SX, 2))/(@N*(@N-1)))
	      END
WHERE
	SX >= 0

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


/* Calcular o estoque de seguranta  */
/*     ES = K * DP * (TR^.5)  */

UPDATE
	Model
SET	
	ES = (	CASE Model.ClasseABC
			WHEN 'A' THEN @KA
			WHEN 'E' THEN @KA
			WHEN 'B'THEN @KB
			ELSE @KC
		END ) * DP * SQRT(@TR)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


/* Calcular o Ponto de Pedido */
/*     PP = TR * PVD + ES     */

UPDATE
	Model
SET	
	PP = Model.TR * PVD + ES

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


/* Marca como terminado */

UPDATE  
	DailyMaintenanceReport
SET 
	LastMessage = 'Finished'
WHERE 
	IDDailyMaintenanceReport = @DMP

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END


/* Deleto todos os computer request */
DELETE 
	POItemRequest
WHERE
	IDRequest IN (SELECT IDRequest FROM Request WHERE Type = 'C')
	
DELETE 
	Request 
WHERE 
	Type = 'C'

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END

/* Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido */
--Declaração do Cursor de Request
DECLARE Request_Cursor CURSOR FOR

	SELECT	
		IDModel,
		Description
	FROM	
		Model (NOLOCK) 
	WHERE	
		TotQtyOnHand < PP
		AND
		PP <> 0
		AND
		PP IS NOT NULL
		AND 
		AutomaticRequest = 1
		AND 
		NOT EXISTS ( SELECT ModelID FROM PreInventoryMov PO WHERE PO.ModelID = Model.IDModel AND PO.InventMovTypeID = 2 )
		AND 
		NOT EXISTS ( SELECT ModelID FROM Request R  WHERE R.ModelID = Model.IDModel AND R.Type <> 'C')

OPEN Request_Cursor

--Inicialização de Request_Cursor
FETCH NEXT FROM Request_Cursor INTO
	@ModelID,
	@Description
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Request.IDRequest', @IDRequest OUTPUT

	INSERT Request
		(
		IDRequest,
		ModelID,
		Description,
		UserID,
		QtyReq,
		DateRequest,
		Type,
		StoreID
		)
	VALUES
		(
		@IDRequest,
		@ModelID,
		@Description,
		0,
		1,
		GetDate(),
		'C',
		1
		)

	IF @@ERROR <> 0
	BEGIN
		CLOSE Request_Cursor
		DEALLOCATE Request_Cursor
		SET @ErrorLevel = -213
		GOTO ERRO
	END

	FETCH NEXT FROM Request_Cursor INTO
		@ModelID,
		@Description
END
--fechamento do cursor
CLOSE Request_Cursor
--Destruição do cursor
DEALLOCATE Request_Cursor


IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PO_CalcOrderPointSimple
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Calculo dinamico do Ponto de Pedido Simples

		por Maximiliano Muniz e Rodrigo Costa em 30 de janeiro de 2006.

		Esta procedure utiliza os seguintes parametros:		
			Month - Periodo utilizado para calcular as vendas do produto;
			Type - Tipo de tela;

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-200  Erro em Insiro em DailyMaintenanceReport
		-201  Erro em Atualizar a última data processada em DailyMaintenanceReport
		-202  Erro em calcular a media de entrega
		-203  Erro em calcular a media de vendas no periodo
		-204  Erro em calcular o ponto de pedido
		-205  Erro em Altera o status do processamento após a conclusão
		-206  Erro em Deleto todos os computer request
		-207  Erro em Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	30 Jan	2006		Max e Rodrigo		Criacao;
	24 Feb	2006		Maximiliano Muniz	Alterado o filtro por data no cálculo da média de vendas;
	14 Jun	2006		Leonardo Riego		Verifica se é utilizado quantidade fracionária para o cálulo
							da Autoequisição;
	28 Jun	2006		Leonardo Riego		Adicionado filtro de inclusao de modelos filtrados por loja;
	27 Oct	2006		Maximiliano e Maic	Alterada condição para auto-requisitar, com base nos parâmetros
							de configuração de estoque. Apenas produtos de classes que
							auto-requisitam, serão selecionados;
	07 Feb	2007		Maximiliano Muniz	Adicionado cálculo de média de vendas, média de tempo de entrega,
							margem de segurança e ponto de pedido por loja;
	05 Mar	2007		Maximiliano Muniz	Correção na query que cria as auto-requisições;
	06 Mar	2007		Rodrigo Costa		Setar as Cotacoes para NULL
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @Today			datetime
DECLARE @LastProcess		datetime
DECLARE @IDDayMaint		int
DECLARE @Type			int
DECLARE @IDStore		int
DECLARE @IDRequest		int
DECLARE @IDModel 		int
DECLARE @Description		varchar(50)
DECLARE @Qty			float
DECLARE @SaleMonth		int
DECLARE @SafeMarginClassA	int
DECLARE @SafeMarginClassB	int
DECLARE @SafeMarginClassC	int
DECLARE @POPeriodClassA		int
DECLARE @POPeriodClassB		int
DECLARE @POPeriodClassC		int
DECLARE @StoreAutoRequest	int
DECLARE @QtyFrac		bit
DECLARE @AutoRequestClassA	bit
DECLARE @AutoRequestClassB	bit
DECLARE @AutoRequestClassC	bit

SET @ErrorLevel = 0
SET @LastProcess = 0
SET @Type = (SELECT Convert(int, SrvValue) FROM Param (NOLOCK) Where IDParam = 63)

--Periodo
(SELECT @SaleMonth = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'AutoRequestSalePeriodInMonth')

--Margem de seguranca
(SELECT @SafeMarginClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PercSecurityMarginClassA')
(SELECT @SafeMarginClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PercSecurityMarginClassB')
(SELECT @SafeMarginClassC = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PercSecurityMarginClassC')

--Periodo para compra
(SELECT @POPeriodClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'POTimeSetupClassAInDays')
(SELECT @POPeriodClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'POTimeSetupClassBInDays')
(SELECT @POPeriodClassC = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'POTimeSetupClassCInDays')

--Classes que auto-requisitam
(SELECT @AutoRequestClassA = CONVERT(bit, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'AutoRequestClassA')
(SELECT @AutoRequestClassB = CONVERT(bit, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'AutoRequestClassB')
(SELECT @AutoRequestClassC = CONVERT(bit, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'AutoRequestClassC')

--Loja que vai ser à base do cálculo
(SELECT @StoreAutoRequest = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'StoreToAutoRequest')

--------------------------------------------------------------------------------------------------------------
-- Pego a última data processada ou a primeira data a processar
SELECT @Today	= CONVERT(smalldatetime, CONVERT(varchar, GetDate(), 103), 103)
SELECT @LastProcess	= CONVERT(smalldatetime, CONVERT(varchar, MAX(Date), 103), 103) FROM DailyMaintenanceReport (NOLOCK) WHERE Maintenance = 'CalcOrderPoint'

IF @LastProcess = @Today
	RETURN
ELSE
BEGIN
	IF @LastProcess > 0
		SET @LastProcess = DateAdd(DAY, 1, @LastProcess)
	ELSE
	BEGIN
		----------------------------------------------------------------------------------------------
		-- Se ainda não processou nenhuma vez, insiro em DailyMaintenanceReport
		-- com a data da primeira movimentação do sitema
		SELECT @LastProcess = CONVERT(smalldatetime, CONVERT(varchar, MIN(MovDate), 103), 103) FROM InventoryMov (NOLOCK) 

		exec sp_Sis_GetNextCode 'DailyMaintenanceReport.IDDailyMaintenanceReport', @IDDayMaint OUTPUT
		INSERT DailyMaintenanceReport 
			(
			IDDailyMaintenanceReport,
			Maintenance,
			[Date],
			LastMessage
			)
			VALUES
			(
			@IDDayMaint,
			'CalcOrderPoint',
			@LastProcess,
			'Started'
			)
		
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -200
			GOTO ERRO
		END
	END
END

-----------------------------------------------------------------------------------------------------------------
-- Atualizar a última data processada em DailyMaintenanceReport
UPDATE DailyMaintenanceReport SET [Date] = @Today, LastMessage = 'Started' WHERE Maintenance = 'CalcOrderPoint'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- SUM(DataCompra - DataPedido)/Count(Numero Compras)
-- Calculo Media Entrega [ME] por produto
UPDATE
	M
SET
	M.TR = IsNull(P.MediaPedido, 0)
FROM
	Model M
	LEFT JOIN	(
		SELECT
			PUI.IDModel,
			(SUM(DATEDIFF(Day, PO.DataPedido, PU.DatePreReceiving))/COUNT(PU.IDPurchase)) as MediaPedido
		FROM
			Pur_Purchase PU (NOLOCK) 
			JOIN PO (NOLOCK) ON (PU.IDPO = PO.IDPO)
			JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PUI.IDPurchase = PU.IDPurchase)
			JOIN Model M (NOLOCK) ON (M.IDModel = PUI.IDModel)
		WHERE
			PU.DatePreReceiving >= DATEADD(month, - @SaleMonth, GetDate())
		GROUP BY
			PUI.IDModel) P ON (M.IDModel = P.IDModel)

-- Calculo Media Entrega [ME] por loja e produto
UPDATE
	I
SET
	I.LeadTime = IsNull(P.MediaPedido, 0)
FROM
	Inventory I
	LEFT JOIN	(
		SELECT
			PU.IDStore,
			PUI.IDModel,
			(SUM(DATEDIFF(Day, PO.DataPedido, PU.DatePreReceiving))/COUNT(PU.IDPurchase)) as MediaPedido
		FROM
			Pur_Purchase PU (NOLOCK) 
			JOIN PO (NOLOCK) ON (PU.IDPO = PO.IDPO)
			JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PUI.IDPurchase = PU.IDPurchase)
			JOIN Model M (NOLOCK) ON (M.IDModel = PUI.IDModel)
		WHERE
			PU.DatePreReceiving >= DATEADD(month, - @SaleMonth, GetDate())
		GROUP BY
			PU.IDStore,
			PUI.IDModel
		) P ON (I.StoreID = P.IDStore AND I.ModelID = P.IDModel)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

-- Calculo Media Venda [MV]
IF (@Type = 1)
BEGIN
	-- por produto
	UPDATE
		M
	SET	
		PVD = CASE WHEN MT.Venda IS NULL THEN 0 ELSE MT.Venda / MT.Period END
	FROM
		Model M
		LEFT JOIN	(
			SELECT
				IM.ModelID IDModel,
				SUM(Qty) Venda,
				DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
			FROM	
				InventoryMov IM (NOLOCK) 
				JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
			WHERE
				InventMovTypeID = 1
				AND IM.MovDate >= DATEADD(month, - @SaleMonth, GetDate())
				AND TG.Service = 0
			GROUP BY
				IM.ModelID
			) MT ON (M.IDModel = MT.IDModel)

	-- por loja e produto
	UPDATE
		I
	SET	
		DailySales = CASE WHEN MT.Venda IS NULL THEN 0 ELSE MT.Venda / MT.Period END
	FROM
		Inventory I
		LEFT JOIN	(
			SELECT
				IM.StoreID IDStore,
				IM.ModelID IDModel,
				SUM(Qty) Venda,
				DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
			FROM	
				InventoryMov IM (NOLOCK) 
				JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
			WHERE
				InventMovTypeID = 1
				AND IM.MovDate >= DATEADD(month, - @SaleMonth, GetDate())
				AND TG.Service = 0
			GROUP BY
				IM.StoreID,
				IM.ModelID
			) MT ON (MT.IDStore = I.StoreID AND MT.IDModel = I.ModelID)
END
ELSE
BEGIN
	-- por produto
	UPDATE
		M
	SET	
		PVD = CASE WHEN MT.Venda IS NULL THEN 0 ELSE MT.Venda / MT.Period END
	FROM
		Model M
		LEFT JOIN	(
			SELECT
				IM.ModelID IDModel,
				SUM(Qty) Venda,
				DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
			FROM	
				vwSaleItem IM (NOLOCK) 
				JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
				JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
			WHERE
				IM.InventMovTypeID = 1
				AND
				IM.PreSaleDate >= DATEADD(month, - @SaleMonth, GetDate())
				AND
				TG.Service = 0
			GROUP BY
				IM.ModelID
			) MT ON (MT.IDModel = M.IDModel)

	-- por loja
	UPDATE
		I
	SET	
		DailySales = CASE WHEN MT.Venda IS NULL THEN 0 ELSE MT.Venda / MT.Period END
	FROM
		Inventory I
		LEFT JOIN	(
			SELECT
				IM.StoreID IDStore,
				IM.ModelID IDModel,
				SUM(Qty) Venda,
				DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
			FROM	
				vwSaleItem IM (NOLOCK) 
				JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
				JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
			WHERE
				IM.InventMovTypeID = 1
				AND IM.PreSaleDate >= DATEADD(month, - @SaleMonth, GetDate())
				AND TG.Service = 0
			GROUP BY
				IM.StoreID,
				IM.ModelID
			) MT ON (MT.IDStore = I.StoreID AND MT.IDModel = I.ModelID)
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

-- Calculo da margem de suguranca do ponto de pedido [Round(ME*MV)] * (Margem/100)
-- por produto
UPDATE
	Model
SET
	ES = CASE ClasseABC 
			WHEN 'A' THEN Round(TR * PVD, 2) * (@SafeMarginClassA/100.0)
			WHEN 'B' THEN Round(TR * PVD, 2) * (@SafeMarginClassB/100.0)
			WHEN 'C' THEN Round(TR * PVD, 2) * (@SafeMarginClassC/100.0)
		END
				
-- por loja e produto
UPDATE
	Inventory
SET
	SafetyMargin = CASE ClassABC
			WHEN 'A' THEN Round(LeadTime * DailySales, 2) * (@SafeMarginClassA/100.0)
			WHEN 'B' THEN Round(LeadTime * DailySales, 2) * (@SafeMarginClassB/100.0)
			WHEN 'C' THEN Round(LeadTime * DailySales, 2) * (@SafeMarginClassC/100.0)
		END


-- Calculo Ponto do Pedido [Round(ME*MV+ES)]
-- por produto
UPDATE
	Model
SET
	PP = Round((TR * PVD) , 2)

-- por loja e produto
UPDATE
	Inventory
SET
	OrderPoint = Round((LeadTime * DailySales) , 2)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/* Deleto todos os computer request */
DELETE 
	POItemRequest
WHERE
	IDRequest IN (SELECT IDRequest FROM Request WHERE Type = 'C')

/* Set as Cotacoes para NULL */
UPDATE
	CM
SET
	CM.IDRequest = NULL
FROM
	CotacaoToModel CM (NOLOCK) 
	JOIN Request R (NOLOCK) ON (R.IDRequest = CM.IDRequest)
	
DELETE 
	Request 
WHERE 
	Type = 'C'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

/* Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido */

-- Verifica se é utilizado quantidade fracionária.
SELECT
	@QtyFrac = CASE UPPER(SrvValue) WHEN 'TRUE' THEN 1 ELSE 0 END
FROM
	Param (NOLOCK) 
WHERE
	IDParam = 85


/* Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido */
--Declaração do Cursor de Request

IF (@StoreAutoRequest = 0)
BEGIN
	DECLARE Store_Cursor CURSOR FOR

		SELECT
			IDStore
		FROM
			Store (NOLOCK) 
		ORDER BY
			IDStore

	OPEN Store_Cursor

	--Inicialização de Store_Cursor
	FETCH NEXT FROM Store_Cursor INTO
		@IDStore

	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE Request_Cursor CURSOR FOR

			SELECT
				I.ModelID,
				Model.Description,
				CASE I.ClassABC
					WHEN 'A' THEN Round(I.DailySales * @POPeriodClassA,2)
					WHEN 'B' THEN Round(I.DailySales * @POPeriodClassB,2)
					WHEN 'C' THEN Round(I.DailySales * @POPeriodClassC,2)
				END
			FROM
				Inventory I (NOLOCK) 
				JOIN Model Model (NOLOCK) ON (Model.IDModel = I.ModelID)
			WHERE
				(I.OrderPoint + I.SafetyMargin) >=	(CASE @Type
						WHEN 1 THEN I.QtyOnHand
						ELSE I.QtyOnHand - I.QtyOnPreSale
						END)
				AND I.OrderPoint <> 0
				AND I.OrderPoint IS NOT NULL
				AND AutomaticRequest = 1
				AND ((@AutoRequestClassA = 1 AND I.ClassABC = 'A') OR (@AutoRequestClassB = 1 AND I.ClassABC = 'B') OR (@AutoRequestClassC = 1 AND I.ClassABC = 'C'))
				AND I.StoreID = @IDStore
				AND NOT EXISTS ( SELECT ModelID FROM PreInventoryMov PO WHERE PO.ModelID = Model.IDModel AND PO.InventMovTypeID = 2 AND (PO.Qty < PO.QtyRealMov))
				AND NOT EXISTS ( SELECT ModelID FROM Request R  WHERE R.ModelID = Model.IDModel AND R.Type <> 'C')

		OPEN Request_Cursor

		--Inicialização de Request_Cursor
		FETCH NEXT FROM Request_Cursor INTO
			@IDModel,
			@Description,
			@Qty

		--Enquanto tem registros
		WHILE
		@@FETCH_STATUS = 0
		BEGIN
			EXEC sp_Sis_GetNextCode'Request.IDRequest', @IDRequest OUTPUT
		
			IF @QtyFrac = 0
			BEGIN
				SET @Qty = CEILING(@Qty)
			END

			INSERT Request
				(
				IDRequest,
				ModelID,
				Description,
				UserID,
				QtyReq,
				DateRequest,
				Type,
				StoreID
				)
			VALUES
				(
				@IDRequest,
				@IDModel,
				@Description,
				0,
				@Qty,
				GetDate(),
				'C',
				@IDStore
				)

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE Request_Cursor
				DEALLOCATE Request_Cursor
				SET @ErrorLevel = -213
				GOTO ERRO
			END

			FETCH NEXT FROM Request_Cursor INTO
				@IDModel,
				@Description,
				@Qty
		END
		--fechamento do cursor
		CLOSE Request_Cursor
		--Destruição do cursor
		DEALLOCATE Request_Cursor

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -207
			GOTO ERRO
		END

		FETCH NEXT FROM Store_Cursor INTO
			@IDStore

	END

	--fechamento do cursor
	CLOSE Store_Cursor
	--Destruição do cursor
	DEALLOCATE Store_Cursor
END
ELSE
BEGIN
	DECLARE Request_Cursor CURSOR FOR

		SELECT	
			I.ModelID,
			Model.Description,
			CASE I.ClassABC
				WHEN 'A' THEN Round(I.DailySales * @POPeriodClassA,2)
				WHEN 'B' THEN Round(I.DailySales * @POPeriodClassB,2)
				WHEN 'C' THEN Round(I.DailySales * @POPeriodClassC,2)
			END
		FROM
			Inventory I (NOLOCK) 
			JOIN Model Model (NOLOCK) ON (Model.IDModel = I.ModelID)
		WHERE	
			(I.OrderPoint + I.SafetyMargin) >=	(CASE @Type
					WHEN 1 THEN I.QtyOnHand 
					ELSE I.QtyOnHand - I.QtyOnPreSale
					END)
			AND I.OrderPoint <> 0
			AND I.OrderPoint IS NOT NULL
			AND AutomaticRequest = 1
			AND ((@AutoRequestClassA = 1 AND I.ClassABC = 'A') OR (@AutoRequestClassB = 1 AND I.ClassABC = 'B') OR (@AutoRequestClassC = 1 AND I.ClassABC = 'C'))
			AND I.StoreID = @StoreAutoRequest
			AND NOT EXISTS ( SELECT ModelID FROM PreInventoryMov PO WHERE PO.ModelID = Model.IDModel AND PO.InventMovTypeID = 2 AND (PO.Qty < PO.QtyRealMov))
			AND NOT EXISTS ( SELECT ModelID FROM Request R  WHERE R.ModelID = Model.IDModel AND R.Type <> 'C')

	OPEN Request_Cursor

	--Inicialização de Request_Cursor
	FETCH NEXT FROM Request_Cursor INTO
		@IDModel,
		@Description,
		@Qty
	
	--Enquanto tem registros
	WHILE
	@@FETCH_STATUS = 0
	BEGIN
		EXEC sp_Sis_GetNextCode'Request.IDRequest', @IDRequest OUTPUT
	
		IF @QtyFrac = 0
		BEGIN
			SET @Qty = CEILING(@Qty)
		END
	
		INSERT Request
			(
			IDRequest,
			ModelID,
			Description,
			UserID,
			QtyReq,
			DateRequest,
			Type,
			StoreID
			)
		VALUES
			(
			@IDRequest,
			@IDModel,
			@Description,
			0,
			@Qty,
			GetDate(),
			'C',
			@StoreAutoRequest
			)
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Request_Cursor
			DEALLOCATE Request_Cursor
			SET @ErrorLevel = -213
			GOTO ERRO
		END
	
		FETCH NEXT FROM Request_Cursor INTO
			@IDModel,
			@Description,
			@Qty
	
	END
	--fechamento do cursor
	CLOSE Request_Cursor
	--Destruição do cursor
	DEALLOCATE Request_Cursor
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -207
		GOTO ERRO
	END
END

-------------------------------------------------------------------------------------------------
-- Altera o status do processamento após a conclusão
UPDATE DailyMaintenanceReport SET LastMessage = 'Finished' WHERE Maintenance = 'CalcOrderPoint'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205

	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'System', 'Error: sp_PO_CalcOrderPoint', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PO_CalcTotalQty
		(
		@IDPO     		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizacao do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	11 Mar 2005		Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @Counted	int
DECLARE @Records	int
DECLARE @Aberto	bit

SET @ErrorLevel = 0

--Retorno as quantidades
SELECT
	@Counted = COUNT(IDPreInventoryMov)
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.InventMovTypeID = 2
	AND
	PIM.DocumentID = @IDPO
	AND
	PIM.Qty > PIM.QtyRealMov

--Contar as linhas de itens do PO
SELECT
	@Records = COUNT(IDPreInventoryMov)
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.InventMovTypeID = 2
	AND
	PIM.DocumentID = @IDPO

--
IF ((@Records>0) AND (@Counted=0))
	SET @Aberto = 0
ELSE
	SET @Aberto = 1

--Atualizo PO
UPDATE
	PO
SET
	PO.Aberto = @Aberto
FROM
	PO (NOLOCK) 
WHERE
	PO.IDPO = @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_CalcTotalQty', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PO_ChangeItem
		(
		@IDModel                	int,
		@IDPOItem 	  	int,
		@IDPO			int,
		@Qty			float,
		@CostPrice		money,
		@SalePrice		money,
		@SuggRetail		money,
		@DataPedido    		smalldatetime,
		@EstimatedDate	smalldatetime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Muda os valores do POItem atual
		- Atualiza o Model
		- Atualiza o total do PO
		- Verifica Condição de fechamento do PO e atualiza

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok		
		-201  Erro em Muda os valores do POItem atual
		-202  Erro em Atualiza o Model
		-203  Erro em Atualiza o total do PO
		-204  Erro em Verifica Condição de fechamento do PO e atualiza


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug  2004		Rodrigo Costa		Gravar error log
	30 Nov 2005		Carlos Lima		Atualizar totais e fechamento
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @SubTotal	money
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN


/*------------------------------------------------------------------------------*/
/*     	      Muda os valores do POItem atual					*/
/*------------------------------------------------------------------------------*/

UPDATE
	dbo.vwPOItem
SET	
	Qty 			= @Qty,
	CostPrice  		= @CostPrice,
	SalePrice  		= @SalePrice,
	SuggRetail 		= @SuggRetail,
	MovDate 		= @DataPedido,
	DateEstimatedMov 	= @EstimatedDate
WHERE
	IDPOItem = @IDPOItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                             Atualiza o Model                                 */
/*------------------------------------------------------------------------------*/
UPDATE 
	MODEL
SET
	SuggRetail = @SuggRetail
FROM
	MODEL (NOLOCK) 
WHERE
	IDModel = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*		Atualiza o total do PO						*/
/*------------------------------------------------------------------------------*/

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*---------------------------------------------------------------------------------------------------------------------*/
/*               Verifica Condição de fechamento do PO e atualiza		*/
/*---------------------------------------------------------------------------------------------------------------------*/
EXEC sp_PO_CalcTotalQty @IDPO	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_ChangeItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PO_DeleteItem
		( 		
			@IDPOItem	int,
	 		@IDPO		int,
			@SubTotal	money
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Remove Item do PO
		- Atualiza o total do PO
		- Testa se o numero de itens chegou a zero e deleta o PO
		- Verifica Condição de fechamento do PO e atualiza


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Remove Item do PO
		-202  Erro em Testa se o numero de itens chegou a zero e deleta o PO
		-203  Erro em Atualiza o total do PO
		-204  Verifica Condição de fechamento do PO e atualiza

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug  2004		Rodrigo Costa		Gravar error log
	29 Nov  2005		Carlos Lima		Atualizar totais e fechamento ao excluir item do PO
	
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @CountItem 	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*		Remove Item do PO		*/
/*-----------------------------------------------------------------------------*/

SELECT @SubTotal = -@SubTotal

--EXEC sp_PO_AtuPOTotal @IDPO, @SubTotal

DELETE FROM dbo.vwPOItem WHERE dbo.vwPOItem.IDPOItem = @IDPOItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*		Atualiza o total do PO		*/
/*-----------------------------------------------------------------------------*/

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*---------------------------------------------------------------------------------------------------------------------*/
/*                Testa se o numero de itens chegou a zero e deleta o PO	*/
/*---------------------------------------------------------------------------------------------------------------------*/

SELECT @CountItem = 	(
			SELECT 
				Count(*)
			FROM 
				dbo.vwPOItem (NOLOCK) 
			WHERE 
				dbo.vwPOItem.IDPO = @IDPO
			)

IF @CountItem = 0
	DELETE FROM dbo.PO WHERE IDPO = @IDPO

	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------------------------------------------------------------------------------------------------------------*/
/*               Verifica Condição de fechamento do PO e atualiza		*/
/*---------------------------------------------------------------------------------------------------------------------*/
IF @CountItem <> 0
BEGIN
	EXEC sp_PO_CalcTotalQty @IDPO	

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
END



OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_DeleteItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PO_GetCurrentPO
	(
	@IDStore	int,
	@IDPessoa	int,
	@Date		Datetime,
	@IDPO		int output,
	@NewOne	bit output
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna qual o PO aberto para a Store e Pessoa selecionados
		- Caso nao exista inclui um novo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em INSERT PO


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDPO; 
							Removido SET @IDPO = @@IDENTITY;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

SET @IDPO 	= Null
SET @NewOne = 0

------------------------------------------------------------------------------
-- Pesquisa por um PO aberto

SELECT
	@IDPO=IDPO
FROM
	PO (NOLOCK) 
WHERE
	PO.IDFornecedor = @IDPessoa
	AND
	PO.Aberto   = 1
	AND
	PO.IDStore  = @IDStore
	AND
	convert(SmallDateTime, convert(varchar, PO.DataPedido, 103), 103) = convert(SmallDateTime, convert(varchar, @Date, 103), 103)


------------------------------------------------------------------------------
-- Verifico se achou algum

IF @IDPO IS NULL
BEGIN
	------------------------------------------------------------------------------
	-- Nao existe, inclui um novo
	EXEC sp_Sis_GetNextCode 'PO.IDPO ', @IDPO OUTPUT
	INSERT
		PO (IDPO, IDFornecedor, DataPedido, Aberto, IDStore)
	VALUES
		(@IDPO, @IDPessoa, @Date, 1, @IDStore)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	SET @NewOne = 1
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_GetCurrentPO', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PO_Item_Do
		(
		@IDPreInventoryMov 	int,
		@IDPO			int
		)
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto a POItemRequest
		- Atualiza SuggRetail no Model
		- Atualiza as informações nos Subs
		- Atualiza Total no PO
		- Incluo a POItemRequest
		- Atualizo a condição de fechamento do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deteto a POItemRequest
		-202  Erro em Atualiza o Model
		-203  Erro em Copio os dados do master para os subs
		-204  Erro em Atualiza o total do PO
		-205  Erro em Recrio  a POItemRequest
		-206  Erro em  Atualizo a condição de fechamento do PO



	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	01 Dec 2005		Carlos Lima		Verificar a condição de fechamento do PO e atualizar
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @QtyAtual	float
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

------------------------------------------------------------------------------
-- Deteto a POItemRequest

DELETE
	POIR
FROM
	POItemRequest POIR (NOLOCK) 
	JOIN 
	PreInventoryMov PIM (NOLOCK) ON (POIR.IDPreInventoryMov = PIM.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @IDPO
	AND
	PIM.InventMovTypeID = 2 -- Compra

SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END



------------------------------------------------------------------------------
-- Atualiza o Model

UPDATE
	M
SET
	M.SuggRetail = PIM.SuggRetail
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN 
	Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
WHERE
	PIM.IDPreInventoryMov = @IDPreInventoryMov
	AND
	IsNull(PIM.SuggRetail,0) <> 0


SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END



------------------------------------------------------------------------------
-- Copio os dados do master para os subs

UPDATE
	PIMS
SET
	PIMS.CostPrice 			= PIMM.CostPrice,
	PIMS.SuggRetail		= PIMM.SuggRetail,
	PIMS.IDPessoa			= PIMM.IDPessoa,
	PIMS.DateEstimatedMov		= PIMM.DateEstimatedMov,
	PIMS.StoreID			= PIMM.StoreID,
	PIMS.SalePrice			= PIMM.SalePrice,
	PIMS.DocumentID		= PIMM.DocumentID,
	PIMS.MovDate			= PIMM.MovDate,
	PIMS.InventMovTypeID		= PIMM.InventMovTypeID,
	PIMS.UserID			= PIMM.UserID
FROM
	PreInventoryMov PIMM (NOLOCK) 
	JOIN 
	PreInventoryMov PIMS (NOLOCK) ON (PIMM.IDPreInventoryMov = PIMS.IDPreInventoryMovParent)
WHERE
	PIMM.IDPreInventoryMov = @IDPreInventoryMov

SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Atualiza o total do PO

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END



------------------------------------------------------------------------------
-- Recrio  a POItemRequest

INSERT
	POItemRequest
	(
	IDPreInventoryMov,
	IDRequest,
	Qty
	)
SELECT
	PIM.IDPreInventoryMov,
	R.IDRequest,
	CASE WHEN R.QtyReq <= PIM.Qty THEN R.QtyReq ELSE R.QtyReq - PIM.Qty END
FROM
	Request R (NOLOCK) 
	JOIN 
	PreInventoryMov PIM (NOLOCK) ON (R.ModelID = PIM.ModelID)
WHERE
	IsNull(R.QtyReq, 0) > IsNull(R.QtyOrdered, 0)
	AND
	PIM.DocumentID = @IDPO
	AND
	PIM.InventMovTypeID = 2 -- Compra


SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Atualizo a condição de fechamento do PO

EXEC sp_PO_CalcTotalQty @IDPO
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_Item_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PO_Item_InsertSubModel
	(
	@IDModel		int,
	@IDPreInventoryMov	int,
	@IDStore		int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreInventoryMov
		- Insiro em PreInventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto PreInventoryMov
		-202  Erro em Insiro em PreInventoryMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	12 July 2001		Rodrigo Costa		Novo Param @IDStore. O PreInvMov precisa de IDStore para o Trigger
	22 Jan	2002		Rodrigo Costa		Incluir o Inventory MovType nos subItems
	29 Oct	2003		Rodrigo Costa		Criado cursor PreInventoryMov_Cursor;
							Chama sp_GetNextCode;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		 	int
DECLARE @SysError			int
--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @IDPreInventoryMovParent 	int 
DECLARE @DocumentID 		int 
DECLARE @InventMovTypeID 	 	int 
DECLARE @PreInventoryMovID	 	int

SET @ErrorLevel = 0

-- Deleto PreInventoryMov
DELETE
	PIM
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.IDPreInventoryMovParent = @IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


-- Insiro em PreInventoryMov
--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMov_Cursor CURSOR FOR

SELECT
	@IDPreInventoryMov,
	0,
	M.IDModel,
	2
FROM
	Model M (NOLOCK) 
WHERE
	M.IDModelParent = @IDModel

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@IDPreInventoryMovParent,
	@DocumentID,
	@IDModel,
	@InventMovTypeID
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventoryMovID OUTPUT
	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		IDPreInventoryMovParent,
		StoreID,
		DocumentID,
		ModelID,
		InventMovTypeID
		)
	VALUES
		(
		@PreInventoryMovID,
		@IDPreInventoryMovParent,
		@IDStore,
		@DocumentID,
		@IDModel,
		@InventMovTypeID
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@IDPreInventoryMovParent,
		@DocumentID,
		@IDModel,
		@InventMovTypeID
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_Item_InsertSubModel', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PO_Item_Remove
		(
		@IDPO     		int,
		@IDPreInventoryMov	int
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Removo todoas as relações entre PO e request
		- Removo os SubItens
		- Removo o Item
		- Atualizo o total do PO
		- Verifica condição de Fechamento e Atualiza

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Removo todoas as relações entre PO e request
		-202  Erro em Removo os subItems
		-203  Erro em Removo o Item
		-204  Erro em Atualizo o total do PO
		-205  Erro em Verifica condição de Fechamento e Atualiza


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	30 Nov 2005		Carlos Lima		Verifica condição de Fechamento e Atualiza
	03 Aug 2006		Leonardo Riego		Só exclui POs que não possuem itens com recebimento final.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @CountItem	int

SET @ErrorLevel = 0

BEGIN TRAN

------------------------------------------------------------------------------------------------------
-- Removo todoas as relações entre PO e request

DELETE
	POIR
FROM
	POItemRequest POIR (NOLOCK) 
WHERE
	POIR.IDPreInventoryMov = @IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


-------------------------------------------------------------------------------------------------------
-- Removo os subItems

DELETE
	PIM
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.IDPreInventoryMovParent = @IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


--------------------------------------------------------------------------------------------------------
-- Removo o Item

DELETE
	PIM
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.IDPreInventoryMov = @IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


------------------------------------------------------------------------------------------------------
-- Atualizo o total do PO


/*---------------------------------------------------------------------------------------------------------------------*/
/*                Testa se o numero de itens chegou a zero e deleta o PO	*/
/*---------------------------------------------------------------------------------------------------------------------*/

SELECT @CountItem = 	(
			SELECT 
				Count(*)
			FROM 
				dbo.vwPOItem  (NOLOCK) 	
			WHERE 
				dbo.vwPOItem.IDPO = @IDPO
			)

SELECT @CountItem = @CountItem	+	(
				 	SELECT
						COUNT(*)
				 	FROM
						Pur_Purchase (NOLOCK) 
				 	WHERE
						IDPO = @IDPO
						AND
						DatepreReceiving IS NOT NULL
				 	)				

IF @CountItem = 0
BEGIN
	EXEC sp_PO_Remove @IDPO

SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
END

IF @CountItem > 0
BEGIN
	EXEC sp_PO_AtuPOTotal @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
	
	EXEC sp_PO_CalcTotalQty @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_Item_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Pessoa_CalcSaldos

			(
			@IDPessoa 	int,
			@CalcDate	DateTime
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula Saldo Vencido e a Vencer baseado em uma determinada data


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT 	IsNull(	(
		SELECT
 			Sum(ValorPrevisto - ValorQuitado)
 		FROM
			dbo.Lancamento (NOLOCK) 
		WHERE
			(Situacao = 'N')
			AND
			(IDPessoa = @IDPessoa)
			AND
			(DataVencimento <= @CalcDate)
		), 0) as SaldoVencido,
 
	IsNull(	(
		SELECT
			Sum(ValorPrevisto - ValorQuitado)
		FROM
			dbo.Lancamento (NOLOCK) 
		WHERE
			(Situacao = 'N')
			AND
			(IDPessoa = @IDPessoa)
			AND
			(DataVencimento > @CalcDate)
		),0)  as SaldoAVencer
GO

CREATE PROCEDURE sp_Pessoa_GetPessoaRoot
		(
			@IDTipoPessoa 	int,
			@IDPessoa		int,
			@Code			int output,
			@IDTipoPessoaRoot 	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualiza os proximo TipoPessoaRoot

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no UpdateTipo Pessoa
		-202  Erro no Select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	22 Mac  2005		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	@Code = (IsNull(TP.LastCode, 0) + 1),
	@IDTipoPessoaRoot = Tp.IDTipoPessoa
FROM
	TipoPessoa TP1 (NOLOCK) 
	JOIN
	TipoPessoa TP (NOLOCK) ON ( CASE SUBSTRING(TP1.Path, 1, 4)
		WHEN '.003' THEN SUBSTRING(TP1.Path, 1, 8)
		ELSE SUBSTRING(TP1.Path, 1, 4)
		END = TP.Path )
WHERE
	TP1.IDTipoPessoa = @IDTipoPessoa

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

UPDATE
	TipoPessoa
SET
	LastCode = IsNull(LastCode, 0) + 1
FROM	(
	SELECT	CASE SUBSTRING(TP.Path, 1, 4)
		WHEN '.003' THEN SUBSTRING(TP.Path, 1, 8)
		ELSE SUBSTRING(TP.Path, 1, 4)
		END Path
	FROM
		Pessoa I (NOLOCK) JOIN TipoPessoa TP (NOLOCK) ON (I.IDTipoPessoa = TP.IDTipoPessoa)
	WHERE
		I.IDPessoa = @IDPessoa
	) A
WHERE
	A.Path = TipoPessoa.Path

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Pessoa_GetPessoaRoot', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_AddModelCredit
		(
		@IDPreInventMov	int,
		@IDCliente		int,
		@IDUser		int,
		@IDStore		int,
		@MovDate		smalldatetime
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Inserir no Customer Credit

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inserir no Customer Credit


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	01 Dec 2004		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @TotalCredit		Money
DECLARE @TotalCreditModel	Money
DECLARE @IDCustomerCredit	int

SET @ErrorLevel = 0


/*****************************************************************************************
	Inclusão dos Creditos para o modelo caso tenha
******************************************************************************************/
SELECT
	@TotalCredit = ((P.Qty * P.SalePrice)-P.Discount),
	@TotalCreditModel = (P.Qty * M.SellingPrice)
FROM
	PreInventoryMov P (NOLOCK) 
	JOIN Model M (NOLOCK) ON (M.IDModel = P.ModelID)
	JOIN TabGroup TB (NOLOCK) ON (TB.IDGroup = M.GroupID)
WHERE
	TB.Credit = 1
	AND
	P.IDPreInventoryMov = @IDPreInventMov
	AND
	P.InventMovTypeID = 1

/*****************************************************************************************
	Testar o valor do PackModel
******************************************************************************************/
SELECT
	@TotalCredit = (CASE WHEN IDParentPack Is Null THEN @TotalCredit ELSE @TotalCreditModel END)
FROM
	PreInventoryMov (NOLOCK) 
WHERE
	IDPreInventoryMov = @IDPreInventMov
	AND
	InventMovTypeID = 1

IF @TotalCredit > 0
BEGIN
	EXEC sp_Sis_GetNextCode 'CustomerCredit.IDCustomerCredit',  @IDCustomerCredit output

	INSERT CustomerCredit
	(
	IDCustomerCredit,
	IDPessoa,
	IDUser,
	IDStore,
	CreditDate,
	IsUsed,
	Amount,
	IDPreInventoryMov
	)
	VALUES
	(
	@IDCustomerCredit,
	@IDCliente,
	@IDUser,
	@IDStore,
	@MovDate,
	0,
	ABS(ISNULL(@TotalCredit, 0)),
	@IDPreInventMov
	)

END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddModelCredit', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_AddParcela
	(
	@IDStore		int,
	@IDUser			int,
	@IDCliente		int,
	@PreSaleID		int,
	@PreSaleDate		smalldatetime,
	@ExpirationDate		smalldatetime,
	@IDMeioPag		int,
	@Value			money,
	@Authorization		varchar(50),
	@IDCashRegMov		int,
	@Parcela		varchar(20),
	@IDBankCheck		int,
	@CheckNumber		varchar(20),
	@CustomerDocument	varchar(20),
	@CustomerName		varchar(80),
	@CustomerPhone		varchar(20),
	@OBS			varchar(255),
	@PaymentPlace		int,
	@IsPreDatado		bit
	) AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- Pega as constantes
		- Insere o lancamento
		- Update CashReg TotalSales
		- Incluir crédito para o Cliente

	TABELA DE ERROS PARA RETURN_VALUE
		 000 Ok
		-201 Erro em Pega as constantes
		-202 Erro em Insere o lancamento
		-203  Erro em Update CashReg TotalSales
		-204  Erro em Incluir crédito para o Cliente
		-205 Erro em Incluir em Sal_AccountCard

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------------- ----------------------- -----------------------------------------------------------------
	26 May	2000		Eduardo Costa		Suporte ao novo financeiro;
	27 Jun	2001		Davi Gouveia		Log de Return Values;
	28 Jul	2001		Rodrigo Costa		Atualizar o CashReg TotalSales;
	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDLancamento; 
							Criado @IDLancamento;
	15 Oct	2004		Carlos Lima		Incluídos novos campos no Fin_Lancamento;
	27 Sep	2004		Carlos Lima		Incluídos novo campo no no Fin_Lancamento (PaymentPlace);
	09 Nov	2004		Carlos Lima		Inclusão de Crédito;
	10 Nov	2004		Carlos Lima		Inclusão do campo IDLancamento quando inclui Crédito;
	07 Jan	2005		Carlos Lima		Inclusão do parâmetro IsPredatado;
	23 Mar	2006		Carlos Lima		Suporte ao Gift Card ( Chamada para a procedure que inclui em Sal_AccountCard );
	16 May	2006		Maximiliano Muniz	Calcula da data de vencimento do Lancamento, com base no MeioPag;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	02 May	2007		Maximiliano Muniz	Alteração na query que pega as constantes;
	16 Jul	2007		Maximiliano Muniz	Pegar o IDCentroCusto do tipo de lançamento;
	--------------------------------------------------------------------------------------------------------------- */

DECLARE @IDCentroCusto		int
DECLARE @IDCentroCustoSug	int
DECLARE @HasCentroCusto		bit
DECLARE @IDContaCorrente	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int
DECLARE @IDLancamento		int
DECLARE @Tipo			int
DECLARE @IDCustomerCredit	int
DECLARE @DueDate		smalldatetime
DECLARE @SysError		int

SET @ErrorLevel = 0

-- Pega as constantes
SELECT
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM
	Store S (NOLOCK) 
WHERE
	S.IDStore = @IDStore

SELECT
	@HasCentroCusto = SugereCentroCusto,
	@IDCentroCustoSug = IDCentroCusto
FROM
	Fin_LancamentoTipo LT (NOLOCK) 
WHERE
	LT.IDLancamentoTipo = 2

IF @HasCentroCusto = 1
BEGIN
	SET @IDCentroCusto = @IDCentroCustoSug
END

SELECT
	@IDContaCorrente = IsNull(MPTS.IDContaCorrente, MP.IDContaCorrente)
FROM
	MeioPag MP (NOLOCK) 
	LEFT JOIN MeioPag MPB (NOLOCK) ON (MPB.IDMeioPag = MP.IDMeioPagBatch)
	LEFT JOIN MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = @IDStore)
WHERE
	MP.IDMeioPag = @IDMeioPag

SELECT
	@Tipo = Tipo,
	@DueDate = DateAdd(Day, IsNull(PrazoRecebimento, 0), @ExpirationDate)
FROM
	MeioPag (NOLOCK) 
WHERE
	IDMeioPag = @IDMeioPag

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END
 
-- Insere o lancamento
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento (
		IDLancamento,
		IDLancamentoTipo,
		Pagando,
		Situacao,
		IDCentroCusto,
		IDContaCorrentePrevista,
		IDDocumentoTipo,
		NumDocumento,
		IDEmpresa,
		IDPreSale,
		IDPessoaTipo,
		IDPessoa,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal,
		IDQuitacaoMeioPrevisto,
		IDUsuarioLancamento,
		NumMeioQuitPrevisto,
		IDCashRegMov,
		NumDesdobramento,
		IDDesdobramentoTipo,
		IDBankCheck,
		CheckNumber,
		CustomerDocument,
		CustomerName,
		CustomerPhone,
		Historico,
		PaymentPlace,
		IsPreDatado)
VALUES (
		@IDLancamento,
		2, -- \\Receitas\Vendas
		0,
		1,
		@IDCentroCusto,
		@IDContaCorrente,
		1001, -- Sales Invoice
		Convert(varchar(50), @PreSaleID),
		@IDEmpresa,
		@PreSaleID,
		1, -- Sales Customer
		@IDCliente,
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar
		@PreSaleDate,
		@DueDate,
		@Value,
		@IDMeioPag,
		@IDUser, --Usuario do financeiro
		@Authorization,
		@IDCashRegMov,
		@Parcela,
		1001,
		@IDBankCheck,
		@CheckNumber,
		@CustomerDocument,
		@CustomerName,
		@CustomerPhone,
		@OBS,
		@PaymentPlace,
		@IsPreDatado)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*                     Update Cash RegisterMovent                             */
/*--------------------------------------------------------------------------------------------------------*/
UPDATE
            CashRegMov
SET
            CashRegMov.TotalSales = IsNull(dbo.CashRegMov.TotalSales, 0) + ROUND(IsNull(@Value,0),2)
WHERE
            CashRegMov.IDCashRegMov = @IDCashRegMov 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END

/*----------------------------------------------------------------*/
/*		Customer Credit		*/
/*----------------------------------------------------------------*/
IF (@Tipo = 5)  AND (@Value < 0)
BEGIN
	EXEC sp_PreSale_AddCustomerCredit @IDCliente, @IDUser, @IDStore, @PreSaleDate, NULL, @Value, @IDLancamento, @IDCustomerCredit OUTPUT

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -204
	            GOTO ERRO
	END
END

/*----------------------------------------------------------------*/
/*		Gift Card		*/
/*----------------------------------------------------------------*/
IF (@Tipo = 6)
BEGIN

	EXEC sp_Sal_AccountCard_AddAmount @CustomerDocument, @Value, @PreSaleID, @IDLancamento, @IDUser, 0, ''

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -205
	            GOTO ERRO
	END
END

OK:
            RETURN 0
ERRO:
            PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	

	SET @Params = ' [ @IDStore = ' + CAST(@IDStore AS VARCHAR) + 
			' @IDUser = ' + CAST(@IDUser AS VARCHAR) +  
			' @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + 
			' @PreSaleID = '  + CAST(@PreSaleID AS VARCHAR) + 
			' @IDMeioPag = '  + CAST(@IDMeioPag AS VARCHAR) + 
			' @IDCashRegMov = '  + CAST(@IDCashRegMov AS VARCHAR) +
			' @IDBankCheck = '  + CAST(@IDBankCheck AS VARCHAR) + 
			' @Value = '  + CAST(@Value AS VARCHAR) +  ' ] '

	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddParcela', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_ApplyCustomerDiscount
		(
		@IDPreSale		int,
		@IDCustomer		int,
		@Date			DateTime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Altera desconto baseado no tipo de cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro na atualização dos itens
		-202  Erro no Cursor
		-203  Erro em exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	------------------------------------------------------------------------------- -----------------------------------------------------------------------------------------------------------
	17 Feb 2006		Maximiliano Muniz	Criacao;
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDPreInventoryMov	int
DECLARE @IDModel		int
DECLARE @Qty			float
DECLARE @SalePrice		money
DECLARE @Discount		money
DECLARE @ErrorLevel		int 
DECLARE @SysError		int

SET @ErrorLevel = 0

BEGIN TRAN

/*--------------------------------------*/
/*	Calcula desconto do cliente	*/
/*--------------------------------------*/

--Declaração do Cursor de PreInventoryMov
DECLARE ApplyDiscount_Cursor CURSOR FOR

	SELECT
		IDPreInventoryMov,
		ModelID,
	 	Qty,
		SalePrice,
		Discount
	FROM
		PreInventoryMov (NOLOCK) 
	WHERE
		DocumentID = @IDPreSale
		AND
		InventMovTypeID = 1

OPEN ApplyDiscount_Cursor

--Inicialização de ApplyDiscount_Cursor
FETCH NEXT FROM ApplyDiscount_Cursor INTO
	@IDPreInventoryMov,
	@IDModel,
	@Qty,
	@SalePrice,
	@Discount

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	SELECT
		@Discount = (@SalePrice * (CD.Discount / 100)) * @Qty
	FROM
		Ent_CustomerDiscount CD (NOLOCK) 
		JOIN Model M (NOLOCK) ON (CD.IDGroup = M.GroupID)
		JOIN Pessoa P (NOLOCK) ON (CD.IDTipoPessoa = P.IDTipoPessoa)
	WHERE
		M.IDModel = @IDModel
		AND
		P.IDPessoa = @IDCustomer

	UPDATE
		PreInventoryMov
	SET
		Discount = @Discount
	WHERE
		IDPreInventoryMov = @IDPreInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE ApplyDiscount_Cursor
		DEALLOCATE CalcABC_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM ApplyDiscount_Cursor INTO
		@IDPreInventoryMov,
		@IDModel,
		@Qty,
		@SalePrice,
		@Discount
END

--fechamento do cursor
CLOSE ApplyDiscount_Cursor

--Destruição do cursor
DEALLOCATE ApplyDiscount_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @IDPreSale, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ApplyCustomerDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_ApplyCustomerItemDiscount
		(
		@IDPreSale		int,
		@IDCustomer		int,
		@IDPreInventoryMov	int,
		@Date			DateTime
		)
AS

/* ---------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere desconto em apenas um item espcifico, baseado no tipo de cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro ao selecionar um item.
		-202  Erro ao atualizar o item.
		-203  Erro em exec sp_PreSale_SubCalcTotal @PreSaleID, @Date.

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	------------------------------------------------------------------------------- -----------------------------------------------------------------------------------------------------------
	05 Jan 2007		Maic Nogueira		Criação;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @Discount		money
DECLARE @OldDiscount		money
DECLARE @ErrorLevel		int 
DECLARE @SysError		int

SET @ErrorLevel = 0

/*--------------------------------------------------------------------------------------*/
/*				Calcula desconto do cliente				*/
/*--------------------------------------------------------------------------------------*/

	SELECT
		@Discount = (PIM.SalePrice * (CD.Discount / 100)) * PIM.Qty,
		@OldDiscount = PIM.Discount
	FROM
		Ent_CustomerDiscount CD (NOLOCK) 
		JOIN Model M (NOLOCK) ON (CD.IDGroup = M.GroupID)
		JOIN PreInventoryMov PIM (NOLOCK) ON (M.IDModel = PIM.ModelID)
		JOIN Pessoa P (NOLOCK) ON (CD.IDTipoPessoa = P.IDTipoPessoa)
	WHERE
		P.IDPessoa = @IDCustomer
		AND
		PIM.IDPreInventoryMov = @IDPreInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	IF (@Discount > 0) AND (@Discount > @OldDiscount)
	BEGIN	
		UPDATE
			PreInventoryMov
		SET
			Discount = @Discount
		WHERE
			IDPreInventoryMov = @IDPreInventoryMov
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	
		exec sp_PreSale_SubCalcTotal @IDPreSale, @Date
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -203
			GOTO ERRO
		END
	END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ApplyCustomerItemDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_ApplySpecialPrice
		(
		@PreSaleID 		int,
		@SpecialPriceID 	int,
		@Date 			datetime,
		@ExemptTax		bit
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Altera baseado no Special Price do Grupo
		- Altera baseado no Special Price do Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Altera baseado no Special Price do Grupo
		-202  Erro em Atualizo PreInventoryMov
		-203  Erro em Atualizo Invoice
		-204  Erro em exec sp_PreSale_SubCalcTotal @PreSaleID, @Date


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	25 May 2004		RodrigoCosta		Special price not for PackModel
	18 Aug 2004		Rodrigo Costa		Gravar error log
	10 Mar 2004		Rodrigo Costa		Novo parametro TaxExempt		
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/* ----------------------------------------------- */
/*	Altera baseado no Special Price do Grupo   */
/* ----------------------------------------------- */
UPDATE
	PreInventoryMov
SET
	PreInventoryMov.Discount = 0,
	PreInventoryMov.SalePrice = 	ROUND(
						IsNull (
							(
							SELECT
								( (1+(IsNull( SP.SpecialMarkUp,0)/100)) * PreInventoryMov.CostPrice )
							FROM
								Model MO (NOLOCK),
								SpecialPriceByGroup SP (NOLOCK)
							WHERE
								PreInventoryMov.ModelID = MO.IDModel
								AND
								MO.GroupID = SP.GroupID
								AND
								SP.SpecialPriceID = @SpecialPriceID
							), Model.SellingPrice)
						,2)
FROM
	Model Model (NOLOCK)
WHERE
	(PreInventoryMov.DocumentID = @PreSaleID
	AND
	PreInventoryMov.IDParentPack IS Null
	AND
	(PreInventoryMov.ModelID = Model.IDModel)
	AND
	PreInventoryMov.InventMovTypeID = 1)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/* ----------------------------------------------- */
/*	Altera baseado no Special Price do Model   */
/* ----------------------------------------------- */
-- Atualizo PreInventoryMov
UPDATE
	PreInventoryMov
SET
	PreInventoryMov.SalePrice = ROUND(IsNull (( (1+(IsNull( MoToSP.MarkUp,0)/100)) * dbo.PreInventoryMov.CostPrice ), Model.SellingPrice),2)
FROM
	ModelToSpecialPrice MoToSP (NOLOCK),
	model Model (NOLOCK)
WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND
	PreInventoryMov.InventMovTypeID = 1
	AND
       	PreInventoryMov.ModelID = MoToSP.IDModel
	AND
      	MoToSp.IDModel = Model.IDModel
	AND
       	MoToSP.IDSpecialPrice = @SpecialPriceID
	AND
	PreInventoryMov.IDParentPack IS Null


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


-- Atualizo Invoice
UPDATE
	Invoice
SET
	Invoice.SpecialPriceID = @SpecialPriceID,
	Invoice.TaxIsent = @ExemptTax
WHERE
	Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ApplySpecialPrice', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_AtuOpenUser
		( 
		@PreSaleID 	int,
		@IsOpen  	bit,
		@IsCash  	bit,
		@nOpenUser 	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE

		-1, 1, @Ret   Ok
		-201              Erro em UPDATE dbo.Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @Ret   		int 
DECLARE @NewOpenUser 	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0

SELECT @nOpenUser = (SELECT IsNull(nOpenUser, 0) FROM
		     dbo.Invoice (NOLOCK) 
		     WHERE dbo.Invoice.IDPreSale = @PreSaleID) 

SELECT @nOpenUser = IsNull(@nOpenUser, -1)

IF @IsOpen = 1
  begin
    IF @nOpenUser < 0
      begin
       return -1
      end

    if @IsCash = 1
      begin
        if @nOpenUser = 0 
          begin
           SELECT @Ret = 0
           if @IsCash = 1
	      SELECT @NewOpenUser = -1
          end
	else
          begin
           return 1
	  end
      end
    else
      begin
        if @nOpenUser = 0 
           SELECT @Ret = 0
	else
           SELECT @Ret = 1

 	SELECT @NewOpenUser = @nOpenUser + 1
      end
  end
ELSE
  begin
    IF @IsCash = 1
      begin
	if @nOpenUser < 0
           SELECT @NewOpenUser = 0
        else
          begin
            return 1
          end
      end
    else
      begin
	if @nOpenUser > 0
          begin
            SELECT @Ret = 0
            SELECT @NewOpenUser = @nOpenUser - 1
          end
      end
  end
 
BEGIN TRAN

UPDATE dbo.Invoice SET nOpenUser = @NewOpenUser WHERE dbo.Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN @Ret
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AtuOpenUser', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_CalcCustomerDiscount
		(
		@IDCustomer		int,
		@IDModel		int,
		@Qty			float,
		@SalePrice		money,
		@Discount		money out
		)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	SUMARIO

		- Calcula o desconto por tipo de cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000	Ok
		-201	Erro no cálculo do desconto por tipo de cliente

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------------- ----------------------- ---------------------------------------------------------------------------------------------------------------------------------------------
	21 Feb 2006		Maximiliano		Criacao;
	16 Jun	2006		Rodrigo Costa		Retirado o Retorno Result = 0, pois estava gravando na tabela de historico
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0

/*--------------------------------------*/
/*	Calcula desconto do cliente	*/
/*--------------------------------------*/

IF @Discount = 0
BEGIN
	SELECT
		@Discount = (@SalePrice * (CD.Discount / 100)) * @Qty
	FROM
		Ent_CustomerDiscount CD (NOLOCK) 
		JOIN Model M (NOLOCK) ON (CD.IDGroup = M.GroupID)
		JOIN Pessoa P (NOLOCK) ON (CD.IDTipoPessoa = P.IDTipoPessoa)
	WHERE
		M.IDModel = @IDModel
		AND
		P.IDPessoa = @IDCustomer
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CalcCustomerDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_CalcFullTotal
		(
		@IDPreSale 	int,
		@FullTotal 	money output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna o total de uma determinada venda

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 May  2004		Rodrigo Costa		Includ PackModel Calc
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT	@FullTotal = 	(
			SELECT
				SUM(PreInventoryMov.Qty * Model.SellingPrice)
			FROM
				dbo.PreInventoryMov PreInventoryMov (NOLOCK) 
				JOIN dbo.Model Model (NOLOCK) ON (PreInventoryMov.ModelID = Model.IDModel)
			WHERE
 				PreInventoryMov.DocumentID  = @IDPreSale
 				AND
 				PreInventoryMov.InventMovTypeID = 1
				AND
				PreInventoryMov.IDParentPack IS Null
			)

SELECT @FullTotal = IsNull(@FullTotal, 0)
GO

CREATE PROCEDURE sp_PreSale_CalcSalePrice

		(
		@ModelID		int,
		@IDStore		int,
		@IDCustomer		int,
		@SpecialPriceID		int,
		@SalePrice		money Output,
		@CostPrice		money Output,
		@Discount		money Output,
		@AvgCostPrice		money Output,
		@ReplacementCost	money Output,
		@StoreSalePrice		money Output,
		@RequestCustomer	bit Output,
		@PuppyTracker		bit Output,
		@StoreCostPrice		money OutPut,
		@StoreAvgCost		money OutPut,
		@AddKitItems		bit OutPut
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calculo do valor no modelo e seu custo
		- Calculo o valor do grupo e do modelo
		- Calculo o desconto pelo tipo de cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select
		-203  Erro ao Executar sp_PreSale_CalcCustomerDiscount

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	16 Mar	2005		RodrigoCosta 		Inclusao do campo ReplacementCost
	28 Jul	2005		Rodrigo Costa		Inclusao do campo StoreSellingPrice
	30 Oct	2005		Rodrigo	Costa		Inclusao dos campos StoreCost and Store Avg
	21 Feb	2006		Maximiliano Muniz	Chamada da sp_PreSale_CalcCustomerDiscount
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @Model	money
DECLARE @ModelSP 	money
DECLARE @GroupSP 	money

SET @Model = Null
SET @ModelSP = Null
SET @GroupSP = Null
SET @ErrorLevel = 0

---------------------------------------------------------------------------------------------------
-- Calculo do valor no modelo e seu custo

SELECT
	@CostPrice = (IsNull(M.VendorCost,0) + IsNull(M.OtherCost,0) + IsNull(M.FreightCost, 0)),
	@Model = CASE WHEN IsNull(I.SellingPrice, 0) = 0 THEN IsNull(M.SellingPrice, 0) ELSE I.SellingPrice END,
	@AvgCostPrice = IsNull(M.AvgCost,0),
	@ReplacementCost = IsNull(ReplacementCost,0),
	@StoreSalePrice = IsNull(I.SellingPrice,0),
	@StoreCostPrice = IsNull(I.StoreCostPrice,0),
	@StoreAvgCost = IsNull(I.StoreAvgPrice,0),
	@AddKitItems = IsNull(TG.PackModelAddItems,0)
FROM
	Model M (NOLOCK) 
	JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
	LEFT OUTER JOIN Inventory I (NOLOCK) ON (I.ModelID = M.IDModel AND I.StoreID = @IDStore)
WHERE
	M.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

---------------------------------------------------------------------------------------------------
-- Calculo o valor do grupo e do modelo

IF IsNull(@SpecialPriceID,0) > 0
BEGIN
	SELECT
		@GroupSP = (1+(SP.SpecialMarkUp/100) ) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO (NOLOCK) 
		JOIN SpecialPriceByGroup SP (NOLOCK)  ON (MO.GroupID = SP.GroupID)
	WHERE
		MO.IDModel = @ModelID
		AND
		SP.SpecialPriceID = @SpecialPriceID


	SELECT
		@ModelSP = (1+(MTSP.MarkUp/100)) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO (NOLOCK) 
		JOIN ModelToSpecialPrice MTSP (NOLOCK) ON (MO.IDModel = MTSP.IDModel)
	WHERE
		MO.IDModel = @ModelID
		AND
		MTSP.IDSpecialPrice = @SpecialPriceID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END

END

SET @SalePrice = IsNull(@ModelSP, IsNull(@GroupSP, @Model))

---------------------------------------------------------------------------------------------------
-- Calculo o desconto pelo tipo de Cliente

EXEC sp_PreSale_CalcCustomerDiscount @IDCustomer, @ModelID, 1, @SalePrice, @Discount OUTPUT


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CalcSalePrice', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_CancelHold
                                   (
                                   	@IDPreSale int,
					@IDUser int
                                   )
AS
/* ---------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO
 

                        - Update Cash RegisterMovent
                        - Desquita o lancamento
                        - Deleta o lancamento


            TABELA DE ERROS PARA RETURN_VALUE

                         000  Ok
                        -201  Erro em Inser no PreInventoryMov (Cancelamento)
                        -202  Erro em Delete no PreInventoryMov
                        -203  Erro em Delete nos registros de Lançamento e Quitação
                        -204  Erro em Update no Invoice


            LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
        -----------------------	-----------------------	----------------------------------------------------------------------------------
	15 Oct 2004		Carlos Lima		Criação
	27 Jan 2005		Rodrigo Costa		Inclusao do @IDUser para deletar os lancamentos
	01 Fev 2005		Rodrigo Costa		Criacao do Cursor para delecao do PreInvMov
	30 Mar 2005		Rodrigo Costa		Chamada na sp para deletar os lancamentos
	04 Jan 2007		Maximiliano MUniz	Retirada a transação
        ---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDLancamento	int

-- Variaveis para o cursor PreInv_Cursor
DECLARE  @IDPreInventoryMov		int
DECLARE  @StoreID			int
DECLARE  @ModelID			int
DECLARE  @IDPessoa			int
DECLARE  @UserID			int
DECLARE  @IDCotacao			int
DECLARE  @IDPreInventoryMovParent	int
DECLARE  @BarCodeID			TBarCode
DECLARE  @DocumentID			int
DECLARE  @MovDate			smalldatetime
DECLARE  @Qty				float
DECLARE  @CostPrice			money
DECLARE  @SalePrice			money
DECLARE  @Discount			money
DECLARE  @DateEstimatedMov		smalldatetime
DECLARE  @DateRealMov			smalldatetime
DECLARE  @QtyRealMov			float
DECLARE  @Marked			bit
DECLARE  @ExchangeInvoice		int
DECLARE  @SuggRetail			money
DECLARE  @IDParentPack			int
DECLARE  @IDModelService		int
DECLARE  @IDPreInvMovOld		int


SET @ErrorLevel = 0

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Insere movimentaçao de cancelamento com base na movimentação anterior                    */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
--Declaração do Cursor de PreInv_Cursor
DECLARE PreInv_Cursor CURSOR FOR 
            SELECT                       
                        StoreID,
                        ModelID,
                        IDPessoa,
                        UserID,
                        IDCotacao,
                        IDPreInventoryMovParent,
                        BarCodeID,
                        DocumentID,
                        MovDate,
                        Qty,
                        CostPrice,
                        SalePrice,
                        Discount,
                        DateEstimatedMov,
                        DateRealMov,
                        QtyRealMov,
                        Marked,
                        ExchangeInvoice,
                        SuggRetail,
                        IDParentPack,
                        IDModelService
            FROM
                        PreInventoryMov (NOLOCK) 
            WHERE
                        DocumentID = @IDPreSale
      AND 
			InventMovTypeID = 1

OPEN PreInv_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM PreInv_Cursor INTO
            @StoreID,
            @ModelID,
            @IDPessoa,
            @UserID,
            @IDCotacao,
            @IDPreInventoryMovParent,
            @BarCodeID,
            @DocumentID,
            @MovDate,
            @Qty,
            @CostPrice,
            @SalePrice,
            @Discount,
            @DateEstimatedMov,
            @DateRealMov,
            @QtyRealMov,
            @Marked,
            @ExchangeInvoice,
            @SuggRetail,
            @IDParentPack,
            @IDModelService

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
            EXEC sp_Sis_GetNextCode 'Preinventorymov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

            INSERT PreInventoryMov
                        (
                        IDPreInventoryMov,
                        InventMovTypeID,
                        StoreID,
                        ModelID,
                        IDPessoa,
                        UserID,
                        IDCotacao,
                        IDPreInventoryMovParent,
                        BarCodeID,
                        DocumentID,
                        MovDate,
                        Qty,
                        CostPrice,
                        SalePrice,
                        Discount,
                        DateEstimatedMov,
                        DateRealMov,
                        QtyRealMov,
                        Marked,
                        ExchangeInvoice,
                        SuggRetail,
                        IDParentPack,
                        IDModelService
                        )
                        VALUES
                        (
                        @IDPreInventoryMov,
                        25,
                        @StoreID,
                        @ModelID,
                        @IDPessoa,
                        @UserID,
                        @IDCotacao,
                        @IDPreInventoryMovParent,
                        @BarCodeID,
                        @DocumentID,
                        @MovDate,
                        @Qty,
                        @CostPrice,
                        @SalePrice,
                        @Discount,
                        @DateEstimatedMov,
                        @DateRealMov,
                        @QtyRealMov,
                        @Marked,
                        @ExchangeInvoice,
                        @SuggRetail,
                        @IDParentPack,
                        @IDModelService
                        )

            FETCH NEXT FROM PreInv_Cursor INTO
                        @StoreID,
                        @ModelID,
                        @IDPessoa,
                        @UserID,
                        @IDCotacao,
                        @IDPreInventoryMovParent,
                        @BarCodeID,
                        @DocumentID,
                        @MovDate,
                        @Qty,
                        @CostPrice,
                        @SalePrice,
                        @Discount,
                        @DateEstimatedMov,
                        @DateRealMov,
                        @QtyRealMov,
                        @Marked,
                        @ExchangeInvoice,
                        @SuggRetail,
                        @IDParentPack,
                        @IDModelService
END

--fechamento do cursor
CLOSE PreInv_Cursor
--Destruição do cursor
DEALLOCATE PreInv_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deletar movimentaçao de cancelamento com base na movimentação anterior                    */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
--Declaração do Cursor de PreInvDel_Cursor
DECLARE PreInvDel_Cursor CURSOR STATIC FOR 
	SELECT
		IDPreInventoryMov
	FROM
		PreInventoryMov (NOLOCK) 
	WHERE
		DocumentID = @IDPreSale
		AND 
		InventMovTypeID = 1

OPEN PreInvDel_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM PreInvDel_Cursor INTO
            @IDPreInvMovOld

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	--Deletar os items
	EXEC sp_PreSale_SubRemoveItem @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -202
	            GOTO ERRO
	END

            FETCH NEXT FROM PreInvDel_Cursor INTO
                        @IDPreInvMovOld
END

--fechamento do cursor
CLOSE PreInvDel_Cursor
--Destruição do cursor
DEALLOCATE PreInvDel_Cursor

/*
DELETE FROM
            PreInventoryMov
WHERE
            DocumentID = @IDPreSale
            AND InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END
*/

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deleta todos os lançamentos e Quitações                                                                                */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

EXEC sp_PreSale_DeletePayments @IDPreSale, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END

 
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Atualiza Status de Cancelado no invoice                                                                       */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

UPDATE 
            Invoice
SET
            Canceled = 1
WHERE
            IDPreSale = @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -204
            GOTO ERRO
END

OK:
            RETURN 0
ERRO:
            RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_CancelInvoice
	(
	@IDPreSale int,
	@IDUser int
	)
AS
/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Transforma Invoice em Hold (Quando necessario)
		- Cancela o Hold

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Transforma Invoice em Hold
		-202  Erro em Cancela o Hold

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	24 Mar  2005		Carlos Lima		Criacao;
	04 Jan	2007		Maximiliano Muniz	Retirada a transação
							Alterado o "IF" antes da sp_PreSale_UnPay. Testa agora com "IS" e não com "<>";
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

DECLARE @IDInvoice	int

SELECT
	@IDInvoice = IDInvoice
FROM
	Invoice (NOLOCK) 
WHERE
	IDPreSale = @IDPreSale

/* Transforma Invoice em Hold */

IF @IDInvoice IS NOT NULL
	EXEC sp_PreSale_Unpay @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END

EXEC sp_PreSale_CancelHold @IDPreSale, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

OK:
            RETURN 0
ERRO:
            RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_DelOldHold AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreInventoryMov
		- Deleto Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto PreInventoryMov
		-202  Erro em Deleto Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

-- Deleto PreInventoryMov
DELETE	
	PreInventoryMov
FROM	
	Invoice (NOLOCK) 
WHERE	
	PreInventoryMov.DocumentID = Invoice.IDPreSale		
	AND
	PreInventoryMov.InventMovTypeID = 1			
	AND
	Invoice.IDInvoice IS NULL				
	AND
	Invoice.PreSaleDate < dateadd(dd, -7, GetDate())	
	AND
	(
	Invoice.EstimatedPay IS NULL 				
	OR
	Invoice.EstimatedPay < dateadd(dd, 1, GetDate())
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Deleto Invoice
DELETE	
	Invoice
WHERE	
	Invoice.IDInvoice IS NULL				
	AND
	Invoice.PreSaleDate < dateadd(dd, -7, GetDate())	
	AND
	(
	Invoice.EstimatedPay IS NULL 				
	OR
	Invoice.EstimatedPay < dateadd(dd, 1, GetDate())
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelOldHold', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_DeleteDelayPayment
			(
			@PreSaleID	int,
			@IDUser	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleta os lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deletar o simgle payment


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	22 Set  2004		Rodrigo Costa		Criação
	12 Nov 2004		Carlos Lima		Suporte a Crédito do Cliente
	07 Jan 2005		Carlos Lima		Alteração para que somente os campos marcados com
							IsPreDatado = 1 sejam filtrados
	30 Mar	2005		Rodrigo Costa		Nova chamada para DelSinglePayment
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

DECLARE @ErrorLevel		int
DECLARE @SysError		int


-- Variáveis para o cursor Cursor_Lanc
DECLARE @IDLancamento		int

SET @ErrorLevel = 0

DECLARE Cursor_Lanc CURSOR FOR
	SELECT
		L.IDLancamento
	FROM
		Fin_Lancamento L (NOLOCK) 
		JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
				   AND (MP.Tipo IN (2,4)) AND L.IsPreDatado = 1)
	WHERE
		L.IDPreSale = @PreSaleID
		

OPEN Cursor_Lanc

FETCH NEXT FROM Cursor_Lanc INTO
	@IDLancamento

WHILE @@FETCH_STATUS = 0
BEGIN
	/*----------------------------------------------------------------*/
	/*	Deleta os Lancamentos	*/
	/*---------------------------------------------------------------*/
	EXEC sp_PreSale_DeleteSingleDelayPayment @IDLancamento, @IDUser

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Cursor_Lanc
		DEALLOCATE Cursor_Lanc
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM Cursor_Lanc INTO
		@IDLancamento
END

CLOSE Cursor_Lanc
DEALLOCATE Cursor_Lanc

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelLancamento', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_DivideHold
	(
	@IDPreSale   int,
	@DeliverTypeID  int,
	@DeliverDate  dateTime,
	@DeliverAddress varchar(100),
	@DeliverOBS  varchar(255),
	@NewIDPreSale  int  output
	)
AS
 
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 SUMARIO
	 
	  - Cria um novo cabeçalho para o PreSale
	  - Inclui as quantidades dos items marcados para o novo PreSale
	  - Atualiza as quantiades do Antigo PreSale
	  - Remove os items marcados do Antigo PreSale
	  - Recalcula o total do novo PreSale
	  - Recalcula o total do antigo PreSale
	 
	 TABELA DE ERROS PARA RETURN_VALUE
	 
	   000  Ok
	  -201  Erro em Cria um novo cabeçalho para o PreSale
	  -202  Erro em Inclui as quantidades dos items marcados para o novo PreSale
	  -203  Erro em Atualiza as quantiades do Antigo PreSale
	  -204  Erro em Remove os items marcados do Antigo PreSale
	  -205  Erro em exec sp_PreSale_SubCalcTotal
	  -206  Erro em Recalcula o total do antigo PreSale
	  -207  Erro em atualizar a comissao
	 
	
	 LOG DE MODIFICAÇÕES
	 
	Data			Programador			Modificação
	-------------------------------------	--------------------------------------- 	-----------------------------------------------------------------------------------------------------
	22 Oct 	2004  		Carlos Lima  			Criação;
	29 Oct 	2004  		Rodrigo Costa  			Correcao;  Nao pode colocar a data do invoice, ainda nao e um invoice
	20 Jan	2005		Rodrigo Costa			Correcao; Removido o Discount + SalePrice do insert
	03 Fev  2005		Rodrigo Costa			Atualizao das garantias quando marcar entrega
	05 May	2005		Rodrigo Costa			Novo campo de desired markup
	12 May	2005		Rodrigo Costa			Removido o IDPreSale do Update IDPreInvParent para atualizar os desdobramentos
	01 Dec	2005		Leonardo Riego 			Removido campo de ComissionID da PreInventoryMov e atualizacao da SaleItemCommission com o novo IDPreInventoryMov
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @ErrorLevel			int
DECLARE @SysError			int
 

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @IDPreInventoryMov		int
DECLARE @IDPreInvMovOld		int
DECLARE @InventMovTypeID		int
DECLARE @StoreID    			int
DECLARE @ModelID    			int
DECLARE @IDPessoa     		int
DECLARE @UserID     			int
DECLARE @IDCotacao    		int
DECLARE @IDPreInventoryMovParent  	int
DECLARE @BarCodeID    		TBarCode
DECLARE @DocumentID    		int
DECLARE @MovDate    		smalldatetime
DECLARE @Qty    			float
DECLARE @CostPrice    		money
DECLARE @SalePrice    		money
DECLARE @Discount     		money
DECLARE @DateEstimatedMov   	smalldatetime
DECLARE @DateRealMov   		smalldatetime
DECLARE @QtyRealMov    		float
DECLARE @Marked     			bit
DECLARE @ExchangeInvoice   		int
DECLARE @SuggRetail    		money
DECLARE @IDParentPack    		int
DECLARE @IDModelService    		int
DECLARE @DesiredMarkup		money
 
DECLARE @Date    			DateTime
DECLARE @SaleCode 			varchar(20)
DECLARE @IDStore 			int
 
SET @ErrorLevel = 0
 
BEGIN TRAN
 
/*------------------------------------------------------------------------------------------------------*/
/*      Cria um novo cabeçalho para o PreSale   */
/*-----------------------------------------------------------------------------------------------------*/ 
EXEC sp_Sis_GetNextCode'Invoice.IDPreSale', @NewIDPreSale OUTPUT

SELECT	
	@IDStore = IDStore
FROM
	Invoice (NOLOCK) 
WHERE
	IDPreSale = @IDPreSale

EXEC SP_PreSale_GetNewSaleCode @IDPreSale, @IDStore, @SaleCode output
 
INSERT Invoice 
	(
	IDPreSale,
	CashRegMovID,
	SpecialPriceID,
	IDMeioPag,
	IDTouristGroup,
	DeliverTypeID,
	MediaID,
	IDCustomer,
	IDStore,
	IDInvoice,
	OtherComissionID,
	IDLancPagOtherCom,	PreSaleDate,
	--InvoiceDate,  -Nao pode colocar a data do invoice, ainda nao e um invoice
	DeliverDate,
	DeliverAddress,
	Passport,
	PassportDate,
	Ticket,
	AirLine,
	CompanyName,
	CompanyCGC,
	DepositDate,
	Tax,
	SubTotal,
	Note,
	ItemDiscount,
	TaxIsent,
	--nOpenUser,
	--RefreshInvoice,
	Printed,
	CashReceived,
	EstimatedPay,
	CardNumber,
	OtherExpences,
	Address,
	TaxIsemptValue,
	TaxIsemptItemDiscount,
	Layaway,
	FirstName,
	LastName,
	ZIP,
	--nOpenHoldCaixa,
	PrintNotes,
	DeliverOBS,
	DeliverConfirmation,
	IDFormOfPayment,
	AditionalExpenses,
	Canceled,
	IDPreSaleParent,
	SaleCode
	)
	SELECT
		@NewIDPreSale,
		CashRegMovID,
		SpecialPriceID,
		IDMeioPag,
		IDTouristGroup,
		@DeliverTypeID,
		MediaID,
		IDCustomer,
		IDStore,
		IDInvoice,
		OtherComissionID,
		IDLancPagOtherCom,
		PreSaleDate,
		--GetDate(), -Nao pode colocar a data do invoice, ainda nao e um invoice
		@DeliverDate,
		@DeliverAddress,
		Passport,
		PassportDate,
		Ticket,
		AirLine,
		CompanyName,
		CompanyCGC,
		DepositDate,
		Tax,
		SubTotal,
		Note,
		ItemDiscount,
		TaxIsent,
		--nOpenUser,
		--RefreshInvoice,
		Printed,
		CashReceived,
		EstimatedPay,
		CardNumber,
		OtherExpences,
		Address,
		TaxIsemptValue,
		TaxIsemptItemDiscount,
		Layaway,
		FirstName,
		LastName,
		ZIP,
		--nOpenHoldCaixa,
		PrintNotes,
		@DeliverOBS,
		1,--O PreSale deve ser  criado com a entrega já confirmada, pois sua criação parte de uma confirmação de entrega
		IDFormOfPayment,
		AditionalExpenses,
		Canceled,
		@IDPreSale,
		@SaleCode
 
	FROM
		Invoice (NOLOCK) 
	WHERE
		Invoice.IDPreSale = @IDPreSale
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END
 

/*---------------------------------------------------------------------------------------------------*/
/*           Inclui os items marcados para o novo PreSale              */
/*---------------------------------------------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMov_Cursor CURSOR FOR
 
SELECT
	InventMovTypeID,
	StoreID,
	ModelID,
	IDPessoa,
	UserID,
	IDCotacao,
	IDPreInventoryMovParent,
	BarCodeID,
	@NewIDPreSale,
	MovDate,
	Qty,
	CostPrice,
	SalePrice,
	Discount,
	DateEstimatedMov,
	DateRealMov,
	QtyRealMov,
	Marked,
	ExchangeInvoice,
	SuggRetail,
	IDParentPack,
	IDModelService,
 	IDPreInventoryMov,
	DesiredMarkup
FROM
	dbo.PreInventoryMov (NOLOCK) 
WHERE
	DocumentID = @IDPreSale
   	AND
   	Marked = 1
	AND
   	InventMovTypeID = 1
 

OPEN PreInventoryMov_Cursor
 
--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@InventMovTypeID,
	@StoreID,
	@ModelID,
	@IDPessoa,
	@UserID,
	@IDCotacao,
	@IDPreInventoryMovParent,
	@BarCodeID,
	@DocumentID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@Discount,
	@DateEstimatedMov,
	@DateRealMov,
	@QtyRealMov,
	@Marked,
	@ExchangeInvoice,
	@SuggRetail,
	@IDParentPack,
	@IDModelService,
	@IDPreInvMovOld,
	@DesiredMarkup
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT
 
	--Inclui as quantidades dos items marcados para o novo PreSale
	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		StoreID,
		ModelID,
		IDPessoa,
		UserID,
		IDCotacao,
		IDPreInventoryMovParent,
		BarCodeID,
		DocumentID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		DateEstimatedMov,
		DateRealMov,
		QtyRealMov,
		Marked,
		ExchangeInvoice,
		SuggRetail,
		IDParentPack,
		IDModelService,
		DesiredMarkup
		)
	VALUES
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@UserID,
		@IDCotacao,
		@IDPreInventoryMovParent,
		@BarCodeID,
		@DocumentID,
		@MovDate,
		@QtyRealMov,
		@CostPrice,
		@SalePrice,
		((@Discount / @Qty) * @QtyRealMov), --Desconto tem que ser dividido nos invoices
		@DateEstimatedMov,
		@DateRealMov,
		0,
		0,
		@ExchangeInvoice,
		@SuggRetail,
		@IDParentPack,
		@IDModelService,
		@DesiredMarkup
		)
 
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END


	--Atualizar os SaleItemCommisison
	UPDATE
		SaleItemCommission
	SET
		IDPreInventoryMov = @IDPreInventoryMov
	WHERE
		IDPreInventoryMov = @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -207
		GOTO ERRO
	END


	--Atualizar os IDPreInvParent
	UPDATE
		PreInventoryMov
	SET
		IDPreInventoryMovParent = @IDPreInventoryMov
	WHERE
		--DocumentID = @IDPreSale
   		--AND
   		InventMovTypeID = 1
		AND
		IDPreInventoryMovParent = @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

 
	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@InventMovTypeID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@UserID,
		@IDCotacao,
		@IDPreInventoryMovParent,
		@BarCodeID,
		@DocumentID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@DateEstimatedMov,
		@DateRealMov,
		@QtyRealMov,
		@Marked,
		@ExchangeInvoice,
		@SuggRetail,
		@IDParentPack,
		@IDModelService,
		@IDPreInvMovOld,
		@DesiredMarkup
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor
 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END
 
/*---------------------------------------------------------------------------------------------------------*/
/*           Atualiza as quantiades do Antigo PreSale  e o Desconto      */
/*---------------------------------------------------------------------------------------------------------*/
UPDATE PreInventoryMov
SET	Qty = Qty - QtyRealMov,
	Discount = Discount - ((Discount / Qty) * QtyRealMov), --Desconto tem que ser dividido nos invoices
 	Marked = 0,
	QtyRealMov = 0
WHERE
	DocumentID = @IDPreSale
	AND
	Marked = 1
	AND
	InventMovTypeID = 1
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END
 
/*---------------------------------------------------------------------------------------------------------*/
/*           Remove os items marcados do Antigo PreSale   */
/*---------------------------------------------------------------------------------------------------------*/
 
DELETE PreInventoryMov
WHERE
	DocumentID = @IDPreSale
	AND
	Qty = 0
	AND 
	InventMovTypeID = 1
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END
 
/*---------------------------------------------------------------------------------------------------------*/
/*            Recalcula o total do novo PreSale                */
/*---------------------------------------------------------------------------------------------------------*/
SET @Date = getDate()
 
EXEC sp_PreSale_SubCalcTotal @NewIDPreSale , @Date
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO 
END
 
/*---------------------------------------------------------------------------------------------------------*/
/*            Recalcula o total do antigo PreSale                */
/*---------------------------------------------------------------------------------------------------------*/
SET @Date = getDate()
 
EXEC sp_PreSale_SubCalcTotal @IDPreSale , @Date
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO 
END
 
OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)
 
	 DECLARE @ErrorLevelStr varchar(10)
	 SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	 EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DivideHold', @ErrorLevelStr
 
 	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PreSale_Import_Estimated
			(
			@IDEstimated		int,
			@TaxIsent		bit,
			@MediaID		int,
			@IDStore		int,
			@IDUser		int,
			@UpdateSalePrice	bit,
			@NewIDPreSale	int   Output 			
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Cria um novo cabeçalho para o PreSale
		- Inclui os items do orcamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Cria um novo cabeçalho para o PreSale
		-202  Erro em Atualizar o Orcamento
		-203  Erro ao importas os items do orcamento
		-204  Erro em exec sp_PreSale_SubCalcTotal
		-206  Erro em inserir comissao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	19 Aug  2005		Rodrigo Costa		Criacao;
	09 Dec	2005		Rodrigo Costa		Inclusao da comissao;
	24 Feb	2006		Maximiliano Muniz	Ordenação dos itens por código;
	25 Jul	2007		Maximiliano Muniz	Teste do tipo de tela de venda, para o valor do campo LAYAWAY;
	30 Jul	2007		Maximiliano Muniz	Corrigigo tamanho do OBS a ser importado (150 caracteres);
	08 Aug	2007		Maximiliano Muniz	Inclusão do campo IDDepartment na importação dos dados;
	20 Aug	2007		Rodrigo Costa		Removido a opcao de atualizar Cliente Para Prospect
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @StoreID		int
DECLARE @DocumentID 		int 
DECLARE @ModelID 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			float
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @IDPessoa 		int 
DECLARE @DateEstimatedMov 	smalldatetime 
DECLARE @DateRealMov 		smalldatetime 
DECLARE @ComissionID 		int 
DECLARE @IDPreInventoryMov	int
DECLARE @DesiredMarkup		money
DECLARE @Date			DateTime
DECLARE @IDSaleItemCommission	int
DECLARE @Layaway		bit
DECLARE @IDDepartment		int

SET @ErrorLevel = 0

SELECT @Layaway = CAST((CASE WHEN CAST(SrvValue AS INT) = 2 THEN 1 ELSE 0 END) AS BIT) FROM Param WHERE IDParam = 63

BEGIN TRAN
 
/*---------------------------------------------------------------------*/
/*                  Cria um novo cabeçalho para o PreSale              */
/*---------------------------------------------------------------------*/ 

EXEC sp_Sis_GetNextCode 'Invoice.IDPreSale', @NewIDPreSale OUTPUT
INSERT Invoice	(
		IDPreSale,
		IDStore,
 		PreSaleDate,
		IDCustomer,
		TaxIsent,
		MediaID,
		FirstName,
		LastName,
		Layaway,
		Note
		)
		SELECT
			@NewIDPreSale,
			E.IDStore,
 			GetDate(),
			IsNull(E.IDPessoa,0),
 			@TaxIsent,
			@MediaID,
			P.PessoaFirstName,
			P.PessoaLastName,
			@Layaway,
			CAST((isNull(E.OBS, '') + char(13) + char(10) + isNull(E.OBS2, '')) AS VARCHAR(150)) as OBS
		FROM
			Estimated E (NOLOCK) 
			LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = E.IDPessoa)
		WHERE
			E.IDEstimated = @IDEstimated

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Atualizo o orcamento
UPDATE
	Estimated
SET
	IDPreSale = @NewIDPreSale
WHERE
	IDEstimated = @IDEstimated


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------------------------------------------------------------*/
/*           Inclui os items marcados para o novo PreSale              */
/*---------------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMov_Cursor CURSOR FOR

		SELECT
			1,
			@NewIDPreSale,
			@IDStore,
			EI.IDModel,
			GetDate(),
			EI.Qty,
			IsNull(M.VendorCost, M.VendorCost),
			CASE @UpdateSalePrice WHEN 1 THEN M.SellingPrice ELSE EI.SalePrice END,
			IsNull(E.IDPessoa,0),
			E.EstimatedDate,
			GetDate(),
			SU.ComissionID,
			TG.DesiredMarkup,
			EI.IDDepartment
		FROM
			EstimatedItem EI (NOLOCK) 
			JOIN Model M (NOLOCK) ON (M.IDModel = EI.IDModel) 
			JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup) 
			JOIN Estimated E (NOLOCK) ON (E.IDEstimated = EI.IDEstimated)
			JOIN SystemUser SU (NOLOCK) ON (SU.IDUser = E.IDUser)
		WHERE
			EI.IDEstimated = @IDEstimated
		ORDER BY
			EI.Code

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@StoreID,
	@ModelID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@IDPessoa,
	@DateEstimatedMov,
	@DateRealMov,
	@ComissionID,
	@DesiredMarkup,
	@IDDepartment

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		UserID,
		DocumentID,
		StoreID,
		ModelID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		IDPessoa,
		DateEstimatedMov,
		DateRealMov,
		DesiredMarkup,
		IDDepartment
		)
	VALUES
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@IDUser,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@DesiredMarkup,
		@IDDepartment
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	
	/*****************************************************************************************
		Inclusão do Comissionado na tabela de SaleItemCommission
	******************************************************************************************/
	EXEC sp_Sis_GetNextCode'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT
	INSERT INTO dbo.SaleItemCommission
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
		SET @ErrorLevel = -206
		GOTO ERRO
	END


	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@ComissionID,
		@DesiredMarkup,
		@IDDepartment
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor

SET @Date = GetDate()
EXEC sp_PreSale_SubCalcTotal @NewIDPreSale, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO 
END 

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Import_Estimated', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_ItemRepair
			(
				@IDPreSale	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreSerialMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro Inserir Repair
		-202  Erro em Atualizar Repair


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	03 Apr	2006		Rodrigo Costa		Criacao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
*/
 
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
DECLARE @Obs		varchar(255)	
DECLARE @IDDefectType	int
DECLARE @RA		varchar(20)
DECLARE @IDVendor	int
DECLARE @ModelID	int
DECLARE @IDRepair	int
DECLARE @StoreID	int
DECLARE @MovDate	DateTime
DECLARE @CostPrice	Money
DECLARE	@Qty		Float
DECLARE @IDUser		int

SET @ErrorLevel = 0 


DECLARE InvRepair_Cursor CURSOR STATIC FOR 
	SELECT
		IR.Obs,
		IR.IDDefectType,
		IR.RA,
		IR.IDVendor,
		PIM.ModelID,
		PIM.StoreID,
		PIM.MovDate,
		PIM.CostPrice,
		ABS(PIM.Qty),
		PIM.UserID
	FROM
		Sal_ItemRepair IR (NOLOCK) 
		JOIN PreInventoryMov PIM (NOLOCK) ON (PIM.IDPreInventoryMov = IR.IDPreInventoryMov)
	WHERE
		PIM.DocumentID = @IDPreSale
		AND 
		PIM.InventMovTypeID = 1

OPEN InvRepair_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM InvRepair_Cursor INTO
		@Obs,
		@IDDefectType,
		@RA,
		@IDVendor,
		@ModelID,
		@StoreID,
		@MovDate,
		@CostPrice,
		@Qty,
		@IDUser

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN

	EXEC sp_Sis_GetNextCode 'Repair.IDRepair', @IDRepair OUTPUT
	
	--Criar o Repair
	INSERT
		Repair
		(
		IDRepair, 
		IDModel, 
		IDStore, 
		Fase, 
		IDFornecedor, 
		RA, 
		SentDate, 
		IDUserSent, 
		LastCost, 
		Tipo, 
		Qty, 
		IDDefectType,
		TipoRepair,
		Desativado,
		Defect
		)
		VALUES
		(
		@IDRepair, 
		@ModelID, 
		@StoreID, 
		'Send to Vendor', 
		@IDVendor, 
		@RA, 
		@MovDate, 
		@IDUser, 
		@CostPrice, 
		2, 
		@Qty, 
		@IDDefectType,
		0,
		0,
		@Obs
		)


		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
		            SET @ErrorLevel = -201
		            GOTO ERRO
		END

		EXEC sp_Repair_Do @IDRepair


		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
		            SET @ErrorLevel = -202
		            GOTO ERRO
		END


            FETCH NEXT FROM InvRepair_Cursor INTO
			@Obs,
			@IDDefectType,
			@RA,
			@IDVendor,
			@ModelID,
			@StoreID,
			@MovDate,
			@CostPrice,
			@Qty,
			@IDUser
END

--fechamento do cursor
CLOSE InvRepair_Cursor
--Destruição do cursor
DEALLOCATE InvRepair_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ItemRepair', @ErrorLevelStr
	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_MaxDiscount
			(
			@PreSaleID		int, 
			@UserID		int,			 
			@MaxVendaMin  	money output,
			@MaxDiscount    	money output
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Find the Maximum Discount for invoice Range

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ValInvoice money

/*-------------------------------------------------------*/ 
/*      Find the Maximum Discount for invoice Range      */ 
/*-------------------------------------------------------*/ 

SELECT @ValInvoice = 
 	(
	SELECT  sum( IsNull(PIM.Qty,0) * IsNull(PIM.SalePrice,0) * (IsNull(TG.PrcPartDiscount,0)/100) )
 
	FROM 	dbo.PreInventoryMov PIM (NOLOCK)
		JOIN Model MO (NOLOCK) ON (PIM.ModelID = MO.IDModel)
		JOIN TabGroup TG (NOLOCK) ON (MO.GroupID = TG.IDGroup)

	WHERE
		PIM.DocumentID = @PreSaleID
		AND 
		PIM.InventMovTypeID = 1
	) 

SELECT @MaxVendaMin =
	(
	SELECT  MAX(DRMax.TotVendaMin)

	FROM
		dbo.DiscRange DRMax (NOLOCK)  
		JOIN vwComissionado CO (NOLOCK)  ON (DRMax.IDTipoComissionado = CO.IDTipoComissionado)
		JOIN SystemUser SU (NOLOCK) ON (CO.IDComissionado = SU.ComissionID)

	WHERE
		SU.IDUser = @UserID
		 AND
   		DRMax.TotVendaMin <= IsNull(@ValInvoice, 0)
	)
 

SELECT @MaxDiscount =
	(
		(
		SELECT 	IsNull(DR.PercDiscMax, 0)

		FROM 	
			dbo.DiscRange  DR (NOLOCK) 
			JOIN dbo.vwComissionado  CO (NOLOCK) ON (DR.IDTipoComissionado = CO.IDTipoComissionado)
			JOIN dbo.SystemUser SU (NOLOCK)  ON (CO.IDComissionado = SU.ComissionID)

		WHERE
		 	SU.IDUser = @UserID
			AND
			DR.TotVendaMin = @MaxVendaMin
		) /100
	) * @ValInvoice
 

SELECT @MaxVendaMin = IsNull(@MaxVendaMin, 0) 
SELECT @MaxDiscount = IsNull(@MaxDiscount, 0)
GO

CREATE PROCEDURE sp_PreSale_Pay
			(
			@PreSaleID		int,
			@IDCashRegMov		int,
			@PayDate 		smalldatetime,
			@IDStore		int,
			@IDTouristGroup 	int,
			@OtherComID 		int,
			@CashReceived   	money,
			@Date			Datetime,
			@BonusBucks		money,
			@IDInvoice 		int output
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
	- Transforma a PreSale em Sale
	- Move os PreInventMov para o InventMov
	- Insert Encargos de Venda na tabela de Taxas InventoryMovTax
	- Insert Impostos de Venda na tabela de Taxas InventoryMovTax
	- Move os PreSerialMov para o SerialMov
	- Deleta os seriais do Inventario
	- Deleta Pre Inventory Movement
	- Marca os lancamentos como confimados, e troca o documento
	- Update Cash RegisterMovent
	- Atualiza o custo medio dos modelos
	- Calc commissions for report performace

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro ao gerar novo IDInvoice
	-202  Erro ao transformar Hold em Invoice
	-203  Erro movendo os PreInventMov para o InventMov
	-204  Erro movendo os PreSerialMov para o SerialMov
	-205  Erro ao deletar/inserir os Seriais do Inventario
	-206  Erro ao deletar o PreSerialMov
	-207  Erro ao deletar o PreInventoryMov
	-208  Erro ao inserir as linhas de quitacao
	-209  Erro as inserir as linhas de ligação entre lancamento e quitacao
	-210  Erro ao atualizar o NumDocumento nas parcelas do Invoice
	-212  Erro ao Atualizar as comissões
	-213  Erro ao mover Model Pack de PreInvMov para InvMov
	-214  Erro ao Impostos
	-216  Erro ao Colocar PreInventMovParent para Null
	-217  Erro ao atualizar SaleItemCommission
	-218  Erro ao inserir em Sal_AccountCard
	-219  Erro ao Inserir em Repair
	-220  Erro ao Inserir em Sal_RebateDiscount
	-221  Erro nos totais de Invoice com os Lacamentos
	-222  Erro ao atualizar Inv_MovPrice
	-223  Erro ao inserir Price
	-224  Erro ao atualizar Inv_MovDocument

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		Alteração para suporte as novas tabelas do financeiro;
	27 May	2000   		Eduardo Costa		Criação da rotina de tratamento e retorno de erros;
	14 Aug	2000   		Eduardo Costa		A quitação dos lancamentos do invoice foi transferida
							para o close da caixa registradora;
	15 Aug	2000		Rodrigo Costa		Novo campo SalesTax para calcular a tax;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	29 Jun	2001		Rodrigo Costa		Alteracao no delete Serial do Inventory, criado um join com a tbl PreSerialMov;
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCode para Invoice; Cursor InventoryMov;
							Deletado INSERT InvoiceGen (BitGen) VALUES (1), SELECT @IDInvoice = @@IDENTITY; 
							Criado Cursor para InvMov;
	18 Dec	2003		Andre Bogado		Alteração no cursor de InvMov para atualizar InventoryMovTax;
	22 Dec	2003		Rodrigo Costa		Incluir os Serias no Inventory se for Refound;
	25 May	2004		Rodrigo Costa		Mover PackModels do PreInvMov para o InvMov;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	20 Set	2004		Rodrigo Costa		Correcao do Calculo de InventoryMovTax (IM.SalePrice-IM.Discount);
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas;
	01 Fev	2005		Rodrigo Costa		Mover as QtyExchanged de Pre para Inv;
	25 Fev	2005		Rodrigo Costa		Quando finalizar o Invoice nao pode atualizar o IDStore;
	29 Mar	2005		Rodrigo Costa		Atualiza o custo medio dos modelos; gravar o custo medio na venda;
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInv e InventoryMov;
	17 May	2005		Rodrigo Costa		Cursor para alterar PreInvMovParent;
	01 Jul	2005		Rodrigo Costa		Gerar numero sequencial para Items de Servico;
	28 Nov	2005		Leonardo Riego		Atualiza SaleItemCommission;
	11 Jan	2006		Rodrigo Costa		Remover zerar o custo medio;
	23 Mar	2006		Carlos Lima		Suporte ao Gift Card ( Chamada para a procedure que inclui em Sal_AccountCard );
	03 Apr	2006		Rodrigo Costa		Inserir em Repair;
	29 Jun	2006		Rodrigo Costa		Retirado a transacao, tem que ser feita no Delphi;
	09 Aug	2006		Leonardo Riego		Adicionado a coluna de promo na PreInventory para InventoryMov;
	07 Nov	2006		Maximiliano Muniz	Inserção na tabela Sal_RebateDiscount;
	16 Nov	2006		Maximiliano Muniz	Mudança do campo IDPreSale para IDPreSaleCreated e inclusão do campo
							IDPreSaleUsed, na tabela Sal_RebateDiscount;
	23 Nov	2006		Maximiliano Muniz	Mudança na inserção da tabela Sal_RebateDiscount, para gravar os novos
							campos (ValidFromDate, ExpirationDate)
	28 Nov	2006		Rodrigo Costa		Verificacao do total do invoice com os totais do pagamento;
	11 Jan	2007		Maximiliano Muniz	Retirada a gravação em Sis_AppHistory;
	26 Fev	2007		Rodrigo Costa		Calcular imposto estabelecido no PreInvMov
	03 Apr	2007		Maximiliano Muniz	Alterado o join da query que insere os impostos;
	11 Apr	2007		Maximiliano Muniz	Adicionado ao cálculo do total da nota, o novo campo de desconto;
	19 Jul	2007		Maximiliano Muniz	Atualização do campo IDInventoryMov na tabela Inv_MovPrice;
							Inserção de um novo registro na Fin_Lancamento com o valor nominal igual a diferênça
							entre o valor vendido e o valor sugerido pelo fornecedor, na tabela Inv_MovPrice;
	09 Aug	2007		Maximiliano Muniz	Atualização do campo IDInventoryMov na tabela Inv_MovDocument;
							Preenchimento do campo "IdentificationNumber" na tabela "SerialMov";
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @DataPagamento  	smalldatetime
DECLARE @ComissionPayed 	money
DECLARE @IDCentroCusto		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @InvoiceCode		varchar(20)
DECLARE @ServiceField		varchar(30)
DECLARE @BonusMinSaleValue	money
DECLARE @DaysToUseBonusBucks	int
DECLARE @ExpireDaysBonusBucks	int
--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID	int
DECLARE @DocumentID		int
DECLARE @IDPessoa		int
DECLARE @ModelID		int
DECLARE @BarCodeID		char(20)
DECLARE @MovDate		smalldatetime
DECLARE @Qty 			float
DECLARE @CostPrice		money
DECLARE @SalePrice		money
DECLARE @Discount		money
DECLARE @PreInventoryMovID	int
DECLARE @IDUser			int
DECLARE @SalesTax		money
DECLARE @StoreID		int
DECLARE @IDInventoryMov		int
DECLARE @IDParentPack		int
DECLARE @QtyExchanged		float
DECLARE @IDPreInvMovExchange	int
DECLARE @AvgCost		money
DECLARE @DesiredMarkup		money
DECLARE @IsService		bit
DECLARE @AutoCreateSrvNum	bit
DECLARE @ServiceNum		int
DECLARE @IDGroup		int
DECLARE @CardNumber		varchar(20)
DECLARE @GiftValue		money
DECLARE @IDDepartment		int
DECLARE @Promo			bit
DECLARE @TotalPaid		money
DECLARE @TotalInvoice		money
DECLARE @IDTaxCategory		int
--Declaração de variáveis para Price
DECLARE @GeneratePrice		int
DECLARE @IDEmpresa		int
DECLARE @IDContaCorrente	int
DECLARE @IDLancamento		int
DECLARE @IDLancamentoTipo	int
DECLARE @IDDocumentoTipo	int
DECLARE @IDPagamentoTipo	int
DECLARE @DiasVencimento		int
DECLARE @IDVendorPrice		int
DECLARE @IDVendorType		int
DECLARE @SuggPrice		money

SET @ErrorLevel = 0

SET @SysError = @@ERROR
IF @SysError <> 0 GOTO ERRO


-- Pego o parâmetro de PRICE
SELECT @GeneratePrice = CASE WHEN UPPER(SrvValue) = 'TRUE' THEN 1 ELSE 0 END FROM Param (NOLOCK) WHERE IDParam = 97

/*--------------------------------------------------------------------------------------------------------*/
/*		Valida as formas de pagamento								*/
/*--------------------------------------------------------------------------------------------------------*/

SELECT
	@TotalPaid = SUM(IsNull(ValorNominal, 0))
FROM
	Fin_Lancamento (NOLOCK)
WHERE
	IDPreSale =  @PreSaleID

SELECT
	@TotalInvoice = ((((IsNull(SubTotal,0) - IsNull(InvoiceDiscount, 0) - IsNull(TaxIsemptItemDiscount,0)) - IsNull(ItemDiscount,0)) + IsNull(Tax,0)) + IsNull(AditionalExpenses,0))
FROM
	Invoice (NOLOCK)
WHERE
	IDPreSale =  @PreSaleID

PRINT 'TotalPaid = ' + cast(@TotalPaid as varchar)
PRINT 'TotalInvoice = ' + cast(@TotalInvoice as varchar)

SET @SysError = @@ERROR
IF (@SysError <> 0) OR (@TotalPaid <> @TotalInvoice)
BEGIN
	SET @ErrorLevel = -221
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  	*/
/*--------------------------------------------------------------------------------------------------------*/

-- Calcula o proximo IDInvoice
EXEC sp_Sis_GetNextCode 'InvoiceGen.IDInvoice', @IDInvoice OUTPUT

EXEC SP_PreSale_GetNewInvoiceCode @IDStore, @InvoiceCode OUTPUT

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

 -- Transforma o hold em invoice
UPDATE Invoice
SET		Invoice.IDInvoice    	= @IDInvoice,
		Invoice.InvoiceDate  	= @PayDate,
		Invoice.CashReceived 	= @CashReceived,
		Invoice.CashRegMovID 	= @IDCashRegMov,
		Invoice.InvoiceCode	= @InvoiceCode

WHERE 	Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Move os PreInventMov para o InventMov                      */
/*------------------------------------------------------------------------------------------------------*/
--Declaração do Cursor de InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT	PIM.InventMovTypeID,
			@IDInvoice,
			PIM.IDPessoa,
			PIM.StoreID,
			PIM.ModelID,
			PIM.BarCodeID,
			@PayDate,
			PIM.Qty,
			PIM.CostPrice,
			PIM.SalePrice,
			PIM.Discount,
			PIM.IDPreInventoryMov,
			PIM.UserID,
			IsNull((CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
				 THEN TC.SpecialTax ELSE TC.Tax END / 100.00),0)  as Tax,-- Tax
			PIM.IDParentPack,
			PIM.QtyExchanged,
			PIM.IDPreInvMovExchange,
			M.AvgCost,
			TG.DesiredMarkup,
			TG.ServiceAutoNumber,
			TG.Service,
			TG.IDGroup,
			PIM.IDDepartment,
			PIM.Promo,
			PIM.IDTaxCategory
	FROM		
			dbo.PreInventoryMov PIM (NOLOCK)
			JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel )
			JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )
			JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
			LEFT JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, STC.IDTaxCategory))

	WHERE   	PIM.DocumentID = @PreSaleID
			AND
			PIM.InventMovTypeID = 1

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@IDPessoa,
	@StoreID,
	@ModelID,
	@BarCodeID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@Discount,
	@PreInventoryMovID,
	@IDUser,
	@SalesTax,
	@IDParentPack,
	@QtyExchanged,
	@IDPreInvMovExchange,
	@AvgCost,
	@DesiredMarkup,
	@AutoCreateSrvNum,
	@IsService,
	@IDGroup,
	@IDDepartment,
	@Promo,
	@IDTaxCategory
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0BEGIN

	SET @ServiceNum = Null

	IF (@AutoCreateSrvNum = 1 AND @IsService = 1  )
	BEGIN
		SET @ServiceField = 'TabGroup.Service'+CAST(@IDGroup as Varchar(10))
		EXEC sp_Sis_GetNextCode @ServiceField, @ServiceNum OUTPUT
	END

	EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		IDPessoa,
		StoreID,
		ModelID,
		BarCodeID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		PreInventoryMovID,
		IDUser,

		SalesTax,
		IDParentPack,
		QtyExchanged,
		IDPreInvMovExchange,
		AvgCost,
		DesiredMarkup,
		SequencyNum,
		IDDepartment,
		Promo
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack,
		@QtyExchanged,
		@IDPreInvMovExchange,
		@AvgCost,
		@DesiredMarkup,
		@ServiceNum,
		@IDDepartment,
		@Promo
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	-- Atualiza SaleItemCommission
	UPDATE SaleItemCommission
	SET
	 	IDPreInventoryMov = NULL,
		IDInventoryMov = @IDInventoryMov
	WHERE
		IDPreInventoryMov = @PreInventoryMovID
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -217
		GOTO ERRO
	END

	-- Insert Encargos de Venda na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TCC.IDTaxCategory,0) AS IDTaxCategory,
		ISNULL (TCC.Tax,0)/100 AS Tax,
		ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TCC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM (NOLOCK)
		JOIN Model Mo (NOLOCK) ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG (NOLOCK) ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TCP (NOLOCK) ON (TCP.IDTaxCategory = IsNull(@IDTaxCategory, SG.IDTaxCategory))
		JOIN TaxCategory TCC (NOLOCK) ON (SG.IDTaxCategory = TCC.IDTaxCategoryParent)
	WHERE
	 	IM.IDInventoryMov = @IDInventoryMov

	-- Insert Impostos de Venda na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TC.IDTaxCategory,0) AS IDTaxCategory,
		ISNULL (TC.Tax,0)/100 AS Tax,
		ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM (NOLOCK)
		JOIN Model Mo (NOLOCK) ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG (NOLOCK) ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TC (NOLOCK) ON (SG.IDSaleTax = TC.IDTaxCategory)

	WHERE
	 	IM.IDInventoryMov = @IDInventoryMov

	-- Atualiza Inv_MovPrice
	UPDATE Inv_MovPrice
	SET
	 	IDPreInventoryMov = NULL,
		IDInventoryMov = @IDInventoryMov
	WHERE
		IDPreInventoryMov = @PreInventoryMovID
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -222
		GOTO ERRO
	END

	IF @GeneratePrice = 1
	BEGIN
		-- Pego as informações de price
		SET @SuggPrice = @SalePrice

		SELECT
			@IDVendorPrice = IDVendor,
			@SuggPrice = SuggPrice
		FROM
			Inv_MovPrice (NOLOCK)
		WHERE
			IDInventoryMov = @IDInventoryMov
		
		-- Se o preço vendido foi inferior ao preço sugerido pelo fornecedor, insere o Price
		IF @SalePrice < @SuggPrice
		BEGIN
			-- Pega as constantes
			SELECT @IDLancamentoTipo = CAST(PropertyValue AS INT) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PriceRecordType'
			SELECT @IDDocumentoTipo = CAST(PropertyValue AS INT) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PriceDocumentType'
			SELECT @IDPagamentoTipo = CAST(PropertyValue AS INT) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PricePaymentType'
			SELECT @DiasVencimento = CAST(PropertyValue AS INT) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PriceDueDateDays'
			SELECT @IDVendorType = IDTipoPessoaRoot FROM Pessoa (NOLOCK) WHERE IDPessoa = @IDVendorPrice


			SELECT
				@IDCentroCusto = S.IDCentroCusto,
				@IDContaCorrente = MPS.IDContaCorrente,
				@IDEmpresa = S.IDEmpresa
			FROM
				Store S (NOLOCK)
				JOIN MeioPagToStore MPS (NOLOCK) ON (S.IDStore = MPS.IDStore)
			WHERE
				S.IDStore = @IDStore
				AND MPS.IDMeioPag = @IDPagamentoTipo

			EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento output

			INSERT INTO Fin_Lancamento (IDLancamento, IDPessoa, IDPessoaTipo, IDUsuarioLancamento, IDEmpresa, DataLancamento, DataVencimento,
			ValorNominal, Pagando, NumDocumento, IDCentroCusto, IDContaCorrentePrevista, IDQuitacaoMeioPrevisto, IDLancamentoTipo,
			IDDocumentoTipo, Situacao)
			VALUES (@IDLancamento, @IDVendorPrice, @IDVendorType, @IDUser, @IDEmpresa, @MovDate, DATEADD(DAY, @DiasVencimento, @MovDate),
			@SuggPrice - @SalePrice, 0, @InvoiceCode, @IDCentroCusto, @IDContaCorrente, @IDPagamentoTipo, @IDLancamentoTipo,
			@IDDocumentoTipo, 1)
		END

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE InventoryMov_Cursor
			DEALLOCATE InventoryMov_Cursor
			SET @ErrorLevel = -223
			GOTO ERRO
		END
	END

	-- Atualiza Inv_MovDocument
	UPDATE Inv_MovDocument
	SET
	 	IDPreInventoryMov = NULL,
		IDInventoryMov = @IDInventoryMov
	WHERE
		IDPreInventoryMov = @PreInventoryMovID
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -223
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack,
		@QtyExchanged,
		@IDPreInvMovExchange,
		@AvgCost,
		@DesiredMarkup,
		@AutoCreateSrvNum,
		@IsService,
		@IDGroup,
		@IDDepartment,
		@Promo,
		@IDTaxCategory
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Insere a movimentação de crédito na tabela de AccountCard                	*/
/*--------------------------------------------------------------------------------------------------------*/

EXEC sp_PreSale_ItemRepair @PreSaleID
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -219
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Insere a movimentação de crédito na tabela de AccountCard                	*/
/*--------------------------------------------------------------------------------------------------------*/


DECLARE AccountMov_Cursor CURSOR FOR
	SELECT			
		PSM.SerialNumber,
		PIM.SalePrice - (PIM.Discount / PIM.Qty),
		PIM.UserID
	FROM		
		PreSerialMov PSM (NOLOCK)
		JOIN PreInventoryMov PIM (NOLOCK) ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
		JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
	WHERE 	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		M.ModelType = 'G'

OPEN AccountMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM AccountMov_Cursor INTO @CardNumber, @GiftValue, @IDUser

WHILE @@FETCH_STATUS = 0
BEGIN

	EXEC sp_Sal_AccountCard_AddAmount @CardNumber, @GiftValue, @PreSaleID, NULL, @IDUser, 1, ''


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE AccountMov_Cursor
		DEALLOCATE AccountMov_Cursor
		SET @ErrorLevel = -218
		GOTO ERRO
	END

	FETCH NEXT FROM AccountMov_Cursor INTO @CardNumber, @GiftValue, @IDUser
END

CLOSE AccountMov_Cursor
DEALLOCATE AccountMov_Cursor


/*--------------------------------------------------------------------------------------------------------*/
/*	     Move os PreSerialMov para o SerialMov                	*/
/*--------------------------------------------------------------------------------------------------------*/
INSERT SerialMov (InventoryMovID, SerialNumber, IdentificationNumber)
	SELECT
		IM.IDInventoryMov,
		PSM.SerialNumber,
		PSM.IdentificationNumber
	FROM
		PreSerialMov PSM (NOLOCK)
		JOIN InventoryMov IM (NOLOCK) ON (PSM.PreInventoryMovID = IM.PreInventoryMovID)
	WHERE
		IM.DocumentID = @IDInvoice
		AND IM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta/Insert os seriais do Inventario			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE
	InventorySerial
FROM
	PreInventoryMov PIM (NOLOCK),
	PreSerialMov PSV (NOLOCK)
WHERE
	PIM.DocumentID = @PreSaleID
	AND PIM.InventMovTypeID = 1
	AND InventorySerial.ModelID = PIM.ModelID
	AND InventorySerial.StoreID = @IDStore
	AND InventorySerial.Serial = PSV.SerialNumber
	AND PIM.Qty > 0

--Refound
INSERT
	InventorySerial (StoreID, ModelID, Serial)
SELECT
	@IDStore,
	PIM.ModelID,	
	PSV.SerialNumber
FROM
	PreInventoryMov PIM (NOLOCK)
	JOIN PreSerialMov PSV (NOLOCK) ON (PIM. IDPreInventoryMov = PSV.PreInventoryMovID)
WHERE
	PIM.DocumentID = @PreSaleID
	AND PIM.InventMovTypeID = 1
	AND PIM.Qty < 0


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreSerial Movement			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE
	PreSerialMov
FROM
	PreInventoryMov PIM (NOLOCK)
WHERE
	PIM.DocumentID = @PreSaleID
	AND PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Atualiza  os ModelsPack de InvMov			*/
/*--------------------------------------------------------------------------------------------------------*/

UPDATE 
	IMC 
SET 
	IMC.IDParentPack = IMP.IDInventoryMov
FROM 
	InventoryMov IMC (NOLOCK)
	JOIN InventoryMov IMP (NOLOCK) ON ( IMP.PreInventoryMovID = IMC.IDParentPack)
WHERE 
	IMC.DocumentID = @DocumentID
	AND IMC.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreInventory Movement			*/
/*--------------------------------------------------------------------------------------------------------*/

UPDATE
	PreInventoryMov
SET
	IDPreInventoryMovParent = NULL
WHERE
	DocumentID = @PreSaleID
	AND InventMovTypeID = 1
	AND IDPreInventoryMovParent IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	CLOSE PreInventoryMovDelParent_Cursor
	DEALLOCATE PreInventoryMovDelParent_Cursor
	SET @ErrorLevel = -216
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreInventory Movement			*/
/*--------------------------------------------------------------------------------------------------------*/
DELETE 	
		PreInventoryMov
WHERE 	
		PreInventoryMov.DocumentID = @PreSaleID
		AND
		PreInventoryMov.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*----------------------------------------------------------------------------------------------*/
/*	Marca os lancamentos como confimados, e troca o documento				*/
/*----------------------------------------------------------------------------------------------*/

UPDATE
	Fin_Lancamento
SET
	NumDocumento = @InvoiceCode,
	DataEmissao = @PayDate,
	Previsao = 0
WHERE
	IDPreSale =  @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END

/*----------------------------------------------------------------------------------------------*/
/*		Insere o bonus bucks								*/
/*----------------------------------------------------------------------------------------------*/

IF (@BonusBucks > 0)
BEGIN
	SELECT @BonusMinSaleValue = CAST(PropertyValue as money)
	FROM Sis_PropertyDomain (NOLOCK)
	WHERE Property = 'BonusBuckMinSaleValue'
	
	IF (@TotalInvoice > @BonusMinSaleValue)
	BEGIN
		SELECT @DaysToUseBonusBucks = CAST(PropertyValue as int)
		FROM Sis_PropertyDomain (NOLOCK)
		WHERE Property = 'DaysToUseBonusBucks'
	
		SELECT @ExpireDaysBonusBucks = CAST(PropertyValue as int)
		FROM Sis_PropertyDomain (NOLOCK)
		WHERE Property = 'ExpireDaysBonusBucks'
	
		INSERT INTO Sal_RebateDiscount (IDPreSaleCreated, DiscountValue, ValidFromDate, ExpirationDate, IDPreSaleUsed)
		VALUES (@PreSaleID, @BonusBucks, dbo.fn_Sys_RemoveTime(DateAdd(Day, @DaysToUseBonusBucks, @PayDate)), DateAdd(Day, @DaysToUseBonusBucks + @ExpireDaysBonusBucks, @PayDate), NULL)
		
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -220
			GOTO ERRO
		END
	END
END

OK:
	RETURN 0
ERRO:
	RETURN @ErrorLevel

GO

CREATE PROCEDURE sp_PreSale_Remove
			(
				@PreSaleID	int,
				@IDUser		int
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreSerialMov
		- Remove InventoryMov
		- Deleta os pagamentos
		- Remove o Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Delecao do PreSerialMov
		-202  Erro em Remove the Inventory Mov
		-203  Erro em Remover os lancamentos
		-207  Erro em Remove the Invoice
		-208  Erro em Remove historico
		-208  Erro em Remove outros custos
		-209  Erro em Deletar Account Number
		-210  Erro em Deletar Item repair
		-211  Erro em Remove the Shipping
		-212  Erro no Update Sal_RebateDiscount
		-213  Erro em Remove Sal_AccountCardMov
		-214  Erro em Update Estimated
		-215  Erro em Remove InvoiceOBS

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	19 Jul	2001		Davi Gouveia		Exclusao de testes se Hold está sendo usado, visto q o teste ja é feito no Delphi;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	25 Oct	2004		Rodrigo Costa		Deleta os Historicos dos pedidos;
	19 Jan	2005		Rodrigo Costa		Deleta os outros custos do pedido;
	22 Mar	2006		Rodrigo Costa		Deletar Account Number;
	03 Apr	2006		Rodrigo Costa		Deletar o Item Repair;
	14 Feb	2007		Maximiliano Muniz	Deletar da tabela Sal_InvoiceShipping;
	21 Mar	2007		Maic Nogueira		Update na tabela Sal_RebateDiscount para remover o vínculo com a tabela Invoice;
	23 Jul	2007		Maximiliano Muniz	Deleção nas tabelas Sal_AccountCardMov e InvoiceOBS, e update na Estimated;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IsLayaway	bit
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
DECLARE @IDPreInvMovOld	int
SET @ErrorLevel = 0

BEGIN TRAN

/*----------------------------------------------*/
/*	Deleta os Historicos dos pedidos	*/
/*----------------------------------------------*/
DELETE
	H
FROM
	History H (NOLOCK) 
WHERE
	H.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*--------------------------------------*/
/*	Delecao do Account Number	*/
/*--------------------------------------*/
DELETE
	AC
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN Sal_AccountCard AC (NOLOCK) ON (PIM.IDPreInventoryMov = AC.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


/*--------------------------------------------------------------*/
/*		Delecao do Sal_ItemRepair	        */
/*--------------------------------------------------------------*/
DELETE
	IR
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN Sal_ItemRepair IR (NOLOCK) ON (PIM.IDPreInventoryMov = IR.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


/*--------------------------------------------------------------*/
/*	Delecao do PreSerialMov	        */
/*--------------------------------------------------------------*/
DELETE
	PSM
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN PreSerialMov PSM (NOLOCK) ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	Remove the PreInventoryMov		  */
/*----------------------------------------------------------------*/
--Declaração do Cursor de PreInvDel_Cursor
DECLARE PreInvDel_Cursor CURSOR STATIC FOR 
	SELECT
		IDPreInventoryMov
	FROM
		PreInventoryMov (NOLOCK) 
	WHERE
		DocumentID = @PreSaleID
		AND 
		InventMovTypeID = 1

OPEN PreInvDel_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM PreInvDel_Cursor INTO
            @IDPreInvMovOld

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	--Deletar os items
	EXEC sp_PreSale_SubRemoveItem @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -202
	            GOTO ERRO
	END

            FETCH NEXT FROM PreInvDel_Cursor INTO
                        @IDPreInvMovOld
END

--fechamento do cursor
CLOSE PreInvDel_Cursor
--Destruição do cursor
DEALLOCATE PreInvDel_Cursor

/*--------------------------------------*/
/*	Deleta os pagamentos		*/
/*--------------------------------------*/

EXEC sp_PreSale_DeletePayments @PreSaleID, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END

-- Remove os outros custos
DELETE
	C
FROM
	InvoiceToCostType C (NOLOCK) 
WHERE
	C.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END

/*------------------------------*/
/*	Remove the Shipping	*/
/*------------------------------*/
DELETE
	Sal_InvoiceShipping
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

/*--------------------------------------*/
/*	Update Sal_RebateDiscount	*/
/*--------------------------------------*/
UPDATE
	Sal_RebateDiscount
SET
	IDPreSaleUsed = NULL
WHERE
	IDPreSaleUsed = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END

/*--------------------------------------*/
/*	Remove the Sal_AccountCardMov	*/
/*--------------------------------------*/

DELETE
	Sal_AccountCardMov
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*--------------------------------------*/
/*	Update Estimated		*/
/*--------------------------------------*/

UPDATE
	Estimated
SET
	IDPreSale = NULL
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -214
	GOTO ERRO
END

/*------------------------------*/
/*	Remove the InvoiceOBS	*/
/*------------------------------*/

DELETE
	InvoiceOBS
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -215
	GOTO ERRO
END

/*------------------------------*/
/*	Remove the Invoice	*/
/*------------------------------*/
DELETE
	I
FROM
	Invoice I (NOLOCK) 
WHERE
	I.IDPreSale = @PreSaleID
	AND
	I.IDInvoice IS  NULL 

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
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Remove', @ErrorLevelStr
	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_RemoveDiscountItem
			( 
			@IDPreSale 		int,
			@IDPreInventMov	int,
			@Date 			DateTime,
			@SellBelowCost		bit = 0
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se possui Item de Desconto 
		- Delecao do item de Desconto
		- Guarda o valor do desconto no Invoice
		- Atualização do Desconto na Nota

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro ao guardar o valor do desconto do item
		-202  Erro em Delecao do item de Desconto
		-203  Erro ao guardar o valor do desconto do invoice
		-205  Erro ao guardar o valor do parametro TAX_EXEMPT_ON_SALE  
		-205  Erro em Atualizar o Desconto na Nota 
		


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	5  Apr  2006		Leonardo Riego		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ItemDiscount	  money
DECLARE @InvoiceDiscount  money
DECLARE @NewDiscountValue money
DECLARE @TaxinSale      bit
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*                Testa se possui Item de Desconto                              */
/*------------------------------------------------------------------------------*/ 

SELECT
	@ItemDiscount = Discount
FROM
	Sal_Discount (NOLOCK) 
WHERE
	IDPreSale = @IDPreSale
	AND
	IDPreInventoryMov = @IDPreInventMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -201'
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                Delecao do item de Desconto                              */
/*------------------------------------------------------------------------------*/ 

DELETE FROM
	Sal_Discount
WHERE
	IDPreSale = @IDPreSale
	AND
	IDPreInventoryMov = @IDPreInventMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -202'
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                Guarda o valor do desconto no Invoice                         */
/*------------------------------------------------------------------------------*/ 

SELECT
	@InvoiceDiscount = ItemDiscount
FROM
	Invoice (NOLOCK) 
WHERE
	IDPreSale = @IDPreSale
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -203'
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                Guarda o valor do parametro TAX_EXEMPT_ON_SALE                */
/*------------------------------------------------------------------------------*/ 

SELECT
	@TaxinSale = CASE WHEN SrvValue = 'TRUE' THEN 1
			  	ELSE  0
			END
FROM
	Param (NOLOCK) 
WHERE
	IDParam = 64
	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -204'
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                Atualização do Desconto na Nota                              */
/*------------------------------------------------------------------------------*/ 
IF (@ItemDiscount <> 0)
BEGIN

exec sp_PreSale_SpecialPriceManager @IDPreSale, 0, @Date, @TaxinSale, @SellBelowCost

SET @NewDiscountValue = @InvoiceDiscount - @ItemDiscount

exec sp_PreSale_SpecialPriceManager @IDPreSale, @NewDiscountValue, @Date, @TaxinSale, @SellBelowCost

END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -205'
	SET @ErrorLevel = -205
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_RemoveDiscountItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_RemoveSpecialPrice
		(
			@PreSaleID	int,
			@Date  	DateTime,
			@ExemptTax	bit
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Remove o SpecialPrice de um PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE dbo.PreInventoryMov
		-202  Erro em UPDATE dbo.Invoice
		-203  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	20 Mar 2005		Rodrigo Costa		Novo parametro ExemptTax
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

UPDATE
	dbo.PreInventoryMov
SET
	dbo.PreInventoryMov.SalePrice =
		(
		SELECT
			MO.SellingPrice
		FROM
			dbo.PreInventoryMov PIM (NOLOCK) 
			JOIN dbo.Model MO (NOLOCK) ON (PIM.ModelID    = MO.IDModel)
		WHERE
			PIM.IDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
		),
	dbo.PreInventoryMov.Discount = 0
WHERE
	dbo.PreInventoryMov.DocumentID = @PreSaleID
	AND
       	dbo.PreInventoryMov.InventMovTypeID = 1
	AND
	PreInventoryMov.IDParentPack IS Null

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

UPDATE
	dbo.Invoice
SET
	dbo.Invoice.SpecialPriceID = NULL,
	dbo.Invoice.TaxIsent = @ExemptTax
WHERE
	dbo.Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_RemoveSpecialPrice', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SetTaxIsention
		(
			@IDPreSale 	int,
			@IDMedia   	int,
			@Date  	DateTime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se isencao de taxa e automatica e tira a taxa do invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE Invoice SET TaxIsent = 1
		-202  Erro em UPDATE Invoice SET TaxIsent = 0
		-203  Erro em exec sp_PreSale_SubCalcTax


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/*		Testa se isencao de taxa e automatica e tira a taxa do invoice   */
if (SELECT TaxMode FROM Media (NOLOCK)  WHERE IDMedia = @IDMedia) = 3
  begin
	UPDATE
		Invoice
	SET
		Tax = 0,
		TaxIsent = 1
	WHERE
		IDPreSale = @IDPreSale

	SET @SysError = @@ERROR 
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
        	END
  end
else
  begin
	UPDATE
		Invoice
	SET
		TaxIsent = 0
	WHERE
		IDPreSale = @IDPreSale

	SET @SysError = @@ERROR 
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
        	END

	exec sp_PreSale_SubCalcTax @IDPreSale, @Date

	SET @SysError = @@ERROR 
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
        	END
  end


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SetTaxIsention', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_Split
			(
			@IDPreSale 		int,
			@NewIDPreSale	int   Output 			
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Cria um novo cabeçalho para o PreSale
		- Inclui os items marcados para o novo PreSale
		- Remove os items marcados para o novo PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Cria um novo cabeçalho para o PreSale
		-202  Erro em Inclui os items marcados para o novo PreSale
		-203  Erro em Remove os items marcados para o novo PreSale
		-204  Erro em exec sp_PreSale_SubCalcTotal
		-205  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	29 Oct 	2003		Rodrigo Costa		Removido SELECT @NewIDPreSale = @@IDENTITY;
							Chama sp_GetNextCode para IDPreSale
	18 Aug 2004		Rodrigo Costa		Gravar error log
	05 May	2005		Rodrigo Costa		Novo campo de desired markup
	09 Dec	2005		Rodrigo Costa		Inclusao das comissoes
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 		int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			float 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @IDPessoa 		int 
DECLARE @DateEstimatedMov 	smalldatetime 
DECLARE @DateRealMov 		smalldatetime 
DECLARE @QtyRealMov 		float
DECLARE @ComissionID 		int 
DECLARE @IDPreInventoryMov	int
DECLARE @DesiredMarkup		money
DECLARE @Date			DateTime
DECLARE @IDPreInvMovOld		int


SET @ErrorLevel = 0

BEGIN TRAN
 
/*---------------------------------------------------------------------*/
/*                  Cria um novo cabeçalho para o PreSale              */
/*---------------------------------------------------------------------*/ 
EXEC sp_Sis_GetNextCode'Invoice.IDPreSale', @NewIDPreSale OUTPUT
INSERT Invoice	(
		IDPreSale,
		IDInvoice,
		IDMeioPag,
		SpecialPriceID,
 		IDTouristGroup,
 		PreSaleDate,
 		InvoiceDate,
		OtherComissionID,
		IDCustomer,
		DeliverTypeID,
		DeliverDate,
		DeliverAddress,
		Passport,
		PassportDate,
 		Ticket,
		AirLine,
		CompanyName,
		CompanyCGC,
		DepositDate,
		Note,
		TaxIsent,
		MediaID
		)
		SELECT
			@NewIDPreSale,
			IDInvoice,
			IDMeioPag,
			SpecialPriceID,
			IDTouristGroup,
 			PreSaleDate,
			InvoiceDate,
			OtherComissionID,
			IDCustomer,
			DeliverTypeID,
			DeliverDate,
			DeliverAddress,
			Passport,
			PassportDate,
			Ticket,
 			AirLine,
			CompanyName,
			CompanyCGC,
			DepositDate,
			Note,
 			TaxIsent,
			MediaID
		FROM
			Invoice (NOLOCK) 
		WHERE
			Invoice.IDPreSale = @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*---------------------------------------------------------------------*/
/*           Inclui os items marcados para o novo PreSale              */
/*---------------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMov_Cursor CURSOR FOR

		SELECT
			IDPreInventoryMov,
			InventMovTypeID,
			@NewIDPreSale,
			StoreID,
			ModelID,
			BarCodeID,
			MovDate,
			Qty,
			CostPrice,
			SalePrice,
			Discount,
			IDPessoa,
			DateEstimatedMov,
			DateRealMov,
			QtyRealMov,
			DesiredMarkup
		FROM
			dbo.PreInventoryMov (NOLOCK) 
		WHERE
			DocumentID = @IDPreSale
			AND
			Marked = 1
			AND
			InventMovTypeID = 1


OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@IDPreInvMovOld,
	@InventMovTypeID,
	@DocumentID,
	@StoreID,
	@ModelID,
	@BarCodeID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@Discount,
	@IDPessoa,
	@DateEstimatedMov,
	@DateRealMov,
	@QtyRealMov,
	@DesiredMarkup
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		BarCodeID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		IDPessoa,
		DateEstimatedMov,
		DateRealMov,
		QtyRealMov,
		DesiredMarkup
		)
	VALUES
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@QtyRealMov,
		@DesiredMarkup
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	--Atualizar os SaleItemCommisison
	UPDATE
		SaleItemCommission
	SET
		IDPreInventoryMov = @IDPreInventoryMov
	WHERE
		IDPreInventoryMov = @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -207
		GOTO ERRO
	END

	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@IDPreInvMovOld,
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@QtyRealMov,
		@DesiredMarkup
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------------------------------------------------------------*/
/*           Remove os items marcados para o novo PreSale              */
/*---------------------------------------------------------------------*/
DELETE
	PreInventoryMov
WHERE
	DocumentID = @IDPreSale
	AND
	Marked = 1
	AND
	InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

SET @Date = GetDate()

exec sp_PreSale_SubCalcTotal @IDPreSale, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

EXEC sp_PreSale_SubCalcTotal @NewIDPreSale, @Date 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO 
END 

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Split', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubAddItem
	(
	@PreSaleID		int,
	@IDCliente		int,
	@ModelID		int,
	@StoreID		int,
	@UserID			int,
	@IDComission		int,
	@Qty			float,
	@SalePrice		money,
	@CostPrice		money = Null,
	@Discount		money,
	@MovDate		smalldatetime,
	@IDPreInvMovExchange	int,
	@PreInvMovParentID	int,
	@IDDepartment		int,
	@Promo			bit,
	@IDDescriptionPrice	int,
	@IDVendorPrice		int,
	@SuggPrice		int,
	@DocumentNumber		varchar(20),
	@IDDocumentType		int,
	@PreInventMovID		int Output
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insert on Inventory Movement
		- Inserir no Customer Credit
		- Inserir as quantidades para troca

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insert on Inventory Movement
		-203  Erro em Inclusão de Models de PacketModel
		-204  Erro em Inserir no Customer Credit
		-205  Erro em Inserir no Customer Credit do PackModel
		-206  Erro em Inserir as quantidades para troca do PreInvMov
		-207  Erro em Inserir as quantidades para troca InvMov
		-208  Erro em Inserir na SaleItemCommission
		-209  Erro em Inserir na SaleItemCommission referente ao item de Kit
		-210  Erro em Inserir na Inv_MovPrice
		-211  Erro em Inserir na Inv_MovDocument

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCod;
	24 May	2004		André Bogado		Criado Cursor para KitModel;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	01 Dec	2004		Rodrigo Costa		Gravar no Customer Credit;
	01 Feb	2005		Rodrigo Costa		Inclusao do campo @IDPreInvMovExchange;
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInvMov;
	28 Nov	2005		Leonardo Riego		Gravar na SaleItemCommission;
	12 Apr  2006		Leonardo Riego		Novo campo @IDDepartment;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	20 Jul	2007		Maximiliano Muniz	Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
							Inserção na tabeça Inv_MovPrice;
	08 Aug	2007		Maximiliano Muniz	Novos parâmetros @DocumentNumber e @IDDocumentType;
							Inserção na tabeça Inv_MovDocument;
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ComissionID		int
DECLARE @IDMovPrice		int
DECLARE @IDMovDocument		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDSaleItemCommission   int

--Declaração de variáveis para o Cursor de ModelChild
DECLARE @ModelIDChild  	int 
DECLARE @QtyChild  		float
DECLARE @PreInvMovIDPack	int

SET @ErrorLevel = 0

BEGIN TRAN

/*-------------------------------------------------------------*/
/*                  Insert on PreInventory Movement               */
/*-------------------------------------------------------------*/

EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventMovID OUTPUT
INSERT dbo.PreInventoryMov
	(
	IDPreInventoryMov,
	InventMovTypeID,
	IDPessoa,
	DocumentID,
	ModelID,
	StoreID,
	MovDate,
 	Qty,
	SalePrice,
	Discount,
	CostPrice,
	UserID,
	IDPreInvMovExchange,
	IDPreInventoryMovParent,
	IDDepartment,
	Promo,
	DesiredMarkup
	)
	SELECT
		@PreInventMovID,
		1,
		@IDCliente,
 		@PreSaleID,
		@ModelID,
		@StoreID,
		@MovDate,
		@Qty,
		@SalePrice,
 		@Discount,
		IsNull(@CostPrice, (M.VendorCost+M.OtherCost+M.FreightCost)),
		@UserID,
		@IDPreInvMovExchange,
		@PreInvMovParentID,
		@IDDepartment,
		@Promo,
		TG.DesiredMarkup
	FROM
 		dbo.Model M (NOLOCK) 
		JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)
 	WHERE
		M.IDModel = @ModelID

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*****************************************************************************************
	Inclusão do Comissionado na tabela de SaleItemCommission
******************************************************************************************/
EXEC sp_Sis_GetNextCode'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT
INSERT INTO dbo.SaleItemCommission
	(
	 IDSaleItemCommission,
	 IDPreInventoryMov,
	 IDCommission,
	 CommissionPercent
	)
	VALUES
	(
	 @IDSaleItemCommission,
	 @PreInventMovID,
	 @IDComission,
	 100
	)

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*****************************************************************************************
	Inclusão na tabela de Inv_MovPrice
******************************************************************************************/
IF @IDDescriptionPrice <> 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Inv_MovPrice.IDMovPrice', @IDMovPrice OUTPUT
	INSERT INTO Inv_MovPrice
		(
		IDMovPrice,
		IDPreInventoryMov,
		IDInventoryMov,
		IDDescriptionPrice,
		IDVendor,
		SuggPrice
		)
		VALUES
		(
		@IDMovPrice,
		@PreInventMovID,
		NULL,
		@IDDescriptionPrice,
		@IDVendorPrice,
		@SuggPrice
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -210
		GOTO ERRO
	END
END

/*****************************************************************************************
	Inclusão na tabela de Inv_MovDocument
******************************************************************************************/
IF @DocumentNumber <> ''
BEGIN
	EXEC sp_Sis_GetNextCode 'Inv_MovDocument.IDMovDocument', @IDMovDocument OUTPUT
	INSERT INTO Inv_MovDocument
		(
		IDMovDocument,
		IDPreInventoryMov,
		IDInventoryMov,
		DocumentNumber,
		DocumentDate,
		DocumentStatus,
		IDDocumentType,
		OBS
		)
		VALUES
		(
		@IDMovDocument,
		@PreInventMovID,
		NULL,
		@DocumentNumber,
		@MovDate,
		1,
		@IDDocumentType,
		NULL
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -211
		GOTO ERRO
	END
END

/*****************************************************************************************
	Inclusão das quantidades para troca
******************************************************************************************/
IF (@IDPreInvMovExchange IS NOT NULL)
BEGIN
	--Pre Inv Mov
	UPDATE
		PreInventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) + ABS(@Qty)
	WHERE 
		IDPreInventoryMov = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
	
	-- Inv Mov
	UPDATE
		InventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) + ABS(@Qty)
	WHERE 
		PreInventoryMovID = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -207
		GOTO ERRO
	END
END

/*****************************************************************************************
	Inclusão dos Creditos para o modelo caso tenha
******************************************************************************************/
EXEC sp_PreSale_AddModelCredit
			@PreInventMovID,
			@IDCliente,
			@UserID,
			@StoreID,
			@MovDate


SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END
 

/*****************************************************************************************
	Inclusão de Models de PacketModel
******************************************************************************************/

--Declaração do Cursor de ModelChild

DECLARE ModelChild_Cursor CURSOR FOR

	SELECT
		M.IDModel,
		P.Qty
	FROM 
 		dbo.PackModel P (NOLOCK) 
		JOIN dbo.Model M (NOLOCK) ON (P.IDModel= M.IDModel)
 	WHERE
		P.IDPackModel = @ModelID


OPEN ModelChild_Cursor

--Inicialização de ModelChild_Cursor
FETCH NEXT FROM ModelChild_Cursor INTO
	@ModelIDChild,
	@QtyChild

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInvMovIDPack OUTPUT

	INSERT dbo.PreInventoryMov
	(
	IDPreInventoryMov,
	InventMovTypeID,
	IDPessoa,
	DocumentID,
	ModelID,
	StoreID,
	MovDate,
 	Qty,
	SalePrice,
	Discount,
	CostPrice,
	UserID,
	IDParentPack,
	IDDepartment
	)
	SELECT
		@PreInvMovIDPack,
		1,
		@IDCliente,
 		@PreSaleID,
		@ModelIDChild,
		@StoreID,
		@MovDate,
		@Qty * @QtyChild,--Qtde Comprada x Qtde do Kit
		0,
 		0,
		FinalCost,
		@UserID,
		@PreInventMovID,
		@IDDepartment
	FROM
 		dbo.Model (NOLOCK) 
 	WHERE
		dbo.Model.IDModel = @ModelIDChild


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		CLOSE ModelChild_Cursor
		DEALLOCATE ModelChild_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	/*****************************************************************************************
	               Inclusão do Comissionado na tabela de SaleItemCommission
        ******************************************************************************************/
        EXEC sp_Sis_GetNextCode'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT
        INSERT INTO dbo.SaleItemCommission
	(
	 IDSaleItemCommission,
	 IDPreInventoryMov,
	 IDCommission,
	 CommissionPercent
	)
	VALUES
	(
	 @IDSaleItemCommission,
	 @PreInvMovIDPack,
	 @IDComission,
	 100
	)

        SET @SysError = @@ERROR
        IF @SysError <> 0 
        BEGIN
		SET @ErrorLevel = -209
		GOTO ERRO
        END

	/*****************************************************************************************
		Inclusão dos Creditos dos item do pack caso tenha
	******************************************************************************************/
	EXEC sp_PreSale_AddModelCredit
			@PreInvMovIDPack,
			@IDCliente,
			@UserID,
			@StoreID,

			@MovDate


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	--Leitura do Proximo 
	FETCH NEXT FROM ModelChild_Cursor INTO
		@ModelIDChild,
		@QtyChild

END
--fechamento do cursor
CLOSE ModelChild_Cursor

--Destruição do cursor
DEALLOCATE ModelChild_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + ' @ModelID = ' + CAST(@ModelID AS VARCHAR) +  
			' @StoreID = ' + CAST(@StoreID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @IDComission = '  + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
			' @IDPreInvMovExchange = '  + CAST(@IDPreInvMovExchange AS VARCHAR) + 
			' @PreInvMovParentID = '  + CAST(@PreInvMovParentID AS VARCHAR) + 
			' @IDDepartment = '  + CAST(@IDDepartment AS VARCHAR) +  ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubAddItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubRemoveAdditionalExpenses
                                   (
                                   @IDInvoiceCost 	int
                                   )
AS

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO

                        - Remove e recalcula Despesas Adicionais

            TABELA DE ERROS PARA RETURN_VALUE

                         000  Ok
                        -201  Erro em DELETE FROM InvoiceToCostType
                        -202  Erro em UPDATE Invoice SET AditionalExpenses

            LOG DE MODIFICAÇÕES
 

            Data                             Programador                 Modificação
            --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
            28 Sep 2004                 Carlos Lima                  Criação
            ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */


DECLARE @IDPreSale 	int
DECLARE @ErrorLevel  	int
DECLARE @SysError   	int
DECLARE @Amount	Money


SET @ErrorLevel = 0
 
--Grava o valor a ser retirado do invoice
SELECT 
	@IDPreSale = IDPreSale,
	@Amount = Amount
FROM
            InvoiceToCostType (NOLOCK) 
WHERE           
            IDInvoiceCost = @IDInvoiceCost

-- Exclui a despesa Adicional
DELETE FROM 
            InvoiceToCostType
WHERE
            IDInvoiceCost = @IDInvoiceCost
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

 
-- É necessário a atualização de um campo: AditionalExpenses
UPDATE
            Invoice
SET 
            Invoice.AditionalExpenses =  Invoice.AditionalExpenses - @Amount
WHERE
            Invoice.IDPreSale = @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

OK:
            RETURN 0
ERRO:
            PRINT CAST(@ErrorLevel AS VARCHAR)
            DECLARE @ErrorLevelStr varchar(10)
            SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
            EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubRemoveAdditionalExpenses', @ErrorLevelStr
            RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubTestDiscount
	(
	@PreSaleID	int,
	@ModelID	int,
	@UserID		int,
	@Discount	money,
	@Value		money,
	@OP		char(1),
	@PreInventMovID	int = 0
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Find the value of Invoice
		- Find the discount on invoice items
		- Find the Percentual for discount
		- Calcula os novos valores para Invoice e Discount
		- Find the Maximum Discount for invoice Range
		- Test and Return

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Find the value of Invoice
		-202  Erro em Find the discount on invoice items
		-203  Erro em Find the Percentual for discount
		-204  Erro em if @OP = 'I'
		-205  Erro em else if @OP = 'E'
		-206  Erro em else if @OP = 'A'
		-207  Erro em Find the Maximum Discount for invoice Range


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	19 Oct	2006		Leonardo Riego		Foi incluído verificação de teto de porcentagem de desconto por produto e 
							adiconado condição que testa se o desconto esta inferior ao máximo (por item).	
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @MaxDiscount   	money
DECLARE @MaxVendaMin   	money
DECLARE @ValInvoice    	money
DECLARE @NewValInvoice  	money
DECLARE @NewDiscount    	money
DECLARE @ItemDiscount  	money
DECLARE @OldValMov		money
DECLARE @FatParcDisc	money
DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0

/*-------------------------------------------------------*/
/*	             Find the value of Invoice           */
/*-------------------------------------------------------*/
SELECT @ValInvoice =
	(
	SELECT  IsNull(sum(IsNull(PIM.Qty,0) * IsNull(PIM.SalePrice,0) * (IsNull(TG.PrcPartDiscount,0))/100), 0)
		FROM 	
			dbo.PreInventoryMov PIM (NOLOCK) 
			JOIN dbo.Model MO (NOLOCK) ON (PIM.ModelID = MO.IDModel)
			JOIN dbo.TabGroup TG (NOLOCK) ON (MO.GroupID = TG.IDGroup)
	WHERE	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*-------------------------------------------------------*/
/*          Find the discount on invoice items           */
/*-------------------------------------------------------*/
SELECT @ItemDiscount =
	(
	SELECT
	 	IsNull( Sum( IsNull(PIM.Discount,0) ), 0)
	FROM 	
		dbo.PreInventoryMov PIM (NOLOCK) 
	WHERE
	 	PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*-------------------------------------------------------*/
/*	      Find the Percentual for discount           */
/*-------------------------------------------------------*/
SELECT @FatParcDisc =
	(
	SELECT  
		CASE WHEN IsNull(DiscountPerc, 0) <> 0 THEN (DiscountPerc / 100)
		     ELSE(IsNull( TG.PrcPartDiscount,0 ) / 100) END
        
	FROM 	
		dbo.Model MO (NOLOCK) 
		JOIN dbo.TabGroup TG (NOLOCK) ON (MO.GroupID = TG.IDGroup)
	WHERE
		MO.IDModel = @ModelID
	)

PRINT CAST(@ModelID AS VARCHAR)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*-------------------------------------------------------*/
/*    Calcula os novos valores para Invoice e Discount   */
/*-------------------------------------------------------*/
if @OP = 'I'
   begin
	SELECT @NewValInvoice = IsNull(@ValInvoice, 0) + IsNull(@Value * @FatParcDisc, 0)
	SELECT @NewDiscount = IsNull(@Discount, 0) + IsNull(@ItemDiscount, 0)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
   end
else if @OP = 'E'
   begin
	SELECT @NewValInvoice = IsNull(@ValInvoice, 0) - IsNull(@Value * @FatParcDisc, 0)
	SELECT @NewDiscount = IsNull(@ItemDiscount, 0) - IsNull(@Discount, 0)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
   end

else if @OP = 'A'
   begin
	SELECT @NewValInvoice = IsNull(@ValInvoice, 0) + IsNull(@Value * @FatParcDisc, 0) -
					IsNull(
					(
					SELECT 	IsNull( (PIM.SalePrice * PIM.Qty), 0 )
					FROM 	dbo.PreInventoryMov PIM (NOLOCK) 
					WHERE	PIM.IDPreInventoryMov = @PreInventMovID
					) * @FatParcDisc, 0)
	SELECT @NewDiscount = IsNull(@Discount, 0) + IsNull(@ItemDiscount, 0) -
					IsNull(
					(
					SELECT 	IsNull( PIM.Discount, 0 )
					FROM 	dbo.PreInventoryMov PIM (NOLOCK) 
					WHERE	PIM.IDPreInventoryMov = @PreInventMovID
					), 0)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
   end
/*-------------------------------------------------------*/
/*      Find the Maximum Discount for invoice Range      */
/*-------------------------------------------------------*/
SELECT @MaxVendaMin = IsNull(
	(
	SELECT  MAX(DRMax.TotVendaMin)
	FROM   
		dbo.DiscRange DRMax (NOLOCK) 
		JOIN dbo.vwComissionado CO (NOLOCK) ON (DRMax.IDTipoComissionado = CO.IDTipoComissionado)
		JOIN dbo.SystemUser SU (NOLOCK) ON (CO.IDComissionado = SU.ComissionID)
	WHERE
		SU.IDUser = @UserID 
		AND
   		DRMax.TotVendaMin <= IsNull(@NewValInvoice, 0)
	), 0)
SELECT @MaxDiscount = IsNull(
	(
		(
		SELECT 	IsNull(DR.PercDiscMax, 0)

		FROM 	
			dbo.DiscRange DR (NOLOCK) 
			JOIN dbo.vwComissionado  CO (NOLOCK) ON (DR.IDTipoComissionado = CO.IDTipoComissionado)
			JOIN dbo.SystemUser SU (NOLOCK) ON (CO.IDComissionado = SU.ComissionID)
		WHERE
		 	SU.IDUser = @UserID
	 		AND
			DR.TotVendaMin = @MaxVendaMin
		) /100
	) * @NewValInvoice,0)

PRINT CAST(@MaxVendaMin AS VARCHAR) + '  ' + CAST(@NewValInvoice AS VARCHAR) + CAST(@UserID AS VARCHAR) + CAST(@MaxDiscount AS VARCHAR)  

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*-------------------------------------------------------*/
/*                     Test and Return                   */
/*-------------------------------------------------------*/
-- Sempre é possivel incluir um novo item sem desconto
IF (IsNull(@Discount,0) = 0) and (@OP = 'I')
	RETURN 0

IF (IsNull(@NewDiscount, 0) > IsNull(@MaxDiscount, 0))
BEGIN
	IF (IsNull(@MaxDiscount, 0) = 0) AND (IsNull(@Discount, 0) <= (Round(IsNull(@Value, 0) * IsNull(@FatParcDisc, 0), 2) )) AND ((@OP = 'I') or (@OP = 'A'))
		RETURN 0
	ELSE IF (IsNull(@MaxDiscount, 0) = 0) AND (IsNull(@NewDiscount, 0) <= (IsNull(@Value, 0) * IsNull(@FatParcDisc, 0))) AND ((@OP = 'I') or (@OP = 'A'))
		RETURN 0
	ELSE IF (IsNull(@Discount, 0) > IsNull(@MaxDiscount, 0)) and (@OP <> 'E')
		RETURN -2
	ELSE
		RETURN -1
END
ELSE
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubTestDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_TestPayment

		(
		@IDMeioPag int,
		@DifDay int,
		@Value money
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se existe o prazo escolhido

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Testa se existe o prazo escolhido
		-202  Erro em SELECT @MaxValue


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @MaxValue	money
DECLARE @RealDifDay	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/* Testa se existe o prazo escolhido */

SELECT @RealDifDay =
	(
	SELECT
		Min(MeioPagMinSale.DifDay)
	FROM
		dbo.MeioPagMinSale MeioPagMinSale (NOLOCK) 
	WHERE
		MeioPagMinSale.IDMeioPag = @IDMeioPag
		AND
   		IsNull(MeioPagMinSale.DifDay, 0) >= IsNull(@DifDay, 0)
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

if IsNull(@RealDifDay, -10000) = -10000
	return -1


 SELECT @MaxValue =
	(
	SELECT	IsNull(dbo.MeioPagMinSale.TotalSale, 0)
	FROM    dbo.MeioPagMinSale (NOLOCK) 
	WHERE   dbo.MeioPagMinSale.IDMeioPag = @IDMeioPag AND
		dbo.MeioPagMinSale.DifDay =  @RealDifDay
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END 

if @Value >= IsNull(@MaxValue, 0)
	return 0
else
            return 1

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_TestPayment', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_TestRefresh
			(
			@IDPreSale int,
			@RefreshInvoice int output
			)
AS
 /* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	SUMARIO
		
		-

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	27 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	@RefreshInvoice =   CONVERT(int,
			   (
 		 	   SELECT 	RefreshInvoice
 	 		   FROM 	dbo.Invoice (NOLOCK) 
			   WHERE 	dbo.Invoice.IDPreSale = @IDPreSale
 			   ))

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_TestRefresh', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_quPayTypeMin
		(
		@IDMeioPag int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		-

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	DifDay,
	TotalSale
FROM
	dbo.MeioPagMinSale (NOLOCK) 
WHERE 	dbo.MeioPagMinSale.IDMeioPag = @IDMeioPag ORDER BY
	DifDay

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPayTypeMin', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_quPreSaleItem
	(
		@DocumentID	int,
		@IsPreSale	bit,
		@Date		DateTime
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

	- Retorna itens de um determinado PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	15 Aug	2000		Rodrigo Costa		Feito o Join com a Tbl TaxCategory para pegar a tax do Item;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	26 May	2004		Rodrigo Costa		Not display Item Packs;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	21 Oct	2004		Rodrigo Costa		Criado PIM.InventMovTypeID IN (1,25) para mostrar itens cancelados;
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas;
	01 Dez	2005		Leonardo Riego		Modificado para pegar o nome do Comissionado da função;
	17 Apr	2006		Leonardo Riego		Novo campo IDDepartment;
	26 Feb	2007		Rodrigo Costa		Selecionar imposto definido no PreInventoryMov;
	26 Mar	2007		Maic Nogueira		Adicionado o campo "CaseQty" da tabela "Model";
	10 Aug	2007		Maximiliano Muniz	Adicionado o campo "Department" da tabela "Inv_Department";
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel int
DECLARE @SysError int

SET @ErrorLevel = 0

if @IsPreSale = 1
begin
	SELECT
		ModelID,
		M.CaseQty,
		M.Model,
		Description,
		(SELECT dbo.SalesPersonPreInvMov(IDPreInventoryMov)) AS SalesPerson,
		M.SuggRetail,
		SU.IDUser,
		0 as IDComission,
		Qty,
		ExchangeInvoice,
		SalePrice,
		CostPrice,
		Discount,
		PIM.IDPreInventoryMov IDInventoryMov,
		TG.SerialNumber,
		(CASE
			WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0)) THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0))
			ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0))
		END) as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color,
		M.NotVerifyQty,
		PIM.IDDepartment,
		TG.RequestCustomer,
		TG.PuppyTracker,
		PIM.Promo,
		M.SellingPrice,
		PIM.IDPreInventoryMovParent as IDMovParent,
		D.Department
	FROM
		PreInventoryMov PIM (NOLOCK) 
		JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ (NOLOCK) ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL (NOLOCK) ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU (NOLOCK) ON ( SU.IDUser = PIM.UserID )
		JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT OUTER JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
		LEFT OUTER JOIN TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STC.IDSaleTax )
		LEFT OUTER JOIN Inv_Department D (NOLOCK) ON (PIM.IDDepartment = D.IDDepartment)
	WHERE
		PIM.DocumentID  = @DocumentID
		AND PIM.InventMovTypeID IN (1,25) --Sale and Canceled
		AND PIM.IDParentPack Is Null

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
end
else
begin
	SELECT
		ModelID,
		M.CaseQty,
		M.Model,
		Description,
		(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson,
		M.SuggRetail,
		SU.IDUser,
		0 AS IDComission,
		Qty,
		ExchangeInvoice,
		SalePrice,
		CostPrice,
		Discount,
		IM.IDInventoryMov IDInventoryMov,
		TG.SerialNumber,
		IM.SalesTax as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color,
		M.NotVerifyQty,
		IM.IDDepartment,
		TG.RequestCustomer,
		TG.PuppyTracker,
		IM.Promo,
		M.SellingPrice,
		0 as IDMovParent,
		D.Department
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON ( IM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ (NOLOCK) ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL (NOLOCK) ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU (NOLOCK) ON ( SU.IDUser = IM.IDUser )
		JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = IM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory )
		LEFT JOIN Inv_Department D (NOLOCK) ON (IM.IDDepartment = D.IDDepartment)
WHERE
		IM.DocumentID  = @DocumentID
		AND IM.InventMovTypeID = 1
		AND IM.IDParentPack Is Null

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
end

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPreSaleItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_quPreSaleItemSplited
	(
		@DocumentID	int,
		@IsPreSale	bit,
		@Date		DateTime
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna itens de um determinado PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro Criando TempTable
		-202  Erro no 1o select
		-203  Erro no 2o select
		-204  Erro no 1o select
		-205  Erro no 2o select
		-205  Erro no Select Fields

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	27 Oct	2004		Rodrigo Costa		Criacao;
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas;
	01 Jul	2005		Rodrigo Costa		Exibir campo auto incremental do item servico;
	01 Dez	2005		Leonardo Riego		Modificado para pegar o nome do Comissionado da função;
	24 Feb	2006		Maximiliano Muniz	Ordenação dos selects por IDInvMov;
	27 Oct	2006		Rodrigo Costa		Adicionar as colunas de Promo e Model SellingPrice;
	29 Dez	2006		Rodrigo Costa		Criacao do campo CupomFiscal;
	15 Jun	2007		Maximiliano Muniz	Adicionados novos campos (Fabricante e Unidade);
	10 Aug	2007		Maximiliano Muniz	Adicionado novo campo "Departamento";
							Adicionado NOLOCK nos selects;
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

-- Criação e carca da Tabela Temporária e inclusao dos Items
CREATE TABLE #InventoryItems
	(
	IDItem 			int Null,
	IDModel 		int Null,
	IDSalesPerson		int Null,
	IDUser			int Null,
	IDStore			int Null,
	Qty			float Null,
	ExchangeInvoice		int Null,
	SalePrice		Money,
	CostPrice		Money,
	Discount		Money,
	Tax			Money,
	IsDelivered		bit,
	SaleCode		varchar(20),
	InvoiceCode		varchar(20),
	AutoServiceNum		int Null,
	SalesPerson		varchar(50),
	Promo			bit,
	CupomFiscal		varchar(8),
	IDDepartment		int Null
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Inclusao dos item do PreInventoryMov Parent
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson,
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo,
	CupomFiscal,
	IDDepartment
	)
SELECT 
	PIM.IDPreInventoryMov, 
	PIM.ModelID,
	0 AS ComissionID, 
	PIM.UserID,
	PIM.StoreID,
	PIM.Qty, 
	PIM.ExchangeInvoice, 
	PIM.SalePrice,
	PIM.CostPrice, 
	PIM.Discount, 
 	 (CASE WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
		 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END) as Tax, -- Tax
	0,
	I.SaleCode,
	I.InvoiceCode,
	0,
	(SELECT dbo.SalesPersonPreInvMov(PIM.IDPreInventoryMov)) AS SalesPerson,
	PIM.Promo,
	I.CupomFiscal,
	PIM.IDDepartment
FROM 
	PreInventoryMov PIM (NOLOCK)
	JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel )
	JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
	LEFT OUTER JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	LEFT OUTER JOIN TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STC.IDSaleTax )
	JOIN Invoice I (NOLOCK) ON (I.IDPreSale = PIM.DocumentID AND PIM.InventMovTypeID IN (1,25) ) 
WHERE 
	PIM.DocumentID = @DocumentID
	AND PIM.InventMovTypeID IN (1,25) --Sale and Canceled
	AND PIM.IDParentPack Is Null
ORDER BY
	PIM.IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END
	 
-- Inclusao dos PreInventoryMov Splits
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson, 
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo,
	CupomFiscal,
	IDDepartment
	)
SELECT 
	PIM.IDPreInventoryMov, 
	PIM.ModelID,
	0 AS ComissionID, 
	PIM.UserID,
	PIM.StoreID,	PIM.Qty, 
	PIM.ExchangeInvoice, 
	PIM.SalePrice,
	PIM.CostPrice, 
	PIM.Discount, 
 	 (CASE WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
	 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END) as Tax, -- Tax
	0,
	I.SaleCode,
	I.InvoiceCode,
	0,
	(SELECT dbo.SalesPersonPreInvMov(PIM.IDPreInventoryMov)) AS SalesPerson,
	PIM.Promo,
	I.CupomFiscal,
	PIM.IDDepartment
FROM
	PreInventoryMov PIM (NOLOCK)
	JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel)
	JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup)
	JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup)
	LEFT OUTER JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory)
	LEFT OUTER JOIN TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STC.IDSaleTax)
	JOIN Invoice I (NOLOCK) ON (I.IDPreSale = PIM.DocumentID AND PIM.InventMovTypeID IN (1,25))
WHERE
	PIM.DocumentID IN (SELECT IDPreSale FROM Invoice where IDPreSaleParent = @DocumentID)
	AND PIM.InventMovTypeID IN (1,25) --Sale and Canceled
	AND PIM.IDParentPack Is Null
ORDER BY
	PIM.IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

-- Inclusao dos item do InventoryMov Parent
INSERT
	#InventoryItems
	(
	IDItem,
	IDModel,
	IDSalesPerson,
	IDUser,
	IDStore,
	Qty,
	ExchangeInvoice,
	SalePrice,
	CostPrice,
	Discount,
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo,
	CupomFiscal,
	IDDepartment
	)
SELECT
	IM.IDInventoryMov,
	IM.ModelID,
	0 AS ComissionID,
	IM.IDUser,
	IM.StoreID,
	IM.Qty,
	IM.ExchangeInvoice,
	IM.SalePrice,
	IM.CostPrice,
	IM.Discount,
	IM.SalesTax,
	1,
	I.SaleCode,
	I.InvoiceCode,
	IM.SequencyNum,
	(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson,
	IM.Promo,
	I.CupomFiscal,
	IM.IDDepartment
FROM
	InventoryMov IM (NOLOCK)
	JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID IN (1,25))
WHERE
	IM.DocumentID IN (SELECT IDInvoice FROM Invoice (NOLOCK) where IDPreSale = @DocumentID AND IDInvoice IS NOT NULL)
	AND IM.InventMovTypeID = 1
	AND IM.IDParentPack Is Null
ORDER BY
	IM.IDInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

-- Inclusao dos InventoryMov Splits
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson, 
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo,
	CupomFiscal,
	IDDepartment
	)
SELECT
	IM.IDInventoryMov,
	IM.ModelID,
	0 AS ComissionID,
	IM.IDUser,
	IM.StoreID,
	IM.Qty,
	IM.ExchangeInvoice,
	IM.SalePrice,
	IM.CostPrice,
	IM.Discount,
	IM.SalesTax,
	1,
	I.SaleCode,
	I.InvoiceCode,
	IM.SequencyNum,
	(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson,
	IM.Promo,
	I.CupomFiscal,
	IM.IDDepartment
FROM
	InventoryMov IM (NOLOCK)
	JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID IN (1,25))
WHERE
	IM.DocumentID IN (SELECT IDInvoice FROM Invoice (NOLOCK)  where IDPreSaleParent = @DocumentID AND IDInvoice IS NOT NULL)
	AND IM.InventMovTypeID = 1
	AND IM.IDParentPack Is Null
ORDER BY
	IM.IDInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

SELECT
	IM.IDModel as ModelID,
	M.Model,
	M.[Description],
	SalesPerson,
	M.SuggRetail,
	SU.IDUser,
	IM.IDSalesPerson as IDComission,
	IM.Qty,
	IM.ExchangeInvoice,
	IM.SalePrice,
	IM.CostPrice,
	IM.Discount,
	IDItem as IDInventoryMov,
	TG.SerialNumber,
	IM.Tax as Tax,
	SZ.CodSize,
	SZ.SizeName,
	CL.CodColor,
	CL.Color,
	IM.IsDelivered,
	IM.SaleCode,
	IM.InvoiceCode,
	IM.AutoServiceNum,
	IM.Promo,
	M.SellingPrice,
	IM.CupomFiscal,
	F.Pessoa Manufacturer,
	U.Sigla Unit,
	D.Department
FROM
	#InventoryItems IM (NOLOCK)
	JOIN Model M (NOLOCK) ON (IM.IDModel = M.IDModel)
	LEFT OUTER JOIN InvSize SZ (NOLOCK) ON (M.IDSize = SZ.IDSize)
	LEFT OUTER JOIN InvColor CL (NOLOCK) ON (M.IDColor = CL.IDColor)
	JOIN SystemUser SU (NOLOCK) ON (SU.IDUser = IM.IDUser)
	JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
	JOIN StoreToTabGroup STC (NOLOCK) ON (STC.IDStore = IM.IDStore AND STC.IDGroup = TG.IDGroup)
	LEFT JOIN TaxCategory TC (NOLOCK) ON (TC.IDTaxCategory = STC.IDTaxCategory)
	LEFT JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)
	LEFT JOIN Unidade U (NOLOCK) ON (M.IDUnidade = U.IDUnidade)
	LEFT JOIN Inv_Department D (NOLOCK) ON (IM.IDDepartment = D.IDDepartment)
ORDER BY
	D.Department,
	IM.IDItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPreSaleItemSplited', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_quPreSaleParcela
		(
			@PreSaleID	int 
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		-

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 May  2000		Eduardo Costa		suporte ao novo financeiro e suporte a tratamento de erro
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	L.IDLancamento,
	L.IDQuitacaoMeioPrevisto as IDMeioPagPrevisto,
	MP.MeioPag,
 	L.DataVencimento as ExpirationDate ,
	L.ValorNominal as MovValue
FROM
	Fin_Lancamento L (NOLOCK) 
	JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)
WHERE
	L.IDPreSale = @PreSaleID
ORDER BY
	L.DataVencimento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

 OK: 	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPreSaleParcela', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_quPreSaleValue
		(
			@PreSaleID	int
		)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		-

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Select

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	28 Set	2004		Rodrigo Costa		Novo Campo AditionalExpenses;
	11 Apr	2007		Maximiliano Muniz	Novo campo InvoiceDiscount;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	TaxIsent,
	SubTotal ,
	ItemDiscount ,
	I.SpecialPriceID,
	SP.SpecialPrice,
	Tax,
	nOpenUser,
	TaxIsemptValue,
	TaxIsemptItemDiscount,
	AditionalExpenses,
	InvoiceDiscount
FROM
	Invoice I (NOLOCK) 
	LEFT JOIN SpecialPrice SP (NOLOCK) ON (I.SpecialPriceID = SP.IDSpecialPrice)
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPreSaleValue', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_AddPurchaseItemTax
		(
		@IDVendor      		int,
		@IDPurchaseItem	int,
		@IDPurchase		int
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insert on Pur_PurchaseItemTax

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insert on Pur_PurchaseItemTax


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	10 Dec  2000		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel	int
DECLARE @SysError	int

--Declaração de variáveis para o Cursor de PurchaseItem
DECLARE @IDPurchaseItemTax		int 
DECLARE @IDVendorTax  		int
DECLARE @IDTaxCategory  		int

SET @ErrorLevel = 0

BEGIN TRAN


/*****************************************************************************************
	Inclusão dos impostos no item
******************************************************************************************/

--Declaração do Cursor de PurchaseItem

DECLARE PurchaseItem_Cursor CURSOR FOR

	SELECT
		VT.IDVendorTax,
		VT.IDTaxCategory
	FROM
		VendorTax VT (NOLOCK) 
	WHERE
		VT.IDPessoa = @IDVendor


OPEN PurchaseItem_Cursor 

--Inicialização de PurchaseItem_Cursor
FETCH NEXT FROM PurchaseItem_Cursor INTO
	@IDVendorTax,
	@IDTaxCategory

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Pur_PurchaseItemTax.IDPurchaseItemTax', @IDPurchaseItemTax OUTPUT

	INSERT dbo.Pur_PurchaseItemTax
	(
	IDPurchaseItemTax,
	IDPurchaseItem,
	IDVendorTax,
	TaxValue,
	TaxPercentage,
	IDPurchase
	)
	SELECT
		@IDPurchaseItemTax,
		@IDPurchaseItem,
		@IDVendorTax,
		0,
	 	TG.Tax,
		@IDPurchase
	FROM
		TaxCategory TG (NOLOCK) 
	WHERE
		TG.IDTaxCategory = @IDTaxCategory

	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		CLOSE PurchaseItem_Cursor
		DEALLOCATE PurchaseItem_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	--Leitura do Proximo 
	FETCH NEXT FROM PurchaseItem_Cursor INTO
		@IDVendorTax,
		@IDTaxCategory

END
--fechamento do cursor
CLOSE PurchaseItem_Cursor

--Destruição do cursor
DEALLOCATE PurchaseItem_Cursor


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_AddPurchaseItemTax', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_AddPurchaseItemTaxRet
		(		
		@IDPurchaseItem	int
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- Exclui os Pur_PurchaseItemTaxRet para o @IDPurchaseItem
		- Copia os Pur_PurchaseItemTax para Pur_PurchaseItemTaxRet

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Copia os Pur_PurchaseItemTax para Pur_PurchaseItemTaxRet
		-202  Erro em Exclui os Pur_PurchaseItemTaxRet para o @IDPurchaseItem


	LOG DE MODIFICA??ES

	Data			Programador		Modifica??o
	----------------------- ----------------------- -------------------------------------------------------------------------------------------------------------------------------------------------
	10 Mar  2005		Carlos Lima		Criacao;
	----------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel	int
DECLARE @SysError	int

--Declara??o de vari?veis para o Cursor de PurchaseItemTaxRet
DECLARE @IDPurchaseItemTaxRet	int
DECLARE @IDVendorTax		int
DECLARE @TaxValue		money
DECLARE @TaxPercentage		money
DECLARE @IDPurchase		int

SET @ErrorLevel = 0

BEGIN TRAN


/*****************************************************************************************
	Exclui os Pur_PurchaseItemTaxRet para o @IDPurchaseItem
******************************************************************************************/
DELETE	Pur_PurchaseItemTaxRet
WHERE
	IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END




/*****************************************************************************************
	Copia os Pur_PurchaseItemTax para Pur_PurchaseItemTaxRet
******************************************************************************************/

--Declara??o do Cursor de PurchaseItemTax

DECLARE PurchaseItemTaxRet_Cursor CURSOR FOR

	SELECT
		IDVendorTax,
		0 as TaxValue,
		TaxPercentage,
		IDPurchase
	FROM
		Pur_PurchaseItemTax (NOLOCK) 
	WHERE
		IDPurchaseItem = @IDPurchaseItem


OPEN PurchaseItemTaxRet_Cursor

--Inicializa??o de PurchaseItemTax_Cursor
FETCH NEXT FROM PurchaseItemTaxRet_Cursor INTO
	@IDVendorTax,
	@TaxValue,
	@TaxPercentage,
	@IDPurchase

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Pur_PurchaseItemTaxRet.IDPurchaseItemTaxRet', @IDPurchaseItemTaxRet OUTPUT

	INSERT dbo.Pur_PurchaseItemTaxRet
	(
		IDPurchaseItemTaxRet,
		IDVendorTax,
		TaxValue,
		TaxPercentage,
		IDPurchase,
		IDPurchaseItem

	)
	VALUES
	(
		@IDPurchaseItemTaxRet,
		@IDVendorTax,
		@TaxValue,
		@TaxPercentage,
		@IDPurchase,
		@IDPurchaseItem
	)


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		CLOSE PurchaseItemTax_Cursor
		DEALLOCATE PurchaseItemTax_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	--Leitura do Proximo 
	FETCH NEXT FROM PurchaseItemTaxRet_Cursor INTO
		@IDVendorTax,
		@TaxValue,
		@TaxPercentage,
		@IDPurchase

END
--fechamento do cursor
CLOSE PurchaseItemTaxRet_Cursor

--Destrui??o do cursor
DEALLOCATE PurchaseItemTaxRet_Cursor


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_AddPurchaseItemTaxRet', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_Purchase_AtuPurchaseSubTotal
	(
	@IDPurchase	int,
	@TaxInCost	bit
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste se ja existe a tabela de SubTotal
		- Atualizo o SubTotal do Purchase

	OBS
		Devido a um BUG do BDE, tenho que guardar o total do purchase em uma tabela separada,
		espero um dia, quando o bug for resolvido, voltar ao código original e remover a tabela desnecessaria.

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Teste se o purchase ja esta na tabela
		-202  Erro em Atualizo o SubTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 Dec	2000		Eduardo Costa		Criação;
	26 Jun	2001		Davi Gouveia		Log de Return Values
	18 Aug	2004		Rodrigo Costa		Gravar error log
	05 Jan	2005		Rodrigo Costa		Somar os impostos totais que tem a opcao adcionar
	22 Mar	2006		Maximiliano Muniz	Somar os fretes totais
	03 Aug  2006		Leonardo Riego		Soma do valor total do Purchase não é feita direto na tabela de itens. 
							(Quando o Purchase não tinha mais itens o retorno do select era nulo)
							(o que gerava erro no Purchase com valor no SubTotal sem itens )	
	24 Aug	2007		Rodrigo Costa		Estava somando o campo de custo errado no total da compra.
							Somando NewCostPrice * Qty ... tinha que somar o CostPrice
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @TaxTotal		float
DECLARE @TaxTotalRet		float

SET @ErrorLevel = 0

BEGIN TRAN


------------------------------------------------------------------------------
-- Teste se o purchase ja esta na tabela

IF NOT EXISTS (SELECT SubTotal FROM Pur_PurchaseTotal (NOLOCK)  WHERE IDPurchase = @IDPurchase)
	INSERT Pur_PurchaseTotal (IDPurchase, SubTotal, SubTotalRet) VALUES (@IDPurchase, 0, 0)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Atualizo o SubTotal
IF (@TaxInCost=1)
BEGIN

	--Somar os impostos totais que tem a opcao adcionar
	
	SELECT 
		@TaxTotal = SUM(IsNull(PIT.TaxValue,0))
	FROM 
		Pur_PurchaseItemTax PIT (NOLOCK) 
		LEFT OUTER JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax)
		LEFT OUTER JOIN TaxCategory CT (NOLOCK) ON (CT.IDTaxCategory = VT.IDTaxCategory)
	WHERE
		PIT.IDPurchase = @IDPurchase
		AND
		CT.Debit = 0

	--Somar os impostos totais que tem a opcao adcionar de Retorno
	SELECT 
		@TaxTotalRet = SUM(IsNull(PIT.TaxValue,0))
	FROM 
		Pur_PurchaseItemTaxRet PIT (NOLOCK) 
		LEFT OUTER JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax)
		LEFT OUTER JOIN TaxCategory CT (NOLOCK) ON (CT.IDTaxCategory = VT.IDTaxCategory)
	WHERE
		PIT.IDPurchase = @IDPurchase
		AND
		CT.Debit = 0

	
	UPDATE
		P
	SET
		P.SubTotal = (PT.SubTotal + IsNull(@TaxTotal,0)),
		P.SubTotalRet = (PT.SubTotalRet + IsNull(@TaxTotalRet,0))
	FROM
		Pur_PurchaseTotal P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
		JOIN (
			SELECT
				PU.IDPurchase,
				SUM(IsNull(PPI.CostPrice,0)) as SubTotal,
				SUM(IsNull(PPI.CostPriceRet,0)) as SubTotalRet
			FROM
				Pur_Purchase PU (NOLOCK) 
				LEFT JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
			WHERE
				PU.IDPurchase = @IDPurchase
			GROUP BY
				PU.IDPurchase
		) as PT ON (P.IDPurchase = PT.IDPurchase)


	UPDATE
		P
	SET
		P.Freight = PT.Freight,
		P.OtherCharges = PT.Other,
		P.FreightRet = PT.FreightRet,
		P.OtherChargesRet = PT.OtherRet	FROM
		Pur_Purchase P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
		JOIN (
			SELECT
				PPI.IDPurchase,
				SUM(IsNull(PPI.FreightCost, 0)) as Freight,
				SUM(IsNull(PPI.OtherCost, 0)) as Other,
				SUM(IsNull(PPI.FreightCostRet, 0)) as FreightRet,
				SUM(IsNull(PPI.OtherCostret, 0)) as OtherRet
			FROM
				Pur_PurchaseItem PPI (NOLOCK) 
			WHERE
				PPI.IDPurchase = @IDPurchase
			GROUP BY
				PPI.IDPurchase
		) as PT ON (P.IDPurchase = PT.IDPurchase)

END
ELSE

BEGIN
	UPDATE
		P
	SET
		P.SubTotal = PT.SubTotal,
		P.SubTotalRet = PT.SubTotalRet 
	FROM
		Pur_PurchaseTotal P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
		JOIN (
	
			SELECT
				PU.IDPurchase,
				SUM(IsNull(PPI.NewCostPrice * PPI.Qty, 0)) as SubTotal,
				SUM(IsNull(PPI.NewCostPriceRet * PPI.Qty, 0)) as SubTotalRet
			FROM
				Pur_Purchase PU (NOLOCK) 
				LEFT JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
			WHERE
				PU.IDPurchase = @IDPurchase
			GROUP BY
				PU.IDPurchase
	
		) as PT ON (P.IDPurchase = PT.IDPurchase)
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END



OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_AtuPurchaseSubTotal', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_CriaPagamento
	(
	@IDPurchase	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo as informacoes dos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em update os lancamentos anteriores
		-202  Erro em incluo o lancamento Parent
		-203  Erro Preenchando valores default
		-204  Erro em incluo o lancamento Disbursement SubTotal
		-205  Erro em incluo o lancamento Disbursement Freight


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	--------------------------------------------------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	13 May	2002		Rodrigo Costa		Inserir Lancamentos com Disbursements
	28 Oct	2003		Rodrigo Costa		Create sp_GetNexCode
	18 Aug	2004		Rodrigo Costa		Gravar error log
	21 Feb	2006		Maximiliano Muniz	Inserir lançamentos com base na Pur_PurchaseDueDate
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamentoParent	int
DECLARE @SubTotal		money
DECLARE @Freight		money
DECLARE @CriaDisbur		int

--Declaração de variáveis para o Cursor de Fin_Lancamento
DECLARE @Pagando		bit
DECLARE @IDLancamentoTipo	int
DECLARE @DataLancamento		smalldatetime
DECLARE @IDUsuarioLancamento	int
DECLARE @Previsao		bit
DECLARE @Situacao		int
DECLARE @IDPessoaTipo 		int 
DECLARE @IDPessoa		int
DECLARE @IDEmpresa		int
DECLARE @DataVencimento		smalldatetime
DECLARE @DataEmissao		datetime
DECLARE @IDDocumentoTipo	int
DECLARE @ValorNominal		money
DECLARE @NumDocumento 		varchar(20)
DECLARE @IDMoeda		int
DECLARE @IDMoedaCotacao		int
DECLARE @LancamentoType		int
DECLARE @IDLancamento		int
DECLARE @IDPurchaseDueDate	int

SET @ErrorLevel = 0
SET @CriaDisbur = 0

IF EXISTS (SELECT IDLancamento FROM Fin_Lancamento WHERE IDPurchase = @IDPurchase)
BEGIN
	-- Atualizo as informacoes do Lancamento Parent
	UPDATE
		L
	SET
		L.DataVencimento = PDD.Date,
		L.DataEmissao = P.DocumentDate,
		L.NumDocumento = P.DocumentNumber,
		L.ValorNominal = PDD.Amount + ((PDD.Amount/PT.SubTotal)*IsNull(P.Freight, 0)) + ((PDD.Amount/PT.SubTotal)*IsNull(P.OtherCharges, 0)),
		L.IDPessoa = P.IDFornecedor,
		L.DataLancamento =IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		L.IDUsuarioLancamento = IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving)
	FROM
		Fin_Lancamento L (NOLOCK) 
		JOIN Pur_Purchase P (NOLOCK) ON (L.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseTotal PT (NOLOCK) ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD (NOLOCK) ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		L.LancamentoType <> 2 -- Diferente de LancamentoFilho

	-- Atualizo as informacoes do Lancamento Filho
	UPDATE
		L
	SET
		L.DataVencimento = PDD.Date,
		L.DataEmissao = P.DocumentDate,
		L.NumDocumento = P.DocumentNumber,
		L.ValorNominal = PDD.Amount,
		L.IDPessoa = P.IDFornecedor,
		L.DataLancamento =IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		L.IDUsuarioLancamento = IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving)
	FROM
		Fin_Lancamento L (NOLOCK) 
		JOIN Pur_Purchase P (NOLOCK) ON (L.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseTotal PT (NOLOCK) ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD (NOLOCK) ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		L.LancamentoType = 2 -- Lancamento Filho primeira parcela
		AND
		L.NumeroDuplicata = '1/2'


	-- Atualizo as informacoes do Lancamento Filho
	UPDATE
		L
	SET
		L.DataVencimento = PDD.Date,
		L.DataEmissao = P.DocumentDate,
		L.NumDocumento = P.DocumentNumber,
		L.ValorNominal = ((PDD.Amount/PT.SubTotal)*IsNull(P.Freight, 0)) + ((PDD.Amount/PT.SubTotal)*IsNull(P.OtherCharges, 0)),
		L.IDPessoa = P.IDFornecedor,
		L.DataLancamento =IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		L.IDUsuarioLancamento = IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving)
	FROM
		Fin_Lancamento L (NOLOCK) 
		JOIN Pur_Purchase P (NOLOCK) ON (L.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseTotal PT (NOLOCK) ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD (NOLOCK) ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		L.LancamentoType = 2 -- Lancamento Filho segunda parcela
		AND
		L.NumeroDuplicata = '2/2'

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
END
ELSE
BEGIN
	-- Incluo o lancamento parent
	--Declaração do Cursor de Fin_Lancamento
	DECLARE Fin_Lancamento_Cursor CURSOR FOR
	
		SELECT
			1,
			7,  -- Cost of Good ## Davi
			IsNull(P.DateFinalReceiving, P.DatePreReceiving),
			IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving),
			1,  -- Nao approvado
			1,  -- Aberto
			2,  -- Vendor
			P.IDFornecedor,
			S.IDEmpresa,
			PDD.Date,
			P.DocumentDate,
			1002,  -- Vendor Invoice
			PDD.Amount + ((PDD.Amount/PT.SubTotal)*IsNull(P.Freight, 0)) + ((PDD.Amount/PT.SubTotal)*IsNull(P.OtherCharges, 0)),
			P.DocumentNumber,
			P.IDPurchase,
			PDD.IDPurchaseDueDate,
			4, -- Dollar
			6, -- Cotacao Default - Dollar
			1  -- Lancamento Parent
		FROM 
			Pur_Purchase P (NOLOCK) 
			JOIN Pur_PurchaseTotal PT (NOLOCK)  ON (PT.IDPurchase = P.IDPurchase)
			JOIN Store S (NOLOCK) ON (P.IDStore = S.IDStore)
			JOIN Pur_PurchaseDueDate PDD (NOLOCK) ON (PDD.IDPurchase = P.IDPurchase)
		WHERE
			P.IDPurchase = @IDPurchase
			AND
			DocumentType = 'Invoice'

	OPEN Fin_Lancamento_Cursor
	
	--Inicialização de Fin_Lancamento_Cursor
	FETCH NEXT FROM Fin_Lancamento_Cursor INTO
		@Pagando,
		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDPurchaseDueDate,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
		INSERT Fin_Lancamento(
			IDLancamento,
			Pagando,
			IDLancamentoTipo,
			DataLancamento,
			IDUsuarioLancamento,
			Previsao,
			Situacao,
			IDPessoaTipo,
			IDPessoa,
			IDEmpresa,
			DataVencimento,
			DataEmissao,
			IDDocumentoTipo,
			ValorNominal,
			NumDocumento,
			IDPurchase,
			IDMoeda,
			IDMoedaCotacao,
			LancamentoType
			)
		VALUES 
			(
			@IDLancamento,
			@Pagando,
			@IDLancamentoTipo,
			@DataLancamento,
			@IDUsuarioLancamento,
			@Previsao,
			@Situacao,
			@IDPessoaTipo,
			@IDPessoa,
			@IDEmpresa,
			@DataVencimento,
			@DataEmissao,
			@IDDocumentoTipo,
			@ValorNominal,
			@NumDocumento,
			@IDPurchase,
			@IDMoeda,
			@IDMoedaCotacao,
			@LancamentoType	
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Fin_Lancamento_Cursor
			DEALLOCATE Fin_Lancamento_Cursor
			SET @ErrorLevel = -202
			GOTO ERRO
		END

		--Pega o IDLancamento do Pararent e os Valores para criar os disbursement
		SELECT 
			@IDLancamentoParent = @IDLancamento,
			@SubTotal = PDD.Amount,
			@Freight = ((PDD.Amount/PT.SubTotal)*IsNull(P.Freight, 0)) + ((PDD.Amount/PT.SubTotal)*IsNull(P.OtherCharges, 0)),
			@CriaDisbur = 1,
			@IDLancamentoTipo = 7 -- Cost of Good ## Davi
		FROM
			Pur_Purchase P (NOLOCK) 
			JOIN Pur_PurchaseTotal PT (NOLOCK) ON (PT.IDPurchase = P.IDPurchase)
			JOIN Pur_PurchaseDueDate PDD (NOLOCK) ON (PDD.IDPurchase = P.IDPurchase)
		WHERE
			P.IDPurchase = @IDPurchase
			AND
			P.DocumentType = 'Invoice'
			AND
			PDD.IDPurchaseDueDate = @IDPurchaseDueDate
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -203
			GOTO ERRO
		END

		IF (@CriaDisbur = 1)
		BEGIN
			--Cria desdobramento do Sub Total
			EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @SubTotal, '1/2', @IDLancamentoTipo

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				SET @ErrorLevel = -204
				GOTO ERRO
			END

			--Cria desdobramento do Freight
			IF @Freight <> 0
			BEGIN
				EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @Freight, '2/2', @IDLancamentoTipo

				SET @SysError = @@ERROR
				IF @SysError <> 0
				BEGIN
					SET @ErrorLevel = -205
					GOTO ERRO
				END
			END
		END

		FETCH NEXT FROM Fin_Lancamento_Cursor INTO
			@Pagando,
			@IDLancamentoTipo,
			@DataLancamento,
			@IDUsuarioLancamento,
			@Previsao,
			@Situacao,
			@IDPessoaTipo,
			@IDPessoa,
			@IDEmpresa,
			@DataVencimento,
			@DataEmissao,
			@IDDocumentoTipo,
			@ValorNominal,
			@NumDocumento,
			@IDPurchase,
			@IDPurchaseDueDate,
			@IDMoeda,
			@IDMoedaCotacao,
			@LancamentoType
	END
	--fechamento do cursor
	CLOSE Fin_Lancamento_Cursor
	--Destruição do cursor
	DEALLOCATE Fin_Lancamento_Cursor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_CriaPagamento', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_CriaPagamentoComImposto
	(
	@IDPurchase	int
	)
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deletar os lancamentos se precisar
		- Inserir as informacoes dos lancamentos
		- Inserir os desdobramentos nos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deletar os lancamentos anteriores
		-202  Erro em incluo o lancamento Parent
		-203  Erro Preenchando valores default
		-204  Erro em incluo o lancamento Disbursement SubTotal
		-205  Erro em incluo o lancamento Disbursement Freight
		-206  Erro em incluo os lancamentos Disbursement Impostos

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	24 Dez	2004		Rodrigo Costa		Criacao;
	22 Feb	2006		Maximiliano Muniz	Inserir lançamentos com base na Pur_PurchaseDueDate
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamentoParent	int
DECLARE @SubTotal		money
DECLARE @PercSubTotal		float
DECLARE @Freight		money
DECLARE @CriaDisbur		int

--Declaração de variáveis para o Cursor de Fin_Lancamento
DECLARE @Pagando		bit
DECLARE @IDLancamentoTipo	int 
DECLARE @DataLancamento		smalldatetime 
DECLARE @IDUsuarioLancamento	int 
DECLARE @Previsao		bit 
DECLARE @Situacao		int 
DECLARE @IDPessoaTipo		int 
DECLARE @IDPessoa		int 
DECLARE @IDEmpresa		int 
DECLARE @DataVencimento		smalldatetime 
DECLARE @DataEmissao		datetime 
DECLARE @IDDocumentoTipo	int 
DECLARE @ValorNominal		money 
DECLARE @NumDocumento		varchar(20)
DECLARE @IDMoeda		int 
DECLARE @IDMoedaCotacao		int 
DECLARE @LancamentoType		int 
DECLARE @IDLancamento		int
DECLARE @TotalDesdobramento	int
DECLARE @NumDesdobramento	varchar(10)
DECLARE @CountImposto		int
DECLARE @TotalImposto		money
DECLARE @IDPurchaseDueDate	int

SET @ErrorLevel = 0
SET @CriaDisbur = 0

-- Deleto os Lancamentos Filhos
DELETE 
FROM 
	Fin_Lancamento  
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Incluo o lancamento parent
--Declaração do Cursor de Fin_Lancamento
DECLARE Fin_Lancamento_Cursor CURSOR FOR
	
	SELECT
		1,
		7,  -- Cost of Good ## Davi
		IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving),
		1,  -- Nao approvado
		1,  -- Aberto
		2,  -- Vendor
		P.IDFornecedor,
		S.IDEmpresa,
		PDD.Date,
		P.DocumentDate,
		1002,  -- Vendor Invoice
		PDD.Amount, -- + ((PDD.Amount/IsNull(PT.SubTotal, 0))*IsNull(P.Freight, 0)) + ((PDD.Amount/IsNull(PT.SubTotal, 0))*IsNull(P.OtherCharges, 0)),
		P.DocumentNumber,
		P.IDPurchase,
		PDD.IDPurchaseDueDate,
		4, -- Dollar
		6, -- Cotacao Default - Dollar
		1  -- Lancamento Parent
	FROM
		Pur_Purchase P (NOLOCK) 
		JOIN Pur_PurchaseTotal PT (NOLOCK) ON (PT.IDPurchase = P.IDPurchase)
		JOIN Store S (NOLOCK) ON (P.IDStore = S.IDStore)
		JOIN Pur_PurchaseDueDate PDD (NOLOCK) ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		DocumentType = 'Invoice'
	
	
OPEN Fin_Lancamento_Cursor
	
--Inicialização de Fin_Lancamento_Cursor
FETCH NEXT FROM Fin_Lancamento_Cursor INTO
	@Pagando,
	@IDLancamentoTipo,
	@DataLancamento,
	@IDUsuarioLancamento,
	@Previsao,
	@Situacao,
	@IDPessoaTipo,
	@IDPessoa,
	@IDEmpresa,
	@DataVencimento,
	@DataEmissao,
	@IDDocumentoTipo,
	@ValorNominal,
	@NumDocumento,
	@IDPurchase,
	@IDPurchaseDueDate,
	@IDMoeda,
	@IDMoedaCotacao,
	@LancamentoType
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
	INSERT Fin_Lancamento(
		IDLancamento,
		Pagando,
		IDLancamentoTipo,
		DataLancamento,
		IDUsuarioLancamento,
		Previsao,
		Situacao,
		IDPessoaTipo,
		IDPessoa,
		IDEmpresa,
		DataVencimento,
		DataEmissao,
		IDDocumentoTipo,
		ValorNominal,
		NumDocumento,
		IDPurchase,
		IDMoeda,
		IDMoedaCotacao,
		LancamentoType
		)
	VALUES 
		(
		@IDLancamento,
		@Pagando,
		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType	
		)

		SET @SysError = @@ERROR
		IF @SysError <> 0
			BEGIN
				CLOSE Fin_Lancamento_Cursor
				DEALLOCATE Fin_Lancamento_Cursor
				SET @ErrorLevel = -202
				GOTO ERRO
			END

-------------------------------------------------------------------------------------------------------------------------
	--Contar total de parcelas
	--@TotalDesdobramento
	SELECT 
		@TotalDesdobramento = COUNT (*)
	FROM 
		Pur_PurchaseDueDate PDD
	WHERE
		PDD.IDPurchase = @IDPurchase

	-- Pega o IDLancamento do Pararent e os Valores para criar os disbursement frete
	SELECT 
		@IDLancamentoParent = @IDLancamento,
		@PercSubTotal = ((PDD.Amount/(IsNull(PT.SubTotal, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*100),
		@SubTotal = PDD.Amount -
				(((PDD.Amount/(IsNull(PT.SubTotal, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*IsNull(P.Freight, 0))+
				((PDD.Amount/(IsNull(PT.SubTotal, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*IsNull(P.Freight, 0))),
		@Freight = (((PDD.Amount/(IsNull(PT.SubTotal, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*IsNull(P.Freight, 0))+
				((PDD.Amount/(IsNull(PT.SubTotal, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*IsNull(P.Freight, 0))),
		@CriaDisbur = 1,
		@IDLancamentoTipo = 7 -- Cost of Good ## Davi
	FROM
		Pur_Purchase P (NOLOCK) 
		JOIN Pur_PurchaseTotal PT (NOLOCK) ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD (NOLOCK) ON (P.IDPurchase = PDD.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		P.DocumentType = 'Invoice'
		AND
		PDD.IDPurchaseDueDate = @IDPurchaseDueDate

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	
	IF (@CriaDisbur = 1)
	BEGIN
		--Descubro o total dos impostos para diminuir com o da fatura
		SELECT 
			@TotalImposto = IsNull(SUM(ABS(IsNull(PIT.TaxValue,0))),0)
		FROM 
			Pur_PurchaseItemTax PIT
		WHERE
			PIT.IDPurchase = @IDPurchase

		SET @TotalImposto = (@SubTotal - ((@PercSubTotal/100)*@TotalImposto))

		--Cria desdobramento do Sub Total
		SET @NumDesdobramento = '1/'+Convert(VarChar(10),@TotalDesdobramento)
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @TotalImposto, @NumDesdobramento, @IDLancamentoTipo
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		--Cria desdobramento do Freight
		SET @NumDesdobramento = '2/'+Convert(VarChar(10),@TotalDesdobramento)
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @Freight, @NumDesdobramento, @IDLancamentoTipo

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -205
			GOTO ERRO
		END

		--Setar o contador para os desdobramentos de impostos
		SET @CountImposto = 3

		--Cursor para impostos
		--Declaração do Cursor de Purchase_ItemTax_Cursor
		DECLARE Purchase_ItemTax_Cursor CURSOR FOR

			SELECT
				CT.IDLancamentoTipo,
				((@PercSubTotal/100)*IsNull(SUM(ABS(IsNull(PIT.TaxValue,0))),0)) as Value
			FROM
				Pur_PurchaseItemTax PIT (NOLOCK) 
				LEFT OUTER JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax)
				LEFT OUTER JOIN TaxCategory CT (NOLOCK) ON (CT.IDTaxCategory = VT.IDTaxCategory)
			WHERE
				PIT.IDPurchase = @IDPurchase
			GROUP BY
				CT.IDLancamentoTipo,
				PIT.IDVendorTax 		
		
		OPEN Purchase_ItemTax_Cursor

		--Inicialização de Purchase_ItemTax_Cursor
		FETCH NEXT FROM Purchase_ItemTax_Cursor INTO
			@IDLancamentoTipo,
			@ValorNominal
		--Enquanto tem registros
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--Cria desdobramento dos impostos
			SET @NumDesdobramento = Convert(VarChar(10),@CountImposto)+'/'+Convert(VarChar(10),@TotalDesdobramento)
			EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @ValorNominal, @NumDesdobramento, @IDLancamentoTipo
			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				SET @ErrorLevel = -206
				GOTO ERRO
			END

			--Incrementar o desdobramento
			SET @CountImposto = @CountImposto + 1

		FETCH NEXT FROM Purchase_ItemTax_Cursor INTO
				@IDLancamentoTipo,
				@ValorNominal
		END
		--fechamento do cursor
		CLOSE Purchase_ItemTax_Cursor
		--Destruição do cursor
		DEALLOCATE Purchase_ItemTax_Cursor

END
-------------------------------------------------------------------------------------------------------------------------

FETCH NEXT FROM Fin_Lancamento_Cursor INTO
		@Pagando,
		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDPurchaseDueDate,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType
END
--fechamento do cursor
CLOSE Fin_Lancamento_Cursor
--Destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_CriaPagamentoComImposto', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_CriaPagamentoComImpostoRet
	(
	@IDPurchase	int
	)
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Inserir as informacoes dos lancamentos
		- Inserir os desdobramentos nos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-202  Erro em incluo o lancamento Parent
		-203  Erro Preenchando valores default
		-204  Erro em incluo o lancamento Disbursement SubTotal
		-205  Erro em incluo o lancamento Disbursement Freight
		-206  Erro em incluo os lancamentos Disbursement Impostos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	14 Mar 	2005		Carlos Lima		Criação
	22 Feb	2006		Maximiliano Muniz	Inserir lançamentos com base na Pur_PurchaseDueDate
    	-----------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamentoParent	int
DECLARE @SubTotal		money
DECLARE @PercSubTotal		money
DECLARE @Freight		money
DECLARE @CriaDisbur		int

--Declaração de variáveis para o Cursor de Fin_Lancamento
DECLARE @Pagando		bit
DECLARE @IDLancamentoTipo	int
DECLARE @DataLancamento		smalldatetime
DECLARE @IDUsuarioLancamento	int
DECLARE @Previsao		bit
DECLARE @Situacao		int
DECLARE @IDPessoaTipo		int
DECLARE @IDPessoa		int
DECLARE @IDEmpresa		int
DECLARE @DataVencimento		smalldatetime
DECLARE @DataEmissao		datetime
DECLARE @IDDocumentoTipo	int
DECLARE @ValorNominal		money
DECLARE @NumDocumento		varchar(20)
DECLARE @IDMoeda		int
DECLARE @IDMoedaCotacao		int
DECLARE @LancamentoType		int
DECLARE @IDLancamento		int
DECLARE @TotalDesdobramento	int
DECLARE @NumDesdobramento	varchar(10)
DECLARE @CountImposto		int
DECLARE @TotalImposto		money
DECLARE @IDPurchaseDueDate	int

SET @ErrorLevel = 0
SET @CriaDisbur = 0

-- Incluo o lancamento parent
--Declaração do Cursor de Fin_Lancamento
DECLARE Fin_Lancamento_Cursor CURSOR FOR	
	SELECT
		1,
		7,  -- Cost of Good ## Davi
		IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving),
		1,  -- Nao approvado
		1,  -- Aberto
		2,  -- Vendor
		P.IDFornecedor,
		S.IDEmpresa,
		P.DocumentDueDate,
		P.DocumentDate,
		1002,  -- Vendor Invoice
		(IsNull(PT.SubTotalRet, 0) + IsNull(P.FreightRet, 0) + IsNull(P.OtherChargesRet, 0)) * -1,
		P.DocumentNumberRet,
		P.IDPurchase,
		PDD.IDPurchaseDueDate,
		4, -- Dollar
		6, -- Cotacao Default - Dollar
		1  -- Lancamento Parent
	FROM
		Pur_Purchase P (NOLOCK) 
		JOIN Pur_PurchaseTotal PT (NOLOCK) ON (PT.IDPurchase = P.IDPurchase)
		JOIN Store S (NOLOCK) ON (P.IDStore = S.IDStore)
		JOIN Pur_PurchaseDueDate PDD (NOLOCK) ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		DocumentType = 'Invoice'
	
	
OPEN Fin_Lancamento_Cursor
	
--Inicialização de Fin_Lancamento_Cursor
FETCH NEXT FROM Fin_Lancamento_Cursor INTO
	@Pagando,
	@IDLancamentoTipo,
	@DataLancamento,
	@IDUsuarioLancamento,
	@Previsao,
	@Situacao,
	@IDPessoaTipo,
	@IDPessoa,
	@IDEmpresa,
	@DataVencimento,
	@DataEmissao,
	@IDDocumentoTipo,
	@ValorNominal,
	@NumDocumento,
	@IDPurchase,
	@IDPurchaseDueDate,
	@IDMoeda,
	@IDMoedaCotacao,
	@LancamentoType
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
	INSERT Fin_Lancamento(
		IDLancamento,
		Pagando,
		IDLancamentoTipo,
		DataLancamento,
		IDUsuarioLancamento,
		Previsao,
		Situacao,
		IDPessoaTipo,
		IDPessoa,
		IDEmpresa,
		DataVencimento,
		DataEmissao,
		IDDocumentoTipo,
		ValorNominal,
		NumDocumento,
		IDPurchase,
		IDMoeda,
		IDMoedaCotacao,
		LancamentoType
		)
	VALUES 
		(
		@IDLancamento,
		@Pagando,

		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType	
		)

		SET @SysError = @@ERROR
		IF @SysError <> 0
			BEGIN
				CLOSE Fin_Lancamento_Cursor
				DEALLOCATE Fin_Lancamento_Cursor
				SET @ErrorLevel = -202
				GOTO ERRO
			END

-------------------------------------------------------------------------------------------------------------------------	
	--Contar total de parcelas
	--@TotalDesdobramento
	SELECT 
		@TotalDesdobramento = COUNT (*)
	FROM 
		Pur_PurchaseDueDate PDD
	WHERE
		PDD.IDPurchase = @IDPurchase

	--Pega o IDLancamento do Pararent e os Valores para criar os disbursement frete
	SELECT 
		@IDLancamentoParent = @IDLancamento,
		@PercSubTotal = ((PDD.Amount/(IsNull(PT.SubTotalRet, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*100),
		@SubTotal = PDD.Amount -
				(((PDD.Amount/(IsNull(PT.SubTotalRet, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*IsNull(P.Freight, 0))+
				((PDD.Amount/(IsNull(PT.SubTotalRet, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*IsNull(P.Freight, 0))),
		@Freight = (((PDD.Amount/(IsNull(PT.SubTotalRet, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*IsNull(P.Freight, 0))+
				((PDD.Amount/(IsNull(PT.SubTotalRet, 0)+IsNull(P.Freight, 0)+IsNull(P.OtherCharges, 0)))*IsNull(P.Freight, 0))),
		@CriaDisbur = 1,
		@IDLancamentoTipo = 7 -- Cost of Good ## Davi
	FROM
		Pur_Purchase P (NOLOCK) 
		JOIN Pur_PurchaseTotal PT (NOLOCK) ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD (NOLOCK) ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		P.DocumentType = 'Invoice'
		AND
		PDD.IDPurchaseDueDate = @IDPurchaseDueDate

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	IF (@CriaDisbur = 1)
	BEGIN
		--Descubro o total dos impostos para diminuir com o da fatura
		SELECT
			@TotalImposto = IsNull(SUM(ABS(IsNull(PIT.TaxValue,0))),0) * (-1)
		FROM
			Pur_PurchaseItemTaxRet PIT
		WHERE
			PIT.IDPurchase = @IDPurchase

		SET @TotalImposto = (@SubTotal - ((@PercSubTotal/100)*@TotalImposto))

		--Cria desdobramento do Sub Total
		SET @NumDesdobramento = '1/'+Convert(VarChar(10),@TotalDesdobramento)
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @TotalImposto, @NumDesdobramento, @IDLancamentoTipo
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		--Cria desdobramento do Freight
		SET @NumDesdobramento = '2/'+Convert(VarChar(10),@TotalDesdobramento)
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @Freight, @NumDesdobramento, @IDLancamentoTipo

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -205
			GOTO ERRO
		END

		--Setar o contador para os desdobramentos de impostos
		SET @CountImposto = 3

		--Cursor para impostos
		--Declaração do Cursor de Purchase_ItemTax_Cursor
		DECLARE Purchase_ItemTax_Cursor CURSOR FOR

			SELECT 
				CT.IDLancamentoTipo,
				((@PercSubTotal/100)*IsNull(SUM(ABS(IsNull(PIT.TaxValue,0))),0)) * (-1) as Value
			FROM 
				Pur_PurchaseItemTaxRet PIT (NOLOCK) 
				LEFT OUTER JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax)
				LEFT OUTER JOIN TaxCategory CT (NOLOCK) ON (CT.IDTaxCategory = VT.IDTaxCategory)
			WHERE
				PIT.IDPurchase = @IDPurchase
			GROUP BY
				CT.IDLancamentoTipo,
				PIT.IDVendorTax 		

		OPEN Purchase_ItemTax_Cursor

		--Inicialização de Purchase_ItemTax_Cursor
		FETCH NEXT FROM Purchase_ItemTax_Cursor INTO
			@IDLancamentoTipo,
			@ValorNominal
		--Enquanto tem registros
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--Cria desdobramento dos impostos

			SET @NumDesdobramento = Convert(VarChar(10),@CountImposto)+'/'+Convert(VarChar(10),@TotalDesdobramento)
			EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @ValorNominal, @NumDesdobramento, @IDLancamentoTipo
			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				SET @ErrorLevel = -206
				GOTO ERRO
			END

			--Incrementar o desdobramento
			SET @CountImposto = @CountImposto + 1

		FETCH NEXT FROM Purchase_ItemTax_Cursor INTO			@IDLancamentoTipo,
			@ValorNominal
		END
		--fechamento do cursor
		CLOSE Purchase_ItemTax_Cursor
		--Destruição do cursor
		DEALLOCATE Purchase_ItemTax_Cursor
END
-------------------------------------------------------------------------------------------------------------------------

FETCH NEXT FROM Fin_Lancamento_Cursor INTO
		@Pagando,
		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDPurchaseDueDate,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType
END
--fechamento do cursor
CLOSE Fin_Lancamento_Cursor
--Destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_CriaPagamentoComImpostoRet', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_Do
	(
	@IDPurchase	int,
	@Date 		DateTime,
	@TaxInCost	Bit
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario os barcodes que ainda nao existam
		- Altero o Category no Model quando diferente
		- Atualizo o AvgCost no Model
		- Atualizo o AvgCost no Inventory
		- Incluo o InventoryMov se necessario
		- Se necessario crio os lancamentos no contas a pagar
		- Deleto as Qty do Pur_PurchaseQtyPreSale ##Rodrigo
		- Incluo as Qty do Pur_PurchaseQtyPreSale ##Rodrigo
		- Incluo os serial Numbers no inventory
		- Crio os lancamentos de retorno no contas a pagar, se necessario


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto as Qty do Pur_PurchaseQtyPreSale
		-202  Erro em Deleto as Qty do Pur_PurchaseQtyOrder
		-203  Erro em Deleto os PreInventoryMov
		-204  Erro em Deleto os InventoryMov
		-205  Erro em Incluo no Inventario os barcodes que ainda nao exitam
		-206  Erro em Atualizo a informa??o de category
		-207  Erro em Atualizar a TBL de Model com os valores se for Final
		-208  Erro em Incluo o InventoryMov se necessario
		-209  Erro em Insiro as Qty do Pur_PurchaseQtyPrePurchase se for PreReceiving para atualizar o qtyOnPreReceive na TBL Inventory
		-210  Erro em Insiro as Qty do Pur_PurchaseQtyOrder - Atualizar as qty no PO
		-211  Erro em Atualiza o total do PO
		-212  Erro em Crio os Serial Numbers no inventory se for final
		-213  Erro em Delete os Serial Numbers do Purchase
		-214  Erro em Deleto o Term do Fin >>> Os termos so serao deletados se o Purchase Type for do tipo Invoice
		-215  Erro em Crio os lancamentos no contas a pagar, se necessario
		-216  Erro em Incluio novamente o Term do Fin >>> Os termos so serao incluidos se o Purchase Type for do typo Invoice
		-217  Erro em Deletetar o InventoryMovTax
		-218  Erro em atualizar o PO
		-219  Erro em Crio os lancamentos de retorno no contas a pagar, se necessario
		-220  Erro em Inserir na ModelVendor
		-221  Erro em Atualizo o AvgCost no Model
		-222  Erro em Atualizo o AvgCost no Inventory
		-223  Erro em Inserir Case Barcode
	
	LOG DE MODIFICA??ES

	Data			Programador		Modifica??o
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 	2000	Eduardo Costa		Cria??o;
	18 dezembro 	2000	Rodrigo Costa		Complemento;
	06 junho        	2001	Davi Gouveia	Variavel @ErrorLevel/Lista de Return_Values
	07 junho        	2001	Rodrigo Costa	Insert no Fin_LancamentoTerm
	07 dezembro 	2001	Rodrigo Costa		Nao pode deletar p PreInventoryMov, pois os item nao sao salvos la.
	13 May	        	2002	Rodrigo Costa	Criacao Lancamento Termo para os Disbursements 
	29 Oct		2003	Rodrigo Costa		Criado Cuersor para InvMov, Pur_PurchaseQtyPrePurchase, Pur_PurchaseQtyOrder_Cursor;
							Chamado da sp_GetNextCode;
	13 Feb		2004	Rodrigo Costa		Deletar o InventoryMovTax da Compra
	18 Aug		2004	Rodrigo Costa		Gravar error log
	14 Dez		2004	Rodrigo Costa		Cricao do campo @TaxInCost para incluir o preco do item; Retirado o update NewSalePrice
	11 Mar		2005	Carlos Lima		Tratamento das quantidades devolvidas
	11 Mar		2005	Rodrigo Costa		Atualizacao das quantidades no PO
	14 Mar		2005	Carlos Lima		Criação da Devolução no Contas a Pagar
	26 Abr		2005	Rodrigo Costa		Incluir impostos de devolucao caso necessario; Nao alterar categoria dos produtos
	02 Jan		2006	Carlos Lima		Retirada do update do AvgCost em Model e Inventory ( feito agora pela trigger do InventoryMov )
	12 Jan		2006	Carlos Lima		Update do AvgCost em InventoryMov
	22 Jan		2006	Rodrigo Costa		Atualizar o DateLastSellingPrice quando fizer a compra
	25 Jan		2006	Rodrigo Costa		Inserir na tabela de Inv_ModelVendor
	01 Jun		2006	Carlos Lima		O calculo do custo medio volta para a procedure ( espero q seja a ultima vez !!! )
	06 Jun		2006	Carlos Lima		Cursor para excluir o inventorymov e atualizar o custo médio
	19 Jun		2006	Leonardo Riego		Verificação se atualiza DateLastSellingPrice e DateLastCost na tabela de Model.
	07 Jul		2006	Rodrigo Costa		Adicionado o Trim no CodBarra do item da compra
	07 Fev		2006	Rodrigo Costa		Inserir Case Barcode
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDPO 			int
DECLARE @ErrorLevel 			int
DECLARE @SysError			int

--Declara??o de vari?veis para o Cursor de InventoryMov
DECLARE @StoreID 			int 
DECLARE @IDPessoa 			int 
DECLARE @InventMovTypeID 		int 
DECLARE @DocumentID 		int 
DECLARE @ModelID 			int 
DECLARE @Qty 			float 
DECLARE @CostPrice 			money 
DECLARE @SalePrice 			money 
DECLARE @BarCodeID 			char(20)
DECLARE @MovDate 			smalldatetime 
DECLARE @IDUser 			int 
DECLARE @IDInventoryMov		int
DECLARE @HasRet				int

--Declara??o de vari?veis para o Cursor de Pur_PurchaseQtyPrePurchase
DECLARE @IDModel 			int 
DECLARE @IDStore 			int 
DECLARE @IDPurchaseQtyPreSale	float

--Declara??o de vari?veis para o Cursor de Pur_PurchaseQtyOrder
DECLARE @IDPOItem 			int 
DECLARE @IDPurchaseQtyOrder	float
DECLARE @AvgCost		float

DECLARE @IDInventory		int

BEGIN TRAN


-----------------------------------------------------------
-- Deleto as Qty do Pur_PurchaseQtyPreSale
DELETE
	PQP
FROM
	Pur_PurchaseQtyPrePurchase PQP (NOLOCK) 
WHERE
	PQP.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-----------------------------------------------------------
-- Deleto as Qty do Pur_PurchaseQtyOrder
DELETE
	PQP
FROM 
	Pur_PurchaseQtyOrder PQP (NOLOCK) 
WHERE
	PQP.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PreInventoryMov
/*
DELETE
	PIM
FROM
	PreInventoryMov PIM
WHERE
	PIM.DocumentID = @IDPurchase
	AND
	PIM.InventMovTypeID = 2

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END
*/

------------------------------------------------------------------------------
-- Deleto os InventoryMovTax

DELETE
	IMT
FROM
	InventoryMovTax IMT (NOLOCK) 
WHERE
	IMT.IDInventoryMov IN (	SELECT IDInventoryMov
			       	FROM InventoryMov IM (NOLOCK) 
				WHERE IM.DocumentID = @IDPurchase AND
				IM.InventMovTypeID = 2
				)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -217
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IM.IDInventoryMov
FROM
	InventoryMov IM (NOLOCK) 
WHERE
	IM.DocumentID = @IDPurchase
	AND
	IM.InventMovTypeID = 2


OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor

------------------------------------------------------------------------------
-- Incluo no Inventario os barcodes que ainda nao exitam

INSERT
	BarCode (IDBarCode, IDModel, Data, BarcodeOrder)
SELECT
	PPI.BarCode,
	PPI.IDModel,
	@Date,
	IsNull(Max(BarcodeOrder), 0) + 1
FROM
	Pur_PurchaseItem PPI (NOLOCK) 
	LEFT OUTER JOIN BarCode BC (NOLOCK) ON (PPI.IDModel = BC.IDModel)
WHERE
	(PPI.BarCode IS NOT NULL AND (RTRIM(LTRIM(PPI.BarCode)) <> ''))
	AND PPI.IDPurchase = @IDPurchase
	AND NOT EXISTS (SELECT * FROM Barcode (NOLOCK) WHERE IDBarcode = PPI.BarCode)
GROUP BY
	PPI.BarCode,
	PPI.IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Incluo no Inventario o barcode de embalagem

INSERT
	BarCode (IDBarCode, IDModel, Data, BarcodeOrder, Qty)
SELECT
	PPI.BarcodeCase,
	PPI.IDModel,
	@Date,
	IsNull(Max(BarcodeOrder), 0) + 1,
	(PPI.Qty / IsNull(PPI.CaseQty,1))
FROM
	Pur_PurchaseItem PPI (NOLOCK) 
	LEFT OUTER JOIN Barcode BC (NOLOCK) ON (PPI.IDModel = BC.IDModel)
WHERE
	(PPI.BarcodeCase IS NOT NULL AND (RTRIM(LTRIM(PPI.BarcodeCase)) <> ''))
	AND PPI.IDPurchase = @IDPurchase
	AND NOT EXISTS (SELECT * FROM Barcode (NOLOCK) WHERE IDBarcode = PPI.BarcodeCase)
	AND IsNull(PPI.CaseQty,0) >= 1
GROUP BY
	PPI.BarcodeCase,
	PPI.IDModel,
	PPI.CaseQty,
	PPI.Qty

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -223
	GOTO ERRO
END
------------------------------------------------------------------------------
-- Atualizo a informacao de category

UPDATE
	M
SET
	M.GroupID = PPI.IDGroup
FROM
	Model M (NOLOCK) 
	JOIN Pur_PurchaseItem PPI (NOLOCK) ON (M.IDModel = PPI.IDModel)
WHERE
	M.GroupID <> PPI.IDGroup
	AND
	PPI.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


--------------------------------------------------------------------------------------------------
---Atualizar a TBL de Model com os valores se for Final
---Imposto nao esta incluido no Custo do produto
IF (@TaxInCost=1)
BEGIN
	UPDATE
		Model
	SET
		Model.Desativado     	= 0,
		Model.DateLastSellingPrice = CASE PUI.IsPromo WHEN 0 THEN (CASE IsNull(PUI.NewSalePrice, 0) WHEN 0 THEN Model.DateLastSellingPrice WHEN Model.SellingPrice THEN Model.DateLastSellingPrice ELSE @Date END) ELSE Model.DateLastSellingPrice END,
		Model.DateLastCost   	= CASE PUI.IsPromo WHEN 0 THEN (CASE WHEN (Model.LastCost = Model.VendorCost) THEN Model.DateLastCost ELSE @Date END) ELSE Model.DateLastCost END ,
		Model.LastCost       	= CASE PUI.IsPromo WHEN 0 THEN IsNull(Model.VendorCost,0) ELSE Model.LastCost END,
		Model.VendorCost     	= CASE PUI.IsPromo WHEN 0 THEN IsNull(PUI.NewCostPrice,0) ELSE Model.VendorCost END,
		Model.SellingPrice 	= CASE PUI.IsPromo WHEN 0 THEN (CASE IsNull(PUI.NewSalePrice,0) WHEN 0 THEN Model.SellingPrice ELSE PUI.NewSalePrice END) ELSE Model.SellingPrice END,
		Model.SuggRetail 	= CASE PUI.IsPromo WHEN 0 THEN (CASE IsNull(PUI.NewSuggRetail,0) WHEN 0 THEN Model.SuggRetail ELSE PUI.NewSuggRetail END) ELSE Model.SuggRetail END,
		Model.OtherCost		= 0, --OtherCost ja esta incluido no custo
		Model.FreightCost    	= 0 --Freight ja esta incluido no custo
		
	FROM
		Pur_Purchase PU (NOLOCK) 
		JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
		JOIN Pur_PurchaseTotal PUT (NOLOCK) ON (PU.IDPurchase = PUT.IDPurchase)
	WHERE
		PU.IDPurchase = @IDPurchase
		AND
		DateFinalReceiving IS NOT NULL
		AND
		Model.IDModel = PUI.IDModel
END
ELSE
BEGIN

	UPDATE
		Model
	SET
		Model.Desativado	= 0,
		Model.DateLastSellingPrice = CASE PUI.IsPromo WHEN 0 THEN (CASE IsNull(PUI.NewSalePrice, 0) WHEN 0 THEN Model.DateLastSellingPrice WHEN Model.SellingPrice THEN Model.DateLastSellingPrice ELSE @Date END) ELSE Model.DateLastSellingPrice END,
		Model.DateLastCost	= CASE PUI.IsPromo WHEN 0 THEN (CASE WHEN (Model.LastCost = Model.VendorCost) THEN Model.DateLastCost ELSE @Date END) ELSE Model.DateLastCost END,
		Model.SellingPrice 	= CASE PUI.IsPromo WHEN 0 THEN IsNull(PUI.NewSalePrice,0) ELSE Model.SellingPrice END,
		Model.SuggRetail 	= CASE PUI.IsPromo WHEN 0 THEN IsNull(PUI.NewSuggRetail,0)ELSE Model.SuggRetail END,
		Model.LastCost		= CASE PUI.IsPromo WHEN 0 THEN IsNull(Model.VendorCost,0) ELSE Model.LastCost END,
		Model.VendorCost	= CASE PUI.IsPromo WHEN 0 THEN IsNull(PUI.NewCostPrice,0) ELSE Model.VendorCost END,
				
		Model.OtherCost 	= CASE PUI.IsPromo WHEN 0 THEN ( ROUND(
										CASE	WHEN 	PUT.SubTotal = 0 THEN 0
											ELSE	( IsNull((PU.OtherCharges / PUT.SubTotal)  * (PUI.NewCostPrice)  , 0 ) )
										END
	
				      					,2)) ELSE Model.OtherCost END,
	
	
		Model.FreightCost 	= CASE PUI.IsPromo WHEN 0 THEN ( ROUND(
					 					 CASE	WHEN 	PUT.SubTotal = 0 THEN 0
											ELSE	( IsNull(	(PU.Freight / PUT.SubTotal)  * (PUI.NewCostPrice) , 0 ) )
					 					 END
				      					,2)) ELSE Model.FreightCost END
			
	FROM
		Pur_Purchase PU (NOLOCK) 
		JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
		JOIN Pur_PurchaseTotal PUT (NOLOCK) ON (PU.IDPurchase = PUT.IDPurchase)
	WHERE
		PU.IDPurchase = @IDPurchase
		AND
		DateFinalReceiving IS NOT NULL
		AND
		Model.IDModel = PUI.IDModel

END


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Incluo o InventoryMov se necessario
--Declara??o do Cursor de InventoryMov
DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	PP.IDStore,
	PP.IDFornecedor,
	2, -- Compra
	PP.IDPurchase,
	PPI.IDModel,
	PPI.Qty - IsNull(PPI.QtyRet, 0) AS Qty,
	PPI.NewCostPrice,
	PPI.NewSalePrice,
	PPI.BarCode,
	PP.DateFinalReceiving,
	PP.IDUserFinalReceiving
FROM
	Pur_Purchase PP (NOLOCK) 
	JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PP.IDPurchase = PPI.IDPurchase)
WHERE
	PP.IDPurchase = @IDPurchase
	AND
	DateFinalReceiving IS NOT NULL



OPEN InventoryMov_Cursor

--Inicializacao de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@StoreID,
	@IDPessoa,
	@InventMovTypeID,
	@DocumentID,
	@ModelID,
	@Qty,
	@CostPrice,
	@SalePrice,
	@BarCodeID,
	@MovDate,
	@IDUser
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	-- Atualiza o saldo em valor do Model

	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -221
		GOTO ERRO
	END

	IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @ModelID AND StoreID = @StoreID)
	BEGIN
		EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
	
		INSERT Inventory
			(
			IDInventory,
			StoreID,
			ModelID
			)
		VALUES
			(
			@IDInventory,
			@StoreID,
			@ModelID
			)
	END


	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCost = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreID



	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -222
		GOTO ERRO
	END
	

	EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		StoreID,
		IDPessoa,
		InventMovTypeID,
		DocumentID,
		ModelID,
		Qty,
		CostPrice,
		SalePrice,
		BarCodeID,
		MovDate,
		IDUser,
		AvgCost
		)
	VALUES
		(
		@IDInventoryMov,
		@StoreID,
		@IDPessoa,
		@InventMovTypeID,
		@DocumentID,
		@ModelID,
		@Qty,
		@CostPrice,
		@SalePrice,
		@BarCodeID,
		@MovDate,
		@IDUser,
		@AvgCost
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -208
		GOTO ERRO
	END
	

	IF NOT EXISTS (SELECT IDModel FROM Inv_ModelVendor WHERE IDModel = @ModelID AND IDPessoa = @IDPessoa)
	BEGIN
		INSERT
			Inv_ModelVendor (IDModel, IDPessoa, VendorOrder)
		SELECT
			@ModelID,
			@IDPessoa,
			IsNull(MAX(IMV.VendorOrder),0) + 1
		FROM
			Inv_ModelVendor IMV (NOLOCK) 
		WHERE
			IMV.IDModel = @ModelID
	END

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		PRINT 'ERROR AQUI'
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -220
		GOTO ERRO
	END


	FETCH NEXT FROM InventoryMov_Cursor INTO

		@StoreID,
		@IDPessoa,
		@InventMovTypeID,
		@DocumentID,
		@ModelID,
		@Qty,
		@CostPrice,
		@SalePrice,
		@BarCodeID,
		@MovDate,
		@IDUser
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destrui??o do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


-----------------------------------------------------------
-- Insiro as Qty do Pur_PurchaseQtyPrePurchase se for PreReceiving para atualizar o qtyOnPreReceive na TBL Inventory
--Declara??o do Cursor de Pur_PurchaseQtyPrePurchase
DECLARE Pur_PurchaseQtyPrePurchase_Cursor CURSOR FOR


SELECT
	PUI.IDModel,
	PU.IDStore,
	SUM(PUI.Qty - IsNull(PUI.QtyRet, 0))
FROM
	Pur_Purchase PU (NOLOCK) 
	JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NULL
GROUP BY
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem


OPEN Pur_PurchaseQtyPrePurchase_Cursor

--Inicializa??o de Pur_PurchaseQtyPrePurchase_Cursor
FETCH NEXT FROM Pur_PurchaseQtyPrePurchase_Cursor INTO
	@IDModel,
	@IDStore,
	@Qty
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Pur_PurchaseQtyPrePurchase.IDPurchaseQtyPreSale', @IDPurchaseQtyPreSale OUTPUT
	INSERT Pur_PurchaseQtyPrePurchase
		(
		IDPurchaseQtyPreSale,
		IDPurchase,
		IDModel,
		IDStore,
		Qty
		)
	VALUES
		(
		@IDPurchaseQtyPreSale,
		@IDPurchase,
		@IDModel,
		@IDStore,
		@Qty
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Pur_PurchaseQtyPrePurchase_Cursor
		DEALLOCATE Pur_PurchaseQtyPrePurchase_Cursor
		SET @ErrorLevel = -209
		GOTO ERRO
	END

	FETCH NEXT FROM Pur_PurchaseQtyPrePurchase_Cursor INTO
		@IDModel,
		@IDStore,
		@Qty
END
--fechamento do cursor
CLOSE Pur_PurchaseQtyPrePurchase_Cursor
--Destrui??o do cursor
DEALLOCATE Pur_PurchaseQtyPrePurchase_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


-----------------------------------------------------------
-- Insiro as Qty do Pur_PurchaseQtyOrder - Atualizar as qty no PO
--Declara??o do Cursor de Pur_PurchaseQtyOrder

DECLARE Pur_PurchaseQtyOrder_Cursor CURSOR FOR

SELECT
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem,
	SUM(PUI.Qty - IsNull(PUI.QtyRet, 0))
FROM
	Pur_Purchase PU (NOLOCK) 
	JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
GROUP BY
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem

OPEN Pur_PurchaseQtyOrder_Cursor

--Inicializa??o de Pur_PurchaseQtyOrder_Cursor
FETCH NEXT FROM Pur_PurchaseQtyOrder_Cursor INTO
	@IDModel,
	@IDStore,
	@IDPOItem,
	@Qty
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Pur_PurchaseQtyOrder.IDPurchaseQtyOrder', @IDPurchaseQtyOrder OUTPUT
	INSERT Pur_PurchaseQtyOrder
		(
		IDPurchaseQtyOrder,
		IDPurchase,
		IDModel,
		IDStore,
		IDPOItem,
		Qty
		)
	VALUES
		(
		@IDPurchaseQtyOrder,
		@IDPurchase,
		@IDModel,
		@IDStore,
		@IDPOItem,
		@Qty
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Pur_PurchaseQtyOrder_Cursor
		DEALLOCATE Pur_PurchaseQtyOrder_Cursor
		SET @ErrorLevel = -210
		GOTO ERRO
	END

	FETCH NEXT FROM Pur_PurchaseQtyOrder_Cursor INTO
		@IDModel,
		@IDStore,
		@IDPOItem,
		@Qty
END
--fechamento do cursor
CLOSE Pur_PurchaseQtyOrder_Cursor
--Destrui??o do cursor
DEALLOCATE Pur_PurchaseQtyOrder_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualiza o total do PO

SELECT
	@IDPO = PIM.DocumentID
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN Pur_PurchaseQtyOrder PQO (NOLOCK) ON (PIM.IDPreInventoryMov = PQO.IDPOItem)
WHERE
	PQO.IDPurchase = @IDPurchase	

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualizo os totais da PO, se necessario
SELECT
	@IDPO = P.IDPO
FROM
	Pur_Purchase P (NOLOCK) 
WHERE
	IDPurchase = @IDPurchase

EXEC sp_PO_CalcTotalQty @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -218
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Crio os Serial Numbers no inventory se for final
INSERT
	InventorySerial
	(
	StoreID,
	ModelID,
	Serial
	)
SELECT
	PU.IDStore,
	PUI.IDModel,
	PIS.SerialNumber
FROM
	Pur_Purchase PU (NOLOCK) 
	JOIN Pur_PurchaseItemSerial PIS (NOLOCK) ON (PU.IDPurchase = PIS.IDPurchase)
	JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PIS.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Delete os Serail Numbers do Purchase
DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS (NOLOCK) 
	JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PIS.IDPurchase)
WHERE
	PIS.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o Term do Fin >>> Os termos so serao deletados se o Purchase Type for do typo Invoice


DELETE
	Fin_LancamentoTerm
WHERE
	IDLancamento IN (SELECT L.IDLancamento FROM Fin_Lancamento L WHERE L.IDPurchase = @IDPurchase)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -214
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Crio os lancamentos no contas a pagar, se necessario
IF (@TaxInCost=1)
	EXEC sp_Purchase_CriaPagamentoComImposto @IDPurchase
ELSE
	EXEC sp_Purchase_CriaPagamento @IDPurchase


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -215
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Crio os lancamentos de retorno no contas a pagar, se necessario

SELECT
	@HasRet = SUM(ABS(IsNull(PPI.QtyRet, 0)))
FROM
	Pur_Purchase PP (NOLOCK) 
	JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PP.IDPurchase = PPI.IDPurchase)
WHERE
	PP.IDPurchase = @IDPurchase
	AND
	DateFinalReceiving IS NOT NULL

IF ((@TaxInCost=1) AND (@HasRet>0))
	EXEC sp_Purchase_CriaPagamentoComImpostoRet @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -219
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Incluio novamente o Term do Fin >>> Os termos so serao incluidos se o Purchase Type for do typo Invoice

INSERT
	Fin_LancamentoTerm (IDLancamento, DueDateShift, Discount)
SELECT
	L.IDLancamento, PT.DueDateShift, PT.Discount
FROM
	Pur_PurchaseTerm PT (NOLOCK) 
	JOIN Fin_Lancamento L (NOLOCK) ON (L.IDPurchase = PT.IDPurchase)
WHERE
	L.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -216
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_Remove
		(
 		@IDPurchase	 	 int
		)
AS 

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo o QtyOnPreReceive no Inventory
		- Deleto os InventoryMov
		- Deleto os PreInventoryMov
		- Deleto os PurchaseItemSerial
		- Deleto os PurchaseItem
		- Deleto os PurchaseDueDate
		- Deleto o Term do Financeiro
		- Deleto o Term da Purchase
 		- Deleto o Contas a Pagar, caso exista
		- Deleto a total de purhcase (o bacalhau do BugBDE)
		- Deleto o Purchase
		- Deletar a TBL Pur_PurchaseQtyPreSale
		- Deletar a TBL Pur_PurchaseItemTax
		- Deletar Pur_PurchaseItemTaxRet
		- Atualizar o fechamento do PO
		- Atualizar os valores do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto qtyOnPrePurchase do Inventory
		-202  Erro em Deleto qtyOnOrder do Inventory
		-203  Erro em Deleto os PreInventoryMov
		-204  Erro em Deleto os InventoryMov
		-205  Erro em Deleto os PurchaseItemSerial
		-206  Erro em Deleto o PurchaseDueDate
		-207  Erro em Deleto o Term do Fin
		-208  Erro em Deleto o Term do Purchase
		-209  Erro em Deleto as contas a pagar
		-210  Erro em Deleto os PurchaseTotal
		-211  Erro em Deleto os Purchase
		-212  Erro em Deletar Pur_PurchaseItemTax
		-213  Erro em Deletar Pur_PurchaseItemTaxRet
		-214  Erro em Atualizar o fechamento do PO
		-215  Erro em Atualizar os valores do PO
		-216  Erro em Atualizar o Custo Medio

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	--------------------------------------------------------------------------------
	04 Dec	2000		Eduardo Costa		Criação;
	18 Dec	2001		Rodrigo Costa		Atualizacao;
	08 Jun	2001		Rodrigo Costa		Deletar o Term do Fin_Lancamento & Purchase;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	14 Dez	2004		Rodrigo Costa		Deletar os Pur_PurchaseItemTax;
	11 Mar	2005		Carlos Lima		Deletar os Pur_PurchaseItemTaxRet;
	11 Mar	2005		Rodrigo Costa		Alteracao do PO;
	01 Dec	2005		Carlos Lima		Atualizar Totais e Condição de fechamento do PO;
	09 Dec	2005		Rodrigo Costa		Atualizar o Custo Medio;
	11 Jan	2006		Rodrigo Costa		Remover o Custo Medio;
	23 Feb	2006		Maximiliano Muniz	Deletar os PurchaseDueDate;
	06 Jun  2006		Carlos Lima		Deleção do InvMov em um cursor, para atualizar o AvgCost
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDPO		int
DECLARE @IDInventoryMov	int

SET @ErrorLevel = 0

BEGIN TRAN

---------------------------------------------------------------------------- ##Carlos
-- Obtenho o ID do PO

SELECT
	@IDPO = IDPO
FROM
	Pur_Purchase (NOLOCK) 
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnPrePurchase do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ (NOLOCK) 
WHERE
	PUQ.IDPurchase =  @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnOrder do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyOrder PUQ (NOLOCK) 
WHERE
	PUQ.IDPurchase =  @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PreInventoryMov

DELETE
	PIM
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.DocumentID = @IDPurchase
	AND
	PIM.InventMovTypeID = 2

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO

END

------------------------------------------------------------------------------
-- Deleto os InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IM.IDInventoryMov
FROM
	InventoryMov IM (NOLOCK) 
WHERE
	IM.DocumentID = @IDPurchase
	AND
	IM.InventMovTypeID = 2


OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor

/*
DELETE
	IM
FROM
	InventoryMov IM
WHERE
	IM.DocumentID = @IDPurchase
	AND
	IM.InventMovTypeID = 2

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

*/

------------------------------------------------------------------------------
-- Deleto os PurchaseItemSerial

DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS (NOLOCK) 
WHERE
	PIS.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItemTax

DELETE
	PIT
FROM
	Pur_PurchaseItemtax PIT (NOLOCK) 
WHERE
	PIT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItemTaxRet

DELETE
	PIT
FROM
	Pur_PurchaseItemtaxRet PIT (NOLOCK) 
WHERE
	PIT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItem

DELETE
	PPI
FROM
	Pur_PurchaseItem PPI (NOLOCK) 
WHERE
	PPI.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseDueDate

DELETE
	PDD
FROM
	Pur_PurchaseDueDate PDD (NOLOCK) 
WHERE
	PDD.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto o Term do Fin 

DELETE
	Fin_LancamentoTerm
WHERE	IDLancamento IN (SELECT L.IDLancamento FROM Fin_Lancamento L (NOLOCK) WHERE L.IDPurchase = @IDPurchase)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o Term do Purchase 

DELETE
	Pur_PurchaseTerm
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto as contas a pagar

DELETE
	L
FROM
	Fin_Lancamento L (NOLOCK) 
WHERE
	L.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PurchaseTotal

DELETE
	PT
FROM 
	Pur_PurchaseTotal PT (NOLOCK) 
WHERE
	PT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os Purchase

DELETE
	P
FROM
	Pur_Purchase P (NOLOCK) 
WHERE
	P.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

IF @IDPO IS NOT NULL
BEGIN
------------------------------------------------------------------------------
-- Call sp_PO_CalcTotalQty
	
	EXEC sp_PO_CalcTotalQty @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -214
		GOTO ERRO
	END

------------------------------------------------------------------------------
-- Call sp_PO_AtuPOTotal

	EXEC sp_PO_AtuPOTotal @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -215
		GOTO ERRO
	END

END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_RemoveItem
		(
 		@IDPurchase		int,
		@IDPurchaseItem		int,
		@TaxInCost		bit
		)
AS 

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Obtenho o ID do PO
		- Atualizo o QtyOnPrePurchase no Inventory ### Rodrigo
		- Atualizo o QrtArrived no PreInvMov ## Rodrigo

		- Deleto os PurchaseItemSerial
		- Atualizao o Avg Cost no Model
		- Deleto o PurchaseItem
		- Call sp_Purchase_AtuPurchaseSubTotal
		- Deleto Pur_PurchaseItemTax
		- Deleto Pur_PurchaseItemTaxRet
		- Atualizo Total do PO
		- Atualizo condição de fechamento do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto AsQty o item no Pur_PurchaseQtyPrePurchase
		-202  Erro em Deleto AsQty o item no Pur_PurchaseQtyOrder
		-203  Erro em Deleto os PurchaseItemSerial
		-204  Erro em Deleto o PurchaseItem
		-205  Erro em Call sp_Purchase_AtuPurchaseSubTotal
		-206  Erro em Deletar Pur_PurchaseItemTax
		-207  Erro em Deletar Pur_PurchaseItemTaxRet
		-208  Obtenho o ID do PO
		-209  Atualizo Total do PO
		-210  Atualizo condição de fechamento do PO
		-211 Atualizao o Custo Medio
		-212 Erro ao desvincular Purchase do PO.


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 Dec 2000		Eduardo Costa		Criação;
	18 Dec 2000		Rodrigo Costa		Atualizacao;
	26 Jun 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	14 Dec 2004		Rodrigo Costa		Deletar os Pur_PurchaseItemTax
	11 Mar 2005		Carlos Lima		Deletar os Pur_PurchaseItemTaxRet
	01 Dec 2005		Carlos Lima		Verificar a Condição de fechamento do PO e atualizar
	07 Dec	2005		Rodrigo Costa		Atualizar o AvgCost no Model
	11 Jan	2006		Rodrigo Costa		Remover o Custo Medio
	20 Jul	2006		Leonardo Riego		Caso Purchase nao possua mais itens do PO desvincular o Purchase do PO.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDPO	int
DECLARE @HavePOItens	int

SET @ErrorLevel = 0

BEGIN TRAN



---------------------------------------------------------------------------- ##Carlos
-- Obtenho o ID do PO

SELECT
	@IDPO = IDPO
FROM
	Pur_Purchase (NOLOCK) 
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

---------------------------------------------------------------------------- ##Rodrigo
-- Deleto AsQty o item no Pur_PurchaseQtyPrePurchase

DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ (NOLOCK) 
WHERE
	PUQ.IDModel = (
			SELECT
				PUI.IDModel
			FROM
				Pur_PurchaseItem PUI (NOLOCK) 
			WHERE
				PUI.IDPurchaseItem = @IDPurchaseItem
				AND
				PUI.IDPurchase = @IDPurchase
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


---------------------------------------------------------------------------- ##Rodrigo
-- Deleto AsQty o item no Pur_PurchaseQtyOrder

DELETE
	PUQ
FROM
	Pur_PurchaseQtyOrder PUQ (NOLOCK) 
WHERE
	PUQ.IDModel = (
			SELECT
				PUI.IDModel
			FROM
				Pur_PurchaseItem PUI (NOLOCK) 
			WHERE
				PUI.IDPurchaseItem = @IDPurchaseItem
				AND
				PUI.IDPurchase = @IDPurchase
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PurchaseItemSerial

DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS (NOLOCK) 
WHERE
	PIS.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PurchaseItemTax

DELETE
	PIT
FROM
	Pur_PurchaseItemTax PIT (NOLOCK) 
WHERE
	PIT.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItemTaxRet

DELETE
	PIT
FROM
	Pur_PurchaseItemTaxRet PIT (NOLOCK) 
WHERE
	PIT.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto o PurchaseItem

DELETE
	PPI
FROM
	Pur_PurchaseItem PPI (NOLOCK) 
WHERE
	PPI.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Call sp_Purchase_AtuPurchaseSubTotal

EXEC sp_Purchase_AtuPurchaseSubTotal  @IDPurchase, @TaxInCost

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END



IF @IDPO IS NOT NULL
BEGIN
------------------------------------------------------------------------------
-- Call sp_PO_AtuPOTotal

	EXEC sp_PO_AtuPOTotal @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -209
		GOTO ERRO
	END

------------------------------------------------------------------------------
-- Call sp_PO_CalcTotalQty
	
	EXEC sp_PO_CalcTotalQty @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -210
		GOTO ERRO
	END
------------------------------------------------------------------------------
-- Caso Purchase nao possua mais itens do PO desvincular o Purchase do PO.
	
	SELECT 
		@HavePOItens = COUNT(IDPurchaseItem)
	FROM
		Pur_Purchase PP (NOLOCK) 
		JOIN PreInventoryMov PIM (NOLOCK) ON(PIM.DocumentID = PP.IDPO)
		JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PPI.IDPOItem = PIM.IDPreInventoryMov AND PPI.IDPurchase = PP.IDPurchase)
	WHERE
		PP.IDPurchase = @IDPurchase 

	IF @HavePOItens = 0
	BEGIN
		UPDATE
			Pur_Purchase
		SET
			IDPO = NULL
		WHERE
			IDPurchase = @IDPurchase 		
	END
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -212
		GOTO ERRO
	END
END


OK:
	COMMIT TRAN 
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_RemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Sis_GetUserRights
	(
	@IDUsuario 	int,
	@IDMenuItem 	int,
	@Rights	varchar(255)	output
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Le os direitos que o usuario tem sobre o menuitem
		e os retorna em uma string separada por ponto e virgula

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro na Criacao do CURSOR
		-202  Erro no FETCH dado para o CURSOR


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDOperacao	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0

DECLARE Operacoes CURSOR FOR
	(
	SELECT 	IDOperacao
	FROM	((
		Sis_Grupo G (NOLOCK) 
		JOIN Sis_GrupoMainMenuOperacao GMMO (NOLOCK) ON (G.IDGrupo = GMMO.IDGrupo))
		JOIN Sis_UsuarioGrupo GU (NOLOCK) ON (GU.IDGrupo = G.IDGrupo))
	WHERE   IDMenuItem = @IDMenuItem
		AND
		IDUsuario = @IDUsuario
	GROUP BY IDOperacao
	HAVING  SUM(Convert(int, GMMO.Permissao)) > 0
	)  

	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
	END 

SELECT @Rights = ''

OPEN Operacoes
FETCH NEXT FROM Operacoes INTO @IDOperacao
WHILE (@@FETCH_STATUS = 0)
BEGIN
	-- Inclui a operacao
	SELECT @Rights = @Rights + RTrim(Convert(char(20), @IDOperacao)) + ';'
	-- Proximo Operacao
	FETCH NEXT FROM Operacoes INTO @IDOperacao
END

CLOSE Operacoes
DEALLOCATE Operacoes

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Sis_GetUserRights', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Sis_QuickInfo

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		-

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Total Invoices Today
		-202  Erro em ItemOnPO
		-203  Erro em ItemOnHand
		-204  Erro em SELECT FROM Fin_Lancamento (NOLOCK)
		-205  Erro em PastDuePayments
		-206  Erro em Expenses
		-207  Erro em Profit
		-207  Erro em Item Request
		-207  Erro em Item Hold


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May 2000		Eduardo Costa		Criacao;
	27 June 2001		Davi Gouveia		Log de Return Values
	15 October 2001	Rodrigo Costa		Exepenses was updated with 'L.IDLancamentoTipo <> 7' - Cost of Good
	28 Nov 2001		Rodrigo Costa		Novos Quick Info - Request & Items onHold
 	18 Aug 2004		Rodrigo Costa		Gravar error log
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @TotalSale 				money
DECLARE @ItemOnHand 			int
DECLARE @ItemOnPO 				int
DECLARE @AccountReceivableToAprove 	int
DECLARE @AccountPayableToAprove 		int
DECLARE @PastDuePayments 			int
DECLARE @Profit 				money
DECLARE @Expenses 				money
DECLARE @ErrorLevel 				int
DECLARE @SysError				int
DECLARE @ItemOnRequest 			int
DECLARE @ItemOnHold 			int 

SET @ErrorLevel = 0


/*-----------------------------------  Total Invoices Today ---------------------------------*/

SELECT
	@TotalSale =  SUM(I.SubTotal - I.ItemDiscount)
FROM
	Invoice I (NOLOCK) 
WHERE
	DatePart( Year, I.InvoiceDate ) = DatePart( Year, GetDate() )
	AND
	DatePart( Month, I.InvoiceDate ) = DatePart( Month, GetDate() )
	AND
	DatePart( Day, I.InvoiceDate ) = DatePart( Day, GetDate() )
	AND
	I.IDInvoice IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*-----------------------------------  ItemOnPO ---------------------------------*/

SELECT
	@ItemOnPO = SUM(POI.Qty )
FROM
	vwPOItem POI (NOLOCK) 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*-----------------------------------  ItemOnHand ---------------------------------*/

SELECT
	@ItemOnHand = count(IDInventory)
FROM
	inventory (NOLOCK) 
WHERE
	QtyOnHand < 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*-----------------------------------   ---------------------------------*/

SELECT
	@AccountReceivableToAprove = SUM(CASE Pagando WHEN 0 THEN 1 ELSE 0 END),
	@AccountPayableToAprove = SUM(CASE Pagando WHEN 1 THEN 1 ELSE 0 END)
FROM
	Fin_Lancamento (NOLOCK)
WHERE
	DatePart(Year, DataVencimento) = DatePart(Year, GetDate())
	AND
	DatePart(Month, DataVencimento) = DatePart(Month, GetDate())
	AND
	Previsao = 1
	AND
	Situacao in (1,5)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*-----------------------------------  PastDuePayments ---------------------------------*/

SELECT
	@PastDuePayments = COUNT(IDLancamento)
FROM
	Fin_Lancamento (NOLOCK)
WHERE
	DataVencimento < GetDate()
	AND
	Situacao in (1,5)
	AND
	Pagando = 1
	AND
	Desativado = 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

/*-----------------------------------  BreakEven ---------------------------------*/

--Expenses
Select
	@Expenses = Sum(L.ValorNominal)
From
	Fin_Lancamento L (NOLOCK) 
Where
	L.Pagando = 1
	AND
	DatePart(Month, L.DataVencimento) = DatePart(Month, GetDate())
	AND
	DatePart(Year, L.DataVencimento) = DatePart(Year, GetDate())
	AND
	L.Desativado = 0
	AND
	L.IDLancamentoTipo <> 7 --Cust of Good

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

--Profit
SELECT
	@Profit = ( sum(  ( InvMov.SalePrice - InvMov.CostPrice )  * InvMov.Qty - InvMov.Discount ) )
FROM
	InventoryMov InvMov (NOLOCK)
WHERE
	( InventMovTypeID = 1 )
	AND
	DatePart(Month, InvMov.MovDate) = DatePart(Month, GetDate())
	AND
	DatePart(Year, InvMov.MovDate) = DatePart(Year, GetDate())

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


/*-----------------------------------  Request ---------------------------------*/
SELECT
	@ItemOnRequest = SUM(QtyReq)
FROM
	Request (NOLOCK) 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


/*-----------------------------------  Item on Hold ---------------------------------*/

SELECT 
	@ItemOnHold = SUM(Qty)
FROM
	PreInventoryMov (NOLOCK) 
WHERE
	InventMovTypeID = 1
	AND
	Qty > 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


--Rodrigo Select the var to show in Delphi

SELECT
	IsNull ( @TotalSale, 0 ) as TotalSale,
	IsNull ( @ItemOnPO, 0 )  as ItemOnPO,
	IsNull ( @ItemOnHand, 0 ) as ItemOnHand,
	IsNull ( @AccountReceivableToAprove, 0 ) as AccountReceivableToAprove,
	IsNull ( @AccountPayableToAprove, 0 ) as AccountPayableToAprove,
	IsNull ( @PastDuePayments, 0 ) as PastDuePayments,
	IsNull ( @Profit - @Expenses, 0 ) as BreakEven,
	IsNull ( @ItemOnRequest, 0 ) as ItemOnRequest,
	IsNull ( @ItemOnHold, 0 )  as ItemOnHold



OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Sis_QuickInfo', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Sys_DailyMaintenance
			(
			@CalcABC	bit = 1,
			@CalcAvg	bit = 1,
			@DelHold	bit = 1
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Deleta os holds antigos

		- Deleto PreInventoryMov
		- Deleto Invoice
		- Atualizo Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-200  Erro em Insiro em DailyMaintenanceReport
		-201  Erro em Calcular ABC dos modelos
		-202  Erro em Calcular ABC dos modelos por loja
		-203  Erro em Calcular ponto de pedido e criar auto-requisições
		-204  Erro em Calcular o saldo em estoque e o custo médio
		-205  Erro em Atualizar a última data processada em DailyMaintenanceReport
		-206  Erro em Deleto PreInventoryMov
		-207  Erro em Atualizo Model
		-208  Erro em Altera o status do processamento após a conclusão


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Rodrigo Costa		Criacao;
	25 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	05 Jan	2007		Rodrigo Costa		Deletar hold com um cursor;
	09 Feb	2007		Maximiliano Muniz	Inclusão de apenas um registro na tabela DailyMaintenanceReport;
	16 Feb	2007		Maximiliano Muniz	Chamada da SP de cálculo de saldo de estoque e custo médio;
	06 Mar	2007		Rodrigo Costa		Criado parametros para executar as opcoes
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDPreSale	int
DECLARE @DelHoldDay	int
DECLARE @DelItemMonth	int
DECLARE @ErrorLevel 	int
DECLARE @SysError	int
DECLARE @Today		datetime
DECLARE @LastProcess	datetime
DECLARE	@IDDayMaint	int
DECLARE	@Date		DateTime

SET @ErrorLevel = 0

SELECT 	@DelHoldDay = Convert(Int, SrvValue) FROM Param (NOLOCK)  WHERE IDParam = 18
SELECT 	@DelItemMonth = Convert(Int, SrvValue) FROM Param (NOLOCK) WHERE IDParam = 17

-- Garanto que nao estao nulos
SELECT @DelHoldDay = IsNull(@DelHoldDay, 0) 
SELECT @DelItemMonth = IsNull(@DelItemMonth, 0)

-------------------------------------------------------------------------------------------------------------------------
-- Pego a última data processada ou a primeira data a processar
SELECT @Today		= CONVERT(smalldatetime, CONVERT(varchar, GetDate(), 103), 103)
SELECT @LastProcess	= CONVERT(smalldatetime, CONVERT(varchar, MAX(Date), 103), 103) FROM DailyMaintenanceReport (NOLOCK) WHERE Maintenance = 'DailyMaintenance'

IF @LastProcess = @Today
	RETURN
ELSE
BEGIN
	IF @LastProcess > 0
		SET @LastProcess = DateAdd(DAY, 1, @LastProcess)
	ELSE
	BEGIN
		----------------------------------------------------------------------------------------------------------
		-- Se ainda não processou nenhuma vez, insiro em DailyMaintenanceReport
		-- com a data da primeira movimentação do sitema
		SELECT @LastProcess = @Today

		exec sp_Sis_GetNextCode 'DailyMaintenanceReport.IDDailyMaintenanceReport', @IDDayMaint OUTPUT
		INSERT DailyMaintenanceReport 
			(
			IDDailyMaintenanceReport,
			Maintenance,
			[Date],
			LastMessage
			)
			VALUES
			(
			@IDDayMaint,
			'DailyMaintenance',
			@LastProcess,
			'Started'
			)
		
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -200
			GOTO ERRO
		END
	END
END



IF @CalcABC = 1
BEGIN
	-------------------------------------------------------------------------------------------------
	-- Calcular ABC dos modelos
	exec sp_Inv_CalcModelABC
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
	
		GOTO ERRO
	END
	
	-------------------------------------------------------------------------------------------------
	-- Calcular ABC dos modelos por loja
	exec sp_Inv_CalcStoreABC

	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
	
		GOTO ERRO
	END
	
	-------------------------------------------------------------------------------------------------
	-- Calcular ponto de pedido e criar auto-requisições
	exec sp_PO_CalcOrderPointSimple
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
	
		GOTO ERRO
	END
END



IF @CalcAvg = 1
BEGIN
	-------------------------------------------------------------------------------------------------
	-- Calcular o saldo em estoque e o custo médio
	exec sp_Inv_CalcBalance
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
	
		GOTO ERRO
	END
END

BEGIN TRANSACTION

-----------------------------------------------------------------------------------------------------------------
-- Atualizar a última data processada em DailyMaintenanceReport
UPDATE DailyMaintenanceReport SET [Date] = @Today, LastMessage = 'Started' WHERE Maintenance = 'DailyMaintenance'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END



IF @DelHold = 1
BEGIN

	IF @DelHoldDay > 0
	BEGIN
	
	/* ------------------------------------------------------------------------------------ */
	/*	Deletar movimentaçao de cancelamento com base na movimentação anterior		*/
	/* ------------------------------------------------------------------------------------ */ 
	--Declaração do Cursor de HoldDel_Cursor
	DECLARE HoldDel_Cursor CURSOR STATIC FOR 
		SELECT
			IDPreSale
		FROM
			Invoice (NOLOCK) 
		WHERE
			Invoice.IDInvoice IS NULL
			AND
			DateAdd(dd, @DelHoldDay, IsNull(EstimatedPay, Invoice.PreSaleDate)) < GetDate()
			AND
			Layaway <> 1
	
	OPEN HoldDel_Cursor
	
	--Inicialização de PreInv_Cursor
	FETCH NEXT FROM HoldDel_Cursor INTO
	            @IDPreSale
	
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Deletar os items
		EXEC sp_PreSale_Remove @IDPreSale, 0
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
		            SET @ErrorLevel = -206
		            GOTO ERRO
		END
	
	
		FETCH NEXT FROM HoldDel_Cursor INTO
	                        @IDPreSale
	END
	
	--fechamento do cursor
	CLOSE HoldDel_Cursor
	--Destruição do cursor
	DEALLOCATE HoldDel_Cursor
	
	END
	
	IF @DelItemMonth > 0
	BEGIN
		SELECT
			IDModel
		INTO 
			#ModelToDelete
		FROM
			Model  (NOLOCK) 
			JOIN Inventory I (NOLOCK) ON (Model.IDModel = I.ModelID)
		WHERE
			DateAdd(mm, @DelItemMonth, Model.LastMovDate) < GetDate()
			AND
			Model.LastMovDate IS NOT NULL
			AND
			Desativado = 0
		GROUP BY 
			IDModel
		HAVING
			SUM(IsNull(I.QtyOnHand,0)) = 0
	
		/*
	  	INSERT 	InventoryMov (InventMovTypeID, DocumentID, StoreID, ModelID, MovDate, Qty)
	        SELECT  20, 1, 1, IDModel, GetDate(), 0
		FROM	#ModelToDelete
		*/
	
		-- Atualizo Model
		UPDATE
			Model
		SET
			Desativado = 1
		FROM
			#ModelToDelete MTD
		WHERE
			Model.IDModel = MTD.IDModel
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -207
			GOTO ERRO
		END
	
		DROP TABLE #ModelToDelete
	END
END

-------------------------------------------------------------------------------------------------
-- Altera o status do processamento após a conclusão
UPDATE DailyMaintenanceReport SET LastMessage = 'Finished' WHERE Maintenance = 'DailyMaintenance'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208

	GOTO ERRO
END

OK:
	COMMIT TRANSACTION
	RETURN 0

ERRO:
	ROLLBACK TRANSACTION
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'System', 'Error: sp_DailyMaintenance', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_SystemUser_GetIDUser
		(
		@IDCOmission 	int,
		@IDUser      	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Retorna o ultimo id de usuario

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT @IDUser = IsNull(  ( SELECT MAX(IDUser) FROM SystemUser (NOLOCK)  WHERE ComissionID = @IDComission ), 0)
GO

CREATE PROCEDURE sp_TourGroup_AddGift 
			(
			@IDTouristGroup 	int,
			@IDModel 		int,
			@IDStore 		int,
			@Qty 			float,
			@DataGift 		smalldatetime,
			@IDUser 		int 
			)
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Três fases compreendem o gift, a movimentacao
		de inventario, o registro no cost do group e
		o registro no GroupCostGift para armazenar o
		Model e o User

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Registro no InventoryMov
		-202  Erro em Registra o cost
		-203  Erro em Registra o GroupCostGift


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	27 June 2001		Davi Gouveia		Log de Return Values
	30 Oct	2003		Rodrigo Costa		Criacao o cursor InventoryMov_Cursor;
							Chama sp_GetNextCode;  
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @IDInventoryMov 	int
DECLARE @IDCost 		int
DECLARE @IDGroupCostGift 	int


SET @ErrorLevel = 0

BEGIN TRAN

/* Registro no InventoryMov */

--Declaração do Cursor de InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT
		13, /* Tipo saida por gift */
		0,
		M.VendorCost,
		M.SellingPrice,
		M.SellingPrice * @Qty
	FROM
		Model M (NOLOCK) 
	WHERE
		IDModel = @IDModel

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@CostPrice,
	@SalePrice,
	@Discount

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		IDUser
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDStore,
		@IDModel,
		@DataGift,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@IDUser
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@CostPrice,
		@SalePrice,
		@Discount
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/* Registra o cost */
EXEC sp_Sis_GetNextCode'GroupCost.IDCost', @IDCost OUTPUT
	INSERT GroupCost
		(
		IDCost,
		IDTouristGroup,
		IDCostType,
		CostDate,
		UnitCost,
		Quantity
		)
	SELECT
		@IDCost,
		@IDTouristGroup,
     		5, /* Tipo gift */
		@DataGift,
		M.VendorCost,
		@Qty
	FROM
		Model M
	WHERE
		IDModel = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/* Registra o GroupCostGift */
EXEC sp_Sis_GetNextCode'GroupCostGift.IDGroupCostGift', @IDGroupCostGift OUTPUT
	INSERT GroupCostGift
		(
		IDGroupCostGift,
		IDGroupCost,
		IDModel,
		IDUser,
		Desativado
		)
	VALUES
		(
		@IDGroupCostGift,
		@IDCost,
		@IDModel,

		@IDUser,		0
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_TourGroup_AddGift', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_UpdateSystemQty
AS

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Recalculo dos saldos do sistema.
-- 	Não faz parte da operação normal do sistema.        	
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   CLEAR DOS SALDOS 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I 
SET
	I.QtyOnHand = 0,
	I.QtyOnOrder = 0,
	I.QtyOnPreSale = 0,
	I.QtyOnPrePurchase =0 ,
	I.QtyOnRepair = 0
FROM
	Inventory I (NOLOCK) 

UPDATE 
	IMT
SET
	IMT.TotQty = 0,
	IMT.TotCost = 0,
	IMT.TotSale = 0
FROM
	InventoryMovTotal IMT (NOLOCK) 


UPDATE
	M
SET
	M.TotQtyOnHand = 0,
	M.TotQtyOnOrder = 0,
	M.TotQtyOnPreSale = 0,
	M.TotQtyOnPrePurchase =0,
	M.TotQtyOnRepair = 0
FROM
	Model M



---###################################################################################################
-- ###### PreInventoryMov atualiza as Qty
---###################################################################################################
			

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale

FROM
	(
	SELECT
		ModelID,
		StoreID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		PreInventoryMov PIM (NOLOCK) 
		JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		PIM.InventMovTypeID = 1
		AND
		PIM.ModelID IS NOT NULL		AND
		PIM.StoreID IS NOT NULL
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		PIM.StoreID,

		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		PreInventoryMov PIM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL

	GROUP BY
		M.IDModelParent,
		PIM.StoreID
	) Total
	JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M	
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		PreInventoryMov PIM (NOLOCK) 
		JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN Model M ON (Total.ModelID = M.IDModel)





----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL MASTER TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		IDModelParent,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		PreInventoryMov PIM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN Model M ON (Total.IDModelParent = M.IDModel)


---###################################################################################################
-- ###### Inventory atualiza as Qty
---###################################################################################################


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		StoreID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		StoreID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)

	WHERE
		M.IDModelParent IS NOT NULL

	GROUP BY
		M.IDModelParent,
		StoreID
	) Total
	JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN InventoryMovType IMT (NOLOCK)  ON (IM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN Model M ON (Total.ModelID = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL MASTER TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		IDModelParent,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)

	WHERE
		M.IDModelParent IS NOT NULL

	GROUP BY
		IDModelParent
	) Total
	JOIN Model M ON (Total.IDModelParent = M.IDModel)







----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o InventoryMovTotals 			
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
	(
	SELECT
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		InventoryMov IM (NOLOCK) 
	GROUP BY
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT  (NOLOCK) 
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year] 
			AND
			Total.[Month] = IMT.[Month] )



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MASTER: Atualiza o InventoryMovTotals 			
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
	(
	SELECT
		IM.StoreID,		M.IDModelParent as ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
	WHERE 
		M.IDModelParent IS NOT NULL
	GROUP BY
		IM.StoreID,
		M.IDModelParent,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT 
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year] 
			AND
			Total.[Month] = IMT.[Month] )
GO
