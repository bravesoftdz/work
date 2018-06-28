USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_ItemRepair]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_ItemRepair](
	[IDItemRepair] [int] NOT NULL,
	[IDPreInventoryMov] [int] NOT NULL,
	[Obs] [varchar](255) NULL,
	[IDDefectType] [int] NOT NULL,
	[RA] [varchar](20) NOT NULL,
	[IDVendor] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_ItemRepair] PRIMARY KEY CLUSTERED 
(
	[IDItemRepair] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_ItemRepair]  WITH CHECK ADD  CONSTRAINT [FK_InvDefectType_SalItemRepair_IDDefectType] FOREIGN KEY([IDDefectType])
REFERENCES [dbo].[Inv_DefectType] ([IDDefectType])
GO
ALTER TABLE [dbo].[Sal_ItemRepair] CHECK CONSTRAINT [FK_InvDefectType_SalItemRepair_IDDefectType]
GO
ALTER TABLE [dbo].[Sal_ItemRepair]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_SalItemRepair_IDVendor] FOREIGN KEY([IDVendor])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sal_ItemRepair] CHECK CONSTRAINT [FK_Pessoa_SalItemRepair_IDVendor]
GO
