CREATE TABLE Nfe_NotaFiscal (
       IDNotaFiscal         int NOT NULL,
       Origem               varchar(20) NOT NULL,
       Referencia           int NOT NULL,
       Situacao             char(15) NOT NULL,
       DataSolicitacao      datetime NOT NULL,
       DataUltimoEnvio      datetime NULL,
       DataResultado        datetime NULL,
       DataUltimaImpressao  datetime NULL,
       XMLEnviado           varchar(8000) NULL,
       XMLRecebido          varchar(8000) NULL,
       DetalhamentoErro     varchar(8000) NULL,
       QtdEnvios            int NULL,
       QtdImpressao         int NULL,
       IDUserSolicitacao    int NOT NULL,
       IDUserUltimoEnvio    int NULL,
       IDUserResultado      int NULL,
       IDUserUltimaImpressao int NULL,
       IDUserCancelamento   int NULL
)
GO

ALTER TABLE Nfe_NotaFiscal
       ADD CONSTRAINT XPKNfe_NotaFiscal PRIMARY KEY (IDNotaFiscal)
GO

ALTER TABLE Nfe_NotaFiscal
       ADD CONSTRAINT FK_SystemUser_Nfe_NotaFiscal_IDUserCancelamento
              FOREIGN KEY (IDUserCancelamento)
                             REFERENCES SystemUser
GO

ALTER TABLE Nfe_NotaFiscal
       ADD CONSTRAINT FK_SystemUser_Nfe_NotaFiscal_IDUserUltimaImpressao
              FOREIGN KEY (IDUserUltimaImpressao)
                             REFERENCES SystemUser
GO

ALTER TABLE Nfe_NotaFiscal
       ADD CONSTRAINT FK_SystemUser_Nfe_NotaFiscal_IDUserResultado
              FOREIGN KEY (IDUserResultado)
                             REFERENCES SystemUser
GO

ALTER TABLE Nfe_NotaFiscal
       ADD CONSTRAINT FK_SystemUser_Nfe_NotaFiscal_IDUserUltimoEnvio
              FOREIGN KEY (IDUserUltimoEnvio)
                             REFERENCES SystemUser
GO

ALTER TABLE Nfe_NotaFiscal
       ADD CONSTRAINT FK_SystemUser_Nfe_NotaFiscal_IDUserSolicitacao
              FOREIGN KEY (IDUserSolicitacao)
                             REFERENCES SystemUser
GO

ALTER TABLE Estado 
	ADD Codigo varchar(20) NULL
GO

CREATE TABLE Sis_Municipio (
       IDMunicipio          int NOT NULL,
       Codigo               varchar(20) NULL,
       Descricao            varchar(100) NULL,
       System               bit NULL
                                   CONSTRAINT DEF_SystemMun
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DEF_HiddenMun
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DEF_DesMun
                                          DEFAULT 0
)
GO

ALTER TABLE Sis_Municipio
       ADD CONSTRAINT XPKSis_Municipo PRIMARY KEY (IDMunicipio)
GO

ALTER TABLE Sis_Empresa ADD
	NomeFantasia varchar(100) NULL,
	IDMunicipio          int NULL
GO

ALTER TABLE Sis_Empresa
       ADD CONSTRAINT FK_Sis_Municipo_SisEmpresa_IDMunicipio
              FOREIGN KEY (IDMunicipio)
                             REFERENCES Sis_Municipio
GO

ALTER TABLE Pessoa ADD
       Complemento          varchar(20) NULL,
       ComplementoNum       int NULL,
       IDMunicipio          int NULL
GO

ALTER TABLE Pessoa
       ADD CONSTRAINT FK_Sis_Municipio_Pessoa_IDMunicipio
              FOREIGN KEY (IDMunicipio)
                             REFERENCES Sis_Municipio
GO
