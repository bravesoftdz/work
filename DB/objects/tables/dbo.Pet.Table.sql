USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet](
	[IDPet] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Sex] [varchar](1) NULL,
	[IDSpecies] [int] NULL,
	[IDPorte] [int] NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
	[IDBreed] [int] NULL,
	[IDStatus] [int] NULL,
	[IDBreeder] [int] NULL,
	[SKU] [varchar](30) NULL,
	[PenNum] [varchar](10) NULL,
	[VendorCost] [money] NULL,
	[MSRP] [money] NULL,
	[SalePrice] [money] NULL,
	[PromoPrice] [money] NULL,
	[USDA] [varchar](50) NULL,
	[Collar] [varchar](50) NULL,
	[Sire] [varchar](255) NULL,
	[Dam] [varchar](255) NULL,
	[WhelpDate] [datetime] NULL,
	[PurchaseDate] [datetime] NULL,
	[Notes] [varchar](255) NULL,
	[IDModel] [int] NULL,
	[IDColor] [int] NULL,
	[IDStore] [int] NULL,
 CONSTRAINT [XPKPet] PRIMARY KEY CLUSTERED 
(
	[IDPet] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet]  WITH CHECK ADD  CONSTRAINT [FK_Breed_IDBreed_Pet_IDBreed] FOREIGN KEY([IDBreed])
REFERENCES [dbo].[Pet_Breed] ([IDBreed])
GO
ALTER TABLE [dbo].[Pet] CHECK CONSTRAINT [FK_Breed_IDBreed_Pet_IDBreed]
GO
ALTER TABLE [dbo].[Pet]  WITH CHECK ADD  CONSTRAINT [FK_Model_IDModel_Pet_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Pet] CHECK CONSTRAINT [FK_Model_IDModel_Pet_IDModel]
GO
ALTER TABLE [dbo].[Pet]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_IDPessoa_Pet_IDBreeder] FOREIGN KEY([IDBreeder])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Pet] CHECK CONSTRAINT [FK_Pessoa_IDPessoa_Pet_IDBreeder]
GO
ALTER TABLE [dbo].[Pet]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Color_IDColor_Pet__IDColor] FOREIGN KEY([IDColor])
REFERENCES [dbo].[Pet_Color] ([IDColor])
GO
ALTER TABLE [dbo].[Pet] CHECK CONSTRAINT [FK_Pet_Color_IDColor_Pet__IDColor]
GO
ALTER TABLE [dbo].[Pet]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_Species_IDSpecies] FOREIGN KEY([IDSpecies])
REFERENCES [dbo].[Pet_Species] ([IDSpecies])
GO
ALTER TABLE [dbo].[Pet] CHECK CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_Species_IDSpecies]
GO
ALTER TABLE [dbo].[Pet]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Status_IDStatus_Pet_IDStatus] FOREIGN KEY([IDStatus])
REFERENCES [dbo].[Pet_Status] ([IDStatus])
GO
ALTER TABLE [dbo].[Pet] CHECK CONSTRAINT [FK_Pet_Status_IDStatus_Pet_IDStatus]
GO
ALTER TABLE [dbo].[Pet]  WITH CHECK ADD  CONSTRAINT [FK_Porte_IDPorte_Pet_IDPorte] FOREIGN KEY([IDPorte])
REFERENCES [dbo].[Pet_Porte] ([IDPorte])
GO
ALTER TABLE [dbo].[Pet] CHECK CONSTRAINT [FK_Porte_IDPorte_Pet_IDPorte]
GO
ALTER TABLE [dbo].[Pet]  WITH CHECK ADD  CONSTRAINT [FK_Store_Pet_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Pet] CHECK CONSTRAINT [FK_Store_Pet_IDStore]
GO
ALTER TABLE [dbo].[Pet] ADD  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Pet] ADD  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Pet] ADD  DEFAULT (0) FOR [Desativado]
GO
