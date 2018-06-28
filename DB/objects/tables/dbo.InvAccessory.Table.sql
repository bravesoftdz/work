USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InvAccessory]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvAccessory](
	[IDInvAccessory] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[Description] [varchar](255) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInvAccessory] PRIMARY KEY CLUSTERED 
(
	[IDInvAccessory] ASC,
	[IDModel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[InvAccessory]  WITH CHECK ADD  CONSTRAINT [FK_Model_InvAccessory_IDInvAccessory] FOREIGN KEY([IDInvAccessory])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[InvAccessory] CHECK CONSTRAINT [FK_Model_InvAccessory_IDInvAccessory]
GO
ALTER TABLE [dbo].[InvAccessory]  WITH CHECK ADD  CONSTRAINT [FK_Model_InvAccessory_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[InvAccessory] CHECK CONSTRAINT [FK_Model_InvAccessory_IDModel]
GO
