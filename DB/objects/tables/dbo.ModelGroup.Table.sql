USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ModelGroup]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ModelGroup](
	[IDModelGroup] [int] NOT NULL,
	[ModelGroup] [varchar](30) NULL,
	[IDGroup] [int] NULL,
	[UserCode] [varchar](5) NULL,
	[SalePriceMargemPercent] [float] NULL,
	[UseSalePricePercent] [dbo].[TBit] NULL,
	[IDSalePriceMargemTable] [int] NULL,
	[IDMSRPMargemTable] [int] NULL,
	[MSRPMargemPercent] [float] NULL,
	[UseMSRPPercent] [dbo].[TBit] NULL,
	[System] [dbo].[TBit] NOT NULL,
	[Hidden] [dbo].[TBit] NOT NULL,
	[Desativado] [dbo].[TBit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKModelGroup] PRIMARY KEY CLUSTERED 
(
	[IDModelGroup] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ModelGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_MargemTable_ModelGroup_IDMSRPMargemTable] FOREIGN KEY([IDMSRPMargemTable])
REFERENCES [dbo].[MargemTable] ([IDMargemTable])
GO
ALTER TABLE [dbo].[ModelGroup] CHECK CONSTRAINT [FK_MargemTable_ModelGroup_IDMSRPMargemTable]
GO
ALTER TABLE [dbo].[ModelGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_MargemTable_ModelGroup_IDSalePriceMargemTable] FOREIGN KEY([IDSalePriceMargemTable])
REFERENCES [dbo].[MargemTable] ([IDMargemTable])
GO
ALTER TABLE [dbo].[ModelGroup] CHECK CONSTRAINT [FK_MargemTable_ModelGroup_IDSalePriceMargemTable]
GO
ALTER TABLE [dbo].[ModelGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_TabGroup_ModelGroup_IDGroup] FOREIGN KEY([IDGroup])
REFERENCES [dbo].[TabGroup] ([IDGroup])
GO
ALTER TABLE [dbo].[ModelGroup] CHECK CONSTRAINT [FK_TabGroup_ModelGroup_IDGroup]
GO
ALTER TABLE [dbo].[ModelGroup] ADD  CONSTRAINT [DF_Zero1413]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[ModelGroup] ADD  CONSTRAINT [DF_Zero1414]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[ModelGroup] ADD  CONSTRAINT [DF_Zero1415]  DEFAULT (0) FOR [Desativado]
GO
