USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_Transferencia]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fin_Transferencia](
	[IDTransferencia] [int] NOT NULL,
	[IDContaCorrenteCredito] [int] NULL,
	[IDContaCorrenteDebito] [int] NULL,
	[IDUsuario] [int] NOT NULL,
	[Data] [datetime] NULL,
	[Valor] [dbo].[TValor] NULL,
	[Obs] [text] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_Transferenci__0B5CAFEA] PRIMARY KEY CLUSTERED 
(
	[IDTransferencia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Fin_Transferencia]  WITH NOCHECK ADD  CONSTRAINT [FK_ContaCorrente_Transferencia_IDContaCorrenteCredito] FOREIGN KEY([IDContaCorrenteCredito])
REFERENCES [dbo].[Fin_ContaCorrente] ([IDContaCorrente])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Transferencia] CHECK CONSTRAINT [FK_ContaCorrente_Transferencia_IDContaCorrenteCredito]
GO
ALTER TABLE [dbo].[Fin_Transferencia]  WITH NOCHECK ADD  CONSTRAINT [FK_ContaCorrente_Transferencia_IDContaCorrenteDebito] FOREIGN KEY([IDContaCorrenteDebito])
REFERENCES [dbo].[Fin_ContaCorrente] ([IDContaCorrente])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Transferencia] CHECK CONSTRAINT [FK_ContaCorrente_Transferencia_IDContaCorrenteDebito]
GO
ALTER TABLE [dbo].[Fin_Transferencia]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Transferencia_IDUsuario] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_Transferencia] CHECK CONSTRAINT [FK_SystemUser_Transferencia_IDUsuario]
GO
