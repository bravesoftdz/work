USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_LancamentoTerm]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fin_LancamentoTerm](
	[IDLancamento] [int] NOT NULL,
	[DueDateShift] [int] NOT NULL,
	[Discount] [money] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKFin_LancamentoTerm] PRIMARY KEY CLUSTERED 
(
	[IDLancamento] ASC,
	[DueDateShift] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Fin_LancamentoTerm]  WITH NOCHECK ADD  CONSTRAINT [FK_Lancamento_LancamentoTerm_IDLancamento] FOREIGN KEY([IDLancamento])
REFERENCES [dbo].[Fin_Lancamento] ([IDLancamento])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_LancamentoTerm] CHECK CONSTRAINT [FK_Lancamento_LancamentoTerm_IDLancamento]
GO
