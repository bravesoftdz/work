USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_MessageUser]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sis_MessageUser](
	[IDMessage] [int] NOT NULL,
	[IDUserReceiver] [int] NOT NULL,
	[ReadDate] [datetime] NULL,
	[Desativado] [bit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSis_MessageUser] PRIMARY KEY CLUSTERED 
(
	[IDMessage] ASC,
	[IDUserReceiver] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sis_MessageUser]  WITH CHECK ADD  CONSTRAINT [FK_SisMessage_SisMessageUser_IDMessage] FOREIGN KEY([IDMessage])
REFERENCES [dbo].[Sis_Message] ([IDMessage])
GO
ALTER TABLE [dbo].[Sis_MessageUser] CHECK CONSTRAINT [FK_SisMessage_SisMessageUser_IDMessage]
GO
ALTER TABLE [dbo].[Sis_MessageUser]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_SisMessageUser_IDUser] FOREIGN KEY([IDUserReceiver])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sis_MessageUser] CHECK CONSTRAINT [FK_SystemUser_SisMessageUser_IDUser]
GO
ALTER TABLE [dbo].[Sis_MessageUser] ADD  DEFAULT (0) FOR [Desativado]
GO
