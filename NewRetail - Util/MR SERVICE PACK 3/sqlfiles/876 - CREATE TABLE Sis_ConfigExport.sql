CREATE TABLE Sis_ConfigExport (
       IDConfigExport       int NOT NULL,
       DelimiterSeparator   char(1) NULL,
       DecimalSeparator     char(1) NULL,
       HeaderConfig         text NULL,
       FileFormat           text NOT NULL,
       HeaderFile           bit NOT NULL
                                   CONSTRAINT DEF_BitHeaderfile
                                          DEFAULT 0,
       IDPessoa             int NULL,
       ExportType           smallint NULL
)
GO

ALTER TABLE Sis_ConfigExport
       ADD CONSTRAINT XPKSis_ConfigExport PRIMARY KEY (IDConfigExport)
GO

CREATE TABLE Sis_ConfigImport (
       IDConfigImport       int NOT NULL,
       ImportType           smallint NOT NULL,
       CrossColumn          text NULL,
       CaseCost             bit NULL
                                   CONSTRAINT DEF_BitCaseCost
                                          DEFAULT 0,
       IDPessoa             int NULL
)
GO

ALTER TABLE Sis_ConfigImport
       ADD CONSTRAINT XPKSis_ConfigImport PRIMARY KEY (IDConfigImport)
GO

ALTER TABLE Sis_ConfigExport
       ADD CONSTRAINT FK_Pessoa_Sis_ConfigExport_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO

ALTER TABLE Sis_ConfigImport
       ADD CONSTRAINT FK_Pessoa_Sis_ConfigImport_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO
