USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_LancamentoTipo]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_LancamentoTipo](
	[IDLancamentoTipo] [int] NOT NULL,
	[IDPessoa] [int] NULL,
	[IDPessoaTipo] [int] NULL,
	[IDContaCorrenteDefault] [int] NULL,
	[IDLancamentoTipoParent] [int] NULL,
	[LancamentoTipo] [varchar](65) NULL,
	[Path] [dbo].[TPath] NULL,
	[PathName] [varchar](255) NULL,
	[Pagando] [dbo].[TBit] NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[PermitePessoaNula] [dbo].[TBit] NULL,
	[SugerePessoa] [dbo].[TBit] NULL,
	[PessoaFixa] [dbo].[TBit] NULL,
	[SugereContaCorrente] [dbo].[TBit] NULL,
	[ContaCorrenteFixa] [dbo].[TBit] NULL,
	[CodigoContabil] [varchar](35) NULL,
	[Sintetico] [dbo].[TBit] NULL,
	[IDCentroCusto] [int] NULL,
	[SugereCentroCusto] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_LancamentoTi__32AB8735] PRIMARY KEY CLUSTERED 
(
	[IDLancamentoTipo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo]  WITH CHECK ADD  CONSTRAINT [FK_ContaCorrente_CentroCusto_IDCentroCustoDefault] FOREIGN KEY([IDCentroCusto])
REFERENCES [dbo].[Fin_CentroCusto] ([IDCentroCusto])
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo] CHECK CONSTRAINT [FK_ContaCorrente_CentroCusto_IDCentroCustoDefault]
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo]  WITH NOCHECK ADD  CONSTRAINT [FK_ContaCorrente_LancamentoTipo_IDContaCorrenteDefault] FOREIGN KEY([IDContaCorrenteDefault])
REFERENCES [dbo].[Fin_ContaCorrente] ([IDContaCorrente])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo] CHECK CONSTRAINT [FK_ContaCorrente_LancamentoTipo_IDContaCorrenteDefault]
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo]  WITH NOCHECK ADD  CONSTRAINT [FK_LancamentoTipo_LancamentoTipo_IDLancamentoTipoParent] FOREIGN KEY([IDLancamentoTipoParent])
REFERENCES [dbo].[Fin_LancamentoTipo] ([IDLancamentoTipo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo] CHECK CONSTRAINT [FK_LancamentoTipo_LancamentoTipo_IDLancamentoTipoParent]
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_LancamentoTipo_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo] CHECK CONSTRAINT [FK_Pessoa_LancamentoTipo_IDPessoa]
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo]  WITH NOCHECK ADD  CONSTRAINT [FK_TipoPessoa_LancamentoTipo_IDPessoaTipo] FOREIGN KEY([IDPessoaTipo])
REFERENCES [dbo].[TipoPessoa] ([IDTipoPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_LancamentoTipo] CHECK CONSTRAINT [FK_TipoPessoa_LancamentoTipo_IDPessoaTipo]
GO
