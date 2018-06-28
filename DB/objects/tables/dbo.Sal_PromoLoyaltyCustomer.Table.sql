USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_PromoLoyaltyCustomer]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_PromoLoyaltyCustomer](
	[IDPromo] [int] NOT NULL,
	[IDTipoPessoa] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_PromoLoyaltyCustomer] PRIMARY KEY CLUSTERED 
(
	[IDPromo] ASC,
	[IDTipoPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_PromoLoyaltyCustomer]  WITH CHECK ADD  CONSTRAINT [FK_Model_SalPromoLoyaltyCustomer_IDTipoPessoa] FOREIGN KEY([IDTipoPessoa])
REFERENCES [dbo].[TipoPessoa] ([IDTipoPessoa])
GO
ALTER TABLE [dbo].[Sal_PromoLoyaltyCustomer] CHECK CONSTRAINT [FK_Model_SalPromoLoyaltyCustomer_IDTipoPessoa]
GO
ALTER TABLE [dbo].[Sal_PromoLoyaltyCustomer]  WITH CHECK ADD  CONSTRAINT [R_194] FOREIGN KEY([IDPromo])
REFERENCES [dbo].[Sal_Promo] ([IDPromo])
GO
ALTER TABLE [dbo].[Sal_PromoLoyaltyCustomer] CHECK CONSTRAINT [R_194]
GO
