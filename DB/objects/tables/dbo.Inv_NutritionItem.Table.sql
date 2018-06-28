USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_NutritionItem]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_NutritionItem](
	[IDNutritionItem] [int] NOT NULL,
	[IDNutrition] [int] NOT NULL,
	[Description] [varchar](100) NULL,
	[FieldLength] [int] NULL,
	[FieldPos] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_NutritionItem] PRIMARY KEY CLUSTERED 
(
	[IDNutritionItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_NutritionItem]  WITH CHECK ADD  CONSTRAINT [FK_Inv_Nutrition_Inv_NutritionItem_IDNutrition] FOREIGN KEY([IDNutrition])
REFERENCES [dbo].[Inv_Nutrition] ([IDNutrition])
GO
ALTER TABLE [dbo].[Inv_NutritionItem] CHECK CONSTRAINT [FK_Inv_Nutrition_Inv_NutritionItem_IDNutrition]
GO
