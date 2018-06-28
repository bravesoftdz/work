USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[PreInventoryMov]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PreInventoryMov](
	[IDPreInventoryMov] [int] NOT NULL,
	[InventMovTypeID] [int] NULL,
	[StoreID] [int] NULL,
	[ModelID] [int] NULL,
	[IDPessoa] [int] NULL,
	[UserID] [int] NULL,
	[IDCotacao] [int] NULL,
	[IDPreInventoryMovParent] [int] NULL,
	[BarCodeID] [dbo].[TBarCode] NULL,
	[DocumentID] [int] NOT NULL,
	[MovDate] [smalldatetime] NULL,
	[CostPrice] [money] NULL,
	[SalePrice] [money] NULL,
	[Discount] [money] NULL,
	[DateEstimatedMov] [smalldatetime] NULL,
	[DateRealMov] [smalldatetime] NULL,
	[Marked] [bit] NULL,
	[ExchangeInvoice] [int] NULL,
	[SuggRetail] [money] NULL,
	[IDParentPack] [int] NULL,
	[IDModelService] [int] NULL,
	[IDPreInvMovExchange] [int] NULL,
	[DesiredMarkup] [money] NULL,
	[CaseCost] [money] NULL,
	[Promo] [bit] NULL,
	[IDDepartment] [int] NOT NULL,
	[IDTaxCategory] [int] NULL,
	[Qty] [decimal](38, 4) NULL,
	[QtyRealMov] [decimal](38, 4) NULL,
	[QtyExceeded] [decimal](38, 4) NULL,
	[QtyExchanged] [decimal](38, 4) NULL,
	[CaseQty] [decimal](38, 4) NULL,
	[SequencyNum] [int] NULL,
	[TotParcial] [varchar](10) NULL,
	[DiscountPromo] [money] NULL,
	[UnitDiscount] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__PreInventoryMov__04AFB25B] PRIMARY KEY NONCLUSTERED 
(
	[IDPreInventoryMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PreInventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_Cotacao_PreInventoryMov_IDCotacao] FOREIGN KEY([IDCotacao])
REFERENCES [dbo].[Cotacao] ([IDCotacao])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[PreInventoryMov] CHECK CONSTRAINT [FK_Cotacao_PreInventoryMov_IDCotacao]
GO
ALTER TABLE [dbo].[PreInventoryMov]  WITH CHECK ADD  CONSTRAINT [FK_InvDepartment_PreInventoryMov_IDDepartment] FOREIGN KEY([IDDepartment])
REFERENCES [dbo].[Inv_Department] ([IDDepartment])
GO
ALTER TABLE [dbo].[PreInventoryMov] CHECK CONSTRAINT [FK_InvDepartment_PreInventoryMov_IDDepartment]
GO
ALTER TABLE [dbo].[PreInventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_InventoryMovType_PreInventoryMov_InventMovTypeID] FOREIGN KEY([InventMovTypeID])
REFERENCES [dbo].[InventoryMovType] ([IDInventMovType])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[PreInventoryMov] CHECK CONSTRAINT [FK_InventoryMovType_PreInventoryMov_InventMovTypeID]
GO
ALTER TABLE [dbo].[PreInventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_PreInventMov_ModelID] FOREIGN KEY([ModelID])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[PreInventoryMov] CHECK CONSTRAINT [FK_Model_PreInventMov_ModelID]
GO
ALTER TABLE [dbo].[PreInventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_PreInventoryMov_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[PreInventoryMov] CHECK CONSTRAINT [FK_Pessoa_PreInventoryMov_IDPessoa]
GO
ALTER TABLE [dbo].[PreInventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_PreInventoryMov_PreInventoryMov_IDPreInventoryMovParent] FOREIGN KEY([IDPreInventoryMovParent])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[PreInventoryMov] CHECK CONSTRAINT [FK_PreInventoryMov_PreInventoryMov_IDPreInventoryMovParent]
GO
ALTER TABLE [dbo].[PreInventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_PreInventoryMov_StoreID] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[PreInventoryMov] CHECK CONSTRAINT [FK_Store_PreInventoryMov_StoreID]
GO
ALTER TABLE [dbo].[PreInventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_PreInvnetoryMov_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[PreInventoryMov] CHECK CONSTRAINT [FK_SystemUser_PreInvnetoryMov_UserID]
GO
ALTER TABLE [dbo].[PreInventoryMov]  WITH CHECK ADD  CONSTRAINT [FK_TaxCategory_PreInventMov_IDTaxCategory] FOREIGN KEY([IDTaxCategory])
REFERENCES [dbo].[TaxCategory] ([IDTaxCategory])
GO
ALTER TABLE [dbo].[PreInventoryMov] CHECK CONSTRAINT [FK_TaxCategory_PreInventMov_IDTaxCategory]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_Zero128]  DEFAULT (0) FOR [CostPrice]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_Zero129]  DEFAULT (0) FOR [SalePrice]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_Zero130]  DEFAULT (0) FOR [Discount]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_Zero132]  DEFAULT (0) FOR [Marked]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_Zero133]  DEFAULT (0) FOR [SuggRetail]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_Zero2512]  DEFAULT (0) FOR [Promo]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_PreInventoryMov_IDDepartment_Zero]  DEFAULT (0) FOR [IDDepartment]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_ZERO127]  DEFAULT (0) FOR [Qty]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_ZERO131]  DEFAULT (0) FOR [QtyRealMov]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  CONSTRAINT [DF_Zero1482]  DEFAULT (0) FOR [QtyExceeded]
GO
ALTER TABLE [dbo].[PreInventoryMov] ADD  DEFAULT ((0)) FOR [DiscountPromo]
GO
