USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[PessoaValidation]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PessoaValidation](
	[IDPessoaValidation] [int] NOT NULL,
	[IDTipoPessoa] [int] NOT NULL,
	[PessoaField] [varchar](40) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPessoaValidation] PRIMARY KEY CLUSTERED 
(
	[IDPessoaValidation] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PessoaValidation]  WITH CHECK ADD  CONSTRAINT [FK_TipoPessoa_PessoaValidation_IDTipoPessoaFilho] FOREIGN KEY([IDTipoPessoa])
REFERENCES [dbo].[TipoPessoa] ([IDTipoPessoa])
GO
ALTER TABLE [dbo].[PessoaValidation] CHECK CONSTRAINT [FK_TipoPessoa_PessoaValidation_IDTipoPessoaFilho]
GO
