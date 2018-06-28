if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_TestRefresh]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_TestRefresh]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CC]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Open]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Open]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_PettyCash]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_PettyCash]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Quita_Invoice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Quita_Invoice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Widraw]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Widraw]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_ChangeAgency]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_ChangeAgency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_ChangeGuide]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_ChangeGuide]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CredDiv]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CredDiv]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_DelPayAgency]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_DelPayAgency]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_DelPayGuide]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_DelPayGuide]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_DelPayVendedor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_DelPayVendedor]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CreateCursor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CreateCursor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DailyMaintenance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DailyMaintenance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DropConstraint]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DropConstraint]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Fin_ContaCorrenteAjusta]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Fin_ContaCorrenteAjusta]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_AddColor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_AddColor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_AddSize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_AddSize]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Count]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Count]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Sub_AtuModelName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Sub_AtuModelName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_UpdateABC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_UpdateABC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Invoice_CalcComission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Invoice_CalcComission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Invoice_ChangeSalesPerson]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Invoice_ChangeSalesPerson]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Invoice_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Invoice_Remove]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_ChangeItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_ChangeItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_DeleteItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_DeleteItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_DeletePO]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_DeletePO]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddParcela]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddParcela]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ApplySpecialPrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ApplySpecialPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AtuOpenUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AtuOpenUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CacheCommission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CacheCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcFullTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcFullTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcSalePrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcSalePrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ChangeItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ChangeItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DelOldHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DelOldHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_MaxDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_MaxDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Move]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Move]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Pay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Pay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_RemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_RemoveItem]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcItemDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcItemDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcTax]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcTax]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubRemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubRemoveItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubResetDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubResetDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubTestDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubTestDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_TestPayment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_TestPayment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_UnPay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_UnPay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_UpHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_UpHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPayTypeMin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPayTypeMin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleParcela]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleParcela]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleValue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleValue]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quQtyOnStore]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quQtyOnStore]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_AtuPurchaseSubTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_AtuPurchaseSubTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_CriaPagamento]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_CriaPagamento]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Request_GenerateComputer]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Request_GenerateComputer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Request_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Request_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Select]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Select]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_GetNextCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_GetNextCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_GetUserRights]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_GetUserRights]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_QuickInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_QuickInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SystemUser_GetIDUser]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SystemUser_GetIDUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_System_dbKeys]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_System_dbKeys]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_System_dbTables]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_System_dbTables]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_TourGroup_AddGift]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_TourGroup_AddGift]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_TourGroup_DelGift]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_TourGroup_DelGift]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Util_NextPath]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Util_NextPath]
GO