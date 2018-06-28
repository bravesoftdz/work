USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InvFeatures]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvFeatures](
	[IDInvFeatures] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[Feature] [varchar](255) NOT NULL,
	[System] [bit] NOT NULL,
	[Hidden] [bit] NOT NULL,
	[Desativado] [bit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInvFeatures] PRIMARY KEY CLUSTERED 
(
	[IDInvFeatures] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[InvFeatures]  WITH CHECK ADD  CONSTRAINT [FK_Model_InvFeatures_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[InvFeatures] CHECK CONSTRAINT [FK_Model_InvFeatures_IDModel]
GO
ALTER TABLE [dbo].[InvFeatures] ADD  CONSTRAINT [DF_InvFeaturesSystem]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[InvFeatures] ADD  CONSTRAINT [DF_InvFeaturesHidden]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[InvFeatures] ADD  CONSTRAINT [DF_InvFeaturesDesativ]  DEFAULT (0) FOR [Desativado]
GO
