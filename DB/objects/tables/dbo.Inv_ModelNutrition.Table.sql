USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_ModelNutrition]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_ModelNutrition](
	[IDModel] [int] NOT NULL,
	[IDNutritionItem] [int] NOT NULL,
	[QtyPortion] [decimal](38, 4) NULL,
	[VDPortion] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_ModelNutrition] PRIMARY KEY CLUSTERED 
(
	[IDModel] ASC,
	[IDNutritionItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_ModelNutrition]  WITH CHECK ADD  CONSTRAINT [FK_Inv_NutritionItem_Inv_ModelNutrition_IDNutritionItem] FOREIGN KEY([IDNutritionItem])
REFERENCES [dbo].[Inv_NutritionItem] ([IDNutritionItem])
GO
ALTER TABLE [dbo].[Inv_ModelNutrition] CHECK CONSTRAINT [FK_Inv_NutritionItem_Inv_ModelNutrition_IDNutritionItem]
GO
ALTER TABLE [dbo].[Inv_ModelNutrition]  WITH CHECK ADD  CONSTRAINT [FK_Model_Inv_ModelNutrition_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Inv_ModelNutrition] CHECK CONSTRAINT [FK_Model_Inv_ModelNutrition_IDModel]
GO
