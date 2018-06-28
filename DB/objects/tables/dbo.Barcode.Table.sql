USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Barcode]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Barcode](
	[IDBarcode] [dbo].[TBarCode] NOT NULL,
	[IDModel] [int] NOT NULL,
	[Data] [smalldatetime] NULL,
	[BarcodeOrder] [int] NOT NULL,
	[Qty] [float] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_Barcode_IDBarcode] PRIMARY KEY CLUSTERED 
(
	[IDBarcode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Barcode]  WITH CHECK ADD  CONSTRAINT [FK_Model_Barcode_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Barcode] CHECK CONSTRAINT [FK_Model_Barcode_IDModel]
GO
ALTER TABLE [dbo].[Barcode] ADD  CONSTRAINT [DF_GetDate3]  DEFAULT (getdate()) FOR [Data]
GO
