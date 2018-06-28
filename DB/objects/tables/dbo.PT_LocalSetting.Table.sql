USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[PT_LocalSetting]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PT_LocalSetting](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PathToSaleExec] [varchar](100) NULL,
	[PuppyInstalled] [bit] NULL,
	[PathToAvail] [varchar](100) NULL,
	[FrequencyPetAvail] [varchar](30) NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[PT_LocalSetting] ADD [MacAddress] [varchar](30) NULL
ALTER TABLE [dbo].[PT_LocalSetting] ADD [ReplLastChange] [datetime] NULL
ALTER TABLE [dbo].[PT_LocalSetting] ADD  CONSTRAINT [PT_LocalSetting_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
