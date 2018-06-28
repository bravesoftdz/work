CREATE TABLE RoundingTable (
       IDRoundingTable      int NOT NULL,
       RoundingTable        varchar(30) NULL,
       System               bit NOT NULL
                                   CONSTRAINT DF_Zero1360
                                          DEFAULT 0,
       Hidden               bit NOT NULL
                                   CONSTRAINT DF_Zero1361
                                          DEFAULT 0,
       Desativado           int NOT NULL
                                   CONSTRAINT DF_Zero1362
                                          DEFAULT 0
)
GO


ALTER TABLE RoundingTable
       ADD CONSTRAINT XPKRoundingTable PRIMARY KEY (IDRoundingTable)
GO


CREATE TABLE RoundingTableRange (
       IDRoundingTableRange int NOT NULL,
       MinValue             money NULL,
       IDRoundingTable      int NULL,
       RoundType            int NULL,
       MaxValue             money NULL,
       RoundValues          varchar(100) NULL
)
GO

CREATE INDEX XIF4RoundingTableRange ON RoundingTableRange
(
       IDRoundingTable
)
GO


ALTER TABLE RoundingTableRange
       ADD CONSTRAINT XPKRoundingTableRange PRIMARY KEY (
              IDRoundingTableRange)
GO


ALTER TABLE TabGroup ADD IDRoundingTable int NULL
       
GO

ALTER TABLE RoundingTableRange
       ADD CONSTRAINT FK_RoundingTable_RoundingTableRange_IDRoundingTable
              FOREIGN KEY (IDRoundingTable)
                             REFERENCES RoundingTable
GO


ALTER TABLE TabGroup
       ADD CONSTRAINT FK_RoundingTable_TabGroup_IDRoundingTable
              FOREIGN KEY (IDRoundingTable)
                             REFERENCES RoundingTable
GO

