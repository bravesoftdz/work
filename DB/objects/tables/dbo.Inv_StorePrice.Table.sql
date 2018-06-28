USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_StorePrice]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_StorePrice](
	[IDStore] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[IDDescriptionPrice] [int] NOT NULL,
	[IDVendor] [int] NULL,
	[CostPrice] [money] NOT NULL,
	[SuggPrice] [money] NOT NULL,
	[SalePrice] [money] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_StorePrice] PRIMARY KEY CLUSTERED 
(
	[IDStore] ASC,
	[IDModel] ASC,
	[IDDescriptionPrice] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_StorePrice]  WITH CHECK ADD  CONSTRAINT [FK_InvDescriptionPrice_InvStorePrice_IDDescriptionPrice] FOREIGN KEY([IDDescriptionPrice])
REFERENCES [dbo].[Inv_DescriptionPrice] ([IDDescriptionPrice])
GO
ALTER TABLE [dbo].[Inv_StorePrice] CHECK CONSTRAINT [FK_InvDescriptionPrice_InvStorePrice_IDDescriptionPrice]
GO
ALTER TABLE [dbo].[Inv_StorePrice]  WITH CHECK ADD  CONSTRAINT [FK_Model_InvStorePrice_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Inv_StorePrice] CHECK CONSTRAINT [FK_Model_InvStorePrice_IDModel]
GO
ALTER TABLE [dbo].[Inv_StorePrice]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_InvStorePrice_IDVendor] FOREIGN KEY([IDVendor])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Inv_StorePrice] CHECK CONSTRAINT [FK_Pessoa_InvStorePrice_IDVendor]
GO
ALTER TABLE [dbo].[Inv_StorePrice]  WITH CHECK ADD  CONSTRAINT [FK_Store_InvStorePrice_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Inv_StorePrice] CHECK CONSTRAINT [FK_Store_InvStorePrice_IDStore]
GO
ALTER TABLE [dbo].[Inv_StorePrice] ADD  CONSTRAINT [DF_InvStorePrice_CostPrice_Zero]  DEFAULT (0) FOR [CostPrice]
GO
ALTER TABLE [dbo].[Inv_StorePrice] ADD  CONSTRAINT [DF_InvStorePrice_SuggPrice_Zero]  DEFAULT (0) FOR [SuggPrice]
GO
ALTER TABLE [dbo].[Inv_StorePrice] ADD  CONSTRAINT [DF_InvStorePrice_SalePrice_Zero]  DEFAULT (0) FOR [SalePrice]
GO
