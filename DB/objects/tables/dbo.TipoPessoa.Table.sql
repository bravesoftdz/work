USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[TipoPessoa]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoPessoa](
	[IDTipoPessoa] [int] NOT NULL,
	[Path] [varchar](150) NOT NULL,
	[TipoPessoa] [varchar](50) NOT NULL,
	[PathName] [varchar](255) NOT NULL,
	[DefaultDiaPag] [int] NULL,
	[ComissionOnProfit] [bit] NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[LastCode] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__TipoPessoa__33D4B598] PRIMARY KEY CLUSTERED 
(
	[IDTipoPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TipoPessoa] ADD  CONSTRAINT [DF_Zero18]  DEFAULT (0) FOR [ComissionOnProfit]
GO
ALTER TABLE [dbo].[TipoPessoa] ADD  CONSTRAINT [DF_Zero19]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[TipoPessoa] ADD  CONSTRAINT [DF_Zero20]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[TipoPessoa] ADD  CONSTRAINT [DF_Zero21]  DEFAULT (0) FOR [Hidden]
GO
