USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[StoreToTabGroup]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreToTabGroup](
	[IDStore] [int] NOT NULL,
	[IDGroup] [int] NOT NULL,
	[IDTaxCategory] [int] NULL,
	[Visible] [bit] NULL,
	[IDSaleTax] [int] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDStore] ASC,
	[IDGroup] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StoreToTabGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_StoreToTabGroup_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[StoreToTabGroup] CHECK CONSTRAINT [FK_Store_StoreToTabGroup_IDStore]
GO
ALTER TABLE [dbo].[StoreToTabGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_TabGroup_StoreToTabGroup_IDGroup] FOREIGN KEY([IDGroup])
REFERENCES [dbo].[TabGroup] ([IDGroup])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[StoreToTabGroup] CHECK CONSTRAINT [FK_TabGroup_StoreToTabGroup_IDGroup]
GO
ALTER TABLE [dbo].[StoreToTabGroup]  WITH CHECK ADD  CONSTRAINT [FK_TaxCategory_StoreToTabGroup_IDSaleTax] FOREIGN KEY([IDSaleTax])
REFERENCES [dbo].[TaxCategory] ([IDTaxCategory])
GO
ALTER TABLE [dbo].[StoreToTabGroup] CHECK CONSTRAINT [FK_TaxCategory_StoreToTabGroup_IDSaleTax]
GO
ALTER TABLE [dbo].[StoreToTabGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_TaxCategory_StoreToTabGroup_IDTaxCategory] FOREIGN KEY([IDTaxCategory])
REFERENCES [dbo].[TaxCategory] ([IDTaxCategory])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[StoreToTabGroup] CHECK CONSTRAINT [FK_TaxCategory_StoreToTabGroup_IDTaxCategory]
GO
ALTER TABLE [dbo].[StoreToTabGroup] ADD  DEFAULT (1) FOR [Visible]
GO
