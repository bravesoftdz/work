USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_Lancamento]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_Lancamento](
	[IDLancamento] [int] NOT NULL,
	[IDPreSale] [int] NULL,
	[IDQuitacaoMeioPrevisto] [int] NULL,
	[IDPessoaTipo] [int] NULL,
	[IDBancoAgenciaQuitPrev] [int] NULL,
	[IDEmpresa] [int] NOT NULL,
	[IDPessoa] [int] NULL,
	[IDBancoQuitPrev] [int] NULL,
	[IDDesdobramentoTipo] [int] NULL,
	[IDMoedaCotacao] [int] NULL,
	[IDMoeda] [int] NULL,
	[IDUsuarioLancamento] [int] NULL,
	[IDCentroCusto] [int] NULL,
	[IDLancamentoTipo] [int] NULL,
	[IDDocumentoTipo] [int] NULL,
	[IDContaCorrentePrevista] [int] NULL,
	[IDUsuarioProtesto] [int] NULL,
	[IDUsuarioAprovacao] [int] NULL,
	[IDLancamentoOriginal] [int] NULL,
	[IDCashRegMov] [int] NULL,
	[IDPurchase] [int] NULL,
	[Previsao] [dbo].[TBit] NULL,
	[DataAprovacao] [smalldatetime] NULL,
	[Situacao] [int] NULL,
	[DataLancamento] [smalldatetime] NOT NULL,
	[DataVencimento] [smalldatetime] NOT NULL,
	[DataVencimentoOriginal] [datetime] NULL,
	[DataInicioQuitacao] [smalldatetime] NULL,
	[DataFimQuitacao] [smalldatetime] NULL,
	[DataProtesto] [smalldatetime] NULL,
	[Pagando] [dbo].[TBit] NULL,
	[ValorNominal] [dbo].[TValor] NOT NULL,
	[TotalQuitado] [dbo].[TValor] NOT NULL,
	[TotalJuros] [dbo].[TValor] NOT NULL,
	[NumDocumento] [dbo].[TCodigoGeral] NULL,
	[NumDesdobramento] [dbo].[TCodigoGeral] NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[NumeroDuplicata] [dbo].[TCodigoGeral] NULL,
	[MoedaSigla] [varchar](35) NULL,
	[NumeroRepeticoes] [int] NULL,
	[PeriodicidadeRepeticoes] [int] NULL,
	[DiaRepeticoes] [int] NULL,
	[DataPrimeiraRepeticao] [smalldatetime] NULL,
	[DataEmissao] [datetime] NULL,
	[DataFaturamento] [datetime] NULL,
	[Historico] [text] NULL,
	[FavorecidoPrevisto] [varchar](65) NULL,
	[LancamentoType] [int] NULL,
	[IDLancamentoParent] [int] NULL,
	[CheckNumber] [varchar](20) NULL,
	[CustomerDocument] [varchar](20) NULL,
	[CustomerName] [varchar](80) NULL,
	[CustomerPhone] [varchar](20) NULL,
	[IDBankCheck] [int] NULL,
	[PaymentPlace] [int] NULL,
	[IDCashRegMovClosed] [int] NULL,
	[IsPreDatado] [bit] NULL,
	[NumMeioQuitPrevisto] [varchar](60) NULL,
	[IDServiceOrder] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_Lancamento__47A6A41B] PRIMARY KEY CLUSTERED 
