USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[EstimatedItem]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstimatedItem](
	[IDEstimatedItem] [int] NOT NULL,
	[IDEstimated] [int] NULL,
	[IDModel] [int] NULL,
	[SalePrice] [money] NOT NULL,
	[Code] [int] NULL,
	[Qty] [decimal](38, 4) NULL,
	[IDDepartment] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKEstimatedItem] PRIMARY KEY CLUSTERED 
(
	[IDEstimatedItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EstimatedItem]  WITH CHECK ADD  CONSTRAINT [FK_Estimated_EstimatedItem_IDEstimated] FOREIGN KEY([IDEstimated])
REFERENCES [dbo].[Estimated] ([IDEstimated])
GO
ALTER TABLE [dbo].[EstimatedItem] CHECK CONSTRAINT [FK_Estimated_EstimatedItem_IDEstimated]
GO
ALTER TABLE [dbo].[EstimatedItem]  WITH CHECK ADD  CONSTRAINT [FK_InvDepartment_EstimatedItem_IDDepartment] FOREIGN KEY([IDDepartment])
REFERENCES [dbo].[Inv_Department] ([IDDepartment])
GO
ALTER TABLE [dbo].[EstimatedItem] CHECK CONSTRAINT [FK_InvDepartment_EstimatedItem_IDDepartment]
GO
ALTER TABLE [dbo].[EstimatedItem]  WITH CHECK ADD  CONSTRAINT [FK_Model_EstimatedItem_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[EstimatedItem] CHECK CONSTRAINT [FK_Model_EstimatedItem_IDModel]
GO
