USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Param]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Param](
	[IDParam] [int] NOT NULL,
	[SrvParameter] [varchar](40) NOT NULL,
	[SrvValue] [varchar](30) NOT NULL,
	[SrvType] [char](10) NOT NULL,
	[Description] [varchar](200) NULL,
	[DefaultValue] [varchar](30) NULL,
	[Desativado] [dbo].[Boolean] NULL,
	[IDMenu] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKParam] PRIMARY KEY CLUSTERED 
(
	[IDParam] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Param] ADD  DEFAULT (0) FOR [Desativado]
GO
