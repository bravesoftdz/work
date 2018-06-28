INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('PctBreederDefaultEntityTypePath', '.004')
GO

INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('PctMicrochipCategory', 0)
GO

INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('PctPetKitCategory', 0)
GO

INSERT Sis_PropertyDomain (Property, PropertyValue)
VALUES ('PctDefaultStore', 0)
GO

ALTER TABLE Pet_Microchip
       ADD IDModel int NULL
GO

ALTER TABLE Pet_Microchip
       ADD CONSTRAINT FK_Model_IDModel_Pet_Microchip_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

ALTER TABLE Pet
       ADD IDModel int NULL
GO

ALTER TABLE Pet
       ADD CONSTRAINT FK_Model_IDModel_Pet_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO
