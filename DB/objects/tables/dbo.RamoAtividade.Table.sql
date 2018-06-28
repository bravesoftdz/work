USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[RamoAtividade]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RamoAtividade](
	[IDRamoAtividade] [int] NOT NULL,
	[RamoAtividade] [varchar](50) NOT NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_2__12] PRIMARY KEY CLUSTERED 
(
	[IDRamoAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[RamoAtividade] ADD  CONSTRAINT [DF_Zero27]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[RamoAtividade] ADD  CONSTRAINT [DF_Zero28]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[RamoAtividade] ADD  CONSTRAINT [DF_Zero29]  DEFAULT (0) FOR [Hidden]
GO
