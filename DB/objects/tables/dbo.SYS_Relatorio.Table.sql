USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[SYS_Relatorio]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SYS_Relatorio](
	[IDRelatorio] [int] NOT NULL,
	[IDMenu] [int] NULL,
	[Relatorio] [varchar](50) NOT NULL,
	[Descricao] [varchar](255) NULL,
	[CreateIndex] [int] NOT NULL,
	[OrderClause] [varchar](50) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_SYS_Relatorio_1__14] PRIMARY KEY CLUSTERED 
(
	[IDRelatorio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[SYS_Relatorio]  WITH NOCHECK ADD  CONSTRAINT [FK_MenuMain_SYSRelatorio_IDMenu] FOREIGN KEY([IDMenu])
REFERENCES [dbo].[MenuMain] ([IDMenu])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[SYS_Relatorio] CHECK CONSTRAINT [FK_MenuMain_SYSRelatorio_IDMenu]
GO
