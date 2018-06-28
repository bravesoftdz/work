USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sys_Module]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_Module](
	[ModuleInfo] [varchar](255) NOT NULL,
	[VersionNo] [int] NULL,
	[BuildNo] [int] NULL,
	[Seats] [varchar](50) NULL,
	[VersionType] [varchar](15) NULL,
	[RestricForms] [text] NULL,
	[MRLogo] [image] NULL,
	[MRBuild] [int] NULL,
	[ReplLastChange] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
