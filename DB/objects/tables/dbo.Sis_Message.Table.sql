USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_Message]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_Message](
	[IDMessage] [int] NOT NULL,
	[CreationDate] [datetime] NULL,
	[Subject] [varchar](100) NULL,
	[Body] [varchar](225) NULL,
	[IDUserSender] [int] NULL,
	[Desativado] [bit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSis_Message] PRIMARY KEY CLUSTERED 
(
	[IDMessage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_Message]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_SisMessage_IDUser] FOREIGN KEY([IDUserSender])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sis_Message] CHECK CONSTRAINT [FK_SystemUser_SisMessage_IDUser]
GO
ALTER TABLE [dbo].[Sis_Message] ADD  DEFAULT (0) FOR [Desativado]
GO
