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


CREATE TABLE dbo.Tmp_Invoice
	(
	IDPreSale int NOT NULL,
	CashRegMovID int NULL,
	SpecialPriceID int NULL,
	IDMeioPag int NULL,
	IDTouristGroup int NULL,
	DeliverTypeID int NULL,
	MediaID int NULL,
	IDCustomer int NOT NULL,
	IDStore int NULL,
	IDInvoice int NULL,
	OtherComissionID int NULL,
	IDLancPagOtherCom int NULL,
	PreSaleDate smalldatetime NOT NULL,
	InvoiceDate smalldatetime NULL,
	DeliverDate smalldatetime NULL,
	DeliverAddress varchar(100) NULL,
	Passport varchar(20) NULL,
	PassportDate smalldatetime NULL,
	Ticket varchar(20) NULL,
	AirLine varchar(40) NULL,
	CompanyName varchar(40) NULL,
	CompanyCGC varchar(20) NULL,
	DepositDate smalldatetime NULL,
	Tax money NULL,
	SubTotal money NULL,
	Note varchar(150) NULL,
	ItemDiscount money NULL,
	TaxIsent bit NULL,
	nOpenUser int NULL,
	RefreshInvoice timestamp NULL,
	Printed bit NULL,
	CashReceived money NULL,
	EstimatedPay smalldatetime NULL,
	CardNumber varchar(30) NULL,
	OtherExpences money NULL,
	Address varchar(200) NULL,
	TaxIsemptValue money NULL,
	TaxIsemptItemDiscount money NULL,
	Layaway TBit NULL,
	FirstName varchar(20) NULL,
	LastName varchar(20) NULL,
	ZIP varchar(20) NULL,
	nOpenHoldCaixa int NULL,
	PrintNotes bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Invoice)
	 EXEC('INSERT INTO dbo.Tmp_Invoice (IDPreSale, CashRegMovID, SpecialPriceID, IDMeioPag, IDTouristGroup, DeliverTypeID, MediaID, IDCustomer, IDStore, IDInvoice, OtherComissionID, IDLancPagOtherCom, PreSaleDate, InvoiceDate, DeliverDate, DeliverAddress, Passport, PassportDate, Ticket, AirLine, CompanyName, CompanyCGC, DepositDate, Tax, SubTotal, Note, ItemDiscount, TaxIsent, nOpenUser, Printed, CashReceived, EstimatedPay, CardNumber, OtherExpences, Address, TaxIsemptValue, TaxIsemptItemDiscount, Layaway, FirstName, LastName, ZIP, nOpenHoldCaixa, PrintNotes)
		SELECT IDPreSale, CashRegMovID, SpecialPriceID, IDMeioPag, IDTouristGroup, DeliverTypeID, MediaID, IDCustomer, IDStore, IDInvoice, OtherComissionID, IDLancPagOtherCom, PreSaleDate, InvoiceDate, DeliverDate, DeliverAddress, Passport, PassportDate, Ticket, AirLine, CompanyName, CompanyCGC, DepositDate, Tax, SubTotal, Note, ItemDiscount, TaxIsent, nOpenUser, Printed, CashReceived, EstimatedPay, CardNumber, OtherExpences, Address, TaxIsemptValue, TaxIsemptItemDiscount, Layaway, FirstName, LastName, ZIP, nOpenHoldCaixa, PrintNotes FROM dbo.Invoice TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Invoice'
EXEC(@temp)
GO

DROP TABLE dbo.Invoice
GO

ALTER TABLE dbo.Tmp_Invoice ADD CONSTRAINT
	DF_Zero101 DEFAULT (0) FOR SubTotal
GO

ALTER TABLE dbo.Tmp_Invoice ADD CONSTRAINT
	DF_Zero102 DEFAULT (0) FOR ItemDiscount
GO

ALTER TABLE dbo.Tmp_Invoice ADD CONSTRAINT
	DF_Zero103 DEFAULT (0) FOR TaxIsent
GO

ALTER TABLE dbo.Tmp_Invoice ADD CONSTRAINT
	DF_Zero104 DEFAULT (0) FOR nOpenUser
GO

ALTER TABLE dbo.Tmp_Invoice ADD CONSTRAINT
	DF_Zero105 DEFAULT (0) FOR Printed
GO

ALTER TABLE dbo.Tmp_Invoice ADD CONSTRAINT
	DF_Zero106 DEFAULT (0) FOR CashReceived
GO

ALTER TABLE dbo.Tmp_Invoice ADD CONSTRAINT
	DF_Zero107 DEFAULT (0) FOR TaxIsemptValue
GO

ALTER TABLE dbo.Tmp_Invoice ADD CONSTRAINT
	DF_Zero108 DEFAULT (0) FOR nOpenHoldCaixa
GO

EXECUTE sp_rename N'dbo.Tmp_Invoice', N'Invoice', 'OBJECT'
GO

ALTER TABLE dbo.Invoice ADD CONSTRAINT
	PK__Invoice__43D61337 PRIMARY KEY CLUSTERED 
	(
	IDPreSale
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_Invoice_IDInvoice ON dbo.Invoice
	(
	IDInvoice
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_Invoice_InvoiceDate ON dbo.Invoice
	(
	InvoiceDate
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF232Invoice ON dbo.Invoice
	(
	IDMeioPag
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF233Invoice ON dbo.Invoice
	(
	IDCustomer
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_Invoice_CashRegMovID ON dbo.Invoice
	(
	CashRegMovID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF388Invoice ON dbo.Invoice
	(
	SpecialPriceID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_Invoice_IDTouristGroup ON dbo.Invoice
	(
	IDTouristGroup
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF390Invoice ON dbo.Invoice
	(
	DeliverTypeID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF391Invoice ON dbo.Invoice
	(
	IDStore
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF392Invoice ON dbo.Invoice
	(
	MediaID
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_CashRegMov_Invoice_CashRegMovID FOREIGN KEY
	(
	CashRegMovID
	) REFERENCES dbo.CashRegMov
	(
	IDCashRegMov
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_DeliverType_Invoice_DeliverTypeID FOREIGN KEY
	(
	DeliverTypeID
	) REFERENCES dbo.DeliverType
	(
	IDDeliverType
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_Media_Invoice_MediaID FOREIGN KEY
	(
	MediaID
	) REFERENCES dbo.Media
	(
	IDMedia
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

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_TouristGroup_Invoice_IDTourisGroup FOREIGN KEY
	(
	IDTouristGroup
	) REFERENCES dbo.TouristGroup
	(
	IDTouristGroup
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_SpecialPrice_Invoice_SpecialPriceID FOREIGN KEY
	(
	SpecialPriceID
	) REFERENCES dbo.SpecialPrice
	(
	IDSpecialPrice
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Invoice_IDCustomer FOREIGN KEY
	(
	IDCustomer
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_MeioPag_Invoice_IDMeioPag FOREIGN KEY
	(
	IDMeioPag
	) REFERENCES dbo.MeioPag
	(
	IDMeioPag
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_Invoice_Lancamento_IDPreSale FOREIGN KEY
	(
	IDPreSale
	) REFERENCES dbo.Invoice
	(
	IDPreSale
	) NOT FOR REPLICATION
GO

