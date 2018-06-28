USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_FrozeCount]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_FrozeCount](
	[IDCount] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[Qty] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_FrozeCount] PRIMARY KEY CLUSTERED 
(
	[IDCount] ASC,
	[IDModel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_FrozeCount]  WITH CHECK ADD  CONSTRAINT [FK_InvCount_InvFroze_IDCount] FOREIGN KEY([IDCount])
REFERENCES [dbo].[Inv_Count] ([IDCount])
GO
ALTER TABLE [dbo].[Inv_FrozeCount] CHECK CONSTRAINT [FK_InvCount_InvFroze_IDCount]
GO
ALTER TABLE [dbo].[Inv_FrozeCount]  WITH CHECK ADD  CONSTRAINT [FK_Model_InvFroze_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Inv_FrozeCount] CHECK CONSTRAINT [FK_Model_InvFroze_IDModel]
GO
