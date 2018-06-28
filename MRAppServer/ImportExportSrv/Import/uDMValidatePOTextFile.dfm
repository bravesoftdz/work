inherited DMValidatePOTextFile: TDMValidatePOTextFile
  OldCreateOrder = True
  Left = 690
  Top = 506
  Height = 234
  Width = 334
  object qryPoItemList: TADOQuery
    Parameters = <
      item
        Name = 'DocumentID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'ModelID,'
      #9'Qty'
      'FROM'
      #9'PreInventoryMov'
      'WHERE'
      #9'DocumentID = :DocumentID '
      #9'AND'
      #9'InventMovTypeID = 2')
    Left = 124
    Top = 32
  end
  object quModelExist: TADODataSet
    CommandText = 'SELECT'#13#10#9'M.Model'#13#10'FROM'#13#10#9'Model M'#13#10'WHERE'#13#10#9'M.Model = :Model'
    Parameters = <
      item
        Name = 'Model'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end>
    Left = 48
    Top = 32
  end
  object qryMaxBarcode: TADOQuery
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'Max(BarcodeOrder) BarcodeOrder'
      'FROM '
      #9'Barcode'
      'WHERE '
      #9'IDModel = :IDModel')
    Left = 212
    Top = 32
  end
end
