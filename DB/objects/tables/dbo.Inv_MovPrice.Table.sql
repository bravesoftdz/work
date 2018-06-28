USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_MovPrice]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_MovPrice](
	[IDMovPrice] [int] NOT NULL,
	[IDPreInventoryMov] [int] NULL,
	[IDInventoryMov] [int] NULL,
	[IDDescriptionPrice] [int] NOT NULL,
	[IDVendor] [int] NULL,
	[SuggPrice] [money] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_MovPrice] PRIMARY KEY CLUSTERED 
(
	[IDMovPrice] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_MovPrice]  WITH CHECK ADD  CONSTRAINT [FK_InvDescriptionPrice_InvMovPrice_IDDescriptionPrice] FOREIGN KEY([IDDescriptionPrice])
REFERENCES [dbo].[Inv_DescriptionPrice] ([IDDescriptionPrice])
GO
ALTER TABLE [dbo].[Inv_MovPrice] CHECK CONSTRAINT [FK_InvDescriptionPrice_InvMovPrice_IDDescriptionPrice]
GO
ALTER TABLE [dbo].[Inv_MovPrice]  WITH CHECK ADD  CONSTRAINT [FK_InventoryMov_InvMovPrice_IDInventoryMov] FOREIGN KEY([IDInventoryMov])
REFERENCES [dbo].[InventoryMov] ([IDInventoryMov])
GO
ALTER TABLE [dbo].[Inv_MovPrice] CHECK CONSTRAINT [FK_InventoryMov_InvMovPrice_IDInventoryMov]
GO
ALTER TABLE [dbo].[Inv_MovPrice]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_InvMovPrice_IDVendor] FOREIGN KEY([IDVendor])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Inv_MovPrice] CHECK CONSTRAINT [FK_Pessoa_InvMovPrice_IDVendor]
GO
ALTER TABLE [dbo].[Inv_MovPrice]  WITH CHECK ADD  CONSTRAINT [FK_PreInventoryMov_InvMovPrice_IDPreInventoryMov] FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
GO
ALTER TABLE [dbo].[Inv_MovPrice] CHECK CONSTRAINT [FK_PreInventoryMov_InvMovPrice_IDPreInventoryMov]
GO
ALTER TABLE [dbo].[Inv_MovPrice] ADD  CONSTRAINT [DF_InvMovPrice_SuggPrice_Zero]  DEFAULT (0) FOR [SuggPrice]
GO
