USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_Count]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_Count](
	[IDCount] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[CountType] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[IDStore] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_Count] PRIMARY KEY CLUSTERED 
(
	[IDCount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_Count]  WITH CHECK ADD  CONSTRAINT [FK_Store_InvCount_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Inv_Count] CHECK CONSTRAINT [FK_Store_InvCount_IDStore]
GO
ALTER TABLE [dbo].[Inv_Count]  WITH CHECK ADD  CONSTRAINT [FK_User_InvCount_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Inv_Count] CHECK CONSTRAINT [FK_User_InvCount_IDUser]
GO
