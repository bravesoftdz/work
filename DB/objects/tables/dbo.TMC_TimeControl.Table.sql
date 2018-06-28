USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[TMC_TimeControl]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMC_TimeControl](
	[IDTime] [int] NOT NULL,
	[IDStore] [int] NULL,
	[IDUser] [int] NULL,
	[IDPessoa] [int] NULL,
	[EnterDate] [datetime] NULL,
	[ExitDate] [datetime] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__TMC_TimeControl__178D7CA5] PRIMARY KEY CLUSTERED 
(
	[IDTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TMC_TimeControl]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_TMCTimeControl_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TMC_TimeControl] CHECK CONSTRAINT [FK_Pessoa_TMCTimeControl_IDPessoa]
GO
ALTER TABLE [dbo].[TMC_TimeControl]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_TMCTimeControl_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TMC_TimeControl] CHECK CONSTRAINT [FK_Store_TMCTimeControl_IDStore]
GO
ALTER TABLE [dbo].[TMC_TimeControl]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_TMCTimeControl_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TMC_TimeControl] CHECK CONSTRAINT [FK_SystemUser_TMCTimeControl_IDUser]
GO
