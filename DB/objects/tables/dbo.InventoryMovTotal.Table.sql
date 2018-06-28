USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InventoryMovTotal]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryMovTotal](
	[StoreID] [int] NOT NULL,
	[ModelID] [int] NOT NULL,
	[InventMovTypeID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[TotSale] [money] NULL,
	[TotCost] [money] NULL,
	[TotQty] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC,
	[ModelID] ASC,
	[InventMovTypeID] ASC,
	[Year] ASC,
	[Month] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryMovTotal] ADD  CONSTRAINT [DF_Zero122]  DEFAULT (0) FOR [TotSale]
GO
ALTER TABLE [dbo].[InventoryMovTotal] ADD  CONSTRAINT [DF_Zero123]  DEFAULT (0) FOR [TotCost]
GO
ALTER TABLE [dbo].[InventoryMovTotal] ADD  CONSTRAINT [DF_ZERO121]  DEFAULT (0) FOR [TotQty]
GO
