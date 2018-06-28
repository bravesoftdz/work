USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_AccountCardMov]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_AccountCardMov](
	[IDAccountCardMov] [int] NOT NULL,
	[DateMov] [datetime] NOT NULL,
	[Value] [money] NOT NULL,
	[Credit] [bit] NOT NULL,
	[IDPreSale] [int] NULL,
	[IDLancamento] [int] NULL,
	[IDUser] [int] NOT NULL,
	[IDAccountCard] [int] NOT NULL,
	[Obs] [varchar](100) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_AccountCardMov] PRIMARY KEY CLUSTERED 
(
	[IDAccountCardMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_AccountCardMov]  WITH CHECK ADD  CONSTRAINT [FK_FinLancamento_SalAccountCardMov_IDLancamento] FOREIGN KEY([IDLancamento])
REFERENCES [dbo].[Fin_Lancamento] ([IDLancamento])
GO
ALTER TABLE [dbo].[Sal_AccountCardMov] CHECK CONSTRAINT [FK_FinLancamento_SalAccountCardMov_IDLancamento]
GO
ALTER TABLE [dbo].[Sal_AccountCardMov]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_SalAccountCardMov_IDPreSale] FOREIGN KEY([IDPreSale])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[Sal_AccountCardMov] CHECK CONSTRAINT [FK_Invoice_SalAccountCardMov_IDPreSale]
GO
ALTER TABLE [dbo].[Sal_AccountCardMov]  WITH CHECK ADD  CONSTRAINT [FK_SalAccountCard_SalAccountCardMov_IDAccountCard] FOREIGN KEY([IDAccountCard])
REFERENCES [dbo].[Sal_AccountCard] ([IDAccountCard])
GO
ALTER TABLE [dbo].[Sal_AccountCardMov] CHECK CONSTRAINT [FK_SalAccountCard_SalAccountCardMov_IDAccountCard]
GO
ALTER TABLE [dbo].[Sal_AccountCardMov]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_SalAccountCardMov_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sal_AccountCardMov] CHECK CONSTRAINT [FK_SystemUser_SalAccountCardMov_IDUser]
GO
ALTER TABLE [dbo].[Sal_AccountCardMov] ADD  CONSTRAINT [DF_Zero2508]  DEFAULT (0) FOR [Credit]
GO
