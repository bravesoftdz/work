SET QUOTED_IDENTIFIER ON
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

SET ARITHABORT ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

SET CONCAT_NULL_YIELDS_NULL ON
GO

SET ANSI_NULLS ON
GO

SET ANSI_PADDING ON
GO

SET ANSI_WARNINGS ON
GO

CREATE TABLE dbo.Tmp_Model
	(
	IDModel int NOT NULL,
	GroupID int NOT NULL,
	IDUnidade int NULL,
	IDFabricante int NULL,
	IDSize int NULL,
	IDColor int NULL,
	IDModelParent int NULL,
	Model varchar(30) NOT NULL,
	Description varchar(50) NOT NULL,
	VendorCost money NULL,
	FreightCost money NULL,
	OtherCost money NULL,
	MarkUp money NULL,
	SellingPrice money NULL,
	LastCost money NULL,
	DateLastCost smalldatetime NULL,
	DateLastSellingPrice smalldatetime NULL,
	LastMovDate datetime NULL,
	Peso money NULL,
	Avaiable money NULL,
	SuggRetail money NULL,
	VD int NULL,
	SX int NULL,
	TotQtyOnHand int NOT NULL,
	SX2 int NULL,
	PVD money NULL,
	DP money NULL,
	ES money NULL,
	PP money NULL,
	VP int NULL,
	InicioPontoPedido datetime NULL,
	ClasseABC char(1) NULL,
	AutomaticRequest bit NULL,
	TR int NULL,
	ModelType char(1) NULL,
	CustomSalePrice bit NULL,
	CustomCostPrice bit NULL,
	CustomSpecialPrice bit NULL,
	CustomPromotion bit NULL,
	AvgCost money NULL,
	TotQtyOnRepair int NULL,
	TotQtyOnPreSale int NULL,
	TotQtyOnPrePurchase int NULL,
	TotQtyOnOrder int NULL,
	System bit NULL,
	Hidden int NOT NULL,
	Desativado int NOT NULL,
	FinalCost  AS (isnull([VendorCost],0) + isnull([FreightCost],0) + isnull([OtherCost],0))
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Model)
	 EXEC('INSERT INTO dbo.Tmp_Model (IDModel, GroupID, IDUnidade, IDFabricante, IDSize, IDColor, IDModelParent, Model, Description, VendorCost, FreightCost, OtherCost, MarkUp, SellingPrice, LastCost, DateLastCost, DateLastSellingPrice, LastMovDate, Peso, Avaiable, SuggRetail, VD, SX, TotQtyOnHand, SX2, PVD, DP, ES, PP, VP, InicioPontoPedido, ClasseABC, AutomaticRequest, TR, ModelType, CustomSalePrice, CustomCostPrice, CustomSpecialPrice, CustomPromotion, AvgCost, TotQtyOnRepair, TotQtyOnPreSale, TotQtyOnPrePurchase, TotQtyOnOrder, System, Hidden, Desativado)
		SELECT IDModel, GroupID, IDUnidade, IDFabricante, IDSize, IDColor, IDModelParent, Model, Description, VendorCost, FreightCost, OtherCost, MarkUp, SellingPrice, LastCost, DateLastCost, DateLastSellingPrice, LastMovDate, Peso, Avaiable, SuggRetail, VD, SX, TotQtyOnHand, SX2, PVD, DP, ES, PP, VP, InicioPontoPedido, ClasseABC, AutomaticRequest, TR, ModelType, CustomSalePrice, CustomCostPrice, CustomSpecialPrice, CustomPromotion, AvgCost, TotQtyOnRepair, TotQtyOnPreSale, TotQtyOnPrePurchase, TotQtyOnOrder, System, Hidden, Desativado FROM dbo.Model TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Model'
EXEC(@temp)
GO

DROP TABLE dbo.Model
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero45 DEFAULT (0) FOR VendorCost
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero46 DEFAULT (0) FOR FreightCost
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero47 DEFAULT (0) FOR OtherCost
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero48 DEFAULT (0) FOR MarkUp
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero49 DEFAULT (0) FOR SellingPrice
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero50 DEFAULT (0) FOR LastCost
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero51 DEFAULT (0) FOR TotQtyOnHand
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF__Model__ClasseABC DEFAULT ('C') FOR ClasseABC
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Model_AutomaticRequest001 DEFAULT (1) FOR AutomaticRequest
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF__Model__TR DEFAULT (3) FOR TR
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DEF_R DEFAULT ('R') FOR ModelType
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero52 DEFAULT (0) FOR CustomSalePrice
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero53 DEFAULT (0) FOR CustomCostPrice
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero54 DEFAULT (0) FOR CustomSpecialPrice
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero55 DEFAULT (0) FOR CustomPromotion
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero56 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero57 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_Model ADD CONSTRAINT
	DF_Zero58 DEFAULT (0) FOR Desativado
GO

EXECUTE sp_rename N'dbo.Tmp_Model', N'Model', 'OBJECT'
GO

ALTER TABLE dbo.Model ADD CONSTRAINT
	PK__Model__6A30C649 PRIMARY KEY CLUSTERED 
	(
	IDModel
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX LAST_DATE ON dbo.Model
	(
	DateLastCost
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIE_Model_Combo ON dbo.Model
	(
	Model,
	Desativado,
	Hidden
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIE_Model_Model ON dbo.Model
	(
	Model
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF112Model ON dbo.Model
	(
	IDFabricante
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF113Model ON dbo.Model
	(
	IDUnidade
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF114Model ON dbo.Model
	(
	GroupID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF393Model ON dbo.Model
	(
	IDModelParent
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF417Model ON dbo.Model
	(
	IDColor
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF418Model ON dbo.Model
	(
	IDSize
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_InvColor_Model_IDColor FOREIGN KEY
	(
	IDColor
	) REFERENCES dbo.InvColor
	(
	IDColor
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_Model_Model_IDModelParent FOREIGN KEY
	(
	IDModelParent
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_TabGroup_Model_GroupID FOREIGN KEY
	(
	GroupID
	) REFERENCES dbo.TabGroup
	(
	IDGroup
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_Unidade_Model_IDUnidade FOREIGN KEY
	(
	IDUnidade
	) REFERENCES dbo.Unidade
	(
	IDUnidade
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Model_IDFabricante FOREIGN KEY
	(
	IDFabricante
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_InvSize_Model_IDSize FOREIGN KEY
	(
	IDSize
	) REFERENCES dbo.InvSize
	(
	IDSize
	) NOT FOR REPLICATION
GO

CREATE TRIGGER  tr_Model_InsUpt on dbo.Model
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Be shure there is no duplicated Model
		- If deactivate the master model l, deactivate all submodels


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

-- Be shure there is no duplicated Model

IF @@RowCount = 0
   RETURN -- Nothing to do

SET NOCOUNT ON

IF EXISTS
	(
	SELECT
		I.IDModel
	FROM
		INSERTED I,
		Model M
	WHERE
		I.Model = M.Model -- The same code
		AND
		I.IDModel <> M.IDModel	 -- With other model
		AND
		I.ModelType <> 'S'   -- Not a SubModel
		AND
		M.ModelType <> 'S'   -- Not a SubModel
		AND
		I.Desativado = 0  AND M.Desativado = 0 -- Both them active
	)
	BEGIN
		RAISERROR ('DUP_Model_Model can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

-- If deactivate the master model l, deactivate all submodels

UPDATE
	SM
SET
	SM.Desativado = MM.Desativado
FROM
	Inserted MM
	JOIN Model SM ON (MM.IDModel = SM.IDModelParent)
GO

ALTER TABLE dbo.Pur_PurchaseQtyPrePurchase WITH NOCHECK ADD CONSTRAINT
	FK_Model_PurchaseQtyPrePurchase_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.GroupCostGift WITH NOCHECK ADD CONSTRAINT
	FK_Model_GroupCostGift_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.ModelTransfDet WITH NOCHECK ADD CONSTRAINT
	FK_Model_ModelTransfDet_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventorySerial WITH NOCHECK ADD CONSTRAINT
	FK_Model_InventorySerial_IDModel FOREIGN KEY
	(
	ModelID
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_PurchaseItem WITH NOCHECK ADD CONSTRAINT
	FK_Model_PurchaseItem_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.KitModel WITH NOCHECK ADD CONSTRAINT
	FK_Model_KitModel_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.CotacaoToModel WITH NOCHECK ADD CONSTRAINT
	FK_Model_CotacaoToModel_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.CotacaoResult WITH NOCHECK ADD CONSTRAINT
	FK_Model_CotacaoResult_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Barcode WITH NOCHECK ADD CONSTRAINT
	FK_Model_BarCode_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Request WITH NOCHECK ADD CONSTRAINT
	FK_Model_Request_ModelID FOREIGN KEY
	(
	ModelID
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_PurchaseQtyOrder WITH NOCHECK ADD CONSTRAINT
	FK_Model_PurchaseQtyOrder_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Model_PreInventMov_ModelID FOREIGN KEY
	(
	ModelID
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Model_InventoryMov_ModelID FOREIGN KEY
	(
	ModelID
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Inventory WITH NOCHECK ADD CONSTRAINT
	FK_Model_Inventory_ModelID FOREIGN KEY
	(
	ModelID
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_Model_Repair_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

