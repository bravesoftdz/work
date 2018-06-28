CREATE TABLE History (
       IDHistory            int NOT NULL,
       IDUser               int NULL,
       MovDate              datetime NOT NULL,
       OBS                  varchar(255) NOT NULL,
       IDHistoryType        int NULL,
       IDPreSale            int NULL
)
GO

CREATE INDEX XIF1History ON History (IDHistoryType)
GO

CREATE INDEX XIF2History ON History (IDPreSale)
GO

CREATE INDEX XIF3History ON History (IDUser)
GO

ALTER TABLE History ADD CONSTRAINT XPKHistory PRIMARY KEY (IDHistory)
GO


CREATE TABLE HistoryType (
       IDHistoryType        int NOT NULL,
       HistoryType          varchar(255) NOT NULL,
       System               bit NOT NULL,
       Hidden               bit NOT NULL,
       Desativado           bit NOT NULL
)
GO

ALTER TABLE HistoryType ADD CONSTRAINT XPKHistoryType PRIMARY KEY (IDHistoryType)
GO

ALTER TABLE History
       ADD CONSTRAINT FK_SystemUser_History_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE History
       ADD CONSTRAINT FK_Invoice_History_IDPreSale
              FOREIGN KEY (IDPreSale)
                             REFERENCES Invoice
GO

ALTER TABLE History
       ADD CONSTRAINT FK_HistoryType_History_IDHIstoryType
              FOREIGN KEY (IDHistoryType)
                             REFERENCES HistoryType
GO

Insert into HistoryType values (1, 'Finalize', 1, 1 ,0)
GO

Insert into HistoryType values (2, 'Canceled', 1, 1 ,0)
GO

INSERT Sis_CodigoIncremental (Tabela,  UltimoCodigo) 
VALUES ('LastKey', 1)
GO

INSERT INTO Sis_CodigoIncremental (Tabela, UltimoCodigo)
VALUES ('History.IDHistory', 1)
GO

INSERT INTO Sis_CodigoIncremental (Tabela, UltimoCodigo)
VALUES ('HistoryType.IDHistoryType', 1)
GO