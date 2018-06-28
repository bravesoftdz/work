USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_WarrantyReport]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_WarrantyReport](
	[IDWarrantyReport] [int] NOT NULL,
	[IDSpecies] [int] NOT NULL,
	[Report] [image] NULL,
	[ReportName] [varchar](30) NULL,
	[ReportDate] [datetime] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_WarrantyReport] PRIMARY KEY CLUSTERED 
(
	[IDWarrantyReport] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_WarrantyReport]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_WarrantyReport_IDSpecies] FOREIGN KEY([IDSpecies])
REFERENCES [dbo].[Pet_Species] ([IDSpecies])
GO
ALTER TABLE [dbo].[Pet_WarrantyReport] CHECK CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_WarrantyReport_IDSpecies]
GO
