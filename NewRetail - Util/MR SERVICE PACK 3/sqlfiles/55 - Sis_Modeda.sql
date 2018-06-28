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

CREATE TABLE dbo.Tmp_Sis_Moeda
	(
	IDMoeda int NOT NULL,
	CodigoMoeda TCodigoGeral NOT NULL,
	Moeda TDescricao NOT NULL,
	MoedaPadrao TBit NULL,
	Sigla TCodigoGeral NOT NULL,
	IDMoedaCotacao int NULL,
	ValorMoedaPadrao TValor NULL,
	DataCotacao datetime NULL,
	Desativado TBit NULL,
	System TBit NULL,
	Hidden TBit NULL
	)  ON [PRIMARY]
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Sis_Moeda.Desativado'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Sis_Moeda.System'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Sis_Moeda.Hidden'
GO

IF EXISTS(SELECT * FROM dbo.Sis_Moeda)
	 EXEC('INSERT INTO dbo.Tmp_Sis_Moeda (IDMoeda, CodigoMoeda, Moeda, MoedaPadrao, Sigla, IDMoedaCotacao, ValorMoedaPadrao, DataCotacao, Desativado, System, Hidden)
		SELECT IDMoeda, CodigoMoeda, Moeda, MoedaPadrao, Sigla, IDMoedaCotacao, ValorMoedaPadrao, DataCotacao, Desativado, System, Hidden FROM dbo.Sis_Moeda TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Sis_Moeda'
EXEC(@temp)
GO

DROP TABLE dbo.Sis_Moeda
GO

EXECUTE sp_rename N'dbo.Tmp_Sis_Moeda', N'Sis_Moeda', 'OBJECT'
GO

ALTER TABLE dbo.Sis_Moeda ADD CONSTRAINT
	PK__Sis_Moeda__00200768 PRIMARY KEY CLUSTERED 
	(
	IDMoeda
	) ON [PRIMARY]

GO

CREATE TRIGGER tr_Sis_Moeda_All ON dbo.Sis_Moeda
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Quando atualizar uma moeda para padrao,
		Atualizar todos os Valores de todas as moedas
		para refletirem a nova moeda padrão

  		- Desligar a antiga


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

IF NOT UPDATE (MoedaPadrao) Return

/*
	Calcula o fator de conversao
*/
DECLARE @Fator 	Money
SELECT	@Fator= (
		SELECT 	CASE
			   WHEN M.ValorMoedaPadrao = 0 THEN 1
			   ELSE (1 / M.ValorMoedaPadrao)
			END
		FROM 	Sis_Moeda M,
			Inserted I
		WHERE	M.IDMoeda = I.IDMoeda
			AND
			I.MoedaPadrao = 1
		)

/*
	Multiplica todas as moedas pelo fator calculado
	Retira a marca de MoedaPadrao
*/
UPDATE	Sis_Moeda
SET	Sis_Moeda.MoedaPadrao = 0,
	Sis_Moeda.ValorMoedaPadrao = Sis_Moeda.ValorMoedaPadrao * @Fator
FROM	Inserted I
WHERE	I.IDMoeda <> Sis_Moeda.IDMoeda
	AND
	I.MoedaPadrao = 1
	AND
	Sis_Moeda.MoedaPadrao = 1

UPDATE	Sis_Moeda
SET	Sis_Moeda.MoedaPadrao = 1
FROM	Inserted I
WHERE	I.IDMoeda = Sis_Moeda.IDMoeda
	AND
	I.MoedaPadrao = 1

/*
	Multiplica todas as cotacões pelo fator calculado
	primeiro as outras, depois a nova padrao
*/

UPDATE	Sis_MoedaCotacao
SET	Sis_MoedaCotacao.ValorMoedaPadrao = Sis_MoedaCotacao.ValorMoedaPadrao * @Fator
FROM	Inserted I
WHERE	Sis_MoedaCotacao.IDMoeda <> I.IDMoeda
	AND
	I.MoedaPadrao = 1

UPDATE	Sis_MoedaCotacao
SET	Sis_MoedaCotacao.ValorMoedaPadrao = 1
FROM	Inserted I
WHERE	Sis_MoedaCotacao.IDMoeda = I.IDMoeda
	AND
	I.MoedaPadrao = 1

/*
	Inclui a nova cotacao com o valormoedaopadrao 1
*/

INSERT	Sis_MoedaCotacao (IDMoeda, ValorMoedaPadrao, DataCotacao)
	(
	SELECT	I.IDMoeda,
		1,
		GetDate()
	FROM	Inserted I
	WHERE	I.MoedaPadrao = 1
	)
GO

ALTER TABLE dbo.Sis_MoedaCotacao WITH NOCHECK ADD CONSTRAINT
	FK_SisMoeda_SisMoedaCotacao_IDMoeda FOREIGN KEY
	(
	IDMoeda
	) REFERENCES dbo.Sis_Moeda
	(
	IDMoeda
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SisMoeda_Lancamento_IDMoeda FOREIGN KEY
	(
	IDMoeda
	) REFERENCES dbo.Sis_Moeda
	(
	IDMoeda
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_ContaCorrente WITH NOCHECK ADD CONSTRAINT
	FK_SisMoeda_ContaCorrente_IDMoeda FOREIGN KEY
	(
	IDMoeda
	) REFERENCES dbo.Sis_Moeda
	(
	IDMoeda
	) NOT FOR REPLICATION

GO

