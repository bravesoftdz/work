USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Mnt_StoreVendorAccount]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mnt_StoreVendorAccount](
	[IDStoreVendorAccount] [int] NOT NULL,
	[IDStore] [int] NOT NULL,
	[IDPessoa] [int] NOT NULL,
	[Account] [varchar](35) NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMnt_StoreVendorAccount] PRIMARY KEY CLUSTERED 
(
	[IDStoreVendorAccount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Mnt_StoreVendorAccount]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_StoreVendorAccount_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Mnt_StoreVendorAccount] CHECK CONSTRAINT [FK_Pessoa_StoreVendorAccount_IDPessoa]
GO
ALTER TABLE [dbo].[Mnt_StoreVendorAccount]  WITH CHECK ADD  CONSTRAINT [FK_Store_StoreVendorAccount_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Mnt_StoreVendorAccount] CHECK CONSTRAINT [FK_Store_StoreVendorAccount_IDStore]
GO
