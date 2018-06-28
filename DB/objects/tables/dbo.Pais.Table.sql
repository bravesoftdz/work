USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pais](
	[IDPais] [int] NOT NULL,
	[CodPais] [varchar](3) NOT NULL,
	[Pais] [varchar](50) NOT NULL,
	[Desativado] [bit] NULL,
	[hidden] [bit] NULL,
	[system] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Pais__3C69FB99] PRIMARY KEY CLUSTERED 
(
	[IDPais] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pais] ADD  CONSTRAINT [DF_Zero24]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Pais] ADD  CONSTRAINT [DF_Zero25]  DEFAULT (0) FOR [hidden]
GO
ALTER TABLE [dbo].[Pais] ADD  CONSTRAINT [DF_Zero26]  DEFAULT (0) FOR [system]
GO