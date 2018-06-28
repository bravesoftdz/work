object DMInventory: TDMInventory
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 809
  Top = 82
  Height = 277
  Width = 441
  object quQtyDifference: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'QtyOnHand'#13#10'FROM'#13#10#9'Inventory (NOLOCK)'#13#10'WHERE '#13#10#9'StoreID ' +
      '= :IDStore'#13#10#9'AND'#13#10#9'ModelID = :IDModel'
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 84
    Top = 64
  end
  object cmdInsInventoryMov: TADOCommand
    CommandText = 
      'INSERT InventoryMov (IDInventoryMov, InventMovTypeID, DocumentID' +
      ', StoreID, ModelID, MovDate, Qty, IDUser)'#13#10'VALUES (:IDInventoryM' +
      'ov, :InventMovTypeID, :DocumentID, :IDStore, :IDModel, :MovDate,' +
      ' :Qty, :IDUser)'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'InventMovTypeID'
        Attributes = [paSigned]
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
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MovDate'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 84
    Top = 12
  end
  object quModelExist: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'M.Model'#13#10'FROM'#13#10#9'Model M (NOLOCK)'#13#10'WHERE'#13#10#9'M.Model = :Mo' +
      'del'
    Parameters = <
      item
        Name = 'Model'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end>
    Left = 84
    Top = 112
  end
  object quCategory: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT '#13#10#9'TG.IDGroup,'#13#10#9'TG.Name,'#13#10#9'TG.SizeAndColor,'#13#10#9'TG.PackMod' +
      'el,'#13#10#9'TG.SerialNumber,'#13#10#9'TG.Service,'#13#10#9'TG.Credit,'#13#10#9'TG.GiftCard,' +
      #13#10#9'TG.PuppyTracker'#13#10'FROM'#13#10#9'TabGroup TG (NOLOCK)'#13#10'WHERE'#13#10#9'TG.Desa' +
      'tivado = 0'#13#10#9'AND'#13#10#9'TG.System = 0'
    CommandTimeout = 180
    Parameters = <>
    Left = 184
    Top = 14
  end
  object cmdInsertModelPriceLog: TADOCommand
    CommandText = 
      'INSERT ModelPriceLog (IDModelPriceLog, IDModel, IDUser, IDStore,' +
      ' ChangeDate, OldCostPrice, NewCostPrice, OldSalePrice, NewSalePr' +
      'ice)'#13#10'VALUES (:IDModelPriceLog, :IDModel, :IDUser, :IDStore, :Ch' +
      'angeDate, :OldCostPrice, :NewCostPrice, :OldSalePrice, :NewSaleP' +
      'rice)'#13#10
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDModelPriceLog'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'ChangeDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'OldCostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewCostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'OldSalePrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewSalePrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end>
    Left = 200
    Top = 80
  end
  object spLotAdjust: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Inventory_Lot_Adjust;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDModel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDStore'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDLot'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Qty'
        Attributes = [paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 38
        Value = Null
      end
      item
        Name = '@Type'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 210
    Top = 145
  end
end
