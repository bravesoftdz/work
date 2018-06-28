CREATE TABLE Pet_MedicalCondition (
       IDMedicalCondition   int NOT NULL,
       MedicalCondition     varchar(50) NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero3355
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3356
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3357
                                          DEFAULT 0
)
GO


ALTER TABLE Pet_MedicalCondition
       ADD CONSTRAINT XPKPet_MedicalCondition PRIMARY KEY (
              IDMedicalCondition)
GO
