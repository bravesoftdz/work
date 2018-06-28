USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_RegistrySale]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_RegistrySale](
	[IDPreInventoryMov] [int] NOT NULL,
	[IDRegistry] [int] NOT NULL,
	[IDPetSale] [int] NOT NULL,
	[RegistrationNum] [varchar](50) NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_RegistrySale] PRIMARY KEY CLUSTERED 
(
	[IDPreInventoryMov] ASC,
	[IDRegistry] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_RegistrySale]  WITH CHECK ADD  CONSTRAINT [FK_Pet_PetSale_IDPetSale_Pet_RegistrySale_IDPetSale] FOREIGN KEY([IDPetSale])
REFERENCES [dbo].[Pet_PetSale] ([IDPetSale])
GO
ALTER TABLE [dbo].[Pet_RegistrySale] CHECK CONSTRAINT [FK_Pet_PetSale_IDPetSale_Pet_RegistrySale_IDPetSale]
GO
ALTER TABLE [dbo].[Pet_RegistrySale]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Registry_IDRegistry_Pet_RegistrySale_IDRegistry] FOREIGN KEY([IDRegistry])
REFERENCES [dbo].[Pet_Registry] ([IDRegistry])
GO
ALTER TABLE [dbo].[Pet_RegistrySale] CHECK CONSTRAINT [FK_Pet_Registry_IDRegistry_Pet_RegistrySale_IDRegistry]
GO
