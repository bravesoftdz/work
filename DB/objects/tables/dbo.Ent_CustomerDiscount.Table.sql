USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Ent_CustomerDiscount]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ent_CustomerDiscount](
	[IDTipoPessoa] [int] NOT NULL,
	[IDGroup] [int] NOT NULL,
	[Discount] [dbo].[TPercentual] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKEnt_CustomerDiscount] PRIMARY KEY CLUSTERED 
(
	[IDTipoPessoa] ASC,
	[IDGroup] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ent_CustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_TabGroup_CustomerDiscount_IDGroup] FOREIGN KEY([IDGroup])
REFERENCES [dbo].[TabGroup] ([IDGroup])
GO
ALTER TABLE [dbo].[Ent_CustomerDiscount] CHECK CONSTRAINT [FK_TabGroup_CustomerDiscount_IDGroup]
GO
ALTER TABLE [dbo].[Ent_CustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_TipoPessoa_CustomerDiscount_IDTipoPessoa] FOREIGN KEY([IDTipoPessoa])
REFERENCES [dbo].[TipoPessoa] ([IDTipoPessoa])
GO
ALTER TABLE [dbo].[Ent_CustomerDiscount] CHECK CONSTRAINT [FK_TipoPessoa_CustomerDiscount_IDTipoPessoa]
GO
