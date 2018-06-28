USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[MargemTableRange]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MargemTableRange](
	[IDMargemTableRange] [int] NOT NULL,
	[IDMargemTable] [int] NULL,
	[MinValue] [money] NULL,
	[MaxValue] [money] NULL,
	[Percentage] [float] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMargemTableRange] PRIMARY KEY CLUSTERED 
(
	[IDMargemTableRange] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MargemTableRange]  WITH CHECK ADD  CONSTRAINT [FK_MagemTable_MagemTableRange_IDMargemTable] FOREIGN KEY([IDMargemTable])
REFERENCES [dbo].[MargemTable] ([IDMargemTable])
GO
ALTER TABLE [dbo].[MargemTableRange] CHECK CONSTRAINT [FK_MagemTable_MagemTableRange_IDMargemTable]
GO
