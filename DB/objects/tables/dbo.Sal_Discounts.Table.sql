USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_Discounts]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_Discounts](
	[IDSal_Discount] [int] NOT NULL,
	[Start_Timestamp] [datetimeoffset](7) NULL,
	[End_TimeStamp] [datetimeoffset](7) NULL,
	[DayOfWeek] [int] NULL,
	[BeginTimeOfDay] [time](7) NULL,
	[EndTimeOfDay] [time](7) NULL,
	[DiscType] [varchar](100) NULL,
	[MinSubtotal] [money] NULL,
	[IDStore] [int] NULL,
	[MaxUsesPerCustomer] [int] NULL,
	[MaxUsesInTotal] [int] NULL,
	[FirstTimeCustomerOnly] [dbo].[Boolean] NULL,
	[CustomerCardRequired] [dbo].[Boolean] NULL,
	[AllowedCustomerGroup] [varchar](100) NULL,
	[IsStackable] [dbo].[Boolean] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDSal_Discount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_Discounts] ADD  DEFAULT ((1)) FOR [IsStackable]
GO
