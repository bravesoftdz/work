CREATE TABLE Mnt_PessoaAddress (
	IDPessoaAddress int NOT NULL,
	IDPessoa int NOT NULL,
	[Name] varchar(30) NOT NULL,
	Address varchar(50) NOT NULL,
	City varchar(20) NOT NULL,
	ZIP varchar(10) NOT NULL,
	IDTaxCategory int NULL,
	IDPais int NOT NULL,
	IDEstado char(3) NOT NULL,
	IsBillTo Boolean NOT NULL CONSTRAINT DF_MntPessoaAddress_IsBillTo_Zero DEFAULT 0,
	System Boolean NOT NULL CONSTRAINT DF_MntPessoaAddress_System_Zero DEFAULT 0,
	Hidden Boolean NOT NULL CONSTRAINT DF_MntPessoaAddress_Hidden_Zero DEFAULT 0,
	Desativado Boolean NOT NULL CONSTRAINT DF_MntPessoaAddress_Desativado_Zero DEFAULT 0
)
GO

ALTER TABLE Mnt_PessoaAddress ADD CONSTRAINT
	XPKMnt_PessoaAddress PRIMARY KEY (IDPessoaAddress)
GO

ALTER TABLE Mnt_PessoaAddress ADD CONSTRAINT
	FK_Estado_MntPessoaAddress_IDEstado FOREIGN KEY (IDEstado) REFERENCES Estado
GO

ALTER TABLE Mnt_PessoaAddress ADD CONSTRAINT
	FK_Pais_MntPessoaAddress_IDPais FOREIGN KEY (IDPais) REFERENCES Pais
GO

ALTER TABLE Mnt_PessoaAddress ADD CONSTRAINT
	FK_TaxCategory_MntPessoaAddress_IDTaxCategory FOREIGN KEY (IDTaxCategory) REFERENCES TaxCategory
GO

ALTER TABLE Mnt_PessoaAddress ADD CONSTRAINT
	FK_Pessoa_MntPessoaAddress_IDPessoa FOREIGN KEY (IDPessoa) REFERENCES Pessoa
GO
