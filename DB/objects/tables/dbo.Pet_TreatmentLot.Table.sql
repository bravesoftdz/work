USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pet_TreatmentLot]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pet_TreatmentLot](
	[IDTreatmentLot] [int] NOT NULL,
	[IDTreatment] [int] NOT NULL,
	[LotNumber] [varchar](30) NULL,
	[ExpirationDate] [datetime] NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPet_TreatmentLot] PRIMARY KEY CLUSTERED 
(
	[IDTreatmentLot] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pet_TreatmentLot]  WITH CHECK ADD  CONSTRAINT [FK_Pet_Treatment_IDTreatment_Pet_TreatmentLot_IDTreatment] FOREIGN KEY([IDTreatment])
REFERENCES [dbo].[Pet_Treatment] ([IDTreatment])
GO
ALTER TABLE [dbo].[Pet_TreatmentLot] CHECK CONSTRAINT [FK_Pet_Treatment_IDTreatment_Pet_TreatmentLot_IDTreatment]
GO
ALTER TABLE [dbo].[Pet_TreatmentLot] ADD  CONSTRAINT [DF_Zero3397]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Pet_TreatmentLot] ADD  CONSTRAINT [DF_Zero3398]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Pet_TreatmentLot] ADD  CONSTRAINT [DF_Zero3399]  DEFAULT (0) FOR [Desativado]
GO
