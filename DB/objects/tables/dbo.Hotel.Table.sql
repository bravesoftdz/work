USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Hotel]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Hotel](
	[IDHotel] [int] NOT NULL,
	[Hotel] [varchar](50) NOT NULL,
	[Endereco] [dbo].[TAddress] NULL,
	[Cidade] [dbo].[TCity] NULL,
	[CEP] [dbo].[TZipCode] NULL,
	[Telefone] [dbo].[TTelephone] NULL,
	[Fax] [dbo].[TTelephone] NULL,
	[OBS] [varchar](255) NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_Hotel_1__21] PRIMARY KEY CLUSTERED 
(
	[IDHotel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Hotel] ADD  CONSTRAINT [DF_Zero88]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Hotel] ADD  CONSTRAINT [DF_Zero89]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Hotel] ADD  CONSTRAINT [DF_Zero90]  DEFAULT (0) FOR [Hidden]
GO
