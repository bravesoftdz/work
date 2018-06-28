IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[tr_SpecialPrice_insert]') AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
DROP TRIGGER [dbo].[tr_SpecialPrice_insert]
GO

CREATE TRIGGER tr_SpecialPrice_insert ON dbo.SpecialPrice
FOR INSERT, UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do SpecialPrice
		- Insiro em SpecialPriceByGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@RowCount = 0
   return

IF ISNULL(APP_NAME (), '') = 'MRREPLICATION' 
	RETURN

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDSpecialPrice
		FROM
			INSERTED,
			SpecialPrice
		WHERE
			INSERTED.SpecialPrice = SpecialPrice.SpecialPrice
			AND
			SpecialPrice.IDSpecialPrice <> INSERTED.IDSpecialPrice
			AND
			INSERTED.Desativado = 0
			AND
			SpecialPrice.Desativado = 0
			)
	BEGIN
		RAISERROR ('DUP_SpecialPrice_SpecialPrice can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */

if 	NOT EXISTS
			(
			SELECT
				Deleted.IDSpecialPrice
			FROM
				Deleted
			)
	BEGIN
		INSERT
			SpecialPriceByGroup
			(
				SpecialPriceID,
				GroupID,
				SpecialMarkUp
			)
			SELECT
				Inserted.IDSpecialPrice,
				TabGroup.IDGroup,
				0
			FROM
				TabGroup,
				Inserted
			WHERE
				TabGroup.Desativado = 0
	END
GO