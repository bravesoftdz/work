USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[GroupCost]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupCost](
	[IDCost] [int] NOT NULL,
	[IDTouristGroup] [int] NOT NULL,
	[IDCostType] [int] NOT NULL,
	[IDInventoryMov] [int] NULL,
	[CostDate] [smalldatetime] NOT NULL,
	[UnitCost] [money] NOT NULL,
	[Quantity] [float] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__GroupCost__690797E6] PRIMARY KEY CLUSTERED 
(
	[IDCost] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GroupCost]  WITH NOCHECK ADD  CONSTRAINT [FK_CostType_GroupCost_IDCostType] FOREIGN KEY([IDCostType])
REFERENCES [dbo].[CostType] ([IDCostType])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[GroupCost] CHECK CONSTRAINT [FK_CostType_GroupCost_IDCostType]
GO
ALTER TABLE [dbo].[GroupCost]  WITH NOCHECK ADD  CONSTRAINT [FK_InventoryMov_GroupCost_IDInventoryMov] FOREIGN KEY([IDInventoryMov])
REFERENCES [dbo].[InventoryMov] ([IDInventoryMov])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[GroupCost] CHECK CONSTRAINT [FK_InventoryMov_GroupCost_IDInventoryMov]
GO
ALTER TABLE [dbo].[GroupCost]  WITH NOCHECK ADD  CONSTRAINT [FK_TouristGroup_GroupCost_IDTourisGroup] FOREIGN KEY([IDTouristGroup])
REFERENCES [dbo].[TouristGroup] ([IDTouristGroup])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[GroupCost] CHECK CONSTRAINT [FK_TouristGroup_GroupCost_IDTourisGroup]
GO
ALTER TABLE [dbo].[GroupCost] ADD  CONSTRAINT [DF_GetDate2]  DEFAULT (getdate()) FOR [CostDate]
GO
ALTER TABLE [dbo].[GroupCost] ADD  CONSTRAINT [DF_Zero120]  DEFAULT (0) FOR [Quantity]
GO
