USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_Lot]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_Lot](
	[IDLote] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[Lot] [varchar](50) NULL,
	[ExpirationDate] [datetime] NULL,
	[LotDate] [datetime] NULL,
	[Qty] [decimal](38, 4) NULL,
	[System] [bit] NULL,
	[Hidden] [char](18) NULL,
	[Desativado] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_Lot] PRIMARY KEY CLUSTERED 
(
	[IDLote] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_Lot]  WITH CHECK ADD  CONSTRAINT [FK_Model_Inv_Lot_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Inv_Lot] CHECK CONSTRAINT [FK_Model_Inv_Lot_IDModel]
GO
ALTER TABLE [dbo].[Inv_Lot]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Inv_Lot_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Inv_Lot] CHECK CONSTRAINT [FK_SystemUser_Inv_Lot_IDUser]
GO
ALTER TABLE [dbo].[Inv_Lot] ADD  CONSTRAINT [DF_Zero4038]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Inv_Lot] ADD  CONSTRAINT [DF_Zero4039]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Inv_Lot] ADD  CONSTRAINT [DF_Zero4040]  DEFAULT (0) FOR [Desativado]
GO
