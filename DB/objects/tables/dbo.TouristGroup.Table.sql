USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[TouristGroup]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TouristGroup](
	[IDTouristGroup] [int] NOT NULL,
	[IDGuide] [int] NULL,
	[IDAgency] [int] NULL,
	[IDStore] [int] NOT NULL,
	[IDLancPagGuia] [int] NULL,
	[IDLancPagAgencia] [int] NULL,
	[IDUser] [int] NULL,
	[IDHotel] [int] NULL,
	[IDLastMark] [money] NULL,
	[TipTouristGroup] [varchar](50) NOT NULL,
	[EnterDate] [smalldatetime] NOT NULL,
	[NumTourist] [int] NULL,
	[ComissaoSobreGuia] [money] NULL,
	[DescontaCoordenacao] [bit] NULL,
	[Permanente] [bit] NULL,
	[DiasValidade] [int] NULL,
	[TipGuide] [varchar](30) NULL,
	[TipAgency] [varchar](30) NULL,
	[OtherExpences] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK_NewTouristGroup_1__42] PRIMARY KEY CLUSTERED 
(
	[IDTouristGroup] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TouristGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_Hotel_TouristGroup_IDHotel] FOREIGN KEY([IDHotel])
REFERENCES [dbo].[Hotel] ([IDHotel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TouristGroup] CHECK CONSTRAINT [FK_Hotel_TouristGroup_IDHotel]
GO
ALTER TABLE [dbo].[TouristGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_TouristGroup_IDAgency] FOREIGN KEY([IDAgency])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TouristGroup] CHECK CONSTRAINT [FK_Pessoa_TouristGroup_IDAgency]
GO
ALTER TABLE [dbo].[TouristGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_TouristGroup_IDGuide] FOREIGN KEY([IDGuide])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TouristGroup] CHECK CONSTRAINT [FK_Pessoa_TouristGroup_IDGuide]
GO
ALTER TABLE [dbo].[TouristGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_TourGroup_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TouristGroup] CHECK CONSTRAINT [FK_Store_TourGroup_IDStore]
GO
ALTER TABLE [dbo].[TouristGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_TouristGroup_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TouristGroup] CHECK CONSTRAINT [FK_SystemUser_TouristGroup_IDUser]
GO
ALTER TABLE [dbo].[TouristGroup] ADD  CONSTRAINT [DF_GetDate]  DEFAULT (getdate()) FOR [EnterDate]
GO
ALTER TABLE [dbo].[TouristGroup] ADD  CONSTRAINT [DF_Zero91]  DEFAULT (0) FOR [Permanente]
GO
