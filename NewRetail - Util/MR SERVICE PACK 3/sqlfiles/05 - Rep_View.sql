if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_DisbursementType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_DisbursementType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_DocumentType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_DocumentType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Payment]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Payment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_RecordPaid]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_RecordPaid]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_RecordType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_RecordType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Records]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Records]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_RecordsTerms]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_RecordsTerms]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Transfer]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Transfer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_User]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_User]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_UserGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_UserGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_AgedInventory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_AgedInventory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_AgencyAgentInvoices]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_AgencyAgentInvoices]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Barcode]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Barcode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_BestSeller]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_BestSeller]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegLog]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegLog]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegMov]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CustomerPurchaseHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CustomerPurchaseHistory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CustomerPurchaseHistory_Sub]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CustomerPurchaseHistory_Sub]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Entity]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Entity]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_GroupCost]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_GroupCost]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_GroupCostGift]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_GroupCostGift]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InvTotal]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InvTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InveItemStock]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InveItemStock]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Inventory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Inventory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryMov]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryQtyByModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryQtyByModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryQtyByStore]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryQtyByStore]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryRepair]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryRepair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventorySerial]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventorySerial]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Invoice]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Invoice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InvoiceDate]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InvoiceDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_MarketingCustomerPurchaseHist]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_MarketingCustomerPurchaseHist]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Model]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Model]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_ModelTransf]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_ModelTransf]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_ModelTransfDet]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_ModelTransfDet]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_OpenLayawayHold]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_OpenLayawayHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_PaymentType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_PaymentType]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_PurchaseOrder]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_PurchaseOrder]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_QuotationResult]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_QuotationResult]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_QuotationToModel]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_QuotationToModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_QuotationToVendor]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_QuotationToVendor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Records]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Records]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SystemUser]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SystemUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_TouristGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_TouristGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_ZipCode]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_ZipCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_BankAccountBalance]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_BankAccountBalance]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_BankAccount]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_BankAccount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Quotation]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Quotation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_BankBranch]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_BankBranch]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_DiscRange]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_DiscRange]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_GroupToCommissionType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_GroupToCommissionType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Store]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Store]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Bank]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Bank]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Acc_Company]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Acc_Company]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Category]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Category]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CostType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CostType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_DeliverType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_DeliverType]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryMovType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryMovType]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Media]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Media]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_PaidCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_PaidCommission]
GO

CREATE VIEW vw_Rep_Acc_Bank (IDBank, BankCode, Bank, System, Hidden, Deleted)  AS
       SELECT B.IDBanco, B.CodigoBanco, B.Banco, B.System, B.Hidden, B.Desativado
       FROM Fin_Banco B

GO

CREATE VIEW vw_Rep_Acc_Company (IDConpany, CompanyCode, Company, Address, City, Country, System, Deleted, Hidden)  AS
       SELECT E.IDEmpresa, E.CodigoEmpresa, E.Empresa, E.Endereco, E.Cidade, E.Pais, E.System, E.Desativado, E.Hidden
       FROM Sis_Empresa E

GO

CREATE VIEW vw_Rep_Acc_CostCenter (IDCostCenter, CostCenterCod, CostCenter, Deleted, Hidden, System)  AS
       SELECT CC.IDCentroCusto, CC.CodigoCentroCusto, CC.CentroCusto, CC.Desativado, CC.Hidden, CC.System
       FROM Fin_CentroCusto CC

GO

CREATE VIEW vw_Rep_Acc_Group (IDGroup, Groups, Hidden, Deleted, System)  AS
       SELECT G.IDGrupo, G.Grupo, G.Hidden, G.Desativado, G.System
       FROM Sis_Grupo G

GO

CREATE VIEW vw_Rep_Acc_Holiday (IDHoliday, Holiday, Date, Hidden, Deleted, System)  AS
       SELECT F.IDFeriado, F.Feriado, F.Data, F.Hidden, F.Desativado, F.System
       FROM Sis_Feriado F

GO

CREATE VIEW vw_Rep_CashRegLogType (IDCashRegTipoLog, CashRegTipoLog, Entering, Move, PettyCash)  AS
       SELECT C.IDCashRegTipoLog, C.CashRegTipoLog, C.Entrando, C.Movimenta, C.PettyCash
       FROM CashRegTipoLog C

GO

CREATE VIEW vw_Rep_CashRegister AS
       SELECT C.IDCashRegister, C.Name, C.IsAssociated
       FROM CashRegister C
GO


CREATE VIEW vw_Rep_TouristGroup (IDTouristGroup, TipTouristGroup, IDGuide, IDAgency, EnterDate, IDStore, NumTourist, GuideCommission, IDUser, IDHotel)  AS
       SELECT T.IDTouristGroup, T.TipTouristGroup, T.IDGuide, T.IDAgency, T.EnterDate, T.IDStore, T.NumTourist, T.ComissaoSobreGuia, T.IDUser, T.IDHotel
       FROM TouristGroup T
GO


CREATE VIEW vw_Rep_Inventory (IDInventory, IDStore, IDModel, QtyOnPreSale, QtyOnHand, QtyOnOrder, QtyOnRepair, MaxQty, MinQty, Location, QtyCount, CountDate, LastMov, LastCount, AuxCalc, Avaiable, QtyOnPrePurchase, LastPurchase, FirstPurchase, TotalPurchase)  AS
       SELECT I.IDInventory, I.StoreID, I.ModelID, I.QtyOnPreSale, I.QtyOnHand, I.QtyOnOrder, I.QtyOnRepair, I.MaxQty, I.MinQty, I.Location, I.QtyContada, I.DataContagem, I.UltimaMovimentacao, I.UltimaContagem, I.AuxCalculo, I.Avaiable, I.QtyOnPrePurchase, I.LastPurchase, I.FirstPurchase, I.TotalPurchase
       FROM Inventory I
GO

CREATE VIEW vw_Rep_InventoryMov (IDInventoryMov, IDInventMovType, IDDocument, IDPessoa, IDModel, IDStore, IDComission, IDLancPagCom, IDUser, IDAgrupaPag, IDTemp, MovDate, Qty, CostPrice, SalePrice, Discount, Freight, OtherCost, ExchangeInvoice, QtyExchanged, SalesTax)  AS
       SELECT I.IDInventoryMov, I.InventMovTypeID, I.DocumentID, I.IDPessoa, I.ModelID, I.StoreID, I.ComissionID, I.IDLancPagCom, I.IDUser, I.IDAgrupaPag, I.IDTemp, I.MovDate, I.Qty, I.CostPrice, I.SalePrice, I.Discount, I.Freight, I.OtherCost, I.ExchangeInvoice, I.QtyExchanged, I.SalesTax
       FROM InventoryMov I
GO

CREATE VIEW vw_Rep_Category (IDCategory, Category, Taxable, PrcPartDiscount, Path, PathName, SerialNumber, SizeAndColor)  AS
       SELECT T.IDGroup, T.Name, T.Taxable, T.PrcPartDiscount, T.Path, T.PathName, T.SerialNumber, T.SizeAndColor
       FROM TabGroup T

