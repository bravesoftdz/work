USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_MoedaCotacao]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sis_MoedaCotacao](
	[IDMoedaCotacao] [int] NOT NULL,
	[IDMoeda] [int] NOT NULL,
	[DataCotacao] [datetime] NULL,
	[ValorMoedaPadrao] [dbo].[TValor] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Sis_MoedaCotacao__45BE5BA9] PRIMARY KEY CLUSTERED 
(
	[IDMoedaCotacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sis_MoedaCotacao]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMoeda_SisMoedaCotacao_IDMoeda] FOREIGN KEY([IDMoeda])
REFERENCES [dbo].[Sis_Moeda] ([IDMoeda])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_MoedaCotacao] CHECK CONSTRAINT [FK_SisMoeda_SisMoedaCotacao_IDMoeda]
GO
