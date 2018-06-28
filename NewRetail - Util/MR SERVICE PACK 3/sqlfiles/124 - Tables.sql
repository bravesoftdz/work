CREATE TABLE CustomerCredit (
       IDCustomerCredit     int NOT NULL,
       IDPessoa             int NULL,
       IDUser               int NULL,
       IDStore              int NULL,
       CreditDate           datetime NULL,
       ExpirationDate       datetime NULL,
       IsUsed               Boolean,
       Amount               money NULL
)
GO

CREATE INDEX XIF2CustomerCredit ON CustomerCredit
(
       IDPessoa
)
GO

CREATE INDEX XIF3CustomerCredit ON CustomerCredit
(
       IDUser
)
GO


ALTER TABLE CustomerCredit
       ADD CONSTRAINT XPKCustomerCredit PRIMARY KEY (IDCustomerCredit)
GO


ALTER TABLE CustomerCredit
       ADD CONSTRAINT FK_SystemUser_CustomerCredit_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO


ALTER TABLE CustomerCredit
       ADD CONSTRAINT FK_Pessoa_CustomerCredit_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO

ALTER TABLE CustomerCredit
       ADD CONSTRAINT FK_Store_CustomerCredit_IDStore
              FOREIGN KEY (IDStore)
                             REFERENCES Store
GO

CREATE TABLE Estimated (
       IDEstimated          int NOT NULL,
       IDPessoa             int NULL,
       IDUser               int NULL,
       IDStore              int NULL,
       EstimatedDate        datetime NULL,
       Total                money NULL,
       OBS                  varchar(255) NULL
)
GO

CREATE INDEX XIF1Estimated ON Estimated
(
       IDPessoa
)
GO

CREATE INDEX XIF2Estimated ON Estimated
(
       IDUser
)
GO


ALTER TABLE Estimated
       ADD CONSTRAINT XPKEstimated PRIMARY KEY (IDEstimated)
GO


CREATE TABLE EstimatedItem (
       IDEstimatedItem      int NOT NULL,
       IDEstimated          int NULL,
       IDModel              int NULL,
       Qty	            int NULL,
       SalePrice            money NOT NULL
)
GO

CREATE INDEX XIF1EstimatedItem ON EstimatedItem
(
       IDModel
)
GO

CREATE INDEX XIF2EstimatedItem ON EstimatedItem
(
       IDEstimated
)
GO


ALTER TABLE EstimatedItem
       ADD CONSTRAINT XPKEstimatedItem PRIMARY KEY (IDEstimatedItem)
GO


ALTER TABLE Estimated
       ADD CONSTRAINT FK_SystemUser_Estimated_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO


ALTER TABLE Estimated
       ADD CONSTRAINT FK_Pessoa_Estimated_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO

ALTER TABLE Estimated
       ADD CONSTRAINT FK_Store_Estimated_IDStore
              FOREIGN KEY (IDStore)
                             REFERENCES Store
GO


ALTER TABLE EstimatedItem
       ADD CONSTRAINT FK_Estimated_EstimatedItem_IDEstimated
              FOREIGN KEY (IDEstimated)
                             REFERENCES Estimated
GO


ALTER TABLE EstimatedItem
       ADD CONSTRAINT FK_Model_EstimatedItem_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO
