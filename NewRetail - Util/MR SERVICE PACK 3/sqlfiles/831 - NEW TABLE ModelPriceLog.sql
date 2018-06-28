CREATE TABLE ModelPriceLog (
       IDModelPriceLog      int NOT NULL,
       IDModel              int NOT NULL,
       IDUser               int NOT NULL,
       IDStore              int NULL,
       ChangeDate           datetime NULL,
       OldCostPrice         money NULL,
       NewCostPrice         money NULL,
       OldSalePrice         money NULL,
       NewSalePrice         money NULL
)
GO

ALTER TABLE ModelPriceLog
       ADD CONSTRAINT XPKModelPriceLog PRIMARY KEY (IDModelPriceLog)
GO

ALTER TABLE ModelPriceLog
       ADD CONSTRAINT FK_Store_ModelPriceLog_IDStore
              FOREIGN KEY (IDStore)
                             REFERENCES Store
GO

ALTER TABLE ModelPriceLog
       ADD CONSTRAINT FK_SystemUser_ModelPriceLog_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE ModelPriceLog
       ADD CONSTRAINT FK_Model_ModelPriceLog_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO
