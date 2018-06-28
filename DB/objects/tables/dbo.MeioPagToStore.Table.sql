USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[MeioPagToStore]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeioPagToStore](
	[IDStore] [int] NOT NULL,
	[IDMeioPag] [int] NOT NULL,
	[IDContaCorrente] [int] NULL,
	[AdmTax] [money] NULL,
	[ReceivingDay] [int] NULL,
	[FlatFee] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDStore] ASC,
	[IDMeioPag] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MeioPagToStore]  WITH NOCHECK ADD  CONSTRAINT [FK_ContaCorrente_MeioPagToStore_IDContaCorrente] FOREIGN KEY([IDContaCorrente])
REFERENCES [dbo].[Fin_ContaCorrente] ([IDContaCorrente])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[MeioPagToStore] CHECK CONSTRAINT [FK_ContaCorrente_MeioPagToStore_IDContaCorrente]
GO
ALTER TABLE [dbo].[MeioPagToStore]  WITH NOCHECK ADD  CONSTRAINT [FK_MeioPag_MeioPagToStore_IDMeioPag] FOREIGN KEY([IDMeioPag])
REFERENCES [dbo].[MeioPag] ([IDMeioPag])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[MeioPagToStore] CHECK CONSTRAINT [FK_MeioPag_MeioPagToStore_IDMeioPag]
GO
ALTER TABLE [dbo].[MeioPagToStore]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_MeioPagToStore_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[MeioPagToStore] CHECK CONSTRAINT [FK_Store_MeioPagToStore_IDStore]
GO
