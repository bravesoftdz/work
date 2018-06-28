CREATE TABLE Mnt_PessoaHistoryType (
	IDPessoaHistoryType int NOT NULL,
	PessoaHistoryType varchar(30) NOT NULL,
	System Boolean NOT NULL CONSTRAINT DF_MntPessoaHistoryType_System_Zero DEFAULT 0,
	Hidden Boolean NOT NULL CONSTRAINT DF_MntPessoaHistoryType_Hidden_Zero DEFAULT 0,
	Desativado Boolean NOT NULL CONSTRAINT DF_MntPessoaHistoryType_Desativado_Zero DEFAULT 0
)
GO

ALTER TABLE Mnt_PessoaHistoryType ADD CONSTRAINT XPKMnt_PessoaHistoryType
	PRIMARY KEY (IDPessoaHistoryType)
GO

CREATE TABLE Mnt_PessoaHistoryResult (
	IDPessoaHistoryResult int NOT NULL,
	PessoaHistoryResult varchar(30) NOT NULL,
	IDPessoaHistoryType int NOT NULL,
	ResultColor varchar(20) NOT NULL
)
GO

ALTER TABLE Mnt_PessoaHistoryResult ADD CONSTRAINT
	XPKMnt_PessoaHistoryResult PRIMARY KEY (IDPessoaHistoryResult)
GO

ALTER TABLE Mnt_PessoaHistoryResult ADD CONSTRAINT
	FK_MntPessoaHistoryResult_MntPessoaHistoryType_IDPessoaHistoryResult FOREIGN KEY (IDPessoaHistoryType) REFERENCES Mnt_PessoaHistoryType
GO

CREATE TABLE Mnt_PessoaHistory (
	IDPessoaHistory int NOT NULL,
	IDUser int NOT NULL,
	MovDate datetime NOT NULL,
	IDPessoa int NOT NULL,
	IDPessoaHistoryType int NOT NULL,
	IDPessoaHistoryResult int NOT NULL,
	Obs varchar(255) NULL
)
GO

ALTER TABLE Mnt_PessoaHistory ADD CONSTRAINT
	XPKMnt_PessoaHistory PRIMARY KEY (IDPessoaHistory)
GO

ALTER TABLE Mnt_PessoaHistory ADD CONSTRAINT
	FK_MntPessoaHistoryResult_MntPessoaHistory_IDPessoaHistoryResult FOREIGN KEY (IDPessoaHistoryResult) REFERENCES Mnt_PessoaHistoryResult
GO

ALTER TABLE Mnt_PessoaHistory ADD CONSTRAINT
	FK_MntPessoaHistoryType_MntPessoaHistory_IDPessoaHistoryType FOREIGN KEY (IDPessoaHistoryType) REFERENCES Mnt_PessoaHistoryType
GO

ALTER TABLE Mnt_PessoaHistory ADD CONSTRAINT
	FK_Pessoa_MntPessoaHistory_IDPessoa FOREIGN KEY (IDPessoa) REFERENCES Pessoa
GO

ALTER TABLE Mnt_PessoaHistory ADD CONSTRAINT
	FK_SystemUser_MntPessoaHistory_IDUser FOREIGN KEY (IDUser) REFERENCES SystemUser
GO

INSERT Mnt_PessoaHistoryType (IDPessoaHistoryType, PessoaHistoryType, System, Hidden)
VALUES (0, '', 1, 1)
GO

INSERT Mnt_PessoaHistoryResult (IDPessoaHistoryResult, PessoaHistoryResult, IDPessoaHistoryType, ResultColor)
VALUES (0, '', 0, '')
GO
