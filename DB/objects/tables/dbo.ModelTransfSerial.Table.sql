USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ModelTransfSerial]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ModelTransfSerial](
	[IDModelTransfSerial] [int] NOT NULL,
	[IDModelTransfDet] [int] NULL,
	[SerialNum] [varchar](30) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKModelTransfSerial] PRIMARY KEY CLUSTERED 
(
	[IDModelTransfSerial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ModelTransfSerial]  WITH CHECK ADD  CONSTRAINT [FK_ModelTransfDet_ModelTransfSerial_IDModelTransfDet] FOREIGN KEY([IDModelTransfDet])
REFERENCES [dbo].[ModelTransfDet] ([IDModelTransfDet])
GO
ALTER TABLE [dbo].[ModelTransfSerial] CHECK CONSTRAINT [FK_ModelTransfDet_ModelTransfSerial_IDModelTransfDet]
GO
