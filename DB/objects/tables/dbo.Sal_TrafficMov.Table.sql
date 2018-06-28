USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_TrafficMov]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_TrafficMov](
	[IDTrafficMov] [int] NOT NULL,
	[IDTrafficBox] [int] NULL,
	[DateMov] [datetime] NOT NULL,
	[Qty] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_TrafficMov] PRIMARY KEY CLUSTERED 
(
	[IDTrafficMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_TrafficMov]  WITH CHECK ADD  CONSTRAINT [R_212] FOREIGN KEY([IDTrafficBox])
REFERENCES [dbo].[Sal_TrafficBox] ([IDTrafficBox])
GO
ALTER TABLE [dbo].[Sal_TrafficMov] CHECK CONSTRAINT [R_212]
GO
