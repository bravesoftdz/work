USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_ModelStoreBalance]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_ModelStoreBalance](
	[IDStore] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[BalanceDate] [datetime] NOT NULL,
	[Qty] [float] NOT NULL,
	[AvgCostOut] [money] NOT NULL,
	[BalanceTotal] [money] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_ModelStoreBalance] PRIMARY KEY CLUSTERED 
(
	[IDStore] ASC,
	[IDModel] ASC,
	[BalanceDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_ModelStoreBalance]  WITH CHECK ADD  CONSTRAINT [FK_Model_InvModelStoreBalance_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Inv_ModelStoreBalance] CHECK CONSTRAINT [FK_Model_InvModelStoreBalance_IDModel]
GO
ALTER TABLE [dbo].[Inv_ModelStoreBalance]  WITH CHECK ADD  CONSTRAINT [FK_Store_InvModelStoreBalance_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Inv_ModelStoreBalance] CHECK CONSTRAINT [FK_Store_InvModelStoreBalance_IDStore]
GO
