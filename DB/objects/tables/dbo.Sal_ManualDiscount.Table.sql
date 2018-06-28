USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_ManualDiscount]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_ManualDiscount](
	[IDPreInventoryMov] [int] NOT NULL,
	[ManualDiscount] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPreInventoryMov] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_ManualDiscount]  WITH CHECK ADD FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
ON DELETE CASCADE
GO
