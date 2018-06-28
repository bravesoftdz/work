USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_CodigoIncremental]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_CodigoIncremental](
	[Tabela] [varchar](100) NOT NULL,
	[UltimoCodigo] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [Tabela] PRIMARY KEY CLUSTERED 
(
	[Tabela] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_CodigoIncremental]  WITH CHECK ADD  CONSTRAINT [MaxValue_Check] CHECK  (([UltimoCodigo]<=(100000000)))
GO
ALTER TABLE [dbo].[Sis_CodigoIncremental] CHECK CONSTRAINT [MaxValue_Check]
GO
