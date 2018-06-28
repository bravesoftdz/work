object RDMLookUpPet: TRDMLookUpPet
  OldCreateOrder = False
  Left = 134
  Top = 179
  Height = 466
  Width = 714
  object clLuPetBreed: TmrConfigLookupSvr
    CommandButtons = [cbClear]
    DataSetProvider = dspLuPetBreed
    KeyFieldName = 'IDBreed'
    ListFieldNames.Strings = (
      'Breed')
    RecordTypes = [rtEnabled]
    Left = 43
    Top = 126
  end
  object dspLuPetBreed: TDataSetProvider
    DataSet = quLuPetBreed
    Left = 43
    Top = 71
  end
  object quLuPetBreed: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDBreed,'
      #9'Breed'
      'FROM '
      #9'Pet_Breed (NOLOCK)'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0'
      'ORDER BY'
      #9'Breed')
    Left = 43
    Top = 16
  end
  object clLuPetStatus: TmrConfigLookupSvr
    CommandButtons = [cbClear]
    DataSetProvider = dspLuPetStatus
    KeyFieldName = 'IDStatus'
    ListFieldNames.Strings = (
      'Status'
      'StatusCode')
    RecordTypes = [rtEnabled]
    Left = 155
    Top = 126
  end
  object dspLuPetStatus: TDataSetProvider
    DataSet = quLuPetStatus
    Left = 155
    Top = 71
  end
  object quLuPetStatus: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDStatus,'
      #9'StatusCode,'
      #9'Status'
      'FROM '
      #9'Pet_Status (NOLOCK)'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0')
    Left = 155
    Top = 16
  end
  object ctLuPetRegistry: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspLuPetRegistry
    KeyFieldName = 'IDRegistry'
    ListFieldNames.Strings = (
      'Registry')
    RecordTypes = [rtEnabled]
    Left = 263
    Top = 126
  end
  object dspLuPetRegistry: TDataSetProvider
    DataSet = quLuPetRegistry
    Left = 263
    Top = 71
  end
  object quLuPetRegistry: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDRegistry,'
      #9'Registry'
      'FROM '
      #9'Pet_Registry (NOLOCK)'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0')
    Left = 263
    Top = 16
  end
  object ctLuPetMicrochip: TmrConfigLookupSvr
    CommandButtons = [cbClear]
    DataSetProvider = dspLuPetMicrochip
    KeyFieldName = 'IDMicrochip'
    ListFieldNames.Strings = (
      'Microchip')
    RecordTypes = [rtEnabled]
    Left = 375
    Top = 126
  end
  object dspLuPetMicrochip: TDataSetProvider
    DataSet = quLuPetMicrochip
    Left = 375
    Top = 71
  end
  object quLuPetMicrochip: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'IDMicrochip,'
      #9'Microchip'
      'FROM '
      #9'Pet_Microchip (NOLOCK)'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0')
    Left = 375
    Top = 16
  end
  object ctLuPetSpecies: TmrConfigLookupSvr
    CommandButtons = [cbOpen, cbClear]
    DataSetProvider = dspLuPetSpecies
    KeyFieldName = 'IDSpecies'
    ListFieldNames.Strings = (
      'Species')
    RecordTypes = [rtEnabled]
    Left = 495
    Top = 126
  end
  object dspLuPetSpecies: TDataSetProvider
    DataSet = quLuPetSpecies
    Left = 495
    Top = 71
  end
  object quLuPetSpecies: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDSpecies,'
      #9'Species'
      'FROM'
      #9'Pet_Species (NOLOCK)'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0')
    Left = 495
    Top = 16
  end
  object ctLuPetTreatmentLot: TmrConfigLookupSvr
    CommandButtons = [cbClear]
    DataSetProvider = dspLuPetTreatmentLot
    KeyFieldName = 'IDTreatmentLot'
    ListFieldNames.Strings = (
      'LotNumber')
    RecordTypes = [rtEnabled]
    Left = 611
    Top = 126
  end
  object dspLuPetTreatmentLot: TDataSetProvider
    DataSet = quLuPetTreatmentLot
    Left = 611
    Top = 71
  end
  object quLuPetTreatmentLot: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'TL.IDTreatmentLot,'
      #9'TL.IDTreatment,'
      #9'TL.ExpirationDate,'
      #9'TL.LotNumber'
      'FROM'
      #9'Pet_TreatmentLot TL (NOLOCK)'
      
        #9'JOIN Pet_Treatment T (NOLOCK) ON (TL.IDTreatment = T.IDTreatmen' +
        't)'
      'WHERE'
      #9'TL.Desativado = 0'
      #9'AND TL.Hidden = 0'
      '')
    Left = 611
    Top = 16
  end
  object ctLuPetTreatment: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspLuPetTreatment
    KeyFieldName = 'IDTreatment'
    ListFieldNames.Strings = (
      'Treatment'
      'TreatmentTypeStr')
    RecordTypes = [rtEnabled]
    Left = 43
    Top = 298
  end
  object dspLuPetTreatment: TDataSetProvider
    DataSet = quLuPetTreatment
    Left = 43
    Top = 243
  end
  object quLuPetTreatment: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PT.IDTreatment,'
      #9'PT.Treatment,'
      #9'(CASE PT.TreatmentType '
      #9'WHEN 1 THEN '#39'Vaccine'#39
      #9'WHEN 2 THEN '#39'Wormer'#39
      #9'WHEN 3 THEN '#39'Preventative'#39' END) as TreatmentTypeStr'
      'FROM'
      #9'Pet_Treatment PT (NOLOCK)'
      'WHERE'
      #9'PT.Desativado = 0'
      #9'AND PT.Hidden = 0')
    Left = 43
    Top = 188
  end
  object ctLuPet: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspLuPet
    KeyFieldName = 'IDPet'
    ListFieldNames.Strings = (
      'SKU')
    RecordTypes = [rtEnabled]
    Left = 159
    Top = 298
  end
  object dspLuPet: TDataSetProvider
    DataSet = qryLuPet
    Left = 159
    Top = 243
  end
  object qryLuPet: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPet,'
      #9'P.SKU,'
      #9'P.IDStatus,'
      #9'P.SalePrice,'
      #9'P.IDSpecies,'
      #9'P.PromoPrice,'
      #9'P.VendorCost,'
      #9'P.IDModel,'
      #9'P.IDStore'
      'FROM'
      #9'Pet P (NOLOCK)'
      'WHERE'
      #9'P.Desativado = 0'
      #9'AND P.Hidden = 0')
    Left = 159
    Top = 188
  end
  object ctLuPetMedicalCondition: TmrConfigLookupSvr
    CommandButtons = [cbClear]
    DataSetProvider = dspLuPetMedicalCondition
    KeyFieldName = 'IDMedicalCondition'
    ListFieldNames.Strings = (
      'MedicalCondition')
    RecordTypes = [rtEnabled]
    Left = 263
    Top = 298
  end
  object dspLuPetMedicalCondition: TDataSetProvider
    DataSet = quLuPetMedicalCondition
    Left = 263
    Top = 243
  end
  object quLuPetMedicalCondition: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDMedicalCondition,'
      
        #9'(MedicalCondition + '#39' - '#39' + SubMedicalCondition) as MedicalCond' +
        'ition'
      'FROM'
      #9'Pet_MedicalCondition (NOLOCK)'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      '')
    Left = 263
    Top = 188
  end
  object ctLuPetColor: TmrConfigLookupSvr
    CommandButtons = [cbNew, cbOpen, cbClear]
    DataSetProvider = dspLuPetColor
    KeyFieldName = 'IDColor'
    ListFieldNames.Strings = (
      'Color')
    RecordTypes = [rtEnabled]
    Left = 375
    Top = 294
  end
  object dspLuPetColor: TDataSetProvider
    DataSet = qryLuPetColor
    Left = 375
    Top = 239
  end
  object qryLuPetColor: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDColor,'
      #9'Color,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pet_Color (NOLOCK)'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0')
    Left = 375
    Top = 184
  end
end
