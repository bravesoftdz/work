USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_RegistrySpecies]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pet_RegistrySpecies](
	[IDRegistry] [int] NOT NULL,
	[IDSpecies] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_RegistrySpecies] PRIMARY KEY CLUSTERED 
(
	[IDRegistry] ASC,
	[IDSpecies] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pet_RegistrySpecies]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Registry_IDRegistry_Pet_RegistrySpecies_IDRegistry] FOREIGN KEY([IDRegistry])
REFERENCES [dbo].[Pet_Registry] ([IDRegistry])
GO
ALTER TABLE [dbo].[Pet_RegistrySpecies] CHECK CONSTRAINT [FK_Pet_Registry_IDRegistry_Pet_RegistrySpecies_IDRegistry]
GO
ALTER TABLE [dbo].[Pet_RegistrySpecies]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_RegistrySpecies_IDSpecies] FOREIGN KEY([IDSpecies])
REFERENCES [dbo].[Pet_Species] ([IDSpecies])
GO
ALTER TABLE [dbo].[Pet_RegistrySpecies] CHECK CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_RegistrySpecies_IDSpecies]
GO
