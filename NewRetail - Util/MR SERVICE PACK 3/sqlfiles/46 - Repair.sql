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

COMMIT
GO

CREATE TABLE dbo.Tmp_Repair
	(
	IDRepair int NOT NULL,
	IDModel int NOT NULL,
	IDStore int NOT NULL,
	IDInvMovSend int NULL,
	IDCliente int NULL,
	Fase varchar(20) NULL,
	IDFornecedor int NULL,
	IDUserReceive int NULL,
	ReceiveDate datetime NULL,
	SentDate datetime NULL,
	OBSReceive varchar(255) NULL,
	TipoRepair int NULL,
	IDUserSent int NULL,
	Qty int NOT NULL,
	UPS varchar(20) NULL,
	RA varchar(20) NULL,
	DateLastCost datetime NULL,
	SerialNumber varchar(20) NULL,
	LastCost money NULL,
	Defect varchar(255) NULL,
	Desativado int NULL,
	IDUserReturn int NULL,
	ReturnDate datetime NULL,
	ReturnStatus varchar(20) NULL,
	OBSReturn varchar(255) NULL,
	IDUserBack int NULL,
	BackDate datetime NULL,
	IDInvMovReturn int NULL,
	Tipo int NULL,
	OBSBack varchar(255) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Repair)
	 EXEC('INSERT INTO dbo.Tmp_Repair (IDRepair, IDModel, IDStore, IDInvMovSend, IDCliente, Fase, IDFornecedor, IDUserReceive, ReceiveDate, SentDate, OBSReceive, TipoRepair, IDUserSent, Qty, UPS, RA, DateLastCost, SerialNumber, LastCost, Defect, Desativado, IDUserReturn, ReturnDate, ReturnStatus, OBSReturn, IDUserBack, BackDate, IDInvMovReturn, Tipo, OBSBack)
		SELECT IDRepair, IDModel, IDStore, IDInvMovSend, IDCliente, Fase, IDFornecedor, IDUserReceive, ReceiveDate, SentDate, OBSReceive, TipoRepair, IDUserSent, Qty, UPS, RA, DateLastCost, SerialNumber, LastCost, Defect, Desativado, IDUserReturn, ReturnDate, ReturnStatus, OBSReturn, IDUserBack, BackDate, IDInvMovReturn, Tipo, OBSBack FROM dbo.Repair TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Repair'
EXEC(@temp)
GO

DROP TABLE dbo.Repair
GO

EXECUTE sp_rename N'dbo.Tmp_Repair', N'Repair', 'OBJECT'
GO

ALTER TABLE dbo.Repair ADD CONSTRAINT
	PK__Repair__59C55456 PRIMARY KEY CLUSTERED 
	(
	IDRepair
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF100Repair ON dbo.Repair
	(
	IDCliente
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF91Repair ON dbo.Repair
	(
	IDStore
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF92Repair ON dbo.Repair
	(
	IDInvMovSend
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF93Repair ON dbo.Repair
	(
	IDInvMovReturn
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF94Repair ON dbo.Repair
	(
	IDModel
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF95Repair ON dbo.Repair
	(
	IDUserSent
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF96Repair ON dbo.Repair
	(
	IDUserReturn
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF97Repair ON dbo.Repair
	(
	IDUserReceive
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF98Repair ON dbo.Repair
	(
	IDUserBack
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF99Repair ON dbo.Repair
	(
	IDFornecedor
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Repair_IDUserBack FOREIGN KEY
	(
	IDUserBack
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Repair_IDUserReceive FOREIGN KEY
	(
	IDUserReceive
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Repair_IDUserReturn FOREIGN KEY
	(
	IDUserReturn
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Repair_IDUserSent FOREIGN KEY
	(
	IDUserSent
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_Store_Repair_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
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

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Repair_IDFornecedor FOREIGN KEY
	(
	IDFornecedor
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Repair_IDCliente FOREIGN KEY
	(
	IDCliente
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMov_Repair_IDInvMovReturn FOREIGN KEY
	(
	IDInvMovReturn
	) REFERENCES dbo.InventoryMov
	(
	IDInventoryMov
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMov_Repair_IDInvMovSend FOREIGN KEY
	(
	IDInvMovSend
	) REFERENCES dbo.InventoryMov
	(
	IDInventoryMov
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Repair_InventoryMov_IDRepair FOREIGN KEY
	(
	IDRepair
	) REFERENCES dbo.Repair
	(
	IDRepair
	) NOT FOR REPLICATION

GO