(
	[IDLancamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_Banco_Lancamento_IDBancoQuitPrev] FOREIGN KEY([IDBancoQuitPrev])
REFERENCES [dbo].[Fin_Banco] ([IDBanco])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_Banco_Lancamento_IDBancoQuitPrev]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_BancoAgencia_Lancamento_IDBancoAgenciaQuitPrev] FOREIGN KEY([IDBancoAgenciaQuitPrev])
REFERENCES [dbo].[Fin_BancoAgencia] ([IDBancoAgencia])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_BancoAgencia_Lancamento_IDBancoAgenciaQuitPrev]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_CashRegMov_Lancamento_IDCashRegMov] FOREIGN KEY([IDCashRegMov])
REFERENCES [dbo].[CashRegMov] ([IDCashRegMov])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_CashRegMov_Lancamento_IDCashRegMov]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_CentroCusto_Lancamento_IDCentroCusto] FOREIGN KEY([IDCentroCusto])
REFERENCES [dbo].[Fin_CentroCusto] ([IDCentroCusto])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_CentroCusto_Lancamento_IDCentroCusto]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_ContaCorrente_Lancamento_IDContaCorrentePrevista] FOREIGN KEY([IDContaCorrentePrevista])
REFERENCES [dbo].[Fin_ContaCorrente] ([IDContaCorrente])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_ContaCorrente_Lancamento_IDContaCorrentePrevista]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_DesdobramentoTipo_Lancamento_IDDesdobramentoTipo] FOREIGN KEY([IDDesdobramentoTipo])
REFERENCES [dbo].[Fin_DesdobramentoTipo] ([IDDesdobramentoTipo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_DesdobramentoTipo_Lancamento_IDDesdobramentoTipo]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_DocumentoTipo_Lancamento_IDDocumentoTipo] FOREIGN KEY([IDDocumentoTipo])
REFERENCES [dbo].[Fin_DocumentoTipo] ([IDDocumentoTipo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_DocumentoTipo_Lancamento_IDDocumentoTipo]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH CHECK ADD  CONSTRAINT [FK_Fin_Banco_Fin_Lancamento_IDBankCheck] FOREIGN KEY([IDBankCheck])
REFERENCES [dbo].[Fin_Banco] ([IDBanco])
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_Fin_Banco_Fin_Lancamento_IDBankCheck]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_Fin_Lancamento_Fin_Lancamento_IDLancamentoParent] FOREIGN KEY([IDLancamentoParent])
REFERENCES [dbo].[Fin_Lancamento] ([IDLancamento])
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_Fin_Lancamento_Fin_Lancamento_IDLancamentoParent]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_Invoice_Lancamento_IDPreSale] FOREIGN KEY([IDPreSale])
REFERENCES [dbo].[Invoice] ([IDPreSale])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_Invoice_Lancamento_IDPreSale]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_Lancamento_Lancamento_IDLancamentoOriginal] FOREIGN KEY([IDLancamentoOriginal])
REFERENCES [dbo].[Fin_Lancamento] ([IDLancamento])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_Lancamento_Lancamento_IDLancamentoOriginal]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_LancamentoTipo_Lancamento_IDLancamentoTipo] FOREIGN KEY([IDLancamentoTipo])
REFERENCES [dbo].[Fin_LancamentoTipo] ([IDLancamentoTipo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_LancamentoTipo_Lancamento_IDLancamentoTipo]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_MeioPag_Lancamento_IDQuitacaoMeioPrevisto] FOREIGN KEY([IDQuitacaoMeioPrevisto])
REFERENCES [dbo].[MeioPag] ([IDMeioPag])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_MeioPag_Lancamento_IDQuitacaoMeioPrevisto]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_Lancamento_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_Pessoa_Lancamento_IDPessoa]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH CHECK ADD  CONSTRAINT [FK_Ser_ServiceOrder_Fin_Lancamento_IDServiceOrder] FOREIGN KEY([IDServiceOrder])
REFERENCES [dbo].[Ser_ServiceOrder] ([IDServiceOrder])
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_Ser_ServiceOrder_Fin_Lancamento_IDServiceOrder]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_SisEmpresa_Lancamento_IDEmpresa] FOREIGN KEY([IDEmpresa])
REFERENCES [dbo].[Sis_Empresa] ([IDEmpresa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_SisEmpresa_Lancamento_IDEmpresa]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMoeda_Lancamento_IDMoeda] FOREIGN KEY([IDMoeda])
REFERENCES [dbo].[Sis_Moeda] ([IDMoeda])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_SisMoeda_Lancamento_IDMoeda]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMoedaCotacao_Lancamento_IDMoedaCotacao] FOREIGN KEY([IDMoedaCotacao])
REFERENCES [dbo].[Sis_MoedaCotacao] ([IDMoedaCotacao])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_SisMoedaCotacao_Lancamento_IDMoedaCotacao]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Fin_Lancamento_IDUsuarioAprovacao] FOREIGN KEY([IDUsuarioAprovacao])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_SystemUser_Fin_Lancamento_IDUsuarioAprovacao]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Fin_Lancamento_IDUsuarioLancamento] FOREIGN KEY([IDUsuarioLancamento])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_SystemUser_Fin_Lancamento_IDUsuarioLancamento]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Fin_Lancamento_IDUsuarioProtesto] FOREIGN KEY([IDUsuarioProtesto])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_SystemUser_Fin_Lancamento_IDUsuarioProtesto]
GO
ALTER TABLE [dbo].[Fin_Lancamento]  WITH NOCHECK ADD  CONSTRAINT [FK_TipoPessoa_Lancamento_IDPessoaTipo] FOREIGN KEY([IDPessoaTipo])
REFERENCES [dbo].[TipoPessoa] ([IDTipoPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Lancamento] CHECK CONSTRAINT [FK_TipoPessoa_Lancamento_IDPessoaTipo]
GO
ALTER TABLE [dbo].[Fin_Lancamento] ADD  DEFAULT (0) FOR [IsPreDatado]
GO
