USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_ModelDepartment]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_ModelDepartment](
	[StoreID] [int] NOT NULL,
	[ModelID] [int] NOT NULL,
	[IDDepartment] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_ModelDepartment] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC,
	[ModelID] ASC,
	[IDDepartment] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_ModelDepartment]  WITH CHECK ADD  CONSTRAINT [FK_InvDepartment_InvModelDepartment_IDDepartment] FOREIGN KEY([IDDepartment])
REFERENCES [dbo].[Inv_Department] ([IDDepartment])
GO
ALTER TABLE [dbo].[Inv_ModelDepartment] CHECK CONSTRAINT [FK_InvDepartment_InvModelDepartment_IDDepartment]
GO
ALTER TABLE [dbo].[Inv_ModelDepartment]  WITH CHECK ADD  CONSTRAINT [FK_Inventory_InvModelDepartment_IDStore_IDModel] FOREIGN KEY([StoreID], [ModelID])
REFERENCES [dbo].[Inventory] ([StoreID], [ModelID])
GO
ALTER TABLE [dbo].[Inv_ModelDepartment] CHECK CONSTRAINT [FK_Inventory_InvModelDepartment_IDStore_IDModel]
GO
