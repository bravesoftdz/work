USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_RemovedItem]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_RemovedItem](
	[IDRemovedItem] [int] NOT NULL,
	[IDCashRegister] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[IDStore] [int] NOT NULL,
	[IDDepartment] [int] NOT NULL,
	[IDUserAuto] [int] NOT NULL,
	[IDPessoa] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[MovDate] [datetime] NOT NULL,
	[Qty] [money] NOT NULL,
	[SalePrice] [money] NOT NULL,
	[CostPrice] [money] NOT NULL,
	[Discount] [money] NOT NULL,
	[SaleCode] [varchar](20) NULL,
	[PosicaoItem] [int] NULL,
	[Acrescimo] [money] NULL,
	[TotalizadorParcial] [varchar](10) NULL,
	[IDNotasCanceladas] [int] NULL,
	[IDPreSale] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_RemovedItem] PRIMARY KEY CLUSTERED 
(
	[IDRemovedItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_RemovedItem]  WITH CHECK ADD  CONSTRAINT [FK_CashRegister_SalRemovedItem_IDCashRegister] FOREIGN KEY([IDCashRegister])
REFERENCES [dbo].[CashRegister] ([IDCashRegister])
GO
ALTER TABLE [dbo].[Sal_RemovedItem] CHECK CONSTRAINT [FK_CashRegister_SalRemovedItem_IDCashRegister]
GO
ALTER TABLE [dbo].[Sal_RemovedItem]  WITH CHECK ADD  CONSTRAINT [FK_InvDepartment_SalRemovedItem_IDDepartment] FOREIGN KEY([IDDepartment])
REFERENCES [dbo].[Inv_Department] ([IDDepartment])
GO
ALTER TABLE [dbo].[Sal_RemovedItem] CHECK CONSTRAINT [FK_InvDepartment_SalRemovedItem_IDDepartment]
GO
ALTER TABLE [dbo].[Sal_RemovedItem]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Sal_RemovedItem_IDPreSale] FOREIGN KEY([IDPreSale])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[Sal_RemovedItem] CHECK CONSTRAINT [FK_Invoice_Sal_RemovedItem_IDPreSale]
GO
ALTER TABLE [dbo].[Sal_RemovedItem]  WITH CHECK ADD  CONSTRAINT [FK_Model_SalRemovedItem_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Sal_RemovedItem] CHECK CONSTRAINT [FK_Model_SalRemovedItem_IDModel]
GO
ALTER TABLE [dbo].[Sal_RemovedItem]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_SalRemovedItem_IDCommission] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sal_RemovedItem] CHECK CONSTRAINT [FK_Pessoa_SalRemovedItem_IDCommission]
GO
ALTER TABLE [dbo].[Sal_RemovedItem]  WITH CHECK ADD  CONSTRAINT [FK_Sal_NotasCanceladas_Sal_RemovedItem_IDNotasCanceladas] FOREIGN KEY([IDNotasCanceladas])
REFERENCES [dbo].[Sal_NotasCanceladas] ([IDNotasCanceladas])
GO
ALTER TABLE [dbo].[Sal_RemovedItem] CHECK CONSTRAINT [FK_Sal_NotasCanceladas_Sal_RemovedItem_IDNotasCanceladas]
GO
ALTER TABLE [dbo].[Sal_RemovedItem]  WITH CHECK ADD  CONSTRAINT [FK_Store_SalRemovedItem_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Sal_RemovedItem] CHECK CONSTRAINT [FK_Store_SalRemovedItem_IDStore]
GO
ALTER TABLE [dbo].[Sal_RemovedItem]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_SalRemovedItem_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sal_RemovedItem] CHECK CONSTRAINT [FK_SystemUser_SalRemovedItem_IDUser]
GO
ALTER TABLE [dbo].[Sal_RemovedItem]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_SalRemovedItem_IDUserAuto] FOREIGN KEY([IDUserAuto])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sal_RemovedItem] CHECK CONSTRAINT [FK_SystemUser_SalRemovedItem_IDUserAuto]
GO
