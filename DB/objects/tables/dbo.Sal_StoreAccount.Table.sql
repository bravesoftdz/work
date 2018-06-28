USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_StoreAccount]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_StoreAccount](
	[IDStoreAccount] [int] NOT NULL,
	[IDStoreAccountUsed] [int] NULL,
	[IDPessoa] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[IDStore] [int] NOT NULL,
	[IDLancamento] [int] NULL,
	[TransactionDate] [datetime] NULL,
	[Amount] [money] NULL,
	[IsUsed] [bit] NULL,
	[IsReceiving] [bit] NULL,
	[Verify] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_StoreAccount] PRIMARY KEY CLUSTERED 
(
	[IDStoreAccount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_StoreAccount]  WITH CHECK ADD  CONSTRAINT [FK_Fin_Lancamento_Sal_StoreAcc_IDLancamento] FOREIGN KEY([IDLancamento])
REFERENCES [dbo].[Fin_Lancamento] ([IDLancamento])
GO
ALTER TABLE [dbo].[Sal_StoreAccount] CHECK CONSTRAINT [FK_Fin_Lancamento_Sal_StoreAcc_IDLancamento]
GO
ALTER TABLE [dbo].[Sal_StoreAccount]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_Sal_StoreAcc_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sal_StoreAccount] CHECK CONSTRAINT [FK_Pessoa_Sal_StoreAcc_IDPessoa]
GO
ALTER TABLE [dbo].[Sal_StoreAccount]  WITH CHECK ADD  CONSTRAINT [FK_Sal_StoreAcc_Sal_StoreAcc_IDStoreAccountUsed] FOREIGN KEY([IDStoreAccountUsed])
REFERENCES [dbo].[Sal_StoreAccount] ([IDStoreAccount])
GO
ALTER TABLE [dbo].[Sal_StoreAccount] CHECK CONSTRAINT [FK_Sal_StoreAcc_Sal_StoreAcc_IDStoreAccountUsed]
GO
ALTER TABLE [dbo].[Sal_StoreAccount]  WITH CHECK ADD  CONSTRAINT [FK_Store_Sal_StoreAcc_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Sal_StoreAccount] CHECK CONSTRAINT [FK_Store_Sal_StoreAcc_IDStore]
GO
ALTER TABLE [dbo].[Sal_StoreAccount]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Sal_StoreAcc_IDStore] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sal_StoreAccount] CHECK CONSTRAINT [FK_SystemUser_Sal_StoreAcc_IDStore]
GO
ALTER TABLE [dbo].[Sal_StoreAccount] ADD  DEFAULT (0) FOR [IsReceiving]
GO
ALTER TABLE [dbo].[Sal_StoreAccount] ADD  CONSTRAINT [DEF_Bit1219]  DEFAULT ((0)) FOR [Verify]
GO
