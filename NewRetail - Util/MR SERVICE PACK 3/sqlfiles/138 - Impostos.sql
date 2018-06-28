ALTER TABLE StoreToTabGroup ADD 
	Visible 	bit	NULL	DEFAULT 1, 
	IDSaleTax	int	NULL
GO

UPDATE StoreToTabGroup SET Visible = 1
GO

CREATE INDEX XIF4StoreToTabGroup ON StoreToTabGroup
(
       IDSaleTax
)
GO

ALTER TABLE StoreToTabGroup
       ADD CONSTRAINT FK_TaxCategory_StoreToTabGroup_IDSaleTax
              FOREIGN KEY (IDSaleTax)
                             REFERENCES TaxCategory
GO

ALTER TABLE TaxCategory ADD
	Debit                bit 		NULL,
	OperationType        int 		NULL,
	SaleTaxType          int 		NULL,
	Formula              varchar(255) 	NULL,
	IDLancamentoTipo     int 		NULL
GO

CREATE INDEX XIF2TaxCategory ON TaxCategory
(
       IDLancamentoTipo
)
GO

ALTER TABLE TaxCategory
       ADD CONSTRAINT FK_Fin_LancamentoTipo_TaxCategory_IDLancamentoTipo
              FOREIGN KEY (IDLancamentoTipo)
                             REFERENCES Fin_LancamentoTipo
GO

UPDATE TaxCategory
SET OperationType = 1, SaleTaxType = 1
GO
