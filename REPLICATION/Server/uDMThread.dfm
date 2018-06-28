object DMThread: TDMThread
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 153
  Top = 161
  Height = 219
  Width = 458
  object Zipper: TAbZipper
    AutoSave = False
    DOSMode = False
    StoreOptions = [soStripPath, soReplace]
    Left = 20
    Top = 15
  end
  object UnZipper: TAbUnZipper
    Left = 85
    Top = 15
  end
  object ADODBConnect: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=RodrigoTestDB;Data Source=(local)'
    ConnectionTimeout = 10
    KeepConnection = False
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 85
    Top = 80
  end
  object spRecalcTotal: TADOStoredProc
    Connection = ADODBConnect
    CommandTimeout = 5550000
    ProcedureName = 'sp_UpdateSystemQty;1'
    Parameters = <>
    Left = 296
    Top = 72
  end
  object quUpdatePet: TADOCommand
    CommandText = 
      'UPDATE Pet'#13#10#9'SET Pet.IDStore = PTT.IDStoreDest'#13#10'FROM'#13#10#9'('#13#10#9#9'SELE' +
      'CT'#13#10#9#9#9'PT.IDPet, PT.IDStoreDest, PT.TransferDate'#13#10#9#9'FROM'#13#10#9#9#9'Pet' +
      '_Transfer PT INNER JOIN'#13#10#9#9#9'('#13#10#9#9#9#9'SELECT'#13#10#9#9#9#9#9'IDPet,'#13#10#9#9#9#9#9'MAX' +
      '(TransferDate) LastTransferDate'#13#10#9#9#9#9'FROM'#13#10#9#9#9#9#9'Pet_Transfer'#13#10#9#9 +
      #9#9'GROUP BY'#13#10#9#9#9#9#9'IDPet'#13#10#9#9#9') AS LPT ON'#13#10#9#9#9#9'(PT.IDPet = LPT.IDPe' +
      't AND PT.TransferDate = LPT.LastTransferDate)'#13#10#9') PTT'#13#10#9#13#10'WHERE'#13 +
      #10#9'Pet.IDPet = PTT.IDPet'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 384
    Top = 72
  end
end
