USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_CountItem]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_CountItem](
	[IDCountItem] [int] NOT NULL,
	[Barcode] [varchar](20) NOT NULL,
	[Qty] [float] NOT NULL,
	[SalePrice] [money] NULL,
	[CountDate] [datetime] NOT NULL,
	[IDUser] [int] NOT NULL,
	[IDCount] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_CountItem] PRIMARY KEY CLUSTERED 
(
	[IDCountItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_CountItem]  WITH CHECK ADD  CONSTRAINT [FK_InvCount_InvCountItem_IDCount] FOREIGN KEY([IDCount])
REFERENCES [dbo].[Inv_Count] ([IDCount])
GO
ALTER TABLE [dbo].[Inv_CountItem] CHECK CONSTRAINT [FK_InvCount_InvCountItem_IDCount]
GO
ALTER TABLE [dbo].[Inv_CountItem]  WITH CHECK ADD  CONSTRAINT [FK_User_InvCountItem_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Inv_CountItem] CHECK CONSTRAINT [FK_User_InvCountItem_IDUser]
GO
