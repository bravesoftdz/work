USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_Microchip]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_Microchip](
	[IDMicrochip] [int] NOT NULL,
	[Microchip] [varchar](50) NULL,
	[Amount] [money] NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[IDModel] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_Microchip] PRIMARY KEY CLUSTERED 
(
	[IDMicrochip] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_Microchip]  WITH CHECK ADD  CONSTRAINT [FK_Model_IDModel_Pet_Microchip_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Pet_Microchip] CHECK CONSTRAINT [FK_Model_IDModel_Pet_Microchip_IDModel]
GO
ALTER TABLE [dbo].[Pet_Microchip] ADD  CONSTRAINT [DF_Zero3352]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Pet_Microchip] ADD  CONSTRAINT [DF_Zero3353]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Pet_Microchip] ADD  CONSTRAINT [DF_Zero3354]  DEFAULT (0) FOR [Desativado]
GO
