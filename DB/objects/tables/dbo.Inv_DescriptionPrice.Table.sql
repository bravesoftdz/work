USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_DescriptionPrice]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_DescriptionPrice](
	[IDDescriptionPrice] [int] NOT NULL,
	[DescriptionPrice] [varchar](20) NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_DescriptionPrice] PRIMARY KEY CLUSTERED 
(
	[IDDescriptionPrice] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
