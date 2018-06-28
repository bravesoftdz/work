USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_Species]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_Species](
	[IDSpecies] [int] NOT NULL,
	[Species] [varchar](50) NOT NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_Species] PRIMARY KEY CLUSTERED 
(
	[IDSpecies] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_Species] ADD  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Pet_Species] ADD  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Pet_Species] ADD  DEFAULT (0) FOR [Desativado]
GO