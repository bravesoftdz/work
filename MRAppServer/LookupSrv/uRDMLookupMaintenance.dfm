object RDMLookupMaintenance: TRDMLookupMaintenance
  OldCreateOrder = False
  Left = 160
  Top = 59
  Height = 617
  Width = 764
  object dspLuStore: TDataSetProvider
    DataSet = quLuStore
    Left = 40
    Top = 72
  end
  object quLuStore: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'S.IDStore,'
      #9'S.Name Store'
      'FROM'
      #9'Store S'
      'WHERE'
      #9'S.Desativado = 0'
      #9'AND S.System = 0'
      #9'AND S.Hidden = 0'
      'ORDER BY'
      #9'S.Name')
    Left = 40
    Top = 16
  end
  object quLuCustomer: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPessoa,'
      #9'P.Pessoa,'
      #9'P.Endereco,'
      #9'P.Email,'
      #9'P.Cidade,'
      #9'P.IDEstado,'
      #9'P.CEP'
      'FROM'
      #9'Pessoa P'
      #9'JOIN TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'
      'WHERE'
      #9'TP.Path LIKE '#39'.001%'#39
      #9'AND P.Desativado = 0'
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      'ORDER BY'
      #9'Pessoa')
    Left = 120
    Top = 16
  end
  object dspLuCustomer: TDataSetProvider
    DataSet = quLuCustomer
    Left = 120
    Top = 72
  end
  object quLuTaxCategory: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        T.IDTaxCategory,'
      '        T.TaxCategory,'
      '        IsNull(T.Tax,0) as Tax'
      'FROM'
      '        TaxCategory T'
      'WHERE'
      '        T.IDTaxCategoryParent = 0'
      'Order by'
      '        T.TaxCategory'
      ' ')
    Left = 208
    Top = 16
  end
  object dspLuTaxCategory: TDataSetProvider
    DataSet = quLuTaxCategory
    Left = 212
    Top = 72
  end
  object dspLuUser: TDataSetProvider
    DataSet = quLuUser
    Left = 296
    Top = 76
  end
  object quLuUser: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'SU.IDUser,'
      #9'SU.SystemUser'
      'FROM'
      #9'SystemUser SU'
      'WHERE'
      #9'SU.Desativado <> 1'
      #9'AND'
      #9'SU.System <> 1'
      'ORDER BY'
      #9'SU.SystemUser')
    Left = 296
    Top = 16
  end
  object quLuCashRegister: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDCashRegister,'
      #9'Name CashRegister '
      'FROM'
      #9'CashRegister'
      'ORDER BY '
      #9'Name')
    Left = 376
    Top = 16
  end
  object dspLuCashRegister: TDataSetProvider
    DataSet = quLuCashRegister
    Left = 376
    Top = 72
  end
  object dspLuMedia: TDataSetProvider
    DataSet = quLuMedia
    Left = 40
    Top = 260
  end
  object quLuMedia: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'M.IDMedia,'
      #9'M.Media'
      'FROM'
      #9'Media M'
      'WHERE'
      #9'M.Desativado = 0'
      #9'AND M.Hidden = 0'
      'ORDER BY'
      #9'M.Media')
    Left = 40
    Top = 204
  end
  object quLuAgency: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPessoa IDAgency,'
      #9'P.Pessoa Agency'
      'FROM'
      #9'Pessoa P'
      #9'JOIN TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'
      'WHERE'
      #9'TP.Path LIKE '#39'.003.003%'#39
      #9'AND'
      #9'P.Desativado = 0'
      #9'AND'
      #9'P.Hidden = 0'
      #9'AND'
      #9'P.System = 0'
      'ORDER BY'
      #9'P.Pessoa')
    Left = 120
    Top = 204
  end
  object dspLuAgency: TDataSetProvider
    DataSet = quLuAgency
    Left = 120
    Top = 260
  end
  object dspLuGuide: TDataSetProvider
    DataSet = quLuGuide
    Left = 212
    Top = 260
  end
  object quLuGuide: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPessoa IDGuide,'
      #9'P.Pessoa Guide'
      'FROM'
      #9'Pessoa P'
      #9'JOIN TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'
      'WHERE'
      #9'TP.Path LIKE '#39'.003.002%'#39
      #9'AND'
      #9'P.Desativado = 0'
      #9'AND'
      #9'P.Hidden = 0'
      #9'AND'
      #9'P.System = 0'
      'ORDER BY'
      #9'P.Pessoa')
    Left = 212
    Top = 204
  end
  object quLuChartOfAccount: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'LT.IDLancamentoTipo,'
      #9'LT.LancamentoTipo'
      'FROM'
      #9'Fin_LancamentoTipo LT'
      'WHERE'
      #9'LT.Hidden = 0'
      #9'AND'
      #9'LT.Desativado = 0'
      'ORDER BY'
      #9'LT.LancamentoTipo')
    Left = 308
    Top = 204
  end
  object dspLuChartOfAccount: TDataSetProvider
    DataSet = quLuChartOfAccount
    Left = 308
    Top = 260
  end
  object quLuDocumentType: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'DT.IDDocumentoTipo,'
      #9'DT.DocumentoTipo'
      'FROM '
      #9'Fin_DocumentoTipo DT'
      'WHERE'
      #9'DT.Hidden = 0'
      #9'AND'
      #9'DT.Desativado = 0'
      #9'AND'
      #9'DT.System = 0')
    Left = 416
    Top = 204
  end
  object dspLuDocumentType: TDataSetProvider
    DataSet = quLuDocumentType
    Left = 416
    Top = 260
  end
  object quLuBank: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'B.IDBanco,'
      #9'B.CodigoBanco,'
      #9'B.Banco'
      'FROM'
      #9'Fin_Banco B'
      'WHERE'
      #9'B.System = 0'
      #9'AND B.Hidden = 0'
      #9'AND B.Desativado = 0')
    Left = 520
    Top = 204
  end
  object dspLuBank: TDataSetProvider
    DataSet = quLuBank
    Left = 520
    Top = 260
  end
  object dspBankAccount: TDataSetProvider
    DataSet = quLuBankAccount
    Left = 476
    Top = 72
  end
  object quLuBankAccount: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'CC.IDContaCorrente,'
      #9'CC.Numero'
      'FROM'
      #9'Fin_ContaCorrente CC'
      'WHERE'
      #9'CC.System = 0'
      #9'AND CC.Hidden = 0'
      #9'AND Desativado = 0')
    Left = 476
    Top = 16
  end
  object quLuPaymentType: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'MP.IDMeioPag,'
      #9'MP.MeioPag'
      'FROM'
      #9'MeioPag MP'
      'WHERE'
      #9'MP.System = 0'
      #9'AND '
      #9'MP.Hidden = 0'
      #9'AND '
      #9'MP.Desativado = 0')
    Left = 576
    Top = 16
  end
  object dspPaymentType: TDataSetProvider
    DataSet = quLuPaymentType
    Left = 576
    Top = 72
  end
  object quLuState: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDEstado,'
      #9'Estado'
      'FROM '
      #9'Estado'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0')
    Left = 40
    Top = 336
  end
  object dspLuState: TDataSetProvider
    DataSet = quLuState
    Left = 40
    Top = 392
  end
  object quLuCountry: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDPais,'
      #9'CodPais,'
      #9'Pais'
      'FROM '
      #9'Pais'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0')
    Left = 131
    Top = 336
  end
  object dspLuCountry: TDataSetProvider
    DataSet = quLuCountry
    Left = 131
    Top = 394
  end
  object quLuEntityType: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDTipoPessoa,'
      #9'TipoPessoa,'
      #9'Path'
      'FROM '
      #9'TipoPessoa'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0')
    Left = 227
    Top = 336
  end
  object dspLuEntityType: TDataSetProvider
    DataSet = quLuEntityType
    Left = 227
    Top = 394
  end
  object clLuEntiryType: TmrConfigLookupSvr
    CommandButtons = [cbClear]
    DataSetProvider = dspLuEntityType
    KeyFieldName = 'IDTipoPessoa'
    ListFieldNames.Strings = (
      'TipoPessoa')
    RecordTypes = [rtEnabled]
    Left = 228
    Top = 448
  end
  object clLuState: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspLuState
    KeyFieldName = 'IDEstado'
    ListFieldNames.Strings = (
      'Estado')
    RecordTypes = [rtEnabled]
    Left = 40
    Top = 448
  end
  object clLuPais: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspLuCountry
    KeyFieldName = 'IDPais'
    ListFieldNames.Strings = (
      'Pais')
    RecordTypes = [rtEnabled]
    Left = 132
    Top = 448
  end
  object quLuManufacture: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPessoa,'
      #9'P.Pessoa,'
      #9'P.UserCode'
      'FROM'
      #9'Pessoa P'
      #9'JOIN TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'
      'WHERE'
      #9'TP.Path LIKE '#39'.004%'#39
      #9'AND'
      #9'P.Desativado = 0'
      #9'AND'
      #9'P.Hidden = 0'
      #9'AND'
      #9'P.System = 0')
    Left = 319
    Top = 336
  end
  object dspManufacture: TDataSetProvider
    DataSet = quLuManufacture
    Left = 319
    Top = 392
  end
  object clLuManufacture: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspManufacture
    KeyFieldName = 'IDPessoa'
    ListFieldNames.Strings = (
      'Pessoa')
    RecordTypes = [rtEnabled]
    Left = 320
    Top = 448
  end
  object quLuSystemUser: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'SU.IDUser,'
      #9'SU.UserTypeID,'
      #9'SU.ComissionID,'
      #9'SU.SystemUser,'
      #9'SU.PW'
      'FROM'
      #9'SystemUser SU'
      'WHERE'
      #9'SU.Desativado = 0'
      #9'AND SU.Hidden = 0'
      #9'AND SU.System = 0')
    Left = 423
    Top = 336
  end
  object dspLuSystemUser: TDataSetProvider
    DataSet = quLuSystemUser
    Left = 423
    Top = 392
  end
  object clLuSystemUser: TmrConfigLookupSvr
    CommandButtons = [cbClear]
    DataSetProvider = dspLuSystemUser
    KeyFieldName = 'IDUser'
    ListFieldNames.Strings = (
      'SystemUser')
    RecordTypes = [rtEnabled]
    Left = 424
    Top = 448
  end
  object clLuStore: TmrConfigLookupSvr
    CommandButtons = []
    DataSetProvider = dspLuStore
    KeyFieldName = 'IDStore'
    ListFieldNames.Strings = (
      'Store')
    RecordTypes = [rtEnabled]
    Left = 40
    Top = 128
  end
  object clCustomer: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspLuCustomer
    KeyFieldName = 'IDPessoa'
    ListFieldNames.Strings = (
      'Pessoa')
    RecordTypes = [rtEnabled]
    Left = 120
    Top = 128
  end
  object quLuCommission: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPessoa,'
      #9'P.Pessoa,'
      #9'P.UserCode'
      'FROM'
      #9'Pessoa P'
      #9'JOIN TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'
      'WHERE'
      #9'TP.Path LIKE '#39'.003%'#39
      #9'AND P.Desativado = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.System = 0')
    Left = 523
    Top = 336
  end
  object dspLuCommission: TDataSetProvider
    DataSet = quLuCommission
    Left = 523
    Top = 392
  end
  object dspLuCompany: TDataSetProvider
    DataSet = quLuCompany
    Left = 615
    Top = 260
  end
  object quLuCompany: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'E.IDEmpresa,'
      #9'E.CodigoEmpresa,'
      #9'E.Empresa'
      'FROM'
      #9'Sis_Empresa E'
      'WHERE'
      #9'E.System = 0'
      #9'AND E.Hidden = 0'
      #9'AND E.Desativado = 0')
    Left = 615
    Top = 204
  end
end
