if (not exists(select 1 from syscolumns where id = OBJECT_ID('CashRegister') and name = 'IsOPen')) begin
	alter table CashRegister add IsOpen bit null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('CashRegLogReason') and name = 'ReplLastChange')) begin
	alter table CashRegLogReason add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('CashRegMovPaymentLog') and name = 'ReplLastChange')) begin
	alter table CashRegMovPaymentLog add ReplLastChange datetime null
end	

/****** Object:  Index [PI_CashRegMovPaymentLog_ReplLastChange]    Script Date: 08/18/2016 02:57:37 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CashRegMovPaymentLog]') AND name = N'PI_CashRegMovPaymentLog_ReplLastChange')
DROP INDEX [PI_CashRegMovPaymentLog_ReplLastChange] ON [dbo].[CashRegMovPaymentLog] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [PI_CashRegMovPaymentLog_ReplLastChange]    Script Date: 08/18/2016 02:57:37 ******/
CREATE NONCLUSTERED INDEX [PI_CashRegMovPaymentLog_ReplLastChange] ON [dbo].[CashRegMovPaymentLog] 
(
	[ReplLastChange] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

if (not exists(select 1 from syscolumns where id = OBJECT_ID('ComisPaga') and name = 'ReplLastChange')) begin
	alter table ComisPaga add ReplLastChange datetime null
end	

/****** Object:  Index [PI_ComisPaga_ReplLastChange]    Script Date: 08/18/2016 03:58:05 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ComisPaga]') AND name = N'PI_ComisPaga_ReplLastChange')
DROP INDEX [PI_ComisPaga_ReplLastChange] ON [dbo].[ComisPaga] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [PI_ComisPaga_ReplLastChange]    Script Date: 08/18/2016 03:58:05 ******/
CREATE NONCLUSTERED INDEX [PI_ComisPaga_ReplLastChange] ON [dbo].[ComisPaga] 
(
	[ReplLastChange] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Cotacao') and name = 'ReplLastChange')) begin
	alter table Cotacao add ReplLastChange datetime null
end	

/****** Object:  Index [PI_Cotacao_ReplLastChange]    Script Date: 08/18/2016 04:12:12 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Cotacao]') AND name = N'PI_Cotacao_ReplLastChange')
DROP INDEX [PI_Cotacao_ReplLastChange] ON [dbo].[Cotacao] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [PI_Cotacao_ReplLastChange]    Script Date: 08/18/2016 04:12:12 ******/
CREATE NONCLUSTERED INDEX [PI_Cotacao_ReplLastChange] ON [dbo].[Cotacao] 
(
	[ReplLastChange] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

if (not exists(select 1 from syscolumns where id = OBJECT_ID('CotacaoResult') and name = 'ReplLastChange')) begin
	alter table CotacaoResult add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('CotacaoToFornec') and name = 'ReplLastChange')) begin
	alter table CotacaoToFornec add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('CotacaoToModel') and name = 'ReplLastChange')) begin
	alter table CotacaoToModel add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('DailyMaintenanceReport') and name = 'ReplLastChange')) begin
	alter table DailyMaintenanceReport add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Estimated') and name = 'ReplLastChange')) begin
	alter table Estimated add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('EstimatedItem') and name = 'ReplLastChange')) begin
	alter table EstimatedItem add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Fin_LancamentoComplement') and name = 'ReplLastChange')) begin
	alter table Fin_LancamentoComplement add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Fin_LancamentoTerm') and name = 'ReplLastChange')) begin
	alter table Fin_LancamentoTerm add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Fin_Transferencia') and name = 'ReplLastChange')) begin
	alter table Fin_Transferencia add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Fis_Registro60Analitico') and name = 'ReplLastChange')) begin
	alter table Fis_Registro60Analitico add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Fis_Registro60Item') and name = 'ReplLastChange')) begin
	alter table Fis_Registro60Item add ReplLastChange datetime null
