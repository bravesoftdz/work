USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_BarcodePrint]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_BarcodePrint](
	[IDBarcode] [dbo].[TBarCode] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Qtd] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKBarcodePrint] PRIMARY KEY CLUSTERED 
(
	[IDBarcode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_BarcodePrint]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_BarcodePrint_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Inv_BarcodePrint] CHECK CONSTRAINT [FK_SystemUser_BarcodePrint_IDUser]
GO
