USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_DiscountEntries]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_DiscountEntries](
	[IDSal_DiscountEntry] [int] NOT NULL,
	[IDSal_Discount] [int] NOT NULL,
	[IDModel] [int] NULL,
	[RewardAmount] [money] NULL,
	[AmountType] [varchar](100) NOT NULL,
	[RewardQuantity] [int] NULL,
	[MinQuantity] [int] NULL,
	[MinDollarAmount] [money] NULL,
	[IsInclude] [dbo].[Boolean] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDSal_DiscountEntry] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_DiscountEntries]  WITH CHECK ADD FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Sal_DiscountEntries]  WITH CHECK ADD FOREIGN KEY([IDSal_Discount])
REFERENCES [dbo].[Sal_Discounts] ([IDSal_Discount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Sal_DiscountEntries] ADD  DEFAULT ('Percent Off') FOR [AmountType]
GO
ALTER TABLE [dbo].[Sal_DiscountEntries] ADD  DEFAULT ((1)) FOR [IsInclude]
GO
