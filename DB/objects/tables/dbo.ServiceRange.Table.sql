USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ServiceRange]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceRange](
	[IDServiceRange] [int] NOT NULL,
	[IDGroup] [int] NULL,
	[IDModel] [int] NULL,
	[BeginAmount] [money] NULL,
	[EndAmount] [money] NULL,
	[UseRange] [dbo].[Boolean] NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDServiceRange] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ServiceRange]  WITH CHECK ADD  CONSTRAINT [FK_Model_ServiceRange_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[ServiceRange] CHECK CONSTRAINT [FK_Model_ServiceRange_IDModel]
GO
ALTER TABLE [dbo].[ServiceRange]  WITH CHECK ADD  CONSTRAINT [FK_TabGroup_ServiceRange_IDGroup] FOREIGN KEY([IDGroup])
REFERENCES [dbo].[TabGroup] ([IDGroup])
GO
ALTER TABLE [dbo].[ServiceRange] CHECK CONSTRAINT [FK_TabGroup_ServiceRange_IDGroup]
GO
ALTER TABLE [dbo].[ServiceRange] ADD  DEFAULT (1) FOR [UseRange]
GO
