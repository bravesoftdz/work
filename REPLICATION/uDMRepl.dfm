inherited DMRepl: TDMRepl
  OldCreateOrder = True
  Width = 557
  object ADOCommand: TADOCommand
    CommandTimeout = 760
    Connection = ADODBConnect
    Parameters = <>
    ParamCheck = False
    Left = 45
    Top = 85
  end
  object Zipper: TAbZipper
    AutoSave = False
    DOSMode = False
    StoreOptions = [soStripPath, soReplace]
    Left = 340
    Top = 15
  end
  object UnZipper: TAbUnZipper
    Left = 405
    Top = 15
  end
  object imgLarge: TImageList
    Height = 32
    Width = 32
    Left = 475
    Top = 150
  end
  object quUpdTotQtyOnHand: TADOCommand
    CommandText = 
      'UPDATE'#13#10#9'Model'#13#10'SET'#13#10#9'Model.TotQtyOnHand = TotInv.TotQtyOnHand'#13#10 +
      'FROM'#13#10#9'('#13#10#9'SELECT '#13#10#9#9'ModelID IDModel, '#13#10#9#9'SUM(QtyOnHand) TotQty' +
      'OnHand'#13#10#9'FROM '#13#10#9#9'Inventory '#13#10#9'GROUP BY '#13#10#9#9'ModelID'#13#10#9') TotInv'#13#10 +
      'WHERE'#13#10#9'Model.IDModel = TotInv.IDModel'
    Parameters = <>
    Left = 40
    Top = 176
  end
  object spRecalcTotal: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 5000
    ProcedureName = 'sp_UpdateSystemQty;1'
    Parameters = <>
    Left = 176
    Top = 172
  end
end
