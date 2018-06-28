USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[PT_GlobalSettingDetail]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PT_GlobalSettingDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GlobalSettingID] [int] NOT NULL,
	[ServiceMap] [varchar](30) NULL,
	[IdModel] [int] NULL,
	[RequireOnSale] [bit] NULL,
	[price] [money] NULL,
	[description] [varchar](50) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PT_GlobalSettingDetail_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PT_GlobalSettingDetail]  WITH CHECK ADD  CONSTRAINT [PT_GlobalSet_Model_FK] FOREIGN KEY([IdModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[PT_GlobalSettingDetail] CHECK CONSTRAINT [PT_GlobalSet_Model_FK]
GO
