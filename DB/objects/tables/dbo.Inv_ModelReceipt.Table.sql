USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_ModelReceipt]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_ModelReceipt](
	[IDModelReceipt] [varchar](20) NOT NULL,
	[ReceiptText] [varchar](255) NOT NULL,
	[System] [dbo].[Boolean] NOT NULL,
	[Hidden] [dbo].[Boolean] NOT NULL,
	[Desativado] [dbo].[Boolean] NOT NULL,
	[IDModel] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_ModelReceipt] PRIMARY KEY CLUSTERED 
(
	[IDModelReceipt] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_ModelReceipt]  WITH CHECK ADD  CONSTRAINT [FK_Model_InvModelReceipt_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Inv_ModelReceipt] CHECK CONSTRAINT [FK_Model_InvModelReceipt_IDModel]
GO
ALTER TABLE [dbo].[Inv_ModelReceipt] ADD  CONSTRAINT [DF_InvModelReceipt_System_Zero]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Inv_ModelReceipt] ADD  CONSTRAINT [DF_InvModelReceipt_Hidden_Zero]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Inv_ModelReceipt] ADD  CONSTRAINT [DF_InvModelReceipt_Desativado_Zero]  DEFAULT (0) FOR [Desativado]
GO
