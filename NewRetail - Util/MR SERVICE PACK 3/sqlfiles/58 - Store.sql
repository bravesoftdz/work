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

CREATE TABLE dbo.Tmp_Store
	(
	IDStore int NOT NULL,
	IDEmpresa int NULL,
	IDCentroCusto int NULL,
	IDTipoConta int NULL,
	IDContaCorrente int NULL,
	IDContaCashier int NULL,
	IDEstado char(3) NULL,
	Name varchar(30) NOT NULL,
	Address TAddress NULL,
	City TCity NULL,
	Zip TZipCode NULL,
	Telephone TTelephone NULL,
	Cellular varchar(18) NULL,
	Beeper varchar(25) NULL,
	Fax varchar(40) NULL,
	Contato varchar(50) NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL,
	TicketHeader text NULL,
	TicketLayawayFooter text NULL,
	TicketTaxIsemptFooter text NULL,
	HourDefault varchar(5) NULL,
	TicketFooter text NULL,
	PrintTicketHeader bit NULL,
	PrintLayawayFooter bit NULL,
	PrintTaxInsemptFooter bit NULL,
	PrintTicketFooter bit NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Store)
	 EXEC('INSERT INTO dbo.Tmp_Store (IDStore, IDEmpresa, IDCentroCusto, IDTipoConta, IDContaCorrente, IDContaCashier, IDEstado, Name, Address, City, Zip, Telephone, Cellular, Beeper, Fax, Contato, System, Desativado, Hidden, TicketHeader, TicketLayawayFooter, TicketTaxIsemptFooter, HourDefault, TicketFooter, PrintTicketHeader, PrintLayawayFooter, PrintTaxInsemptFooter, PrintTicketFooter)
		SELECT IDStore, IDEmpresa, IDCentroCusto, IDTipoConta, IDContaCorrente, IDContaCashier, IDEstado, Name, Address, City, Zip, Telephone, Cellular, Beeper, Fax, Contato, System, Desativado, Hidden, TicketHeader, TicketLayawayFooter, TicketTaxIsemptFooter, HourDefault, TicketFooter, PrintTicketHeader, PrintLayawayFooter, PrintTaxInsemptFooter, PrintTicketFooter FROM dbo.Store TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Store'
EXEC(@temp)
GO

DROP TABLE dbo.Store
GO

ALTER TABLE dbo.Tmp_Store ADD CONSTRAINT
	DF_Zero30 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_Store ADD CONSTRAINT
	DF_Zero31 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_Store ADD CONSTRAINT
	DF_Zero32 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_Store', N'Store', 'OBJECT'
GO

ALTER TABLE dbo.Store ADD CONSTRAINT
	PK__Store__49C3F6B7 PRIMARY KEY CLUSTERED 
	(
	IDStore
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX PI_Store_Name ON dbo.Store
	(
	Name
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF157Store ON dbo.Store
	(
	IDEstado
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF433Store ON dbo.Store
	(
	IDCentroCusto
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF434Store ON dbo.Store
	(
	IDEstado
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF87Store ON dbo.Store
	(
	IDEmpresa
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Store WITH NOCHECK ADD CONSTRAINT
	FK_CentroCusto_Store_IDCentroCusto FOREIGN KEY
	(
	IDCentroCusto
	) REFERENCES dbo.Fin_CentroCusto
	(
	IDCentroCusto
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Store WITH NOCHECK ADD CONSTRAINT
	FK_SisEmpresa_Store_IDEmpresa FOREIGN KEY
	(
	IDEmpresa
	) REFERENCES dbo.Sis_Empresa
	(
	IDEmpresa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Store WITH NOCHECK ADD CONSTRAINT
	FK_Estado_Store_IDEstado FOREIGN KEY
	(
	IDEstado
	) REFERENCES dbo.Estado
	(
	IDEstado
	) NOT FOR REPLICATION
GO

CREATE TRIGGER tr_Store_InsUpt ON dbo.Store
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia da Store
		- Insiro em MeioPagToStore
		- Insiro em StoreToTabGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT	INSERTED.IDStore
		FROM	INSERTED, Store
		WHERE 	INSERTED.Name = Store.Name	AND
			Store.IDStore <> INSERTED.IDStore	AND
			INSERTED.Desativado = 0 		AND
			Store.Desativado = 0
		)
	BEGIN
		RAISERROR ('DUP_Store_Name can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END


/* So faz na inclusao  */

INSERT MeioPagToStore (IDStore, IDMeioPag)
	SELECT
		I.IDStore, MP.IDMeioPag
	FROM
		Inserted I
		LEFT OUTER JOIN Deleted D ON (I.IDStore = D.IDStore),
		MeioPag MP
	WHERE
		D.IDStore IS NULL

INSERT StoreToTabGroup  (IDStore, IDGroup)
	SELECT
		I.IDStore, TG.IDGroup
	FROM
		Inserted I
		LEFT OUTER JOIN Deleted D ON (I.IDStore = D.IDStore),
		TabGroup TG
	WHERE
		D.IDStore IS NULL
GO

ALTER TABLE dbo.Inventory WITH NOCHECK ADD CONSTRAINT
	FK_Store_Inventory_StoreID FOREIGN KEY
	(
	StoreID
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.ModelTransf WITH NOCHECK ADD CONSTRAINT
	FK_Store_ModelTransf_IDLojaDestino FOREIGN KEY
	(
	IDLojaDestino
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.ModelTransf WITH NOCHECK ADD CONSTRAINT
	FK_Store_ModelTransf_IDLojaOrigem FOREIGN KEY
	(
	IDLojaOrigem
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Cotacao WITH NOCHECK ADD CONSTRAINT
	FK_Store_Cotacao_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_PurchaseQtyPrePurchase WITH NOCHECK ADD CONSTRAINT
	FK_Store_PurchaseQtyPrePurchase_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_PurchaseQtyOrder WITH NOCHECK ADD CONSTRAINT
	FK_Store_PurchaseQtyOrder_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.TMC_TimeControl WITH NOCHECK ADD CONSTRAINT
	FK_Store_TMCTimeControl_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventorySerial WITH NOCHECK ADD CONSTRAINT
	FK_Store_InventorySerial_IDStore FOREIGN KEY
	(
	StoreID
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_Purchase WITH NOCHECK ADD CONSTRAINT
	FK_Store_Purchase_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
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

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Store_PreInventoryMov_StoreID FOREIGN KEY
	(
	StoreID
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.StoreToTabGroup WITH NOCHECK ADD CONSTRAINT
	FK_Store_StoreToTabGroup_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PO WITH NOCHECK ADD CONSTRAINT
	FK_Store_PO_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_Store_Invoice_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_Store_Pessoa_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.MeioPagToStore WITH NOCHECK ADD CONSTRAINT
	FK_Store_MeioPagToStore_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
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

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Store_InventoryMov_StoreID FOREIGN KEY
	(
	StoreID
	) REFERENCES dbo.Store
	(
	IDStore
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

