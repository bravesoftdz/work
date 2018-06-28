USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Trajeto]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trajeto](
	[IDTrajeto] [int] NOT NULL,
	[Trajeto] [varchar](50) NOT NULL,
	[CustoMotorista] [money] NOT NULL,
	[CustoGasolina] [money] NOT NULL,
	[System] [bit] NULL,
	[Desativado] [int] NULL,
	[Hidden] [bit] NULL,
	[MinPax] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Trajeto__24285DB4] PRIMARY KEY CLUSTERED 
(
	[IDTrajeto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Trajeto] ADD  CONSTRAINT [DF_Zero136]  DEFAULT (0) FOR [CustoMotorista]
GO
ALTER TABLE [dbo].[Trajeto] ADD  CONSTRAINT [DF_Zero137]  DEFAULT (0) FOR [CustoGasolina]
GO
ALTER TABLE [dbo].[Trajeto] ADD  CONSTRAINT [DF_Zero138]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Trajeto] ADD  CONSTRAINT [DF_Zero139]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Trajeto] ADD  CONSTRAINT [DF_Zero140]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Trajeto] ADD  CONSTRAINT [DF_Trajeto_Enabled4]  DEFAULT (1) FOR [MinPax]
GO
