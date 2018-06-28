USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[KitModel]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KitModel](
	[IDModel] [int] NOT NULL,
	[SellingPrice] [money] NOT NULL,
	[MarginPerc] [float] NOT NULL,
	[Qty] [decimal](38, 4) NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDModel] ASC,
	[Qty] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KitModel]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_KitModel_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[KitModel] CHECK CONSTRAINT [FK_Model_KitModel_IDModel]
GO
ALTER TABLE [dbo].[KitModel] ADD  DEFAULT (0) FOR [MarginPerc]
GO
ALTER TABLE [dbo].[KitModel] ADD  DEFAULT (0) FOR [Qty]
GO
