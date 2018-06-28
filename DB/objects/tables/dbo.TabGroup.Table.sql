USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[TabGroup]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TabGroup](
	[IDGroup] [int] NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Taxable] [bit] NULL,
	[PrcPartDiscount] [money] NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[Path] [varchar](150) NULL,
	[PathName] [varchar](255) NULL,
	[SerialNumber] [bit] NULL,
	[SizeAndColor] [bit] NULL,
	[PackModel] [dbo].[Boolean] NULL,
	[Service] [bit] NULL,
	[Credit] [bit] NULL,
	[DesiredMarkup] [money] NULL,
	[UserCode] [varchar](5) NULL,
	[ServiceAutoNumber] [bit] NULL,
	[PuppyTracker] [bit] NULL,
	[RequestCustomer] [bit] NULL,
	[IDRoundingTable] [int] NULL,
	[IDSalePriceMargemTable] [int] NULL,
	[SalePriceMargemPercent] [float] NULL,
	[UseSalePricePercent] [bit] NOT NULL,
	[IDMSRPMargemTable] [int] NULL,
	[MSRPMargemPercent] [float] NULL,
	[UseMSRPPercent] [bit] NOT NULL,
	[GiftCard] [bit] NULL,
	[IDDepartment] [int] NOT NULL,
	[ReceiptText] [varchar](255) NULL,
	[PackModelAddItems] [bit] NULL,
	[UsePriceTable] [bit] NOT NULL,
	[UseDocumentOnSale] [dbo].[Boolean] NOT NULL,
	[TabGroupCode] [varchar](20) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__TabGroup__20C1E124] PRIMARY KEY CLUSTERED 
(
	[IDGroup] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TabGroup]  WITH CHECK ADD  CONSTRAINT [FK_InvDepartment_TabGroup_IDDepartment] FOREIGN KEY([IDDepartment])
REFERENCES [dbo].[Inv_Department] ([IDDepartment])
GO
ALTER TABLE [dbo].[TabGroup] CHECK CONSTRAINT [FK_InvDepartment_TabGroup_IDDepartment]
GO
ALTER TABLE [dbo].[TabGroup]  WITH CHECK ADD  CONSTRAINT [FK_MagemTable_TabGroup_IDMSRPMargemTable] FOREIGN KEY([IDMSRPMargemTable])
REFERENCES [dbo].[MargemTable] ([IDMargemTable])
GO
ALTER TABLE [dbo].[TabGroup] CHECK CONSTRAINT [FK_MagemTable_TabGroup_IDMSRPMargemTable]
GO
ALTER TABLE [dbo].[TabGroup]  WITH CHECK ADD  CONSTRAINT [FK_MagemTable_TabGroup_IDSalePriceMargemTable] FOREIGN KEY([IDSalePriceMargemTable])
REFERENCES [dbo].[MargemTable] ([IDMargemTable])
GO
ALTER TABLE [dbo].[TabGroup] CHECK CONSTRAINT [FK_MagemTable_TabGroup_IDSalePriceMargemTable]
GO
ALTER TABLE [dbo].[TabGroup]  WITH CHECK ADD  CONSTRAINT [FK_RoundingTable_TabGroup_IDRoundingTable] FOREIGN KEY([IDRoundingTable])
REFERENCES [dbo].[RoundingTable] ([IDRoundingTable])
GO
ALTER TABLE [dbo].[TabGroup] CHECK CONSTRAINT [FK_RoundingTable_TabGroup_IDRoundingTable]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_MenuItem_Enabled]  DEFAULT (1) FOR [Taxable]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF__TabGroup__PrcPar]  DEFAULT (100) FOR [PrcPartDiscount]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero7]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero8]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero9]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero10]  DEFAULT (0) FOR [SerialNumber]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero11]  DEFAULT (0) FOR [SizeAndColor]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_PackModel_Enabled]  DEFAULT (0) FOR [PackModel]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [TabGroup_Service_Zero863]  DEFAULT (0) FOR [Service]
GO
ALTER TABLE [dbo].[TabGroup] ADD  DEFAULT (0) FOR [Credit]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero1241]  DEFAULT (0) FOR [ServiceAutoNumber]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero1353]  DEFAULT (0) FOR [PuppyTracker]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero1354]  DEFAULT (0) FOR [RequestCustomer]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero1405]  DEFAULT (0) FOR [UseSalePricePercent]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero1406]  DEFAULT (0) FOR [UseMSRPPercent]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_Zero2496]  DEFAULT (0) FOR [GiftCard]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_TabGroup_IDDepartment_Zero]  DEFAULT (0) FOR [IDDepartment]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_TabGroup_PackModelAddItems_Zero]  DEFAULT (0) FOR [PackModelAddItems]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_TabGroup_UsePriceTable_False]  DEFAULT (0) FOR [UsePriceTable]
GO
ALTER TABLE [dbo].[TabGroup] ADD  CONSTRAINT [DF_TabGroup_UseDocumentOnSale_Zero]  DEFAULT (0) FOR [UseDocumentOnSale]
GO
