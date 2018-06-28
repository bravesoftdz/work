USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CashRegMovPaymentLog]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashRegMovPaymentLog](
	[IDPaymentLog] [int] NOT NULL,
	[IDCashRegMov] [int] NOT NULL,
	[IDMeioPag] [int] NOT NULL,
	[IDBanco] [int] NOT NULL,
	[SaleCode] [varchar](20) NULL,
	[PreSaleDate] [datetime] NULL,
	[InvoiceTotal] [money] NULL,
	[CheckNumber] [varchar](20) NULL,
	[CustomerDocument] [varchar](20) NULL,
	[CustomerName] [varchar](80) NULL,
	[CustomerPhone] [varchar](20) NULL,
	[ValorNominal] [money] NULL,
	[DataVencimento] [datetime] NULL,
	[NumDesdobramento] [varchar](20) NULL,
	[IDPreSale] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKCashRegMovPaymentLog] PRIMARY KEY CLUSTERED 
(
	[IDPaymentLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CashRegMovPaymentLog]  WITH CHECK ADD  CONSTRAINT [FK_CashRegMov_CashRegMovPaymentLog_IDCashRegMov] FOREIGN KEY([IDCashRegMov])
REFERENCES [dbo].[CashRegMov] ([IDCashRegMov])
GO
ALTER TABLE [dbo].[CashRegMovPaymentLog] CHECK CONSTRAINT [FK_CashRegMov_CashRegMovPaymentLog_IDCashRegMov]
GO
ALTER TABLE [dbo].[CashRegMovPaymentLog]  WITH CHECK ADD  CONSTRAINT [FK_Fin_Banco_CashRegMovPaymentLog_IDBanco] FOREIGN KEY([IDBanco])
REFERENCES [dbo].[Fin_Banco] ([IDBanco])
GO
ALTER TABLE [dbo].[CashRegMovPaymentLog] CHECK CONSTRAINT [FK_Fin_Banco_CashRegMovPaymentLog_IDBanco]
GO
ALTER TABLE [dbo].[CashRegMovPaymentLog]  WITH CHECK ADD  CONSTRAINT [FK_MeioPag_CashRegMovPaymentLog_IDMeioPag] FOREIGN KEY([IDMeioPag])
REFERENCES [dbo].[MeioPag] ([IDMeioPag])
GO
ALTER TABLE [dbo].[CashRegMovPaymentLog] CHECK CONSTRAINT [FK_MeioPag_CashRegMovPaymentLog_IDMeioPag]
GO
