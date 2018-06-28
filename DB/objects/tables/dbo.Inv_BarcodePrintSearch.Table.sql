USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_BarcodePrintSearch]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_BarcodePrintSearch](
	[sequence] [int] IDENTITY(1,1) NOT NULL,
	[IdUser] [int] NOT NULL,
	[IdModel] [int] NOT NULL,
	[model] [varchar](30) NOT NULL,
	[description] [varchar](50) NOT NULL,
	[IdBarcode] [char](20) NOT NULL,
	[qtyOnHand] [decimal](38, 4) NULL,
	[sellingPrice] [money] NULL,
	[numCopy] [int] NULL,
	[report] [varchar](10) NOT NULL,
	[IdSearchType] [int] NOT NULL,
	[StraightToPrinter] [char](1) NULL,
	[PrintQueue] [char](1) NULL,
	[LabelQtyOnHand] [char](1) NULL,
	[PrimaryBarcode] [char](1) NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [LargeImage] [varchar](255) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [LargeImage2] [varchar](255) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [Manufacturer] [varchar](50) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [VendorNum] [varchar](6) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [Vendor] [varchar](50) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [SizeName] [varchar](20) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [Color] [varchar](20) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [CodColor] [varchar](10) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [ModelToScan] [varchar](22) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [BarcodeToScan] [varchar](22) NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD [ReplLastChange] [datetime] NULL
ALTER TABLE [dbo].[Inv_BarcodePrintSearch] ADD  CONSTRAINT [InvBarPrnSearch_PK] PRIMARY KEY CLUSTERED 
(
	[sequence] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
