USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Model]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Model](
	[IDModel] [int] NOT NULL,
	[GroupID] [int] NOT NULL,
	[IDUnidade] [int] NULL,
	[IDFabricante] [int] NULL,
	[IDSize] [int] NULL,
	[IDColor] [int] NULL,
	[IDModelParent] [int] NULL,
	[Model] [varchar](30) NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[VendorCost] [money] NULL,
	[FreightCost] [money] NULL,
	[OtherCost] [money] NULL,
	[MarkUp] [money] NULL,
	[SellingPrice] [money] NULL,
	[LastCost] [money] NULL,
	[DateLastCost] [smalldatetime] NULL,
	[DateLastSellingPrice] [smalldatetime] NULL,
	[LastMovDate] [datetime] NULL,
	[Peso] [money] NULL,
	[Avaiable] [money] NULL,
	[SuggRetail] [money] NULL,
	[PVD] [money] NULL,
	[DP] [money] NULL,
	[ES] [money] NULL,
	[PP] [money] NULL,
	[InicioPontoPedido] [datetime] NULL,
	[ClasseABC] [char](1) NULL,
	[AutomaticRequest] [bit] NULL,
	[TR] [int] NULL,
	[ModelType] [char](1) NULL,
	[CustomSalePrice] [bit] NULL,
	[CustomCostPrice] [bit] NULL,
	[CustomSpecialPrice] [bit] NULL,
	[CustomPromotion] [bit] NULL,
	[AvgCost] [money] NULL,
	[System] [bit] NULL,
	[Hidden] [int] NOT NULL,
	[Desativado] [int] NOT NULL,
	[FinalCost]  AS (isnull([VendorCost],0) + isnull([FreightCost],0) + isnull([OtherCost],0)),
	[LargeImage] [varchar](255) NULL,
	[FloatPercent] [int] NULL,
	[LargeImage2] [varchar](255) NULL,
	[ReplacementCost] [money] NULL,
	[NotVerifyQty] [bit] NULL,
	[PromotionPrice] [money] NULL,
	[DiscountPerc] [float] NULL,
	[IDModelGroup] [int] NULL,
	[IDModelSubGroup] [int] NULL,
	[VD] [float] NULL,
	[VP] [float] NULL,
	[SX] [float] NULL,
	[SX2] [float] NULL,
	[Verify] [dbo].[Boolean] NOT NULL,
	[AvgCostTotal] [money] NOT NULL,
	[SendToTrash] [dbo].[Boolean] NOT NULL,
	[IDUserLastSellingPrice] [int] NULL,
	[AskUserOnSale] [dbo].[Boolean] NULL,
	[TotQtyOnHand] [decimal](38, 4) NULL,
	[TotQtyOnRepair] [decimal](38, 4) NULL,
	[TotQtyOnPreSale] [decimal](38, 4) NULL,
	[TotQtyOnPrePurchase] [decimal](38, 4) NULL,
	[TotQtyOnOrder] [decimal](38, 4) NULL,
	[CaseQty] [decimal](38, 4) NULL,
	[UpdatePrice] [bit] NULL,
	[UseScale] [bit] NULL,
	[ScaleValidDay] [int] NULL,
	[UseLot] [bit] NULL,
	[IndicadorProducao] [char](1) NULL,
	[IndicadorAT] [char](1) NULL,
	[IDNCM] [int] NULL,
	[WebDescription] [varchar](255) NULL,
	[Portion] [varchar](100) NULL,
	[IDCFOP] [int] NULL,
	[ServiceMap] [varchar](30) NULL,
	[RequireOnSale] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
	[NoUpdateCatalogs] [bit] NOT NULL,
 CONSTRAINT [PK__Model__6A30C649] PRIMARY KEY CLUSTERED 
(
	[IDModel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Model]  WITH CHECK ADD  CONSTRAINT [FK_Inv_NCM_Model_IDNCM] FOREIGN KEY([IDNCM])
REFERENCES [dbo].[Inv_NCM] ([IDNCM])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_Inv_NCM_Model_IDNCM]
GO
ALTER TABLE [dbo].[Model]  WITH CHECK ADD  CONSTRAINT [FK_InvColor_Model_IDColor] FOREIGN KEY([IDColor])
REFERENCES [dbo].[InvColor] ([IDColor])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_InvColor_Model_IDColor]
GO
ALTER TABLE [dbo].[Model]  WITH CHECK ADD  CONSTRAINT [FK_InvSize_Model_IDSize] FOREIGN KEY([IDSize])
REFERENCES [dbo].[InvSize] ([IDSize])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_InvSize_Model_IDSize]
GO
ALTER TABLE [dbo].[Model]  WITH CHECK ADD  CONSTRAINT [FK_MntCFOP_Model_IDCFOP] FOREIGN KEY([IDCFOP])
REFERENCES [dbo].[Mnt_CFOP] ([IDCFOP])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_MntCFOP_Model_IDCFOP]
GO
ALTER TABLE [dbo].[Model]  WITH NOCHECK ADD  CONSTRAINT [FK_ModelGroup_Model_IDModelGroup] FOREIGN KEY([IDModelGroup])
REFERENCES [dbo].[ModelGroup] ([IDModelGroup])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_ModelGroup_Model_IDModelGroup]
GO
ALTER TABLE [dbo].[Model]  WITH NOCHECK ADD  CONSTRAINT [FK_ModelSubGroup_Model_IDModelSubGroup] FOREIGN KEY([IDModelSubGroup])
REFERENCES [dbo].[ModelSubGroup] ([IDModelSubGroup])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_ModelSubGroup_Model_IDModelSubGroup]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero45]  DEFAULT (0) FOR [VendorCost]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero46]  DEFAULT (0) FOR [FreightCost]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero47]  DEFAULT (0) FOR [OtherCost]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero48]  DEFAULT (0) FOR [MarkUp]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero49]  DEFAULT (0) FOR [SellingPrice]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero50]  DEFAULT (0) FOR [LastCost]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF__Model__ClasseABC]  DEFAULT ('C') FOR [ClasseABC]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Model_AutomaticRequest001]  DEFAULT (1) FOR [AutomaticRequest]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF__Model__TR]  DEFAULT (3) FOR [TR]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DEF_R]  DEFAULT ('R') FOR [ModelType]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero52]  DEFAULT (0) FOR [CustomSalePrice]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero53]  DEFAULT (0) FOR [CustomCostPrice]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero54]  DEFAULT (0) FOR [CustomSpecialPrice]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero55]  DEFAULT (0) FOR [CustomPromotion]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero56]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero57]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero58]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Model] ADD  DEFAULT (0) FOR [FloatPercent]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero1008]  DEFAULT (0) FOR [NotVerifyQty]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Model_Verify_Zero]  DEFAULT (0) FOR [Verify]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Model_AvgCostTotal_Zero]  DEFAULT (0) FOR [AvgCostTotal]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Model_SendToTrash_Zero]  DEFAULT (0) FOR [SendToTrash]
GO
ALTER TABLE [dbo].[Model] ADD  DEFAULT (0) FOR [AskUserOnSale]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_ZERO51]  DEFAULT (0) FOR [TotQtyOnHand]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero3706]  DEFAULT (0) FOR [UpdatePrice]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero3707]  DEFAULT (0) FOR [UseScale]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF_Zero4083]  DEFAULT (0) FOR [UseLot]
GO
ALTER TABLE [dbo].[Model] ADD  DEFAULT (NULL) FOR [ServiceMap]
GO
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [DF__Model__NoUpdateCatalogs]  DEFAULT ((0)) FOR [NoUpdateCatalogs]
GO
