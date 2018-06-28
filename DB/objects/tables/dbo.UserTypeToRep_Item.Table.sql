USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[UserTypeToRep_Item]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypeToRep_Item](
	[IDUserType] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[Access] [dbo].[Boolean] NULL,
	[Edit] [dbo].[Boolean] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKUserTypeToRep_Item] PRIMARY KEY CLUSTERED 
(
	[IDUserType] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserTypeToRep_Item]  WITH NOCHECK ADD  CONSTRAINT [FK_RepItem_UserTypeToRepItem_ItemId] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Rep_Item] ([ItemId])
GO
ALTER TABLE [dbo].[UserTypeToRep_Item] CHECK CONSTRAINT [FK_RepItem_UserTypeToRepItem_ItemId]
GO
ALTER TABLE [dbo].[UserTypeToRep_Item]  WITH CHECK ADD  CONSTRAINT [FK_UserType_UserTypeToRepItem_IDUserTypeId] FOREIGN KEY([IDUserType])
REFERENCES [dbo].[UserType] ([IDUserType])
GO
ALTER TABLE [dbo].[UserTypeToRep_Item] CHECK CONSTRAINT [FK_UserType_UserTypeToRepItem_IDUserTypeId]
GO