GO

CREATE VIEW vw_Rep_CostType AS
       SELECT C.IDCostType, C.CostType, C.DefaultValue
       FROM CostType C

GO

CREATE VIEW vw_Rep_DeliverType AS
       SELECT D.IDDeliverType, D.Name
       FROM DeliverType D

GO

CREATE VIEW vw_Rep_EntityType (IDPersonType, Path, PersonType, PathName, PayDayDefault, CommissionOnProfit, LastCode)  AS
       SELECT T.IDTipoPessoa, T.Path, T.TipoPessoa, T.PathName, T.DefaultDiaPag, T.ComissionOnProfit, T.LastCode
       FROM TipoPessoa T

GO

CREATE VIEW vw_Rep_Hotel (IDHotel, Hotel, Address, City, Zip, Phone, Fax, Note)  AS
       SELECT H.IDHotel, H.Hotel, H.Endereco, H.Cidade, H.CEP, H.Telefone, H.Fax, H.OBS
       FROM Hotel H
GO

CREATE VIEW vw_Rep_InvColor (IDColor, Color, ColorCode)  AS
       SELECT I.IDColor, I.Color, I.CodColor
       FROM InvColor I

GO

CREATE VIEW vw_Rep_InvSize AS
       SELECT I.IDSize, I.SizeName, I.CodSize
       FROM InvSize I
GO


CREATE VIEW vw_Rep_Invoice (IDPreSale, IDInvoice, IDCashRegMov, IDMeioPag, IDMedia, IDTouristGroup, IDOtherComission, IDCustomer, IDStore, IDLancPagOtherCom, PreSaleDate, InvoiceDate, DeliverDate, DeliverAddress, Passport, PassportDate, Ticket, AirLine, CompanyName, CompanyCGC, DepositDate, Tax, SubTotal, Note, ItemDiscount, TaxIsent, nOpenUser, RefreshInvoice, Printed, CashReceived, EstimatedPay, CardNumber, OtherExpences, Address, TaxIsemptValue, TaxIsemptItemDiscount, Layaway, FirstName, LastName, ZIP, nOpenHoldCaixa)  AS
       SELECT I.IDPreSale, I.IDInvoice, I.CashRegMovID, I.IDMeioPag, I.MediaID, I.IDTouristGroup, I.OtherComissionID, I.IDCustomer, I.IDStore, I.IDLancPagOtherCom, I.PreSaleDate, I.InvoiceDate, I.DeliverDate, I.DeliverAddress, I.Passport, I.PassportDate, I.Ticket, I.AirLine, I.CompanyName, I.CompanyCGC, I.DepositDate, I.Tax, I.SubTotal, I.Note, I.ItemDiscount, I.TaxIsent, I.nOpenUser, I.RefreshInvoice, I.Printed, I.CashReceived, I.EstimatedPay, I.CardNumber, I.OtherExpences, I.Address, I.TaxIsemptValue, I.TaxIsemptItemDiscount, I.Layaway, I.FirstName, I.LastName, I.ZIP, I.nOpenHoldCaixa
       FROM Invoice I
GO


CREATE VIEW vw_Rep_InventoryMovType (IDInventMovType, Name, Entering)  AS
       SELECT I.IDInventMovType, I.Name, I.Entrando
       FROM InventoryMovType I
GO

CREATE VIEW vw_Rep_Media AS
       SELECT M.IDMedia, M.IDOtherCommission, M.Media, M.TaxMode, M.PayComission
       FROM Media M
GO

CREATE VIEW vw_Rep_PaidCommission AS
       SELECT C.IDDocumento, C.IDLancPag
       FROM ComisPaga C
GO

CREATE VIEW vw_Rep_Acc_BankBranch (IDBranch, BranchCode, IDBank, Branch, Address, City, Hidden, Deleted, System)  AS
       SELECT BB.IDBancoAgencia, BB.CodigoBancoAgencia, BB.IDBanco, BB.BancoAgencia, BB.Endereco, BB.Bairro, BB.Hidden, BB.Desativado, BB.System
       FROM Fin_BancoAgencia BB
GO

CREATE VIEW vw_Rep_DiscRange (IDComissionedType, MinTotSale, PercDiscMax)  AS
       SELECT D.IDTipoComissionado, D.TotVendaMin, D.PercDiscMax
       FROM DiscRange D
GO

CREATE VIEW vw_Rep_SystemUser (IDUser, IDUserType, IDCommission, SystemUser)  AS
       SELECT S.IDUser, S.UserTypeID, S.ComissionID, S.SystemUser
       FROM SystemUser S
GO

CREATE VIEW vw_Rep_GroupToCommissionType (IDPersonType, IDGroup, Commission)  AS
       SELECT G.IDTipoComissionado, G.GroupID, G.Comission
       FROM GroupToComissionType G
GO

CREATE VIEW vw_Rep_Store (IDStore, IDCompany, Store, Address, Telephone, IDState, City, Zip, Fax, Beeper, Cel, Contact)  AS
       SELECT S.IDStore, S.IDEmpresa, S.Name, S.Address, S.Telephone, S.IDEstado, S.City, S.Zip, S.Fax, S.Beeper, S.Cellular, S.Contato
       FROM Store S
GO

CREATE VIEW vw_Rep_Acc_BankAccount (IDBankAccount, IDCurrency, IDCostCenter, IDBank, IDBankBranch, IDCompany, Type, BankAccountCode, Number, Manager, OpenDate, OBS, Balance, LastBalance, LastReconciliation, System, Deleted, Hidden)  AS
       SELECT BA.IDContaCorrente, BA.IDMoeda, BA.IDCentroCusto, BA.IDBanco, BA.IDBancoAgencia, BA.IDEmpresa, BA.Tipo, BA.CodigoContaCorrente, BA.Numero, BA.Gerente, BA.DataAbertura, BA.OBS, BA.SaldoAtual, BA.UltimoSaldoBancario, BA.UltimaReconciliacao, BA.System, BA.Desativado, BA.Hidden
       FROM Fin_ContaCorrente BA
GO

CREATE VIEW vw_Rep_Quotation (IDQuotation, IDStore, Quotation, LastIssue, QuotationDate)  AS
       SELECT C.IDCotacao, C.IDStore, C.Cotacao, C.UltimaEmissao, C.DataCotacao
       FROM Cotacao C
GO


CREATE VIEW vw_Rep_PaymentTypeToStore AS
       SELECT M.IDStore, M.IDMeioPag, M.IDContaCorrente
       FROM MeioPagToStore M


GO

