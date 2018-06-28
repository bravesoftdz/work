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

CREATE TABLE dbo.Tmp_TabGroup
	(
	IDGroup int NOT NULL,
	Name varchar(30) NOT NULL,
	Taxable bit NULL,
	PrcPartDiscount money NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL,
	Path varchar(150) NULL,
	PathName varchar(255) NULL,
	SerialNumber bit NULL,
	SizeAndColor bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.TabGroup)
	 EXEC('INSERT INTO dbo.Tmp_TabGroup (IDGroup, Name, Taxable, PrcPartDiscount, System, Desativado, Hidden, Path, PathName, SerialNumber, SizeAndColor)
		SELECT IDGroup, Name, Taxable, PrcPartDiscount, System, Desativado, Hidden, Path, PathName, SerialNumber, SizeAndColor FROM dbo.TabGroup TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'TabGroup'
EXEC(@temp)
GO

DROP TABLE dbo.TabGroup
GO

ALTER TABLE dbo.Tmp_TabGroup ADD CONSTRAINT
	DF_MenuItem_Enabled DEFAULT (1) FOR Taxable
GO

ALTER TABLE dbo.Tmp_TabGroup ADD CONSTRAINT
	DF__TabGroup__PrcPar DEFAULT (100) FOR PrcPartDiscount
GO

ALTER TABLE dbo.Tmp_TabGroup ADD CONSTRAINT
	DF_Zero7 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_TabGroup ADD CONSTRAINT
	DF_Zero8 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_TabGroup ADD CONSTRAINT
	DF_Zero9 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_TabGroup ADD CONSTRAINT
	DF_Zero10 DEFAULT (0) FOR SerialNumber
GO

ALTER TABLE dbo.Tmp_TabGroup ADD CONSTRAINT
	DF_Zero11 DEFAULT (0) FOR SizeAndColor
GO

EXECUTE sp_rename N'dbo.Tmp_TabGroup', N'TabGroup', 'OBJECT'
GO

ALTER TABLE dbo.TabGroup ADD CONSTRAINT
	PK__TabGroup__20C1E124 PRIMARY KEY CLUSTERED 
	(
	IDGroup
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX PI_TabGroup_Name ON dbo.TabGroup
	(
	Name
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_TabGroup_Del on dbo.TabGroup
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto SpecialPriceByGroup
		- Deleto GroupToComissionType


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@RowCount = 0 
   Return

SET NOCOUNT ON

DELETE
	SpecialPriceByGroup
FROM
	SpecialPriceByGroup,
	Deleted
WHERE
	SpecialPriceByGroup.GroupID = Deleted.IDGroup

DELETE
	GroupToComissionType
FROM
	TipoPessoa,
	Deleted
WHERE
	GroupToComissionType.GroupID = Deleted.IDGroup

GO

CREATE TRIGGER tr_TabGroup_InsUpt on dbo.TabGroup
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do TabGroup
        	- Insiro em SpecialPriceByGroup
		- Insiro em StoreToTabGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT	INSERTED.IDGroup
		FROM	INSERTED, TabGroup
		WHERE 	INSERTED.Name = TabGroup.Name  	   	AND
			TabGroup.IDGroup <> INSERTED.IDGroup  	AND
			INSERTED.Desativado = 0 	   	AND
			TabGroup.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_TabGroup_Name can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */
if 	NOT EXISTS
		(
		SELECT	Deleted.IDGroup
		FROM	Deleted
		)
	BEGIN
		Insert SpecialPriceByGroup select SpecialPrice.IDSpecialPrice, Inserted.IDGroup, 0 FROM
		SpecialPrice, Inserted WHERE SpecialPrice.Desativado = 0
		Insert GroupToComissionType select TipoPessoa.IDTipoPessoa, INSERTED.IDGroup, 0 FROM
		TipoPessoa, Inserted WHERE (TipoPessoa.Desativado = 0) AND (TipoPessoa.Path like '.003.%') AND
		(NOT (TipoPessoa.Path like '.003.003%'))
	END



INSERT StoreToTabGroup  (IDStore, IDGroup)
	SELECT
		S.IDStore, I.IDGroup
	FROM
		Inserted I
		LEFT OUTER JOIN Deleted D ON (I.IDGroup = D.IDGroup),
		Store S
	WHERE
		D.IDGroup IS NULL
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

ALTER TABLE dbo.Pur_PurchaseItem WITH NOCHECK ADD CONSTRAINT
	FK_TabGroup_PurchaseItem_IDGroup FOREIGN KEY
	(
	IDGroup
	) REFERENCES dbo.TabGroup
	(
	IDGroup
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.StoreToTabGroup WITH NOCHECK ADD CONSTRAINT
	FK_TabGroup_StoreToTabGroup_IDGroup FOREIGN KEY
	(
	IDGroup
	) REFERENCES dbo.TabGroup
	(
	IDGroup
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.GroupToComissionType WITH NOCHECK ADD CONSTRAINT
	FK_TabGroup_GroupToComssionType_GroupID FOREIGN KEY
	(
	GroupID
	) REFERENCES dbo.TabGroup
	(
	IDGroup
	) NOT FOR REPLICATION

GO

