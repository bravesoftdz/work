CREATE TABLE Inv_Count (
       IDCount              int NOT NULL,
       StartDate            datetime NOT NULL,
       EndDate              datetime NULL,
       CountType            int NOT NULL,
       IDUser               int NOT NULL,
       IDStore              int NOT NULL
)
GO

CREATE INDEX XIF1Inv_Count ON Inv_Count
(
       IDUser
)
GO

CREATE INDEX XIF2Inv_Count ON Inv_Count
(
       IDStore
)
GO


ALTER TABLE Inv_Count
       ADD CONSTRAINT XPKInv_Count PRIMARY KEY (IDCount)
GO


CREATE TABLE Inv_CountItem (
       IDCountItem          int NOT NULL,
       Barcode              varchar(20) NOT NULL,
       Qty                  float NOT NULL,
       SalePrice            money NULL,
       CountDate            datetime NOT NULL,
       IDUser               int NOT NULL,
       IDCount              int NOT NULL
)
GO

CREATE INDEX XIF1Inv_CountItem ON Inv_CountItem
(
       IDUser
)
GO

CREATE INDEX XIF3Inv_CountItem ON Inv_CountItem
(
       IDCount
)
GO

ALTER TABLE Inv_CountItem
       ADD CONSTRAINT XPKInv_CountItem PRIMARY KEY (IDCountItem)
GO

ALTER TABLE Inv_Count
       ADD CONSTRAINT FK_Store_InvCount_IDStore
              FOREIGN KEY (IDStore)
                             REFERENCES Store
GO

ALTER TABLE Inv_Count
       ADD CONSTRAINT FK_User_InvCount_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE Inv_CountItem
       ADD CONSTRAINT FK_InvCount_InvCountItem_IDCount
              FOREIGN KEY (IDCount)
                             REFERENCES Inv_Count
GO

ALTER TABLE Inv_CountItem
       ADD CONSTRAINT FK_User_InvCountItem_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

CREATE TABLE Inv_FrozeCount (
       IDCount              int NOT NULL,
       IDModel              int NOT NULL,
       Qty                  float NULL
)
GO

CREATE INDEX XIF1Inv_FrozeCount ON Inv_FrozeCount
(
       IDCount
)
GO

CREATE INDEX XIF2Inv_FrozeCount ON Inv_FrozeCount
(
       IDModel
)
GO

ALTER TABLE Inv_FrozeCount
       ADD CONSTRAINT XPKInv_FrozeCount PRIMARY KEY (IDCount, IDModel)
GO

ALTER TABLE Inv_FrozeCount
       ADD CONSTRAINT FK_Model_InvFroze_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

ALTER TABLE Inv_FrozeCount
       ADD CONSTRAINT FK_InvCount_InvFroze_IDCount
              FOREIGN KEY (IDCount)
                             REFERENCES Inv_Count
GO
