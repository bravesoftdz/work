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

CREATE TABLE dbo.Tmp_TouristGroup
	(
	IDTouristGroup int NOT NULL,
	IDGuide int NULL,
	IDAgency int NULL,
	IDStore int NOT NULL,
	IDLancPagGuia int NULL,
	IDLancPagAgencia int NULL,
	IDUser int NULL,
	IDHotel int NULL,
	IDLastMark money NULL,
	TipTouristGroup varchar(50) NOT NULL,
	EnterDate smalldatetime NOT NULL,
	NumTourist int NULL,
	ComissaoSobreGuia money NULL,
	DescontaCoordenacao bit NULL,
	Permanente bit NULL,
	DiasValidade int NULL,
	TipGuide varchar(30) NULL,
	TipAgency varchar(30) NULL,
	OtherExpences int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.TouristGroup)
	 EXEC('INSERT INTO dbo.Tmp_TouristGroup (IDTouristGroup, IDGuide, IDAgency, IDStore, IDLancPagGuia, IDLancPagAgencia, IDUser, IDHotel, IDLastMark, TipTouristGroup, EnterDate, NumTourist, ComissaoSobreGuia, DescontaCoordenacao, Permanente, DiasValidade, TipGuide, TipAgency, OtherExpences)
		SELECT IDTouristGroup, IDGuide, IDAgency, IDStore, IDLancPagGuia, IDLancPagAgencia, IDUser, IDHotel, IDLastMark, TipTouristGroup, EnterDate, NumTourist, ComissaoSobreGuia, DescontaCoordenacao, Permanente, DiasValidade, TipGuide, TipAgency, OtherExpences FROM dbo.TouristGroup TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'TouristGroup'
EXEC(@temp)
GO

DROP TABLE dbo.TouristGroup
GO

ALTER TABLE dbo.Tmp_TouristGroup ADD CONSTRAINT
	DF_GetDate DEFAULT (getdate()) FOR EnterDate
GO

ALTER TABLE dbo.Tmp_TouristGroup ADD CONSTRAINT
	DF_Zero91 DEFAULT (0) FOR Permanente
GO

EXECUTE sp_rename N'dbo.Tmp_TouristGroup', N'TouristGroup', 'OBJECT'
GO

ALTER TABLE dbo.TouristGroup ADD CONSTRAINT
	PK_NewTouristGroup_1__42 PRIMARY KEY CLUSTERED 
	(
	IDTouristGroup
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX PI_TourGroup_EnterDate ON dbo.TouristGroup
	(
	EnterDate
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF147TouristGroup ON dbo.TouristGroup
	(
	IDStore
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF148TouristGroup ON dbo.TouristGroup
	(
	IDGuide
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF149TouristGroup ON dbo.TouristGroup
	(
	IDAgency
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF436TouristGroup ON dbo.TouristGroup
	(
	IDHotel
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF437TouristGroup ON dbo.TouristGroup
	(
	IDUser
	) ON [PRIMARY]
GO

ALTER TABLE dbo.TouristGroup WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_TouristGroup_IDAgency FOREIGN KEY
	(
	IDAgency
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TouristGroup WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_TouristGroup_IDGuide FOREIGN KEY
	(
	IDGuide
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TouristGroup WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_TouristGroup_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TouristGroup WITH NOCHECK ADD CONSTRAINT
	FK_Store_TourGroup_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TouristGroup WITH NOCHECK ADD CONSTRAINT
	FK_Hotel_TouristGroup_IDHotel FOREIGN KEY
	(
	IDHotel
	) REFERENCES dbo.Hotel
	(
	IDHotel
	) NOT FOR REPLICATION
GO

CREATE TRIGGER tr_TourGroup ON dbo.TouristGroup
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo os campos atualizados
		- Atualizo TipTouristGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

DECLARE @Guide varchar(50)
if not ( UPDATE(IDGuide) or UPDATE(IDAgency) or UPDATE(IDHotel) or UPDATE(TipGuide) ) 
   return
UPDATE
	TouristGroup
SET
	TipTouristGroup = 	CONVERT(varchar(30),(
			CASE
				WHEN	(TouristGroup.IDGuide is Null) THEN
							IsNull(TouristGroup.TipGuide, '')

				ELSE	IsNull((
					SELECT
						(
						CASE	WHEN	(CHARINDEX(',', Pessoa.Pessoa) = 0) THEN Pessoa.Pessoa
						       	ELSE	RIGHT(Pessoa.Pessoa, DATALENGTH(Pessoa.Pessoa)-CHARINDEX(',', Pessoa.Pessoa))+' '+
								SUBSTRING(Pessoa.Pessoa, 1, CHARINDEX(',', Pessoa.Pessoa)-1)
					       	END
						)
					FROM	Pessoa
					WHERE 	Pessoa.IDPessoa = TouristGroup.IDGuide
					), '')
			END
			) + ' / ' +
			IsNull((
			SELECT
				Pessoa.Pessoa
			FROM
				Pessoa
			WHERE
				Pessoa.IDPessoa = TouristGroup.IDAgency
			), '') + ' / ' +
			IsNull((
			SELECT
				Hotel.Hotel
			FROM
				Hotel
			WHERE
				Hotel.IDHotel = TouristGroup.IDHotel
			), ''))
FROM
	Inserted
WHERE
	Inserted.IDTouristGroup = TouristGroup.IDTouristGroup

GO

ALTER TABLE dbo.GroupCost WITH NOCHECK ADD CONSTRAINT
	FK_TouristGroup_GroupCost_IDTourisGroup FOREIGN KEY
	(
	IDTouristGroup
	) REFERENCES dbo.TouristGroup
	(
	IDTouristGroup
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_TouristGroup_Invoice_IDTourisGroup FOREIGN KEY
	(
	IDTouristGroup
	) REFERENCES dbo.TouristGroup
	(
	IDTouristGroup
	) NOT FOR REPLICATION

GO

