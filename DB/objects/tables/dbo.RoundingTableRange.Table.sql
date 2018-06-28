USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[RoundingTableRange]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RoundingTableRange](
	[IDRoundingTableRange] [int] NOT NULL,
	[MinValue] [money] NULL,
	[IDRoundingTable] [int] NULL,
	[RoundType] [int] NULL,
	[MaxValue] [money] NULL,
	[RoundValues] [varchar](100) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKRoundingTableRange] PRIMARY KEY CLUSTERED 
(
	[IDRoundingTableRange] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[RoundingTableRange]  WITH CHECK ADD  CONSTRAINT [FK_RoundingTable_RoundingTableRange_IDRoundingTable] FOREIGN KEY([IDRoundingTable])
REFERENCES [dbo].[RoundingTable] ([IDRoundingTable])
GO
ALTER TABLE [dbo].[RoundingTableRange] CHECK CONSTRAINT [FK_RoundingTable_RoundingTableRange_IDRoundingTable]
GO
