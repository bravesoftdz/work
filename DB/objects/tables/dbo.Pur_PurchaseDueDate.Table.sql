USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pur_PurchaseDueDate]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pur_PurchaseDueDate](
	[IDPurchaseDueDate] [varchar](20) NOT NULL,
	[Date] [datetime] NULL,
	[Amount] [dbo].[TValor] NOT NULL,
	[IDPurchase] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPur_PurchaseDueDate] PRIMARY KEY CLUSTERED 
(
	[IDPurchaseDueDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pur_PurchaseDueDate]  WITH CHECK ADD  CONSTRAINT [FK_Pur_Purchase_Pur_PurchaseDueDate_IDPurchase] FOREIGN KEY([IDPurchase])
REFERENCES [dbo].[Pur_Purchase] ([IDPurchase])
GO
ALTER TABLE [dbo].[Pur_PurchaseDueDate] CHECK CONSTRAINT [FK_Pur_Purchase_Pur_PurchaseDueDate_IDPurchase]
GO
