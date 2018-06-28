USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_PaymentCondition]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_PaymentCondition](
	[IDPaymentCondition] [int] NOT NULL,
	[IDEstimated] [int] NULL,
	[IDPreSale] [int] NULL,
	[IDMeioPag] [int] NULL,
	[Amount] [money] NULL,
	[OBS] [varchar](100) NULL,
	[EstimetedDate] [datetime] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_PaymentCondition] PRIMARY KEY CLUSTERED 
(
	[IDPaymentCondition] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_PaymentCondition]  WITH CHECK ADD  CONSTRAINT [FK_Estimated_Sal_PaymentCondition_IDEstimated] FOREIGN KEY([IDEstimated])
REFERENCES [dbo].[Estimated] ([IDEstimated])
GO
ALTER TABLE [dbo].[Sal_PaymentCondition] CHECK CONSTRAINT [FK_Estimated_Sal_PaymentCondition_IDEstimated]
GO
ALTER TABLE [dbo].[Sal_PaymentCondition]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Sal_PaymentCondition_IDPreSale] FOREIGN KEY([IDPreSale])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[Sal_PaymentCondition] CHECK CONSTRAINT [FK_Invoice_Sal_PaymentCondition_IDPreSale]
GO
ALTER TABLE [dbo].[Sal_PaymentCondition]  WITH CHECK ADD  CONSTRAINT [FK_MeioPag_Sal_PaymentCondition_IDMeioPag] FOREIGN KEY([IDMeioPag])
REFERENCES [dbo].[MeioPag] ([IDMeioPag])
GO
ALTER TABLE [dbo].[Sal_PaymentCondition] CHECK CONSTRAINT [FK_MeioPag_Sal_PaymentCondition_IDMeioPag]
GO
