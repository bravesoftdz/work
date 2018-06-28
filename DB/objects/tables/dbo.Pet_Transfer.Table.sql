USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_Transfer]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pet_Transfer](
	[IDPetTransfer] [int] NOT NULL,
	[IDPet] [int] NOT NULL,
	[IDStoreSource] [int] NOT NULL,
	[IDStoreDest] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[TransferDate] [datetime] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_Transfer] PRIMARY KEY CLUSTERED 
(
	[IDPetTransfer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pet_Transfer]  WITH CHECK ADD  CONSTRAINT [FK_Pet_IDPet_Pet_Transfer_IDPet] FOREIGN KEY([IDPet])
REFERENCES [dbo].[Pet] ([IDPet])
GO
ALTER TABLE [dbo].[Pet_Transfer] CHECK CONSTRAINT [FK_Pet_IDPet_Pet_Transfer_IDPet]
GO
ALTER TABLE [dbo].[Pet_Transfer]  WITH CHECK ADD  CONSTRAINT [FK_Store_Pet_Transfer_IDStoreDest] FOREIGN KEY([IDStoreDest])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Pet_Transfer] CHECK CONSTRAINT [FK_Store_Pet_Transfer_IDStoreDest]
GO
ALTER TABLE [dbo].[Pet_Transfer]  WITH CHECK ADD  CONSTRAINT [FK_Store_Pet_Transfer_IDStoreSource] FOREIGN KEY([IDStoreSource])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Pet_Transfer] CHECK CONSTRAINT [FK_Store_Pet_Transfer_IDStoreSource]
GO
ALTER TABLE [dbo].[Pet_Transfer]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_IDUser_Pet_Transfer_IDSystemUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Pet_Transfer] CHECK CONSTRAINT [FK_SystemUser_IDUser_Pet_Transfer_IDSystemUser]
GO
