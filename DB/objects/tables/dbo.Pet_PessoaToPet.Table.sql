USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_PessoaToPet]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pet_PessoaToPet](
	[IDPessoa] [int] NOT NULL,
	[IDPet] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_PessoaToPet] PRIMARY KEY CLUSTERED 
(
	[IDPessoa] ASC,
	[IDPet] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pet_PessoaToPet]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_IDPessoa_Pet_PessoaToPet_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Pet_PessoaToPet] CHECK CONSTRAINT [FK_Pessoa_IDPessoa_Pet_PessoaToPet_IDPessoa]
GO
ALTER TABLE [dbo].[Pet_PessoaToPet]  WITH CHECK ADD  CONSTRAINT [FK_Pet_IDPet_Pet_PessoaToPet_IDPet] FOREIGN KEY([IDPet])
REFERENCES [dbo].[Pet] ([IDPet])
GO
ALTER TABLE [dbo].[Pet_PessoaToPet] CHECK CONSTRAINT [FK_Pet_IDPet_Pet_PessoaToPet_IDPet]
GO