end 

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Fis_Registro60Mestre') and name = 'ReplLastChange')) begin
	alter table Fis_Registro60Mestre add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Fis_Registro60ResumoDiario') and name = 'ReplLastChange')) begin
	alter table Fis_Registro60ResumoDiario add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('GroupCost') and name = 'ReplLastChange')) begin
	alter table GroupCost add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('GroupCostGift') and name = 'ReplLastChange')) begin
	alter table GroupCostGift add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('History') and name = 'ReplLastChange')) begin
	alter table History add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrint') and name = 'ReplLastChange')) begin
	alter table Inv_BarcodePrint add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'LargeImage')) begin
    alter table Inv_BarcodePrintSearch add LargeImage varchar(255) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'LargeImage2')) begin
    alter table Inv_BarcodePrintSearch add LargeImage2 varchar(255) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'Manufacturer')) begin
    alter table Inv_BarcodePrintSearch add Manufacturer varchar(50) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'VendorNum')) begin
    alter table Inv_BarcodePrintSearch add VendorNum varchar(06) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'Vendor')) begin
    alter table Inv_BarcodePrintSearch add Vendor varchar(50) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'SizeName')) begin
    alter table Inv_BarcodePrintSearch add SizeName varchar(20) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'Color')) begin
    alter table Inv_BarcodePrintSearch add Color varchar(20) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'CodColor')) begin
    alter table Inv_BarcodePrintSearch add CodColor varchar(10) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'ModelToScan')) begin
    alter table Inv_BarcodePrintSearch add ModelToScan varchar(22) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'BarcodeToScan')) begin
    alter table Inv_BarcodePrintSearch add BarcodeToScan varchar(22) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_BarcodePrintSearch') and name = 'ReplLastChange')) begin
    alter table Inv_BarcodePrintSearch add ReplLastChange varchar(22) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_Count') and name = 'ReplLastChange')) begin
    alter table Inv_Count add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_CountItem') and name = 'ReplLastChange')) begin
   alter table Inv_CountItem add ReplLastChange datetime null
end   

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_DescriptionPrice') and name = 'ReplLastChange')) begin
   alter table Inv_DescriptionPrice add ReplLastChange datetime null
end 

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_FrozeCount') and name = 'ReplLastChange')) begin
    alter table Inv_FrozeCount add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_Lot') and name = 'ReplLastChange')) begin
   alter table Inv_Lot add ReplLastChange datetime null
end   

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_ModelBalance') and name = 'ReplLastChange')) begin
   alter table Inv_ModelBalance add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_ModelNutrition') and name = 'ReplLastChange')) begin
   alter table Inv_ModelNutrition add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_ModelPrice') and name = 'ReplLastChange')) begin
   alter table Inv_ModelPrice add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_ModelStateTax') and name = 'ReplLastChange')) begin
   alter table Inv_ModelStateTax add ReplLastChange datetime null
end 

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_ModelStoreBalance') and name = 'ReplLastChange')) begin
   alter table Inv_ModelStoreBalance add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_MovDocument') and name = 'ReplLastChange')) begin
	alter table Inv_MovDocument add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_MovPrice') and name = 'ReplLastChange')) begin
	alter table Inv_MovPrice add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_NCM') and name = 'ReplLastChange')) begin
   alter table Inv_NCM add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_Nutrition') and name = 'ReplLastChange')) begin
   alter table Inv_Nutrition add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_NutritionItem') and name = 'ReplLastChange')) begin
   alter table Inv_NutritionItem add ReplLastChange datetime null
end
 
if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_StoreModelLot') and name = 'ReplLastChange')) begin
   alter table Inv_StoreModelLot add ReplLastChange datetime null
 end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Inv_StorePrice') and name = 'ReplLastChange')) begin
   alter table Inv_StorePrice add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('InventoryMov') and name = 'UnitDiscount')) begin
   alter table InventoryMov add UnitDiscount money null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Invoice') and name = 'TotalDiscount')) begin
   alter table Invoice add TotalDiscount money null
end 


if (not exists(select 1 from syscolumns where id = OBJECT_ID('InvoiceGen') and name = 'ReplLastChange')) begin
   alter table InvoiceGen add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('InvoiceToCostType') and name = 'ReplLastChange')) begin
