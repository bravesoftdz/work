USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_PetTreatment]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_PetTreatment](
	[IDPetTreatment] [int] NOT NULL,
	[IDTreatment] [int] NOT NULL,
	[IDTreatmentLot] [int] NULL,
	[IDPet] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[ExpirationDate] [datetime] NULL,
	[DosesUsed] [int] NULL,
	[TreatmentDate] [datetime] NULL,
	[Notes] [varchar](255) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_PetTreatment] PRIMARY KEY CLUSTERED 
(
	[IDPetTreatment] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_PetTreatment]  WITH CHECK ADD  CONSTRAINT [FK_Pet_IDPet_Pet_PetTreatment_IDPet] FOREIGN KEY([IDPet])
REFERENCES [dbo].[Pet] ([IDPet])
GO
ALTER TABLE [dbo].[Pet_PetTreatment] CHECK CONSTRAINT [FK_Pet_IDPet_Pet_PetTreatment_IDPet]
GO
ALTER TABLE [dbo].[Pet_PetTreatment]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Treatment_IDTreatment_Pet_PetTreatment_IDTreatment] FOREIGN KEY([IDTreatment])
REFERENCES [dbo].[Pet_Treatment] ([IDTreatment])
GO
ALTER TABLE [dbo].[Pet_PetTreatment] CHECK CONSTRAINT [FK_Pet_Treatment_IDTreatment_Pet_PetTreatment_IDTreatment]
GO
ALTER TABLE [dbo].[Pet_PetTreatment]  WITH CHECK ADD  CONSTRAINT [FK_Pet_TreatmentLot_IDTreatmentLot_Pet_Treatment_IDTreatmentLot] FOREIGN KEY([IDTreatmentLot])
REFERENCES [dbo].[Pet_TreatmentLot] ([IDTreatmentLot])
GO
ALTER TABLE [dbo].[Pet_PetTreatment] CHECK CONSTRAINT [FK_Pet_TreatmentLot_IDTreatmentLot_Pet_Treatment_IDTreatmentLot]
GO
ALTER TABLE [dbo].[Pet_PetTreatment]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_IDUser_Pet_PetTreatment_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Pet_PetTreatment] CHECK CONSTRAINT [FK_SystemUser_IDUser_Pet_PetTreatment_IDUser]
GO
