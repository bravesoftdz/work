USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_ContaCorrente]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_ContaCorrente](
	[IDContaCorrente] [int] NOT NULL,
	[CodigoContaCorrente] [dbo].[TCodigoGeral] NOT NULL,
	[IDMoeda] [int] NULL,
	[IDCentroCusto] [int] NULL,
	[IDBanco] [int] NOT NULL,
	[IDEmpresa] [int] NOT NULL,
	[Tipo] [varchar](20) NULL,
	[Numero] [dbo].[TDescricao] NOT NULL,
	[Gerente] [dbo].[TDescricao] NULL,
	[DataAbertura] [smalldatetime] NULL,
	[OBS] [text] NULL,
	[System] [dbo].[TBit] NULL,
	[Desativado] [dbo].[TBit] NULL,
	[IDBancoAgencia] [int] NULL,
	[Hidden] [dbo].[TBit] NULL,
	[SaldoAtual] [dbo].[TValor] NULL,
	[UltimoSaldoBancario] [dbo].[TValor] NULL,
	[UltimaReconciliacao] [datetime] NULL,
	[NossoNumero] [varchar](20) NULL,
	[NossoNumeroDigito] [char](1) NULL,
	[Carteira] [varchar](10) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_ContaCorrent__02FC7413] PRIMARY KEY CLUSTERED 
(
	[IDContaCorrente] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Fin_ContaCorrente]  WITH NOCHECK ADD  CONSTRAINT [FK_Banco_ContaCorrente_IDBanco] FOREIGN KEY([IDBanco])
REFERENCES [dbo].[Fin_Banco] ([IDBanco])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_ContaCorrente] CHECK CONSTRAINT [FK_Banco_ContaCorrente_IDBanco]
GO
ALTER TABLE [dbo].[Fin_ContaCorrente]  WITH NOCHECK ADD  CONSTRAINT [FK_BancoAgencia_ContaCorrente_IDBancoAgencia] FOREIGN KEY([IDBancoAgencia])
REFERENCES [dbo].[Fin_BancoAgencia] ([IDBancoAgencia])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_ContaCorrente] CHECK CONSTRAINT [FK_BancoAgencia_ContaCorrente_IDBancoAgencia]
GO
ALTER TABLE [dbo].[Fin_ContaCorrente]  WITH NOCHECK ADD  CONSTRAINT [FK_CentroCusto_ContaCorrente_IDCentroCusto] FOREIGN KEY([IDCentroCusto])
REFERENCES [dbo].[Fin_CentroCusto] ([IDCentroCusto])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_ContaCorrente] CHECK CONSTRAINT [FK_CentroCusto_ContaCorrente_IDCentroCusto]
GO
ALTER TABLE [dbo].[Fin_ContaCorrente]  WITH NOCHECK ADD  CONSTRAINT [FK_SisEmpresa_ContaCorrente_IDEmpresa] FOREIGN KEY([IDEmpresa])
REFERENCES [dbo].[Sis_Empresa] ([IDEmpresa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_ContaCorrente] CHECK CONSTRAINT [FK_SisEmpresa_ContaCorrente_IDEmpresa]
GO
ALTER TABLE [dbo].[Fin_ContaCorrente]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMoeda_ContaCorrente_IDMoeda] FOREIGN KEY([IDMoeda])
REFERENCES [dbo].[Sis_Moeda] ([IDMoeda])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_ContaCorrente] CHECK CONSTRAINT [FK_SisMoeda_ContaCorrente_IDMoeda]
GO
ALTER TABLE [dbo].[Fin_ContaCorrente] ADD  CONSTRAINT [DF_Zero68]  DEFAULT (0) FOR [SaldoAtual]
GO
