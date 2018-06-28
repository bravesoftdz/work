USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_PromoPrizeItem]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_PromoPrizeItem](
	[IDPromoPrizeItem] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[IDPromoItem] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_PromoPrizeItem] PRIMARY KEY CLUSTERED 
(
	[IDPromoPrizeItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_PromoPrizeItem]  WITH CHECK ADD  CONSTRAINT [FK_Model_SalPromoPrizeItem_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Sal_PromoPrizeItem] CHECK CONSTRAINT [FK_Model_SalPromoPrizeItem_IDModel]
GO
ALTER TABLE [dbo].[Sal_PromoPrizeItem]  WITH CHECK ADD  CONSTRAINT [FK_SalPromoItem_SalPromoPrizeItem_IDPromoItem] FOREIGN KEY([IDPromoItem])
REFERENCES [dbo].[Sal_PromoItem] ([IDPromoItem])
GO
ALTER TABLE [dbo].[Sal_PromoPrizeItem] CHECK CONSTRAINT [FK_SalPromoItem_SalPromoPrizeItem_IDPromoItem]
GO
