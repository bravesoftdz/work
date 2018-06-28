USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Ser_SOItemDefect]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ser_SOItemDefect](
	[IDSOItemDefect] [int] NOT NULL,
	[IDDefectType] [int] NULL,
	[IDSOItem] [int] NULL,
	[Type] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSer_SOItemDefect] PRIMARY KEY CLUSTERED 
(
	[IDSOItemDefect] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ser_SOItemDefect]  WITH CHECK ADD  CONSTRAINT [FK_Inv_DefectType_Ser_SOItemdefect_IDdefectType] FOREIGN KEY([IDDefectType])
REFERENCES [dbo].[Inv_DefectType] ([IDDefectType])
GO
ALTER TABLE [dbo].[Ser_SOItemDefect] CHECK CONSTRAINT [FK_Inv_DefectType_Ser_SOItemdefect_IDdefectType]
GO
ALTER TABLE [dbo].[Ser_SOItemDefect]  WITH CHECK ADD  CONSTRAINT [FK_Ser_SOItem_Ser_SOItemDefect_IDSOItem] FOREIGN KEY([IDSOItem])
REFERENCES [dbo].[Ser_SOItem] ([IDSOItem])
GO
ALTER TABLE [dbo].[Ser_SOItemDefect] CHECK CONSTRAINT [FK_Ser_SOItem_Ser_SOItemDefect_IDSOItem]
GO
