if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_TipoPessoa_InsUpt]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_TipoPessoa_InsUpt]
GO

CREATE TRIGGER tr_TipoPessoa_InsUpt ON dbo.TipoPessoa
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do TipoPessoa
		- Incluo em GroupToComissionType


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDTipoPessoa
		FROM
			INSERTED,
			TipoPessoa
		WHERE
			INSERTED.TipoPessoa = TipoPessoa.TipoPessoa
			AND
			INSERTED.Path = TipoPessoa.Path
			AND
			TipoPessoa.IDTipoPessoa <> INSERTED.IDTipoPessoa
			AND
			INSERTED.Desativado = 0
			AND
			TipoPessoa.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_TipoPessoa_TipoPessoa can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */
if 	NOT EXISTS
		(
		SELECT
			Deleted.IDTipoPessoa
		FROM
			Deleted
		)
	BEGIN
		INSERT
			GroupToComissionType
			(IDTipoComissionado, GroupID, Comission)
		SELECT
			Inserted.IDTipoPessoa,
			TabGroup.IDGroup,
			0
		FROM
			TabGroup,
			Inserted
		WHERE
			(TabGroup.Desativado = 0)
			AND (INSERTED.Path like '.003.%')
			AND NOT (INSERTED.Path like '.003.003%')
	END

GO
