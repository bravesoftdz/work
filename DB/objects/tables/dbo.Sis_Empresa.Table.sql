USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_Empresa]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_Empresa](
	[IDEmpresa] [int] NOT NULL,
	[CodigoEmpresa] [dbo].[TCodigoGeral] NOT NULL,
	[Empresa] [dbo].[TDescricao] NOT NULL,
	[RazaoSocial] [varchar](100) NULL,
	[CGC] [varchar](20) NULL,
	[InscricaoEstadual] [varchar](20) NULL,
	[InscricaoMunicipal] [varchar](20) NULL,
	[Endereco] [dbo].[TEndereco] NULL,
	[Coplemento] [varchar](20) NULL,
	[Bairro] [dbo].[TBairro] NULL,
	[Cidade] [varchar](30) NULL,
	[CEP] [varchar](10) NULL,
	[Pais] [varchar](20) NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[ISS] [dbo].[TPercentual] NOT NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[Confins] [dbo].[TPercentual] NOT NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[PIS] [dbo].[TPercentual] NOT NULL,
	[ContribuicaoSocial] [dbo].[TPercentual] NOT NULL,
	[UltimaFatura] [int] NULL,
	[PercRetencaoINSS] [dbo].[TPercentual] NOT NULL,
	[UltimoNumeroFormulario] [int] NULL,
	[NFModeloFormulario] [varchar](20) NULL,
	[Porta] [varchar](20) NULL,
	[NFSModeloFormulario] [varchar](20) NULL,
	[NFSPorta] [varchar](20) NULL,
	[IDEstado] [char](3) NULL,
	[Numero] [int] NULL,
	[Contato] [varchar](30) NULL,
	[Telefone] [dbo].[TTelephone] NULL,
	[Fax] [dbo].[TTelephone] NULL,
	[LogoEmpresa] [image] NULL,
	[NomeFantasia] [varchar](100) NULL,
	[IDMunicipio] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Sis_Empresa__44FF419A] PRIMARY KEY CLUSTERED 
(
	[IDEmpresa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Estado_SisEmpresa_IDEstado] FOREIGN KEY([IDEstado])
REFERENCES [dbo].[Estado] ([IDEstado])
GO
ALTER TABLE [dbo].[Sis_Empresa] CHECK CONSTRAINT [FK_Estado_SisEmpresa_IDEstado]
GO
ALTER TABLE [dbo].[Sis_Empresa]  WITH CHECK ADD  CONSTRAINT [FK_Sis_Municipo_SisEmpresa_IDMunicipio] FOREIGN KEY([IDMunicipio])
REFERENCES [dbo].[Sis_Municipio] ([IDMunicipio])
GO
ALTER TABLE [dbo].[Sis_Empresa] CHECK CONSTRAINT [FK_Sis_Municipo_SisEmpresa_IDMunicipio]
GO
