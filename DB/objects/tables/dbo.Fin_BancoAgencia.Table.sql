USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_BancoAgencia]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_BancoAgencia](
	[IDBancoAgencia] [int] NOT NULL,
	[CodigoBancoAgencia] [dbo].[TCodigoGeral] NOT NULL,
	[BancoAgencia] [dbo].[TDescricao] NOT NULL,
	[IDBanco] [int] NOT NULL,
	[Endereco] [dbo].[TEndereco] NULL,
	[Bairro] [dbo].[TBairro] NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_BancoAgencia__7E37BEF6] PRIMARY KEY CLUSTERED 
(
	[IDBancoAgencia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Fin_BancoAgencia]  WITH NOCHECK ADD  CONSTRAINT [FK_Banco_BancoAgencia_IDBanco] FOREIGN KEY([IDBanco])
REFERENCES [dbo].[Fin_Banco] ([IDBanco])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_BancoAgencia] CHECK CONSTRAINT [FK_Banco_BancoAgencia_IDBanco]
GO
