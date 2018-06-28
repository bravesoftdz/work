object RDMLookupPurchase: TRDMLookupPurchase
  OldCreateOrder = False
  Left = 472
  Top = 281
  Height = 193
  Width = 286
  object dspLuVendor: TDataSetProvider
    DataSet = quLuVendor
    Left = 52
    Top = 76
  end
  object quLuVendor: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPessoa IDVendor,'
      #9'P.Pessoa Vendor'
      'FROM'
      #9'Pessoa P'
      #9'JOIN TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'
      'WHERE'
      #9'TP.Path LIKE '#39'.002%'#39
      #9'AND P.Desativado = 0'
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      'ORDER BY'
      #9'Pessoa')
    Left = 52
    Top = 20
  end
end
