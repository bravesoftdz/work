USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_StoreAccountLimetLog]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_StoreAccountLimetLog](
	[IDStoreAccountLimtLog] [int] NOT NULL,
	[IDPessoa] [int] NULL,
	[IDUser] [int] NULL,
	[LogDate] [datetime] NULL,
	[Amount] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_StoreAccountLimetLog] PRIMARY KEY CLUSTERED 
(
	[IDStoreAccountLimtLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_StoreAccountLimetLog]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_StoreAccountLimitLog_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sal_StoreAccountLimetLog] CHECK CONSTRAINT [FK_Pessoa_StoreAccountLimitLog_IDPessoa]
GO
ALTER TABLE [dbo].[Sal_StoreAccountLimetLog]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_StoreAccountLimitLog_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sal_StoreAccountLimetLog] CHECK CONSTRAINT [FK_SystemUser_StoreAccountLimitLog_IDUser]
GO
