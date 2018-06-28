USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[SYS_RelParametro]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SYS_RelParametro](
	[IDRelParametro] [int] NOT NULL,
	[Panel] [varchar](30) NOT NULL,
	[Label] [varchar](30) NOT NULL,
	[ValorDefault] [varchar](30) NULL,
	[Campo] [varchar](30) NOT NULL,
	[Operador] [varchar](30) NOT NULL,
	[IDRelatorio] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__SYS_RelParametro__36470DEF] PRIMARY KEY CLUSTERED 
(
	[IDRelParametro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[SYS_RelParametro]  WITH NOCHECK ADD  CONSTRAINT [FK_SYSRelatorio_SYSRelParametro_IDRelatorio] FOREIGN KEY([IDRelatorio])
REFERENCES [dbo].[SYS_Relatorio] ([IDRelatorio])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[SYS_RelParametro] CHECK CONSTRAINT [FK_SYSRelatorio_SYSRelParametro_IDRelatorio]
GO
