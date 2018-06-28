USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Mnt_DocumentType]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mnt_DocumentType](
	[IDDocumentType] [int] NOT NULL,
	[DocumentType] [varchar](40) NOT NULL,
	[DefaultType] [bit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMnt_DocumentType] PRIMARY KEY CLUSTERED 
(
	[IDDocumentType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Mnt_DocumentType] ADD  CONSTRAINT [DF_MntDocumentType_DefaultType_False]  DEFAULT (0) FOR [DefaultType]
GO
