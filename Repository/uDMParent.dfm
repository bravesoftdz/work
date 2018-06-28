object DMParent: TDMParent
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 65532
  Top = 65532
  Height = 580
  Width = 808
  object spGetNextID: TADOStoredProc
    Connection = ADODBConnect
    ProcedureName = 'sp_Sis_GetNextCode;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Tabela'
        Attributes = [paNullable]
        DataType = ftString
        Size = 100
        Value = Null
      end
      item
        Name = '@NovoCodigo'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 128
    Top = 15
  end
  object ADODBConnect: TADOConnection
    CommandTimeout = 360
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=ApresentationDB;Data Source=(local);Net' +
      'work Library=DBMSSOCN;Use Procedure for Prepare=1;Auto Translate' +
      '=True;Packet Size=4096;Workstation ID=RETAIL;Use Encryption for ' +
      'Data=False;Tag with column collation when possible=False'
    ConnectionTimeout = 10
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'SQLOLEDB.1'
    Left = 45
    Top = 8
  end
  object quFreeSQL: TADOQuery
    Connection = ADODBConnect
    CursorType = ctDynamic
    Parameters = <>
    Left = 217
    Top = 15
  end
end
