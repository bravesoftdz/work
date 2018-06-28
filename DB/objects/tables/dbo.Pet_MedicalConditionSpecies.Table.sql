USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_MedicalConditionSpecies]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pet_MedicalConditionSpecies](
	[IDMedicalCondition] [int] NOT NULL,
	[IDSpecies] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_MedicalConditionSpecies] PRIMARY KEY CLUSTERED 
(
	[IDMedicalCondition] ASC,
	[IDSpecies] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pet_MedicalConditionSpecies]  WITH CHECK ADD  CONSTRAINT [FK_Pet_MedicalCondition_IDMedicalCondition_Pet_MedicalContidionSpecies_IDMedicalCondition] FOREIGN KEY([IDMedicalCondition])
REFERENCES [dbo].[Pet_MedicalCondition] ([IDMedicalCondition])
GO
ALTER TABLE [dbo].[Pet_MedicalConditionSpecies] CHECK CONSTRAINT [FK_Pet_MedicalCondition_IDMedicalCondition_Pet_MedicalContidionSpecies_IDMedicalCondition]
GO
ALTER TABLE [dbo].[Pet_MedicalConditionSpecies]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_MedicalContidionSpecies_IDSpecies] FOREIGN KEY([IDSpecies])
REFERENCES [dbo].[Pet_Species] ([IDSpecies])
GO
ALTER TABLE [dbo].[Pet_MedicalConditionSpecies] CHECK CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_MedicalContidionSpecies_IDSpecies]
GO
