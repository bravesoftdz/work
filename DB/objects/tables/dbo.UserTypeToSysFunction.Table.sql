USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[UserTypeToSysFunction]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypeToSysFunction](
	[IDUserType] [int] NOT NULL,
	[IDSysFunction] [int] NOT NULL,
	[Acesso] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDUserType] ASC,
	[IDSysFunction] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserTypeToSysFunction] ADD  CONSTRAINT [DF_Zero141]  DEFAULT (0) FOR [Acesso]
GO
