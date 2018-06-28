CREATE TABLE SubGroup (
       IDSubGroup           int NOT NULL,
       SubGroup             varchar(50) NULL,
       System               TBit,
       Hidden               TBit,
       Desativado           TBit
)
GO

ALTER TABLE SubGroup
       ADD CONSTRAINT XPKSubGroup PRIMARY KEY (IDSubGroup)
GO


ALTER TABLE Model ADD IDSubGroup int NULL
GO

ALTER TABLE Model
       ADD CONSTRAINT FK_SubGroup_Model_IDSubGroup
              FOREIGN KEY (IDSubGroup)
                             REFERENCES SubGroup
GO
