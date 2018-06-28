inherited FrmParentSaleFull: TFrmParentSaleFull
  Caption = ''
  PixelsPerInch = 96
  TextHeight = 13
  object quTestSerialNumber: TADODataSet [8]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT '#13#10#9'PIM.IDPreInventoryMov'#13#10'FROM'#9#13#10#9'PreInventoryMov PIM'#13#10#9'L' +
      'EFT OUTER JOIN PreSerialMov PSM ON (PIM.IDPreInventoryMov = PSM.' +
      'PreInventoryMovID)'#13#10#9'JOIN Model M ON (PIM.ModelID = M.IDModel)'#13#10 +
      #9'JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)'#13#10'WHERE '#13#10#9'TG.Seria' +
      'lNumber = 1'#13#10#9'AND '#13#10#9'PIM.UserID = :IDUser'#13#10#9'AND  '#13#10#9'PIM.Document' +
      'ID = :DocumentID'#13#10'GROUP BY '#13#10#9'IDPreInventoryMov, '#13#10#9'PIM.Qty'#13#10'HAV' +
      'ING '#13#10#9'COUNT(PSM.SerialNumber) < ABS(PIM.Qty)'#13#10
    Parameters = <
      item
        Name = 'IDUser'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DocumentID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 476
    Top = 268
  end
end
