USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_DocumentoTipo]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_DocumentoTipo](
	[IDDocumentoTipo] [int] NOT NULL,
	[IDDesdobramentoTipoDefault] [int] NULL,
	[CodigoDocumentoTipo] [dbo].[TCodigoGeral] NOT NULL,
	[DocumentoTipo] [dbo].[TDescricao] NOT NULL,
	[Hidden] [dbo].[TBit] NULL,
	[PossuiDesdobramento] [dbo].[TBit] NULL,
	[DataEmissaoObrigatoria] [dbo].[TBit] NULL,
	[Desativado] [dbo].[TBit] NULL,
	[NumDocumentoObrigatorio] [dbo].[TBit] NULL,
	[System] [dbo].[TBit] NULL,
	[DesdobramentoObrigatorio] [dbo].[TBit] NULL,
	[IdentificadorDocumento] [dbo].[TCodigoGeral] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_DocumentoTip__17036CC0] PRIMARY KEY CLUSTERED 
(
	[IDDocumentoTipo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Fin_DocumentoTipo]  WITH NOCHECK ADD  CONSTRAINT [FK_DesdobramentoTipo_DocumentoTipo_IDDesdobramentoTipoDefault] FOREIGN KEY([IDDesdobramentoTipoDefault])
REFERENCES [dbo].[Fin_DesdobramentoTipo] ([IDDesdobramentoTipo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_DocumentoTipo] CHECK CONSTRAINT [FK_DesdobramentoTipo_DocumentoTipo_IDDesdobramentoTipoDefault]
GO
