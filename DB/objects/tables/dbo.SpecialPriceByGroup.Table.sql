USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[SpecialPriceByGroup]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecialPriceByGroup](
	[SpecialPriceID] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[SpecialMarkUp] [money] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_SPG_SpecialPriceID] PRIMARY KEY CLUSTERED 
(
	[SpecialPriceID] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
