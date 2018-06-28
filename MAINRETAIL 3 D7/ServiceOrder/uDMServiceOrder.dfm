object DMServiceOrder: TDMServiceOrder
  OldCreateOrder = False
  Left = 782
  Top = 410
  Height = 333
  Width = 607
  object LookUpSOStatus: TLookUpADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT '#13#10#9'IDSOStatus,'#13#10#9'SOStatus,'#13#10#9'Color'#13#10'FROM '#13#10#9'Ser_SOStatus ' +
      '(NOLOCK)'#13#10#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'SOStatus'
    CodeField = 'IDSOStatus'
    LookUpField = 'IDSOStatus'
    OnClickButton = LookUpSOStatusClickButton
    Left = 55
    Top = 22
    object LookUpSOStatusIDSOStatus: TIntegerField
      FieldName = 'IDSOStatus'
    end
    object LookUpSOStatusSOStatus: TStringField
      FieldName = 'SOStatus'
      Size = 50
    end
    object LookUpSOStatusColor: TStringField
      FieldName = 'Color'
    end
  end
  object dsLookUpSOStatus: TDataSource
    DataSet = LookUpSOStatus
    Left = 54
    Top = 78
  end
  object dsSOCutomerProduct: TDataSource
    DataSet = LookUpSOCutomerProduct
    Left = 179
    Top = 83
  end
  object LookUpSOCutomerProduct: TLookUpADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'IDSOCustomerProduct,'#13#10#9'Model,'#13#10#9'Description'#13#10'FROM'#13#10#9'Ser' +
      '_SOCustomerProduct (NOLOCK)'#13#10#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Model'
    CodeField = 'Description'
    LookUpField = 'IDSOCustomerProduct'
    OnClickButton = LookUpSOCutomerProductClickButton
    Left = 180
    Top = 27
    object LookUpSOCutomerProductIDSOCustomerProduct: TIntegerField
      FieldName = 'IDSOCustomerProduct'
    end
    object LookUpSOCutomerProductModel: TStringField
      FieldName = 'Model'
      Size = 50
    end
    object LookUpSOCutomerProductDescription: TStringField
      FieldName = 'Description'
      Size = 100
    end
  end
  object spApplyPayDiscount: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_ServiceOrder_ApplyDiscount;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDServiceOrder'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@PercDiscount'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 15
        Value = Null
      end>
    Left = 307
    Top = 29
  end
end
