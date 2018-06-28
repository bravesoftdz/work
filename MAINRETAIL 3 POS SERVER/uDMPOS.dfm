inherited DMPOS: TDMPOS
  OldCreateOrder = True
  Left = 83
  Top = 58
  Height = 523
  Width = 807
  inherited spGetNextID: TADOStoredProc
    Left = 124
    Top = 24
  end
  inherited ADODBConnect: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=RodrigotestDB;Data Source=DESENV001;Use' +
      ' Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Wo' +
      'rkstation ID=DESENV002;Use Encryption for Data=False;Tag with co' +
      'lumn collation when possible=False'
    Left = 44
    Top = 24
  end
  inherited quFreeSQL: TADOQuery
    Left = 212
    Top = 24
  end
  object ADOCommand: TADOCommand
    CommandTimeout = 760
    Connection = ADODBConnect
    Parameters = <>
    ParamCheck = False
    Left = 44
    Top = 84
  end
  object imgLarge: TImageList
    Height = 32
    Width = 32
    Left = 444
    Top = 12
  end
  object dsLookUpCashReg: TDataSource
    DataSet = LookUpCashReg
    Left = 212
    Top = 128
  end
  object LookUpCashReg: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDCashRegister,'#13#10#9'Name'#13#10'FROM '#13#10#9'CashRegister (FastFirst' +
      'Row NOLOCK)'#13#10'ORDER BY'#13#10#9'Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDCashRegister'
    LookUpField = 'IDCashRegister'
    quFreeSQL = quFreeSQL
    Left = 212
    Top = 84
    object LookUpCashRegIDCashRegister: TIntegerField
      FieldName = 'IDCashRegister'
    end
    object LookUpCashRegName: TStringField
      FieldName = 'Name'
      Size = 15
    end
  end
  object quSearchPreSale: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pPreSaleDate'
        DataType = ftString
        Size = 21
        Value = '02/02/2004 10:44:35'
      end
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDCashRegister'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'SaleCode'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'I.IDPreSale , I.IDCustomer'
      'FROM'
      #9'Invoice I INNER JOIN'
      #9'CashRegMov CR ON (I.CashRegMovID = CR.IDCashRegMov)'
      'WHERE'
      
        #9'convert(smalldatetime, I.PreSaleDate, 103) = convert(smalldatet' +
        'ime, :pPreSaleDate, 103)'
      #9'AND'
      #9'I.IDStore = :IDStore'
      #9'AND'
      #9'CR.IDCashRegister = :IDCashRegister'
      #9'AND'
      #9'I.SaleCode = :SaleCode'
      '')
    Left = 432
    Top = 76
  end
  object quSearchCashRegMov: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDCashRegister'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'OpenTime'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'CR.IDCashRegMov, '
      #9'CR.IDCashregStatus'
      'FROM'
      #9'CashRegMov CR'
      'WHERE'
      #9'CR.IDCashRegister = :IDCashRegister'
      #9'AND'
      #9'OpenTime = convert(smalldatetime, :OpenTime)')
    Left = 324
    Top = 76
  end
  object quRun: TADOQuery
    Connection = ADODBConnect
    Parameters = <>
    Left = 616
    Top = 72
  end
  object quSearchPreSaleID: TADOQuery
    Connection = ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'IDCustomer,'
      #9'IDInvoice'
      'FROM'
      #9'Invoice'
      'WHERE'
      #9'IDPreSale = :IDPreSale')
    Left = 324
    Top = 132
  end
  object LookUpStore: TLookUpADOQuery
    Connection = ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDStore,'#13#10#9'Name'#13#10'FROM '#13#10#9'Store (FastFirstRow NOLOCK)'#13#10'O' +
      'RDER BY'#13#10#9'Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'IDStore'
    LookUpField = 'IDStore'
    quFreeSQL = quFreeSQL
    Left = 120
    Top = 84
    object LookUpStoreIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object LookUpStoreName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object dsLookUpStore: TDataSource
    DataSet = LookUpStore
    Left = 120
    Top = 128
  end
end
