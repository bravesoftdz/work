USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CashRegMov]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashRegMov](
	[IDCashRegMov] [int] NOT NULL,
	[IDCashRegister] [int] NOT NULL,
	[IDOpenUser] [int] NOT NULL,
	[IDCashRegStatus] [int] NOT NULL,
	[OpenTime] [smalldatetime] NOT NULL,
	[TotalDeposit] [money] NULL,
	[TotalSales] [money] NULL,
	[TotalWidraw] [money] NULL,
	[OpenDeposit] [money] NULL,
	[FinalWidraw] [money] NULL,
	[TotalSaleCash] [money] NULL,
	[TotalPetty] [money] NULL,
	[FinalCount] [money] NULL,
	[ManagerCount] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_CashRegMov_IDCashRegMov] PRIMARY KEY NONCLUSTERED 
(
	[IDCashRegMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CashRegMov]  WITH NOCHECK ADD  CONSTRAINT [FK_CashReg_CashRegMov_IDCashRegister] FOREIGN KEY([IDCashRegister])
REFERENCES [dbo].[CashRegister] ([IDCashRegister])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CashRegMov] CHECK CONSTRAINT [FK_CashReg_CashRegMov_IDCashRegister]
GO
ALTER TABLE [dbo].[CashRegMov]  WITH NOCHECK ADD  CONSTRAINT [FK_CashRegStatus_CashRegMov_IDCashRegStatus] FOREIGN KEY([IDCashRegStatus])
REFERENCES [dbo].[CashRegStatus] ([IDCashRegStatus])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CashRegMov] CHECK CONSTRAINT [FK_CashRegStatus_CashRegMov_IDCashRegStatus]
GO
ALTER TABLE [dbo].[CashRegMov]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_CashRegMov_IDOpenUser] FOREIGN KEY([IDOpenUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CashRegMov] CHECK CONSTRAINT [FK_SystemUser_CashRegMov_IDOpenUser]
GO
ALTER TABLE [dbo].[CashRegMov] ADD  CONSTRAINT [DF_Zero73]  DEFAULT (0) FOR [TotalDeposit]
GO
ALTER TABLE [dbo].[CashRegMov] ADD  CONSTRAINT [DF_Zero74]  DEFAULT (0) FOR [TotalSales]
GO
ALTER TABLE [dbo].[CashRegMov] ADD  CONSTRAINT [DF_Zero75]  DEFAULT (0) FOR [TotalWidraw]
GO
ALTER TABLE [dbo].[CashRegMov] ADD  CONSTRAINT [DF_Zero76]  DEFAULT (0) FOR [OpenDeposit]
GO
ALTER TABLE [dbo].[CashRegMov] ADD  CONSTRAINT [DF_Zero77]  DEFAULT (0) FOR [FinalWidraw]
GO
ALTER TABLE [dbo].[CashRegMov] ADD  CONSTRAINT [DF_Zero78]  DEFAULT (0) FOR [TotalSaleCash]
GO
ALTER TABLE [dbo].[CashRegMov] ADD  CONSTRAINT [DF_Zero79]  DEFAULT (0) FOR [TotalPetty]
GO
ALTER TABLE [dbo].[CashRegMov] ADD  CONSTRAINT [DF_Zero80]  DEFAULT (0) FOR [FinalCount]
GO
ALTER TABLE [dbo].[CashRegMov] ADD  CONSTRAINT [DF_Zero81]  DEFAULT (0) FOR [ManagerCount]
GO
