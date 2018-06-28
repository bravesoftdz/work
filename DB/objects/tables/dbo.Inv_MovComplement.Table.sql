USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_MovComplement]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_MovComplement](
	[IDInventoryMov] [int] NOT NULL,
	[IDMovReason] [int] NOT NULL,
	[Notes] [varchar](255) NULL,
	[IDLote] [int] NULL,
	[TotalizadorParcial] [varchar](10) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_MovComplement] PRIMARY KEY CLUSTERED 
(
	[IDInventoryMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_MovComplement]  WITH CHECK ADD  CONSTRAINT [FK_Inv_Lot_Inv_MovComplement_IDLot] FOREIGN KEY([IDLote])
REFERENCES [dbo].[Inv_Lot] ([IDLote])
GO
ALTER TABLE [dbo].[Inv_MovComplement] CHECK CONSTRAINT [FK_Inv_Lot_Inv_MovComplement_IDLot]
GO
ALTER TABLE [dbo].[Inv_MovComplement]  WITH CHECK ADD  CONSTRAINT [FK_InventoryMov_InvMovComplement_IDInventoryMov] FOREIGN KEY([IDInventoryMov])
REFERENCES [dbo].[InventoryMov] ([IDInventoryMov])
GO
ALTER TABLE [dbo].[Inv_MovComplement] CHECK CONSTRAINT [FK_InventoryMov_InvMovComplement_IDInventoryMov]
GO
ALTER TABLE [dbo].[Inv_MovComplement]  WITH CHECK ADD  CONSTRAINT [FK_InvMovReason_InvMovComplement_IDInventoryMov] FOREIGN KEY([IDMovReason])
REFERENCES [dbo].[Inv_MovReason] ([IDMovReason])
GO
ALTER TABLE [dbo].[Inv_MovComplement] CHECK CONSTRAINT [FK_InvMovReason_InvMovComplement_IDInventoryMov]
GO
