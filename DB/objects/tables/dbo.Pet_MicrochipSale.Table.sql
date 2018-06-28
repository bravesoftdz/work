USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_MicrochipSale]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_MicrochipSale](
	[IDPreInventoryMov] [int] NOT NULL,
	[IDMicrochip] [int] NOT NULL,
	[IDPetSale] [int] NOT NULL,
	[MicrochipNum] [varchar](20) NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_MicrochipSale] PRIMARY KEY CLUSTERED 
(
	[IDPreInventoryMov] ASC,
	[IDMicrochip] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_MicrochipSale]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Microchip_IDMicrochip_Pet_MicrochipSale_IDMicrochip] FOREIGN KEY([IDMicrochip])
REFERENCES [dbo].[Pet_Microchip] ([IDMicrochip])
GO
ALTER TABLE [dbo].[Pet_MicrochipSale] CHECK CONSTRAINT [FK_Pet_Microchip_IDMicrochip_Pet_MicrochipSale_IDMicrochip]
GO
ALTER TABLE [dbo].[Pet_MicrochipSale]  WITH CHECK ADD  CONSTRAINT [FK_Pet_PetSale_IDPetSalet_Pet_MicrochipSale_IDPetSale] FOREIGN KEY([IDPetSale])
REFERENCES [dbo].[Pet_PetSale] ([IDPetSale])
GO
ALTER TABLE [dbo].[Pet_MicrochipSale] CHECK CONSTRAINT [FK_Pet_PetSale_IDPetSalet_Pet_MicrochipSale_IDPetSale]
GO
