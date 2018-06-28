USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_DesdobramentoTipo]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_DesdobramentoTipo](
	[IDDesdobramentoTipo] [int] NOT NULL,
	[IDDocumentoTipo] [int] NOT NULL,
	[DesdobramentoTipo] [dbo].[TDescricao] NOT NULL,
	[CodigoDesdobramentoTipo] [dbo].[TCodigoGeral] NOT NULL,
	[IdentificadorDesdobramento] [dbo].[TCodigoGeral] NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[ObrigaNumeroDesdobramento] [dbo].[TBit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_Desdobrament__18EBB532] PRIMARY KEY CLUSTERED 
(
	[IDDesdobramentoTipo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Fin_DesdobramentoTipo]  WITH NOCHECK ADD  CONSTRAINT [FK_DocumentoTipo_DesdobramentoTipo_IDDocumentoTipo] FOREIGN KEY([IDDocumentoTipo])
REFERENCES [dbo].[Fin_DocumentoTipo] ([IDDocumentoTipo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_DesdobramentoTipo] CHECK CONSTRAINT [FK_DocumentoTipo_DesdobramentoTipo_IDDocumentoTipo]
GO
