object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 344
  Top = 185
  Height = 480
  Width = 696
  object ADOConnection: TADOConnection
    CommandTimeout = 720
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=MR_DB_User;Persist Security Info=Tr' +
      'ue;User ID=sa;Data Source=(Local)\Pinogy;Use Procedure for Prepa' +
      're=1;Auto Translate=True;Packet Size=4096;Workstation ID=NOTEBOO' +
      'K'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 35
    Top = 5
  end
  object cmdRumSql: TADOCommand
    CommandTimeout = 1440
    Connection = ADOConnection
    Parameters = <>
    ParamCheck = False
    Left = 35
    Top = 60
  end
  object qryVersion: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT VersionNo, BuildNo, MRBuild'
      'FROM sys_Module')
    Left = 240
    Top = 10
    object qryVersionVersionNo: TIntegerField
      FieldName = 'VersionNo'
    end
    object qryVersionBuildNo: TIntegerField
      FieldName = 'BuildNo'
    end
    object qryVersionMRBuild: TIntegerField
      FieldName = 'MRBuild'
    end
  end
  object cmdUpdateVersion: TADOCommand
    CommandText = 
      'UPDATE sys_Module'#13#10'SET BuildNo = :Build,'#13#10'VersionNo = :Version,'#13 +
      #10'MRBuild = :MRBuild'#13#10
    CommandTimeout = 720
    Connection = ADOConnection
    Parameters = <
      item
        Name = 'Build'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Version'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'MRBuild'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 345
    Top = 10
  end
  object quFreeSQL: TADODataSet
    Connection = ADOConnection
    CommandTimeout = 1440
    Parameters = <>
    Left = 35
    Top = 120
  end
  object ADORestore: TADOConnection
    CommandTimeout = 720
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 150
    Top = 5
  end
  object cmdValidateColumnMRBuild: TADOCommand
    CommandText = 
      'IF NOT EXISTS ( SELECT 1 FROM information_schema.columns WHERE c' +
      'olumn_name='#39'MRBuild'#39' AND table_name='#39'Sys_Module'#39')'#13#10'BEGIN'#13#10#9'ALTER' +
      ' TABLE Sys_Module ADD MRBuild INT NULL'#13#10'END'
    Connection = ADOConnection
    Parameters = <>
    Left = 305
    Top = 95
  end
end
