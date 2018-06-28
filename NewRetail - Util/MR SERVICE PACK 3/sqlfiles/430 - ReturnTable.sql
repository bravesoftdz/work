CREATE TABLE Inv_DefectType (
       IDDefectType         INTEGER NOT NULL,
       DefectType           varchar(30) NOT NULL,
       System               Boolean
                                   CONSTRAINT DF_Zero_Inv_DefectType_System
                                          DEFAULT 0,
       Hidden               Boolean
                                   CONSTRAINT DF_Zero_Inv_DefectType_Hidden
                                          DEFAULT 0,
       Desativado           Boolean
                                   CONSTRAINT DF_Zero_Inv_DefectType_Desativado
                                          DEFAULT 0
)
GO

ALTER TABLE Inv_DefectType
       ADD CONSTRAINT XPKInv_DefectType PRIMARY KEY (IDDefectType)
GO

CREATE TABLE Sal_ItemRepair (
       IDItemRepair         int NOT NULL,
       IDPreInventoryMov    int NOT NULL,
       Obs                  varchar(255) NULL,
       IDDefectType         INTEGER NOT NULL,
       RA                   varchar(20) NOT NULL,
       IDVendor             int NOT NULL
)
GO

ALTER TABLE Sal_ItemRepair
       ADD CONSTRAINT XPKSal_ItemRepair PRIMARY KEY (IDItemRepair)
GO

ALTER TABLE Sal_ItemRepair
       ADD CONSTRAINT FK_Pessoa_SalItemRepair_IDVendor
              FOREIGN KEY (IDVendor)
                             REFERENCES Pessoa
GO

ALTER TABLE Sal_ItemRepair
       ADD CONSTRAINT FK_InvDefectType_SalItemRepair_IDDefectType
              FOREIGN KEY (IDDefectType)
                             REFERENCES Inv_DefectType
GO

ALTER TABLE Repair ADD
       IDDefectType INTEGER NULL
GO

ALTER TABLE Repair
       ADD CONSTRAINT FK_InvDefectType_Repair_IDDefectType
              FOREIGN KEY (IDDefectType)
                             REFERENCES Inv_DefectType
GO
