USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Rep_Field]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rep_Field](
	[TableName] [varchar](60) NOT NULL,
	[FieldName] [varchar](60) NOT NULL,
	[FieldAlias] [varchar](60) NULL,
	[Selectable] [char](1) NULL,
	[Searchable] [char](1) NULL,
	[Sortable] [char](1) NULL,
	[DataType] [varchar](60) NULL,
	[AutoSearch] [char](1) NULL,
	[Mandatory] [char](1) NULL,
	[DataModule] [varchar](100) NULL,
	[DataSet] [varchar](100) NULL,
	[ListField] [varchar](100) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKRep_Field] PRIMARY KEY CLUSTERED 
(
	[TableName] ASC,
	[FieldName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
