ALTER TABLE Sal_ReducaoZ ADD
	MFAdicional CHAR(1) NULL,
	TipoECF VARCHAR(20) NULL,
	MarcaECF VARCHAR(20) NULL,
	ModeloECF VARCHAR(20) NULL,
	VersaoSBECF VARCHAR(10) NULL,
	DataInstalacaoSBECF DATETIME NULL,
	ContadorReducaoZ INT NULL,
	ContadorOrdemOperacao INT NULL,
	ContadorReinicioOperacao INT NULL,
	NumeroUsuarioECF INT NULL,
	IncideISSQN BIT NULL,
	DataEmissao DATETIME NULL,
	IDCashRegister INT NULL
GO

ALTER TABLE Sal_ReducaoZ ADD CONSTRAINT
	FK_CashRegister_Sal_TotalizadorParcial_IDReducaoZ FOREIGN KEY (IDCashRegister) REFERENCES CashRegister
GO

CREATE TABLE Sal_TotalizadorParcial (
	IDTotalizadorParcial INT NOT NULL,
	IDReducaoZ INT NOT NULL,
	Codigo VARCHAR (10) NULL,
	ValorAcumulado MONEY NULL
)
GO

ALTER TABLE Sal_TotalizadorParcial ADD CONSTRAINT
	XPKSal_TotalizadorParcial PRIMARY KEY (IDTotalizadorParcial)
GO

ALTER TABLE Sal_TotalizadorParcial ADD CONSTRAINT
	FK_Sal_ReducaoZ_Sal_TotalizadorParcial_IDReducaoZ FOREIGN KEY (IDReducaoZ) REFERENCES Sal_ReducaoZ
GO

CREATE TABLE Sal_NotasCanceladas (
       IDNotasCanceladas    int NOT NULL,
       IDPessoa             int NULL,
       IDUser               int NOT NULL,
       Cliente              varchar(40) NULL,
       CPFCGC               varchar(20) NULL,
       COO                  int NULL,
       CCF                  int NULL,
       DataNota             datetime NULL,
       SubTotal             money NULL,
       Desconto             money NULL,
       Acrescimo            int NULL,
       TipoAcrescimo        char(1) NULL,
       TipoDesconto         char(1) NULL,
       IDCashRegMov         int NOT NULL
)
GO

ALTER TABLE Sal_NotasCanceladas
       ADD CONSTRAINT XPKSal_NotasCanceladas PRIMARY KEY (
              IDNotasCanceladas)
GO

ALTER TABLE Sal_NotasCanceladas
       ADD CONSTRAINT FK_CashRegMov_Sal_NotasCanceladas_IDCashRegMov
              FOREIGN KEY (IDCashRegMov)
                             REFERENCES CashRegMov
GO

ALTER TABLE Sal_NotasCanceladas
       ADD CONSTRAINT FK_SystemUser_Sal_NotasCanceladas_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE Sal_NotasCanceladas
       ADD CONSTRAINT FK_Pessoa_Sal_NotasCanceladas_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO

ALTER TABLE Sal_RemovedItem ADD
       PosicaoItem          int NULL,
       Acrescimo            money NULL,
       TotalizadorParcial   varchar(10) NULL,
       IDNotasCanceladas    int NULL,
       IDPreSale            int NULL
GO

ALTER TABLE Sal_RemovedItem
       ADD CONSTRAINT FK_Invoice_Sal_RemovedItem_IDPreSale
              FOREIGN KEY (IDPreSale)
                             REFERENCES Invoice
GO


ALTER TABLE Sal_RemovedItem
       ADD CONSTRAINT FK_Sal_NotasCanceladas_Sal_RemovedItem_IDNotasCanceladas
              FOREIGN KEY (IDNotasCanceladas)
                             REFERENCES Sal_NotasCanceladas
GO


CREATE TABLE Fin_LancamentoComplement (
       IDLancamento         int NOT NULL,
       COO                  int NULL,
       GNF                  int NULL,
       CDC                  int NULL,
       DataEmissao          datetime NULL
)
GO

ALTER TABLE Fin_LancamentoComplement
       ADD CONSTRAINT XPKFin_LancamentoComplement PRIMARY KEY (
              IDLancamento)
GO

ALTER TABLE Fin_LancamentoComplement
       ADD CONSTRAINT FK_Fin_Lancamento_Fin_LancamentoComplement_IDLancamento
              FOREIGN KEY (IDLancamento)
                             REFERENCES Fin_Lancamento
GO

ALTER TABLE Inv_MovComplement 
       ADD TotalizadorParcial varchar(10) NULL
GO

ALTER TABLE CashRegLogComplement
       ADD COO int NULL,
       GNF int NULL
GO

ALTER TABLE PreInventoryMov ADD
	SequencyNum INT NULL,
	TotParcial VARCHAR(10)
GO
