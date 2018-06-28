ALTER TABLE Pessoa ADD
       StoreAccountLimit    money NULL,
       Nonpayer             bit NULL
                                   CONSTRAINT DEF_Bit1196
                                          DEFAULT 0
GO

UPDATE Pessoa
SET Nonpayer = 0
GO

CREATE TABLE Sal_StoreAccountLimetLog (
       IDStoreAccountLimtLog int NOT NULL,
       IDPessoa             int NULL,
       IDUser               int NULL,
       LogDate              datetime NULL,
       Amount               money NULL
)
GO

ALTER TABLE Sal_StoreAccountLimetLog
       ADD CONSTRAINT XPKSal_StoreAccountLimetLog PRIMARY KEY (
              IDStoreAccountLimtLog)
GO

ALTER TABLE Sal_StoreAccountLimetLog
       ADD CONSTRAINT FK_SystemUser_StoreAccountLimitLog_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO


ALTER TABLE Sal_StoreAccountLimetLog
       ADD CONSTRAINT FK_Pessoa_StoreAccountLimitLog_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO

ALTER TABLE MeioPag ADD
       ValidateNonpayer     bit NULL
GO

UPDATE MeioPag
SET ValidateNonpayer = 0
GO

ALTER TABLE Sal_StoreAccount ADD
       Verify               bit NULL
                                   CONSTRAINT DEF_Bit1219
                                          DEFAULT 0
GO

UPDATE Sal_StoreAccount
SET Verify = 0
GO

INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (89, 1, 1, 'Can apply Store Account above limit?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (89, 1, 'Can apply Store Account above limit?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (89, 2, 'Pode liberar Conta na Loja?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (89, 3, '¿Puede aplicar cuenta encima del límite?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 0
WHERE IDSysFunction = 89
GO

INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (90, 1, 1, 'Receive payment from delinquent customer?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (90, 1, 'Receive payment from delinquent customer?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (90, 2, 'Pode receber pagamentos de inadimplente?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (90, 3, '¿Puede recibir el pago de deudor?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 0
WHERE IDSysFunction = 90
GO
