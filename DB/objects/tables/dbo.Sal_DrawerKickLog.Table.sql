USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_DrawerKickLog]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_DrawerKickLog](
	[IDDrawerKickLog] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[IDCashRegister] [int] NOT NULL,
	[MovDate] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_DrawerKickLog] PRIMARY KEY CLUSTERED 
(
	[IDDrawerKickLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_DrawerKickLog]  WITH CHECK ADD  CONSTRAINT [FK_CashRegister_SalDrawerKickLog_IDCashRegister] FOREIGN KEY([IDCashRegister])
REFERENCES [dbo].[CashRegister] ([IDCashRegister])
GO
ALTER TABLE [dbo].[Sal_DrawerKickLog] CHECK CONSTRAINT [FK_CashRegister_SalDrawerKickLog_IDCashRegister]
GO
ALTER TABLE [dbo].[Sal_DrawerKickLog]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_SalDrawerKickLog_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sal_DrawerKickLog] CHECK CONSTRAINT [FK_SystemUser_SalDrawerKickLog_IDUser]
GO
