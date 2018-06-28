USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InvoiceToCostType]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceToCostType](
	[IDInvoiceCost] [int] NOT NULL,
	[IDPreSale] [int] NOT NULL,
	[IDCostType] [int] NOT NULL,
	[Amount] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInvoiceToCostType] PRIMARY KEY CLUSTERED 
(
	[IDInvoiceCost] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InvoiceToCostType]  WITH CHECK ADD  CONSTRAINT [FK_CostType_InvoiceToCostType_IDCostType] FOREIGN KEY([IDCostType])
REFERENCES [dbo].[CostType] ([IDCostType])
GO
ALTER TABLE [dbo].[InvoiceToCostType] CHECK CONSTRAINT [FK_CostType_InvoiceToCostType_IDCostType]
GO
ALTER TABLE [dbo].[InvoiceToCostType]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_InvoiceToCostType_IDPreSale] FOREIGN KEY([IDPreSale])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[InvoiceToCostType] CHECK CONSTRAINT [FK_Invoice_InvoiceToCostType_IDPreSale]
GO
ALTER TABLE [dbo].[InvoiceToCostType] ADD  CONSTRAINT [DF_ZeroCostType]  DEFAULT (0) FOR [Amount]
GO