alter table InvoiceToCostType add ReplLastChange datetime null
end
 
if (not exists(select 1 from syscolumns where id = OBJECT_ID('InvResetHistory') and name = 'ReplLastChange')) begin
   alter table InvResetHistory add ReplLastChange datetime null
end   

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Key_IDInventoryMov') and name = 'ReplLastChange')) begin
   alter table Key_IDInventoryMov add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Key_IDInvoice') and name = 'ReplLastChange')) begin
alter table Key_IDInvoice add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Key_IDLancamento') and name = 'ReplLastChange')) begin
   alter table Key_IDLancamento add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Key_IDPreinventoryMov') and name = 'ReplLastChange')) begin
   alter table Key_IDPreinventoryMov add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Key_IDPreSale') and name = 'ReplLastChange')) begin
   alter table Key_IDPreSale add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Key_IDSaleItemCommission') and name = 'ReplLastChange')) begin
   alter table Key_IDSaleItemCommission add ReplLastChange datetime null
end 

if (not exists(select 1 from syscolumns where id = OBJECT_ID('MargemTable') and name = 'ReplLastChange')) begin
   alter table MargemTable add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('MargemTableRange') and name = 'ReplLastChange')) begin
   alter table MargemTableRange add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('MenuItem') and name = 'ReplLastChange')) begin
   alter table MenuItem add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('MenuItemLanguage') and name = 'ReplLastChange')) begin
   alter table MenuItemLanguage add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('MenuMain') and name = 'ReplLastChange')) begin
   alter table MenuMain add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('MenuMainLanguage') and name = 'ReplLastChange')) begin
   alter table MenuMainLanguage add ReplLastChange datetime null
end 

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Mnt_CFOP') and name = 'ReplLastChange')) begin
   alter table Mnt_CFOP add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Mnt_Controler') and name = 'ReplLastChange')) begin
   alter table Mnt_Controler add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Mnt_DefaultInvoiceObs') and name = 'ReplLastChange')) begin
alter table Mnt_DefaultInvoiceObs add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Mnt_DocumentType') and name = 'ReplLastChange')) begin
   alter table Mnt_DocumentType add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Mnt_PessoaAddress') and name = 'ReplLastChange')) begin
	alter table Mnt_PessoaAddress add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Mnt_PessoaHistory') and name = 'ReplLastChange')) begin
	alter table Mnt_PessoaHistory add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Mnt_Store') and name = 'ReplLastChange')) begin
   alter table Mnt_Store add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Model') and name = 'NoUpdateCatalogs')) begin
   alter table Model add NoUpdateCatalogs bit null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Model') and name = 'ReplLastChange')) begin
	alter table Model add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('ModelPriceLog') and name = 'ReplLastChange')) begin
   alter table ModelPriceLog add ReplLastChange datetime null
end 

if (not exists(select 1 from syscolumns where id = OBJECT_ID('ModelTransfSerial') and name = 'ReplLastChange')) begin
   alter table ModelTransfSerial add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Nfe_NotaFiscal') and name = 'ReplLastChange')) begin
   alter table Nfe_Notafiscal add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Param') and name = 'ReplLastChange')) begin
   alter table Param add ReplLastchange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('ParamLanguage') and name = 'ReplLastChange')) begin
   alter table ParamLanguage add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_animals') and name = 'ReplLastChange')) begin
   alter table pcm_animals add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_breeders') and name = 'ReplLastChange')) begin
   alter table pcm_breeders add ReplLastChange datetime null
end 

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_breeds') and name = 'ReplLastChange')) begin
   alter table pcm_breeds add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_config') and name = 'ReplLastChange')) begin
   alter table pcm_config add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_medical') and name = 'ReplLastChange')) begin
   alter table pcm_medical add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_medical_rec') and name = 'ReplLastChange')) begin
