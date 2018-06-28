USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pessoa]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pessoa](
	[IDPessoa] [int] NOT NULL,
	[IDTipoPessoa] [int] NOT NULL,
	[IDStore] [int] NULL,
	[IDEstado] [char](3) NULL,
	[IDRamoAtividade] [int] NULL,
	[IDPais] [int] NULL,
	[IDPessoaBoss] [int] NULL,
	[IDTipoPessoaFilho] [int] NULL,
	[IDTipoPessoaRoot] [int] NULL,
	[IDUser] [int] NULL,
	[ShortName] [varchar](15) NULL,
	[Pessoa] [varchar](50) NULL,
	[PessoaFirstName] [varchar](30) NULL,
	[PessoaLastName] [varchar](50) NULL,
	[NomeJuridico] [varchar](50) NULL,
	[Endereco] [dbo].[TAddress] NULL,
	[Cidade] [dbo].[TCity] NULL,
	[CEP] [char](12) NULL,
	[Pais] [varchar](21) NULL,
	[Telefone] [dbo].[TTelephone] NULL,
	[Cellular] [char](18) NULL,
	[Fax] [dbo].[TTelephone] NULL,
	[Beeper] [char](25) NULL,
	[Contato] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[OBS] [varchar](100) NULL,
	[Juridico] [bit] NULL,
	[TotalMovimentado] [money] NOT NULL,
	[Limite] [money] NOT NULL,
	[Nascimento] [smalldatetime] NULL,
	[DiaQuitacao] [int] NULL,
	[CPF] [varchar](30) NULL,
	[CGC] [varchar](30) NULL,
	[Identidade] [varchar](30) NULL,
	[CartTrabalho] [varchar](30) NULL,
	[InscEstadual] [varchar](30) NULL,
	[InscMunicipal] [varchar](30) NULL,
	[Contatos] [varchar](255) NULL,
	[NumAtrasos] [int] NULL,
	[DiasAtraso] [int] NULL,
	[NumTransacoes] [int] NULL,
	[HomePage] [varchar](200) NULL,
	[OrgaoEmissor] [varchar](50) NULL,
	[Bairro] [varchar](50) NULL,
	[NumMovimentacoes] [int] NULL,
	[ComissaoSobreGuia] [money] NULL,
	[DescontaCoordenacao] [bit] NULL,
	[AjusteComiss] [money] NULL,
	[Short_Name] [varchar](30) NULL,
	[Code] [int] NULL,
	[CustomerCard] [varchar](20) NULL,
	[HorasSemana] [int] NULL,
	[ValorHora] [dbo].[TValor] NULL,
	[ValorHoraExtra] [dbo].[TValor] NULL,
	[ValorHoraExtraExtra] [dbo].[TValor] NULL,
	[DefaultPaymentDelay] [int] NULL,
	[System] [bit] NULL,
	[Desativado] [int] NOT NULL,
	[Hidden] [int] NOT NULL,
	[PhoneAreaCode] [varchar](5) NULL,
	[CellAreaCode] [varchar](5) NULL,
	[UserCode] [varchar](6) NULL,
	[CartMotorista] [varchar](15) NULL,
	[DataExpedicao] [datetime] NULL,
	[CreationDate] [datetime] NULL,
	[SalesTaxExempt] [bit] NULL,
	[Sexo] [dbo].[Boolean] NULL,
	[Complemento] [varchar](20) NULL,
	[ComplementoNum] [int] NULL,
	[IDMunicipio] [int] NULL,
	[SUFRAMA] [varchar](9) NULL,
	[StoreAccountLimit] [money] NULL,
	[Nonpayer] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Pessoa__571DF1D5] PRIMARY KEY NONCLUSTERED 
(
	[IDPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pessoa]  WITH CHECK ADD  CONSTRAINT [FK_Sis_Municipio_Pessoa_IDMunicipio] FOREIGN KEY([IDMunicipio])
REFERENCES [dbo].[Sis_Municipio] ([IDMunicipio])
GO
ALTER TABLE [dbo].[Pessoa] CHECK CONSTRAINT [FK_Sis_Municipio_Pessoa_IDMunicipio]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero33]  DEFAULT (0) FOR [Juridico]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero34]  DEFAULT (0) FOR [TotalMovimentado]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero35]  DEFAULT (0) FOR [Limite]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero36]  DEFAULT (0) FOR [DiaQuitacao]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero37]  DEFAULT (0) FOR [NumAtrasos]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero38]  DEFAULT (0) FOR [DiasAtraso]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero39]  DEFAULT (0) FOR [NumTransacoes]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero40]  DEFAULT (0) FOR [ComissaoSobreGuia]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero41]  DEFAULT (0) FOR [DescontaCoordenacao]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero42]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero43]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Zero44]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DF_Pessoa_SalesTaxExempt]  DEFAULT (0) FOR [SalesTaxExempt]
GO
ALTER TABLE [dbo].[Pessoa] ADD  CONSTRAINT [DEF_Bit1196]  DEFAULT ((0)) FOR [Nonpayer]
GO
