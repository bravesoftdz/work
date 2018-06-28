USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_Banco]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_Banco](
	[IDBanco] [int] NOT NULL,
	[CodigoBanco] [dbo].[TCodigoGeral] NOT NULL,
	[Banco] [dbo].[TDescricao] NOT NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_Banco__7C4F7684] PRIMARY KEY CLUSTERED 
(
	[IDBanco] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
