USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_FrequentPromo]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_FrequentPromo](
	[IDFrequentPromo] [int] NOT NULL,
	[IDPessoa] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[Qty] [decimal](38, 4) NULL,
	[IsUsed] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_FrequentPromo] PRIMARY KEY CLUSTERED 
(
	[IDFrequentPromo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_FrequentPromo]  WITH CHECK ADD  CONSTRAINT [FK_Model_Sal_FrequentPromo_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Sal_FrequentPromo] CHECK CONSTRAINT [FK_Model_Sal_FrequentPromo_IDModel]
GO
ALTER TABLE [dbo].[Sal_FrequentPromo]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_Sal_FrequentPromo_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sal_FrequentPromo] CHECK CONSTRAINT [FK_Pessoa_Sal_FrequentPromo_IDPessoa]
GO
ALTER TABLE [dbo].[Sal_FrequentPromo] ADD  CONSTRAINT [DF_Zero3841]  DEFAULT (0) FOR [IsUsed]
GO
