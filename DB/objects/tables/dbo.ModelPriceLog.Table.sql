USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ModelPriceLog]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModelPriceLog](
	[IDModelPriceLog] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[IDStore] [int] NULL,
	[ChangeDate] [datetime] NULL,
	[OldCostPrice] [money] NULL,
	[NewCostPrice] [money] NULL,
	[OldSalePrice] [money] NULL,
	[NewSalePrice] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKModelPriceLog] PRIMARY KEY CLUSTERED 
(
	[IDModelPriceLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ModelPriceLog]  WITH CHECK ADD  CONSTRAINT [FK_Model_ModelPriceLog_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[ModelPriceLog] CHECK CONSTRAINT [FK_Model_ModelPriceLog_IDModel]
GO
ALTER TABLE [dbo].[ModelPriceLog]  WITH CHECK ADD  CONSTRAINT [FK_Store_ModelPriceLog_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[ModelPriceLog] CHECK CONSTRAINT [FK_Store_ModelPriceLog_IDStore]
GO
ALTER TABLE [dbo].[ModelPriceLog]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_ModelPriceLog_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[ModelPriceLog] CHECK CONSTRAINT [FK_SystemUser_ModelPriceLog_IDUser]
GO
