USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[GroupCostGift]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupCostGift](
	[IDGroupCostGift] [int] NOT NULL,
	[IDGroupCost] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[Desativado] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_GroupCostGift_1__12] PRIMARY KEY CLUSTERED 
(
	[IDGroupCostGift] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GroupCostGift]  WITH NOCHECK ADD  CONSTRAINT [FK_GroupCost_GroupCostGift_IDGroupCost] FOREIGN KEY([IDGroupCost])
REFERENCES [dbo].[GroupCost] ([IDCost])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[GroupCostGift] CHECK CONSTRAINT [FK_GroupCost_GroupCostGift_IDGroupCost]
GO
ALTER TABLE [dbo].[GroupCostGift]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_GroupCostGift_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[GroupCostGift] CHECK CONSTRAINT [FK_Model_GroupCostGift_IDModel]
GO
ALTER TABLE [dbo].[GroupCostGift]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_GroupCostGift_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[GroupCostGift] CHECK CONSTRAINT [FK_SystemUser_GroupCostGift_IDUser]
GO
