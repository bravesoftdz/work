USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ModelTransf]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ModelTransf](
	[IDModelTransf] [int] NOT NULL,
	[IDLojaOrigem] [int] NOT NULL,
	[IDLojaDestino] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[Data] [smalldatetime] NOT NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[Number] [varchar](20) NULL,
	[TransferType] [bit] NULL,
	[Imported] [bit] NULL,
	[PrintDate] [datetime] NULL,
	[IDCFOP] [int] NULL,
	[OBS] [varchar](255) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__ModelTransf__0A338187] PRIMARY KEY CLUSTERED 
(
	[IDModelTransf] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ModelTransf]  WITH CHECK ADD  CONSTRAINT [FK_MntCFOP_ModelTransf_IDCFOP] FOREIGN KEY([IDCFOP])
REFERENCES [dbo].[Mnt_CFOP] ([IDCFOP])
GO
ALTER TABLE [dbo].[ModelTransf] CHECK CONSTRAINT [FK_MntCFOP_ModelTransf_IDCFOP]
GO
ALTER TABLE [dbo].[ModelTransf]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_ModelTransf_IDLojaDestino] FOREIGN KEY([IDLojaDestino])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ModelTransf] CHECK CONSTRAINT [FK_Store_ModelTransf_IDLojaDestino]
GO
ALTER TABLE [dbo].[ModelTransf]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_ModelTransf_IDLojaOrigem] FOREIGN KEY([IDLojaOrigem])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ModelTransf] CHECK CONSTRAINT [FK_Store_ModelTransf_IDLojaOrigem]
GO
ALTER TABLE [dbo].[ModelTransf]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_ModelTransf_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ModelTransf] CHECK CONSTRAINT [FK_SystemUser_ModelTransf_IDUser]
GO
ALTER TABLE [dbo].[ModelTransf] ADD  CONSTRAINT [DF_Zero178]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[ModelTransf] ADD  CONSTRAINT [DF_Zero179]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[ModelTransf] ADD  CONSTRAINT [DF_Zero180]  DEFAULT (0) FOR [Desativado]
GO
