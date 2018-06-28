USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[DeliverType]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeliverType](
	[IDDeliverType] [int] NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[CanConfirmDeliver] [dbo].[TBit] NULL,
	[MaxDeliverDelay] [int] NOT NULL,
	[CanExchangeItem] [bit] NULL,
	[Website] [varchar](100) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_DeliverType_IDDeliverType] PRIMARY KEY CLUSTERED 
(
	[IDDeliverType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[DeliverType] ADD  CONSTRAINT [DF_Zero85]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[DeliverType] ADD  CONSTRAINT [DF_Zero86]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[DeliverType] ADD  CONSTRAINT [DF_Zero87]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[DeliverType] ADD  DEFAULT (0) FOR [CanConfirmDeliver]
GO
ALTER TABLE [dbo].[DeliverType] ADD  DEFAULT (0) FOR [MaxDeliverDelay]
GO
