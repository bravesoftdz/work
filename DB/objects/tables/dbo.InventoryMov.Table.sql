USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InventoryMov]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventoryMov](
	[IDInventoryMov] [int] NOT NULL,
	[IDRepair] [int] NULL,
	[StoreID] [int] NOT NULL,
	[ModelID] [int] NOT NULL,
	[InventMovTypeID] [int] NOT NULL,
	[IDPessoa] [int] NULL,
	[IDAgrupaPag] [int] NULL,
	[IDTemp] [int] NULL,
	[IDLancPagCom] [int] NULL,
	[DocumentID] [int] NOT NULL,
	[IDUser] [int] NULL,
	[BarCodeID] [dbo].[TBarCode] NULL,
	[PreInventoryMovID] [int] NULL,
	[MovDate] [smalldatetime] NOT NULL,
	[CostPrice] [money] NULL,
	[SalePrice] [money] NULL,
	[Discount] [money] NULL,
	[Freight] [money] NULL,
	[OtherCost] [money] NULL,
	[ExchangeInvoice] [int] NULL,
	[SalesTax] [money] NULL,
	[IDParentPack] [int] NULL,
	[IDModelService] [int] NULL,
	[IDPreInvMovExchange] [int] NULL,
	[AvgCost] [money] NULL,
	[DesiredMarkup] [money] NULL,
	[SequencyNum] [int] NULL,
	[Promo] [bit] NULL,
	[IDDepartment] [int] NOT NULL,
	[QTY] [decimal](38, 4) NULL,
	[QtyExchanged] [decimal](38, 4) NULL,
	[UnitDiscount] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_InventoryMov_IDInventoryMov] PRIMARY KEY NONCLUSTERED 
(
	[IDInventoryMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[InventoryMov]  WITH CHECK ADD  CONSTRAINT [FK_InvDepartment_InventoryMov_IDDepartment] FOREIGN KEY([IDDepartment])
REFERENCES [dbo].[Inv_Department] ([IDDepartment])
GO
ALTER TABLE [dbo].[InventoryMov] CHECK CONSTRAINT [FK_InvDepartment_InventoryMov_IDDepartment]
GO
ALTER TABLE [dbo].[InventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_InventoryMovType_IventoryMov_InventMovTypeID] FOREIGN KEY([InventMovTypeID])
REFERENCES [dbo].[InventoryMovType] ([IDInventMovType])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[InventoryMov] CHECK CONSTRAINT [FK_InventoryMovType_IventoryMov_InventMovTypeID]
GO
ALTER TABLE [dbo].[InventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_InventoryMov_ModelID] FOREIGN KEY([ModelID])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[InventoryMov] CHECK CONSTRAINT [FK_Model_InventoryMov_ModelID]
GO
ALTER TABLE [dbo].[InventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_IventoryMov_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[InventoryMov] CHECK CONSTRAINT [FK_Pessoa_IventoryMov_IDPessoa]
GO
ALTER TABLE [dbo].[InventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_Repair_InventoryMov_IDRepair] FOREIGN KEY([IDRepair])
REFERENCES [dbo].[Repair] ([IDRepair])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[InventoryMov] CHECK CONSTRAINT [FK_Repair_InventoryMov_IDRepair]
GO
ALTER TABLE [dbo].[InventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_InventoryMov_StoreID] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[InventoryMov] CHECK CONSTRAINT [FK_Store_InventoryMov_StoreID]
GO
ALTER TABLE [dbo].[InventoryMov]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_InventoryMov_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[InventoryMov] CHECK CONSTRAINT [FK_SystemUser_InventoryMov_IDUser]
GO
ALTER TABLE [dbo].[InventoryMov] ADD  CONSTRAINT [DF_Zero115]  DEFAULT (0) FOR [CostPrice]
GO
ALTER TABLE [dbo].[InventoryMov] ADD  CONSTRAINT [DF_Zero116]  DEFAULT (0) FOR [SalePrice]
GO
ALTER TABLE [dbo].[InventoryMov] ADD  CONSTRAINT [DF_Zero117]  DEFAULT (0) FOR [Discount]
GO
ALTER TABLE [dbo].[InventoryMov] ADD  CONSTRAINT [DF_Zero118]  DEFAULT (0) FOR [Freight]
GO
ALTER TABLE [dbo].[InventoryMov] ADD  CONSTRAINT [DF_Zero119]  DEFAULT (0) FOR [OtherCost]
GO
ALTER TABLE [dbo].[InventoryMov] ADD  CONSTRAINT [DF_Zero2519]  DEFAULT (0) FOR [Promo]
GO
ALTER TABLE [dbo].[InventoryMov] ADD  CONSTRAINT [DF_InventoryMov_IDDepartment_Zero]  DEFAULT (0) FOR [IDDepartment]
GO
