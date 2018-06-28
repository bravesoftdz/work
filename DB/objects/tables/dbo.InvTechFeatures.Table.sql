USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InvTechFeatures]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvTechFeatures](
	[IDInvTechFeatures] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[TechFeature] [varchar](255) NOT NULL,
	[System] [bit] NOT NULL,
	[Hidden] [bit] NOT NULL,
	[Desativado] [bit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInvTechFeatures] PRIMARY KEY CLUSTERED 
(
	[IDInvTechFeatures] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[InvTechFeatures]  WITH CHECK ADD  CONSTRAINT [FK_Model_InvTechFeatures_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[InvTechFeatures] CHECK CONSTRAINT [FK_Model_InvTechFeatures_IDModel]
GO
ALTER TABLE [dbo].[InvTechFeatures] ADD  CONSTRAINT [DF_InvTechFeaturesSystem]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[InvTechFeatures] ADD  CONSTRAINT [DF_InvTechFeaturesHidden]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[InvTechFeatures] ADD  CONSTRAINT [DF_InvTechFeaturesDesativ]  DEFAULT (0) FOR [Desativado]
GO
