USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ModelSubGroup]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ModelSubGroup](
	[IDModelSubGroup] [int] NOT NULL,
	[IDModelGroup] [int] NULL,
	[ModelSubGroup] [varchar](30) NULL,
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
 CONSTRAINT [XPKModelSubGroup] PRIMARY KEY CLUSTERED 
(
	[IDModelSubGroup] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ModelSubGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_MargemTable_ModelSubGroup_IDMSRPMargemTable] FOREIGN KEY([IDMSRPMargemTable])
REFERENCES [dbo].[MargemTable] ([IDMargemTable])
GO
ALTER TABLE [dbo].[ModelSubGroup] CHECK CONSTRAINT [FK_MargemTable_ModelSubGroup_IDMSRPMargemTable]
GO
ALTER TABLE [dbo].[ModelSubGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_MargemTable_ModelSubGroup_IDSalePriceMargemTable] FOREIGN KEY([IDSalePriceMargemTable])
REFERENCES [dbo].[MargemTable] ([IDMargemTable])
GO
ALTER TABLE [dbo].[ModelSubGroup] CHECK CONSTRAINT [FK_MargemTable_ModelSubGroup_IDSalePriceMargemTable]
GO
ALTER TABLE [dbo].[ModelSubGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_ModelGroup_ModelSubGroup_IDModelGroup] FOREIGN KEY([IDModelGroup])
REFERENCES [dbo].[ModelGroup] ([IDModelGroup])
GO
ALTER TABLE [dbo].[ModelSubGroup] CHECK CONSTRAINT [FK_ModelGroup_ModelSubGroup_IDModelGroup]
GO
ALTER TABLE [dbo].[ModelSubGroup] ADD  CONSTRAINT [DF_Zero1416]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[ModelSubGroup] ADD  CONSTRAINT [DF_Zero1417]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[ModelSubGroup] ADD  CONSTRAINT [DF_Zero1418]  DEFAULT (0) FOR [Desativado]
GO
