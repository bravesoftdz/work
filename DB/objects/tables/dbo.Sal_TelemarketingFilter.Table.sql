USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_TelemarketingFilter]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_TelemarketingFilter](
	[IDTelemarketingFilter] [int] NOT NULL,
	[FilterName] [varchar](30) NOT NULL,
	[FilterValues] [text] NOT NULL,
	[SQL] [text] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_TelemarketingFilter] PRIMARY KEY CLUSTERED 
(
	[IDTelemarketingFilter] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
