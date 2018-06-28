CREATE TABLE ModelGroup (
       IDModelGroup         int NOT NULL,
       ModelGroup           varchar(30) NULL,
       IDGroup              int NULL,
       UserCode             varchar(5) NULL,
       SalePriceMargemPercent float NULL,
       UseSalePricePercent  TBit,
       IDSalePriceMargemTable int NULL,
       IDMSRPMargemTable    int NULL,
       MSRPMargemPercent    float NULL,
       UseMSRPPercent       TBit,
       System               TBit NOT NULL
                                   CONSTRAINT DF_Zero1413
                                          DEFAULT 0,
       Hidden               TBit NOT NULL
                                   CONSTRAINT DF_Zero1414
                                          DEFAULT 0,
       Desativado           TBit NOT NULL
                                   CONSTRAINT DF_Zero1415
                                          DEFAULT 0
)
GO

CREATE INDEX XIF1ModelGroup ON ModelGroup
(
       IDGroup
)
GO

CREATE INDEX XIF4ModelGroup ON ModelGroup
(
       IDSalePriceMargemTable
)
GO

CREATE INDEX XIF5ModelGroup ON ModelGroup
(
       IDMSRPMargemTable
)
GO

ALTER TABLE ModelGroup
       ADD CONSTRAINT XPKModelGroup PRIMARY KEY (IDModelGroup)
GO


CREATE TABLE ModelSubGroup (
       IDModelSubGroup      int NOT NULL,
       IDModelGroup         int NULL,
       ModelSubGroup        varchar(30) NULL,
       UserCode             varchar(5) NULL,
       SalePriceMargemPercent float NULL,
       UseSalePricePercent  TBit,
       IDSalePriceMargemTable int NULL,
       IDMSRPMargemTable    int NULL,
       MSRPMargemPercent    float NULL,
       UseMSRPPercent       TBit,
       System               TBit NOT NULL
                                   CONSTRAINT DF_Zero1416
                                          DEFAULT 0,
       Hidden               TBit NOT NULL
                                   CONSTRAINT DF_Zero1417
                                          DEFAULT 0,
       Desativado           TBit NOT NULL
                                   CONSTRAINT DF_Zero1418
                                          DEFAULT 0
)
GO

CREATE INDEX XIF1ModelSubGroup ON ModelSubGroup
(
       IDModelGroup
)
GO

CREATE INDEX XIF2ModelSubGroup ON ModelSubGroup
(
       IDSalePriceMargemTable
)
GO

CREATE INDEX XIF4ModelSubGroup ON ModelSubGroup
(
       IDMSRPMargemTable
)
GO

ALTER TABLE ModelSubGroup
       ADD CONSTRAINT XPKModelSubGroup PRIMARY KEY (IDModelSubGroup)
GO


ALTER TABLE ModelGroup
       ADD CONSTRAINT FK_MargemTable_ModelGroup_IDMSRPMargemTable
              FOREIGN KEY (IDMSRPMargemTable)
                             REFERENCES MargemTable
GO


ALTER TABLE ModelGroup
       ADD CONSTRAINT FK_MargemTable_ModelGroup_IDSalePriceMargemTable
              FOREIGN KEY (IDSalePriceMargemTable)
                             REFERENCES MargemTable
GO


ALTER TABLE ModelGroup
       ADD CONSTRAINT FK_TabGroup_ModelGroup_IDGroup
              FOREIGN KEY (IDGroup)
                             REFERENCES TabGroup
GO


ALTER TABLE ModelSubGroup
       ADD CONSTRAINT FK_MargemTable_ModelSubGroup_IDMSRPMargemTable
              FOREIGN KEY (IDMSRPMargemTable)
                             REFERENCES MargemTable
GO


ALTER TABLE ModelSubGroup
       ADD CONSTRAINT FK_MargemTable_ModelSubGroup_IDSalePriceMargemTable
              FOREIGN KEY (IDSalePriceMargemTable)
                             REFERENCES MargemTable
GO


ALTER TABLE ModelSubGroup
       ADD CONSTRAINT FK_ModelGroup_ModelSubGroup_IDModelGroup
              FOREIGN KEY (IDModelGroup)
                             REFERENCES ModelGroup
GO


ALTER TABLE Model ADD IDModelGroup int NULL, IDModelSubGroup int NULL 
GO


ALTER TABLE Model
       ADD CONSTRAINT FK_ModelSubGroup_Model_IDModelSubGroup
              FOREIGN KEY (IDModelSubGroup)
                             REFERENCES ModelSubGroup
GO


ALTER TABLE Model
       ADD CONSTRAINT FK_ModelGroup_Model_IDModelGroup
              FOREIGN KEY (IDModelGroup)
                             REFERENCES ModelGroup
GO
