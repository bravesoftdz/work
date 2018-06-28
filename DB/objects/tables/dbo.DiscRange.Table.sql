USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[DiscRange]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscRange](
	[IDTipoComissionado] [int] NOT NULL,
	[TotVendaMin] [money] NOT NULL,
	[PercDiscMax] [money] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_DiscRange_1__14] PRIMARY KEY CLUSTERED 
(
	[IDTipoComissionado] ASC,
	[TotVendaMin] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DiscRange]  WITH NOCHECK ADD  CONSTRAINT [FK_TipoPessoa_DiscRange_IDTipoComissionado] FOREIGN KEY([IDTipoComissionado])
REFERENCES [dbo].[TipoPessoa] ([IDTipoPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[DiscRange] CHECK CONSTRAINT [FK_TipoPessoa_DiscRange_IDTipoComissionado]
GO
