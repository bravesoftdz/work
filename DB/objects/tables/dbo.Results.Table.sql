USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Results]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Results](
	[IDWarrantyReport] [int] NOT NULL,
	[IDSpecies] [int] NOT NULL,
	[Report] [image] NULL,
	[ReportName] [varchar](30) NULL,
	[ReportDate] [datetime] NULL,
	[ReplLastChange] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
