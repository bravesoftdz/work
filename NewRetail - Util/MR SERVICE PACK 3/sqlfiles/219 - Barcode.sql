IF EXISTS(SELECT I.name FROM sysobjects T INNER JOIN sysindexes I ON (T.id = I.id) WHERE T.xtype = 'U' AND I.name = 'XIF146Barcode' AND T.name = 'Barcode')
 DROP INDEX Barcode.XIF146Barcode
GO
 
DELETE FROM BARCODE WHERE IDModel NOT IN (SELECT IDModel From Model)
GO

IF EXISTS(SELECT T.name, T.xtype FROM sysobjects T WHERE T.xtype = 'F' AND T.name = 'FK_Model_BarCode_IDModel')
ALTER TABLE Barcode
       DROP CONSTRAINT FK_Model_Barcode_IDModel
GO

ALTER TABLE Barcode
       ADD CONSTRAINT FK_Model_Barcode_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

CREATE INDEX XIF6IDModel ON Barcode
(
       IDModel
)
GO
