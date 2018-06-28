USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_RebateDiscount]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_RebateDiscount](
	[IDPreSaleCreated] [int] NOT NULL,
	[DiscountValue] [money] NOT NULL,
	[ValidFromDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[IDPreSaleUsed] [int] NULL,
	[BonusCode] [varchar](20) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_RebateDiscount] PRIMARY KEY CLUSTERED 
(
	[IDPreSaleCreated] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_RebateDiscount]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_SalRebateDiscount_IDPreSaleCreated] FOREIGN KEY([IDPreSaleCreated])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[Sal_RebateDiscount] CHECK CONSTRAINT [FK_Invoice_SalRebateDiscount_IDPreSaleCreated]
GO
ALTER TABLE [dbo].[Sal_RebateDiscount]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_SalRebateDiscount_IDPreSaleUsed] FOREIGN KEY([IDPreSaleUsed])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[Sal_RebateDiscount] CHECK CONSTRAINT [FK_Invoice_SalRebateDiscount_IDPreSaleUsed]
GO
ALTER TABLE [dbo].[Sal_RebateDiscount] ADD  CONSTRAINT [Def_BonusCode]  DEFAULT (NULL) FOR [BonusCode]
GO
