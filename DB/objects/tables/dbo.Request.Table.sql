USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Request]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Request](
	[IDRequest] [int] NOT NULL,
	[ModelID] [int] NULL,
	[UserID] [int] NOT NULL,
	[StoreID] [int] NULL,
	[IDPreInventoryMov] [int] NULL,
	[IDCotacao] [int] NULL,
	[Type] [char](1) NOT NULL,
	[DateRequest] [smalldatetime] NOT NULL,
	[Description] [varchar](50) NULL,
	[Cotado] [bit] NULL,
	[DelayDate] [smalldatetime] NULL,
	[QtyReq] [decimal](38, 4) NULL,
	[QtyOrdered] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Request__1B9317B3] PRIMARY KEY CLUSTERED 
(
	[IDRequest] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Request]  WITH NOCHECK ADD  CONSTRAINT [FK_Cotacao_Request_IDCotacao] FOREIGN KEY([IDCotacao])
REFERENCES [dbo].[Cotacao] ([IDCotacao])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Cotacao_Request_IDCotacao]
GO
ALTER TABLE [dbo].[Request]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_Request_ModelID] FOREIGN KEY([ModelID])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Model_Request_ModelID]
GO
ALTER TABLE [dbo].[Request]  WITH NOCHECK ADD  CONSTRAINT [FK_PreInventoryMov_Request_IDPreInventoryMov] FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_PreInventoryMov_Request_IDPreInventoryMov]
GO
ALTER TABLE [dbo].[Request]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_Request_StoreID] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_Store_Request_StoreID]
GO
ALTER TABLE [dbo].[Request]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Request_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Request] CHECK CONSTRAINT [FK_SystemUser_Request_UserID]
GO
ALTER TABLE [dbo].[Request] ADD  CONSTRAINT [DF_Zero135]  DEFAULT (0) FOR [Cotado]
GO
