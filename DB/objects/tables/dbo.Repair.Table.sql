USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Repair]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Repair](
	[IDRepair] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[IDStore] [int] NOT NULL,
	[IDInvMovSend] [int] NULL,
	[IDCliente] [int] NULL,
	[Fase] [varchar](20) NULL,
	[IDFornecedor] [int] NULL,
	[IDUserReceive] [int] NULL,
	[ReceiveDate] [datetime] NULL,
	[SentDate] [datetime] NULL,
	[OBSReceive] [varchar](255) NULL,
	[TipoRepair] [int] NULL,
	[IDUserSent] [int] NULL,
	[UPS] [varchar](20) NULL,
	[RA] [varchar](20) NULL,
	[DateLastCost] [datetime] NULL,
	[SerialNumber] [varchar](20) NULL,
	[LastCost] [money] NULL,
	[Defect] [varchar](255) NULL,
	[Desativado] [int] NULL,
	[IDUserReturn] [int] NULL,
	[ReturnDate] [datetime] NULL,
	[ReturnStatus] [varchar](20) NULL,
	[OBSReturn] [varchar](255) NULL,
	[IDUserBack] [int] NULL,
	[BackDate] [datetime] NULL,
	[IDInvMovReturn] [int] NULL,
	[Tipo] [int] NULL,
	[OBSBack] [varchar](255) NULL,
	[IDDefectType] [int] NULL,
	[Qty] [decimal](38, 4) NULL,
	[IDLote] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Repair__59C55456] PRIMARY KEY CLUSTERED 
(
	[IDRepair] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Repair]  WITH CHECK ADD  CONSTRAINT [FK_Inv_Lot_Repair_IDLot] FOREIGN KEY([IDLote])
REFERENCES [dbo].[Inv_Lot] ([IDLote])
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_Inv_Lot_Repair_IDLot]
GO
ALTER TABLE [dbo].[Repair]  WITH CHECK ADD  CONSTRAINT [FK_InvDefectType_Repair_IDDefectType] FOREIGN KEY([IDDefectType])
REFERENCES [dbo].[Inv_DefectType] ([IDDefectType])
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_InvDefectType_Repair_IDDefectType]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_InventoryMov_Repair_IDInvMovReturn] FOREIGN KEY([IDInvMovReturn])
REFERENCES [dbo].[InventoryMov] ([IDInventoryMov])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_InventoryMov_Repair_IDInvMovReturn]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_InventoryMov_Repair_IDInvMovSend] FOREIGN KEY([IDInvMovSend])
REFERENCES [dbo].[InventoryMov] ([IDInventoryMov])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_InventoryMov_Repair_IDInvMovSend]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_Repair_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_Model_Repair_IDModel]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_Repair_IDCliente] FOREIGN KEY([IDCliente])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_Pessoa_Repair_IDCliente]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_Repair_IDFornecedor] FOREIGN KEY([IDFornecedor])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_Pessoa_Repair_IDFornecedor]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_Repair_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_Store_Repair_IDStore]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Repair_IDUserBack] FOREIGN KEY([IDUserBack])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_SystemUser_Repair_IDUserBack]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Repair_IDUserReceive] FOREIGN KEY([IDUserReceive])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_SystemUser_Repair_IDUserReceive]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Repair_IDUserReturn] FOREIGN KEY([IDUserReturn])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_SystemUser_Repair_IDUserReturn]
GO
ALTER TABLE [dbo].[Repair]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Repair_IDUserSent] FOREIGN KEY([IDUserSent])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Repair] CHECK CONSTRAINT [FK_SystemUser_Repair_IDUserSent]
GO
