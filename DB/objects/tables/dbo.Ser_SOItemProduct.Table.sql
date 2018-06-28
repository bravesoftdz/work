USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Ser_SOItemProduct]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ser_SOItemProduct](
	[IDSOItemProduct] [int] NOT NULL,
	[IDUser] [int] NULL,
	[IDSOItem] [int] NULL,
	[IDModel] [int] NULL,
	[IDStore] [int] NULL,
	[Qty] [decimal](38, 4) NULL,
	[CostPrice] [money] NULL,
	[SalePrice] [money] NULL,
	[MovDate] [datetime] NULL,
	[IDCustomer] [int] NULL,
	[Discount] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSer_SOItemProduct] PRIMARY KEY CLUSTERED 
(
	[IDSOItemProduct] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ser_SOItemProduct]  WITH CHECK ADD  CONSTRAINT [FK_Model_Ser_SOItemProduct_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Ser_SOItemProduct] CHECK CONSTRAINT [FK_Model_Ser_SOItemProduct_IDModel]
GO
ALTER TABLE [dbo].[Ser_SOItemProduct]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_Ser_SOItemProduct_IDCustomer] FOREIGN KEY([IDCustomer])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Ser_SOItemProduct] CHECK CONSTRAINT [FK_Pessoa_Ser_SOItemProduct_IDCustomer]
GO
ALTER TABLE [dbo].[Ser_SOItemProduct]  WITH CHECK ADD  CONSTRAINT [FK_Ser_SOItem_Ser_SOItemProduct_IDSOItem] FOREIGN KEY([IDSOItem])
REFERENCES [dbo].[Ser_SOItem] ([IDSOItem])
GO
ALTER TABLE [dbo].[Ser_SOItemProduct] CHECK CONSTRAINT [FK_Ser_SOItem_Ser_SOItemProduct_IDSOItem]
GO
ALTER TABLE [dbo].[Ser_SOItemProduct]  WITH CHECK ADD  CONSTRAINT [FK_Store_Ser_SOItemProduct_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Ser_SOItemProduct] CHECK CONSTRAINT [FK_Store_Ser_SOItemProduct_IDStore]
GO
ALTER TABLE [dbo].[Ser_SOItemProduct]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Ser_SOItemProduct_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Ser_SOItemProduct] CHECK CONSTRAINT [FK_SystemUser_Ser_SOItemProduct_IDUser]
GO
ALTER TABLE [dbo].[Ser_SOItemProduct] ADD  CONSTRAINT [DF_ZeroSOItem]  DEFAULT (0) FOR [Discount]
GO
