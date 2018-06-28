USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InvResetHistory]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvResetHistory](
	[ResetDate] [datetime] NOT NULL,
	[IDStore] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[Qty] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInvResetHistory] PRIMARY KEY CLUSTERED 
(
	[ResetDate] ASC,
	[IDStore] ASC,
	[IDModel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InvResetHistory]  WITH NOCHECK ADD  CONSTRAINT [FK_Inventory_InvResetHistory_IDStoreIDModel] FOREIGN KEY([IDStore], [IDModel])
REFERENCES [dbo].[Inventory] ([StoreID], [ModelID])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[InvResetHistory] CHECK CONSTRAINT [FK_Inventory_InvResetHistory_IDStoreIDModel]
GO
