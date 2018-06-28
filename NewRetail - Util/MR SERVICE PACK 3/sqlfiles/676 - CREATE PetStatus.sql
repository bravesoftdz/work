CREATE TABLE Pet_Status (
       IDStatus             int NOT NULL,
       StatusCode           varchar(5) NULL,
       Status               varchar(30) NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero3379
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3380
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3381
                                          DEFAULT 0
)
GO

ALTER TABLE Pet_Status
       ADD CONSTRAINT XPKPet_Status PRIMARY KEY (IDStatus)
GO

INSERT Pet_Status VALUES (1, 'A', 'Available', 1, 0, 0)
GO

INSERT Pet_Status VALUES (2, 'H', 'On Hold', 1, 0, 0)
GO

INSERT Pet_Status VALUES (3, 'I', 'Isolation', 1, 0, 0)
GO

INSERT Pet_Status VALUES (4, 'R', 'Return to Breeder', 1, 0, 0)
GO

INSERT Pet_Status VALUES (5, 'S', 'Sold', 1, 0, 0)
GO

INSERT Pet_Status VALUES (6, 'X', 'Exception', 1, 0, 0)
GO

INSERT Sis_CodigoIncremental VALUES ('Pet_Status.IDStatus', 6)
GO
