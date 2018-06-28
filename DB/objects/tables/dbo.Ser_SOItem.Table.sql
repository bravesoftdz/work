USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Ser_SOItem]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ser_SOItem](
	[IDSOItem] [int] NOT NULL,
	[SerialNumber] [varchar](50) NULL,
	[IniDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[OBS] [varchar](100) NULL,
	[IDSOCustomerProduct] [int] NULL,
	[IDUser] [int] NULL,
	[IDServiceOrder] [int] NULL,
	[UsedTime] [varchar](20) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSer_SOItem] PRIMARY KEY CLUSTERED 
(
	[IDSOItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Ser_SOItem]  WITH CHECK ADD  CONSTRAINT [FK_Ser_ServiceOrder_Ser_SOItem_IDServiceOrder] FOREIGN KEY([IDServiceOrder])
REFERENCES [dbo].[Ser_ServiceOrder] ([IDServiceOrder])
GO
ALTER TABLE [dbo].[Ser_SOItem] CHECK CONSTRAINT [FK_Ser_ServiceOrder_Ser_SOItem_IDServiceOrder]
GO
ALTER TABLE [dbo].[Ser_SOItem]  WITH CHECK ADD  CONSTRAINT [FK_Ser_SOCustomerProduct_Ser_SOItem_IDSOCustomerProduct] FOREIGN KEY([IDSOCustomerProduct])
REFERENCES [dbo].[Ser_SOCustomerProduct] ([IDSOCustomerProduct])
GO
ALTER TABLE [dbo].[Ser_SOItem] CHECK CONSTRAINT [FK_Ser_SOCustomerProduct_Ser_SOItem_IDSOCustomerProduct]
GO
ALTER TABLE [dbo].[Ser_SOItem]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Ser_SOItem_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Ser_SOItem] CHECK CONSTRAINT [FK_SystemUser_Ser_SOItem_IDUser]
GO
