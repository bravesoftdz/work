USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_RebateItemCalendar]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_RebateItemCalendar](
	[IDRebateItem] [int] NOT NULL,
	[IDRebateCalendar] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_RebateItemCalendar] PRIMARY KEY CLUSTERED 
(
	[IDRebateItem] ASC,
	[IDRebateCalendar] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_RebateItemCalendar]  WITH CHECK ADD  CONSTRAINT [FK_SalRebateCalendar_SalRebateItemCalendar_IDRebateCalendar] FOREIGN KEY([IDRebateCalendar])
REFERENCES [dbo].[Sal_RebateCalendar] ([IDRebateCalendar])
GO
ALTER TABLE [dbo].[Sal_RebateItemCalendar] CHECK CONSTRAINT [FK_SalRebateCalendar_SalRebateItemCalendar_IDRebateCalendar]
GO
ALTER TABLE [dbo].[Sal_RebateItemCalendar]  WITH CHECK ADD  CONSTRAINT [FK_SalRebateItem_SalRebateItemCalendar_IDRebateItem] FOREIGN KEY([IDRebateItem])
REFERENCES [dbo].[Sal_RebateItem] ([IDRebateItem])
GO
ALTER TABLE [dbo].[Sal_RebateItemCalendar] CHECK CONSTRAINT [FK_SalRebateItem_SalRebateItemCalendar_IDRebateItem]
GO