alter table pcm_medical_rec add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_others') and name = 'ReplLastChange')) begin
   alter table pcm_others add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_vaccine_lots') and name = 'ReplLastChange')) begin
   alter table pcm_vaccine_lots add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_vaccine_manu') and name = 'ReplLastChange')) begin   
   alter table pcm_vaccine_manu add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_vaccine_shots') and name = 'ReplLastChange')) begin
   alter table pcm_vaccine_shots add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('pcm_vaccines') and name = 'ReplLastChange')) begin
   alter table pcm_vaccines add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('PessoaTerm') and name = 'ReplLastChange')) begin
   alter table PessoaTerm add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('PessoaValidation') and name = 'ReplLastChange')) begin
   alter table PessoaValidation add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Pet_MicrochipSale') and name = 'ReplLastChange')) begin
	alter table Pet_MicrochipSale add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Pet_PetSale') and name = 'ReplLastChange')) begin
	alter table Pet_PetSale add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Pet_RegistrySale') and name = 'ReplLastChange')) begin
	alter table Pet_RegistrySale add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Pet_WarrantyReport') and name = 'ReplLastChange')) begin
   alter table Pet_WarrantyReport add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('PreInventoryMov') and name = 'UnitDiscount')) begin
   alter table PreInventoryMov add UnitDiscount money null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('PT_GlobalSetting') and name = 'ReplLastChange')) begin
   alter table PT_GlobalSetting add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('PT_GlobalSettingDetail') and name = 'ReplLastChange')) begin
   alter table PT_GlobalSettingDetail add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('PT_LocalSetting') and name = 'ReplLastChange')) begin
   alter table PT_LocalSetting add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('PT_LocalSetting') and name = 'MacAddress')) begin
	alter table PT_LocalSetting add MacAddress varchar(30) null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('PreSerialMov') and name = 'ReplLastChange')) begin
alter table PreSerialMov add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('PreSerialMov') and name = 'IsIssued')) begin
alter table PreserialMov add IsIssued char(1) null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('PrePurchaseSerial') and name = 'ReplLastChange')) begin
	alter table PrePurchaseSerial add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Pur_PurchaseItemSerial') and name = 'ReplLastChange')) begin
	alter table Pur_PurchaseItemSerial add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Pur_PurchaseItemTax') and name = 'ReplLastChange')) begin
	alter table Pur_PurchaseItemTax add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Pur_PurchaseItemTaxRet') and name = 'ReplLastChange')) begin
	alter table Pur_PurchaseItemTaxRet add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Pur_PurchaseTerm') and name = 'ReplLastChange')) begin
	alter table Pur_PurchaseTerm add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Pur_PurchaseVerify') and name = 'ReplLastChange')) begin
   alter table Pur_PurchaseVerify add ReplLastChange datetime null
end  

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Results') and name = 'ReplLastChange')) begin
   alter table Results add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('RoundingTable') and name = 'ReplLastChange')) begin
   alter table RoundingTable add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('RoundingTableRange') and name = 'ReplLastChange')) begin
   alter table RoundingTableRange add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_Discount') and name = 'ReplLastChange')) begin
	alter table Sal_Discount add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_DrawerKickLog') and name = 'ReplLastChange')) begin
   alter table Sal_DrawerKickLog add ReplLastChange datetime null
end


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_FrequentPromo') and name = 'ReplLastChange')) begin
  alter table Sal_FrequentPromo add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_InvoiceShipping') and name = 'ReplLastChange')) begin
	alter table Sal_InvoiceShipping add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_NotasCanceladas') and name = 'ReplLastChange')) begin
   alter table Sal_NotasCanceladas add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_PaymentCondition') and name = 'ReplLastChange')) begin
   alter table Sal_PaymentCondition add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_PaymentDiscount') and name = 'ReplLastChange')) begin
   alter table Sal_PaymentDiscount add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_PromoLoyaltyCustomer') and name = 'ReplLastChange')) begin
   alter table Sal_PromoLoyaltyCustomer add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_PromoPrizeItem') and name = 'ReplLastChange')) begin
   alter table Sal_PromoPrizeItem add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_RebateCalendar') and name = 'ReplLastChange')) begin
   alter table Sal_RebateCalendar add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_RebateDiscount') and name = 'ReplLastChange')) begin
   alter table Sal_RebateDiscount add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_RebateItem') and name = 'ReplLastChange')) begin
   alter table Sal_RebateItem add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_RebateItemCalendar') and name = 'ReplLastChange')) begin
   alter table Sal_RebateItemCalendar add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_ReducaoZ') and name = 'ReplLastChange')) begin
   alter table Sal_ReducaoZ add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_RemovedItem') and name = 'ReplLastChange')) begin
