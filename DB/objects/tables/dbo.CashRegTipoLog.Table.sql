USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CashRegTipoLog]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashRegTipoLog](
	[IDCashRegTipoLog] [int] NOT NULL,
	[CashRegTipoLog] [varchar](30) NOT NULL,
	[Entrando] [bit] NULL,
	[Movimenta] [bit] NULL,
	[PettyCash] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__CashRegTipoLog__4B7734FF] PRIMARY KEY CLUSTERED 
(
	[IDCashRegTipoLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