CREATE VIEW vw_Rep_PreInventoryMov (IDPreInventoryMov, IDInventMovType, IDDocument, IDStore, IDModel, IDPerson, IDComission, IDUser, IDCotacao, MovDate, Qty, CostPrice, SalePrice, Discount, DateEstimatedMov, DateRealMov, QtyRealMov, Marked, ExchangeInvoice, SuggRetail)  AS
       SELECT P.IDPreInventoryMov, P.InventMovTypeID, P.DocumentID, P.StoreID, P.ModelID, P.IDPessoa, P.ComissionID, P.UserID, P.IDCotacao, P.MovDate, P.Qty, P.CostPrice, P.SalePrice, P.Discount, P.DateEstimatedMov, P.DateRealMov, P.QtyRealMov, P.Marked, P.ExchangeInvoice, P.SuggRetail
       FROM PreInventoryMov P
GO

CREATE VIEW vw_Rep_PurchaseOrder (IDPO, IDStore, IDVendor, OrderDate, _Open_, Freight, Charges, SubTotal, Atendido, PaymenteType)  AS
       SELECT P.IDPO, P.IDStore, P.IDFornecedor, P.DataPedido, P.Aberto, P.Freight, P.Charges, P.SubTotal, P.Atendido, P.PaymenteType
       FROM PO P
GO

CREATE VIEW vw_Rep_QuotationResult (IDModel, IDQuotation, Cost, PO, Qty)  AS
       SELECT C.IDModel, C.IDCotacao, C.Cost, C.PO, C.Qty
       FROM CotacaoResult C
GO

CREATE VIEW vw_Rep_QuotationToModel (IDQuotation, IDModel, IDRequest, QtyQuoted)  AS
       SELECT C.IDCotacao, C.IDModel, C.IDRequest, C.QtyCotada
       FROM CotacaoToModel C
GO

CREATE VIEW vw_Rep_QuotationToVendor (IDQuotation, IDVendor)  AS
       SELECT C.IDCotacao, C.IDFornecedor
       FROM CotacaoToFornec C
GO

CREATE VIEW vw_Rep_Records (RecordDate, IDPreSale, IDPaymentType, TotalInvoice, IDCashRegMov)  AS
       SELECT F.DataLancamento, F.IDPreSale, F.IDQuitacaoMeioPrevisto, F.ValorNominal, F.IDCashRegMov
       FROM Fin_Lancamento F
GO

CREATE VIEW vw_Rep_Repair (IDRepair, IDModel, IDStore, IDInvMovSend, IDCliente, IDUserSent, IDVendor, IDUserReceive, IDUserReturn, IDInvMovReturn, Status, ReceiveDate, SentDate, OBSReceive, RepairType, Qty, UPS, RA, DateLastCost, SerialNumber, LastCost, Defect, ReturnDate, ReturnStatus, OBSReturn, Tipo)  AS
       SELECT R.IDRepair, R.IDModel, R.IDStore, R.IDInvMovSend, R.IDCliente, R.IDUserSent, R.IDFornecedor, R.IDUserReceive, R.IDUserReturn, R.IDInvMovReturn, R.Fase, R.ReceiveDate, R.SentDate, R.OBSReceive, R.TipoRepair, R.Qty, R.UPS, R.RA, R.DateLastCost, R.SerialNumber, R.LastCost, R.Defect, R.ReturnDate, R.ReturnStatus, R.OBSReturn, R.Tipo
       FROM Repair R
GO

CREATE VIEW vw_Rep_Entity (IDPerson, IDAgency, IDAgenty, IDCustomer, IDVendor, IDCommission, IDManufactore,  IDPersonType, IDStore, IDState, IDUser, IDCountry, Code, FullName, FirstName, LastName, DBA, Address, City, Zip, Phone, Cellular, Fax, Beeper, Contact, Email, Limit, BirthDate, PaymentDay, BirthState, SocialSecurity, FederalID, SalesTax, HomePage, DriveLicense, GuideCommission, CoordDiscount, CommissAjust, CustomerCard)  AS
       SELECT P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDTipoPessoa, P.IDStore, P.IDEstado, P.IDUser, P.IDPais, P.Code, P.Pessoa, P.PessoaFirstName, P.PessoaLastName, P.NomeJuridico, P.Endereco, P.Cidade, P.CEP, P.Telefone, P.Cellular, P.Fax, P.Beeper, P.Contatos, P.Email, P.Limite, P.Nascimento, P.DiaQuitacao, P.CPF, P.CartTrabalho, P.InscEstadual, P.InscMunicipal, P.HomePage, P.OrgaoEmissor, P.ComissaoSobreGuia, P.DescontaCoordenacao, P.AjusteComiss, P.CustomerCard
       FROM Pessoa P
GO

CREATE VIEW vw_Rep_GroupCost AS
       SELECT G.IDCost, G.IDTouristGroup, G.IDCostType, G.IDInventoryMov, G.CostDate, G.UnitCost, G.Quantity
       FROM GroupCost G
GO

CREATE VIEW vw_Rep_GroupCostGift AS
       SELECT G.IDGroupCostGift, G.IDModel, G.IDUser
       FROM GroupCostGift G
GO

CREATE VIEW vw_Rep_Acc_BankAccountBalance (IDBankAccount, Date, Balance)  AS
       SELECT BAB.IDContaCorrente, BAB.Data, BAB.Saldo
       FROM Fin_ContaCorrenteSaldo BAB
GO

CREATE VIEW vw_Rep_Acc_DisbursementType (IDDisbursementsType, IDDocumentType, DisbursementType, DisbursementTypeCode, DisbursementIdent, Hidden, System, Deleted)  AS
       SELECT DT.IDDesdobramentoTipo, DT.IDDocumentoTipo, DT.DesdobramentoTipo, DT.CodigoDesdobramentoTipo, DT.IdentificadorDesdobramento, DT.Hidden, DT.System, DT.Desativado
       FROM Fin_DesdobramentoTipo DT
GO

CREATE VIEW vw_Rep_Acc_DocumentType (IDDocumentType, DocumentTypeCode, DocumentType, HasDisbursement, HasIssueDate, DocumentIdent, HasDocumentNumber, ObligateDisbursement, IDDisbursementDefault, Hidden, Deleted, System)  AS
       SELECT DT.IDDocumentoTipo, DT.CodigoDocumentoTipo, DT.DocumentoTipo, DT.PossuiDesdobramento, DT.DataEmissaoObrigatoria, DT.IdentificadorDocumento, DT.NumDocumentoObrigatorio, DT.DesdobramentoObrigatorio, DT.IDDesdobramentoTipoDefault, DT.Hidden, DT.Desativado, DT.System
       FROM Fin_DocumentoTipo DT
GO

CREATE VIEW vw_Rep_Acc_Payment (IDPayment, IDTransfer, IDPaymentType, IDBranch, IDBank, IDBankAccount, IDUser, Amount, Interest, PaymentDate, DocumentNumber, IDUserReconcile, Paying, ReconciliationDate, IsReconciliated, Payee, Deleted, Hidden, System)  AS
       SELECT Q.IDQuitacao, Q.IDTransferencia, Q.IDQuitacaoMeio, Q.IDBancoAgencia, Q.IDBanco, Q.IDContaCorrente, Q.IDUsuarioQuitacao, Q.ValorQuitacao, Q.ValorJuros, Q.DataQuitacao, Q.NumeroMeioQuit, Q.IDUsuarioReconciliacao, Q.Pagando, Q.DataReconciliacao, Q.AReconciliar, Q.Favorecido, Q.Desativado, Q.Hidden, Q.System
       FROM Fin_Quitacao Q
