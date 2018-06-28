USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_NotasCanceladas]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_NotasCanceladas](
	[IDNotasCanceladas] [int] NOT NULL,
	[IDPessoa] [int] NULL,
	[IDUser] [int] NOT NULL,
	[Cliente] [varchar](40) NULL,
	[CPFCGC] [varchar](20) NULL,
	[COO] [int] NULL,
	[CCF] [int] NULL,
	[DataNota] [datetime] NULL,
	[SubTotal] [money] NULL,
	[Desconto] [money] NULL,
	[Acrescimo] [int] NULL,
	[TipoAcrescimo] [char](1) NULL,
	[TipoDesconto] [char](1) NULL,
	[IDCashRegMov] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_NotasCanceladas] PRIMARY KEY CLUSTERED 
(
	[IDNotasCanceladas] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_NotasCanceladas]  WITH CHECK ADD  CONSTRAINT [FK_CashRegMov_Sal_NotasCanceladas_IDCashRegMov] FOREIGN KEY([IDCashRegMov])
REFERENCES [dbo].[CashRegMov] ([IDCashRegMov])
GO
ALTER TABLE [dbo].[Sal_NotasCanceladas] CHECK CONSTRAINT [FK_CashRegMov_Sal_NotasCanceladas_IDCashRegMov]
GO
ALTER TABLE [dbo].[Sal_NotasCanceladas]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_Sal_NotasCanceladas_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sal_NotasCanceladas] CHECK CONSTRAINT [FK_Pessoa_Sal_NotasCanceladas_IDPessoa]
GO
ALTER TABLE [dbo].[Sal_NotasCanceladas]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Sal_NotasCanceladas_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sal_NotasCanceladas] CHECK CONSTRAINT [FK_SystemUser_Sal_NotasCanceladas_IDUser]
GO
