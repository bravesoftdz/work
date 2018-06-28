USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_PetMicrochip]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_PetMicrochip](
	[IDMicrochip] [int] NOT NULL,
	[IDPet] [int] NOT NULL,
	[MicrochipNum] [varchar](20) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_PetMicrochip] PRIMARY KEY CLUSTERED 
(
	[IDMicrochip] ASC,
	[IDPet] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_PetMicrochip]  WITH CHECK ADD  CONSTRAINT [FK_Pet_IDPet_Pet_PetMicrochip_IDPet] FOREIGN KEY([IDPet])
REFERENCES [dbo].[Pet] ([IDPet])
GO
ALTER TABLE [dbo].[Pet_PetMicrochip] CHECK CONSTRAINT [FK_Pet_IDPet_Pet_PetMicrochip_IDPet]
GO
ALTER TABLE [dbo].[Pet_PetMicrochip]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Microchip_IDMicrochip_Pet_PetMicrochip_IDMicrochip] FOREIGN KEY([IDMicrochip])
REFERENCES [dbo].[Pet_Microchip] ([IDMicrochip])
GO
ALTER TABLE [dbo].[Pet_PetMicrochip] CHECK CONSTRAINT [FK_Pet_Microchip_IDMicrochip_Pet_PetMicrochip_IDMicrochip]
GO