GO

CREATE VIEW vw_Rep_Acc_RecordPaid (IDPayment, IDRecord, IDUser, Amount, PaymentDate, Interest)  AS
       SELECT LQ.IDQuitacao, LQ.IDLancamento, LQ.IDUsuarioQuitacao, LQ.ValorQuitado, LQ.DataQuitacao, LQ.ValorJuros
       FROM Fin_LancQuit LQ
GO

CREATE VIEW vw_Rep_Acc_RecordType (IDRecordType, IDPerson, IDPersonType, IDBankAccount, IDRecordTypeParent, RecordType, Path, PathName, System, Hidden, Deleted)  AS
       SELECT LT.IDLancamentoTipo, LT.IDPessoa, LT.IDPessoaTipo, LT.IDContaCorrenteDefault, LT.IDLancamentoTipoParent, LT.LancamentoTipo, LT.Path, LT.PathName, LT.System, LT.Hidden, LT.Desativado
       FROM Fin_LancamentoTipo LT
GO

CREATE VIEW vw_Rep_Acc_Records (IDRecord, IDPaymentTypePrediction, Prediction, IDPreSale, IDPersonType, IDPaymentBankAccountPrediction, IDCompany, IDPerson, IDPaymentBankPrediction, IDDisbursementType, IDCurrencyQuoted, IDCurrency, IDUserRecord, ApprovalDate, IDCostCenter, Situation, RecordDate, IDRecordType, DueDate, OriginalDueDate, FirstPaymentDate, LastPaymentDate, Amount, Paid, IDDocumentType, DocumentNumber, DesbursementNumber, PaymentTypeNumberPrediction, IDBankAccountPrediction, IDUserApproved, IDUserCancelled, DuplicateNumber, CurrentSymbol, IDOriginalRecord, IssueDate, History, IDCashRegMov, Hidden, System, Deleted, Paying, Frequency)  AS
       SELECT L.IDLancamento, L.IDQuitacaoMeioPrevisto, L.Previsao, L.IDPreSale, L.IDPessoaTipo, L.IDBancoAgenciaQuitPrev, L.IDEmpresa, L.IDPessoa, L.IDBancoQuitPrev, L.IDDesdobramentoTipo, L.IDMoedaCotacao, L.IDMoeda, L.IDUsuarioLancamento, L.DataAprovacao, L.IDCentroCusto, L.Situacao, L.DataLancamento, L.IDLancamentoTipo, L.DataVencimento, L.DataVencimentoOriginal, L.DataInicioQuitacao, L.DataFimQuitacao, L.ValorNominal, L.TotalQuitado, L.IDDocumentoTipo, L.NumDocumento, L.NumDesdobramento, L.NumMeioQuitPrevisto, L.IDContaCorrentePrevista, L.IDUsuarioAprovacao, L.IDUsuarioProtesto, L.NumeroDuplicata, L.MoedaSigla, L.IDLancamentoOriginal, L.DataEmissao, L.Historico, L.IDCashRegMov, L.Hidden, L.System, L.Desativado, L.Pagando, L.NumeroRepeticoes
       FROM Fin_Lancamento L
GO

CREATE VIEW vw_Rep_Acc_RecordsTerms (IDRecord, DueDateShift, Discount)  AS
       SELECT LT.IDLancamento, LT.DueDateShift, LT.Discount
       FROM Fin_LancamentoTerm LT
GO

CREATE VIEW vw_Rep_Acc_Transfer (IDTransfer, IDBankAccountCredit, IDBankAccountDebit, Date, Amount, Obs, IDUser)  AS
       SELECT T.IDTransferencia, T.IDContaCorrenteCredito, T.IDContaCorrenteDebito, T.Data, T.Valor, T.Obs, T.IDUsuario
       FROM Fin_Transferencia T
GO

CREATE VIEW vw_Rep_Acc_User (IDUser, UserCode, Users, Deleted, Hidden, System) AS
	SELECT U.IDUser, U.CodSystemUser, U.SystemUser, U.Desativado, U.Hidden, U.System
	FROM SystemUser U
GO

CREATE VIEW vw_Rep_Acc_UserGroup (IDGroup, IDUser)  AS
       SELECT UG.IDGrupo, UG.IDUsuario
       FROM Sis_UsuarioGrupo UG
GO

CREATE VIEW vw_Rep_Model (IDModel, GroupID, IDUnidade, IDFabricante, IDSize, IDColor, Model, Description, FreightCost, OtherCost, VendorCost, DateLastCost, MarkUp, SellingPrice, DateLastSellingPrice, Weight, Avaiable, LastCost, SuggRetail, VD, SX, TotQtyOnHand, SX2, LastMovDate, PVD, DP, ES, PP, VP, InicioPontoPedido, ABCClass, AutomaticRequest, TR, ModelType, CustomSalePrice, CustomCostPrice, CustomSpecialPrice, CustomPromotion, AvgCost, FinalCost, Deleted)  AS
       SELECT M.IDModel, M.GroupID, M.IDUnidade, M.IDFabricante, M.IDSize, M.IDColor, M.Model, M.Description, M.FreightCost, M.OtherCost, M.VendorCost, M.DateLastCost, M.MarkUp, M.SellingPrice, M.DateLastSellingPrice, M.Peso, M.Avaiable, M.LastCost, M.SuggRetail, M.VD, M.SX, M.TotQtyOnHand, M.SX2, M.LastMovDate, M.PVD, M.DP, M.ES, M.PP, M.VP, M.InicioPontoPedido, M.ClasseABC, M.AutomaticRequest, M.TR, M.ModelType, M.CustomSalePrice, M.CustomCostPrice, M.CustomSpecialPrice, M.CustomPromotion, M.AvgCost, M.FinalCost, M.Desativado
       FROM Model M

GO

CREATE VIEW vw_Rep_ModelTransf (IDModelTransf, IDLojaOrigem, IDLojaDestino, IDUser, Date)  AS
       SELECT M.IDModelTransf, M.IDLojaOrigem, M.IDLojaDestino, M.IDUser, M.Data
       FROM ModelTransf M

GO


CREATE VIEW vw_Rep_ModelTransfDet AS
       SELECT M.IDModelTransfDet, M.IDModelTransf, M.IDModel, M.Qty
       FROM ModelTransfDet M


GO

