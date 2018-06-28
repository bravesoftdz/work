USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_ContaCorrenteSaldo]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fin_ContaCorrenteSaldo](
	[IDContaCorrente] [int] NOT NULL,
	[Data] [datetime] NOT NULL,
	[Saldo] [dbo].[TValor] NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDContaCorrente] ASC,
	[Data] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Fin_ContaCorrenteSaldo]  WITH NOCHECK ADD  CONSTRAINT [FK_ContaCorrente_ContaCorrenteSaldo_IDContaCorrente] FOREIGN KEY([IDContaCorrente])
REFERENCES [dbo].[Fin_ContaCorrente] ([IDContaCorrente])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_ContaCorrenteSaldo] CHECK CONSTRAINT [FK_ContaCorrente_ContaCorrenteSaldo_IDContaCorrente]
GO
ALTER TABLE [dbo].[Fin_ContaCorrenteSaldo] ADD  CONSTRAINT [DF_Zero124]  DEFAULT (0) FOR [Saldo]
GO
