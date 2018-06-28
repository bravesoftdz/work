USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_DiscStores]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_DiscStores](
	[IDSal_Discount] [int] NOT NULL,
	[IDStore] [int] NULL,
	[ISInclude] [dbo].[Boolean] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_DiscStores]  WITH CHECK ADD FOREIGN KEY([IDSal_Discount])
REFERENCES [dbo].[Sal_Discounts] ([IDSal_Discount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Sal_DiscStores] ADD  DEFAULT ((1)) FOR [ISInclude]
GO
