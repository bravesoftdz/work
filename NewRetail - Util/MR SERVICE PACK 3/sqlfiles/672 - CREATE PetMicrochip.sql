CREATE TABLE Pet_Microchip (
       IDMicrochip          int NOT NULL,
       Microchip            varchar(50) NULL,
       Amount               money NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero3352
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3353
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3354
                                          DEFAULT 0
)
GO


ALTER TABLE Pet_Microchip
       ADD CONSTRAINT XPKPet_Microchip PRIMARY KEY (IDMicrochip)
GO
