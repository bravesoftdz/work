USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[GroupToComissionType]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupToComissionType](
	[IDTipoComissionado] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[Comission] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_GroupToComissionType_1__10] PRIMARY KEY CLUSTERED 
(
	[IDTipoComissionado] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GroupToComissionType]  WITH NOCHECK ADD  CONSTRAINT [FK_TabGroup_GroupToComssionType_GroupID] FOREIGN KEY([GroupID])
REFERENCES [dbo].[TabGroup] ([IDGroup])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[GroupToComissionType] CHECK CONSTRAINT [FK_TabGroup_GroupToComssionType_GroupID]
GO
ALTER TABLE [dbo].[GroupToComissionType]  WITH NOCHECK ADD  CONSTRAINT [FK_TipoPessoa_GroupToComissionType_IDTipoComissionado] FOREIGN KEY([IDTipoComissionado])
REFERENCES [dbo].[TipoPessoa] ([IDTipoPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[GroupToComissionType] CHECK CONSTRAINT [FK_TipoPessoa_GroupToComissionType_IDTipoComissionado]
GO
