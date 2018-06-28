USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_LancamentoComplement]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fin_LancamentoComplement](
	[IDLancamento] [int] NOT NULL,
	[COO] [int] NULL,
	[GNF] [int] NULL,
	[CDC] [int] NULL,
	[DataEmissao] [datetime] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKFin_LancamentoComplement] PRIMARY KEY CLUSTERED 
(
	[IDLancamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Fin_LancamentoComplement]  WITH CHECK ADD  CONSTRAINT [FK_Fin_Lancamento_Fin_LancamentoComplement_IDLancamento] FOREIGN KEY([IDLancamento])
REFERENCES [dbo].[Fin_Lancamento] ([IDLancamento])
GO
ALTER TABLE [dbo].[Fin_LancamentoComplement] CHECK CONSTRAINT [FK_Fin_Lancamento_Fin_LancamentoComplement_IDLancamento]
GO
