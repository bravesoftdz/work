USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_MovDocument]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_MovDocument](
	[IDMovDocument] [int] NOT NULL,
	[IDPreInventoryMov] [int] NULL,
	[IDInventoryMov] [int] NULL,
	[DocumentNumber] [varchar](20) NOT NULL,
	[DocumentDate] [datetime] NOT NULL,
	[DocumentStatus] [int] NOT NULL,
	[IDDocumentType] [int] NOT NULL,
	[OBS] [varchar](255) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_MovDocument] PRIMARY KEY CLUSTERED 
(
	[IDMovDocument] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_MovDocument]  WITH CHECK ADD  CONSTRAINT [FK_InventoryMov_InvMovDocument_IDInventoryMov] FOREIGN KEY([IDInventoryMov])
REFERENCES [dbo].[InventoryMov] ([IDInventoryMov])
GO
ALTER TABLE [dbo].[Inv_MovDocument] CHECK CONSTRAINT [FK_InventoryMov_InvMovDocument_IDInventoryMov]
GO
ALTER TABLE [dbo].[Inv_MovDocument]  WITH CHECK ADD  CONSTRAINT [FK_MntDocument_InvMovDocument_IDDocument] FOREIGN KEY([IDDocumentType])
REFERENCES [dbo].[Mnt_DocumentType] ([IDDocumentType])
GO
ALTER TABLE [dbo].[Inv_MovDocument] CHECK CONSTRAINT [FK_MntDocument_InvMovDocument_IDDocument]
GO
ALTER TABLE [dbo].[Inv_MovDocument]  WITH CHECK ADD  CONSTRAINT [FK_PreInventoryMov_InvMovDocument_IDPreInventoryMov] FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
GO
ALTER TABLE [dbo].[Inv_MovDocument] CHECK CONSTRAINT [FK_PreInventoryMov_InvMovDocument_IDPreInventoryMov]
GO
