USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_Feriado]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_Feriado](
	[IDFeriado] [int] NOT NULL,
	[Feriado] [dbo].[TDescricao] NULL,
	[Data] [datetime] NULL,
	[Hidden] [dbo].[TBit] NULL,
	[Desativado] [dbo].[TBit] NULL,
	[System] [dbo].[TBit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Sis_Feriado__5D60DB10] PRIMARY KEY CLUSTERED 
(
	[IDFeriado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