CREATE VIEW dbo.vw_Rep_AgedInventory
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
	I.IDStore,
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
	M.Deleted,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.SuggRetail) ELSE 0 END) AS ExtSuggRetail,
	M.SuggRetail,
	M.LastMovDate,
	M.AvgCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.FinalCost) ELSE 0 END) AS ExtFinalCost,
	M.FinalCost,
	CASE WHEN M.SellingPrice > 0 THEN M.SellingPrice - M.FinalCost END as RealMarkUpValue,
	CASE WHEN M.SellingPrice > 0 AND M.FinalCost <> 0 THEN ROUND(( (M.SellingPrice-M.FinalCost)/M.FinalCost * 100),2) END as RealMarkUpPercent,
	TG.Category,
	(CASE WHEN I.QtyOnHand > 0 THEN IsNull(I.QtyOnHand,0) ELSE 0 END) as PostiveQtyOnHand,
	IsNull(F.FullName,'Not Defined') as Manufacture,
	DATEDIFF(day, M.DateLastCost, getdate()) as Days,
	I.QtyOnHand,
	I.QtyOnPreSale,
	I.QtyOnOrder,
	I.QtyOnRepair,
	I.QtyInReceiving
FROM
	vw_Rep_Model M
	JOIN vw_Rep_Category TG ON (M.GroupID = TG.IDCategory)
	LEFT OUTER JOIN 
		(
		SELECT
			I.IDModel,
			I.IDStore,
			SUM(IsNull(I.QtyOnHand,0)) as QtyOnHand,
			SUM(IsNull(I.QtyOnPreSale,0)) as QtyOnPreSale,
			SUM(IsNull(I.QtyOnOrder,0)) as QtyOnOrder,
			SUM(IsNull(I.QtyOnRepair,0)) as QtyOnRepair,
			SUM(IsNull(I.QtyOnPrePurchase,0)) as QtyInReceiving
		FROM			
			vw_Rep_Inventory I
			JOIN vw_Rep_Model M ON (I.IDModel = m.IDModel)
		GROUP BY
			I.IDModel,I.IDStore
		) I ON (M.IDModel = I.IDModel)
	LEFT OUTER JOIN vw_Rep_Entity F ON ( M.IDFabricante = F.IDPerson AND F.IDPersonType = 7 )
WHERE 
	M.Deleted = 0




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE VIEW dbo.vw_Rep_AgencyAgentInvoices
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para ser utilizada no relatório Agency & Agent Invoices by Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
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
	C.IDCategory,
	C.Category,
	ME.Media,
	S.IDStore,
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
	AGN.IDAgency,
	AGN.FullName as Agency,
	AGT.IDAgenty,
	AGT.FullName as Agent
FROM	
	vw_Rep_InventoryMov IMV
	JOIN vw_Rep_Entity COM ON (COM.IDPerson = IMV.IDComission)
	JOIN vw_Rep_Store S ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)
	LEFT OUTER JOIN vw_Rep_InvColor INVC ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS ON (INVS.IDSize = M.IDSize)
	JOIN vw_Rep_Invoice I ON (I.IDInvoice = IMV.IDDocument)
	JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia)
	LEFT OUTER JOIN vw_Rep_TouristGroup TRG ON (TRG.IDTouristGroup = I.IDTouristGroup)
	LEFT OUTER JOIN vw_Rep_Entity AGN ON (AGN.IDPerson = TRG.IDAgency)
	LEFT OUTER JOIN vw_Rep_Entity AGT ON (AGT.IDPerson = TRG.IDGuide)
WHERE
	IMV.IDInventMovType = 1
	AND
	I.IDTouristGroup IS NOT NULL
	AND
	I.IDInvoice IS NOT NULL







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_Barcode (Barcode, IDModel, Date)  AS
       SELECT B.IDBarcode, B.IDModel, B.Data
       FROM Barcode B


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_BestSeller (IDCategory, IDVendor, MovDate, Path, IDModel, Model, Description, Profit, CostPrice, Qty, SalePrice, Discount, QtySold, TotQtyOnHand)  AS
       SELECT M.GroupID, M.IDFabricante, IM.MovDate, TG.Path, M.IDModel, M.Model, M.Description, SUM((IM.SalePrice - IM.CostPrice) * IM.Qty - IM.Discount), IM.CostPrice, IM.Qty, IM.SalePrice, IM.Discount, SUM(IM.Qty), M.TotQtyOnHand
       FROM InventoryMov IM, Model M, TabGroup TG
       WHERE (IM.ModelID = M.IDModel)
AND
(M.GroupID = TG.IDGroup)
AND
(InventMovTypeID = 1)
       GROUP BY M.GroupID,
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_CashRegLog AS
       SELECT C.IDCashRegLog, C.IDCashRegMov, C.IDCashRegTipoLog, C.IDUser, C.LogTime, C.Bill100, C.Bill50, C.Bill20, C.Bill10, C.Bill5, C.Bill2, C.Bill1, C.Coin1, C.Coin050, C.Coin025, C.Coin010, C.Coin005, C.Coin001, C.TotalCard, C.TotalCheck, C.TotalOther, C.TotalCash, C.TotalCashConf, C.TotalOtherConf, C.TotalCheckConf, C.TotalCardConf, C.TotalCardPre, C.TotalCardPreConf, C.LogDocument
       FROM CashRegLog C


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_CashRegMov AS
       SELECT C.IDCashRegMov, C.IDCashRegister, C.IDCashRegStatus, C.OpenTime, C.IDOpenUser, C.TotalDeposit, C.TotalSales, C.TotalWidraw, C.OpenDeposit, C.FinalWidraw, C.TotalSaleCash, C.TotalPetty, C.FinalCount, C.ManagerCount
       FROM CashRegMov C


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_ClientRepair (IDRepair, IDModel, IDStore, IDInvMovSend, IDClient, Status, IDVendor, IDUserReceive, ReceiveDate, SentDate, OBSReceive, RepairType, IDUserSent, Qty, UPS, RA, DateLastCost, SerialNumber, LastCost, Defect, IDUserReturn, ReturnDate, OBSReturn, IDUserBack, BackDate, IDInvMovReturn, OBSBack)  AS
       SELECT R.IDRepair, R.IDModel, R.IDStore, R.IDInvMovSend, R.IDCliente, R.Fase, R.IDFornecedor, R.IDUserReceive, R.ReceiveDate, R.SentDate, R.OBSReceive, R.TipoRepair, R.IDUserSent, R.Qty, R.UPS, R.RA, R.DateLastCost, R.SerialNumber, R.LastCost, R.Defect, R.IDUserReturn, R.ReturnDate, R.OBSReturn, R.IDUserBack, R.BackDate, R.IDInvMovReturn, R.OBSBack
       FROM Repair R
       WHERE R.Tipo = 1


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_CommissionBonus (SalesPerson, TotalDiscount, MovDate, IDPessoa)  AS
       SELECT P.Pessoa, SUM(IM.Discount), IM.MovDate, P.IDPessoa
       FROM InventoryMov IM, Pessoa P
       WHERE IM.ComissionID = P.IDPessoa
AND
(IM.Discount < 0)
AND 
(P.IDTipoPessoa = 4) 
AND 
(IM.InventMovTypeID = 1)
       GROUP BY P.Pessoa, 
