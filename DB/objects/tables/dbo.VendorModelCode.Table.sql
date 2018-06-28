USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[VendorModelCode]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VendorModelCode](
	[IDVendorModelCode] [int] NOT NULL,
	[IDPessoa] [int] NULL,
	[IDModel] [int] NULL,
	[VendorCode] [varchar](35) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKVendorModelCode] PRIMARY KEY CLUSTERED 
(
	[IDVendorModelCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[VendorModelCode]  WITH CHECK ADD  CONSTRAINT [FK_Model_VendorCode_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[VendorModelCode] CHECK CONSTRAINT [FK_Model_VendorCode_IDModel]
GO
ALTER TABLE [dbo].[VendorModelCode]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_VendorCode_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[VendorModelCode] CHECK CONSTRAINT [FK_Pessoa_VendorCode_IDPessoa]
GO
