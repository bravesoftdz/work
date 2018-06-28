USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[HistoryType]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HistoryType](
	[IDHistoryType] [int] NOT NULL,
	[HistoryType] [varchar](255) NOT NULL,
	[System] [bit] NOT NULL,
	[Hidden] [bit] NOT NULL,
	[Desativado] [bit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKHistoryType] PRIMARY KEY CLUSTERED 
(
	[IDHistoryType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[HistoryType] ADD  CONSTRAINT [DF_HistoSystem]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[HistoryType] ADD  CONSTRAINT [DF_HistoHidden]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[HistoryType] ADD  CONSTRAINT [DF_HistoDesativ]  DEFAULT (0) FOR [Desativado]
GO