IM.MovDate, P.IDPessoa


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE VIEW dbo.vw_Rep_CommissionDetails
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para ser utilizada no relatório Agency & Agent Invoices by Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
SELECT
	ME.PayComission,
	IMV.IDUser,
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
	C.IDCategory,
	C.Category,
	ME.Media,
	S.IDStore,
	S.Store,
	S.Address as StoreAddress,
	S.Telephone as StorePhone,
	S.IDState as State,
	S.City as StoreCity,
	S.Zip as StoreZip,
	S.Fax as StoreFax,
	S.Contact as StoreContact,
	COM.IDCommission,
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
	ROUND(((((IMV.SalePrice - (IMV.CostPrice * ET.CommissionOnProfit)) * IMV.Qty - IMV.Discount)) * ( GCT.Commission / 100 )),2) * ME.PayComission as Commission

FROM	
	vw_Rep_Invoice I 
	JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia)
	JOIN vw_Rep_InventoryMov IMV ON (I.IDInvoice = IMV.IDDocument)
	JOIN vw_Rep_Entity COM ON (COM.IDPerson = IMV.IDComission)
	JOIn vw_Rep_EntityType ET ON (ET.IDPersonType = COM.IDPersonType)
	JOIN vw_Rep_Store S ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)
	JOIN vw_Rep_GroupToCommissionType GCT ON (GCT.IDPersonType = COM.IDPersonType AND GCT.IDGroup = M.GroupID)
	LEFT OUTER JOIN vw_Rep_InvColor INVC ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS ON (INVS.IDSize = M.IDSize)
WHERE
	IMV.IDInventMovType = 1






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW vw_Rep_CustomerPurchaseHistory AS

SELECT
	PU.IDUserFinalReceiving,
	PU.IDUserPreReceiving,
	PU.IDStore,
	PU.IDFornecedor,
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
	M.IDModel,
	M.Model,
	M.Description,
	M.IDFabricante as IDManufacture,
	C.IDCategory,
	C.Category,
	MAN.FullName as Manufacture
FROM
	Pur_Purchase PU
	JOIN vw_Rep_Entity V ON (PU.IDFornecedor = V.IDPerson)
	JOIN vw_Rep_Store S ON (S.IDStore = PU.IDStore)
	LEFT OUTER JOIN vw_Rep_SystemUser SUP ON ( PU.IDUserPreReceiving = SUP.IDUser )
	LEFT OUTER JOIN vw_Rep_SystemUser SUF ON ( PU.IDUserFinalReceiving = SUF.IDUser )
	LEFT OUTER JOIN Pur_PurchaseTotal PT ON (PU.IDPurchase = PT.IDPurchase)
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
	JOIN vw_Rep_Model M ON (M.IDModel = PUI.IDModel)
	LEFT OUTER JOIN vw_Rep_Entity MAN ON (MAN.IDPerson = M.IDFabricante)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE VIEW vw_Rep_CustomerPurchaseHistory_Sub AS
SELECT vw_Rep_InventoryMov.MovDate, 
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
FROM vw_Rep_InventoryMov vw_Rep_InventoryMov
      INNER JOIN vw_Rep_Store vw_Rep_Store ON 
     (vw_Rep_Store.IDStore = vw_Rep_InventoryMov.IDStore)
      INNER JOIN vw_Rep_Model vw_Rep_Model ON 
     (vw_Rep_Model.IDModel = vw_Rep_InventoryMov.IDModel)
      INNER JOIN vw_Rep_Invoice vw_Rep_Invoice ON 
     (vw_Rep_Invoice.IDInvoice = vw_Rep_InventoryMov.IDDocument)
      INNER JOIN vw_Rep_Media vw_Rep_Media ON 
     (vw_Rep_Media.IDMedia = vw_Rep_Invoice.IDMedia)
      INNER JOIN vw_Rep_Entity vw_Rep_Entity ON 
     (vw_Rep_Entity.IDCustomer = vw_Rep_Invoice.IDCustomer)
WHERE ( vw_Rep_InventoryMov.IDInventMovType = 1 )
       AND ( vw_Rep_Model.IDFabricante IS NOT NULL  )
       AND ( vw_Rep_Invoice.IDCustomer <> 1 )


GO

CREATE VIEW vw_Rep_InvTotal (Category, CountModel, QtyOnHand, QtyOnOrder, QtyOnHandOrder, SumLastCost, SumAvgCost)  AS
       SELECT TG.Name, COUNT(IDModel), SUM(CASE WHEN IsNull(I.QtyOnHand, 0) > 0 THEN I.QtyOnHand ELSE 0 END), SUM(IsNull(I.QtyOnOrder, 0)), SUM(CASE WHEN IsNull(I.QtyOnHand, 0) > 0 THEN IsNull(I.QtyOnOrder, 0) + I.QtyOnHand ELSE IsNull(I.QtyOnOrder, 0) + 0 END), SUM(CASE WHEN IsNull(I.QtyOnHand, 0) > 0 THEN LastCost * I.QtyOnHand ELSE 0 END), SUM(CASE WHEN IsNull(I.QtyOnHand, 0) > 0 THEN (VendorCost + FreightCost + OtherCost) * I.QtyOnHand ELSE 0 END)
       FROM Model M, Inventory I, TabGroup TG
       WHERE (M.IDModel = I.ModelID)
AND
(M.GroupID = TG.IDGroup)
AND
(M.Desativado = 0)
       GROUP BY TG.Name, 
StoreID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_InveItemStock (DateLastCost, Category, Model, Description, SellingPrice, LastCost, QtyOnHand, Manufacturer, Days, IDStore)  AS
       SELECT M.DateLastCost, TG.Name, M.Model, M.Description, M.SellingPrice, M.LastCost, SUM(ISNULL(I.QtyOnHand, 0)), ISNULL(F.Manufacturer, 'Not Defined'), DATEDIFF(day, M.DateLastCost, GETDATE()), F.IDStore
       FROM Model M, Inventory I, TabGroup TG, vwFabricante F
       WHERE M.IDModel = I.ModelID
AND
M.GroupID = TG.IDGroup
AND
M.IDFabricante = F.IDFabricante
AND
M.Desativado = 0
       GROUP BY M.DateLastCost, 
TG.Name, 
M.Model, 
M.Description, 
M.SellingPrice, 
M.LastCost, 
F.Manufacturer, 
F.IDStore

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
	vw_Rep_Inventory I
	JOIN vw_Rep_Model M ON (I.IDModel = m.IDModel)
GROUP BY I.IDModel




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO





CREATE VIEW dbo.vw_Rep_InventoryQtyByStore
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
	I.IDStore,
	SUM(IsNull(I.QtyOnHand,0)) as QtyOnHand,
	SUM(IsNull(I.QtyOnPreSale,0)) as QtyOnPreSale,
	SUM(IsNull(I.QtyOnOrder,0)) as QtyOnOrder,
	SUM(IsNull(I.QtyOnRepair,0)) as QtyOnRepair,
	SUM(IsNull(I.QtyOnPrePurchase,0)) as QtyInReceiving
