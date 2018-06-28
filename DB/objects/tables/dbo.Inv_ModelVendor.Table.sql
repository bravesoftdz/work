USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_ModelVendor]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_ModelVendor](
	[IDPessoa] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[VendorOrder] [int] NOT NULL,
	[MinQtyPO] [float] NOT NULL,
	[CaseQty] [decimal](38, 4) NULL,
	[VendorCost] [money] NULL,
	[CostLastChange] [datetime] NULL,
	[DoNotOrder] [bit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_ModelVendor] PRIMARY KEY CLUSTERED 
(
	[IDPessoa] ASC,
	[IDModel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_ModelVendor]  WITH CHECK ADD  CONSTRAINT [FK_Model_InvModelVendor_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Inv_ModelVendor] CHECK CONSTRAINT [FK_Model_InvModelVendor_IDModel]
GO
ALTER TABLE [dbo].[Inv_ModelVendor]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_InvModelVendor_IDFabricante] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Inv_ModelVendor] CHECK CONSTRAINT [FK_Pessoa_InvModelVendor_IDFabricante]
GO
ALTER TABLE [dbo].[Inv_ModelVendor] ADD  CONSTRAINT [DF_InvModelVendor_MinQtyPO_Zero]  DEFAULT (0) FOR [MinQtyPO]
GO
ALTER TABLE [dbo].[Inv_ModelVendor] ADD  CONSTRAINT [DF_InvModelVendor_CaseQty_Zero]  DEFAULT (0) FOR [CaseQty]
GO
ALTER TABLE [dbo].[Inv_ModelVendor] ADD  CONSTRAINT [DF_Inv_ModelVendor_DoNotOrder]  DEFAULT ((0)) FOR [DoNotOrder]
GO
