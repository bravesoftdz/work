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

CREATE TABLE dbo.Tmp_Request
	(
	IDRequest int NOT NULL,
	ModelID int NULL,
	UserID int NOT NULL,
	StoreID int NULL,
	IDPreInventoryMov int NULL,
	IDCotacao int NULL,
	Type char(1) NOT NULL,
	QtyReq int NULL,
	DateRequest smalldatetime NOT NULL,
	Description varchar(50) NULL,
	Cotado bit NULL,
	DelayDate smalldatetime NULL,
	QtyOrdered int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Request)
	 EXEC('INSERT INTO dbo.Tmp_Request (IDRequest, ModelID, UserID, StoreID, IDPreInventoryMov, IDCotacao, Type, QtyReq, DateRequest, Description, Cotado, DelayDate, QtyOrdered)
		SELECT IDRequest, ModelID, UserID, StoreID, IDPreInventoryMov, IDCotacao, Type, QtyReq, DateRequest, Description, Cotado, DelayDate, QtyOrdered FROM dbo.Request TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Request'
EXEC(@temp)
GO

DROP TABLE dbo.Request
GO

ALTER TABLE dbo.Tmp_Request ADD CONSTRAINT
	DF_Zero135 DEFAULT (0) FOR Cotado
GO

EXECUTE sp_rename N'dbo.Tmp_Request', N'Request', 'OBJECT'
GO

ALTER TABLE dbo.Request ADD CONSTRAINT
	PK__Request__1B9317B3 PRIMARY KEY CLUSTERED 
	(
	IDRequest
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF115Request ON dbo.Request
	(
	StoreID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF116Request ON dbo.Request
	(
	ModelID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF117Request ON dbo.Request
	(
	UserID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF431Request ON dbo.Request
	(
	IDCotacao
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF432Request ON dbo.Request
	(
	IDPreInventoryMov
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Request WITH NOCHECK ADD CONSTRAINT
	FK_PreInventoryMov_Request_IDPreInventoryMov FOREIGN KEY
	(
	IDPreInventoryMov
	) REFERENCES dbo.PreInventoryMov
	(
	IDPreInventoryMov
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Request WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Request_UserID FOREIGN KEY
	(
	UserID
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Request WITH NOCHECK ADD CONSTRAINT
	FK_Store_Request_StoreID FOREIGN KEY
	(
	StoreID
	) REFERENCES dbo.Store
	(
	IDStore
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

ALTER TABLE dbo.Request WITH NOCHECK ADD CONSTRAINT
	FK_Cotacao_Request_IDCotacao FOREIGN KEY
	(
	IDCotacao
	) REFERENCES dbo.Cotacao
	(
	IDCotacao
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.CotacaoToModel WITH NOCHECK ADD CONSTRAINT
	FK_Request_CotacaoToModel_IDRequest FOREIGN KEY
	(
	IDRequest
	) REFERENCES dbo.Request
	(
	IDRequest
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.POItemRequest WITH NOCHECK ADD CONSTRAINT
	FK_Request_POItemRequest_IDRequest FOREIGN KEY
	(
	IDRequest
	) REFERENCES dbo.Request
	(
	IDRequest
	) NOT FOR REPLICATION

GO

