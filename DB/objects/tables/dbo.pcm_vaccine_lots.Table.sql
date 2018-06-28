USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[pcm_vaccine_lots]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pcm_vaccine_lots](
	[code] [int] IDENTITY(1,1) NOT NULL,
	[lotnum] [varchar](50) NULL,
	[vaccine] [varchar](50) NOT NULL,
	[manu] [varchar](50) NULL,
	[expire] [varchar](25) NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
