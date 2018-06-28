CREATE TABLE Pet_Registry (
       IDRegistry           int NOT NULL,
       Registry             varchar(50) NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero3361
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3362
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3363
                                          DEFAULT 0
)
GO

ALTER TABLE Pet_Registry
       ADD CONSTRAINT XPKPet_Registry PRIMARY KEY (IDRegistry)
GO
