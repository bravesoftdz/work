CREATE TABLE Inv_ModelReceipt (
	IDModelReceipt varchar(20) NOT NULL,
	ReceiptText varchar(255) NOT NULL,
	System Boolean NOT NULL CONSTRAINT DF_InvModelReceipt_System_Zero  DEFAULT 0,
	Hidden Boolean NOT NULL CONSTRAINT DF_InvModelReceipt_Hidden_Zero  DEFAULT 0,
	Desativado Boolean NOT NULL CONSTRAINT DF_InvModelReceipt_Desativado_Zero  DEFAULT 0,
	IDModel int NOT NULL
)
GO

ALTER TABLE Inv_ModelReceipt ADD
	CONSTRAINT XPKInv_ModelReceipt PRIMARY KEY (IDModelReceipt)
GO

ALTER TABLE Inv_ModelReceipt ADD
	CONSTRAINT FK_Model_InvModelReceipt_IDModel FOREIGN KEY (IDModel) REFERENCES Model
GO

ALTER TABLE TabGroup ADD
	ReceiptText varchar(255) NULL
GO
