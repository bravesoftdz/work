USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CashRegister]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashRegister](
	[IDCashRegister] [int] NOT NULL,
	[Name] [varchar](15) NOT NULL,
	[IsAssociated] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[System] [bit] NULL,
	[IsOpen] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_CashRegister_IDCashRegister] PRIMARY KEY CLUSTERED 
(
	[IDCashRegister] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CashRegister] ADD  CONSTRAINT [DF_Zero69]  DEFAULT (0) FOR [IsAssociated]
GO
ALTER TABLE [dbo].[CashRegister] ADD  CONSTRAINT [DF_Zero70]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[CashRegister] ADD  CONSTRAINT [DF_Zero71]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[CashRegister] ADD  CONSTRAINT [DF_Zero72]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[CashRegister] ADD  DEFAULT (NULL) FOR [IsOpen]
GO
