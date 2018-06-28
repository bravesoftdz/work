USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_ColorSpecies]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pet_ColorSpecies](
	[IDSpecies] [int] NOT NULL,
	[IDColor] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_ColorSpecies] PRIMARY KEY CLUSTERED 
(
	[IDSpecies] ASC,
	[IDColor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pet_ColorSpecies]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Color_IDColor_Pet_ColorSpecies_IDColor] FOREIGN KEY([IDColor])
REFERENCES [dbo].[Pet_Color] ([IDColor])
GO
ALTER TABLE [dbo].[Pet_ColorSpecies] CHECK CONSTRAINT [FK_Pet_Color_IDColor_Pet_ColorSpecies_IDColor]
GO
ALTER TABLE [dbo].[Pet_ColorSpecies]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_ColorSpecies_IDSpecies] FOREIGN KEY([IDSpecies])
REFERENCES [dbo].[Pet_Species] ([IDSpecies])
GO
ALTER TABLE [dbo].[Pet_ColorSpecies] CHECK CONSTRAINT [FK_Pet_Species_IDSpecies_Pet_ColorSpecies_IDSpecies]
GO
