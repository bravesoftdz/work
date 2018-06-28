USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[PessoaTerm]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PessoaTerm](
	[IDPessoa] [int] NOT NULL,
	[DueDateShift] [int] NOT NULL,
	[Discount] [money] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPessoaTerm] PRIMARY KEY CLUSTERED 
(
	[IDPessoa] ASC,
	[DueDateShift] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PessoaTerm]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_PessoaTerm_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[PessoaTerm] CHECK CONSTRAINT [FK_Pessoa_PessoaTerm_IDPessoa]
GO
