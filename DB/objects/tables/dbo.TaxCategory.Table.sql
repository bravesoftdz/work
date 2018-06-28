USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[TaxCategory]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaxCategory](
	[IDTaxCategory] [int] NOT NULL,
	[TaxCategory] [varchar](50) NOT NULL,
	[Tax] [money] NOT NULL,
	[SpecialDateStart] [smalldatetime] NULL,
	[SpecialDateEnd] [smalldatetime] NULL,
	[SpecialTax] [money] NULL,
	[TaxExempt] [bit] NULL,
	[MaxItemValue] [money] NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[IDTaxCategoryParent] [int] NOT NULL,
	[Debit] [bit] NULL,
	[OperationType] [int] NULL,
	[SaleTaxType] [int] NULL,
	[Formula] [varchar](255) NULL,
	[IDLancamentoTipo] [int] NULL,
	[ECFTaxIndex] [varchar](2) NULL,
	[SituacaoTributaria] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__TaxCategory__477199F1] PRIMARY KEY CLUSTERED 
(
	[IDTaxCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TaxCategory]  WITH CHECK ADD  CONSTRAINT [FK_Fin_LancamentoTipo_TaxCategory_IDLancamentoTipo] FOREIGN KEY([IDLancamentoTipo])
REFERENCES [dbo].[Fin_LancamentoTipo] ([IDLancamentoTipo])
GO
ALTER TABLE [dbo].[TaxCategory] CHECK CONSTRAINT [FK_Fin_LancamentoTipo_TaxCategory_IDLancamentoTipo]
GO
ALTER TABLE [dbo].[TaxCategory]  WITH CHECK ADD  CONSTRAINT [FK_TaxCategoryParent_TaxCategoryParent_IDTaxCategoryParent] FOREIGN KEY([IDTaxCategoryParent])
REFERENCES [dbo].[TaxCategory] ([IDTaxCategory])
GO
ALTER TABLE [dbo].[TaxCategory] CHECK CONSTRAINT [FK_TaxCategoryParent_TaxCategoryParent_IDTaxCategoryParent]
GO
ALTER TABLE [dbo].[TaxCategory] ADD  CONSTRAINT [DF_Zero143]  DEFAULT (0) FOR [TaxExempt]
GO
ALTER TABLE [dbo].[TaxCategory] ADD  CONSTRAINT [DF_Zero144]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[TaxCategory] ADD  CONSTRAINT [DF_Zero145]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[TaxCategory] ADD  CONSTRAINT [DF_Zero146]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[TaxCategory] ADD  CONSTRAINT [DF_Zero733]  DEFAULT (0) FOR [IDTaxCategoryParent]
GO
