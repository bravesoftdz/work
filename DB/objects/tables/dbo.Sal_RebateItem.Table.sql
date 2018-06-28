USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_RebateItem]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_RebateItem](
	[IDRebateItem] [int] NOT NULL,
	[IDModel] [int] NULL,
	[IDStore] [int] NULL,
	[DiscountPerc] [float] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_RebateItem] PRIMARY KEY CLUSTERED 
(
	[IDRebateItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_RebateItem]  WITH CHECK ADD  CONSTRAINT [FK_Model_SalRebateItem_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Sal_RebateItem] CHECK CONSTRAINT [FK_Model_SalRebateItem_IDModel]
GO
ALTER TABLE [dbo].[Sal_RebateItem]  WITH CHECK ADD  CONSTRAINT [FK_Store_SalRebateItem_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Sal_RebateItem] CHECK CONSTRAINT [FK_Store_SalRebateItem_IDStore]
GO
