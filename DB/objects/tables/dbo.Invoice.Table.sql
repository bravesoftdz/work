USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Invoice](
	[IDPreSale] [int] NOT NULL,
	[CashRegMovID] [int] NULL,
	[SpecialPriceID] [int] NULL,
	[IDMeioPag] [int] NULL,
	[IDTouristGroup] [int] NULL,
	[DeliverTypeID] [int] NULL,
	[MediaID] [int] NULL,
	[IDCustomer] [int] NOT NULL,
	[IDStore] [int] NULL,
	[IDInvoice] [int] NULL,
	[OtherComissionID] [int] NULL,
	[IDLancPagOtherCom] [int] NULL,
	[PreSaleDate] [smalldatetime] NOT NULL,
	[InvoiceDate] [smalldatetime] NULL,
	[DeliverDate] [smalldatetime] NULL,
	[DeliverAddress] [varchar](100) NULL,
	[Passport] [varchar](20) NULL,
	[PassportDate] [smalldatetime] NULL,
	[Ticket] [varchar](20) NULL,
	[AirLine] [varchar](40) NULL,
	[CompanyName] [varchar](40) NULL,
	[CompanyCGC] [varchar](20) NULL,
	[DepositDate] [smalldatetime] NULL,
	[Tax] [money] NULL,
	[SubTotal] [money] NULL,
	[Note] [varchar](150) NULL,
	[ItemDiscount] [money] NULL,
	[TaxIsent] [bit] NULL,
	[nOpenUser] [int] NULL,
	[RefreshInvoice] [timestamp] NULL,
	[Printed] [bit] NULL,
	[CashReceived] [money] NULL,
	[EstimatedPay] [smalldatetime] NULL,
	[CardNumber] [varchar](30) NULL,
	[OtherExpences] [money] NULL,
	[Address] [varchar](200) NULL,
	[TaxIsemptValue] [money] NULL,
	[TaxIsemptItemDiscount] [money] NULL,
	[Layaway] [dbo].[TBit] NULL,
	[FirstName] [varchar](20) NULL,
	[LastName] [varchar](20) NULL,
	[ZIP] [varchar](20) NULL,
	[nOpenHoldCaixa] [int] NULL,
	[PrintNotes] [bit] NULL,
	[DeliverOBS] [varchar](255) NULL,
	[DeliverConfirmation] [dbo].[TBit] NULL,
	[IDFormOfPayment] [int] NULL,
	[AditionalExpenses] [money] NULL,
	[Canceled] [bit] NOT NULL,
	[IDPreSaleParent] [int] NULL,
	[SaleCode] [varchar](20) NULL,
	[InvoiceCode] [varchar](20) NULL,
	[CupomFiscal] [varchar](8) NULL,
	[PuppyTracker] [bit] NULL,
	[NumeroSeriePrinter] [varchar](20) NULL,
	[InvoiceDiscount] [money] NULL,
	[ReplLastChange] [datetime] NULL,
	[TotalDiscount]  AS ([InvoiceDiscount]+[ItemDiscount]),
 CONSTRAINT [PK__Invoice__43D61337] PRIMARY KEY CLUSTERED 
(
	[IDPreSale] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_CashRegMov_Invoice_CashRegMovID] FOREIGN KEY([CashRegMovID])
REFERENCES [dbo].[CashRegMov] ([IDCashRegMov])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_CashRegMov_Invoice_CashRegMovID]
GO
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_DeliverType_Invoice_DeliverTypeID] FOREIGN KEY([DeliverTypeID])
REFERENCES [dbo].[DeliverType] ([IDDeliverType])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_DeliverType_Invoice_DeliverTypeID]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Invoice_IDPresaleParent] FOREIGN KEY([IDPreSaleParent])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Invoice_IDPresaleParent]
GO
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_Media_Invoice_MediaID] FOREIGN KEY([MediaID])
REFERENCES [dbo].[Media] ([IDMedia])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Media_Invoice_MediaID]
GO
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_MeioPag_Invoice_IDMeioPag] FOREIGN KEY([IDMeioPag])
REFERENCES [dbo].[MeioPag] ([IDMeioPag])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_MeioPag_Invoice_IDMeioPag]
GO
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_Invoice_IDCustomer] FOREIGN KEY([IDCustomer])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Pessoa_Invoice_IDCustomer]
GO
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_SpecialPrice_Invoice_SpecialPriceID] FOREIGN KEY([SpecialPriceID])
REFERENCES [dbo].[SpecialPrice] ([IDSpecialPrice])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_SpecialPrice_Invoice_SpecialPriceID]
GO
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_Invoice_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Store_Invoice_IDStore]
GO
ALTER TABLE [dbo].[Invoice]  WITH NOCHECK ADD  CONSTRAINT [FK_TouristGroup_Invoice_IDTourisGroup] FOREIGN KEY([IDTouristGroup])
REFERENCES [dbo].[TouristGroup] ([IDTouristGroup])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_TouristGroup_Invoice_IDTourisGroup]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Zero101]  DEFAULT (0) FOR [SubTotal]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Zero102]  DEFAULT (0) FOR [ItemDiscount]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Zero103]  DEFAULT (0) FOR [TaxIsent]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Zero104]  DEFAULT (0) FOR [nOpenUser]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Zero105]  DEFAULT (0) FOR [Printed]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Zero106]  DEFAULT (0) FOR [CashReceived]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Zero107]  DEFAULT (0) FOR [TaxIsemptValue]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Zero108]  DEFAULT (0) FOR [nOpenHoldCaixa]
GO
ALTER TABLE [dbo].[Invoice] ADD  DEFAULT (0) FOR [DeliverConfirmation]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_ZeroAdExp]  DEFAULT (0) FOR [AditionalExpenses]
GO
ALTER TABLE [dbo].[Invoice] ADD  DEFAULT (0) FOR [Canceled]
GO
ALTER TABLE [dbo].[Invoice] ADD  DEFAULT (0) FOR [InvoiceDiscount]
GO
