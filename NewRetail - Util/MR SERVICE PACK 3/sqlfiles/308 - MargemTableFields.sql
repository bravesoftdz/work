CREATE TABLE MargemTable (
       IDMargemTable        int NOT NULL,
       MargemTable          varchar(30) NULL,
       System               bit NOT NULL
                                   CONSTRAINT DF_Zero1386
                                          DEFAULT 0,
       Hidden               bit NOT NULL
                                   CONSTRAINT DF_Zero1387
                                          DEFAULT 0,
       Desativado           bit NOT NULL
                                   CONSTRAINT DF_Zero1388
                                          DEFAULT 0
)
GO


ALTER TABLE MargemTable
       ADD CONSTRAINT XPKMargemTable PRIMARY KEY (IDMargemTable)

GO


CREATE TABLE MargemTableRange (
       IDMargemTableRange   int NOT NULL,
       IDMargemTable        int NULL,
       MinValue             money NULL,
       MaxValue             money NULL,
       Percentage           float NULL
)

GO

CREATE INDEX XIF1MargemTableRange ON MargemTableRange
(
       IDMargemTable
)

GO


ALTER TABLE MargemTableRange
       ADD CONSTRAINT XPKMargemTableRange PRIMARY KEY (
              IDMargemTableRange)

GO


ALTER TABLE MargemTableRange
       ADD CONSTRAINT FK_MagemTable_MagemTableRange_IDMargemTable
              FOREIGN KEY (IDMargemTable)
                             REFERENCES MargemTable

GO


ALTER TABLE TabGroup ADD 
       IDSalePriceMargemTable int NULL,
       SalePriceMargemPercent float NULL,
       UseSalePricePercent  bit NOT NULL
                                   CONSTRAINT DF_Zero1405
                                          DEFAULT 0,
       IDMSRPMargemTable    int NULL,
       MSRPMargemPercent    float NULL,
       UseMSRPPercent       bit NOT NULL
                                   CONSTRAINT DF_Zero1406
                                          DEFAULT 0
GO


CREATE INDEX XIF5TabGroup ON TabGroup
(
       IDSalePriceMargemTable
)
GO

CREATE INDEX XIF6TabGroup ON TabGroup
(
       IDMSRPMargemTable
)

GO


ALTER TABLE TabGroup
       ADD CONSTRAINT FK_MagemTable_TabGroup_IDMSRPMargemTable
              FOREIGN KEY (IDMSRPMargemTable)
                             REFERENCES MargemTable
GO


ALTER TABLE TabGroup
       ADD CONSTRAINT FK_MagemTable_TabGroup_IDSalePriceMargemTable
              FOREIGN KEY (IDSalePriceMargemTable)
                             REFERENCES MargemTable
GO
