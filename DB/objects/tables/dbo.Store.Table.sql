USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Store]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Store](
	[IDStore] [int] NOT NULL,
	[IDEmpresa] [int] NULL,
	[IDCentroCusto] [int] NULL,
	[IDTipoConta] [int] NULL,
	[IDContaCorrente] [int] NULL,
	[IDContaCashier] [int] NULL,
	[IDEstado] [char](3) NULL,
	[Name] [varchar](30) NOT NULL,
	[Address] [dbo].[TAddress] NULL,
	[City] [dbo].[TCity] NULL,
	[Zip] [dbo].[TZipCode] NULL,
	[Telephone] [dbo].[TTelephone] NULL,
	[Cellular] [varchar](18) NULL,
	[Beeper] [varchar](25) NULL,
	[Fax] [varchar](40) NULL,
	[Contato] [varchar](50) NULL,
	[System] [bit] NULL,
	[Desativado] [bit] NULL,
	[Hidden] [bit] NULL,
	[TicketHeader] [text] NULL,
	[TicketLayawayFooter] [text] NULL,
	[TicketTaxIsemptFooter] [text] NULL,
	[HourDefault] [varchar](5) NULL,
	[TicketFooter] [text] NULL,
	[PrintTicketHeader] [bit] NULL,
	[PrintLayawayFooter] [bit] NULL,
	[PrintTaxInsemptFooter] [bit] NULL,
	[PrintTicketFooter] [bit] NULL,
	[TicketDetail] [text] NULL,
	[TicketTotals] [text] NULL,
	[Email] [varchar](60) NULL,
	[WebPage] [varchar](80) NULL,
	[Franchise] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Store__49C3F6B7] PRIMARY KEY CLUSTERED 
(
	[IDStore] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Store]  WITH NOCHECK ADD  CONSTRAINT [FK_CentroCusto_Store_IDCentroCusto] FOREIGN KEY([IDCentroCusto])
REFERENCES [dbo].[Fin_CentroCusto] ([IDCentroCusto])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Store] CHECK CONSTRAINT [FK_CentroCusto_Store_IDCentroCusto]
GO
ALTER TABLE [dbo].[Store]  WITH NOCHECK ADD  CONSTRAINT [FK_Estado_Store_IDEstado] FOREIGN KEY([IDEstado])
REFERENCES [dbo].[Estado] ([IDEstado])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Store] CHECK CONSTRAINT [FK_Estado_Store_IDEstado]
GO
ALTER TABLE [dbo].[Store]  WITH NOCHECK ADD  CONSTRAINT [FK_SisEmpresa_Store_IDEmpresa] FOREIGN KEY([IDEmpresa])
REFERENCES [dbo].[Sis_Empresa] ([IDEmpresa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Store] CHECK CONSTRAINT [FK_SisEmpresa_Store_IDEmpresa]
GO
ALTER TABLE [dbo].[Store] ADD  CONSTRAINT [DF_Zero30]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Store] ADD  CONSTRAINT [DF_Zero31]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Store] ADD  CONSTRAINT [DF_Zero32]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Store] ADD  DEFAULT (0) FOR [Franchise]
GO
