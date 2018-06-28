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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DailyMaintenance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DailyMaintenance]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_TestRefresh]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_TestRefresh]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_GetUserRights]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_GetUserRights]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sis_QuickInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sis_QuickInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_TourGroup_AddGift]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_TourGroup_AddGift]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_TourGroup_DelGift]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_TourGroup_DelGift]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
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
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError 	INT

SET @ErrorLevel = 0

/* Testa se o final deposit ja foi feito */
if EXISTS (SELECT IDCashRegLog FROM CashRegLog WHERE IDCashRegMov = @IDCashRegMov AND IDCashRegTipoLog = 4) 
   RETURN -1


/*	Update Final Deposit no CashRegMov    */
BEGIN TRANSACTION 

UPDATE
	CashRegMov 
SET	
	FinalWidraw      		= @TotalCash + @TotalCard + @TotalCardPre + @TotalCheck + @TotalOther,
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_CashRegister_Open
		(
		@IDCashRegister 	int,
		@IDUser		int,
		@Bill100		int,
		@Bill50			int,
		@Bill20 			int,
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
		@OpenMoney		money,
		@TotalCash		money,
		@TotalCard		money,
		@TotalCardPre		money,
		@TotalCheck		money,
		@TotalOther 		money,
 		@Date			Datetime,
		@FinalCount		money,
		@IDCashRegLog	int output,
		@IDCashRegMov	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere linha no cashregmov
		- Insere no CashRegLog

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insere linha no cashregmov
		-202  Erro em Insere no CashRegLog


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May 2000		Rodrigo Costa		Criacao;
        	22 Jun 2001             	Davi Gouveia            	Log de Return Values
  	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDCashRegLog, @IDCashRegMov; 
							Removido SELECT @IDCashRegMov = @@IDENTITY;
							Removido SELECT @IDCashRegLog = @@IDENTITY;
	18 Aug 2004		Rodrigo Costa		Gravar error log
  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0


/*	Insere linha no cashregmov	*/

BEGIN TRANSACTION

EXEC sp_Sis_GetNextCode 'CashRegMov.IDCashRegMov', @IDCashRegMov OUTPUT
INSERT
	CashRegMov
	(
	IDCashRegMov,
	IDCashRegister,
	OpenTime,
	IDOpenUser,
	IDCashRegStatus,
 	OpenDeposit
	)
	VALUES
	(
	@IDCashRegMov,
	@IDCashRegister,
	@Date,
	@IDUser,
	1,
	@OpenMoney
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*	Insere no CashRegLog            */

EXEC sp_Sis_GetNextCode 'CashRegLog.IDCashRegLog', @IDCashRegLog OUTPUT
INSERT	
	CashRegLog
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
	TotalOther
	)
	VALUES
	(
	@IDCashRegLog,
	@IDCashRegMov,
	1,
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
	@TotalOther
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Open', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_CashRegister_PettyCash
		(
		@IDCashRegMov  	int,
		@IDUser		int,
		@TotalCash		money,
		@Date			Datetime,
		@IDCashRegLog   	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Total Cash no CashRegMov
		- Insere no CashRegLog

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Update Total Cash no CashRegMov
		-202  Erro em Insere no CashRegLog


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	22 June 2001            	Davi Gouveia           	Log de Return Values
	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDCashRegLog; 
							Removido SELECT @IDCashRegLog = @@IDENTITY;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

/*	Update Total Cash no CashRegMov    */

BEGIN TRANSACTION

UPDATE
	CashRegMov 
SET 
	TotalPetty    = TotalPetty + @TotalCash
WHERE
	IDCashRegMov = @IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
        SET @ErrorLevel = -201
        GOTO ERRO
END;

/*	Insere no CashRegLog            */

exec sp_Sis_GetNextCode 'CashRegLog.IDCashRegLog', @IDCashRegLog OUTPUT
INSERT CashRegLog
	(
	IDCashRegLog,
	IDCashRegMov,
	IDCashRegTipoLog,
	LogTime,
	IDUser,
	TotalCash
	)
	VALUES
	(
	@IDCashRegLog,
	@IDCashRegMov,
	6,
	@Date,
	@IDUser, 
	@TotalCash
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
        SET @ErrorLevel = -202
        GOTO ERRO
END;


OK:
        COMMIT TRANSACTION
        RETURN 0

ERRO:
	ROLLBACK
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_PettyCash', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_CashRegister_Quita_Invoice
	(
	@IDCashRegMov	int,
	@IDUsuario		int,
	@Date			Datetime
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere os registros de quitacao, para os invoices
		- Insiro os Account Payable com as taxas de admim
                - Insere as ligacoes entre Lancamento e Quitacao

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insere os registros de quitacao, para os invoices
		-202  Erro em Insiro os Account Payable com as taxas de admim
		-203  Erro em Insere as ligacoes entre Lancamento e Quitacao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May 2000		Rodrigo Costa		Criacao;
	22 June 2001		Davi Gouveia		Log de Return Values
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode;
							Criado cursor para Fin_Quitacao e Fin_Lancamento
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

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
DECLARE @IDQuitacao 	Int
DECLARE @Pagando 		TBit
DECLARE @DataQuitacao 	smalldatetime
DECLARE @ValorQuitacao 	TValor
DECLARE @IDQuitacaoMeio 	int
DECLARE @IDUsuarioQuitacao 	int
DECLARE @ValorJuros 		TValor
DECLARE @NumeroMeioQuit 	TCodigoGeral
DECLARE @IDContaCorrente 	int
DECLARE @SparrowInt 		int

--Variáveis de Fin_Lancamento
DECLARE @IDLancamento 		int
DECLARE @DataVencimento 		smalldatetime
DECLARE @DataLancamento 		smalldatetime
DECLARE @ValorNominal 		TValor
DECLARE @IDQuitacaoMeioPrevisto 	int
DECLARE @IDUsuarioLancamento 	int
DECLARE @IDContaCorrentePrevista 	int
DECLARE @IDEmpresa 			int
DECLARE @IDPessoa 			int
DECLARE @IDPessoaTipo 		int 
DECLARE @IDLancamentoTipo 		int 

--Declaração do Cursor de Fin_Quitacao
DECLARE Fin_Quitacao_Cursor CURSOR FOR 
	(SELECT
		0,
		DateAdd(Day, MPB.PrazoRecebimento, @Date ),
		0, -- A LancQuit ira atualizar corretamente este valor
		MP.IDMeioPagBatch,
		@IDUsuario,
		0,
		Convert(Varchar(20), L.IDCashRegMov),
		MPTS.IDContaCorrente,
		L.IDCashRegMov
	FROM
		Fin_Lancamento L
		JOIN
		Invoice I on ( I.IDPresale = L.IDPreSale )
		JOIN 
		MeioPag MP on ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN 
		MeioPag MPB on ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN 
		MeioPagToStore MPTS ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
	WHERE
		L.IDCashRegMov = @IDCashRegMov
		AND
		L.DataLancamento = L.DataVencimento -- Somente os lancamento a vista
		AND
		MP.IDMeioPagBatch IS NOT NULL
	GROUP BY
		DateAdd(Day, MPB.PrazoRecebimento, @Date ),
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
		DateAdd(Day, MPB.PrazoRecebimento, @Date ),
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
		Fin_Lancamento L
		JOIN 
		Invoice I on ( I.IDPresale = L.IDPreSale )
		JOIN 
		MeioPag MP on ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN 
		MeioPag MPB on ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN 
		MeioPagToStore MPTS ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
		JOIN 
		Fin_ContaCorrente CC ON (MPTS.IDContaCorrente = CC.IDContaCorrente)
		JOIN 
		Pessoa P ON (MPB.IDPessoa = P.IDPessoa)
	WHERE
		MPB.AutoDiscountFee = 1
		AND
		L.IDCashRegMov = @IDCashRegMov
		AND
		L.DataLancamento = L.DataVencimento -- Somente os lancamento a vista
		AND
		MPB.IDLancamentoTipo IS NOT NULL
		AND
		MPB.IDPessoa IS NOT NULL
		AND
		IsNull(MPB.TaxaAdmin, 0) <> 0
	GROUP BY
		DateAdd(Day, MPB.PrazoRecebimento, @Date ),
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
		Fin_Lancamento L
		JOIN
		MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)
		JOIN
		Fin_Quitacao Q ON (MP.IDMeioPagBatch = Q.IDQuitacaoMeio)
	WHERE
		L.IDCashRegMov  = @IDCashRegMov
		AND
		Q.SparrowInt = @IDCashRegMov

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
	RETURN @ErrorLevel

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Quita_Invoice', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_CashRegister_Widraw
		(
		@IDCashRegMov	int,
		@IDUser		int,
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
		@TotalOther		money,
		@LogDocument		varchar(20),
		@Date			DateTime,
		@IDCashRegLog   	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Total Widraw no CashRegMov
		- Insere no CashRegLog

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Update Total Widraw no CashRegMov
		-202  Erro em Insere no CashRegLog


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	22 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDCashRegLog; 
							Removido SELECT @IDCashRegLog = @@IDENTITY;
	18 Aug 2004		Rodrigo Costa		Gravar error log
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

/*	Update Total Widraw no CashRegMov    */

BEGIN TRANSACTION


UPDATE
	CashRegMov
SET
	TotalWidraw    = TotalWidraw + @TotalCash + @TotalOther + @TotalCheck + @TotalCard
WHERE
	IDCashRegMov = @IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*	Insere no CashRegLog            */
EXEC sp_Sis_GetNextCode 'CashRegLog.IDCashRegLog', @IDCashRegLog OUTPUT
INSERT	
	CashRegLog
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
	LogDocument
	)
	VALUES
	(
	@IDCashRegLog,
	@IDCashRegMov,
	2,
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
	@LogDocument
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Widraw', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Commission_ChangeAgency
	(
	@IDAgencyOrigem  int,
	@IDAgencyDestino int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Movo os recebimentos
		- Movo os touristgroups

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-202  Erro em Movo os touristgroups


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	22 June 2001		Davi Gouveia		Log de Return Values
	06 July  2001		Rodrigo Costa		Nao transfere os recebimentos da Agencia - Fin_Lancamento
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

-- Movo os touristgroups
UPDATE
	 	Touristgroup
SET	
		IDAgency = @IDAgencyDestino
WHERE
	 	IDAgency = @IDAgencyOrigem
		AND
		IDLancPagAgencia IS NULL

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_ChangeAgency', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Commission_ChangeGuide
	(
	@IDGuiaOrigem  int,
	@IDGuiaDestino int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Movo os recebimentos
		- Movo os touristgroups

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-202  Erro em Movo os touristgroups


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	22 June 2001		Davi Gouveia		Log de Return Values
	06 July  2001		Rodrigo Costa		Nao transfere os recebimentos da Agencia - Fin_Lancamento
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

-- Movo os touristgroups
UPDATE
	Touristgroup
SET
	IDGuide = @IDGuiaDestino
WHERE
	IDGuide = @IDGuiaOrigem
	AND
	IDLancPagGuia IS NULL

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_ChangeGuide', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Commission_CredDiv
		(
		@IDStore		int,
		@IDPessoa 		int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente	int,
		@Commission		money
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Descobre o Centro de Custo
		- Inclui o Lancamento
		- Inclui a quitacao
		- Liga Lancamento com Quitacao

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inclui o Lancamento
		-202  Erro em Inclui a quitacao
		-203  Erro em Liga Lancamento com Quitacao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	22 June 2001		Davi Gouveia		Log de Return Values
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE  @IDLancamento	int
DECLARE  @IDQuitacao	int
DECLARE  @IDCentroCusto	int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

if not (@IDPessoa > 0)
   RETURN

/*
	Descobre o Centro de Custo
*/
SELECT @IDCentroCusto = ( SELECT IDCentroCusto FROM Store WHERE Store.IDStore = @IDStore )

/*
   	Inclui o Lancamento
*/
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/

EXEC sp_Sis_GetNextCode 'Lancamento.IDLancamento', @IDLancamento OUTPUT

INSERT dbo.Lancamento
		(
		IDLancamento,
 		IDTipoLancamento,
		IDCentroCusto,
		IDPessoa,
		IDTipoDoc,
		DataLancamento,
		DataVencimento,
		ValorPrevisto
		)
		VALUES
		(
		@IDLancamento,
		12,
		@IDCentroCusto,
		@IDPessoa,
		0,
		@PayDate,
		@PayDate,
		@Commission
		)
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*
   	Inclui a quitacao */
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
EXEC sp_Sis_GetNextCode 'Quitacao.IDQuitacao', @IDQuitacao OUTPUT

INSERT	dbo.Quitacao
		(
		IDQuitacao,
		DataQuitacao,
		ValorQuitacao,
		IDMeioPag,
		TotalJuros,
		IDContaCorrente,
		DataDesbloqueio
		)
		VALUES
		(
		@IDQuitacao,
		@PayDate,
		@Commission,
		@IDMeioPag,
		0,
		@IDContaCorrente,
		@PayDate
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*
	Liga Lancamento com Quitacao
*/
INSERT	dbo.LancamentoToQuit
		(
		IDLancamento,
		IDQuitacao,
		ValorQuitado,
		Juros
		)
		VALUES
		(
		@IDLancamento,
		@IDQuitacao,
		@Commission,
		0
		)

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_CredDiv', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
	Fin_Quitacao Q
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Commission_DelPayGuide
		(
		@IDGuide		int,
		@IDLancamento	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto Lancamento/Quitacao
		- Deleto Quitacao
		- Deleto Lancamento
		- Deleta o Lancamento no Cost do Grupo
		- Deleta o pagamento nos grupos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto Lancamento/Quitacao
		-202  Erro em Deleto Quitacao
		-203  Erro em Deleto Lancamento
		-204  Erro em Deleta o Lancamento no Cost do Grupo
		-205  Erro em Deleta o pagamento nos grupos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	22 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @IDQuitacao 	int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

if not (@IDGuide > 0)
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
DELETE 
	Q
FROM
	Fin_Quitacao Q
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
/*	      Deleta o Lancamento no Cost do Grupo	          */
/*----------------------------------------------------------------*/

DELETE GroupCost 

WHERE IDCostType = 3 and
      IDTouristGroup in
  (SELECT 	IDTouristGroup
   FROM 	dbo.TouristGroup	 TG
   WHERE	TG.IDLancPagGuia = @IDLancamento )

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*		Deleta o pagamento nos grupos			  */
/*----------------------------------------------------------------*/
UPDATE	TouristGroup
SET	IDLancPagGuia = NULL
WHERE	IDGuide = @IDGuide 		AND
	IDLancPagGuia = @IDLancamento

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_DelPayGuide', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Commission_DelPayVendedor
		(
		@IDVendedor		int,
		@IDLancamento	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto Lancamento/Quitacao
		- Deleto Quitacao
		- Deleto Lancamento
		- Deleta o pagamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto Lancamento/Quitacao
		-202  Erro em Deleto Quitacao
		-203  Erro em Deleto Lancamento
		-204  Erro em Deleta o Lancamento no Cost do Grupo


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	22 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDQuitacao 	int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

if not (@IDVendedor > 0)
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
DELETE 	Q
FROM
	Fin_Quitacao Q
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


/*----------------------------------------------------------------*/
/*		Deleta o pagamento 				  */
/*----------------------------------------------------------------*/
DELETE  ComisPaga
WHERE	IDLancPag = @IDLancamento

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_DelPayVendedor', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
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
	Store S
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
	TouristGroup TG
	JOIN Pessoa PG
		ON (TG.IDGuide = PG.IDPessoa)
	JOIN Invoice I 
		ON (TG.IDTouristGroup = I.IDTouristGroup)
	JOIN vwCommission C 
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
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
	Store S
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
	TouristGroup TG
	JOIN Pessoa P
		ON (TG.IDGuide = P.IDPessoa)
	JOIN Invoice I 
		ON (TG.IDTouristGroup = I.IDTouristGroup)
	JOIN vwCommission C 
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
			TouristGroup

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
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
	Store S
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
	InventoryMov
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Commission_PayVendedor
		(
		@IDStore		int,
		@IDVendedor 		int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente   	int,
		@Commission		money,
		@DataIni		smalldatetime,
		@DataFim		smalldatetime,
		@IDUser		int,
		@IDLancamento	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Seleciono os Centro de Custo
		- Incluo no Fin_Lancamento

	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-201  Erro em Select Centro Custo
		-202  Erro em Insert Fin_Lancamento
		-203  Erro em Insert Fin_Quitacao
		-204  Erro em Insert ComisPaga

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 Maio 2000		Eduardo Costa		suporte ao novo financeiro;
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDQuitacao		int
DECLARE @IDCentroCusto 	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

IF NOT (@IDVendedor > 0)
   RETURN

BEGIN TRAN



-- Pega as constantes
SELECT 	
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM
	Store S 
	JOIN MeioPagToStore MPS ON (S.IDStore = MPS.IDStore)
WHERE	
	S.IDStore = @IDStore
	AND
	MPS.IDMeioPag = @IDMeioPag

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*		Inclui o registro do pagamento			  */
/*----------------------------------------------------------------*/



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
		IDEmpresa,
		IDPessoaTipo,
		IDPessoa,
		IDDocumentoTipo,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal,
		IDUsuarioLancamento
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
		(
		SELECT 	L.IDLancamento,
				@IDQuitacao,
				(L.ValorNominal - L.TotalQuitado),
				0,
				@IDUser
		FROM		Fin_Lancamento L
		WHERE	L.IDPessoa = @IDVendedor
				AND
				L.Situacao in (1,5) -- 1=Aberto, 5=ParteQuitado
				AND
				(
				L.IDLancamento = @IDLancamento
				OR
				L.IDLancamentoTipo = 3 -- Correcao de comissao
				OR
				L.IDLancamentoTipo = 5 -- Extorno de comissao
				)
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
INSERT ComisPaga
	(
	IDDocumento,
	IDLancPag
	)
	SELECT
		InvMov.IDInventoryMov,
		@IDLancamento
	FROM
		dbo.InventoryMov         InvMov  (NOLOCK)
		LEFT OUTER JOIN 
		ComisPaga ON (InvMov.IDInventoryMov = ComisPaga.IDDocumento )
	WHERE
		( InvMov.ComissionID = @IDVendedor )
		AND	
		( InvMov.InventMovTypeID = 1 )
		AND
		( InvMov.MovDate >= @DataIni )
		AND
		( InvMov.MovDate < @DataFim )
		AND
		( ComisPaga.IDLancPag IS NULL )

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_PayVendedor', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
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
DECLARE @Qty 		int 
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
		PO
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
	CotacaoResult CR
	JOIN CotacaoToModel CTM ON (CR.IDModel = CTM.IDModel AND CR.IDCotacao =CTM.IDCotacao)
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_DailyMaintenance
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Deleta os holds antigos

		- Deleto PreInventoryMov
		- Deleto Invoice
		- Atualizo Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto PreInventoryMov
		-202  Erro em Deleto Invoice
		-203  Erro em Atualizo Model
		-204  Erro em EXEC sp_PO_CalcOrderPoint


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

BEGIN TRANSACTION

DECLARE @DelHoldDay	int
DECLARE @DelItemMonth	int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

SELECT 	@DelHoldDay = Convert(Int, SrvValue) FROM Param WHERE IDParam = 18
SELECT 	@DelItemMonth = Convert(Int, SrvValue) FROM Param WHERE IDParam = 17

-- Garanto que nao estao nulos
SELECT @DelHoldDay = IsNull(@DelHoldDay, 0) 
SELECT @DelItemMonth = IsNull(@DelItemMonth, 0)


IF @DelHoldDay > 0
BEGIN
	-- Deleto PreInventoryMov
	DELETE
		PreInventoryMov
	FROM
		Invoice
	WHERE
		DocumentID = Invoice.IDPreSale
		AND
		PreInventoryMov.InventMovTypeID = 1
		AND
		Invoice.IDInvoice IS NULL
		AND
		DateAdd(dd, @DelHoldDay, IsNull(EstimatedPay, Invoice.PreSaleDate)) < GetDate()
		AND
		Layaway <> 1

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
		DateAdd(dd, @DelHoldDay, IsNull(EstimatedPay, Invoice.PreSaleDate)) < GetDate()
		AND
		Layaway <> 1

	IF @@ERROR <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END

IF @DelItemMonth > 0
BEGIN
	SELECT
		IDModel
	INTO 
		#ModelToDelete
	FROM
		Model 
		JOIN 
		Inventory I ON (Model.IDModel = I.ModelID)
	WHERE
		DateAdd(mm, @DelItemMonth, Model.LastMovDate) < GetDate()
		AND
		Model.LastMovDate IS Not Null
		AND
		Desativado = 0
	GROUP BY 
		IDModel
	HAVING
		SUM(I.QtyOnHand) = 0

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
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	DROP TABLE #ModelToDelete
END


EXEC sp_PO_CalcOrderPoint

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Fin_ContaCorrenteAjusta
	(
	@IDContaCorrente	int,
	@Valor			TValor,
	@Data			DateTime,
	@IDUsuario		int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Inclui um ajuste de conta corrente
                fazendo uma quitacao de ajuste

		- Ajusta a data do ajuste, para que fique na ultima hora do dia
		Para isto somo um dia e subtraio um minuto


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inclui a Quitacao
		-202  Erro em sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDQuitacao; 
							Removido SELECT @IDQuitacao = @@Identity;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

BEGIN TRAN


SELECT @Data = DateAdd(minute, -1, DateAdd(day, 1, @Data))
DECLARE @IDLancamento	int
DECLARE @IDQuitacao		int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

-- Inclui a Quitacao
EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

IF @Valor > 0
BEGIN
	INSERT Fin_Quitacao
		(
		IDQuitacao,
		Pagando,
		IDContaCorrente,
		IDUsuarioQuitacao,
		ValorQuitacao,
		ValorJuros,
		DataQuitacao,
		IDQuitacaoMeio
		)
	VALUES
		(
		@IDQuitacao,
		0,
		@IDContaCorrente,
		@IDUsuario,
		@Valor,
		0,
		@Data,
		12
		)
END
ELSE
BEGIN
	INSERT Fin_Quitacao
		(
		IDQuitacao,
		Pagando,
		IDContaCorrente,
		IDUsuarioQuitacao,
		ValorQuitacao,
		ValorJuros,
		DataQuitacao,
		IDQuitacaoMeio
		)
	VALUES
		(
		@IDQuitacao,
		1,
		@IDContaCorrente,
		@IDUsuario,
		@Valor * -1,
		0,
		@Data,
		12 -- Ajuste de Saldo de Conta Corrente
		)
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Fin_ContaCorrenteAjusta', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Fin_CriaLacamento_Disburse
	(
	@IDLancamentoParent 	int,
	@Total			money,
	@NumDuplicata		varchar(20)
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo as informacoes dos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em incluo o lancamento Disbursement


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	13 May	2002		Rodrigo Costa		Criacao
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaração de Fin_Lancamento_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDLancamento 		int
DECLARE @Pagando 			bit 
DECLARE @IDLancamentoTipo 		int 
DECLARE @DataLancamento 		smalldatetime 
DECLARE @IDUsuarioLancamento 	int 
DECLARE @Previsao 			bit 
DECLARE @Situacao 			int 
DECLARE @IDPessoaTipo 		int 
DECLARE @IDPessoa 			int 
DECLARE @IDEmpresa 			int 
DECLARE @DataVencimento 		smalldatetime 
DECLARE @DataEmissao 		datetime 
DECLARE @IDDocumentoTipo 		int 
DECLARE @ValorNominal 		money 
DECLARE @NumDocumento 		varchar(20)
DECLARE @IDPurchase 		int 
DECLARE @IDMoeda 			int 
DECLARE @IDMoedaCotacao 		int 
DECLARE @LancamentoType 		int 

SET @ErrorLevel = 0

	--Lancamento Disbursement
	--Declaração do Cursor de Fin_Lancamento

DECLARE Fin_Lancamento_Cursor CURSOR FOR

	SELECT
		LP.Pagando,
		LP.IDLancamentoTipo,
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
		Fin_Lancamento LP
	WHERE
		LP.IDLancamento = @IDLancamentoParent
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
	@IDMoeda,
	@IDMoedaCotacao,
	@LancamentoType,
	@IDLancamentoParent,
	@NumDuplicata

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
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
		@LancamentoType,
		@IDLancamentoParent,
		@NumDuplicata	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Fin_Lancamento_Cursor
		DEALLOCATE Fin_Lancamento_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
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
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType,
		@IDLancamentoParent,
		@NumDuplicata
END
--fechamento do cursor
CLOSE Fin_Lancamento_Cursor
--Destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
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
		Fin_Transferencia T
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
DELETE
	Q
FROM
	Fin_Quitacao
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Inventory_AddColor
	(
	@IDModel			int,
	@IDColor			int
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
	-204  Erro em EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 Nov  2000		Eduardo Costa		Criação;
	25 June 2001		Davi Gouveia		Log de Return Values
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Model_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
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

BEGIN TRAN


-- Testa se a cor já existe
IF EXISTS (SELECT IDModel FROM Model WHERE IDModelParent = @IDModel AND IDColor = @IDColor)
BEGIN
	PRINT 'ERROR: Model already contains this color !'
	SET @ErrorLevel = -201
	GOTO ERRO
END


IF EXISTS(SELECT IDModel FROM Model WHERE IDModelParent = @IDModel AND IDColor IS NULL)
BEGIN
	-- Atualizo a cor do model
	UPDATE
		M
	SET
		M.IDColor = @IDColor
	FROM
		Model M
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
		M.Hidden
	FROM
		Model M
		LEFT OUTER JOIN (SELECT IDModelParent, IDSize FROM Model WHERE IDModelParent = @IDModel GROUP BY IDModelParent, IDSize) MS ON (M.IDModel = MS.IDModelParent)
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
	@Hidden
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
		Hidden
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
		@Hidden	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Model_Cursor
		DEALLOCATE Model_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
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
		@Hidden
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_AddColor', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_Inventory_AddSize
	(
	@IDModel	int,
	@IDSize	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa qual das sub's devo rodar
		- Atualizo o model


	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-204  Size exist
	-201  Erro em Atualizo o model
	-202  Erro em Insiro submodel
	-203  Erro em EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 Nov  2000		Eduardo Costa		Criação;
	25 June 2001		Davi Gouveia		Log de Return Values
	12 August 2003		Rodrigo Costa		Size exist test
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Model_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @CurrentNumberOfSize 	int

--Declaração de variáveis para o Cursor de Model
DECLARE @Model 			varchar(30)
DECLARE @IDColor 			int 
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

BEGIN TRAN

-- Testa se a cor já existe
IF EXISTS (SELECT IDModel FROM Model WHERE IDModelParent = @IDModel AND IDSize = @IDSize)
BEGIN
	PRINT 'ERROR: Model already contains this size !'
	SET @ErrorLevel = -204
	GOTO ERRO
END


-- Testa qual das sub's devo rodar
SELECT
	@CurrentNumberOfSize = COUNT(IDSize)
FROM
	Model
WHERE
	IDModelParent = @IDModel
	AND
	IDSize IS NOT NULL



IF EXISTS(SELECT IDModel FROM Model WHERE IDModelParent = @IDModel AND IDSize IS NULL)
BEGIN
	-- Atualizo o model
	UPDATE
		M
	SET
		M.IDSize = @IDSize
	FROM
		Model M
	WHERE
		M.IDModelParent = @IDModel

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
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
		M.Hidden
	FROM
		Model M
		LEFT OUTER JOIN 
		(SELECT 
			IDModelParent, 
			IDColor 
		FROM 
			Model 
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
	@Hidden
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
		Hidden
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
		@Hidden	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Model_Cursor
		DEALLOCATE Model_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
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
		@Hidden
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
	SET @ErrorLevel = -203
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_AddSize', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Inventory_Count
		(
		@IDModel    	int,
		@IDStore      	int,
		@Difference 	int,
		@CountDate 	SmallDateTime,
		@IDUser	int,
		@Date		Datetime,
		@Notes		varchar(255) -- Davi
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
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDInventoryMov; 
							Criado @IDInventoryMov;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @TotalMov		int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov	int

SET @ErrorLevel = 0

SELECT @TotalMov = (
		SELECT
			SUM(IM.Qty * (2*IMT.UpdateOnHand-1))
		FROM
			InventoryMov IM Inner Join InventoryMovType IMT on (IM.InventMovTypeID = IMT.IDInventMovType)
		WHERE
			IM.StoreID = @IDStore     
			AND
			IM.ModelID = @IDModel     	
			AND
			IM.MovDate > @CountDate
		   )


SELECT @TotalMov = IsNull(@TotalMov,0)


EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
if (@Difference + @TotalMov) > 0
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
				IDUser,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				21,
				0,
				@IDStore,
				@IDModel,
				@Date,
				Abs(@Difference + @TotalMov),
				@IDUser,
				@Notes
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

end
else
begin
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
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				22,
				0,
				@IDStore,
 				@IDModel,
				@Date,
				Abs(@Difference + @TotalMov),
				@IDUser,
				@Notes
				)
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Count', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
	Model MM
	JOIN 
	Model M  ON (M.IDModelParent = MM.IDModel)
	LEFT OUTER JOIN 
	InvColor C ON (M.IDColor = C.IDColor)
	LEFT OUTER JOIN 
	InvSize S ON (M.IDSize = S.IDSize)
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_Inventory_UpdateABC
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Classifiçao ABC do Inventário

		- Crio uma tabela temporaria, ordenada descendentemente por Profit
		- Marco a Primeira fatia como A, a intermediaria como B e o resto como C
		- Uso a tabela temporaria para atualizar os modelos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Marco as linhas conforme os cortes definidos nos parametros
		-202  Erro em Atualizo os Modelos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	09 Sept 1999		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ActualLine 	Int
DECLARE @TotalItems 	Int
DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	ModelID, -- Modelo ordenado DESC por profit
	' ' ABC  -- Para ser preenchido depois
INTO 
	#ABCTemp
FROM
	InventoryMovTotal
WHERE	((
	Year = (DatePart(Year, GetDate()) - 1)
	AND
	Month > DatePart(Month, GetDate())
	)
	OR
	(
	Year = DatePart(Year, GetDate())
	AND
	Month <= DatePart(Month, GetDate())
	))
	AND
	InventMovTypeID = 1
GROUP BY
	ModelID
ORDER BY
	SUM(TotSale - TotCost) DESC

-- Inicializo o contador da linha
SELECT  @ActualLine = 0


-- Guardo quantas linhas existem
SELECT 
	@TotalItems = COUNT(ModelID)
FROM 	
	#ABCTemp

 
-- Marco as linhas conforme os cortes definidos nos parametros
UPDATE 
	#ABCTemp
SET
	@ActualLine = @ActualLine + 1,
	ABC = 	CASE
			WHEN 	@ActualLine <= (@TotalItems * .20) THEN 'A'

			WHEN 	((@TotalItems * .20) < @ActualLine)
				AND
				(@ActualLine <= (@TotalItems * .70)) THEN 'B'

			ELSE  'C'
		END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


-- Atualizo os Modelos
UPDATE
	Model
SET
	Model.ClasseABC = ABCT.ABC
FROM
	#ABCTemp ABCT
WHERE
	Model.ClasseABC <> 'E'
	AND
	Model.ClasseABC <> ABCT.ABC
	AND
	Model.IDModel = ABCT.ModelID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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

if (SELECT PayComission FROM Media WHERE Media.IDMedia = (SELECT MediaID FROM Invoice WHERE IDInvoice = @IDInvoice)) = 1
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
			InvMov.ComissionID,
			IsNull	( SUM 	(
					(IsNull(GroupToComType.Comission, 0)/100) *
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
			dbo.InventoryMov InvMov,
			dbo.Model Model,
			dbo.GroupToComissionType GroupToComType,
			dbo.vwComissionado Comis,
			dbo.vwTipoComissionado TipoComissionado
		WHERE	
			InvMov.DocumentID = @IDInvoice 
			AND
			InvMov.InventMovTypeID = 1
			AND
			InvMov.ModelID = Model.IDModel 
			AND
			Comis.IDComissionado    = InvMov.ComissionID
			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado 
			AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado
			AND
			GroupToComType.GroupID = Model.GroupID
			AND
			InvMov.IDInventoryMov = IsNull(@IDInventoryMov, InvMov.IDInventoryMov)
		GROUP BY 
			InvMov.ComissionID
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
						Fin_Lancamento L
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
 	dbo.InventoryMov 	InvMov
WHERE
	InvMov.DocumentID = @IDInvoice
	AND
	InvMov.InventMovTypeID = 1
	AND
	InvMov.ComissionID = IC.IDComission

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Invoice_ChangeSalesPerson
		(
		@IsInvoice		bit,
		@IDInventoryMov	int,
		@IDNewComission	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Troca o Vendedor

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no primeiro update
		-202  Erro no segundo update


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	16 Nov  1999		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

IF @IsInvoice = 1
BEGIN
	UPDATE InventoryMov SET ComissionID = @IDNewComission WHERE IDInventoryMov = @IDInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
END
ELSE
BEGIN
	UPDATE PreInventoryMov SET ComissionID = @IDNewComission WHERE IDPreInventoryMov = @IDInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_ChangeSalesPerson', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Invoice_Remove
			(
			@InvoiceID   int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Cash RegisterMovent
		- Remove the Inventory Mov
		- Remove the Serial Mov
		- Remove as prestacaoes do finacneiro
		- Remove the Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Update Cash RegisterMovent
		-202  Erro em Remove the Inventory Mov
		-203  Erro em Remove the Serial Mov
		-204  Erro em Remove as prestacaoes do finacneiro
		-205  Erro em Remove the Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/*----------------------------------------------------------------*/
/*		Update Cash RegisterMovent    		     	  */
/*----------------------------------------------------------------*/

UPDATE 
	dbo.CashRegMov
SET 	
	dbo.CashRegMov.TotalSales = IsNull(dbo.CashRegMov.TotalSales, 0) -
	   	  		    IsNull(IsNull(Inv.SubTotal, 0) - IsNull(Inv.ItemDiscount, 0) +
				    IsNull(Inv.Tax, 0), 0) FROM	
	Invoice	Inv WHERE	
	Inv.IDInvoice = @InvoiceID   
	AND
	CashRegMov.IDCashRegMov = Inv.CashRegMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*			Remove the Inventory Mov		  */
/*----------------------------------------------------------------*/

DELETE
	dbo.InventoryMov
WHERE 	dbo.InventoryMov.DocumentID = @InvoiceID 	AND 	dbo.InventoryMov.InventMovTypeID = 1


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*			Remove the Serial Mov			  */
/*----------------------------------------------------------------*/
 
DELETE
	dbo.SerialMov
FROM
	dbo.InventoryMov InvMov
WHERE
 	InvMov.IDInventoryMov  = dbo.SerialMov.InventoryMovID
 	AND
 	InvMov.DocumentID = @InvoiceID
	AND
	InvMov.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*-------------------------------------------------------------------------------------------------------------------------------*/
/*			Remove as prestacaoes do finacneiro 	        	          */ 
/*-------------------------------------------------------------------------------------------------------------------------------*/

DELETE
	L
FROM
	Fin_Lancamento L
	JOIN
	Invoice I ON (L.IDPreSale = I.IDPreSale)
WHERE
	I.IDInvoice = @InvoiceID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END



/*----------------------------------------------------------------*/
/*			Remove the Invoice 	        	  */ 
/*----------------------------------------------------------------*/

DELETE
 	dbo.Invoice 
WHERE
	dbo.Invoice.IDInvoice = @InvoiceID

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
			dbo.InventoryMov InvMov,
			dbo.Model Model,
			dbo.GroupToComissionType GroupToComType,
			dbo.vwComissionado Comis,
			dbo.vwTipoComissionado TipoComissionado

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
			dbo.InventoryMov InvMov, 
			dbo.Model Model,
			dbo.GroupToComissionType GroupToComType, 
			dbo.vwComissionado Comis,
			dbo.vwTipoComissionado TipoComissionado
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
			TouristGroup
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
			TouristGroup
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Model_Adjust
		(
	             @QtyOnOrder        	int,
	             @QtyOnRepair       	int,
		@QtyOnPrePurchase  	int,
		@IDModel    	   	int,
		@IDStore      	   	int,
		@Difference 	   	int,
		@IDUser		int,
		@Date			Datetime,
		@Notes			varchar(255) -- Davi
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


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDInventoryMov; 
							Criado @IDInventoryMov;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov	int

SET @ErrorLevel = 0

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
				Notes --Davi
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
				@Notes --Davi
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
				IDUser,
				Notes --Davi
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
				@Notes --Davi
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Model_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PO_AddItem
		(
		@IDUser		int,
		@IDModel     		int,
		@IDFornecedor		int,
		@IDStore     		int,
		@Qty         		int,
		@CostPrice      		money,
		@SalePrice      		money,
		@SuggRetail      	money,
		@DataPedido    		smalldatetime,
		@EstimatedDate	smalldatetime,
		@IDPOItem 	  	int		Output,
		@BalanceRequest	bit
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
			dbo.PO PO
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
	MODEL
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
SELECT @SubTotal = @Qty*@CostPrice 
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
				dbo.Request
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
	SELECT @Description = (SELECT Description FROM Model WHERE IDModel = @IDModel)

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
			SUM((PIM.Qty - PIM.QtyRealMov) * PIM.CostPrice)
		FROM
			PreInventoryMov PIM
			JOIN Model M ON (PIM.ModelID = M.IDModel) 
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PO_CalcOrderPoint
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
	18 Aug 2004		Rodrigo Costa		Gravar error log
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
DECLARE @SysError		int
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
			DailyMaintenanceReport
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

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

SELECT @DMP = @IDDayMaint

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

SET @SysError = @@ERROR
IF @SysError <> 0
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
		InventoryMov IM
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

SET @SysError = @@ERROR
IF @SysError <> 0
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
		InventoryMov IM
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

SET @SysError = @@ERROR
IF @SysError <> 0
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

SET @SysError = @@ERROR
IF @SysError <> 0
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

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

-- Calculo SX2
UPDATE
	Model
SET	
	SX2 = IsNull((SX2 + POWER(VD,2) - POWER(VP,2)), POWER(VD,2))

SET @SysError = @@ERROR
IF @SysError <> 0
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
		ELSE SQRT((@N * SX2 - POWER(SX, 2))/(@N*(@N-1)))
	      END

SET @SysError = @@ERROR
IF @SysError <> 0
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

SET @SysError = @@ERROR
IF @SysError <> 0
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

SET @SysError = @@ERROR
IF @SysError <> 0
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

SET @SysError = @@ERROR
IF @SysError <> 0
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

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END

/* Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido */
--Declaração do Cursor de Request
DECLARE Request_Cursor CURSOR FOR

	SELECT	
		IDModel,
		Description,
		0,
		1,
		GetDate(),
		'C',
		1
	FROM	
		Model
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

	SET @SysError = @@ERROR
	IF @SysError <> 0
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


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PO_ChangeItem
		(
		@IDModel                	int,
		@IDPOItem 	  	int,
		@IDPO			int,
		@Qty			int,
		@CostPrice		money,
		@SalePrice		money,
		@SuggRetail		money,
		@DataPedido    		smalldatetime,
		@EstimatedDate	smalldatetime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Descobre os valores antigos para atualizar o PO
		- Muda os valores do POItem atual
		- Atualiza o Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Descobre os valores antigos para atualizar o PO
		-202  Erro em Muda os valores do POItem atual
		-203  Erro em Atualiza o Model
		-204  Erro em exec sp_PO_AtuPOTotal @IDPO, @SubTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @SubTotal	money
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*             Descobre os valores antigos para atualizar o PO                  */
/*------------------------------------------------------------------------------*/

SELECT @SubTotal = 	(
			SELECT 	-(Qty*CostPrice)
			FROM 	dbo.vwPOItem
			WHERE 	IDPOItem = @IDPOItem
			)


EXEC sp_PO_AtuPOTotal @IDPO, @SubTotal

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

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
	SET @ErrorLevel = -202
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
	MODEL
WHERE
	IDModel = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

SELECT @SubTotal = (@Qty*@CostPrice)

EXEC sp_PO_AtuPOTotal @IDPO, @SubTotal

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
		
		- Atualiza o total do PO
		- Testa se o numero de itens chegou a zero e deleta o PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualiza o total do PO
		-202  Erro em Testa se o numero de itens chegou a zero e deleta o PO


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @CountItem 	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*                Atualiza o total do PO					*/
/*------------------------------------------------------------------------------*/

SELECT @SubTotal = -@SubTotal

EXEC sp_PO_AtuPOTotal @IDPO, @SubTotal

DELETE FROM dbo.vwPOItem WHERE dbo.vwPOItem.IDPOItem = @IDPOItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                Testa se o numero de itens chegou a zero e deleta o PO	*/
/*------------------------------------------------------------------------------*/

SELECT @CountItem = 	(
			SELECT 
				Count(*)
			FROM 
				dbo.vwPOItem 			WHERE 
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PO_DeletePO
		( 
		@IDPO     		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto POItem
		- Deleto PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto POItem
		-202  Erro em Deleto PO


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

-- Deleto POItem
DELETE FROM dbo.vwPOItem WHERE dbo.vwPOItem.IDPO = @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END
 
-- Deleto PO
DELETE FROM dbo.PO WHERE dbo.PO.IDPO = @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK: 	COMMIT TRAN 	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_DeletePO', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
	PO
WHERE
	PO.IDFornecedor = @IDPessoa
	AND
	PO.Aberto   = 1
	AND
	PO.IDStore  = @IDStore


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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deteto a POItemRequest
		-202  Erro em Atualiza o Model
		-203  Erro em Copio os dados do master para os subs
		-204  Erro em Atualiza o total do PO
		-205  Erro em Recrio  a POItemRequest


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @QtyAtual	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

------------------------------------------------------------------------------
-- Deteto a POItemRequest

DELETE
	POIR
FROM
	POItemRequest POIR
	JOIN 
	PreInventoryMov PIM ON (POIR.IDPreInventoryMov = PIM.IDPreInventoryMov)
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
	PreInventoryMov PIM
	JOIN 
	Model M ON (PIM.ModelID = M.IDModel)
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
	PreInventoryMov PIMM
	JOIN 
	PreInventoryMov PIMS ON (PIMM.IDPreInventoryMov = PIMS.IDPreInventoryMovParent)
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
	Request R
	JOIN 
	PreInventoryMov PIM ON (R.ModelID = PIM.ModelID)
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
	PreInventoryMov PIM
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
	Model M
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Removo todoas as relações entre PO e request
		-202  Erro em Removo os subItems
		-203  Erro em Removo o Item
		-204  Erro em Atualizo o total do PO


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
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
	POItemRequest POIR
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
	PreInventoryMov PIM
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
	PreInventoryMov PIM
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

EXEC sp_PO_AtuPOTotal @IDPO

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

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_Item_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
	POItemRequest POIR
	JOIN 
	PreInventoryMov PIM ON (POIR.IDPreInventoryMov = PIM.IDPreInventoryMov)
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
	PreInventoryMov PIM
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_AddItem
		(
		@PreSaleID     		int,
		@IDCliente		int,
		@ModelID     		int,
		@StoreID     		int,
		@UserID      		int,
		@IDComission		int,
		@Qty         		int,
		@SalePrice      		money,
		@CostPrice		money,
		@Discount    		money,
		@MovDate     		smalldatetime,
		@ResetDiscount  	bit	= 0,
		@Manager		bit	= 0,
		@Date			DateTime,
		@PreInventMovID  	int	Output
		)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	SUMARIO

		- Testa se o discount total ainda e valido
		- Inclui a movimentaçao

	TABELA DE ERROS PARA RETURN_VALUE

		 @Result  Ok
		-201      Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202      Erro em exec sp_PreSale_SubResetDiscount
		-203      Erro em exec @Result = sp_PreSale_SubAddItem
		-204      Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @Result		int
DECLARE @Value		money
DECLARE @ErrorLevel		int 
DECLARE @SysError		int

SET @ErrorLevel = 0
 

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/ 

SELECT @Value = IsNUll((@SalePrice * @Qty),0)

IF @Manager = 0 BEGIN
	EXEC @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
							@ModelID,
							@UserID,
							@Discount,
							@Value,
							'I',
							1

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	IF @ResetDiscount = 1 and @Result <> 0
	BEGIN
		EXEC sp_PreSale_SubResetDiscount	@PreSaleID
	END
	ELSE
	BEGIN
		IF @Result <> 0
		BEGIN
			RETURN @Result
		END
	END

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END

/*------------------------------------------------------------------------------*/
/*	        	         Inclui a movimentaçao                          */
/*------------------------------------------------------------------------------*/

BEGIN TRAN

EXEC @Result = sp_PreSale_SubAddItem
					@PreSaleID,
					@IDCliente,
					@ModelID,
					@StoreID,
					@UserID,
					@IDComission,
					@Qty,
					@SalePrice,
					@CostPrice,
					@Discount,
					@MovDate,
					@PreInventMovID		Output

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

if @Result <> 0
	rollback tran
else
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


OK:
	IF @Result = 0
		COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_PreSale_AddParcela
		(
		@IDStore		int,
		@IDUser		int,
		@IDCliente		int,
		@PreSaleID 		int,
		@PreSaleDate		smalldatetime,
		@ExpirationDate	smalldatetime,
		@IDMeioPag		int,
		@Value			money,
		@Authorization  		varchar(50),
		@IDCashRegMov	int,
		@Parcela		varchar(20)
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Pega as constantes
		- Insere o lancamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Pega as constantes
		-202  Erro em Insere o lancamento
		-203  Erro em Update CashReg TotalSales


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	27 June 2001		Davi Gouveia		Log de Return Values
	28 July 2001		Rodrigo Costa		Atualizar o CashReg TotalSales
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDLancamento; 
							Criado @IDLancamento;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @IDCentroCusto	int
DECLARE @IDContaCorrente	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamento	int

SET @ErrorLevel = 0


-- Pega as constantes
SELECT
		@IDCentroCusto = S.IDCentroCusto,
		@IDContaCorrente = MPS.IDContaCorrente,
		@IDEmpresa = S.IDEmpresa
FROM
		Store S
		JOIN MeioPagToStore MPS ON (S.IDStore = MPS.IDStore)
WHERE
		S.IDStore = @IDStore
		AND
		MPS.IDMeioPag = @IDMeioPag

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Insere o lancamento
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT	Fin_Lancamento
		(
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
		IDDesdobramentoTipo
		)
		VALUES
		(
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
		@ExpirationDate,
		@Value,
		@IDMeioPag,
		@IDUser, --Usuario do financeiro
		@Authorization,
		@IDCashRegMov,
		@Parcela,
		1001
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*		Update Cash RegisterMovent    		     	*/
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


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddParcela', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_PreSale_ApplySpecialPrice
		(
		@PreSaleID 		int,
		@SpecialPriceID 	int,
		@Date 			datetime
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
								Model MO,
								SpecialPriceByGroup SP
							WHERE
								PreInventoryMov.ModelID = MO.IDModel
								AND
								MO.GroupID = SP.GroupID
								AND
								SP.SpecialPriceID = @SpecialPriceID
							), Model.SellingPrice)
						,2)
FROM
	Model Model
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
	ModelToSpecialPrice MoToSP,
	model Model
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
	Invoice.TaxIsent = 0
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
		     dbo.Invoice
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_CacheCommission
	(
	@IDInvoice	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro Commissao dos vendedores
		- Calcula a comissao do Guia
		- Calcula a comissao da Agencia

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto de InvoiceCommission
		-202  Erro em Insiro Commissao dos vendedores
		-203  Erro em Calcula a comissao do Guia
		-204  Erro em Calcula a comissao da Agencia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ComGuia		Money
DECLARE @ComAgency	Money
DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0


-- Deleto de InvoiceCommission
DELETE InvoiceCommission WHERE IDInvoice = @IDInvoice

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*
	Insiro Commissao dos vendedores
*/

INSERT InvoiceCommission 		(
		IDInvoice,
		IDPessoa,
		Commission,
		Tipo 		)
		(
		SELECT
			@IDInvoice,
			InvMov.ComissionID,
			IsNull	( SUM 	(
					(IsNull(GroupToComType.Comission, 0)/100) *
					( 						(
							(
	 						IsNull(InvMov.SalePrice, 0)-
							(TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))
							)*IsNull(InvMov.Qty, 0)
						)-IsNull(InvMov.Discount, 0)
					) 				), 0) Comission,
			'S'
		FROM
			dbo.InventoryMov InvMov,
			dbo.Model Model,
			dbo.GroupToComissionType GroupToComType,
			dbo.vwComissionado Comis,
			dbo.vwTipoComissionado TipoComissionado
		WHERE
			InvMov.DocumentID = @IDInvoice 		    			
			AND
			InvMov.InventMovTypeID = 1      				
			AND
			InvMov.ModelID = Model.IDModel 					
			AND
			Comis.IDComissionado    = InvMov.ComissionID			
			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado 	
			AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado 	
			AND 			GroupToComType.GroupID = Model.GroupID
		GROUP BY 
			InvMov.ComissionID 		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao do Guia                 		*/
/*------------------------------------------------------------------------------*/
SELECT 	@ComGuia = IsNull (
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
		FROM 	dbo.TouristGroup 	 TouristGroup,
			dbo.Invoice 		 Invoice ,
			dbo.InventoryMov 	 InvMov,
			dbo.Model 		 Model,
			dbo.GroupToComissionType GroupToComType,
			dbo.vwComissionado 	 Comis,
			dbo.vwTipoComissionado 	 TipoComissionado (NOLOCK)

		WHERE	Invoice.IDInvoice = @IDInvoice					AND
			Invoice.IDTouristGroup = TouristGroup.IDTouristGroup		AND
			InvMov.DocumentID = @IDInvoice           			AND
			InvMov.InventMovTypeID = 1      				AND
			InvMov.ModelID = Model.IDModel 					AND
			Comis.IDComissionado = TouristGroup.IDGuide 			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado 	AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado 	AND
			GroupToComType.GroupID = Model.GroupID
		), 0)



INSERT InvoiceCommission
		(
		IDInvoice,
		IDPessoa,
		Commission,
		Tipo 
		)
		(
		SELECT 	@IDInvoice,
			TG.IDGuide,
			@ComGuia,
			'G'
		FROM 	TouristGroup TG JOIN Invoice I
				ON (TG.IDTouristGroup = I.IDTouristGroup)
		WHERE 	IDInvoice = @IDInvoice
			AND
			TG.IDGuide is not Null
		)


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao da Agencia               		*/
/*------------------------------------------------------------------------------*/

INSERT InvoiceCommission
		(
		IDInvoice,
		IDPessoa,
		Commission,
		Tipo 
		)
		(
		SELECT 	@IDInvoice,
			TG.IDAgency,
			@ComGuia * (TG.ComissaoSobreGuia/100),
			'A'
		FROM 	TouristGroup TG JOIN Invoice I
				ON (TG.IDTouristGroup = I.IDTouristGroup)
		WHERE 	IDInvoice = @IDInvoice
			AND
			TG.IDAgency is not Null
		)

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

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CacheCommission', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
				dbo.PreInventoryMov PreInventoryMov , dbo.Model Model
			WHERE
 				PreInventoryMov.DocumentID  = @IDPreSale
 				AND
 				PreInventoryMov.InventMovTypeID = 1
				AND
			 	PreInventoryMov.ModelID     = Model.IDModel
				AND
				PreInventoryMov.IDParentPack IS Null
			)

SELECT @FullTotal = IsNull(@FullTotal, 0)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_CalcSalePrice

		(
		@ModelID		int,
		@SpecialPriceID 	int,
		@SalePrice 		money Output,
		@CostPrice 		money Output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calculo do valor no modelo e seu custo
		- Calculo o valor do grupo e do modelo


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @Model	money
DECLARE @ModelSP 	money
DECLARE @GroupSP 	money

SET @Model = Null
SET @ModelSP = Null
SET @GroupSP = Null


---------------------------------------------------------------------------------------------------
-- Calculo do valor no modelo e seu custo

SELECT
	@CostPrice = IsNull(M.VendorCost+M.OtherCost+M.FreightCost, 0),
	@Model = IsNull(M.SellingPrice, 0)

FROM
	Model M

WHERE
	M.IDModel = @ModelID

---------------------------------------------------------------------------------------------------
-- Calculo o valor do grupo e do modelo

IF IsNull(@SpecialPriceID,0) > 0
BEGIN


	SELECT
		@GroupSP = (1+(SP.SpecialMarkUp/100) ) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO
		JOIN SpecialPriceByGroup SP
			ON (MO.GroupID = SP.GroupID)
	WHERE
		MO.IDModel = @ModelID
		AND
		SP.SpecialPriceID = @SpecialPriceID


	SELECT
		@ModelSP = (1+(MTSP.MarkUp/100)) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO
		JOIN ModelToSpecialPrice MTSP
			ON (MO.IDModel = MTSP.IDModel)
	WHERE
		MO.IDModel = @ModelID
		AND
		MTSP.IDSpecialPrice = @SpecialPriceID
 END


SET @SalePrice = IsNull(@ModelSP, IsNull(@GroupSP, @Model))
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_ChangeItem
		(
		@PreSaleID      		int,
		@ModelID     		int,
		@UserID      		int,
		@IDComission		int,
		@Qty         		int,
		@SalePrice      		money,
		@CostPrice      		money = Null,
		@Discount    		money,
		@MovDate     		smalldatetime,
		@Manager		bit 	= 0,
		@ResetDiscount	bit	= 0,
		@Date			DateTime,
		@PreInventMovID	int	output 
		)
AS
 /* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove e inclui o inventory moviment
		- Passa os seriais do item antigo para o novo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em exec @result = sp_PreSale_SubRemoveItem
		-204  Erro em exec @result = sp_PreSale_SubAddItem
		-205  Erro em Passa os seriais do item antigo para o novo
		-206  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

 DECLARE @Result  			int
DECLARE @Value			money
DECLARE @StoreID			int
DECLARE @IDCliente			int
DECLARE @IDOldUser			int
DECLARE @OldPreInventoryMovID 	int 
DECLARE @ErrorLevel			int
DECLARE @SysError			int

SET @ErrorLevel = 0


SET @OldPreInventoryMovID = @PreInventMovID

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/
 SELECT @Value = IsNull((@Qty * @SalePrice), 0)

if @Manager = 0
   begin 

	exec @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
							@ModelID,
							@UserID,
 							@Discount,
							@Value,
							'A', 
							@PreInventMovID
  	
	SET @SysError = @@ERROR
	IF @SysError <> 0 	
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
 
	if @ResetDiscount = 1 and @Result <> 0
	   begin
		exec sp_PreSale_SubResetDiscount	@PreSaleID

		SET @SysError = @@ERROR
		IF @SysError <> 0 	
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	   end
	else
	   begin
		if @Result <> 0
		   begin
			Return @Result
		   end 
	   end
   end

/*------------------------------------------------------------------------------*/
/*                            Descobre o Store                                  */
/*------------------------------------------------------------------------------*/

SELECT @StoreID =
	( 
	SELECT StoreID 
	FROM dbo.PreInventoryMov
	WHERE dbo.PreInventoryMov.IDPreInventoryMov = @PreInventMovID
	)

SELECT @IDCliente =
	( 
	SELECT IDPessoa 
	FROM dbo.PreInventoryMov
	WHERE dbo.PreInventoryMov.IDPreInventoryMov = @PreInventMovID
	)

/*-------------------------------------------------------------*/
/*    Efetivamente remove e inclui o inventory moviment        */
/*-------------------------------------------------------------*/
begin tran

exec @result = sp_PreSale_SubRemoveItem	@PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec @result = sp_PreSale_SubAddItem	@PreSaleID,
					@IDCliente,
					@ModelID,
					@StoreID,
 					@UserID,
 					@IDComission,
 					@Qty,
					@SalePrice,
					@CostPrice,
					@Discount,
					@MovDate,
					@PreInventMovID 	output

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Passa os seriais do item antigo para o novo      */
/*-------------------------------------------------------------*/

UPDATE
	PSM
SET
	PSM.PreInventoryMovID = @PreInventMovID
FROM
	PreSerialMov PSM
WHERE
	PSM.PreInventoryMovID = @OldPreInventoryMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


if @Result <> 0 	rollback tran
else
begin
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
	SET @SysError = @@ERROR
	IF @SysError <> 0 	
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
end

OK:
	IF @Result = 0
		COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ChangeItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
	Invoice
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
 
	FROM 	dbo.PreInventoryMov 	PIM,
		dbo.Model	 	MO,
		dbo.TabGroup	 	TG

	WHERE	PIM.DocumentID = @PreSaleID     AND 
		PIM.InventMovTypeID = 1      AND
		PIM.ModelID = MO.IDModel     AND
		MO.GroupID = TG.IDGroup
	) 

SELECT @MaxVendaMin =
	(
	SELECT  MAX(DRMax.TotVendaMin)

	FROM    dbo.DiscRange DRMax, dbo.vwComissionado CO, 
	        dbo.SystemUser SU

	WHERE	SU.IDUser = @UserID AND
		CO.IDComissionado = SU.ComissionID AND
		DRMax.IDTipoComissionado = CO.IDTipoComissionado 	AND 
   		DRMax.TotVendaMin <= IsNull(@ValInvoice, 0)
	)
 

SELECT @MaxDiscount =
	(
		(
		SELECT 	IsNull(DR.PercDiscMax, 0)

		FROM 	dbo.DiscRange  DR,
			dbo.SystemUser SU, 
			dbo.vwComissionado  CO 

		WHERE 	SU.IDUser = @UserID 		AND
			DR.IDTipoComissionado = CO.IDTipoComissionado  AND
			CO.IDComissionado = SU.ComissionID AND 
			DR.TotVendaMin = @MaxVendaMin
		) /100
	) * @ValInvoice
 

SELECT @MaxVendaMin = IsNull(@MaxVendaMin, 0) 
SELECT @MaxDiscount = IsNull(@MaxDiscount, 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_Move
			(
			@IDPreSaleOrigem 	int,
			@IDPreSaleDestino	int 
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo PreInventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualizo PreInventoryMov
		-202  Erro em exec sp_PreSale_SubCalcTotal @IDPreSaleOrigem
		-203  Erro em exec sp_PreSale_SubCalcTotal @IDPreSaleDestino


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

-- Atualizo PreInventoryMov
UPDATE 	PreInventoryMov
	SET	DocumentID = @IDPreSaleDestino,
		Marked = 0
	WHERE	DocumentID = @IDPreSaleOrigem   AND
		InventMovTypeID = 1		AND
		Marked = 1

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END 
exec sp_PreSale_SubCalcTotal @IDPreSaleOrigem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @IDPreSaleDestino

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Move', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_PreSale_Pay
			(
			@PreSaleID		int,
			@IDCashRegMov 	int,
			@PayDate 		smalldatetime,
			@IDStore		int,
			@IDTouristGroup 	int,
			@OtherComID 		int,
			@CashReceived   	money,
			@Date			Datetime,
			@IDInvoice 		int output
			)
AS


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
        - Transforma a PreSale em Sale
	- Move os PreInventMov para o InventMov
	- Move os PreSerialMov para o SerialMov
	- Deleta os seriais do Inventario
	- Deleta Pre Inventory Movement
	- Marca os lancamentos como confimados, e troca o documento
	- Update Cash RegisterMovent
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


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 may  2000		Eduardo Costa		Alteração para suporte as novas tabelas do financeiro;
	27 may  2000   		Eduardo Costa		Criação da rotina de tratamento e retorno de erros;
	14 aug  2000   		Eduardo Costa		A quitação dos lancamentos do invoice foi transferida
							para o close da caixa registradora;
	15 aug  2000		Rodrigo Costa		Novo campo SalesTax para calcular a tax
	26 June 2001		Davi Gouveia		Log de Return Values
	29 June 2001		Rodrigo Costa		Alteracao no delete Serial do Inventory, criado um join com a tbl PreSerialMov
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCode para Invoice; Cursor InventoryMov;
							Deletado INSERT InvoiceGen (BitGen) VALUES (1), SELECT @IDInvoice = @@IDENTITY; 
							Criado Cursor para InvMov
	18 Dec  2003		Andre Bogado		Alteração no cursor de InvMov para atualizar InventoryMovTax
	22 Dec 2003		Rodrigo Costa		Incluir os Serias no Inventory se for Refound
	25 May 2004		Rodrigo Costa		Mover PackModels do PreInvMov para o InvMov
	18 Aug 2004		Rodrigo Costa		Gravar error log
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @DataPagamento  	smalldatetime
DECLARE @ComissionPayed 	money
DECLARE @IDCentroCusto	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 		int 
DECLARE @IDPessoa 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @ComissionID 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDUser 		int 
DECLARE @SalesTax 		money
DECLARE @StoreID 		int
DECLARE @IDInventoryMov		int
DECLARE @IDParentPack		int

--PRINT 'Starting transaction'
BEGIN TRAN

SET  @ErrorLevel = 0

-- Retorna o Centro de Custo referente a loja
SELECT @IDCentroCusto = (SELECT IDCentroCusto  FROM Store WHERE IDStore = @IDStore)

SET @SysError = @@ERROR
IF @SysError <> 0 GOTO ERRO


/*--------------------------------------------------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  					*/
/*--------------------------------------------------------------------------------------------------------*/

-- Calcula o proximo IDInvoice
EXEC sp_Sis_GetNextCode 'InvoiceGen.IDInvoice', @IDInvoice OUTPUT

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
		Invoice.IDStore	 	= @IDStore,
		Invoice.CashRegMovID 	= @IDCashRegMov

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
			PIM.ComissionID,
			PIM.IDPreInventoryMov,
			PIM.UserID,
			(CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
				 THEN TC.SpecialTax ELSE TC.Tax END / 100.00)  as Tax,-- Tax
			PIM.IDParentPack

	FROM		dbo.PreInventoryMov PIM
			JOIN Model M ON ( PIM.ModelID = M.IDModel )
			JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
			JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
			JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )

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
	@ComissionID,
	@PreInventoryMovID,
	@IDUser,
	@SalesTax,
	@IDParentPack
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
		IDPessoa,
		StoreID,
		ModelID,
		BarCodeID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		ComissionID,
		PreInventoryMovID,
		IDUser,
		SalesTax,
		IDParentPack
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
		@ComissionID,
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	-- Insert na tabela de Taxas InventoryMovTax
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
		ISNULL (TC.Tax,0)/100 AS Tax,
		ISNULL (IM.SalePrice * IM.Qty * TC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM
		JOIN Model Mo ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG	ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TC ON (SG.IDTaxCategory = TC.IDTaxCategoryParent)

	WHERE 	IM.IDInventoryMov = @IDInventoryMov

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
		@ComissionID,
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack
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
/*	     Move os PreSerialMov para o SerialMov                	*/
/*--------------------------------------------------------------------------------------------------------*/
INSERT 	dbo.SerialMov ( InventoryMovID,	SerialNumber )

	SELECT	IM.IDInventoryMov,
			PSM.SerialNumber

	FROM		PreSerialMov PSM
			JOIN InventoryMov IM ON (PSM.PreInventoryMovID = IM.PreInventoryMovID)

	WHERE 	IM.DocumentID = @IDInvoice
			AND
			IM.InventMovTypeID = 1

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
		PreInventoryMov PIM, PreSerialMov PSV
WHERE	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		InventorySerial.ModelID = PIM.ModelID
		AND
		InventorySerial.StoreID = @IDStore
		AND
		InventorySerial.Serial = PSV.SerialNumber
		AND
		PIM.Qty > 0

--Refound
INSERT
		InventorySerial (StoreID, ModelID, Serial)
SELECT
		@IDStore,
		PIM.ModelID,	
		PSV.SerialNumber
FROM
		PreInventoryMov PIM
		JOIN PreSerialMov PSV ON (PIM. IDPreInventoryMov = PSV.PreInventoryMovID)
WHERE	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		PIM.Qty < 0
		

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
		PreInventoryMov PIM
WHERE 	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1

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
	InventoryMov IMC
	JOIN InventoryMov IMP ON ( IMP.PreInventoryMovID = IMC.IDParentPack)
WHERE 
	IMC.DocumentID = @DocumentID
	AND
	IMC.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
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


/*--------------------------------------------------------------------------------------------------------*/
/*	Marca os lancamentos como confimados,  	  	*/
/*	e troca o documento					*/
/*--------------------------------------------------------------------------------------------------------*/


UPDATE
	Fin_Lancamento
SET
	NumDocumento = Convert(varchar(50), @IDInvoice),
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


/*--------------------------------------------------------------------------------------------------------*/
/*	Calc commissions for report performace	     		*/
/*	Temporariamente desativa por motivo de performance     	*/
/*--------------------------------------------------------------------------------------------------------*/
/*
PRINT 'Calc Comissions'
EXEC sp_PreSale_CacheCommission @IDInvoice



IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END
*/

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Pay', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_PreSale_Remove
			(
				@PreSaleID	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreSerialMov
		- Remove InventoryMov
		- Deleta os pagamentos
		- Remove o Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Delecao do PreSerialMov
		-202  Erro em Remove the Inventory Mov
		-203  Erro em Cria tabela com as quitacoes a serem deletadas
		-204  Erro em Remove LancQuit
		-205  Erro em Remove as Quitacões
		-206  Erro em Remove Lancamento
		-207  Erro em Remove the Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	19 July   2001		Davi Gouveia		Exclusao de testes se Hold está sendo usado, visto q o teste ja é feito no Delphi
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @IsLayaway	bit
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
SET @ErrorLevel = 0 

BEGIN TRAN

/*--------------------------------------------------------------*/
/*	Delecao do PreSerialMov	        */
/*--------------------------------------------------------------*/
DELETE
	PSM
FROM
	PreInventoryMov PIM
	JOIN PreSerialMov PSM ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
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
/*	Remove the Inventory Mov		  */
/*----------------------------------------------------------------*/

DELETE 
	dbo.PreInventoryMov
WHERE
	dbo.PreInventoryMov.DocumentID = @PreSaleID
	AND
	dbo.PreInventoryMov.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*----------------------------------------------------------------*/
/*	Deleta os pagamentos  	        	  */
/*----------------------------------------------------------------*/

-- Cria tabela com as quitacoes a serem deletadas
SELECT
	Q.IDQuitacao
INTO
	#sp_PreSale_Remove_QuitToDelete
FROM
	Fin_Quitacao Q
	JOIN Fin_LancQuit LQ ON (LQ.IDQuitacao = Q.IDQuitacao)
	JOIN Fin_Lancamento L ON (LQ.IDLancamento = L.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


-- Remove LancQuit
DELETE
	LQ
FROM
	Fin_LancQuit LQ
	JOIN
	Fin_Lancamento L ON (LQ.IDLancamento = L.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


-- Remove as Quitacões
DELETE
	Q
FROM
	Fin_Quitacao Q
	JOIN
	#sp_PreSale_Remove_QuitToDelete QTD ON (QTD.IDQuitacao = Q.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


-- Remove Lancamento

DELETE
	L
FROM
	Fin_Lancamento L
WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


/*----------------------------------------------------------------*/
/*	Remove the Invoice 	        	  */
/*----------------------------------------------------------------*/

DELETE
	I
FROM
	Invoice I
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_RemoveItem
			( 
			@PreSaleID 		int,
			@ModelID		int,
			@UserID 		int,
			@PreInventMovID	int,
			@Discount		money,
			@SalePrice		money,
			@Qty			int,
			@Date			DateTime,
			@ResetDiscount	bit  	= 0,
			@Manager		bit	= 0
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove o inventory moviment

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em Delecao do PreSerialMov
		-204  Erro em exec @result = sp_PreSale_SubRemoveItem
		-205  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @Result  	int 
DECLARE @Value	money
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/ 

SELECT @Value = IsNull((@Qty * @SalePrice), 0) 

if @Manager = 0
   begin
 
	exec @Result = sp_PreSale_SubTestDiscount
						@PreSaleID,
						@ModelID,
						@UserID,
						@Discount,
						@Value,
						'E'
 	
	SET @SysError = @@ERROR
	IF @SysError <> 0
 	BEGIN
 		PRINT '-201'
 		RETURN -201
 	END

 	if @ResetDiscount = 1 and @Result <> 0
	   begin
		exec sp_PreSale_SubResetDiscount	@PreSaleID
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
 			PRINT '-202'
 			RETURN -202
 		END
	   end
	else
	   begin
		if @Result <> 0
		   begin
 			Return @Result
		   end
	   end
   end

/*-------------------------------------------------------------*/
/*          Efetivamente remove o inventory moviment           */
/*-------------------------------------------------------------*/ 
begin tran
 
/*--------------------------------------------------------------*/
/*		Delecao do PreSerialMov	        */
/*--------------------------------------------------------------*/
DELETE
	PSM
FROM
	PreSerialMov PSM
WHERE
	PSM.PreInventoryMovID =  @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec @result = sp_PreSale_SubRemoveItem	@PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END 
 
if @Result <> 0
begin
	SET @ErrorLevel = @Result
	GOTO ERRO
end
else
begin
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
end

OK:
	COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_RemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE sp_PreSale_RemoveSpecialPrice
		(
			@PreSaleID	int,
			@Date  	DateTime
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
			dbo.PreInventoryMov 	PIM,
			dbo.Model 		MO
		WHERE
			PIM.IDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
			AND
			PIM.ModelID    = MO.IDModel
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
	dbo.Invoice.TaxIsent = 0
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
if (SELECT TaxMode FROM	Media WHERE IDMedia = @IDMedia) = 3
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_PreSale_SpecialPriceManager
		(
			@PreSaleID 	int,
			@PercDiscount 	int,
			@Date 		DateTime
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
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 
BEGIN TRAN

UPDATE
	PreInventoryMov SET
	PreInventoryMov.Discount =
        				ROUND(
						IsNull (
							(
							SELECT  ( PreInventoryMov.SalePrice * @PercDiscount / 100) * PreInventoryMov.Qty
		                        		FROM 	Model Model
                                        		WHERE   PreInventoryMov.ModelID = Model.IDModel
								AND
                                        			Model.VendorCost <= ( PreInventoryMov.SalePrice - ( PreInventoryMov.SalePrice  * @PercDiscount / 100) )
		                        				), 0) 							,2)
WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND
       	PreInventoryMov.InventMovTypeID = 1

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
	Invoice.TaxIsent = 0 WHERE
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 		int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @IDPessoa 		int 
DECLARE @DateEstimatedMov 	smalldatetime 
DECLARE @DateRealMov 	smalldatetime 
DECLARE @QtyRealMov 	int 
DECLARE @ComissionID 	int 
DECLARE @IDPreInventoryMov	int


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
			Invoice
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
			ComissionID
		FROM
			dbo.PreInventoryMov
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
	@ComissionID
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
		ComissionID
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
		@ComissionID
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
		@ComissionID
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

exec sp_PreSale_SubCalcTotal @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

EXEC sp_PreSale_SubCalcTotal @NewIDPreSale  

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_PreSale_SubAddItem
		(
		@PreSaleID      int,
		@IDCliente	int,
		@ModelID     	int,
		@StoreID     	int,
		@UserID      	int,
		@IDComission	int,
		@Qty         	int,
 		@SalePrice      money,
		@CostPrice      money = Null,
		@Discount    	money,
		@MovDate     	smalldatetime,
		@PreInventMovID int 		Output
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insert on Inventory Movement

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insert on Inventory Movement


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCod;
	24 May	2004		André Bogado		Criado Cursor para KitModel 
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ComissionID 	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de ModelChild
DECLARE @ModelIDChild  	int 
DECLARE @QtyChild  		int 
DECLARE @PreInvMovIDPack	int

SET @ErrorLevel = 0

BEGIN TRAN

/*-------------------------------------------------------------*/
/*                  Insert on Inventory Movement               */
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
	ComissionID,
	UserID
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
		IsNull(@CostPrice, (VendorCost+OtherCost+FreightCost)),
 		@IDComission,
		@UserID
	FROM
 		dbo.Model
 	WHERE
		dbo.Model.IDModel = @ModelID

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
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
 		dbo.PackModel P
		JOIN dbo.Model M ON (P.IDModel= M.IDModel)
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
	ComissionID,
	UserID,
	IDParentPack
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
 		@IDComission,
		@UserID,
		@PreInventMovID
	FROM
 		dbo.Model
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

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubAddItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

UPDATE
	dbo.Invoice
SET
	dbo.Invoice.ItemDiscount =
		convert(money, convert(numeric(20, 0),
			(
			SELECT
				Sum(IsNull(PIM.Discount,0))
			FROM
				PreInventoryMov PIM
				JOIN
				Model MO
					ON (PIM.ModelID = MO.IDModel)
				JOIN
				TabGroup TG
					ON (MO.GroupID = TG.IDGroup)
			WHERE
				PIM.DocumentID = @PreSaleID
				AND
				PIM.InventMovTypeID = 1
				AND
				TG.Taxable = 1
			)*100)/100),

	dbo.Invoice.TaxIsemptItemDiscount =
		convert(money, convert(numeric(20, 0),
			(
			SELECT
				Sum(IsNull(PIM.Discount,0))
			FROM
				PreInventoryMov PIM
				JOIN
				Model MO
					ON (PIM.ModelID = MO.IDModel)
				JOIN
				TabGroup TG
					ON (MO.GroupID = TG.IDGroup)
 			WHERE
				PIM.DocumentID = @PreSaleID
				AND
				PIM.InventMovTypeID = 1
				AND
				TG.Taxable = 0
			)*100)/100)
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_PreSale_SubCalcTax
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
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @LocalTax 	money
DECLARE @ErrorLevel	int
DECLARE @SysError	int

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

UPDATE
	I
SET
	TaxIsemptValue =
	ROUND(
	(
	SELECT	ISNULL(
			SUM	(
				(PIM.Qty * ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
			 	* (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) THEN TC.SpecialTax ELSE TC.Tax END / 100.00)  -- Tax
				),0)
	FROM	PreInventoryMov PIM
		JOIN
		Model M ON (M.IDModel = PIM.ModelID)
		JOIN
		StoreToTabGroup STG ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
		JOIN
		TaxCategory TC ON (STG.IDTaxCategory = TC.IDTaxCategory)
	WHERE	PIM.DocumentID = @PreSaleID
               	AND
		PIM.InventMovTypeID = 1
		AND
		TC.TaxExempt = 1
	), 2),
        		Tax =
	ROUND(
	(
	SELECT	ISNULL(
			SUM	(
				(PIM.Qty * ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
			 	* (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
					 THEN TC.SpecialTax ELSE TC.Tax END / 100.00)  -- Tax
				),0)
	FROM	PreInventoryMov PIM
		JOIN Model M ON (M.IDModel = PIM.ModelID)
		JOIN StoreToTabGroup STG ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
		JOIN TaxCategory TC ON (STG.IDTaxCategory = TC.IDTaxCategory)
	WHERE	PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		TC.TaxExempt = 0
	),2)
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_SubCalcTotal
		(
		@PreSaleID Int,
		@Date	DateTime
		)
AS
 /* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
	SUMARIO

		- Atualizo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE dbo.Invoice
		-202  Erro em exec sp_PreSale_SubCalcItemDiscount
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

BEGIN TRAN 

UPDATE
	dbo.Invoice
SET
	dbo.Invoice.SubTotal = convert(money, convert(numeric(20, 0),
					(
					SELECT
						SUM((IsNull(PIM.SalePrice, 0)*IsNull(PIM.Qty, 0)))
        					FROM
						dbo.PreInventoryMov PIM
					WHERE
						(PIM.DocumentID = @PreSaleID
						AND
						PIM.InventMovTypeID = 1)
                                        )*100)/100)
WHERE 	dbo.Invoice.IDPreSale = @PreSaleID  IF @@ERROR <> 0 BEGIN
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE sp_PreSale_SubRemoveItem
			(
			@PreInventMovID int
			)
AS 
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete on Pre Inventory Movement Items Packages
		- Delete on Pre Inventory Movement

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Delete
		-202  Erro no Delete PackItems


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	25 May 2004		Rodrigo Costa		Deletar os PackModels
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/*-------------------------------------------------------------*/
/*                  Delete on Pre Inventory Movement Pack           */
/*-------------------------------------------------------------*/

DELETE
	dbo.PreInventoryMov
WHERE
	dbo.PreInventoryMov.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*                  Delete on Pre Inventory Movement           */
/*-------------------------------------------------------------*/

DELETE
	dbo.PreInventoryMov
WHERE
	dbo.PreInventoryMov.IDPreInventoryMov = @PreInventMovID

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubRemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_SubResetDiscount
				(
					@PreSaleID	int
				)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Zera o Discount

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update


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

UPDATE
	dbo.PreInventoryMov
SET
	dbo.PreInventoryMov.Discount = 0
WHERE
	dbo.PreInventoryMov.DocumentID = @PreSaleID
	AND
	dbo.PreInventoryMov.InventMovTypeID = 1

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubResetDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_SubTestDiscount
			(
			@PreSaleID		int,
			@ModelID        		int,
			@UserID		int,
			@Discount  		money,
			@Value    		money,
			@OP			char(1),
			@PreInventMovID	int 	= 0
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
		FROM 	dbo.PreInventoryMov PIM,
			dbo.Model	    MO,
			dbo.TabGroup	    TG
	WHERE	PIM.DocumentID = @PreSaleID     AND
		PIM.InventMovTypeID = 1      AND
		PIM.ModelID = MO.IDModel     AND
		MO.GroupID = TG.IDGroup
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
	SELECT 	IsNull( Sum( IsNull(PIM.Discount,0) ), 0)
	FROM 	dbo.PreInventoryMov PIM
	WHERE 	PIM.DocumentID = @PreSaleID     AND
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
	SELECT  (IsNull( TG.PrcPartDiscount,0 ) / 100)

	FROM 	dbo.Model	 MO,
		dbo.TabGroup	 TG
	WHERE	MO.IDModel = @ModelID     AND
		MO.GroupID = TG.IDGroup
	)

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
					FROM 	dbo.PreInventoryMov PIM
					WHERE	PIM.IDPreInventoryMov = @PreInventMovID
					) * @FatParcDisc, 0)
	SELECT @NewDiscount = IsNull(@Discount, 0) + IsNull(@ItemDiscount, 0) -
					IsNull(
					(
					SELECT 	IsNull( PIM.Discount, 0 )
					FROM 	dbo.PreInventoryMov PIM
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
	FROM    dbo.DiscRange DRMax, dbo.vwComissionado CO,
	        dbo.SystemUser SU
	WHERE	SU.IDUser = @UserID AND
		CO.IDComissionado = SU.ComissionID AND
		DRMax.IDTipoComissionado = CO.IDTipoComissionado 	AND
   		DRMax.TotVendaMin <= IsNull(@NewValInvoice, 0)
	), 0)
SELECT @MaxDiscount = IsNull(
	(
		(
		SELECT 	IsNull(DR.PercDiscMax, 0)

		FROM 	dbo.DiscRange    DR,
			dbo.SystemUser   SU,
			dbo.vwComissionado  CO
		WHERE 	SU.IDUser = @UserID 		AND
			DR.IDTipoComissionado = CO.IDTipoComissionado 	AND 
			CO.IDComissionado = SU.ComissionID AND
			DR.TotVendaMin = @MaxVendaMin
		) /100
	) * @NewValInvoice,0)

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
if (IsNull(@Discount,0) = 0) and (@OP = 'I')
   return 0


if (IsNull(@NewDiscount, 0) > IsNull(@MaxDiscount, 0))
   begin

	if (IsNull(@Discount, 0) > IsNull(@MaxDiscount, 0)) and (@OP <> 'E')
	   return -2
	else
	   return -1
   end
else
   return 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubTestDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
		dbo.MeioPagMinSale MeioPagMinSale
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
	FROM    dbo.MeioPagMinSale 
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
 	 		   FROM 	dbo.Invoice
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_PreSale_UnPay
			(
			@PreSaleID	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Unmove os PreInventMov para o InventMov
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
		-206  Erro em Update Cash RegisterMovent
		-207  Erro em Transforma a PreSale em Sale


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro e suporte a tratamento de erro
	26 June 2001		Davi Gouveia		Log de Return Values
	28 Oct	2003		Rodrigo Costa		Created Cursor for PreInvMov;
							Call sp_GetNextCode;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

DECLARE @IDInvoice 		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @IDPessoa 		int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 		int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @ComissionID 	int 
DECLARE @UserID 		int 
DECLARE @IDPreInventoryMov	int


SET @ErrorLevel = 0

SELECT 	@IDInvoice = IDInvoice
FROM		Invoice
WHERE 	IDPreSale = @PreSaleID

/*----------------------------------------------------------------*/
/*	    Unmove os PreInventMov para o InventMov                */
/*----------------------------------------------------------------*/


--Declaração do Cursor de PreInventoryMov

DECLARE PreInventoryMov_Cursor CURSOR FOR

	SELECT
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
		IM.ComissionID,
		IM.IDUser

	FROM	dbo.InventoryMov IM
	WHERE   IM.DocumentID = @IDInvoice AND
		IM.InventMovTypeID = 1

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
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
	@ComissionID,
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
		ComissionID,
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
		@CostPrice,
		@SalePrice,
		@Discount,
		@ComissionID,
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

	FETCH NEXT FROM PreInventoryMov_Cursor INTO
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
		@ComissionID,
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

/*---------------- Deleta os registros de ligacao -------------------- */
DELETE
	LQ
FROM
	Fin_LancQuit LQ
	JOIN
	Fin_Lancamento 	L ON (L.IDLancamento = LQ.IDLancamento)
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
	Fin_Quitacao Q
	JOIN
	Fin_Lancamento L ON (Q.SparrowInt = L.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID

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

/*----------------------------------------------------------------*/
/*		Update Cash RegisterMovent    		     	  */
/*----------------------------------------------------------------*/ 
UPDATE
	dbo.CashRegMov
SET
	dbo.CashRegMov.TotalSales = IsNull(dbo.CashRegMov.TotalSales, 0) -
		   	  		    IsNull(IsNull(Inv.SubTotal, 0) - IsNull(Inv.ItemDiscount, 0) -
					    IsNull(Inv.Tax, 0), 0) 
FROM
	Invoice	Inv
WHERE
	Inv.IDPreSale = @PreSaleID
	AND
	CashRegMov.IDCashRegMov = Inv.CashRegMovID

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
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_UnPay', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_UpHold
			(
			@IDPreSaleOrigem 	int,
			@IDPreSaleDestino	int,
			@Date			DateTime 
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo PreInventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualizo PreInventoryMov
		-202  Erro em exec sp_PreSale_SubCalcTotal
		-203  Erro em exec sp_PreSale_Remove


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
 -- Atualizo PreInventoryMov
UPDATE
	PreInventoryMov
SET
	DocumentID = @IDPreSaleDestino
WHERE
	DocumentID = @IDPreSaleOrigem
	AND
	InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END 

exec sp_PreSale_SubCalcTotal @IDPreSaleDestino, @Date

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_Remove @IDPreSaleOrigem

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_UpHold', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
	dbo.MeioPagMinSale
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE sp_PreSale_quPreSaleItem
	(
		@DocumentID      	int,
		@IsPreSale		bit,
		@Date			DateTime
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna itens de um determinado PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	15 Aug  2000		Rodrigo Costa		Feito o Join com a Tbl TaxCategory para pegar a tax do Item
	26 June 2001		Davi Gouveia		Log de Return Values
	26 May 2004		Rodrigo Costa		Not display Item Packs
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

if @IsPreSale = 1
begin
	SELECT
		ModelID ,
		M.Model,
		Description ,
		SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		IDSalesPerson as IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		PIM.IDPreInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	 (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
			 THEN TC.SpecialTax ELSE TC.Tax END) as Tax -- Tax
	FROM
		PreInventoryMov PIM
		JOIN
		vwSalesPerson SP ON ( PIM.ComissionID = SP.IDSalesPerson )
		JOIN
		Model M ON ( PIM.ModelID = M.IDModel )
		JOIN
		SystemUser SU ON ( SU.IDUser = PIM.UserID )
		JOIN
		TabGroup TG ON ( M.GroupID = TG.IDGroup )
                JOIN
		StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT OUTER JOIN
		TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	WHERE
		PIM.DocumentID  = @DocumentID
		AND
		PIM.InventMovTypeID = 1
		AND
		PIM.IDParentPack Is Null
	ORDER BY
		SU.IDUser, Model

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
		ModelID ,
		M.Model,
		Description ,
		SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		IDSalesPerson as IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		IDInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	IM.SalesTax as Tax -- Tax
	FROM
		dbo.InventoryMov IM
		JOIN
		vwSalesPerson SP ON ( IM.ComissionID = SP.IDSalesPerson )
		JOIN
		Model M ON ( IM.ModelID = M.IDModel )
		JOIN
		SystemUser SU ON ( SU.IDUser = IM.IDUser )
		JOIN
		TabGroup TG ON ( M.GroupID = TG.IDGroup )
		JOIN
		StoreToTabGroup STC ON ( STC.IDStore = IM.StoreID AND STC.IDGroup = TG.IDGroup )
		JOIN
		TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	WHERE
		IM.DocumentID  = @DocumentID
		AND
 		IM.InventMovTypeID = 1
		AND
		IM.IDParentPack Is Null
	ORDER BY
		SU.IDUser, M.Model

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
	Fin_Lancamento L
	JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_quPreSaleValue
		(
			@PreSaleID 	int
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
	TaxIsent,
	SubTotal ,
	ItemDiscount ,
	Invoice.SpecialPriceID,
	SpecialPrice.SpecialPrice,
	Tax,
	nOpenUser,
	TaxIsemptValue,
	TaxIsemptItemDiscount
FROM
	dbo.Invoice Invoice,
	dbo.SpecialPrice SpecialPrice
WHERE
	IDPreSale = @PreSaleID
	AND
	Invoice.SpecialPriceID *= SpecialPrice.IDSpecialPrice

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_quQtyOnStore
		(
			@ModelID int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna Qtde do Model por Loja

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
	Name ,
	QtyOnPreSale ,
	QtyOnHand ,
	QtyOnOrder ,
	QtyOnRepair,
	StoreID ,
	(VendorCost+OtherCost+FreightCost) as CurrentCost,
	QtyOnPrePurchase
FROM
	dbo.Inventory Inventory ,
	dbo.Model Model ,
	dbo.Store Store
WHERE
	( Store.IDStore = Inventory.StoreID )
	AND
	( Inventory.ModelID = Model.IDModel )
	AND
	( ModelID = @ModelID )

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quQtyOnStore', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Purchase_AtuPurchaseSubTotal
	(
	@IDPurchase	int
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
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN


------------------------------------------------------------------------------
-- Teste se o purchase ja esta na tabela

IF NOT EXISTS (SELECT SubTotal FROM Pur_PurchaseTotal WHERE IDPurchase = @IDPurchase)
	INSERT Pur_PurchaseTotal (IDPurchase, SubTotal) VALUES (@IDPurchase, 0)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Atualizo o SubTotal

UPDATE
	P
SET
	P.SubTotal = PT.SubTotal
FROM
	Pur_PurchaseTotal P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
	JOIN (

		SELECT
			PPI.IDPurchase,
			SUM(IsNull(PPI.NewCostPrice * PPI.Qty, 0)) as SubTotal
		FROM
			Pur_PurchaseItem PPI
		WHERE
			PPI.IDPurchase = @IDPurchase
		GROUP BY
			PPI.IDPurchase

	) as PT ON (P.IDPurchase = PT.IDPurchase)

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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	13 May	2002		Rodrigo Costa		Inserir Lancamentos com Disbursements
	28 Oct	2003		Rodrigo Costa		Create sp_GetNexCode
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDLancamentoParent 	int
DECLARE @SubTotal			money
DECLARE @Freight			money
DECLARE @CriaDisbur			int

--Declaração de variáveis para o Cursor de Fin_Lancamento
DECLARE @Pagando 			bit 
DECLARE @IDLancamentoTipo 		int 
DECLARE @DataLancamento 		smalldatetime 
DECLARE @IDUsuarioLancamento 	int 
DECLARE @Previsao 			bit 
DECLARE @Situacao 			int 
DECLARE @IDPessoaTipo 		int 
DECLARE @IDPessoa 			int 
DECLARE @IDEmpresa 			int 
DECLARE @DataVencimento 		smalldatetime 
DECLARE @DataEmissao 		datetime 
DECLARE @IDDocumentoTipo 		int 
DECLARE @ValorNominal 		money 
DECLARE @NumDocumento 		varchar(20)
DECLARE @IDMoeda 			int 
DECLARE @IDMoedaCotacao 		int 
DECLARE @LancamentoType 		int 
DECLARE @IDLancamento		int


SET @ErrorLevel = 0
SET @CriaDisbur = 0

IF EXISTS (SELECT IDLancamento FROM Fin_Lancamento WHERE IDPurchase = @IDPurchase)
BEGIN
	-- Atualizo as informacoes do Lancamento Parent
	UPDATE
		L
	SET
		L.DataVencimento = P.DocumentDate,
		L.DataEmissao = P.DocumentDate,
		L.NumDocumento = P.DocumentNumber,
		L.ValorNominal = IsNull(PT.SubTotal, 0) + IsNull(P.Freight,0) + IsNull(P.OtherCharges, 0), 
		L.IDPessoa = P.IDFornecedor,
		L.DataLancamento =IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		L.IDUsuarioLancamento = IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving)
	FROM
		Fin_Lancamento L
		JOIN Pur_Purchase P ON (L.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		L.LancamentoType <> 2 -- Diferente de LancamentoFilho


	-- Atualizo as informacoes do Lancamento Filho
	UPDATE
		L
	SET
		L.DataVencimento = P.DocumentDate,
		L.DataEmissao = P.DocumentDate,
		L.NumDocumento = P.DocumentNumber,
		L.ValorNominal = IsNull(PT.SubTotal, 0), 
		L.IDPessoa = P.IDFornecedor,
		L.DataLancamento =IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		L.IDUsuarioLancamento = IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving)
	FROM
		Fin_Lancamento L
		JOIN Pur_Purchase P ON (L.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
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
		L.DataVencimento = P.DocumentDate,
		L.DataEmissao = P.DocumentDate,
		L.NumDocumento = P.DocumentNumber,
		L.ValorNominal = IsNull(P.Freight,0) + IsNull(P.OtherCharges, 0), 
		L.IDPessoa = P.IDFornecedor,
		L.DataLancamento =IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		L.IDUsuarioLancamento = IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving)
	FROM
		Fin_Lancamento L
		JOIN Pur_Purchase P ON (L.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
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
			P.DocumentDueDate,
			P.DocumentDate,
			1002,  -- Vendor Invoice
			IsNull(PT.SubTotal, 0) + IsNull(P.Freight, 0) + IsNull(P.OtherCharges, 0),
			P.DocumentNumber,
			P.IDPurchase,
			4, -- Dollar
			6, -- Cotacao Default - Dollar
			1  -- Lancamento Parent
		FROM
			Pur_Purchase P
			JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
			JOIN Store S ON (P.IDStore = S.IDStore)
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


	--Pega o IDLancamento do Pararent e os Valores para criar os disbursement
	SELECT 
		@IDLancamentoParent = @IDLancamento,
		@SubTotal = IsNull(PT.SubTotal, 0),
		@Freight = IsNull(P.Freight, 0) + IsNull(P.OtherCharges, 0),
		@CriaDisbur = 1
	FROM
		Pur_Purchase P
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		P.DocumentType = 'Invoice'
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END


	IF (@CriaDisbur = 1)
	BEGIN
		--Cria desdobramento do Sub Total
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @SubTotal, '1/2'
		
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		--Cria desdobramento do Freight
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @Freight, '2/2'

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -205
			GOTO ERRO
		END
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_Purchase_Do
	(
	@IDPurchase	int,
	@Date 		DateTime
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario os barcodes que ainda nao existam
		- Altero o Category no Model quando diferente
		- Incluo o InventoryMov se necessario
		- Se necessario crio os lancamentos no contas a pagar

		- Deleto as Qty do Pur_PurchaseQtyPreSale ##Rodrigo
		- Incluo as Qty do Pur_PurchaseQtyPreSale ##Rodrigo
		- Incluo os serial Numbers no inventory

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto as Qty do Pur_PurchaseQtyPreSale
		-202  Erro em Deleto as Qty do Pur_PurchaseQtyOrder
		-203  Erro em Deleto os PreInventoryMov
		-204  Erro em Deleto os InventoryMov
		-205  Erro em Incluo no Inventario os barcodes que ainda nao exitam
		-206  Erro em Atualizo a informação de category
		-207  Erro em Atualizar a TBL de Model com os valores se for Final
		-208  Erro em Incluo o InventoryMov se necessario
		-209  Erro em Insiro as Qty do Pur_PurchaseQtyPrePurchase se for PreReceiving para atualizar o qtyOnPreReceive na TBL Inventory
		-210  Erro em Insiro as Qty do Pur_PurchaseQtyOrder - Atualizar as qty no PO
		-211  Erro em Atualiza o total do PO
		-212  Erro em Crio os Serial Numbers no inventory se for final
		-213  Erro em Delete os Serail Numbers do Purchase
		-214  Erro em Deleto o Term do Fin >>> Os termos so serao deletados se o Purchase Type for do typo Invoice
		-215  Erro em Crio os lancamentos no contas a pagar, se necessario
		-216  Erro em Incluio novamente o Term do Fin >>> Os termos so serao incluidos se o Purchase Type for do typo Invoice
		-217  Erro em Deletetar o InventoryMovTax


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 	2000	Eduardo Costa		Criação;
	18 dezembro 	2000	Rodrigo Costa		Complemento;
	06 junho        	2001	Davi Gouveia		Variavel @ErrorLevel/Lista de Return_Values
	07 junho        	2001	Rodrigo Costa		Insert no Fin_LancamentoTerm
	07 dezembro 	2001	Rodrigo Costa		Nao pode deletar p PreInventoryMov, pois os item nao sao salvos la.
	13 May	        	2002	Rodrigo Costa		Criacao Lancamento Termo para os Disbursements 
	29 Oct		2003	Rodrigo Costa		Criado Cuersor para InvMov, Pur_PurchaseQtyPrePurchase, Pur_PurchaseQtyOrder_Cursor;
							Chamado da sp_GetNextCode;
	13 Feb		2004	Rodrigo Costa		Deletar o InventoryMovTax da Compra
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDPO 			int
DECLARE @ErrorLevel 			int
DECLARE @SysError			int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @StoreID 			int 
DECLARE @IDPessoa 			int 
DECLARE @InventMovTypeID 		int 
DECLARE @DocumentID 		int 
DECLARE @ModelID 			int 
DECLARE @Qty 			int 
DECLARE @CostPrice 			money 
DECLARE @SalePrice 			money 
DECLARE @BarCodeID 			char(20)
DECLARE @MovDate 			smalldatetime 
DECLARE @IDUser 			int 
DECLARE @IDInventoryMov		int

--Declaração de variáveis para o Cursor de Pur_PurchaseQtyPrePurchase
DECLARE @IDModel 			int 
DECLARE @IDStore 			int 
DECLARE @IDPurchaseQtyPreSale	int

--Declaração de variáveis para o Cursor de Pur_PurchaseQtyOrder
DECLARE @IDPOItem 			int 
DECLARE @IDPurchaseQtyOrder	int

BEGIN TRAN


-----------------------------------------------------------
-- Deleto as Qty do Pur_PurchaseQtyPreSale
DELETE
	PQP
FROM
	Pur_PurchaseQtyPrePurchase PQP
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
	Pur_PurchaseQtyOrder PQP
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
	InventoryMovTax IMT
WHERE
	IMT.IDInventoryMov IN (	SELECT IDInventoryMov
			       	FROM InventoryMov IM
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

------------------------------------------------------------------------------
-- Incluo no Inventario os barcodes que ainda nao exitam

INSERT
	BarCode (IDBarCode, IDModel, Data)
SELECT

	PPI.BarCode,
	PPI.IDModel,
	@Date
FROM
	Pur_PurchaseItem PPI
	LEFT OUTER JOIN BarCode BC ON (PPI.BarCode = BC.IDBarCode)
WHERE
	BC.IDModel IS Null
	AND
	PPI.BarCode IS NOT NULL
	AND
	PPI.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END



------------------------------------------------------------------------------
-- Atualizo a informação de category

UPDATE
	M
SET
	M.GroupID = PPI.IDGroup
FROM
	Model M
	JOIN Pur_PurchaseItem PPI ON (M.IDModel = PPI.IDModel)
WHERE
	M.GroupID <> PPI.IDGroup

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


--------------------------------------------------------------------------------------------------
---Atualizar a TBL de Model com os valores se for Final

UPDATE
	Model
SET
	Model.Desativado     = 0,
	Model.SellingPrice     = IsNull(PUI.NewSalePrice,0),
	Model.SuggRetail      = IsNull(PUI.NewSuggRetail,0),
	Model.LastCost          = IsNull(Model.VendorCost,0),
	Model.VendorCost     = IsNull(PUI.NewCostPrice,0),
	Model.DateLastCost  = @Date,

	Model.OtherCost = 	ROUND(
				CASE	WHEN 	PUT.SubTotal = 0 THEN 0
					ELSE	( IsNull((PU.OtherCharges / PUT.SubTotal)  * (PUI.NewCostPrice)  , 0 ) )
				END

			      	,2),


	Model.FreightCost = 	ROUND(
				  CASE	WHEN 	PUT.SubTotal = 0 THEN 0
					ELSE	( IsNull(	(PU.Freight / PUT.SubTotal)  * (PUI.NewCostPrice) , 0 ) )
				  END
			      	,2),

	Model.AvgCost  =	ROUND(IsNull(	(

					SELECT 	(
							CASE WHEN	PUI.Qty + SUM(IsNull(Inv.QtyOnHand,0)) = 0 THEN 0
							ELSE		(
										(
										(PUI.NewCostPrice * PUI.Qty) + 
										( IsNull(Model.FinalCost,0) * SUM(IsNull(Inv.QtyOnHand,0)))
										)
										/
					       			               	(
										PUI.Qty + SUM(IsNull(Inv.QtyOnHand,0))
										)
									)
							END
						)

					FROM	
						Inventory Inv
						JOIN Model ON (Inv.ModelId = Model.IDModel)
					WHERE
						Inv.ModelID = PUI.IDModel
					GROUP BY  
						Model.FinalCost 

					), PUI.NewCostPrice ),2)


FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
	JOIN Pur_PurchaseTotal PUT ON (PU.IDPurchase = PUT.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
	AND
	DateFinalReceiving IS NOT NULL
	AND
	Model.IDModel = PUI.IDModel



SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Incluo o InventoryMov se necessario

--Declaração do Cursor de InventoryMov
DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	PP.IDStore,
	PP.IDFornecedor,
	2, -- Compra
	PP.IDPurchase,
	PPI.IDModel,
	PPI.Qty,
	PPI.NewCostPrice,
	PPI.NewSalePrice,
	PPI.BarCode,
	PP.DateFinalReceiving,
	PP.IDUserFinalReceiving
FROM
	Pur_Purchase PP
	JOIN Pur_PurchaseItem PPI ON (PP.IDPurchase = PPI.IDPurchase)
WHERE
	PP.IDPurchase = @IDPurchase
	AND
	DateFinalReceiving IS NOT NULL

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
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
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

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
		IDUser
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
		@IDUser
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -208
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
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


-----------------------------------------------------------
-- Insiro as Qty do Pur_PurchaseQtyPrePurchase se for PreReceiving para atualizar o qtyOnPreReceive na TBL Inventory
--Declaração do Cursor de Pur_PurchaseQtyPrePurchase
DECLARE Pur_PurchaseQtyPrePurchase_Cursor CURSOR FOR

SELECT
	PUI.IDModel,
	PU.IDStore,
	SUM(PUI.Qty)
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NULL
GROUP BY
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem


OPEN Pur_PurchaseQtyPrePurchase_Cursor

--Inicialização de Pur_PurchaseQtyPrePurchase_Cursor
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
--Destruição do cursor
DEALLOCATE Pur_PurchaseQtyPrePurchase_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


-----------------------------------------------------------
-- Insiro as Qty do Pur_PurchaseQtyOrder - Atualizar as qty no PO
--Declaração do Cursor de Pur_PurchaseQtyOrder

DECLARE Pur_PurchaseQtyOrder_Cursor CURSOR FOR

SELECT
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem,
	SUM(PUI.Qty)
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
GROUP BY
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem

OPEN Pur_PurchaseQtyOrder_Cursor

--Inicialização de Pur_PurchaseQtyOrder_Cursor
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
--Destruição do cursor
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
	PreInventoryMov PIM
	JOIN Pur_PurchaseQtyOrder PQO ON (PIM.IDPreInventoryMov = PQO.IDPOItem)

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
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
	Pur_Purchase PU
	JOIN Pur_PurchaseItemSerial PIS ON (PU.IDPurchase = PIS.IDPurchase)
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
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
	Pur_PurchaseItemSerial PIS
	JOIN Pur_Purchase PU ON (PU.IDPurchase = PIS.IDPurchase)
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

EXEC sp_Purchase_CriaPagamento @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -215
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Incluio novamente o Term do Fin >>> Os termos so serao incluidos se o Purchase Type for do typo Invoice

INSERT
	Fin_LancamentoTerm (IDLancamento, DueDateShift, Discount)
SELECT
	L.IDLancamento, PT.DueDateShift, PT.Discount
FROM
	Pur_PurchaseTerm PT
	JOIN Fin_Lancamento L ON (L.IDPurchase = PT.IDPurchase)
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE sp_Purchase_Remove
		(
 		@IDPurchase	 	 int
		)
AS 

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo o QtyOnPreReceive no Inventory
		- Deleto os InventoryMov
		- Deleto os PreInventoryMov
		- Deleto os PurchaseItemSerial
		- Deleto os PurchaseItem
		- Deleto o Term do Financeiro
		- Deleto o Term da Purchase
 		- Deleto o Contas a Pagar, caso exista
		- Deleto a total de purhcase (o bacalhau do BugBDE)
		- Deleto o Purchase
		- Deletar a TBL Pur_PurchaseQtyPreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto qtyOnPrePurchase do Inventory
		-202  Erro em Deleto qtyOnOrder do Inventory
		-203  Erro em Deleto os PreInventoryMov
		-204  Erro em Deleto os InventoryMov
		-205  Erro em Deleto os PurchaseItemSerial
		-206  Erro em Deleto o Term do Fin
		-207  Erro em Deleto o Term do Fin
		-208  Erro em Deleto o Term do Purchase
		-209  Erro em Deleto as contas a pagar
		-210  Erro em Deleto os PurchaseTotal
		-211  Erro em Deleto os Purchase


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	18 dez 200		Rodrigo Costa		Atualizacao;
	08 junho 2001		Rodrigo Costa		Deletar o Term do Fin_Lancamento & Purchase;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnPrePurchase do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ
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
	Pur_PurchaseQtyOrder PUQ
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
	PreInventoryMov PIM
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


------------------------------------------------------------------------------
-- Deleto os PurchaseItemSerial

DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS
WHERE
	PIS.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END



------------------------------------------------------------------------------
-- Deleto os PurchaseItem

DELETE
	PPI
FROM
	Pur_PurchaseItem PPI
WHERE
	PPI.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o Term do Fin 

DELETE
	Fin_LancamentoTerm
WHERE
	IDLancamento IN (SELECT L.IDLancamento FROM Fin_Lancamento L WHERE L.IDPurchase = @IDPurchase)

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
	Fin_Lancamento L
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
	Pur_PurchaseTotal PT
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
	Pur_Purchase P
WHERE
	P.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_Purchase_RemoveItem
		(
 		@IDPurchase	 	 int,
		@IDPurchaseItem	 int
		)
AS 

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo o QtyOnPrePurchase no Inventory ### Rodrigo
		- Atualizo o QrtArrived no PreInvMov ## Rodrigo

		- Deleto os PurchaseItemSerial
		- Deleto o PurchaseItem
		- Call sp_Purchase_AtuPurchaseSubTotal

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto AsQty o item no Pur_PurchaseQtyPrePurchase
		-202  Erro em Deleto AsQty o item no Pur_PurchaseQtyOrder
		-203  Erro em Deleto os PurchaseItemSerial
		-204  Erro em Deleto o PurchaseItem
		-205  Erro em Call sp_Purchase_AtuPurchaseSubTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	18 dez 200		Rodrigo Costa		Atualizacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN


---------------------------------------------------------------------------- ##Rodrigo
-- Deleto AsQty o item no Pur_PurchaseQtyPrePurchase

DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ
WHERE
	PUQ.IDModel = (
			SELECT
				PUI.IDModel
			FROM
				Pur_PurchaseItem PUI
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
	Pur_PurchaseQtyOrder PUQ
WHERE
	PUQ.IDModel = (
			SELECT
				PUI.IDModel
			FROM
				Pur_PurchaseItem PUI
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
	Pur_PurchaseItemSerial PIS
WHERE
	PIS.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o PurchaseItem

DELETE
	PPI
FROM
	Pur_PurchaseItem PPI
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

EXEC sp_Purchase_AtuPurchaseSubTotal  @IDPurchase

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_RemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Repair_Do 
		(
		@IDRepair	int
		)

AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em DELETO O INVMOV
		-202  Erro em Send To Vendor
		-203  Erro em Back From Vendor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 June 2001		Rodrigo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	28 Oct	2003		Rodrigo Costa		Criacao do InventoryMov Cursor;
							Chama sp_GetNextCode
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @IDPessoa 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 		int 
DECLARE @IDUser 		int 
DECLARE @CostPrice 		money 
DECLARE @Notes 		varchar(255)
DECLARE @IDInventoryMov	int

BEGIN TRAN
---------------------------------------
-- DELETO O INVMOV
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
		0,
		R.SentDate, --Data que foi enviado o Item
		R.Qty,
		R.IDUserSent,
		R.LastCost,
		R.Defect
	FROM
		Repair R
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
	@Notes
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
		Notes
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
		@Notes
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -202
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
		@Notes
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
			WHEN 4 THEN 17   /* Vendor Credit - Repair */
		END
		) as RepairType,
		R.IDRepair,
		R.IDRepair,
		R.IDStore,
		R.IDModel,
		0,
		R.ReturnDate, --Data recebida do Vendor

		R.Qty,
		R.IDUserReturn, --Usuario que enviou
		R.LastCost,
		R.OBSReturn

	FROM
		Repair R
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
	@Notes
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
		Notes
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
		@Notes
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
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
		@Notes
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Request_GenerateComputer
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Gera ps pedidos do computador

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em DELETE FROM Request
		-202  Erro em INSERT	Request


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Request_Cursor	
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


/*	Gera ps pedidos do computador		*/
DECLARE @MinQty  	int
DECLARE @MinPerc 	numeric(5, 2)
DECLARE @ErrorLevel	int
DECLARE @SysError	int

--Declaração de variáveis para o Cursor de Request
DECLARE @IDRequest	int
DECLARE @ModelID 	int 
DECLARE @UserID 	int 
DECLARE @Type 	char(1)
DECLARE @QtyReq 	int 
DECLARE @DateRequest 	smalldatetime 
DECLARE @StoreID 	int 
DECLARE @Description varchar(50)

SET @ErrorLevel = 0

SELECT  @MinQty   = ( SELECT CONVERT(int, ( SELECT SrvValue FROM Param WHERE IDParam = 13 ) ) )

SELECT  @MinPerc  = ( SELECT CONVERT(int, ( SELECT SrvValue FROM Param WHERE IDParam = 14 ) ) )

/*	Testa se venda dos nMes ultimos meses foi maior que a nMinPerc de compras */

DELETE
FROM
	Request
WHERE
	Type = 'C'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

--Declaração do Cursor de Request

DECLARE Request_Cursor CURSOR FOR

SELECT
		vwInventoryModel.IDModel,
		0,
		'C',
		1,
		GetDate(),
		1,
		Description
	FROM
		vwInventoryModel
	WHERE
		NOT EXISTS
		(
		SELECT
			ModelID
		FROM
			Request (NOLOCK)
		WHERE
			Request.ModelID = vwInventoryModel.IDModel
			)
			AND
			vwInventoryModel.TotQtyOnHand <= @MinQty
			AND
			convert(numeric(5, 2),
			(
			(
			SELECT
				SUM(Qty)
			FROM
				InventoryMov (NOLOCK)
			WHERE
				InventoryMov.InventMovTypeID = 1
				AND
				InventoryMov.ModelID = vwInventoryModel.IDModel
			)/
			(
			SELECT
				SUM(Qty)
			FROM
				InventoryMov (NOLOCK)
			WHERE
				InventoryMov.InventMovTypeID = 2
				AND
				InventoryMov.ModelID = vwInventoryModel.IDModel
			)
		)) >= 1+(@MinPerc/100)
OPEN Request_Cursor

--Inicialização de Request_Cursor
FETCH NEXT FROM Request_Cursor INTO
	@ModelID,
	@UserID,
	@Type,
	@QtyReq,
	@DateRequest,
	@StoreID,
	@Description
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Request.IDRequest', @IDRequest OUTPUT

	INSERT Request
		(
		IDRequest,
		ModelID,
		UserID,
		Type,
		QtyReq,
		DateRequest,
		StoreID,
		Description
		)
	VALUES 
		(
		@IDRequest,
		@ModelID,
		@UserID,
		@Type,
		@QtyReq,
		@DateRequest,
		@StoreID,
		@Description	
		)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Request_Cursor
			DEALLOCATE Request_Cursor
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	FETCH NEXT FROM Request_Cursor INTO
		@ModelID,
		@UserID,
		@Type,
		@QtyReq,
		@DateRequest,
		@StoreID,
		@Description
END
--fechamento do cursor
CLOSE Request_Cursor
--Destruição do cursor
DEALLOCATE Request_Cursor

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Request_GenerateComputer', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_Request_Remove
		(
		@IDRequest 	int
		)
AS 
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleta o POItemRequest
		- Deleta o Request

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleta o POItem_Request
		-202  Erro em Deleta o Request


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

------------------------------------------------------------------------------
-- Deleta o POItem_Request

DELETE
	POItemRequest
WHERE
	IDRequest = @IDRequest

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleta o Request

DELETE
	Request
WHERE
	IDRequest = @IDRequest

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

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Request_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
		Sis_Grupo G
		JOIN Sis_GrupoMainMenuOperacao GMMO
			ON (G.IDGrupo = GMMO.IDGrupo))
		JOIN Sis_UsuarioGrupo GU
			ON (GU.IDGrupo = G.IDGrupo))
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
	Invoice I
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
	vwPOItem POI

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
	inventory
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
	Fin_Lancamento L
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
	Request

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
	PreInventoryMov
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_TourGroup_AddGift 
			(
			@IDTouristGroup 	int,
			@IDModel 		int,
			@IDStore 		int,
			@Qty 			int,
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
		Model M
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
		@IDUser,

		0
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_TourGroup_DelGift
		(
		@IDModel    	int,
		@MovDate	smallDateTime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto InventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto InventoryMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	27 June 2001		Davi Gouveia		Log de Return Values
	04 July   2001		Davi Gouveia		Tirado o Update na QtyOnHand que era rodado em Inventory
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

-- Deleto InventoryMov
DELETE
	InventoryMov
WHERE
	InventMovTypeID = 13 /* Saida por Gift */
	AND 
	MovDate = @MovDate
	AND
	ModelID = @IDModel

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_TourGroup_DelGift', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

