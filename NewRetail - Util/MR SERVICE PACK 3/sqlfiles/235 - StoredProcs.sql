if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_AddColor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_AddColor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_AddSize]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_AddSize]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Model_quModel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Model_quModel]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Model]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Model]
GO

CREATE PROCEDURE sp_Model_quModel
		(
		@IDModel 	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Join do Model dado com sua categoria

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	01 July	2005		Rodrigo Costa		New Table SubGroup;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT
	TG.Name,
	M.SellingPrice,
	M.Peso,
	M.Description,
	(M.VendorCost+M.OtherCost+M.FreightCost) as CurrentCost,
	M.VendorCost,
	M.OtherCost,
	M.FreightCost,
	M.LastCost,
	M.ReplacementCost,
	SG.SubGroup
FROM
	Model M
	JOIN TabGroup TG ON ( TG.IDGroup = M.GroupID )
	LEFT OUTER JOIN SubGroup SG ON (SG.IDSubGroup = M.IDSubGroup)
WHERE
 	( IDModel = @IDModel )
GO

CREATE PROCEDURE sp_Inventory_AddColor
	(
	@IDModel			int,
	@IDColor			int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        SUMARIO

		- Testa se a cor já existe
		- Atualizo a cor do model

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Cor já existe
	-202  Erro em Atualizo a cor do model
	-203  Erro em Insiro em model
	-204  Erro em EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 Nov  2000		Eduardo Costa		Criação;
	25 June 2001		Davi Gouveia		Log de Return Values
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Model_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
	01 July	2005		Rodrigo Costa		New Table SubGroup
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int

--Declaração de variáveis para o Cursor de Model
DECLARE @Model 			varchar(30)
DECLARE @IDSize 			int 
DECLARE @GroupID 			int 
DECLARE @FreightCost 		money 
DECLARE @OtherCost 			money 
DECLARE @VendorCost 		money 
DECLARE @DateLastCost		smalldatetime 
DECLARE @MarkUp 			money 
DECLARE @SellingPrice 		money 
DECLARE @DateLastSellingPrice 	smalldatetime 
DECLARE @IDFabricante 		int 
DECLARE @Avaiable 			money 
DECLARE @LastCost 			money 
DECLARE @SuggRetail 			money 
DECLARE @AutomaticRequest 		bit 
DECLARE @ModelType 		char(1)
DECLARE @IDModelParent 		int 
DECLARE @CustomSalePrice 		bit 
DECLARE @CustomCostPrice 		bit 
DECLARE @CustomSpecialPrice		bit 
DECLARE @CustomPromotion 		bit 
DECLARE @Desativado 		int 
DECLARE @Hidden 			int
DECLARE @System 			bit 
DECLARE @Description 		varchar (50)
DECLARE @ModelID 			int 
DECLARE @IDSubGroup		int

BEGIN TRAN


-- Testa se a cor já existe
IF EXISTS (SELECT IDModel FROM Model WHERE IDModelParent = @IDModel AND IDColor = @IDColor)
BEGIN
	PRINT 'ERROR: Model already contains this color !'
	SET @ErrorLevel = -201
	GOTO ERRO
END


IF EXISTS(SELECT IDModel FROM Model WHERE IDModelParent = @IDModel AND IDColor IS NULL)
BEGIN
	-- Atualizo a cor do model
	UPDATE
		M
	SET
		M.IDColor = @IDColor
	FROM
		Model M
	WHERE
		M.IDModelParent = @IDModel

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END
ELSE
BEGIN
	-- Insiro em model
--Declaração do Cursor de Model
DECLARE Model_Cursor CURSOR FOR

SELECT
		M.Model,
		@IDColor,
		MS.IDSize,
		M.GroupID,
		M.[Description],
		M.FreightCost,
		M.OtherCost,
		M.VendorCost,
		M.DateLastCost,
		M.MarkUp,
		M.SellingPrice,
		M.DateLastSellingPrice,
		M.IDFabricante,
		M.Avaiable,
		M.LastCost,
		M.SuggRetail,
		M.AutomaticRequest,
		'S',                            -- SUBMODEL
		M.IDModel,
		0,
		0,
		0,
		0,
		M.[System],
		M.Desativado,
		M.Hidden,
		M.IDSubGroup
	FROM
		Model M
		LEFT OUTER JOIN (SELECT IDModelParent, IDSize FROM Model WHERE IDModelParent = @IDModel GROUP BY IDModelParent, IDSize) MS ON (M.IDModel = MS.IDModelParent)
	WHERE
		M.IDModel = @IDModel

OPEN Model_Cursor

--Inicialização de Model_Cursor
FETCH NEXT FROM Model_Cursor INTO
	@Model,
	@IDColor,
	@IDSize,
	@GroupID,
	@Description,
	@FreightCost,
	@OtherCost,
	@VendorCost,
	@DateLastCost,
	@MarkUp,
	@SellingPrice,
	@DateLastSellingPrice,
	@IDFabricante,
	@Avaiable,
	@LastCost,
	@SuggRetail,
	@AutomaticRequest,
	@ModelType,
	@IDModelParent,
	@CustomSalePrice,
	@CustomCostPrice,
	@CustomSpecialPrice,
	@CustomPromotion,
	@System,
	@Desativado,
	@Hidden,
	@IDSubGroup
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	Exec sp_Sis_GetNextCode 'Model.IDModel', @ModelID OUTPUT

	INSERT Model
		(
		IDModel,
		Model,
		IDColor,
		IDSize,
		GroupID,
		Description,
		FreightCost,
		OtherCost,
		VendorCost,
		DateLastCost,
		MarkUp,
		SellingPrice,
		DateLastSellingPrice,
		IDFabricante,
		Avaiable,
		LastCost,
		SuggRetail,
		AutomaticRequest,
		ModelType,
		IDModelParent,
		CustomSalePrice,
		CustomCostPrice,
		CustomSpecialPrice,
		CustomPromotion,
		System,
		Desativado,
		Hidden,
		IDSubGroup
		)
	VALUES 
		(
		@ModelID,
		@Model,
		@IDColor,
		@IDSize,
		@GroupID,
		@Description,
		@FreightCost,
		@OtherCost,
		@VendorCost,
		@DateLastCost,
		@MarkUp,
		@SellingPrice,
		@DateLastSellingPrice,
		@IDFabricante,
		@Avaiable,
		@LastCost,
		@SuggRetail,
		@AutomaticRequest,
		@ModelType,
		@IDModelParent,
		@CustomSalePrice,
		@CustomCostPrice,
		@CustomSpecialPrice,
		@CustomPromotion,
		@System,
		@Desativado,
		@Hidden,
		@IDSubGroup
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Model_Cursor
		DEALLOCATE Model_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	FETCH NEXT FROM Model_Cursor INTO
		@Model,
		@IDColor,
		@IDSize,
		@GroupID,
		@Description,
		@FreightCost,
		@OtherCost,
		@VendorCost,
		@DateLastCost,
		@MarkUp,
		@SellingPrice,
		@DateLastSellingPrice,
		@IDFabricante,
		@Avaiable,
		@LastCost,
		@SuggRetail,
		@AutomaticRequest,
		@ModelType,
		@IDModelParent,
		@CustomSalePrice,
		@CustomCostPrice,
		@CustomSpecialPrice,
		@CustomPromotion,
		@System,
		@Desativado,
		@Hidden,
		@IDSubGroup
END
--fechamento do cursor
CLOSE Model_Cursor
--Destruição do cursor
DEALLOCATE Model_Cursor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END
END


EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel

IF @ErrorLevel <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_AddColor', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_AddSize
	(
	@IDModel	int,
	@IDSize	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa qual das sub's devo rodar
		- Atualizo o model


	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-204  Size exist
	-201  Erro em Atualizo o model
	-202  Erro em Insiro submodel
	-203  Erro em EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	29 Nov  2000		Eduardo Costa		Criação;
	25 June 2001		Davi Gouveia		Log de Return Values
	12 August 2003		Rodrigo Costa		Size exist test
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Model_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
	01 July	2005		Rodrigo Costa		New Table SubGroup
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @CurrentNumberOfSize 	int

--Declaração de variáveis para o Cursor de Model
DECLARE @Model 			varchar(30)
DECLARE @IDColor 			int 
DECLARE @GroupID 			int 
DECLARE @FreightCost 		money 
DECLARE @OtherCost 			money 
DECLARE @VendorCost 		money 
DECLARE @DateLastCost		smalldatetime 
DECLARE @MarkUp 			money 
DECLARE @SellingPrice 		money 
DECLARE @DateLastSellingPrice 	smalldatetime 
DECLARE @IDFabricante 		int 
DECLARE @Avaiable 			money 
DECLARE @LastCost 			money 
DECLARE @SuggRetail 			money 
DECLARE @AutomaticRequest 		bit 
DECLARE @ModelType 		char(1)
DECLARE @IDModelParent 		int 
DECLARE @CustomSalePrice 		bit 
DECLARE @CustomCostPrice 		bit 
DECLARE @CustomSpecialPrice		bit 
DECLARE @CustomPromotion 		bit 
DECLARE @Desativado 		int 
DECLARE @Hidden 			int
DECLARE @System 			bit 
DECLARE @Description 		varchar (50)
DECLARE @ModelID 			int 
DECLARE @IDSubGroup		int

BEGIN TRAN

-- Testa se a cor já existe
IF EXISTS (SELECT IDModel FROM Model WHERE IDModelParent = @IDModel AND IDSize = @IDSize)
BEGIN
	PRINT 'ERROR: Model already contains this size !'
	SET @ErrorLevel = -204
	GOTO ERRO
END


-- Testa qual das sub's devo rodar
SELECT
	@CurrentNumberOfSize = COUNT(IDSize)
FROM
	Model
WHERE
	IDModelParent = @IDModel
	AND
	IDSize IS NOT NULL



IF EXISTS(SELECT IDModel FROM Model WHERE IDModelParent = @IDModel AND IDSize IS NULL)
BEGIN
	-- Atualizo o model
	UPDATE
		M
	SET
		M.IDSize = @IDSize
	FROM
		Model M
	WHERE
		M.IDModelParent = @IDModel

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO   ERRO
	END
END
ELSE
BEGIN
	-- Insiro submodel
--Declaração do Cursor de Model

DECLARE Model_Cursor CURSOR FOR
	SELECT
		M.Model,
		MS.IDColor,
		M.GroupID,
		M.Description,
		M.FreightCost,
		M.OtherCost,
		M.VendorCost,
		M.DateLastCost,
		M.MarkUp,
		M.SellingPrice,
		M.DateLastSellingPrice,
		M.IDFabricante,
		M.Avaiable,
		M.LastCost,
		M.SuggRetail,
		M.AutomaticRequest,
		'S',  -- SUBMODEL
		M.IDModel,
		0,
		0,
		0,
		0,
		M.System,
		M.Desativado,
		M.Hidden,
		M.IDSubGroup
	FROM
		Model M
		LEFT OUTER JOIN 
		(SELECT 
			IDModelParent, 
			IDColor 
		FROM 
			Model 
		WHERE 
			IDModelParent = @IDModel 
		GROUP BY 
			IDModelParent, IDColor) MS ON (M.IDModel = MS.IDModelParent)
	WHERE
		M.IDModel = @IDModel


OPEN Model_Cursor

--Inicialização de Model_Cursor
FETCH NEXT FROM Model_Cursor INTO
	@Model,
	@IDColor,
	@GroupID,
	@Description,
	@FreightCost,
	@OtherCost,
	@VendorCost,
	@DateLastCost,
	@MarkUp,
	@SellingPrice,
	@DateLastSellingPrice,
	@IDFabricante,
	@Avaiable,
	@LastCost,
	@SuggRetail,
	@AutomaticRequest,
	@ModelType,
	@IDModelParent,
	@CustomSalePrice,
	@CustomCostPrice,
	@CustomSpecialPrice,
	@CustomPromotion,
	@System,
	@Desativado,
	@Hidden,
	@IDSubGroup
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	Exec sp_Sis_GetNextCode 'Model.IDModel', @ModelID OUTPUT

	INSERT Model
		(
		IDModel,
		Model,
		IDColor,
		IDSize,
		GroupID,
		Description,
		FreightCost,
		OtherCost,
		VendorCost,
		DateLastCost,
		MarkUp,
		SellingPrice,
		DateLastSellingPrice,
		IDFabricante,
		Avaiable,
		LastCost,
		SuggRetail,
		AutomaticRequest,
		ModelType,
		IDModelParent,
		CustomSalePrice,
		CustomCostPrice,
		CustomSpecialPrice,
		CustomPromotion,
		System,
		Desativado,
		Hidden,
		IDSubGroup
		)
	VALUES 
		(
		@ModelID,
		@Model,
		@IDColor,
		@IDSize,
		@GroupID,
		@Description,
		@FreightCost,
		@OtherCost,
		@VendorCost,
		@DateLastCost,
		@MarkUp,
		@SellingPrice,
		@DateLastSellingPrice,
		@IDFabricante,
		@Avaiable,
		@LastCost,
		@SuggRetail,
		@AutomaticRequest,
		@ModelType,
		@IDModelParent,
		@CustomSalePrice,
		@CustomCostPrice,
		@CustomSpecialPrice,
		@CustomPromotion,
		@System,
		@Desativado,
		@Hidden,
		@IDSubGroup
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Model_Cursor
		DEALLOCATE Model_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END
	FETCH NEXT FROM Model_Cursor INTO
		@Model,
		@IDColor,
		@GroupID,
		@Description,
		@FreightCost,
		@OtherCost,
		@VendorCost,
		@DateLastCost,
		@MarkUp,
		@SellingPrice,
		@DateLastSellingPrice,
		@IDFabricante,
		@Avaiable,
		@LastCost,
		@SuggRetail,
		@AutomaticRequest,
		@ModelType,
		@IDModelParent,
		@CustomSalePrice,
		@CustomCostPrice,
		@CustomSpecialPrice,
		@CustomPromotion,
		@System,
		@Desativado,
		@Hidden,
		@IDSubGroup
END
--fechamento do cursor
CLOSE Model_Cursor
--Destruição do cursor
DEALLOCATE Model_Cursor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO   ERRO
	END
END


EXEC @ErrorLevel = sp_Inventory_Sub_AtuModelName @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO   ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_AddSize', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE VIEW vw_Rep_Model AS
SELECT 
	M.IDModel, 
	M.GroupID, 
	M.IDUnidade, 
	M.IDFabricante, 
	M.IDSize, 
	M.IDColor, 
	M.Model, 
	M.Description, 
	M.FreightCost, 
	M.OtherCost, 
	M.VendorCost, 
	M.DateLastCost, 
	M.MarkUp, 
	M.SellingPrice, 
	M.DateLastSellingPrice, 
	M.Peso as Weight, 
	M.Avaiable, 
	M.LastCost, 
	M.SuggRetail, 
	M.VD, 
	M.SX, 
	M.TotQtyOnHand, 
	M.SX2, 
	M.LastMovDate, 
	M.PVD, 
	M.DP, 
	M.ES, 
	M.PP, 
	M.VP, 
	M.InicioPontoPedido, 
	M.ClasseABC, 
	M.AutomaticRequest, 
	M.TR, 
	M.ModelType, 
	M.CustomSalePrice, 
	M.CustomCostPrice, 
	M.CustomSpecialPrice, 
	M.CustomPromotion, 
	M.AvgCost, 
	M.FinalCost, 
	M.Desativado as Deleted, 
	M.ReplacementCost,
	M.LargeImage, 
	M.FloatPercent, 
	M.LargeImage2, 
	M.NotVerifyQty,
	M.IDSubGroup
FROM 
	Model M

GO
