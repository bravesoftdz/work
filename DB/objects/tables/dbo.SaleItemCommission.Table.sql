USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[SaleItemCommission]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleItemCommission](
	[IDSaleItemCommission] [int] NOT NULL,
	[IDPreInventoryMov] [int] NULL,
	[IDInventoryMov] [int] NULL,
	[IDCommission] [int] NULL,
	[CommissionPercent] [decimal](18, 0) NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSaleItemCommission] PRIMARY KEY CLUSTERED 
(
	[IDSaleItemCommission] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SaleItemCommission]  WITH CHECK ADD  CONSTRAINT [FK_InventoryMov_SaleItemCommission_IDInventoryMov] FOREIGN KEY([IDInventoryMov])
REFERENCES [dbo].[InventoryMov] ([IDInventoryMov])
GO
ALTER TABLE [dbo].[SaleItemCommission] CHECK CONSTRAINT [FK_InventoryMov_SaleItemCommission_IDInventoryMov]
GO
ALTER TABLE [dbo].[SaleItemCommission]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_SaleItemCommission_IDCommission] FOREIGN KEY([IDCommission])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[SaleItemCommission] CHECK CONSTRAINT [FK_Pessoa_SaleItemCommission_IDCommission]
GO
ALTER TABLE [dbo].[SaleItemCommission]  WITH CHECK ADD  CONSTRAINT [FK_PreInventoryMov_SaleItemCommission_IDPreInventoryMov] FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
GO
ALTER TABLE [dbo].[SaleItemCommission] CHECK CONSTRAINT [FK_PreInventoryMov_SaleItemCommission_IDPreInventoryMov]
GO
