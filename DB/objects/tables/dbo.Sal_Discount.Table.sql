USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_Discount]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_Discount](
	[IDDiscount] [int] NOT NULL,
	[IDPreSale] [int] NOT NULL,
	[IDPreInventoryMov] [int] NOT NULL,
	[Discount] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_Discount] PRIMARY KEY CLUSTERED 
(
	[IDDiscount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
