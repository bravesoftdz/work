USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estado](
	[IDEstado] [char](3) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[TaxPerc] [money] NULL,
	[Codigo] [varchar](20) NULL,
	[TaxPerc2] [money] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDEstado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Estado] ADD  CONSTRAINT [DF_Zero22]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Estado] ADD  CONSTRAINT [DF_Zero23]  DEFAULT (0) FOR [Hidden]
GO
