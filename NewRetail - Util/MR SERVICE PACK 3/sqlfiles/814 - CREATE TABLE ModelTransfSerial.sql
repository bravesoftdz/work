CREATE TABLE ModelTransfSerial (
       IDModelTransfSerial  int NOT NULL,
       IDModelTransfDet     int NULL,
       SerialNum            varchar(30) NULL
)
GO

ALTER TABLE ModelTransfSerial
       ADD CONSTRAINT XPKModelTransfSerial PRIMARY KEY (
              IDModelTransfSerial)
GO

ALTER TABLE ModelTransfSerial
       ADD CONSTRAINT FK_ModelTransfDet_ModelTransfSerial_IDModelTransfDet
              FOREIGN KEY (IDModelTransfDet)
                             REFERENCES ModelTransfDet
GO
