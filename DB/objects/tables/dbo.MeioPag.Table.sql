USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[MeioPag]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MeioPag](
	[IDMeioPag] [int] NOT NULL,
	[IDContaCorrente] [int] NULL,
	[IDLancamentoTipo] [int] NULL,
	[IDPessoa] [int] NULL,
	[IDMeioPagBatch] [int] NULL,
	[MeioPag] [varchar](50) NOT NULL,
	[CodigoMeioPag] [dbo].[TCodigoGeral] NULL,
	[TemDocumento] [bit] NULL,
	[PrazoRecebimento] [int] NOT NULL,
	[TaxaAdmin] [money] NOT NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[IdentificadorDocumento] [varchar](20) NULL,
	[TaxMode] [int] NULL,
	[Tipo] [int] NULL,
	[PossuiFavorecido] [dbo].[TBit] NULL,
	[ObrigaFavorecido] [dbo].[TBit] NULL,
	[PossuiNumero] [dbo].[TBit] NULL,
	[ObrigaNumero] [dbo].[TBit] NULL,
	[ParentType] [varchar](20) NULL,
	[AutoDiscountFee] [dbo].[TBit] NULL,
	[ImageIndex] [int] NULL,
	[CodFiscal] [varchar](2) NULL,
	[DescFiscal] [varchar](16) NULL,
	[PayOnCashRegClose] [dbo].[Boolean] NOT NULL,
	[DrawerKickOnPay] [dbo].[Boolean] NOT NULL,
	[RequireCustomer] [bit] NOT NULL,
	[PrintBankBillet] [bit] NULL,
	[BankBilletInterest] [money] NULL,
	[ValidateNonpayer] [bit] NULL,
	[FlatPenalty] [dbo].[Boolean] NULL,
	[PenaltyValue] [money] NULL,
	[DailtInterest] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__MeioPag__3A4CA8FD] PRIMARY KEY CLUSTERED 
(
	[IDMeioPag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[MeioPag]  WITH NOCHECK ADD  CONSTRAINT [FK_ContaCorrente_MeioPag_IDContaCorrente] FOREIGN KEY([IDContaCorrente])
REFERENCES [dbo].[Fin_ContaCorrente] ([IDContaCorrente])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[MeioPag] CHECK CONSTRAINT [FK_ContaCorrente_MeioPag_IDContaCorrente]
GO
ALTER TABLE [dbo].[MeioPag]  WITH NOCHECK ADD  CONSTRAINT [FK_LancamentoTipo_MeioPag_IDLancamentoTipo] FOREIGN KEY([IDLancamentoTipo])
REFERENCES [dbo].[Fin_LancamentoTipo] ([IDLancamentoTipo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[MeioPag] CHECK CONSTRAINT [FK_LancamentoTipo_MeioPag_IDLancamentoTipo]
GO
ALTER TABLE [dbo].[MeioPag]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_MeioPag_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[MeioPag] CHECK CONSTRAINT [FK_Pessoa_MeioPag_IDPessoa]
GO
ALTER TABLE [dbo].[MeioPag] ADD  CONSTRAINT [DF_Zero95]  DEFAULT (0) FOR [TemDocumento]
GO
ALTER TABLE [dbo].[MeioPag] ADD  CONSTRAINT [DF_Zero96]  DEFAULT (0) FOR [PrazoRecebimento]
GO
ALTER TABLE [dbo].[MeioPag] ADD  CONSTRAINT [DF_Zero97]  DEFAULT (0) FOR [TaxaAdmin]
GO
ALTER TABLE [dbo].[MeioPag] ADD  CONSTRAINT [DF_Zero98]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[MeioPag] ADD  CONSTRAINT [DF_Zero99]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[MeioPag] ADD  CONSTRAINT [DF_Zero100]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[MeioPag] ADD  DEFAULT (0) FOR [RequireCustomer]
GO
ALTER TABLE [dbo].[MeioPag] ADD  CONSTRAINT [DF_Zero4130]  DEFAULT (0) FOR [PrintBankBillet]
GO
