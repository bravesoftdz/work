USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[SerialMov]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SerialMov](
	[InventoryMovID] [int] NOT NULL,
	[SerialNumber] [dbo].[TSerial] NOT NULL,
	[IdentificationNumber] [varchar](30) NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[SerialMov] ADD [processor] [char](1) NULL
ALTER TABLE [dbo].[SerialMov] ADD [ReplLastChange] [datetime] NULL
ALTER TABLE [dbo].[SerialMov] ADD PRIMARY KEY CLUSTERED 
(
	[InventoryMovID] ASC,
	[SerialNumber] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
