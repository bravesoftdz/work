USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[POItemRequest]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POItemRequest](
	[IDPreInventoryMov] [int] NOT NULL,
	[IDRequest] [int] NOT NULL,
	[Qty] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPOItemRequest] PRIMARY KEY CLUSTERED 
(
	[IDPreInventoryMov] ASC,
	[IDRequest] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[POItemRequest]  WITH NOCHECK ADD  CONSTRAINT [FK_PreInventoryMov_POItemRequest_IDPreInventoryMov] FOREIGN KEY([IDPreInventoryMov])
REFERENCES [dbo].[PreInventoryMov] ([IDPreInventoryMov])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[POItemRequest] CHECK CONSTRAINT [FK_PreInventoryMov_POItemRequest_IDPreInventoryMov]
GO
ALTER TABLE [dbo].[POItemRequest]  WITH NOCHECK ADD  CONSTRAINT [FK_Request_POItemRequest_IDRequest] FOREIGN KEY([IDRequest])
REFERENCES [dbo].[Request] ([IDRequest])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[POItemRequest] CHECK CONSTRAINT [FK_Request_POItemRequest_IDRequest]
GO
