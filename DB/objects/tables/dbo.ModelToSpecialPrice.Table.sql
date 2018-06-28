USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ModelToSpecialPrice]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ModelToSpecialPrice](
	[IDModel] [int] NOT NULL,
	[IDSpecialPrice] [int] NOT NULL,
	[MarkUp] [money] NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDModel] ASC,
	[IDSpecialPrice] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ModelToSpecialPrice] ADD  CONSTRAINT [DF_Zero134]  DEFAULT (0) FOR [MarkUp]
GO
