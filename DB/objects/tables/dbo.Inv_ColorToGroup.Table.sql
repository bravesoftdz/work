USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_ColorToGroup]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_ColorToGroup](
	[IDSizeColorGroup] [int] NOT NULL,
	[IDColor] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_ColorToGroup] PRIMARY KEY CLUSTERED 
(
	[IDSizeColorGroup] ASC,
	[IDColor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_ColorToGroup]  WITH CHECK ADD  CONSTRAINT [FK_InvColor_IDColor_Inv_ColorToGroup_IDColor] FOREIGN KEY([IDColor])
REFERENCES [dbo].[InvColor] ([IDColor])
GO
ALTER TABLE [dbo].[Inv_ColorToGroup] CHECK CONSTRAINT [FK_InvColor_IDColor_Inv_ColorToGroup_IDColor]
GO
ALTER TABLE [dbo].[Inv_ColorToGroup]  WITH CHECK ADD  CONSTRAINT [FK_SizeToColorGroup_IDSizeColorGroup_ColorToGroup_IDSizeColorGroup] FOREIGN KEY([IDSizeColorGroup])
REFERENCES [dbo].[Inv_SizeColorGroup] ([IDSizeColorGroup])
GO
ALTER TABLE [dbo].[Inv_ColorToGroup] CHECK CONSTRAINT [FK_SizeToColorGroup_IDSizeColorGroup_ColorToGroup_IDSizeColorGroup]
GO
