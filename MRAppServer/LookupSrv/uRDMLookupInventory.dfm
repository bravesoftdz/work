object RDMLookupInventory: TRDMLookupInventory
  OldCreateOrder = False
  Left = 163
  Top = 222
  Height = 426
  Width = 627
  object dspLuManufacturer: TDataSetProvider
    DataSet = quLuManufacturer
    Left = 52
    Top = 76
  end
  object quLuManufacturer: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPessoa IDManufacturer,'
      #9'P.Pessoa Manufacturer'
      'FROM'
      #9'Pessoa P'
      #9'JOIN TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)'
      'WHERE'
      #9'TP.Path LIKE '#39'.004%'#39
      #9'AND P.Desativado = 0'
      #9'AND P.System = 0'
      #9'AND P.Hidden = 0'
      'ORDER BY'
      #9'Pessoa')
    Left = 52
    Top = 20
  end
  object quLuModel: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        IDModel,'
      '        Model,'
      '        Description,'
      ' (Model + '#39' - '#39' + Description) as ModelDesc'
      'FROM'
      '        Model (NOLOCK INDEX=XIE_Model_Combo)'
      'WHERE'
      ' ModelType IN ('#39'R'#39','#39'S'#39')'
      'ORDER BY'
      '        Model,'
      ' Description')
    Left = 132
    Top = 20
  end
  object dspLuModel: TDataSetProvider
    DataSet = quLuModel
    Left = 132
    Top = 76
  end
  object quLuColor: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        IDColor,'
      '        Color,'
      '        CodColor'
      'FROM'
      '        InvColor'
      'ORDER BY'
      '        Color')
    Left = 204
    Top = 20
  end
  object quLuSize: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        IDSize,'
      '        SizeName,'
      '        CodSize'
      'FROM'
      '        InvSize'
      'ORDER BY'
      '        SizeName')
    Left = 264
    Top = 20
  end
  object dspLuColor: TDataSetProvider
    DataSet = quLuColor
    Left = 204
    Top = 76
  end
  object dspLuSize: TDataSetProvider
    DataSet = quLuSize
    Left = 264
    Top = 76
  end
  object quLuCategory: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDGroup IDCategory,'
      #9'Name Category'
      'FROM'
      #9'TabGroup'
      'WHERE'
      #9'IDGroup <> 0'
      #9'AND'
      #9'Desativado = 0'
      #9'AND'
      #9'Hidden = 0 '
      'ORDER BY'
      #9'Name')
    Left = 52
    Top = 136
  end
  object dspLuCategory: TDataSetProvider
    DataSet = quLuCategory
    Left = 52
    Top = 192
  end
  object dspLuGroup: TDataSetProvider
    DataSet = quLuGroup
    Left = 336
    Top = 76
  end
  object dspLuSubCategory: TDataSetProvider
    DataSet = quLuSubCategory
    Left = 424
    Top = 80
  end
  object quLuGroup: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'MSG.IDModelSubGroup IDGroup,'
      #9'MSG.ModelSubGroup ModelGroup'
      'FROM'
      #9'vwModelSubGroup MSG'
      'WHERE'
      #9'Desativado = 0'
      #9'AND'
      #9'Hidden = 0 '
      'ORDER BY'
      #9'MSG.ModelSubGroup')
    Left = 336
    Top = 20
  end
  object quLuSubCategory: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'MG.IDModelGroup IDSubCategory,'
      #9'MG.ModelGroup SubCategory'
      'FROM'
      #9'vwModelGroup MG'
      'WHERE'
      #9'Desativado = 0'
      #9'AND'
      #9'Hidden = 0 '
      'ORDER BY'
      #9'MG.ModelGroup')
    Left = 428
    Top = 24
  end
  object clCaterory: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbDelete, cbClear]
    DataSetProvider = dspLuCategory
    KeyFieldName = 'IDCategory'
    ListFieldNames.Strings = (
      'Category')
    RecordTypes = [rtEnabled]
    Left = 52
    Top = 244
  end
  object quLuDefectType: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDDefectType,'
      #9'DefectType'
      'FROM'
      #9'Inv_DefectType'
      'WHERE'
      #9'Desativado = 0')
    Left = 156
    Top = 136
  end
  object dspLuDefectType: TDataSetProvider
    DataSet = quLuDefectType
    Left = 156
    Top = 192
  end
  object clLuDefectType: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbDelete, cbClear]
    DataSetProvider = dspLuDefectType
    KeyFieldName = 'IDDefectType'
    ListFieldNames.Strings = (
      'DefectType')
    RecordTypes = [rtEnabled]
    Left = 156
    Top = 244
  end
end
