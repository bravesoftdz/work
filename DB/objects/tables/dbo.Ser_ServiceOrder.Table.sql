USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Ser_ServiceOrder]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ser_ServiceOrder](
	[IDServiceOrder] [int] NOT NULL,
	[IDCustomer] [int] NULL,
	[IDUser] [int] NULL,
	[IDSOStatus] [int] NULL,
	[IDStore] [int] NULL,
	[SONumber] [varchar](20) NULL,
	[SODate] [datetime] NULL,
	[SOCloseDate] [datetime] NULL,
	[OBS] [varchar](255) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSer_ServiceOrder] PRIMARY KEY CLUSTERED 
(
	[IDServiceOrder] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Ser_ServiceOrder]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_Ser_ServiceOrder_IDCustomer] FOREIGN KEY([IDCustomer])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Ser_ServiceOrder] CHECK CONSTRAINT [FK_Pessoa_Ser_ServiceOrder_IDCustomer]
GO
ALTER TABLE [dbo].[Ser_ServiceOrder]  WITH CHECK ADD  CONSTRAINT [FK_Ser_SOStatus_Ser_ServiceOrder_IDSOStatus] FOREIGN KEY([IDSOStatus])
REFERENCES [dbo].[Ser_SOStatus] ([IDSOStatus])
GO
ALTER TABLE [dbo].[Ser_ServiceOrder] CHECK CONSTRAINT [FK_Ser_SOStatus_Ser_ServiceOrder_IDSOStatus]
GO
ALTER TABLE [dbo].[Ser_ServiceOrder]  WITH CHECK ADD  CONSTRAINT [FK_Store_Ser_ServiceOrder_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Ser_ServiceOrder] CHECK CONSTRAINT [FK_Store_Ser_ServiceOrder_IDStore]
GO
ALTER TABLE [dbo].[Ser_ServiceOrder]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Ser_ServiceOrder_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Ser_ServiceOrder] CHECK CONSTRAINT [FK_SystemUser_Ser_ServiceOrder_IDUser]
GO
