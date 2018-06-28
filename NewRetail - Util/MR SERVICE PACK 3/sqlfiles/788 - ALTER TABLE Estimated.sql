ALTER TABLE Estimated ADD
       IDTouristGroup       int NULL
GO

ALTER TABLE Estimated
       ADD CONSTRAINT FK_TouristGroup_Estimated_IDTouristGroup
              FOREIGN KEY (IDTouristGroup)
                             REFERENCES TouristGroup
GO
