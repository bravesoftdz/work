USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_AppHistory]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_AppHistory](
	[IDHistory] [int] NOT NULL,
	[IDUsuario] [int] NULL,
	[ErrorLevel] [int] NULL,
	[FormSource] [varchar](255) NULL,
	[ErrorMessage] [text] NULL,
	[HistoryDate] [datetime] NULL,
	[Software] [varchar](20) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Sis_AppHistory__32616E72] PRIMARY KEY CLUSTERED 
(
	[IDHistory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_AppHistory]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Sis_AppHistory_IDUsuario] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sis_AppHistory] CHECK CONSTRAINT [FK_SystemUser_Sis_AppHistory_IDUsuario]
GO
