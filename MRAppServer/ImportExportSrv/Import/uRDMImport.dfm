object RDMImport: TRDMImport
  OldCreateOrder = False
  Left = 450
  Top = 205
  Height = 335
  Width = 553
  object dspLookupStore: TDataSetProvider
    DataSet = qryLookupStore
    Left = 52
    Top = 76
  end
  object dspLookupVendor: TDataSetProvider
    DataSet = qryLookupVendor
    Left = 164
    Top = 76
  end
  object dspLookupUser: TDataSetProvider
    DataSet = qryLookupUser
    Left = 272
    Top = 76
  end
  object qryLookupStore: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'select'
      '  IDStore,'
      '  Name as Store'
      'from'
      '  Store'
      'where'
      '  Desativado = 0'
      '  and Hidden = 0')
    Left = 52
    Top = 24
  end
  object qryLookupUser: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'select'
      '  IDUser,'
      '  SystemUser as [User]'
      'from'
      '  SystemUser'
      'where'
      '  Desativado = 0'
      '  and Hidden = 0'
      '  and System = 0'
      'order by'
      '  SystemUser')
    Left = 268
    Top = 24
  end
  object qryLookupVendor: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '  '#9'IDPessoa as IDVendor,'
      '  '#9'Pessoa as Vendor'
      'FROM'
      #9'Pessoa P'
      #9'JOIN TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'
      'WHERE'
      '  '#9'TP.Path LIKE '#39'.002%'#39
      '  '#9'AND P.Desativado = 0'
      '  '#9'AND P.Hidden = 0'
      'ORDER BY'
      #9'Pessoa')
    Left = 164
    Top = 24
  end
end
