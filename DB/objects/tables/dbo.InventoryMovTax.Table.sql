USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InventoryMovTax]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryMovTax](
	[IDInventoryMov] [int] NOT NULL,
	[IDTaxCategory] [int] NOT NULL,
	[Tax] [money] NOT NULL,
	[TaxValue] [dbo].[TValor] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInventoryMovTax] PRIMARY KEY CLUSTERED 
(
	[IDInventoryMov] ASC,
	[IDTaxCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InventoryMovTax]  WITH CHECK ADD  CONSTRAINT [FK_InventoryMov_InventoryMovTax_IDInventoryMov] FOREIGN KEY([IDInventoryMov])
REFERENCES [dbo].[InventoryMov] ([IDInventoryMov])
GO
ALTER TABLE [dbo].[InventoryMovTax] CHECK CONSTRAINT [FK_InventoryMov_InventoryMovTax_IDInventoryMov]
GO
ALTER TABLE [dbo].[InventoryMovTax]  WITH CHECK ADD  CONSTRAINT [FK_TaxCategory_InventoryMovTax_IDTaxCategory] FOREIGN KEY([IDTaxCategory])
REFERENCES [dbo].[TaxCategory] ([IDTaxCategory])
GO
ALTER TABLE [dbo].[InventoryMovTax] CHECK CONSTRAINT [FK_TaxCategory_InventoryMovTax_IDTaxCategory]
GO
