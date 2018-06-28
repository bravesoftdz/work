CREATE TABLE Pet_Treatment (
       IDTreatment          int NOT NULL,
       Treatment            varchar(50) NULL,
       TreatmentType        int NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero3358
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3359
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3360
                                          DEFAULT 0
)
GO

ALTER TABLE Pet_Treatment
       ADD CONSTRAINT XPKPet_Treatment PRIMARY KEY (IDTreatment)
GO
