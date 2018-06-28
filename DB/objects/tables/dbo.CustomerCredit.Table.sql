USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CustomerCredit]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerCredit](
	[IDCustomerCredit] [int] NOT NULL,
	[IDPessoa] [int] NULL,
	[IDUser] [int] NULL,
	[IDStore] [int] NULL,
	[CreditDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[IsUsed] [dbo].[Boolean] NULL,
	[Amount] [money] NULL,
	[IDLancamento] [int] NULL,
	[IDPreInventoryMov] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKCustomerCredit] PRIMARY KEY CLUSTERED 
(
	[IDCustomerCredit] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomerCredit]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_CustomerCredit_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[CustomerCredit] CHECK CONSTRAINT [FK_Pessoa_CustomerCredit_IDPessoa]
GO
ALTER TABLE [dbo].[CustomerCredit]  WITH CHECK ADD  CONSTRAINT [FK_Store_CustomerCredit_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[CustomerCredit] CHECK CONSTRAINT [FK_Store_CustomerCredit_IDStore]
GO
ALTER TABLE [dbo].[CustomerCredit]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_CustomerCredit_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[CustomerCredit] CHECK CONSTRAINT [FK_SystemUser_CustomerCredit_IDUser]
GO
