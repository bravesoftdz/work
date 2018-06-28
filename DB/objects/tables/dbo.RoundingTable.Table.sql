USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[RoundingTable]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoundingTable](
	[IDRoundingTable] [int] NOT NULL,
	[RoundingTable] [varchar](30) NULL,
	[System] [bit] NOT NULL,
	[Hidden] [bit] NOT NULL,
	[Desativado] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKRoundingTable] PRIMARY KEY CLUSTERED 
(
	[IDRoundingTable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[RoundingTable] ADD  CONSTRAINT [DF_Zero1360]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[RoundingTable] ADD  CONSTRAINT [DF_Zero1361]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[RoundingTable] ADD  CONSTRAINT [DF_Zero1362]  DEFAULT (0) FOR [Desativado]
GO
