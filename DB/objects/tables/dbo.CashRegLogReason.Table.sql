USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CashRegLogReason]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashRegLogReason](
	[IDCashRegLogReason] [int] NOT NULL,
	[Reason] [varchar](30) NOT NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKCashRegLogReason] PRIMARY KEY CLUSTERED 
(
	[IDCashRegLogReason] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CashRegLogReason] ADD  CONSTRAINT [DF_Zero_CashRegLogReason_System]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[CashRegLogReason] ADD  CONSTRAINT [DF_Zero_CashRegLogReason_Hidden]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[CashRegLogReason] ADD  CONSTRAINT [DF_Zero_CashRegLogReason_Desativado]  DEFAULT (0) FOR [Desativado]
GO
