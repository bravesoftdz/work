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

CREATE TABLE dbo.Tmp_Sis_MoedaCotacao
	(
	IDMoedaCotacao int NOT NULL,
	IDMoeda int NOT NULL,
	DataCotacao datetime NULL,
	ValorMoedaPadrao TValor NOT NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Sis_MoedaCotacao)
	 EXEC('INSERT INTO dbo.Tmp_Sis_MoedaCotacao (IDMoedaCotacao, IDMoeda, DataCotacao, ValorMoedaPadrao)
		SELECT IDMoedaCotacao, IDMoeda, DataCotacao, ValorMoedaPadrao FROM dbo.Sis_MoedaCotacao TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Sis_MoedaCotacao'
EXEC(@temp)
GO

DROP TABLE dbo.Sis_MoedaCotacao
GO

EXECUTE sp_rename N'dbo.Tmp_Sis_MoedaCotacao', N'Sis_MoedaCotacao', 'OBJECT'
GO

ALTER TABLE dbo.Sis_MoedaCotacao ADD CONSTRAINT
	PK__Sis_MoedaCotacao__45BE5BA9 PRIMARY KEY CLUSTERED 
	(
	IDMoedaCotacao
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF210Sis_MoedaCotacao ON dbo.Sis_MoedaCotacao
	(
	IDMoeda
	) ON [PRIMARY]
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

CREATE TRIGGER tr_Sis_MoedaCotacao_All ON dbo.Sis_MoedaCotacao
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Pega sempre o max da data e coloca na Moeda


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

UPDATE	Sis_Moeda
SET	Sis_Moeda.ValorMoedaPadrao = MC.ValorMoedaPadrao,
	Sis_Moeda.DataCotacao = MC.DataCotacao,
	Sis_Moeda.IDMoedaCotacao = MC.IDMoedaCotacao
FROM	Sis_MoedaCotacao MC,
	(
		SELECT 	I.IDMoeda, 
			Max(IMC.DataCotacao) MaxDataCotacao 
		FROM 	Inserted I,
			Sis_MoedaCotacao IMC
		WHERE	I.IDMoeda = IMC.IDMoeda
		GROUP BY I.IDMoeda
	) MA
	
WHERE	Sis_Moeda.IDMoeda = MA.IDMoeda
	AND
	MC.IDMoeda = MA.IDMoeda
	AND
	MC.DataCotacao = MA.MaxDataCotacao
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SisMoedaCotacao_Lancamento_IDMoedaCotacao FOREIGN KEY
	(
	IDMoedaCotacao
	) REFERENCES dbo.Sis_MoedaCotacao
	(
	IDMoedaCotacao
	) NOT FOR REPLICATION

GO

