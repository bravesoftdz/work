IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[tr_Model_InsUpt]') AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
DROP TRIGGER [dbo].[tr_Model_InsUpt]
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
	08 Apr	2005		Rodrigo Costa		Removido o codigo para atualizar campo desativado do model size e color
	09 Dez	2008		Rodrigo Costa		Validar produtos na lixeira e ativos
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

-- Be shure there is no duplicated Model

IF @@RowCount = 0
   RETURN -- Nothing to do

IF ISNULL(APP_NAME (), '') = 'MRREPLICATION' 
	RETURN

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
		--AND
		--I.Desativado = 0  AND M.Desativado = 0 -- Both them active
	)
	BEGIN
		RAISERROR ('DUP_Model_Model can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO
