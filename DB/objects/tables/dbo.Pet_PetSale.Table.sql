USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_PetSale]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pet_PetSale](
	[IDPetSale] [int] NOT NULL,
	[IDPreInventoryMov] [int] NOT NULL,
	[IDWarrantyReport] [int] NOT NULL,
	[IDWarrantyCustomer] [int] NOT NULL,
	[IDPet] [int] NULL,
	[InvoiceTotal] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_PetSale] PRIMARY KEY CLUSTERED 
(
	[IDPetSale] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pet_PetSale]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_IDPessoa_Pet_PetSale_IDWarrantyCustomer] FOREIGN KEY([IDWarrantyCustomer])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Pet_PetSale] CHECK CONSTRAINT [FK_Pessoa_IDPessoa_Pet_PetSale_IDWarrantyCustomer]
GO
ALTER TABLE [dbo].[Pet_PetSale]  WITH CHECK ADD  CONSTRAINT [FK_Pet_IDPet_Pet_PetSale_IDPet] FOREIGN KEY([IDPet])
REFERENCES [dbo].[Pet] ([IDPet])
GO
ALTER TABLE [dbo].[Pet_PetSale] CHECK CONSTRAINT [FK_Pet_IDPet_Pet_PetSale_IDPet]
GO
ALTER TABLE [dbo].[Pet_PetSale]  WITH CHECK ADD  CONSTRAINT [FK_Pet_WarrantReport_IDWarrantyReport_Pet_PetSale_IDWarrantyReport] FOREIGN KEY([IDWarrantyReport])
REFERENCES [dbo].[Pet_WarrantyReport] ([IDWarrantyReport])
GO
ALTER TABLE [dbo].[Pet_PetSale] CHECK CONSTRAINT [FK_Pet_WarrantReport_IDWarrantyReport_Pet_PetSale_IDWarrantyReport]
GO
