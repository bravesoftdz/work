ALTER TABLE PO ADD PayDays int NULL
GO

ALTER TABLE Pur_Purchase ADD PayDays int NULL
GO

ALTER TABLE Pur_Purchase ADD IDPO int NULL
GO

CREATE INDEX XIF5Pur_Purchase ON Pur_Purchase
(IDPO)
GO

ALTER TABLE Pur_Purchase
       ADD CONSTRAINT FK_PO_PurPurchase_IDPO
              FOREIGN KEY (IDPO)
                             REFERENCES PO
GO
