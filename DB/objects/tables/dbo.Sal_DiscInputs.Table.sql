USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_DiscInputs]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_DiscInputs](
	[IDPreInventoryMov] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ModelID] [int] NOT NULL,
	[IDPessoa] [int] NOT NULL,
	[DocumentID] [int] NOT NULL,
	[SalePrice] [money] NOT NULL,
	[Qty] [decimal](38, 4) NOT NULL,
	[ManualDiscount] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPreInventoryMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_DiscInputs]  WITH CHECK ADD FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sal_DiscInputs]  WITH CHECK ADD FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
GO
ALTER TABLE [dbo].[Sal_DiscInputs]  WITH CHECK ADD FOREIGN KEY([ModelID])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Sal_DiscInputs]  WITH CHECK ADD FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([IDStore])
GO
