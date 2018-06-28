USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_Registry]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Sis_Registry](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AttributeName] [varchar](max) NULL,
	[AttributeValue] [varchar](max) NULL,
	[AttributeType] [varchar](50) NOT NULL,
	[ConstraintValue] [varchar](50) NOT NULL,
	[ContraintType] [tinyint] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_Sis_Registry] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
