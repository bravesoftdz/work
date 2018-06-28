CREATE TABLE Inv_Lot (
       IDLote               int NOT NULL,
       IDModel              int NOT NULL,
       IDUser               int NOT NULL,
       Lot                  varchar(50) NULL,
       ExpirationDate       datetime NULL,
       LotDate              datetime NULL,
       Qty                  decimal(38,4) NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero4038
                                          DEFAULT 0,
       Hidden               char(18) NULL
                                   CONSTRAINT DF_Zero4039
                                          DEFAULT 0,
       Desativado           int NULL
                                   CONSTRAINT DF_Zero4040
                                          DEFAULT 0
)
GO

ALTER TABLE Inv_Lot
       ADD CONSTRAINT XPKInv_Lot PRIMARY KEY (IDLote)
GO

ALTER TABLE Inv_Lot
       ADD CONSTRAINT FK_SystemUser_Inv_Lot_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE Inv_Lot
       ADD CONSTRAINT FK_Model_Inv_Lot_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

ALTER TABLE Inv_MovComplement ADD
       IDLote int NULL
GO

ALTER TABLE Inv_MovComplement
       ADD CONSTRAINT FK_Inv_Lot_Inv_MovComplement_IDLot
              FOREIGN KEY (IDLote)
                             REFERENCES Inv_Lot
GO

CREATE TABLE Inv_StoreModelLot (
       IDLote               int NOT NULL,
       IDStore              int NOT NULL,
       IDModel              int NOT NULL,
       Qty                  decimal(38,4) NULL
)
GO

ALTER TABLE Inv_StoreModelLot
       ADD CONSTRAINT XPKInv_StoreModelLot PRIMARY KEY (IDLote, 
              IDStore, IDModel)
GO

ALTER TABLE Inv_StoreModelLot
       ADD CONSTRAINT FK_Model_Inv_StoreModelLot_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

ALTER TABLE Inv_StoreModelLot
       ADD CONSTRAINT FK_Store_Inv_StoreModelLot_IDStore
              FOREIGN KEY (IDStore)
                             REFERENCES Store
GO

ALTER TABLE Inv_StoreModelLot
       ADD CONSTRAINT FK_Inv_Model_Inv_StoreModelLot_IDLot
              FOREIGN KEY (IDLote)
                             REFERENCES Inv_Lot
GO

ALTER TABLE ModelTransfDet ADD
       IDLote int NULL
GO

ALTER TABLE ModelTransfDet
       ADD CONSTRAINT FK_Inv_Model_ModelTransfDet_IDLot
              FOREIGN KEY (IDLote)
                             REFERENCES Inv_Lot
GO


ALTER TABLE Pur_PurchaseItem ADD
       IDLote int NULL
GO

ALTER TABLE Pur_PurchaseItem
       ADD CONSTRAINT FK_Inv_Model_Pur_PurchaseItem_IDLot
              FOREIGN KEY (IDLote)
                             REFERENCES Inv_Lot
GO

ALTER TABLE Repair ADD
       IDLote int NULL
GO

ALTER TABLE Repair
       ADD CONSTRAINT FK_Inv_Lot_Repair_IDLot
              FOREIGN KEY (IDLote)
                             REFERENCES Inv_Lot
GO

ALTER TABLE Model
       ADD UseLot bit NULL CONSTRAINT DF_Zero4083
                                          DEFAULT 0
GO

UPDATE Model
SET UseLot = 0
GO

INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (112, 'Require Lot Control', 'True', 'Boolean', 'If this option is TRUE, the system will require lot information on purchase, transfer and sale.', 'True', 0, 5)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (112, 1, 'Require Lot Control', 'If this option is TRUE, the system will require lot information on purchase, transfer and sale.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (112, 2, 'Obrigar Controle de Lote', 'Se esta opção for TRUE, o sistema irá exigir informação de lote na compra, transferência e venda.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (112, 3, 'Lote de control requieren', 'Si esta opción es TRUE, el sistema requiere mucha información sobre la adquisición, transferencia y venta.')
GO
