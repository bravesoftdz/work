USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_SizeToGroup]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_SizeToGroup](
	[IDSizeColorGroup] [int] NOT NULL,
	[IDSize] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_SizeToGroup] PRIMARY KEY CLUSTERED 
(
	[IDSizeColorGroup] ASC,
	[IDSize] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_SizeToGroup]  WITH CHECK ADD  CONSTRAINT [FK_SizeToColorGroup_IDSizeColorGroup_SizeToGroup_IDSizeColorGroup] FOREIGN KEY([IDSizeColorGroup])
REFERENCES [dbo].[Inv_SizeColorGroup] ([IDSizeColorGroup])
GO
ALTER TABLE [dbo].[Inv_SizeToGroup] CHECK CONSTRAINT [FK_SizeToColorGroup_IDSizeColorGroup_SizeToGroup_IDSizeColorGroup]
GO
ALTER TABLE [dbo].[Inv_SizeToGroup]  WITH CHECK ADD  CONSTRAINT [InvSize_IDSize_Inv_SizeToGroup_IDSize] FOREIGN KEY([IDSize])
REFERENCES [dbo].[InvSize] ([IDSize])
GO
ALTER TABLE [dbo].[Inv_SizeToGroup] CHECK CONSTRAINT [InvSize_IDSize_Inv_SizeToGroup_IDSize]
GO
