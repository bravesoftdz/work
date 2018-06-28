ALTER TABLE Inv_ColorToGroup
       ADD CONSTRAINT FK_InvColor_IDColor_Inv_ColorToGroup_IDColor
              FOREIGN KEY (IDColor)
                             REFERENCES InvColor
GO

ALTER TABLE Inv_SizeToGroup
       ADD CONSTRAINT InvSize_IDSize_Inv_SizeToGroup_IDSize
              FOREIGN KEY (IDSize)
                             REFERENCES InvSize
GO
