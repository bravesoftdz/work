USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[MeioPagMinSale]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeioPagMinSale](
	[IDMeioPag] [int] NOT NULL,
	[DifDay] [int] NOT NULL,
	[TotalSale] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_MeioPagMinSale_DifDay] PRIMARY KEY CLUSTERED 
(
	[IDMeioPag] ASC,
	[DifDay] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MeioPagMinSale]  WITH NOCHECK ADD  CONSTRAINT [FK_MeioPag_MeioPagMinSale_IDMeioPag] FOREIGN KEY([IDMeioPag])
REFERENCES [dbo].[MeioPag] ([IDMeioPag])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[MeioPagMinSale] CHECK CONSTRAINT [FK_MeioPag_MeioPagMinSale_IDMeioPag]
GO
