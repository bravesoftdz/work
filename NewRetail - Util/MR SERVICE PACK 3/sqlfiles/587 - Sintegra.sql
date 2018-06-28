CREATE TABLE Sal_ReducaoZ (
	IDReducaoZ int NOT NULL,
	MovDate datetime NOT NULL,
	NumeroSerie varchar(20) NOT NULL,
	NumeroLoja int NOT NULL,
	NumeroECF int NOT NULL,
	NumReducaoZ int NOT NULL,
	COOInicial int NOT NULL,
	COOFinal int NOT NULL,
	NumCancelamentos int NOT NULL,
	ValCancelamentos money NOT NULL,
	ValDescontos money NOT NULL,
	GTInicial money NOT NULL,
	GTFinal money NOT NULL,
	SubstituicaoTrib money NOT NULL,
	Isencao money NOT NULL
)
GO

ALTER TABLE Sal_ReducaoZ ADD CONSTRAINT
	XPKSal_ReducaoZ PRIMARY KEY (IDReducaoZ)
GO

CREATE TABLE Sal_TributacaoECF (
	IDTributacaoECF int NOT NULL,
	Aliquota float NOT NULL,
	BaseCalculo money NOT NULL,
	ValImposto money NOT NULL,
	IDReducaoZ int NULL
)
GO

ALTER TABLE Sal_TributacaoECF ADD CONSTRAINT
	XPKSal_TributacaoECF PRIMARY KEY (IDTributacaoECF)
GO

ALTER TABLE Sal_TributacaoECF ADD CONSTRAINT
	FK_SalReducaoZ_SalTributacaoECF_IDReducaoZ FOREIGN KEY (IDReducaoZ) REFERENCES Sal_ReducaoZ
GO
