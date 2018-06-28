USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ModelTransfDet]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ModelTransfDet](
	[IDModelTransfDet] [int] NOT NULL,
	[IDModelTransf] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[CostPrice] [money] NULL,
	[Tax] [money] NULL,
	[AvgCost] [money] NOT NULL,
	[Qty] [decimal](38, 4) NULL,
	[SellingPrice] [money] NULL,
	[IDLote] [int] NULL,
	[TaxCode] [varchar](10) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__ModelTransfDet__15A53433] PRIMARY KEY CLUSTERED 
(
	[IDModelTransfDet] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ModelTransfDet]  WITH CHECK ADD  CONSTRAINT [FK_Inv_Model_ModelTransfDet_IDLot] FOREIGN KEY([IDLote])
REFERENCES [dbo].[Inv_Lot] ([IDLote])
GO
ALTER TABLE [dbo].[ModelTransfDet] CHECK CONSTRAINT [FK_Inv_Model_ModelTransfDet_IDLot]
GO
ALTER TABLE [dbo].[ModelTransfDet]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_ModelTransfDet_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ModelTransfDet] CHECK CONSTRAINT [FK_Model_ModelTransfDet_IDModel]
GO
ALTER TABLE [dbo].[ModelTransfDet]  WITH NOCHECK ADD  CONSTRAINT [FK_ModelTransf_ModelTransfDet_IDModelTransf] FOREIGN KEY([IDModelTransf])
REFERENCES [dbo].[ModelTransf] ([IDModelTransf])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ModelTransfDet] CHECK CONSTRAINT [FK_ModelTransf_ModelTransfDet_IDModelTransf]
GO
ALTER TABLE [dbo].[ModelTransfDet] ADD  CONSTRAINT [DF_Zero182]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[ModelTransfDet] ADD  CONSTRAINT [DF_Zero183]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[ModelTransfDet] ADD  CONSTRAINT [DF_Zero184]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[ModelTransfDet] ADD  DEFAULT (0) FOR [AvgCost]
GO
ALTER TABLE [dbo].[ModelTransfDet] ADD  CONSTRAINT [DF_ZERO181]  DEFAULT (0) FOR [Qty]
GO
ALTER TABLE [dbo].[ModelTransfDet] ADD  DEFAULT (0) FOR [SellingPrice]
GO
