IF NOT EXISTS(select * from sysobjects where name = 'FK_InvColor_Model_IDColor')
BEGIN
ALTER TABLE Model
       ADD CONSTRAINT FK_InvColor_Model_IDColor
              FOREIGN KEY (IDColor)
                             REFERENCES InvColor
END
GO

IF NOT EXISTS(select * from sysobjects where name = 'FK_InvSize_Model_IDSize')
BEGIN
ALTER TABLE Model
       ADD CONSTRAINT FK_InvSize_Model_IDSize
              FOREIGN KEY (IDSize)
                             REFERENCES InvSize
END
GO
