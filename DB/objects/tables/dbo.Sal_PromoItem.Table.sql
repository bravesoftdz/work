USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_PromoItem]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_PromoItem](
	[IDPromoItem] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[IDPromo] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_PromoItem] PRIMARY KEY CLUSTERED 
(
	[IDPromoItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_PromoItem]  WITH CHECK ADD  CONSTRAINT [FK_Model_SalPromoItem_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Sal_PromoItem] CHECK CONSTRAINT [FK_Model_SalPromoItem_IDModel]
GO
ALTER TABLE [dbo].[Sal_PromoItem]  WITH CHECK ADD  CONSTRAINT [R_193] FOREIGN KEY([IDPromo])
REFERENCES [dbo].[Sal_Promo] ([IDPromo])
GO
ALTER TABLE [dbo].[Sal_PromoItem] CHECK CONSTRAINT [R_193]
GO
