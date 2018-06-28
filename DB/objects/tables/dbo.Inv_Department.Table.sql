USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Inv_Department]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inv_Department](
	[IDDepartment] [int] NOT NULL,
	[Department] [varchar](50) NOT NULL,
	[System] [dbo].[Boolean] NOT NULL,
	[Hidden] [dbo].[Boolean] NOT NULL,
	[Desativado] [dbo].[Boolean] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKInv_Department] PRIMARY KEY CLUSTERED 
(
	[IDDepartment] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inv_Department] ADD  CONSTRAINT [DF_InvDepartment_System_Zero]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Inv_Department] ADD  CONSTRAINT [DF_InvDepartment_Hidden_Zero]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Inv_Department] ADD  CONSTRAINT [DF_InvDepartment_Desativado_Zero]  DEFAULT (0) FOR [Desativado]
GO
