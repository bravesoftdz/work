CREATE TABLE UserTypeToRep_Item (
       IDUserType           int NOT NULL,
       ItemId               int NOT NULL,
       Access               Boolean,
       Edit                 Boolean
)
GO

CREATE INDEX XIF1UserTypeToRep_Item ON UserTypeToRep_Item
(
       IDUserType
)
GO

CREATE INDEX XIF2UserTypeToRep_Item ON UserTypeToRep_Item
(
       ItemId
)
GO

ALTER TABLE UserTypeToRep_Item
       ADD CONSTRAINT XPKUserTypeToRep_Item PRIMARY KEY (IDUserType, 
              ItemId)
GO

ALTER TABLE UserTypeToRep_Item
       ADD CONSTRAINT FK_RepItem_UserTypeToRepItem_ItemId
              FOREIGN KEY (ItemId)
                             REFERENCES Rep_Item
GO

ALTER TABLE UserTypeToRep_Item
       ADD CONSTRAINT FK_UserType_UserTypeToRepItem_IDUserTypeId
              FOREIGN KEY (IDUserType)
                             REFERENCES UserType
GO
