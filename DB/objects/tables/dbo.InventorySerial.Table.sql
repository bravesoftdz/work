USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InventorySerial]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InventorySerial](
	[StoreID] [int] NOT NULL,
	[ModelID] [int] NOT NULL,
	[Serial] [varchar](30) NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInventorySerial] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC,
	[ModelID] ASC,
	[Serial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[InventorySerial]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_InventorySerial_IDModel] FOREIGN KEY([ModelID])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[InventorySerial] CHECK CONSTRAINT [FK_Model_InventorySerial_IDModel]
GO
ALTER TABLE [dbo].[InventorySerial]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_InventorySerial_IDStore] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[InventorySerial] CHECK CONSTRAINT [FK_Store_InventorySerial_IDStore]
GO
