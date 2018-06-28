if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_CashRegister_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_CashRegister_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_CostType_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_CostType_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_CotacaoToFornec_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_CotacaoToFornec_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_CotacaoToModel_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_CotacaoToModel_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_DeliverType_Delete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_DeliverType_Delete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_DeliverType_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_DeliverType_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Estado_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Estado_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_LancQuit_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_LancQuit_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Fin_Quitacao_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Fin_Quitacao_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_InventoryMov_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_InventoryMov_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Media_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Media_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_MeioPag_Del]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_MeioPag_Del]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_MeioPag_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_MeioPag_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_MenuItem_delete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_MenuItem_delete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_MenuItem_insert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_MenuItem_insert]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Model_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Model_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_ModelTransfDet_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_ModelTransfDet_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_POItemRequest_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_POItemRequest_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Pessoa_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Pessoa_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_PreInventMov_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_PreInventMov_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Pur_PurchaseQtyOrder_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Pur_PurchaseQtyOrder_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Pur_PurchaseQtyPrePurchase_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Pur_PurchaseQtyPrePurchase_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_RamoAtividade_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_RamoAtividade_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Sis_Empresa_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Sis_Empresa_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Sis_Grupo_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Sis_Grupo_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Sis_MainMenu_Insert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Sis_MainMenu_Insert]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_Sis_MainMenuOperacao_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_Sis_MainMenuOperacao_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_Sis_MainMenuPagina_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_Sis_MainMenuPagina_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Sis_Moeda_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Sis_Moeda_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Sis_MoedaCotacao_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Sis_MoedaCotacao_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_SpecialPrice_delete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_SpecialPrice_delete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_SpecialPrice_insert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_SpecialPrice_insert]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Store_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Store_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_SysFunction_Delete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_SysFunction_Delete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_SysFunction_Insert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_SysFunction_Insert]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_SystemUser_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_SystemUser_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_TabGroup_Del]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_TabGroup_Del]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_TabGroup_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_TabGroup_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_TipoPessoa_Delete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_TipoPessoa_Delete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_TipoPessoa_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_TipoPessoa_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_TourGroup]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_TourGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Trajeto_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Trajeto_InsUpt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_UserType_delete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_UserType_delete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_UserType_insert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_UserType_insert]
GO
