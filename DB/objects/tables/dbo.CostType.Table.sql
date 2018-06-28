USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CostType]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CostType](
	[IDCostType] [int] NOT NULL,
	[CostType] [varchar](50) NOT NULL,
	[DefaultValue] [money] NOT NULL,
	[Desativado] [int] NULL,
	[Hidden] [bit] NULL,
	[System] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_TipoCusto_4__10] PRIMARY KEY CLUSTERED 
(
	[IDCostType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[CostType] ADD  CONSTRAINT [DF_Zero109]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[CostType] ADD  CONSTRAINT [DF_Zero110]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[CostType] ADD  CONSTRAINT [DF_Zero111]  DEFAULT (0) FOR [System]
GO