alter table Sal_RemovedItem add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_StoreAccount') and name = 'ReplLastChange')) begin
   alter table Sal_StoreAccount add ReplLastChange datetime null
end


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_StoreAccountLimetLog') and name = 'ReplLastChange')) begin
   alter table Sal_StoreAccountLimetLog add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_TotalizadorParcial') and name = 'ReplLastChange')) begin
   alter table Sal_TotalizadorParcial add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_TrafficBox') and name = 'ReplLastChange')) begin
	alter table Sal_TrafficBox add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_TrafficMov') and name = 'ReplLastChange')) begin
	alter table Sal_TrafficMov add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sal_TributacaoECF') and name = 'ReplLastChange')) begin
   alter table Sal_TributacaoECF add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Ser_ServiceOrder') and name = 'ReplLastChange')) begin
	alter table Ser_ServiceOrder add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Ser_SOCustomerProduct') and name = 'ReplLastChange')) begin
    alter table Ser_SOCustomerProduct add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Ser_SOItem') and name = 'ReplLastChange')) begin
	alter table Ser_SOItem add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Ser_SOItemDefect') and name = 'ReplLastChange')) begin
	alter table Ser_SOItemDefect add ReplLastChange datetime null
end	

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Ser_SOItemProduct') and name = 'ReplLastChange')) begin
	alter table Ser_SOItemProduct add ReplLastChange datetime null
end	


if (not exists(select 1 from syscolumns where id = OBJECT_ID('Ser_SOStatus') and name = 'ReplLastChange')) begin
   alter table Ser_SOStatus add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_AppHistory') and name = 'ReplLastChange')) begin
   alter table Sis_AppHistory add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_CodigoIncremental') and name = 'ReplLastChange')) begin
alter table Sis_CodigoIncremental add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_ConfigExport') and name = 'ReplLastChange')) begin
   alter table Sis_ConfigExport add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_ConfigImport') and name = 'ReplLastChange')) begin
   alter table Sis_ConfigImport add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_Constante') and name = 'ReplLastChange')) begin
   alter table Sis_Constante add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_GrupoMainMenuPagina') and name = 'ReplLastChange')) begin
alter table Sis_GrupoMainMenuPagina add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_Language') and name = 'ReplLastChange')) begin
   alter table Sis_Language add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_MainMenuOperacao') and name = 'ReplLastChange')) begin
   alter table Sis_MainMenuOperacao add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_Municipio') and name = 'ReplLastChange')) begin
alter table Sis_Municipio add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_PropertyDomain') and name = 'ReplLastChange')) begin
   alter table Sis_PropertyDomain add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_Registro') and name = 'ReplLastChange')) begin
   alter table Sis_Registro add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sis_Registry') and name = 'ReplLastChange')) begin
alter table Sis_Registry add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('SpecialPriceByGroup') and name = 'ReplLastChange')) begin
   alter table SpecialPriceByGroup add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sys_Module') and name = 'ReplLastChange')) begin
   alter table Sys_Module add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sys_Relatorio') and name = 'ReplLastChange')) begin
   alter table Sys_Relatorio add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('Sys_RelParametro') and name = 'ReplLastChange')) begin
   alter table Sys_RelParametro add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('SysFunction') and name = 'ReplLastChange')) begin
   alter table SysFunction add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('SysFunctionLanguage') and name = 'ReplLastChange')) begin
   alter table SysFunctionLanguage add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('UpInvent') and name = 'ReplLastChange')) begin
   alter table UpInvent add ReplLastChange datetime null
end

if (not exists(select 1 from syscolumns where id = OBJECT_ID('VendorTax') and name = 'ReplLastChange')) begin
	alter table VendorTax add ReplLastChange datetime null
end	

go