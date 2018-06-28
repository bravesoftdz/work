USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Media]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Media](
	[IDMedia] [int] NOT NULL,
	[IDOtherCommission] [int] NULL,
	[Media] [varchar](255) NOT NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[TaxMode] [int] NULL,
	[PayComission] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_Media_1__21] PRIMARY KEY CLUSTERED 
(
	[IDMedia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Media] ADD  CONSTRAINT [DF_Zero82]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Media] ADD  CONSTRAINT [DF_Zero83]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Media] ADD  CONSTRAINT [DF_Zero84]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Media] ADD  CONSTRAINT [DF_Media_Pay001]  DEFAULT (1) FOR [PayComission]
GO
