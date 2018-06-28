USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_ModelStateTax]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_ModelStateTax](
	[IDModel] [int] NOT NULL,
	[IDEstado] [char](3) NOT NULL,
	[IDTaxCategory] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_ModelStateTax] PRIMARY KEY CLUSTERED 
(
	[IDModel] ASC,
	[IDEstado] ASC,
	[IDTaxCategory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_ModelStateTax]  WITH CHECK ADD  CONSTRAINT [PK_InvModelStateTax_Estado_IDEstado] FOREIGN KEY([IDEstado])
REFERENCES [dbo].[Estado] ([IDEstado])
GO
ALTER TABLE [dbo].[Inv_ModelStateTax] CHECK CONSTRAINT [PK_InvModelStateTax_Estado_IDEstado]
GO
ALTER TABLE [dbo].[Inv_ModelStateTax]  WITH CHECK ADD  CONSTRAINT [PK_InvModelStateTax_Model_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Inv_ModelStateTax] CHECK CONSTRAINT [PK_InvModelStateTax_Model_IDModel]
GO
ALTER TABLE [dbo].[Inv_ModelStateTax]  WITH CHECK ADD  CONSTRAINT [PK_InvModelStateTax_TaxCategory_IDTaxCategory] FOREIGN KEY([IDTaxCategory])
REFERENCES [dbo].[TaxCategory] ([IDTaxCategory])
GO
ALTER TABLE [dbo].[Inv_ModelStateTax] CHECK CONSTRAINT [PK_InvModelStateTax_TaxCategory_IDTaxCategory]
GO
ALTER TABLE [dbo].[Inv_ModelStateTax] ADD  CONSTRAINT [DEF_Bit1252]  DEFAULT ((0)) FOR [IDModel]
GO
ALTER TABLE [dbo].[Inv_ModelStateTax] ADD  CONSTRAINT [DEF_Bit1253]  DEFAULT ((0)) FOR [IDTaxCategory]
GO
