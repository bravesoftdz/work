USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InventoryMovType]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventoryMovType](
	[IDInventMovType] [int] NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Entrando] [bit] NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[UpdateOnHand] [bit] NULL,
	[UpdateOnRepair] [bit] NULL,
	[UpdateOnOrder] [bit] NULL,
	[UpdateOnPreSale] [bit] NULL,
	[UpdateOnPrePurchase] [bit] NULL,
	[UpdatePreOnHand] [bit] NULL,
	[UpdatePreOnRepair] [bit] NULL,
	[UpdatePreOnOrder] [bit] NULL,
	[UpdatePreOnPreSale] [bit] NULL,
	[UpdatePreOnPrePurchase] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_IMT_IDInventMovType] PRIMARY KEY CLUSTERED 
(
	[IDInventMovType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[InventoryMovType] ADD  CONSTRAINT [DF_Zero112]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[InventoryMovType] ADD  CONSTRAINT [DF_Zero113]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[InventoryMovType] ADD  CONSTRAINT [DF_Zero114]  DEFAULT (0) FOR [Hidden]
GO
