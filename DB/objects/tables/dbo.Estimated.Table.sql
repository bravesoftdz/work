USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Estimated]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estimated](
	[IDEstimated] [int] NOT NULL,
	[IDPessoa] [int] NULL,
	[IDUser] [int] NULL,
	[IDStore] [int] NULL,
	[EstimatedDate] [datetime] NULL,
	[Total] [money] NULL,
	[OBS] [varchar](255) NULL,
	[IDPreSale] [int] NULL,
	[OBS2] [varchar](255) NULL,
	[IDTouristGroup] [int] NULL,
	[IDDeliverType] [int] NULL,
	[DeliverDate] [datetime] NULL,
	[DeliverAddress] [varchar](100) NULL,
	[DeliverOBS] [varchar](255) NULL,
	[TotalDiscount] [money] NULL,
	[Confirmed] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKEstimated] PRIMARY KEY CLUSTERED 
(
	[IDEstimated] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Estimated]  WITH CHECK ADD  CONSTRAINT [FK_DeliverType_Estimated_IDDeliverType] FOREIGN KEY([IDDeliverType])
REFERENCES [dbo].[DeliverType] ([IDDeliverType])
GO
ALTER TABLE [dbo].[Estimated] CHECK CONSTRAINT [FK_DeliverType_Estimated_IDDeliverType]
GO
ALTER TABLE [dbo].[Estimated]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Estimated_IDPreSale] FOREIGN KEY([IDPreSale])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[Estimated] CHECK CONSTRAINT [FK_Invoice_Estimated_IDPreSale]
GO
ALTER TABLE [dbo].[Estimated]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_Estimated_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Estimated] CHECK CONSTRAINT [FK_Pessoa_Estimated_IDPessoa]
GO
ALTER TABLE [dbo].[Estimated]  WITH CHECK ADD  CONSTRAINT [FK_Store_Estimated_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Estimated] CHECK CONSTRAINT [FK_Store_Estimated_IDStore]
GO
ALTER TABLE [dbo].[Estimated]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Estimated_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Estimated] CHECK CONSTRAINT [FK_SystemUser_Estimated_IDUser]
GO
ALTER TABLE [dbo].[Estimated]  WITH CHECK ADD  CONSTRAINT [FK_TouristGroup_Estimated_IDTouristGroup] FOREIGN KEY([IDTouristGroup])
REFERENCES [dbo].[TouristGroup] ([IDTouristGroup])
GO
ALTER TABLE [dbo].[Estimated] CHECK CONSTRAINT [FK_TouristGroup_Estimated_IDTouristGroup]
GO
