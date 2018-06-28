USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[pcm_others]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pcm_others](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[storeid] [varchar](50) NOT NULL,
	[vintage] [varchar](15) NOT NULL,
	[sku] [varchar](25) NOT NULL,
	[type] [varchar](25) NOT NULL,
	[object] [text] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
