USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[InvColor]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InvColor](
	[IDColor] [int] NOT NULL,
	[Color] [varchar](20) NOT NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[System] [bit] NULL,
	[CodColor] [varchar](10) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__InvColor__182C9B23] PRIMARY KEY CLUSTERED 
(
	[IDColor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[InvColor] ADD  CONSTRAINT [DF_Zero4]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[InvColor] ADD  CONSTRAINT [DF_Zero5]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[InvColor] ADD  CONSTRAINT [DF_Zero6]  DEFAULT (0) FOR [System]
GO
