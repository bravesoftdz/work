object RDMApplicationHub: TRDMApplicationHub
  OldCreateOrder = False
  OnCreate = RemoteDataModuleCreate
  OnDestroy = RemoteDataModuleDestroy
  Left = 623
  Top = 527
  Height = 213
  Width = 401
  object ADOConnection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 20
  end
  object qryGetNextCode: TADOQuery
    Connection = ADOConnection
    Parameters = <
      item
        Name = 'TableField'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 100
        Value = Null
      end>
    SQL.Strings = (
      'SELECT UltimoCodigo '
      'FROM Sis_CodigoIncremental'
      'WHERE Tabela = :TableField')
    Left = 40
    Top = 80
  end
  object qrySetNextCode: TADOQuery
    Connection = ADOConnection
    Parameters = <
      item
        Name = 'TableField'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 100
        Value = Null
      end>
    SQL.Strings = (
      'UPDATE'
      '  Sis_CodigoIncremental'
      'SET'
      '  UltimoCodigo = UltimoCodigo + 1'
      'FROM'
      '  Sis_CodigoIncremental (UPDLOCK, ROWLOCK)'
      'WHERE  '#9
      '  Tabela = :TableField')
    Left = 136
    Top = 80
  end
  object dspLogin: TDataSetProvider
    DataSet = qryLogin
    Left = 212
    Top = 80
  end
  object qryLogin: TADODataSet
    Connection = ADOConnection
    CommandText = 
      'SELECT'#13#10#9'SU.IDUser,'#13#10#9'UT.IDUserType,'#13#10#9'SU.[SystemUser],'#13#10#9'UR.Can' +
      'Access,'#13#10#9'SU.ComissionID'#13#10'FROM'#13#10#9'[SystemUser] SU'#13#10#9'JOIN UserType' +
      ' UT ON (SU.UserTypeID = UT.IDUserType)'#13#10#9'JOIN UserRights UR ON (' +
      'UR.UserTypeID = UT.IDUserType)'#13#10'WHERE'#13#10#9'((PW = :Password) AND (M' +
      'enuID = :MenuID) AND (SubMenuID = :SubMenuID))'#13#10'        AND SU.D' +
      'esativado = 0'
    Parameters = <
      item
        Name = 'Password'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = Null
      end
      item
        Name = 'MenuID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'SubMenuID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 212
    Top = 24
  end
  object spGetNextKey: TADOStoredProc
    Connection = ADOConnection
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
    Left = 284
    Top = 24
  end
end
