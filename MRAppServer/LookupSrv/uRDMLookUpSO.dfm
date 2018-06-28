object RDMLookUpSO: TRDMLookUpSO
  OldCreateOrder = False
  Left = 136
  Top = 169
  Height = 402
  Width = 576
  object quLuSOCustomerProduct: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDSOCustomerProduct,'
      #9'Model,'
      #9'Description'#9
      'FROM'
      #9'Ser_SOCustomerProduct')
    Left = 103
    Top = 16
  end
  object dspLuSOCustomerProduct: TDataSetProvider
    DataSet = quLuSOCustomerProduct
    Left = 103
    Top = 67
  end
  object clLuSOCustomerProduct: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspLuSOCustomerProduct
    KeyFieldName = 'IDSOCustomerProduct'
    ListFieldNames.Strings = (
      'Model'
      'Description')
    RecordTypes = [rtEnabled]
    Left = 103
    Top = 126
  end
  object quLuSOStatus: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDSOStatus,'
      #9'SOStatus'
      'FROM'
      #9'Ser_SOStatus'
      'WHERE'
      #9'Hidden = 0')
    Left = 247
    Top = 16
  end
  object dspLuSOStatus: TDataSetProvider
    DataSet = quLuSOStatus
    Left = 247
    Top = 67
  end
  object clLuSOStatus: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspLuSOStatus
    KeyFieldName = 'IDSOStatus'
    ListFieldNames.Strings = (
      'SOStatus')
    RecordTypes = [rtEnabled]
    Left = 247
    Top = 126
  end
end
