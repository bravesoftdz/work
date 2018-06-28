USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inventory](
	[StoreID] [int] NOT NULL,
	[ModelID] [int] NOT NULL,
	[IDInventory] [int] NOT NULL,
	[Location] [varchar](30) NULL,
	[DataContagem] [smalldatetime] NULL,
	[UltimaMovimentacao] [smalldatetime] NULL,
	[UltimaContagem] [smalldatetime] NULL,
	[AuxCalculo] [int] NULL,
	[Avaiable] [bit] NULL,
	[Hidden] [bit] NULL,
	[LastPurchase] [datetime] NULL,
	[FirstPurchase] [datetime] NULL,
	[TotalPurchase] [int] NULL,
	[SellingPrice] [money] NULL,
	[StoreCostPrice] [money] NULL,
	[StoreAvgPrice] [money] NULL,
	[AvgCostTotal] [money] NOT NULL,
	[ClassABC] [char](1) NULL,
	[DailySales] [money] NULL,
	[LeadTime] [money] NULL,
	[OrderPoint] [money] NULL,
	[SafetyMargin] [money] NULL,
	[QtyOnPreSale] [decimal](38, 4) NULL,
	[QtyOnHand] [decimal](38, 4) NULL,
	[QtyOnOrder] [decimal](38, 4) NULL,
	[QtyOnRepair] [decimal](38, 4) NULL,
	[MaxQty] [decimal](38, 4) NULL,
	[MinQty] [decimal](38, 4) NULL,
	[QtyContada] [decimal](38, 4) NULL,
	[QtyOnPrePurchase] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_Inventory_StoreID] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC,
	[ModelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_Zero65]  DEFAULT (0) FOR [Avaiable]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_Zero66]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_Inventory_AvgCostTotal_Zero]  DEFAULT (0) FOR [AvgCostTotal]
GO
ALTER TABLE [dbo].[Inventory] ADD  DEFAULT ('C') FOR [ClassABC]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_ZERO59]  DEFAULT (0) FOR [QtyOnPreSale]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_ZERO60]  DEFAULT (0) FOR [QtyOnHand]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_ZERO61]  DEFAULT (0) FOR [QtyOnOrder]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_ZERO62]  DEFAULT (0) FOR [QtyOnRepair]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_ZERO63]  DEFAULT (0) FOR [MaxQty]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_ZERO64]  DEFAULT (0) FOR [MinQty]
GO
ALTER TABLE [dbo].[Inventory] ADD  CONSTRAINT [DF_ZERO67]  DEFAULT (0) FOR [QtyOnPrePurchase]
GO
