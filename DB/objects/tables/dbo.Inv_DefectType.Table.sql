USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_DefectType]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_DefectType](
	[IDDefectType] [int] NOT NULL,
	[DefectType] [varchar](30) NOT NULL,
	[System] [dbo].[Boolean] NULL,
	[Hidden] [dbo].[Boolean] NULL,
	[Desativado] [dbo].[Boolean] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_DefectType] PRIMARY KEY CLUSTERED 
(
	[IDDefectType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_DefectType] ADD  CONSTRAINT [DF_Zero_Inv_DefectType_System]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Inv_DefectType] ADD  CONSTRAINT [DF_Zero_Inv_DefectType_Hidden]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Inv_DefectType] ADD  CONSTRAINT [DF_Zero_Inv_DefectType_Desativado]  DEFAULT (0) FOR [Desativado]
GO
