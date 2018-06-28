USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pur_Purchase]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pur_Purchase](
	[IDPurchase] [int] NOT NULL,
	[PurchaseStatus] [varchar](20) NULL,
	[IDFornecedor] [int] NULL,
	[IDStore] [int] NULL,
	[IDUserPreReceiving] [int] NULL,
	[DatePreReceiving] [datetime] NULL,
	[IDUserFinalReceiving] [int] NULL,
	[DateFinalReceiving] [datetime] NULL,
	[SubTotal] [money] NULL,
	[Freight] [money] NULL,
	[OtherCharges] [money] NULL,
	[DocumentType] [varchar](20) NULL,
	[DocumentNumber] [varchar](20) NULL,
	[DocumentDate] [datetime] NULL,
	[DocumentDueDate] [datetime] NULL,
	[DocumentTotal] [money] NULL,
	[PayDays] [int] NULL,
	[IDPO] [int] NULL,
	[DocumentNumberRet] [varchar](20) NULL,
	[OtherChargesRet] [money] NULL,
	[FreightRet] [money] NULL,
	[DocumentDueDateRet] [datetime] NULL,
	[CFOP] [int] NULL,
	[IDCFOP] [int] NULL,
	[Discount] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Pur_Purchase__4D5F7D71] PRIMARY KEY CLUSTERED 
(
	[IDPurchase] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pur_Purchase]  WITH CHECK ADD  CONSTRAINT [FK_MntCFOP_PurPurchase_IDCFOP] FOREIGN KEY([IDCFOP])
REFERENCES [dbo].[Mnt_CFOP] ([IDCFOP])
GO
ALTER TABLE [dbo].[Pur_Purchase] CHECK CONSTRAINT [FK_MntCFOP_PurPurchase_IDCFOP]
GO
ALTER TABLE [dbo].[Pur_Purchase]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_Purchase_IDFornecedor] FOREIGN KEY([IDFornecedor])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_Purchase] CHECK CONSTRAINT [FK_Pessoa_Purchase_IDFornecedor]
GO
ALTER TABLE [dbo].[Pur_Purchase]  WITH CHECK ADD  CONSTRAINT [FK_PO_PurPurchase_IDPO] FOREIGN KEY([IDPO])
REFERENCES [dbo].[PO] ([IDPO])
GO
ALTER TABLE [dbo].[Pur_Purchase] CHECK CONSTRAINT [FK_PO_PurPurchase_IDPO]
GO
ALTER TABLE [dbo].[Pur_Purchase]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_Purchase_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_Purchase] CHECK CONSTRAINT [FK_Store_Purchase_IDStore]
GO
ALTER TABLE [dbo].[Pur_Purchase]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Purchase_IDUserFinalReceiving] FOREIGN KEY([IDUserFinalReceiving])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_Purchase] CHECK CONSTRAINT [FK_SystemUser_Purchase_IDUserFinalReceiving]
GO
ALTER TABLE [dbo].[Pur_Purchase]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Purchase_IDUserPreReceiving] FOREIGN KEY([IDUserPreReceiving])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_Purchase] CHECK CONSTRAINT [FK_SystemUser_Purchase_IDUserPreReceiving]
GO
