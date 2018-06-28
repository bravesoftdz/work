USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[History]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[History](
	[IDHistory] [int] NOT NULL,
	[IDUser] [int] NULL,
	[MovDate] [datetime] NOT NULL,
	[OBS] [varchar](255) NOT NULL,
	[IDHistoryType] [int] NULL,
	[IDPreSale] [int] NULL,
	[IDServiceOrder] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKHistory] PRIMARY KEY CLUSTERED 
(
	[IDHistory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_HistoryType_History_IDHIstoryType] FOREIGN KEY([IDHistoryType])
REFERENCES [dbo].[HistoryType] ([IDHistoryType])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_HistoryType_History_IDHIstoryType]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_History_IDPreSale] FOREIGN KEY([IDPreSale])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_Invoice_History_IDPreSale]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_Ser_ServiceOrder_History_IDServiceOrder] FOREIGN KEY([IDServiceOrder])
REFERENCES [dbo].[Ser_ServiceOrder] ([IDServiceOrder])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_Ser_ServiceOrder_History_IDServiceOrder]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_History_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_SystemUser_History_IDUser]
GO
