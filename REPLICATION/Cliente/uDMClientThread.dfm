object DMClientThread: TDMClientThread
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 261
  Top = 110
  Height = 150
  Width = 486
  object Zipper: TAbZipper
    AutoSave = False
    DOSMode = False
    StoreOptions = [soStripPath, soReplace]
    Left = 196
    Top = 7
  end
  object UnZipper: TAbUnZipper
    Left = 269
    Top = 7
  end
  object spRecalcTotal: TADOStoredProc
    CommandTimeout = 500000
    ProcedureName = 'sp_UpdateSystemQty;1'
    Parameters = <>
    Left = 128
    Top = 28
  end
  object IdFTP1: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 336
    Top = 40
  end
  object ADODBConnect: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=MainRetailDB;Data Source=(local)'
    ConnectionTimeout = 10
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 37
    Top = 8
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
    CommandTimeout = 1800
    Parameters = <>
    Left = 32
    Top = 64
  end
end
