USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InvoiceOBS]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvoiceOBS](
	[IDInvoiceOBS] [int] NOT NULL,
	[IDPreSale] [int] NULL,
	[ObsDate] [datetime] NULL,
	[Obs] [varchar](255) NULL,
	[IDCFOP] [int] NULL,
	[IDPessoaTax] [int] NULL,
	[IDCarrier] [int] NULL,
	[FreightType] [int] NULL,
	[IDUserDeliver] [int] NULL,
	[IDPessoaAddress] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_InvoiceOBS_IDInvoiceOBS] PRIMARY KEY CLUSTERED 
(
	[IDInvoiceOBS] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[InvoiceOBS]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_InvoiceOBS_IDPreSale] FOREIGN KEY([IDPreSale])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[InvoiceOBS] CHECK CONSTRAINT [FK_Invoice_InvoiceOBS_IDPreSale]
GO
ALTER TABLE [dbo].[InvoiceOBS]  WITH CHECK ADD  CONSTRAINT [FK_MntCFOP_InvoiceOBS_IDCFOP] FOREIGN KEY([IDCFOP])
REFERENCES [dbo].[Mnt_CFOP] ([IDCFOP])
GO
ALTER TABLE [dbo].[InvoiceOBS] CHECK CONSTRAINT [FK_MntCFOP_InvoiceOBS_IDCFOP]
GO
ALTER TABLE [dbo].[InvoiceOBS]  WITH CHECK ADD  CONSTRAINT [FK_MntPessoaAddress_InvoiceOBS_IDPessoaAddress] FOREIGN KEY([IDPessoaAddress])
REFERENCES [dbo].[Mnt_PessoaAddress] ([IDPessoaAddress])
GO
ALTER TABLE [dbo].[InvoiceOBS] CHECK CONSTRAINT [FK_MntPessoaAddress_InvoiceOBS_IDPessoaAddress]
GO
ALTER TABLE [dbo].[InvoiceOBS]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_InvoiceOBS_IDCarrier] FOREIGN KEY([IDCarrier])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[InvoiceOBS] CHECK CONSTRAINT [FK_Pessoa_InvoiceOBS_IDCarrier]
GO
ALTER TABLE [dbo].[InvoiceOBS]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_InvoiceOBS_IDPessoaTax] FOREIGN KEY([IDPessoaTax])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[InvoiceOBS] CHECK CONSTRAINT [FK_Pessoa_InvoiceOBS_IDPessoaTax]
GO
ALTER TABLE [dbo].[InvoiceOBS]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_InvoiceOBS_IDUser] FOREIGN KEY([IDUserDeliver])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[InvoiceOBS] CHECK CONSTRAINT [FK_SystemUser_InvoiceOBS_IDUser]
GO