FROM			
	vw_Rep_Inventory I
	JOIN vw_Rep_Model M ON (I.IDModel = m.IDModel)
GROUP BY I.IDModel,I.IDStore



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_InventoryRepair (IDRepair, IDModel, IDStore, IDInvMovSend, Status, IDVendor, IDUserReceive, ReceiveDate, SentDate, OBSReceive, RepairType, IDUserSent, Qty, UPS, RA, DateLastCost, SerialNumber, LastCost, Defect, IDUserReturn, ReturnDate, OBSReturn, IDUserBack, BackDate, IDInvMovReturn, OBSBack)  AS
       SELECT R.IDRepair, R.IDModel, R.IDStore, R.IDInvMovSend, R.Fase, R.IDFornecedor, R.IDUserReceive, R.ReceiveDate, R.SentDate, R.OBSReceive, R.TipoRepair, R.IDUserSent, R.Qty, R.UPS, R.RA, R.DateLastCost, R.SerialNumber, R.LastCost, R.Defect, R.IDUserReturn, R.ReturnDate, R.OBSReturn, R.IDUserBack, R.BackDate, R.IDInvMovReturn, R.OBSBack
       FROM Repair R


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_InventorySerial AS
       SELECT I.Serial
       FROM InventorySerial I


GO

CREATE VIEW dbo.vw_Rep_InvoiceDate
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


/*vw_Rep_InvoiceDate*/

SELECT
	IMV.IDInventoryMov,
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
	AGT.FullName as Agent
	

FROM	
	vw_Rep_InventoryMov IMV
	JOIN vw_Rep_Entity COM ON (COM.IDPerson = IMV.IDComission)
	JOIN vw_Rep_Store S ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)
	LEFT OUTER JOIN vw_Rep_InvColor INVC ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS ON (INVS.IDSize = M.IDSize)
	JOIN vw_Rep_Invoice I ON (I.IDInvoice = IMV.IDDocument)
	JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia)
	LEFT OUTER JOIN vw_Rep_TouristGroup TRG ON (TRG.IDTouristGroup = I.IDTouristGroup)
	LEFT OUTER JOIN vw_Rep_Entity AGN ON (AGN.IDPerson = TRG.IDAgency)
	LEFT OUTER JOIN vw_Rep_Entity AGT ON (AGT.IDPerson = TRG.IDGuide)
WHERE
	IMV.IDInventMovType = 1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
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
	Pur_Purchase PU
	JOIN vw_Rep_Entity V ON (PU.IDFornecedor = V.IDPerson)
	JOIN vw_Rep_Store S ON (S.IDStore = PU.IDStore)
	LEFT OUTER JOIN vw_Rep_SystemUser SUP ON ( PU.IDUserPreReceiving = SUP.IDUser )
	LEFT OUTER JOIN vw_Rep_SystemUser SUF ON ( PU.IDUserFinalReceiving = SUF.IDUser )
	LEFT OUTER JOIN Pur_PurchaseTotal PT ON (PU.IDPurchase = PT.IDPurchase)
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
	JOIN vw_Rep_Model M ON (M.IDModel = PUI.IDModel)
	LEFT OUTER JOIN vw_Rep_Entity MAN ON (MAN.IDPerson = M.IDFabricante)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW dbo.vw_Rep_OpenLayawayHold
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


/*vw_Rep_OpenLayawayHold*/

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
	AGT.FullName as Agent
FROM	
	vw_Rep_PreInventoryMov PIMV
	JOIN vw_Rep_Entity COM ON (COM.IDPerson = PIMV.IDComission)
	JOIN vw_Rep_Store S ON (S.IDStore = PIMV.IDStore)
	JOIN vw_Rep_Model M ON (PIMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)
	LEFT OUTER JOIN vw_Rep_InvColor INVC ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS ON (INVS.IDSize = M.IDSize)
	JOIN vw_Rep_Invoice I ON (I.IDPreSale = PIMV.IDDocument)
	JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia)
	LEFT OUTER JOIN vw_Rep_Entity CUS ON (CUS.IDPerson = PIMV.IDPerson)
	LEFT OUTER JOIN vw_Rep_TouristGroup TRG ON (TRG.IDTouristGroup = I.IDTouristGroup)
	LEFT OUTER JOIN vw_Rep_Entity AGN ON (AGN.IDPerson = TRG.IDAgency)
	LEFT OUTER JOIN vw_Rep_Entity AGT ON (AGT.IDPerson = TRG.IDGuide)
WHERE
	PIMV.IDInventMovType = 1
--ORDER BY
--	PIMV.IDDocument,
--	PIMV.MovDate




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_PaymentType (IDMeioPag, IDContaCorrente, IDMeioPagBatch, IDLancamentoTipo, IDPessoa, MeioPag, CodigoMeioPag, HasDocument, ReceiveTime, AdminTax, DocumentIdentifier, TaxMode, Type, PossuiFavorecido, ObrigaFavorecido, HasNumber, NumberRequired, ParentType)  AS
       SELECT M.IDMeioPag, M.IDContaCorrente, M.IDMeioPagBatch, M.IDLancamentoTipo, M.IDPessoa, M.MeioPag, M.CodigoMeioPag, M.TemDocumento, M.PrazoRecebimento, M.TaxaAdmin, M.IdentificadorDocumento, M.TaxMode, M.Tipo, M.PossuiFavorecido, M.ObrigaFavorecido, M.PossuiNumero, M.ObrigaNumero, M.ParentType
       FROM MeioPag M


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_PaymentTypeMinSale AS
       SELECT M.IDMeioPag, M.DifDay, M.TotalSale
       FROM MeioPagMinSale M
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
	vw_Rep_InventoryMov IMV
	JOIN vw_Rep_Store S ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Invoice I ON (I.IDInvoice = IMV.IDDocument)
	JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia)
	JOIN vw_Rep_Entity C ON (C.IDPerson = I.IDCustomer)
WHERE
	IMV.IDInventMovType = 1
	AND
	M.IDFabricante IS NOT NULL
	AND
	I.IDCustomer <> 1 --No Register Customer
/*
	AND 
	M.IDFabricante IN (SELECT IDFabricante FROM Model WHERE IDModel IN ( SELECT IDModel FROM #Ret_ReportSource GROUP BY IDModel ))
*/


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_SalesBySalesPerson (ComissionID, Pessoa, MovDate, Model, Description, SellingPrice, Qty, SalePrice, CostPrice, Discount, TotalDiscount, Comissao)  AS
       SELECT InventoryMov.ComissionID, Pessoa.Pessoa, InventoryMov.MovDate, Model.Model, Model.Description, Model.SellingPrice, InventoryMov.Qty, ((SalePrice - Discount) / Qty), InventoryMov.CostPrice, (InventoryMov.Discount), ((InventoryMov.Discount / Qty)), ((((InventoryMov.SalePrice - (InventoryMov.CostPrice * TipoPessoa.ComissionOnProfit)) * InventoryMov.Qty - InventoryMov.Discount)) * (Comission / 100))  * Media.PayComission
       FROM Model, InventoryMov, Pessoa, TipoPessoa, Invoice, Media, GroupToComissionType
       WHERE (Model.IDModel = InventoryMov.ModelID)
