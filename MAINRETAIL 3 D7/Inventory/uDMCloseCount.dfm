object DMCloseCount: TDMCloseCount
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 1119
  Top = 384
  Height = 212
  Width = 276
  object quInvCountItem: TADODataSet
    CommandText = 
      'SELECT'#13#10#9'CI.IDCountItem,'#13#10#9'CI.Barcode,'#13#10#9'CI.Qty,'#13#10#9'CI.SalePrice,' +
      #13#10#9'CI.CountDate,'#13#10#9'CI.IDUser,'#13#10#9'CI.IDCount'#13#10'from'#13#10#9'Inv_CountItem' +
      ' CI (NOLOCK)'#13#10'where'#13#10#9'CI.IDCount = :IDCount'
    Parameters = <
      item
        Name = 'IDCount'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 60
    Top = 16
  end
  object cmdUpdInventory: TADOCommand
    CommandText = 
      'update'#13#10'  Inventory'#13#10'set'#13#10'  QtyOnHand = :Qty'#13#10'where'#13#10'  StoreID =' +
      ' :IDStore'#13#10'  and ModelID = :IDModel'
    Parameters = <
      item
        Name = 'Qty'
        Size = -1
        Value = Null
      end
      item
        Name = 'IDStore'
        Size = -1
        Value = Null
      end
      item
        Name = 'IDModel'
        Size = -1
        Value = Null
      end>
    Left = 176
    Top = 68
  end
  object quModelByBarcode: TADODataSet
    CommandText = 
      'select'#13#10'  B.IDModel'#13#10'from'#13#10'  Barcode B (NOLOCK)'#13#10'where'#13#10'  B.IDBa' +
      'rcode = :Barcode'
    Parameters = <
      item
        Name = 'Barcode'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 20
        Value = Null
      end>
    Left = 60
    Top = 120
  end
  object cmdUpdInvCount: TADOCommand
    CommandText = 
      'update'#13#10'  Inv_Count'#13#10'set'#13#10'  EndDate = :EndDate'#13#10'where'#13#10'  IDCount' +
      ' = :IDCount'
    Parameters = <
      item
        Name = 'EndDate'
        Size = -1
        Value = Null
      end
      item
        Name = 'IDCount'
        Size = -1
        Value = Null
      end>
    Left = 176
    Top = 16
  end
  object quInvFrozeItem: TADODataSet
    CommandText = 
      'SELECT'#13#10#9'IDModel'#13#10'FROM'#13#10#9'Inv_FrozeCount (NOLOCK)'#13#10'WHERE'#13#10#9'IDCoun' +
      't = :IDCount'
    Parameters = <
      item
        Name = 'IDCount'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 60
    Top = 68
  end
end
