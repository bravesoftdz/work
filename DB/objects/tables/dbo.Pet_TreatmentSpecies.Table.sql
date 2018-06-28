USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_TreatmentSpecies]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pet_TreatmentSpecies](
	[IDSpecies] [int] NOT NULL,
	[IDTreatment] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_TreatmentSpecies] PRIMARY KEY CLUSTERED 
(
	[IDSpecies] ASC,
	[IDTreatment] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pet_TreatmentSpecies]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_TreatmentSpecies_IDSpecies] FOREIGN KEY([IDSpecies])
REFERENCES [dbo].[Pet_Species] ([IDSpecies])
GO
ALTER TABLE [dbo].[Pet_TreatmentSpecies] CHECK CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_TreatmentSpecies_IDSpecies]
GO
ALTER TABLE [dbo].[Pet_TreatmentSpecies]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Treatment_IDTreatment_Pet_TreatmentSpecies_IDTreatment] FOREIGN KEY([IDTreatment])
REFERENCES [dbo].[Pet_Treatment] ([IDTreatment])
GO
ALTER TABLE [dbo].[Pet_TreatmentSpecies] CHECK CONSTRAINT [FK_Pet_Treatment_IDTreatment_Pet_TreatmentSpecies_IDTreatment]
GO
