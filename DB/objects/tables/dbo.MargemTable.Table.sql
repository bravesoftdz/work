USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[MargemTable]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MargemTable](
	[IDMargemTable] [int] NOT NULL,
	[MargemTable] [varchar](30) NULL,
	[System] [bit] NOT NULL,
	[Hidden] [bit] NOT NULL,
	[Desativado] [bit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMargemTable] PRIMARY KEY CLUSTERED 
(
	[IDMargemTable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[MargemTable] ADD  CONSTRAINT [DF_Zero1386]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[MargemTable] ADD  CONSTRAINT [DF_Zero1387]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[MargemTable] ADD  CONSTRAINT [DF_Zero1388]  DEFAULT (0) FOR [Desativado]
GO
