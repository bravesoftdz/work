USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_PetRegistry]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_PetRegistry](
	[IDRegistry] [int] NOT NULL,
	[IDPet] [int] NOT NULL,
	[RegistrationNum] [varchar](50) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_PetRegistry] PRIMARY KEY CLUSTERED 
(
	[IDRegistry] ASC,
	[IDPet] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_PetRegistry]  WITH CHECK ADD  CONSTRAINT [FK_Pet_IDPet_Pet_PetRegistry_IDPet] FOREIGN KEY([IDPet])
REFERENCES [dbo].[Pet] ([IDPet])
GO
ALTER TABLE [dbo].[Pet_PetRegistry] CHECK CONSTRAINT [FK_Pet_IDPet_Pet_PetRegistry_IDPet]
GO
ALTER TABLE [dbo].[Pet_PetRegistry]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Registry_IDRegistry_Pet_PetRegistry_IDRegistry] FOREIGN KEY([IDRegistry])
REFERENCES [dbo].[Pet_Registry] ([IDRegistry])
GO
ALTER TABLE [dbo].[Pet_PetRegistry] CHECK CONSTRAINT [FK_Pet_Registry_IDRegistry_Pet_PetRegistry_IDRegistry]
GO
