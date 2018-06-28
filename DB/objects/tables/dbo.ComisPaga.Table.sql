USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ComisPaga]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComisPaga](
	[IDDocumento] [int] NOT NULL,
	[IDPessoa] [int] NOT NULL,
	[IDLancPag] [int] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDDocumento] ASC,
	[IDPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ComisPaga]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_ComisPaga_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[ComisPaga] CHECK CONSTRAINT [FK_Pessoa_ComisPaga_IDPessoa]
GO
