USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CashRegLogComplement]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashRegLogComplement](
	[IDCashRegLog] [int] NOT NULL,
	[Obs] [varchar](255) NOT NULL,
	[IDCashRegLogReason] [int] NULL,
	[COO] [int] NULL,
	[GNF] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKCashRegLogComplement] PRIMARY KEY CLUSTERED 
(
	[IDCashRegLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CashRegLogComplement]  WITH CHECK ADD  CONSTRAINT [FK_CashRegLog_CashRegLogComplement_IDCashRegLog] FOREIGN KEY([IDCashRegLog])
REFERENCES [dbo].[CashRegLog] ([IDCashRegLog])
GO
ALTER TABLE [dbo].[CashRegLogComplement] CHECK CONSTRAINT [FK_CashRegLog_CashRegLogComplement_IDCashRegLog]
GO
ALTER TABLE [dbo].[CashRegLogComplement]  WITH CHECK ADD  CONSTRAINT [FK_CashRegLogComplement_CashRegLogReason_IDCashRegLogReason] FOREIGN KEY([IDCashRegLogReason])
REFERENCES [dbo].[CashRegLogReason] ([IDCashRegLogReason])
GO
ALTER TABLE [dbo].[CashRegLogComplement] CHECK CONSTRAINT [FK_CashRegLogComplement_CashRegLogReason_IDCashRegLogReason]
GO
