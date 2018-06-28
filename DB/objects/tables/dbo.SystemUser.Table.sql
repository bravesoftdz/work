USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[SystemUser]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemUser](
	[IDUser] [int] NOT NULL,
	[UserTypeID] [int] NOT NULL,
	[ComissionID] [int] NULL,
	[SystemUser] [varchar](50) NOT NULL,
	[PW] [varchar](10) NOT NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[CodSystemUser] [varchar](20) NULL,
	[StoresAccess] [varchar](255) NULL,
	[ContadorClasse] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSystemUser] PRIMARY KEY CLUSTERED 
(
	[IDUser] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[SystemUser]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_SystemUser_ComissionID] FOREIGN KEY([ComissionID])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[SystemUser] CHECK CONSTRAINT [FK_Pessoa_SystemUser_ComissionID]
GO
ALTER TABLE [dbo].[SystemUser]  WITH NOCHECK ADD  CONSTRAINT [FK_UserType_SystemUser_UserTypeID] FOREIGN KEY([UserTypeID])
REFERENCES [dbo].[UserType] ([IDUserType])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[SystemUser] CHECK CONSTRAINT [FK_UserType_SystemUser_UserTypeID]
GO
ALTER TABLE [dbo].[SystemUser] ADD  CONSTRAINT [DF_Zero15]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[SystemUser] ADD  CONSTRAINT [DF_Zero16]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[SystemUser] ADD  CONSTRAINT [DF_Zero17]  DEFAULT (0) FOR [Hidden]
GO
