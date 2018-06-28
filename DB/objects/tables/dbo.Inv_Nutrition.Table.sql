USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_Nutrition]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_Nutrition](
	[IDNutrition] [int] NOT NULL,
	[Description] [varchar](50) NULL,
	[Hidden] [dbo].[TBit] NULL,
	[Desativado] [dbo].[TBit] NULL,
	[System] [dbo].[TBit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_Nutrition] PRIMARY KEY CLUSTERED 
(
	[IDNutrition] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_Nutrition] ADD  CONSTRAINT [DEF_Bit1286]  DEFAULT ((0)) FOR [Hidden]
GO
ALTER TABLE [dbo].[Inv_Nutrition] ADD  CONSTRAINT [DEF_Bit1287]  DEFAULT ((0)) FOR [Desativado]
GO
ALTER TABLE [dbo].[Inv_Nutrition] ADD  CONSTRAINT [DEF_Bit1288]  DEFAULT ((0)) FOR [System]
GO
