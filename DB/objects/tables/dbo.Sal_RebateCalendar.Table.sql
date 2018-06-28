USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_RebateCalendar]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_RebateCalendar](
	[IDRebateCalendar] [int] NOT NULL,
	[IDStore] [int] NULL,
	[Description] [varchar](30) NOT NULL,
	[DaysOfWeek] [varchar](14) NOT NULL,
	[DiscountPerc] [float] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_RebateCalendar] PRIMARY KEY CLUSTERED 
(
	[IDRebateCalendar] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_RebateCalendar]  WITH CHECK ADD  CONSTRAINT [FK_Store_SalRebateCalendar_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Sal_RebateCalendar] CHECK CONSTRAINT [FK_Store_SalRebateCalendar_IDStore]
GO
