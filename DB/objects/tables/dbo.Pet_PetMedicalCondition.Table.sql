USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_PetMedicalCondition]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_PetMedicalCondition](
	[IDPetMedicalCondition] [int] NOT NULL,
	[IDMedicalCondition] [int] NULL,
	[IDPet] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[RecordDate] [datetime] NULL,
	[Notes] [varchar](100) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_PetMedicalCondition] PRIMARY KEY CLUSTERED 
(
	[IDPetMedicalCondition] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_PetMedicalCondition]  WITH CHECK ADD  CONSTRAINT [FK_Pet_IDPet_Pet_PetMedicalCondition_IDPet] FOREIGN KEY([IDPet])
REFERENCES [dbo].[Pet] ([IDPet])
GO
ALTER TABLE [dbo].[Pet_PetMedicalCondition] CHECK CONSTRAINT [FK_Pet_IDPet_Pet_PetMedicalCondition_IDPet]
GO
ALTER TABLE [dbo].[Pet_PetMedicalCondition]  WITH CHECK ADD  CONSTRAINT [FK_Pet_MedicalCondition_IDMedicalCondition_Pet_PetMedicalCondition_IDMedicalCondition] FOREIGN KEY([IDMedicalCondition])
REFERENCES [dbo].[Pet_MedicalCondition] ([IDMedicalCondition])
GO
ALTER TABLE [dbo].[Pet_PetMedicalCondition] CHECK CONSTRAINT [FK_Pet_MedicalCondition_IDMedicalCondition_Pet_PetMedicalCondition_IDMedicalCondition]
GO
ALTER TABLE [dbo].[Pet_PetMedicalCondition]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_IDUser_Pet_PetMedicalCondition_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Pet_PetMedicalCondition] CHECK CONSTRAINT [FK_SystemUser_IDUser_Pet_PetMedicalCondition_IDUser]
GO
