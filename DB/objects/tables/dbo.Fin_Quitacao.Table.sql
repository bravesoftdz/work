USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_Quitacao]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_Quitacao](
	[IDQuitacao] [int] NOT NULL,
	[IDTransferencia] [int] NULL,
	[IDQuitacaoMeio] [int] NOT NULL,
	[IDBancoAgencia] [int] NULL,
	[IDBanco] [int] NULL,
	[IDContaCorrente] [int] NOT NULL,
	[IDUsuarioQuitacao] [int] NOT NULL,
	[IDUsuarioReconciliacao] [int] NULL,
	[Pagando] [dbo].[TBit] NULL,
	[ValorQuitacao] [dbo].[TValor] NOT NULL,
	[ValorJuros] [dbo].[TValor] NOT NULL,
	[DataQuitacao] [smalldatetime] NOT NULL,
	[DataDesbloqueio] [smalldatetime] NULL,
	[NumeroMeioQuit] [dbo].[TCodigoGeral] NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[String] [varchar](100) NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[Favorecido] [varchar](100) NULL,
	[SparrowInt] [int] NULL,
	[AReconciliar] [dbo].[TBit] NULL,
	[DataReconciliacao] [datetime] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_Quitacao__0D44F85C] PRIMARY KEY CLUSTERED 
(
	[IDQuitacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Fin_Quitacao]  WITH NOCHECK ADD  CONSTRAINT [FK_Banco_Quitacao_IDBanco] FOREIGN KEY([IDBanco])
REFERENCES [dbo].[Fin_Banco] ([IDBanco])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Quitacao] CHECK CONSTRAINT [FK_Banco_Quitacao_IDBanco]
GO
ALTER TABLE [dbo].[Fin_Quitacao]  WITH NOCHECK ADD  CONSTRAINT [FK_BancoAgencia_Quitacao_IDBancoAgencia] FOREIGN KEY([IDBancoAgencia])
REFERENCES [dbo].[Fin_BancoAgencia] ([IDBancoAgencia])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Quitacao] CHECK CONSTRAINT [FK_BancoAgencia_Quitacao_IDBancoAgencia]
GO
ALTER TABLE [dbo].[Fin_Quitacao]  WITH NOCHECK ADD  CONSTRAINT [FK_ContaCorrente_Quitacao_IDContaCorrente] FOREIGN KEY([IDContaCorrente])
REFERENCES [dbo].[Fin_ContaCorrente] ([IDContaCorrente])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Quitacao] CHECK CONSTRAINT [FK_ContaCorrente_Quitacao_IDContaCorrente]
GO
ALTER TABLE [dbo].[Fin_Quitacao]  WITH NOCHECK ADD  CONSTRAINT [FK_MeioPag_Quitacao_IDQuitacaoMeio] FOREIGN KEY([IDQuitacaoMeio])
REFERENCES [dbo].[MeioPag] ([IDMeioPag])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Quitacao] CHECK CONSTRAINT [FK_MeioPag_Quitacao_IDQuitacaoMeio]
GO
ALTER TABLE [dbo].[Fin_Quitacao]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Fin_Quitacao_IDUsuarioQuitacao] FOREIGN KEY([IDUsuarioQuitacao])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Fin_Quitacao] CHECK CONSTRAINT [FK_SystemUser_Fin_Quitacao_IDUsuarioQuitacao]
GO
ALTER TABLE [dbo].[Fin_Quitacao]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Quitacao_IDUsuarioReconciliacao] FOREIGN KEY([IDUsuarioReconciliacao])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Quitacao] CHECK CONSTRAINT [FK_SystemUser_Quitacao_IDUsuarioReconciliacao]
GO
ALTER TABLE [dbo].[Fin_Quitacao]  WITH NOCHECK ADD  CONSTRAINT [FK_Transferencia_Quitacao_IDTransferencia] FOREIGN KEY([IDTransferencia])
REFERENCES [dbo].[Fin_Transferencia] ([IDTransferencia])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Quitacao] CHECK CONSTRAINT [FK_Transferencia_Quitacao_IDTransferencia]
GO
