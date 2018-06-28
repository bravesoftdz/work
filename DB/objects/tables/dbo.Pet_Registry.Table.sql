USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_Registry]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_Registry](
	[IDRegistry] [int] NOT NULL,
	[Registry] [varchar](50) NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_Registry] PRIMARY KEY CLUSTERED 
(
	[IDRegistry] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_Registry] ADD  CONSTRAINT [DF_Zero3361]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Pet_Registry] ADD  CONSTRAINT [DF_Zero3362]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Pet_Registry] ADD  CONSTRAINT [DF_Zero3363]  DEFAULT (0) FOR [Desativado]
GO
