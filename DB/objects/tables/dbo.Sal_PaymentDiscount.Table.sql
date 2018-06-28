USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_PaymentDiscount]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_PaymentDiscount](
	[IDPaymentDiscount] [int] NOT NULL,
	[IDMeioPag] [int] NULL,
	[DiscountPercent] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_PaymentDiscount] PRIMARY KEY CLUSTERED 
(
	[IDPaymentDiscount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_PaymentDiscount]  WITH CHECK ADD  CONSTRAINT [FK_MeioPag_Sal_PaymentDiscount_IDMeioPag] FOREIGN KEY([IDMeioPag])
REFERENCES [dbo].[MeioPag] ([IDMeioPag])
GO
ALTER TABLE [dbo].[Sal_PaymentDiscount] CHECK CONSTRAINT [FK_MeioPag_Sal_PaymentDiscount_IDMeioPag]
GO
