USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_Promo]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_Promo](
	[IDPromo] [int] NOT NULL,
	[Barcode] [varchar](20) NULL,
	[Promo] [varchar](35) NOT NULL,
	[PromoType] [int] NOT NULL,
	[QtyFrequent] [float] NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[DaysOfWeek] [varchar](14) NULL,
	[DiscountType] [int] NOT NULL,
	[DiscountValue] [float] NOT NULL,
	[QtyPromoItem] [float] NULL,
	[System] [dbo].[Boolean] NULL,
	[Hidden] [dbo].[Boolean] NULL,
	[Desativado] [dbo].[Boolean] NULL,
	[IDStore] [int] NULL,
	[FlatPromo] [dbo].[Boolean] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_Promo] PRIMARY KEY CLUSTERED 
(
	[IDPromo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_Promo]  WITH CHECK ADD  CONSTRAINT [R_189] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Sal_Promo] CHECK CONSTRAINT [R_189]
GO
ALTER TABLE [dbo].[Sal_Promo] ADD  CONSTRAINT [DF_Zero2489]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Sal_Promo] ADD  CONSTRAINT [DF_Zero2490]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Sal_Promo] ADD  CONSTRAINT [DF_Zero2491]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Sal_Promo] ADD  CONSTRAINT [DF_SalPromo_FlatPromo_One]  DEFAULT ((1)) FOR [FlatPromo]
GO