AND
(InventoryMov.ComissionID = Pessoa.IDPessoa)
AND
(Pessoa.IDTipoPessoa = TipoPessoa.IDTipoPessoa)
AND
(InventoryMov.DocumentID = Invoice.IDInvoice)
AND
(Invoice.MediaID = Media.IDMedia)
AND
(GroupToComissionType.GroupID = Model.GroupID)
AND
(Pessoa.IDTipoPessoa = GroupToComissionType.IDTipoComissionado)
AND
(InventoryMov.InventMovTypeID = 1)
AND
(InventoryMov.Discount <> 0)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_SalesPersonCommission (TipTouristGroup, IDInvoice, InvoiceDate, Tax, Media, Model, Description, Qty, Customer, InvoiceTotal, ItemCost, ItemValue, ItemProfit, Commission, SalesPerson, IDStore, Category)  AS
       SELECT TourGrp.TipTouristGroup, Invo.IDInvoice, Invo.InvoiceDate, Invo.Tax, Media.Media, Model.Model, Model.Description, InvMov.Qty, Pes.Pessoa, Invo.SubTotal - Invo.ItemDiscount, InvMov.CostPrice * InvMov.Qty, InvMov.SalePrice * InvMov.Qty - InvMov.Discount, InvMov.SalePrice * InvMov.Qty - InvMov.Discount - InvMov.CostPrice * InvMov.Qty, ((InvMov.SalePrice - InvMov.CostPrice * TipoPes.ComissionOnProfit) * InvMov.Qty - InvMov.Discount) * GrpComisType.Comission / 100 * Media.PayComission, SalesPerson.Pessoa, Invo.IDStore, TG.Path
       FROM Invoice Invo, TouristGroup TourGrp, InventoryMov InvMov, Model, TabGroup TG, Media, Pessoa Pes, Pessoa SalesPerson, TipoPessoa TipoPes, GroupToComissionType GrpComisType
       WHERE Invo.IDTouristGroup *= TourGrp.IDTouristGroup 
AND
InvMov.DocumentID = Invo.IDInvoice
AND
InvMov.ModelID = Model.IDModel
AND
Model.GroupID = TG.IDGroup
AND
Invo.MediaID = Media.IDMedia
AND
Invo.IDCustomer = Pes.IDPessoa
AND
InvMov.ComissionID = SalesPerson.IDPessoa
AND
SalesPerson.IDTipoPessoa = TipoPes.IDTipoPessoa
AND
GrpComisType.GroupID = Model.GroupID 
AND 
SalesPerson.IDTipoPessoa = GrpComisType.IDTipoComissionado
AND
InvMov.InventMovTypeID = 1


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW vw_Rep_SalesPersonResult (SalesPerson, SalesPersonType, SumSales, SumCost, SumProfit, SumCommission, IDStore, Category, Media, InvoiceDate)  AS
       SELECT Pes.Pessoa, TpPes.TipoPessoa, SUM(InvMov.SalePrice * InvMov.Qty - InvMov.Discount), SUM(InvMov.CostPrice * InvMov.Qty), SUM((InvMov.SalePrice - InvMov.CostPrice) * InvMov.Qty - InvMov.Discount), SUM(((ISNULL(InvMov.SalePrice, 0) - ISNULL(InvMov.CostPrice, 0) * ISNULL(TpPes.ComissionOnProfit, 1)) * 
               ISNULL(InvMov.Qty, 0) - ISNULL(InvMov.Discount, 0)) * ISNULL(GTC.Comission, 0) / 100 * ISNULL(Media.PayComission, 1)), Inv.IDStore, TG.Path, Media.Media, Inv.InvoiceDate
       FROM InventoryMov InvMov, Invoice Inv, Model Mod, TabGroup TG, Pessoa Pes, TipoPessoa TpPes, Media, GroupToComissionType GTC
       WHERE InvMov.DocumentID = Inv.IDInvoice 
AND
InvMov.ModelID = Mod.IDModel 
AND
Mod.GroupID = TG.IDGroup 
AND
InvMov.ComissionID = Pes.IDPessoa 
AND
Pes.IDTipoPessoa = TpPes.IDTipoPessoa 
AND
Inv.MediaID = Media.IDMedia 
AND
Mod.GroupID = GTC.GroupID 
AND 
Pes.IDTipoPessoa = GTC.IDTipoComissionado
AND
InvMov.InventMovTypeID = 1
       GROUP BY Pes.Pessoa, 
TpPes.TipoPessoa, 
Inv.IDStore, 
Media.Media, 
TG.Path, 
Inv.InvoiceDate


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
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
FROM vw_Rep_InventoryMov vw_Rep_InventoryMov
      INNER JOIN vw_Rep_Invoice vw_Rep_Invoice ON 
     (vw_Rep_Invoice.IDInvoice = vw_Rep_InventoryMov.IDDocument)
      INNER JOIN vw_Rep_Media vw_Rep_Media ON 
     (vw_Rep_Media.IDMedia = vw_Rep_Invoice.IDMedia)
      INNER JOIN vw_Rep_Model vw_Rep_Model ON 
     (vw_Rep_Model.IDModel = vw_Rep_InventoryMov.IDModel)
      INNER JOIN vw_Rep_Category vw_Rep_Category ON 
     (vw_Rep_Category.IDCategory = vw_Rep_Model.GroupID)
WHERE ( vw_Rep_InventoryMov.IDInventMovType = 1 )
GROUP BY
	vw_Rep_InventoryMov.IDStore,
	CONVERT(varchar(10), vw_Rep_InventoryMov.MovDate, 101), 
       DatePart(year, vw_Rep_InventoryMov.MovDate),
       Convert(Varchar(10),DateName(month, vw_Rep_InventoryMov.MovDate)),
       DatePart(month, vw_Rep_InventoryMov.MovDate),
       DatePart(day, vw_Rep_InventoryMov.MovDate)
GO

CREATE VIEW vw_Rep_ZipCode (IDStore, ZIP, Total, InvQty, CostPrice, Gross)  AS
       SELECT I.IDStore, I.ZIP, SUM((IM.SalePrice * IM.Qty) - IM.Discount), COUNT(I.IDInvoice), SUM((IM.CostPrice) * IM.Qty), SUM(((IM.SalePrice - IM.CostPrice) * IM.Qty) - IM.Discount)
       FROM Invoice I, InventoryMov IM
       WHERE IM.DocumentID = I.IDInvoice
AND
I.IDInvoice IS NOT NULL 
AND 
LTRIM(I.ZIP) IS NOT NULL 
AND 
IM.InventMovTypeID = 1
       GROUP BY I.ZIP,
I.IDStore


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

