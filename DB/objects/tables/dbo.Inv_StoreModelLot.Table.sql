USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_StoreModelLot]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inv_StoreModelLot](
	[IDLote] [int] NOT NULL,
	[IDStore] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[Qty] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_StoreModelLot] PRIMARY KEY CLUSTERED 
(
	[IDLote] ASC,
	[IDStore] ASC,
	[IDModel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Inv_StoreModelLot]  WITH CHECK ADD  CONSTRAINT [FK_Inv_Model_Inv_StoreModelLot_IDLot] FOREIGN KEY([IDLote])
REFERENCES [dbo].[Inv_Lot] ([IDLote])
GO
ALTER TABLE [dbo].[Inv_StoreModelLot] CHECK CONSTRAINT [FK_Inv_Model_Inv_StoreModelLot_IDLot]
GO
ALTER TABLE [dbo].[Inv_StoreModelLot]  WITH CHECK ADD  CONSTRAINT [FK_Model_Inv_StoreModelLot_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Inv_StoreModelLot] CHECK CONSTRAINT [FK_Model_Inv_StoreModelLot_IDModel]
GO
ALTER TABLE [dbo].[Inv_StoreModelLot]  WITH CHECK ADD  CONSTRAINT [FK_Store_Inv_StoreModelLot_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
GO
ALTER TABLE [dbo].[Inv_StoreModelLot] CHECK CONSTRAINT [FK_Store_Inv_StoreModelLot_IDStore]
GO
