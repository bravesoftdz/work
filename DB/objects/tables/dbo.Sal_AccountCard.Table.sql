USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_AccountCard]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_AccountCard](
	[IDAccountCard] [int] NOT NULL,
	[CardNumber] [varchar](20) NOT NULL,
	[CardDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NULL,
	[Amount] [money] NOT NULL,
	[IDPreInventoryMov] [int] NULL,
	[IDUser] [int] NOT NULL,
	[IDCustomer] [int] NULL,
	[Canceled] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_AccountCard] PRIMARY KEY CLUSTERED 
(
	[IDAccountCard] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_AccountCard]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_SalAccountCard_IDCustomer] FOREIGN KEY([IDCustomer])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sal_AccountCard] CHECK CONSTRAINT [FK_Pessoa_SalAccountCard_IDCustomer]
GO
ALTER TABLE [dbo].[Sal_AccountCard]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_SalAccountCard_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sal_AccountCard] CHECK CONSTRAINT [FK_SystemUser_SalAccountCard_IDUser]
GO
ALTER TABLE [dbo].[Sal_AccountCard] ADD  CONSTRAINT [DF_Zero2507]  DEFAULT (0) FOR [Canceled]
GO
