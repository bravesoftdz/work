USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_Departamento]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_Departamento](
	[IDDepartamento] [int] NOT NULL,
	[IDEmpresa] [int] NULL,
	[CodigoDepartamento] [dbo].[TCodigoGeral] NOT NULL,
	[Departamento] [dbo].[TDescricao] NOT NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Sis_Departamento__1E3A7A34] PRIMARY KEY NONCLUSTERED 
(
	[IDDepartamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_Departamento]  WITH NOCHECK ADD  CONSTRAINT [FK_SisEmpresa_SisDepartamento_IDEmpresa] FOREIGN KEY([IDEmpresa])
REFERENCES [dbo].[Sis_Empresa] ([IDEmpresa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_Departamento] CHECK CONSTRAINT [FK_SisEmpresa_SisDepartamento_IDEmpresa]
GO
