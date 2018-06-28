USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_PotentialDiscounts]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_PotentialDiscounts](
	[IDPreInventoryMov] [int] NOT NULL,
	[DocumentID] [int] NOT NULL,
	[DiscountName] [varchar](max) NOT NULL,
	[IsStackable] [bit] NOT NULL,
	[IsPercentDiscount] [bit] NOT NULL,
	[DiscountAmount] [money] NOT NULL,
	[DiscountPercent] [numeric](5, 2) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_PotentialDiscounts]  WITH CHECK ADD FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
GO
