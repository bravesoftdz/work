USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_Weight]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pet_Weight](
	[IDWeight] [int] NOT NULL,
	[IDPet] [int] NOT NULL,
	[EntryDate] [datetime] NULL,
	[Weight] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_Weight] PRIMARY KEY CLUSTERED 
(
	[IDWeight] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pet_Weight]  WITH CHECK ADD  CONSTRAINT [FK_Pet_IDPet_Pet_Weight_IDPet] FOREIGN KEY([IDPet])
REFERENCES [dbo].[Pet] ([IDPet])
GO
ALTER TABLE [dbo].[Pet_Weight] CHECK CONSTRAINT [FK_Pet_IDPet_Pet_Weight_IDPet]
GO
