USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Mnt_PessoaAddress]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mnt_PessoaAddress](
	[IDPessoaAddress] [int] NOT NULL,
	[IDPessoa] [int] NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[Address] [varchar](80) NOT NULL,
	[City] [varchar](30) NOT NULL,
	[ZIP] [varchar](10) NOT NULL,
	[IDTaxCategory] [int] NULL,
	[IDPais] [int] NULL,
	[IDEstado] [char](3) NOT NULL,
	[IsBillTo] [dbo].[Boolean] NOT NULL,
	[System] [dbo].[Boolean] NOT NULL,
	[Hidden] [dbo].[Boolean] NOT NULL,
	[Desativado] [dbo].[Boolean] NOT NULL,
	[Neighborhood] [varchar](30) NULL,
	[CompanyReg] [varchar](30) NULL,
	[IDMunicipio] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMnt_PessoaAddress] PRIMARY KEY CLUSTERED 
(
	[IDPessoaAddress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress]  WITH CHECK ADD  CONSTRAINT [FK_Estado_MntPessoaAddress_IDEstado] FOREIGN KEY([IDEstado])
REFERENCES [dbo].[Estado] ([IDEstado])
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress] CHECK CONSTRAINT [FK_Estado_MntPessoaAddress_IDEstado]
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress]  WITH CHECK ADD  CONSTRAINT [FK_Pais_MntPessoaAddress_IDPais] FOREIGN KEY([IDPais])
REFERENCES [dbo].[Pais] ([IDPais])
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress] CHECK CONSTRAINT [FK_Pais_MntPessoaAddress_IDPais]
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_MntPessoaAddress_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress] CHECK CONSTRAINT [FK_Pessoa_MntPessoaAddress_IDPessoa]
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress]  WITH CHECK ADD  CONSTRAINT [FK_Sis_Municipio_Mnt_PessoaAddress_IDMunicipio] FOREIGN KEY([IDMunicipio])
REFERENCES [dbo].[Sis_Municipio] ([IDMunicipio])
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress] CHECK CONSTRAINT [FK_Sis_Municipio_Mnt_PessoaAddress_IDMunicipio]
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress]  WITH CHECK ADD  CONSTRAINT [FK_TaxCategory_MntPessoaAddress_IDTaxCategory] FOREIGN KEY([IDTaxCategory])
REFERENCES [dbo].[TaxCategory] ([IDTaxCategory])
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress] CHECK CONSTRAINT [FK_TaxCategory_MntPessoaAddress_IDTaxCategory]
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress] ADD  CONSTRAINT [DF_MntPessoaAddress_IsBillTo_Zero]  DEFAULT (0) FOR [IsBillTo]
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress] ADD  CONSTRAINT [DF_MntPessoaAddress_System_Zero]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress] ADD  CONSTRAINT [DF_MntPessoaAddress_Hidden_Zero]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Mnt_PessoaAddress] ADD  CONSTRAINT [DF_MntPessoaAddress_Desativado_Zero]  DEFAULT (0) FOR [Desativado]
GO
