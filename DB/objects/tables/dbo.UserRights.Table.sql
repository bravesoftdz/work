USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[UserRights]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRights](
	[UserTypeID] [int] NOT NULL,
	[MenuID] [int] NOT NULL,
	[SubMenuID] [int] NOT NULL,
	[CanAccess] [bit] NULL,
	[CanInsert] [bit] NULL,
	[CanDelete] [bit] NULL,
	[CanUpdate] [bit] NULL,
	[CanPrint] [bit] NULL,
	[CanExport] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_UserRights_UserTypeID] PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC,
	[MenuID] ASC,
	[SubMenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserRights] ADD  CONSTRAINT [DF_MenuItem_Enabled5]  DEFAULT (1) FOR [CanInsert]
GO
