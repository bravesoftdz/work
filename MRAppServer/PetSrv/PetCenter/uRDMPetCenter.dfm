object RDMPetCenter: TRDMPetCenter
  OldCreateOrder = False
  Left = 185
  Top = 95
  Height = 645
  Width = 839
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=ApresentacaoDB;Data Source=.'
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 16
  end
  object qryMicrochip: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDMicrochip,'
      #9'IDModel,'
      #9'Microchip,'
      #9'Amount,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pet_Microchip'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0')
    Left = 44
    Top = 128
    object qryMicrochipIDMicrochip: TIntegerField
      FieldName = 'IDMicrochip'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryMicrochipIDModel: TIntegerField
      FieldName = 'IDModel'
      Visible = False
    end
    object qryMicrochipMicrochip: TStringField
      FieldName = 'Microchip'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qryMicrochipAmount: TBCDField
      FieldName = 'Amount'
      ProviderFlags = [pfInUpdate]
      Required = True
      Precision = 19
    end
    object qryMicrochipSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryMicrochipHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryMicrochipDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspMicrochip: TDataSetProvider
    DataSet = qryMicrochip
    Options = [poIncFieldProps]
    Left = 44
    Top = 180
  end
  object ctMicrochip: TmrConfigTable
    DataSetProvider = dspMicrochip
    IdentityField = 'IDMicrochip'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet_Microchip'
    HiddenFields.Strings = (
      'IDMicrochip')
    OnBeforeUpdateRecords = ctMicrochipBeforeUpdateRecords
    Left = 44
    Top = 80
  end
  object qryTreatment: TADOQuery
    CursorType = ctStatic
    OnCalcFields = qryTreatmentCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDTreatment,'
      #9'Treatment,'
      #9'TreatmentType,'
      #9'Mfg,'
      #9'TreatmentLotSize,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pet_Treatment'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0')
    Left = 128
    Top = 128
    object qryTreatmentIDTreatment: TIntegerField
      FieldName = 'IDTreatment'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryTreatmentTreatment: TStringField
      FieldName = 'Treatment'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qryTreatmentTreatmentTypeStr: TStringField
      DisplayLabel = 'Treatment Type'
      FieldKind = fkCalculated
      FieldName = 'TreatmentTypeStr'
      ProviderFlags = [pfInUpdate]
      Calculated = True
    end
    object qryTreatmentTreatmentType: TIntegerField
      FieldName = 'TreatmentType'
      ProviderFlags = [pfInUpdate]
      Required = True
      Visible = False
    end
    object qryTreatmentMfg: TStringField
      DisplayLabel = 'Manufacturer'
      FieldName = 'Mfg'
      Size = 50
    end
    object qryTreatmentTreatmentLotSize: TIntegerField
      DisplayLabel = 'Lot Size'
      FieldName = 'TreatmentLotSize'
    end
    object qryTreatmentSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryTreatmentHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryTreatmentDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspTreatment: TDataSetProvider
    DataSet = qryTreatment
    Options = [poIncFieldProps]
    Left = 128
    Top = 180
  end
  object ctTreatment: TmrConfigTable
    AutoGenerateIdentity = True
    DataSetProvider = dspTreatment
    DependentTables.Strings = (
      'Pet_TreatmentSpecies'
      'Pet_TreatmentLot')
    IdentityField = 'IDTreatment'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet_Treatment'
    HiddenFields.Strings = (
      'IDTreatment')
    Left = 128
    Top = 80
  end
  object qryMedicalCondition: TADOQuery
    CursorType = ctStatic
    OnCalcFields = qryTreatmentCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDMedicalCondition,'
      #9'MedicalCondition,'
      #9'SubMedicalCondition,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pet_MedicalCondition'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0')
    Left = 228
    Top = 128
    object qryMedicalConditionIDMedicalCondition: TIntegerField
      FieldName = 'IDMedicalCondition'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryMedicalConditionMedicalCondition: TStringField
      DisplayLabel = 'Medical Condition'
      FieldName = 'MedicalCondition'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qryMedicalConditionSubMedicalCondition: TStringField
      DisplayLabel = 'Sub Medical Condition'
      FieldName = 'SubMedicalCondition'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 255
    end
    object qryMedicalConditionSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryMedicalConditionHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryMedicalConditionDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspMedicalCondition: TDataSetProvider
    DataSet = qryMedicalCondition
    Options = [poIncFieldProps]
    Left = 228
    Top = 180
  end
  object ctMedicalCondition: TmrConfigTable
    AutoGenerateIdentity = True
    DataSetProvider = dspMedicalCondition
    DependentTables.Strings = (
      'Pet_MedicalConditionSpecies'
      'Pet_PetMedicalCondition')
    IdentityField = 'IDMedicalCondition'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet_MedicalCondition'
    HiddenFields.Strings = (
      'IDMedicalCondition')
    Left = 228
    Top = 82
  end
  object qryBreed: TADOQuery
    CursorType = ctStatic
    OnCalcFields = qryTreatmentCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDBreed,'
      #9'Breed,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pet_Breed'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0')
    Left = 318
    Top = 127
    object qryBreedIDBreed: TIntegerField
      FieldName = 'IDBreed'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryBreedBreed: TStringField
      FieldName = 'Breed'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 28
    end
    object qryBreedSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryBreedHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryBreedDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspBreed: TDataSetProvider
    DataSet = qryBreed
    Options = [poIncFieldProps]
    Left = 318
    Top = 179
  end
  object ctBreed: TmrConfigTable
    DataSetProvider = dspBreed
    IdentityField = 'IDBreed'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet_Breed'
    HiddenFields.Strings = (
      'IDBreed')
    Left = 318
    Top = 81
  end
  object qryRegistry: TADOQuery
    CursorType = ctStatic
    OnCalcFields = qryTreatmentCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDRegistry,'
      #9'Registry,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pet_Registry'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      #9'AND System = 0')
    Left = 396
    Top = 129
    object qryRegistryIDRegistry: TIntegerField
      FieldName = 'IDRegistry'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryRegistryRegistry: TStringField
      FieldName = 'Registry'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qryRegistrySystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryRegistryHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryRegistryDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspRegistry: TDataSetProvider
    DataSet = qryRegistry
    Options = [poIncFieldProps]
    Left = 398
    Top = 179
  end
  object ctRegistry: TmrConfigTable
    AutoGenerateIdentity = True
    DataSetProvider = dspRegistry
    DependentTables.Strings = (
      'Pet_RegistrySpecies')
    IdentityField = 'IDRegistry'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet_Registry'
    HiddenFields.Strings = (
      'IDRegistry')
    Left = 398
    Top = 81
  end
  object qryPetStatus: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDStatus,'
      #9'StatusCode,'
      #9'Status,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pet_Status'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0'
      '')
    Left = 472
    Top = 133
    object qryPetStatusIDStatus: TIntegerField
      FieldName = 'IDStatus'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPetStatusStatusCode: TStringField
      FieldName = 'StatusCode'
      ProviderFlags = [pfInUpdate]
      Size = 5
    end
    object qryPetStatusStatus: TStringField
      FieldName = 'Status'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object qryPetStatusSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPetStatusHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPetStatusDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspPetStatus: TDataSetProvider
    DataSet = qryPetStatus
    Options = [poIncFieldProps]
    Left = 471
    Top = 183
  end
  object ctPetStatus: TmrConfigTable
    DataSetProvider = dspPetStatus
    IdentityField = 'IDStatus'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet_Status'
    HiddenFields.Strings = (
      'IDStatus')
    Left = 474
    Top = 85
  end
  object qryPet: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPet,'
      #9'P.IDSpecies,'
      #9'P.IDPorte,'
      #9'P.IDBreed,'
      #9'P.IDStatus,'
      #9'P.IDBreeder,'
      #9'P.IDModel,'
      #9'P.IDColor,'
      #9'P.IDStore,'
      #9'P.Name,'
      #9'P.Sex,'
      #9'P.SKU,'
      #9'P.PenNum,'
      #9'P.VendorCost,'
      #9'P.MSRP,'
      #9'P.SalePrice,'
      #9'P.PromoPrice,'
      #9'P.USDA,'
      #9'P.Collar,'
      #9'P.Sire,'
      #9'P.Dam,'
      #9'P.WhelpDate,'
      #9'P.PurchaseDate,'
      #9'P.Notes,'
      #9'P.System,'
      #9'P.Hidden,'
      #9'P.Desativado,'
      #9'PC.Color,'
      #9'PS.Species,'
      #9'PT.Porte,'
      #9'PB.Breed,'
      #9'PA.StatusCode,'
      #9'PA.Status,'
      #9'B.Pessoa,'
      #9'B.Telefone,'
      #9'S.Name as Store'
      'FROM'
      #9'Pet P (NOLOCK)'
      
        #9'LEFT JOIN Pet_Species PS (NOLOCK) ON (PS.IDSpecies = P.IDSpecie' +
        's)'
      #9'LEFT JOIN Pet_Porte PT (NOLOCK) ON (PT.IDPorte = P.IDPorte)'
      #9'LEFT JOIN Pet_Breed PB (NOLOCK) ON (PB.IDBreed = P.IDBreed)'
      #9'LEFT JOIN Pet_Status PA (NOLOCK) ON (PA.IDStatus = P.IDStatus)'
      #9'LEFT JOIN Pessoa B (NOLOCK) ON (B.IDPessoa = P.IDBreeder)'
      #9'LEFT JOIN Pet_Color PC (NOLOCK) ON (P.IDColor = PC.IDColor)'
      #9'LEFT JOIN Store S (NOLOCK) ON (S.IDStore = P.IDStore)'
      'WHERE'
      #9'P.Desativado = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.System = 0')
    Left = 544
    Top = 133
    object qryPetIDPet: TIntegerField
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPetIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetIDPorte: TIntegerField
      DisplayLabel = 'IDPort'
      FieldName = 'IDPorte'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetIDBreed: TIntegerField
      FieldName = 'IDBreed'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetIDStatus: TIntegerField
      FieldName = 'IDStatus'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetIDBreeder: TIntegerField
      FieldName = 'IDBreeder'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetIDModel: TIntegerField
      FieldName = 'IDModel'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPetIDColor: TIntegerField
      FieldName = 'IDColor'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetIDStore: TIntegerField
      FieldName = 'IDStore'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetName: TStringField
      DisplayLabel = 'Puppy Name'
      FieldName = 'Name'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object qryPetSex: TStringField
      FieldName = 'Sex'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 1
    end
    object qryPetSKU: TStringField
      FieldName = 'SKU'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 30
    end
    object qryPetPenNum: TStringField
      DisplayLabel = 'Pen Num'
      FieldName = 'PenNum'
      ProviderFlags = [pfInUpdate]
      Size = 10
    end
    object qryPetVendorCost: TBCDField
      FieldName = 'VendorCost'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
    object qryPetMSRP: TBCDField
      FieldName = 'MSRP'
      ProviderFlags = [pfInUpdate]
      Visible = False
      Precision = 19
    end
    object qryPetSalePrice: TBCDField
      DisplayLabel = 'Sale Price'
      FieldName = 'SalePrice'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
    object qryPetPromoPrice: TBCDField
      DisplayLabel = 'Promo Price'
      FieldName = 'PromoPrice'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
    object qryPetColor2: TStringField
      FieldName = 'Color'
      ProviderFlags = []
      Size = 50
    end
    object qryPetUSDA: TStringField
      FieldName = 'USDA'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object qryPetCollar: TStringField
      FieldName = 'Collar'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object qryPetSire: TStringField
      FieldName = 'Sire'
      ProviderFlags = [pfInUpdate]
      Size = 255
    end
    object qryPetDam: TStringField
      FieldName = 'Dam'
      ProviderFlags = [pfInUpdate]
      Size = 255
    end
    object qryPetWhelpDate: TDateTimeField
      FieldName = 'WhelpDate'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetPurchaseDate: TDateTimeField
      FieldName = 'PurchaseDate'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetNotes: TStringField
      FieldName = 'Notes'
      ProviderFlags = [pfInUpdate]
      Size = 255
    end
    object qryPetSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPetHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPetDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPetSpecies: TStringField
      FieldName = 'Species'
      ProviderFlags = []
      Size = 50
    end
    object qryPetPorte: TStringField
      FieldName = 'Porte'
      ProviderFlags = []
      Size = 50
    end
    object qryPetBreed: TStringField
      FieldName = 'Breed'
      ProviderFlags = []
      Size = 50
    end
    object qryPetStatusCode: TStringField
      FieldName = 'StatusCode'
      ProviderFlags = []
      Size = 5
    end
    object qryPetStatus2: TStringField
      FieldName = 'Status'
      ProviderFlags = []
      Size = 30
    end
    object qryPetPessoa: TStringField
      DisplayLabel = 'Breeder'
      FieldName = 'Pessoa'
      ProviderFlags = []
      Size = 50
    end
    object qryPetTelefone: TStringField
      DisplayLabel = 'B. Phone'
      FieldName = 'Telefone'
      ProviderFlags = []
      Size = 40
    end
    object qryPetStore: TStringField
      FieldName = 'Store'
      ProviderFlags = []
      Size = 30
    end
  end
  object dspPet: TDataSetProvider
    DataSet = qryPet
    Options = [poIncFieldProps]
    Left = 543
    Top = 183
  end
  object ctPet: TmrConfigTable
    AutoGenerateIdentity = True
    DataSetProvider = dspPet
    DependentTables.Strings = (
      'Pet_PetRegistry'
      'Pet_PetMicrochip'
      'Pet_Weight'
      'Pet_PetMedicalCondition'
      'Pet_PetTreatment'
      'Pet_TreatmentLot')
    IdentityField = 'IDPet'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet'
    HiddenFields.Strings = (
      'IDPet'
      'IDSpecies'
      'IDPorte'
      'IDBreed'
      'IDStatus'
      'IDBreeder'
      'IDColor'
      'IDStore'
      'Name'
      'Color'
      'PenNum'
      'MSRP'
      'PromoPrice'
      'USDA'
      'Collar'
      'Sire'
      'Dam'
      'WhelpDate'
      'Notes'
      'Species'
      'Porte'
      'StatusCode'
      'Pessoa'
      'Telefone'
      'Store')
    OnBeforeGetRecords = ctPetBeforeGetRecords
    OnBeforeUpdateRecords = ctPetBeforeUpdateRecords
    Left = 546
    Top = 85
  end
  object qryPetRegistry: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PPR.IDRegistry,'
      #9'PPR.IDPet,'
      #9'PPR.RegistrationNum,'
      #9'PR.Registry,'
      #9'P.SKU'
      'FROM'
      #9'Pet_PetRegistry PPR'
      #9'JOIN Pet_Registry PR ON (PPR.IDRegistry = PR.IDRegistry)'
      #9'JOIN Pet P ON (PPR.IDPet = P.IDPet)')
    Left = 45
    Top = 301
    object qryPetRegistryIDRegistry: TIntegerField
      FieldName = 'IDRegistry'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPetRegistryIDPet: TIntegerField
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPetRegistryRegistrationNum: TStringField
      DisplayLabel = 'Registration Num'
      FieldName = 'RegistrationNum'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qryPetRegistryRegistry: TStringField
      FieldName = 'Registry'
      ProviderFlags = []
      Size = 50
    end
    object qryPetRegistrySKU: TStringField
      FieldName = 'SKU'
      ProviderFlags = []
      Size = 30
    end
  end
  object dspPetRegistry: TDataSetProvider
    DataSet = qryPetRegistry
    Options = [poIncFieldProps]
    Left = 41
    Top = 353
  end
  object ctPetRegistry: TmrConfigTable
    DataSetProvider = dspPetRegistry
    ForeignField = 'IDPet'
    TableName = 'Pet_PetRegistry'
    HiddenFields.Strings = (
      'IDRegistry'
      'IDPet'
      'SKU')
    Left = 46
    Top = 245
  end
  object qryPetMicrochip: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PM.IDMicrochip,'
      #9'PM.IDPet,'
      #9'PM.MicrochipNum,'
      #9'M.Microchip,'
      #9'M.Amount,'
      #9'CAST (1 AS Bit) as Marked,'
      #9'M.IDModel'
      'FROM'
      #9'Pet_PetMicrochip PM'
      #9'JOIN Pet_Microchip M ON (PM.IDMicrochip = M.IDMicrochip)'
      #9'JOIN Pet P ON (PM.IDPet = P.IDPet)')
    Left = 149
    Top = 293
    object qryPetMicrochipIDMicrochip: TIntegerField
      FieldName = 'IDMicrochip'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPetMicrochipIDPet: TIntegerField
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPetMicrochipMicrochip: TStringField
      FieldName = 'Microchip'
      ProviderFlags = []
      Size = 50
    end
    object qryPetMicrochipMicrochipNum: TStringField
      DisplayLabel = 'Microchip Num'
      FieldName = 'MicrochipNum'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetMicrochipAmount: TBCDField
      FieldName = 'Amount'
      ProviderFlags = [pfInUpdate]
      Precision = 19
    end
    object qryPetMicrochipMarked: TBooleanField
      FieldName = 'Marked'
      ProviderFlags = []
      Visible = False
    end
    object qryPetMicrochipIDModel: TIntegerField
      FieldName = 'IDModel'
      ProviderFlags = []
    end
  end
  object dspPetMicrochip: TDataSetProvider
    DataSet = qryPetMicrochip
    Options = [poIncFieldProps]
    Left = 149
    Top = 345
  end
  object ctPetMicrochip: TmrConfigTable
    DataSetProvider = dspPetMicrochip
    ForeignField = 'IDPet'
    TableName = 'Pet_PetMicrochip'
    HiddenFields.Strings = (
      'IDMicrochip'
      'IDPet'
      'IDModel'
      'Amount')
    OnBeforeUpdateRecords = ctPetMicrochipBeforeUpdateRecords
    Left = 150
    Top = 245
  end
  object qryPetWeight: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PW.IDWeight,'
      #9'PW.IDPet,'
      #9'PW.EntryDate,'
      #9'PW.Weight'
      'FROM'
      #9'Pet_Weight PW')
    Left = 245
    Top = 293
    object qryPetWeightIDWeight: TIntegerField
      FieldName = 'IDWeight'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPetWeightIDPet: TIntegerField
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetWeightEntryDate: TDateTimeField
      DisplayLabel = 'Entry Date'
      FieldName = 'EntryDate'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetWeightWeight: TBCDField
      FieldName = 'Weight'
      ProviderFlags = [pfInUpdate]
      Required = True
      DisplayFormat = '0.####'
      Precision = 32
    end
  end
  object dspPetWeight: TDataSetProvider
    DataSet = qryPetWeight
    Options = [poIncFieldProps]
    Left = 245
    Top = 345
  end
  object ctPetWeight: TmrConfigTable
    DataSetProvider = dspPetWeight
    ForeignField = 'IDPet'
    IdentityField = 'IDWeight'
    TableName = 'Pet_Weight'
    HiddenFields.Strings = (
      'IDWeight'
      'IDPet')
    Left = 246
    Top = 245
  end
  object qrySpecies: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDSpecies,'
      #9'Species,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pet_Species'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0')
    Left = 617
    Top = 133
    object qrySpeciesIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qrySpeciesSpecies: TStringField
      FieldName = 'Species'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qrySpeciesSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qrySpeciesHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qrySpeciesDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspSpecies: TDataSetProvider
    DataSet = qrySpecies
    Options = [poIncFieldProps]
    Left = 617
    Top = 181
  end
  object ctSpecies: TmrConfigTable
    DataSetProvider = dspSpecies
    DependentTables.Strings = (
      'Pet_MedicalConditionSpecies'
      'Pet_TreatmentSpecies'
      'Pet_RegistrySpecies')
    IdentityField = 'IDSpecies'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet_Species'
    HiddenFields.Strings = (
      'IDSpecies')
    Left = 618
    Top = 85
  end
  object qryMedicalConditionSpecies: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'MCS.IDMedicalCondition,'
      #9'MCS.IDSpecies,'
      #9'PS.Species'
      'FROM'
      #9'Pet_MedicalConditionSpecies MCS'
      
        #9'JOIN Pet_MedicalCondition MC ON (MC.IDMedicalCondition = MCS.ID' +
        'MedicalCondition)'
      #9'JOIN Pet_Species PS ON (PS.IDSpecies = MCS.IDSpecies)')
    Left = 349
    Top = 293
    object qryMedicalConditionSpeciesIDMedicalCondition: TIntegerField
      FieldName = 'IDMedicalCondition'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryMedicalConditionSpeciesIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryMedicalConditionSpeciesSpecies: TStringField
      FieldName = 'Species'
      ProviderFlags = []
      Size = 50
    end
  end
  object dspMedicalConditionSpecies: TDataSetProvider
    DataSet = qryMedicalConditionSpecies
    Options = [poIncFieldProps]
    Left = 353
    Top = 345
  end
  object ctMedicalConditionSpecies: TmrConfigTable
    DataSetProvider = dspMedicalConditionSpecies
    ForeignField = 'IDMedicalCondition'
    TableName = 'Pet_MedicalConditionSpecies'
    HiddenFields.Strings = (
      'IDMedicalCondition'
      'IDSpecies')
    Left = 350
    Top = 241
  end
  object qryTreatmentSpecies: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'TS.IDTreatment,'
      #9'TS.IDSpecies,'
      #9'PS.Species'
      'FROM'
      #9'Pet_TreatmentSpecies TS'
      #9'JOIN Pet_Treatment T ON (T.IDTreatment = TS.IDTreatment)'
      #9'JOIN Pet_Species PS ON (PS.IDSpecies = TS.IDSpecies)')
    Left = 477
    Top = 293
    object qryTreatmentSpeciesIDTreatment: TIntegerField
      FieldName = 'IDTreatment'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryTreatmentSpeciesIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryTreatmentSpeciesSpecies: TStringField
      FieldName = 'Species'
      ProviderFlags = []
      Size = 50
    end
  end
  object dspTreatmentSpecies: TDataSetProvider
    DataSet = qryTreatmentSpecies
    Options = [poIncFieldProps]
    Left = 481
    Top = 345
  end
  object ctTreatmentSpecies: TmrConfigTable
    DataSetProvider = dspTreatmentSpecies
    ForeignField = 'IDTreatment'
    TableName = 'Pet_TreatmentSpecies'
    HiddenFields.Strings = (
      'IDTreatment'
      'IDSpecies')
    Left = 478
    Top = 241
  end
  object qryRegistrySpecies: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'RS.IDRegistry,'
      #9'RS.IDSpecies,'
      #9'S.Species'
      'FROM'
      #9'Pet_RegistrySpecies RS'
      #9'JOIN Pet_Registry R ON (R.IDRegistry = RS.IDRegistry)'
      #9'JOIN Pet_Species S ON (S.IDSpecies = RS.IDSpecies)')
    Left = 597
    Top = 293
    object qryRegistrySpeciesIDRegistry: TIntegerField
      FieldName = 'IDRegistry'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryRegistrySpeciesIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryRegistrySpeciesSpecies: TStringField
      FieldName = 'Species'
      ProviderFlags = []
      Size = 50
    end
  end
  object dspRegistrySpecies: TDataSetProvider
    DataSet = qryRegistrySpecies
    Options = [poIncFieldProps]
    Left = 601
    Top = 345
  end
  object ctRegistrySpecies: TmrConfigTable
    DataSetProvider = dspRegistrySpecies
    ForeignField = 'IDRegistry'
    TableName = 'Pet_RegistrySpecies'
    HiddenFields.Strings = (
      'IDRegistry'
      'IDSpecies')
    Left = 598
    Top = 241
  end
  object qryTreatmentLot: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'TL.IDTreatmentLot,'
      #9'TL.IDTreatment,'
      #9'TL.LotNumber,'
      #9'TL.ExpirationDate,'
      #9'T.Treatment,'
      #9'TL.System,'
      #9'TL.Hidden,'
      #9'TL.Desativado'
      'FROM'
      #9'Pet_TreatmentLot TL'
      #9'JOIN Pet_Treatment T ON (TL.IDTreatment = T.IDTreatment)'
      '')
    Left = 45
    Top = 461
    object qryTreatmentLotIDTreatmentLot: TIntegerField
      FieldName = 'IDTreatmentLot'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryTreatmentLotIDTreatment: TIntegerField
      FieldName = 'IDTreatment'
      ProviderFlags = [pfInUpdate]
    end
    object qryTreatmentLotLotNumber: TStringField
      DisplayLabel = 'Lot Number'
      FieldName = 'LotNumber'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 30
    end
    object qryTreatmentLotExpirationDate: TDateTimeField
      DisplayLabel = 'Expiration Date'
      FieldName = 'ExpirationDate'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryTreatmentLotTreatment: TStringField
      FieldName = 'Treatment'
      ProviderFlags = []
      Size = 50
    end
    object qryTreatmentLotSystem: TBooleanField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryTreatmentLotHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryTreatmentLotDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspTreatmentLot: TDataSetProvider
    DataSet = qryTreatmentLot
    Options = [poIncFieldProps]
    Left = 45
    Top = 513
  end
  object ctTreatmentLot: TmrConfigTable
    DataSetProvider = dspTreatmentLot
    ForeignField = 'IDTreatment'
    IdentityField = 'IDTreatmentLot'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet_TreatmentLot'
    HiddenFields.Strings = (
      'IDTreatmentLot'
      'IDTreatment'
      'Treatment')
    Left = 46
    Top = 409
  end
  object qryPetTreatment: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PT.IDPetTreatment,'
      #9'PT.IDTreatment,'
      #9'PT.IDTreatmentLot,'
      #9'PT.IDPet,'
      #9'PT.IDUser,'
      #9'PT.ExpirationDate,'
      #9'PT.DosesUsed,'
      #9'PT.TreatmentDate,'
      #9'PT.Notes,'
      #9'T.Treatment,'
      #9'P.SKU,'
      #9'SU.SystemUser,'
      #9'TL.LotNumber'
      'FROM'
      #9'Pet_PetTreatment PT'
      #9'JOIN Pet_Treatment T ON (PT.IDTreatment = T.IDTreatment)'
      #9'JOIN Pet P ON (P.IDPet = PT.IDPet)'
      #9'JOIN SystemUser SU ON (SU.IDUser = PT.IDUser)'
      
        #9'LEFT JOIN Pet_TreatmentLot TL ON (TL.IDTreatmentLot = PT.IDTrea' +
        'tmentLot)')
    Left = 149
    Top = 461
    object qryPetTreatmentIDPetTreatment: TIntegerField
      FieldName = 'IDPetTreatment'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPetTreatmentIDTreatment: TIntegerField
      DisplayLabel = 'Treatment'
      FieldName = 'IDTreatment'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetTreatmentIDTreatmentLot: TIntegerField
      DisplayLabel = 'Treatment Lot'
      FieldName = 'IDTreatmentLot'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetTreatmentIDPet: TIntegerField
      DisplayLabel = 'Pet'
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetTreatmentIDUser: TIntegerField
      DisplayLabel = 'User'
      FieldName = 'IDUser'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetTreatmentTreatment: TStringField
      FieldName = 'Treatment'
      ProviderFlags = []
      Size = 50
    end
    object qryPetTreatmentLotNumber: TStringField
      FieldName = 'LotNumber'
      ProviderFlags = []
      Size = 30
    end
    object qryPetTreatmentTreatmentDate: TDateTimeField
      DisplayLabel = 'Trt. Date'
      FieldName = 'TreatmentDate'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetTreatmentDosesUsed: TIntegerField
      DisplayLabel = 'Doses Used'
      FieldName = 'DosesUsed'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetTreatmentSystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      ProviderFlags = []
      Size = 50
    end
    object qryPetTreatmentExpirationDate: TDateTimeField
      DisplayLabel = 'Exp Date'
      FieldName = 'ExpirationDate'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetTreatmentSKU: TStringField
      FieldName = 'SKU'
      ProviderFlags = []
      Size = 30
    end
    object qryPetTreatmentNotes: TStringField
      FieldName = 'Notes'
      ProviderFlags = [pfInUpdate]
      Size = 255
    end
  end
  object dspPetTreatment: TDataSetProvider
    DataSet = qryPetTreatment
    Options = [poIncFieldProps]
    Left = 149
    Top = 513
  end
  object ctPetTreatment: TmrConfigTable
    DataSetProvider = dspPetTreatment
    ForeignField = 'IDPet'
    IdentityField = 'IDPetTreatment'
    TableName = 'Pet_PetTreatment'
    HiddenFields.Strings = (
      'IDPetTreatment'
      'IDTreatment'
      'IDTreatmentLot'
      'IDPet'
      'IDUser'
      'SKU'
      'Amount')
    Left = 150
    Top = 409
  end
  object qryPetMedicalCondition: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PMC.IDPetMedicalCondition,'
      #9'PMC.IDMedicalCondition,'
      #9'PMC.IDPet,'
      #9'PMC.IDUser,'
      #9'PMC.RecordDate,'
      #9'PMC.Notes,'
      #9'P.SKU,'
      #9'SU.SystemUser,'
      #9'MC.MedicalCondition,'
      #9'MC.SubMedicalCondition'
      'FROM'
      #9'Pet_PetMedicalCondition PMC'
      #9'JOIN Pet P ON (P.IDPet = PMC.IDPet)'
      #9'JOIN SystemUser SU ON (SU.IDUser = PMC.IDUser)'
      
        #9'JOIN Pet_MedicalCondition MC ON (MC.IDMedicalCondition = PMC.ID' +
        'MedicalCondition)')
    Left = 249
    Top = 461
    object qryPetMedicalConditionIDPetMedicalCondition: TIntegerField
      FieldName = 'IDPetMedicalCondition'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPetMedicalConditionIDMedicalCondition: TIntegerField
      FieldName = 'IDMedicalCondition'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetMedicalConditionIDPet: TIntegerField
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetMedicalConditionIDUser: TIntegerField
      FieldName = 'IDUser'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetMedicalConditionMedicalCondition: TStringField
      DisplayLabel = 'Medical Condition'
      FieldName = 'MedicalCondition'
      ProviderFlags = []
      Size = 50
    end
    object qryPetMedicalConditionSubMedicalCondition: TStringField
      DisplayLabel = 'Sub M. Condition'
      FieldName = 'SubMedicalCondition'
      ProviderFlags = []
      Size = 255
    end
    object qryPetMedicalConditionRecordDate: TDateTimeField
      DisplayLabel = 'Record Date'
      FieldName = 'RecordDate'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qryPetMedicalConditionNotes: TStringField
      FieldName = 'Notes'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object qryPetMedicalConditionSKU: TStringField
      FieldName = 'SKU'
      ProviderFlags = []
      Size = 30
    end
    object qryPetMedicalConditionSystemUser: TStringField
      DisplayLabel = 'User'
      FieldName = 'SystemUser'
      ProviderFlags = []
      Size = 50
    end
  end
  object dspPetMedicalCondition: TDataSetProvider
    DataSet = qryPetMedicalCondition
    Options = [poIncFieldProps]
    Left = 249
    Top = 513
  end
  object ctPetMedicalCondition: TmrConfigTable
    DataSetProvider = dspPetMedicalCondition
    ForeignField = 'IDPet'
    IdentityField = 'IDPetMedicalCondition'
    TableName = 'Pet_PetMedicalCondition'
    HiddenFields.Strings = (
      'IDPetMedicalCondition'
      'IDMedicalCondition'
      'IDPet'
      'IDUser'
      'SKU')
    Left = 250
    Top = 409
  end
  object qryWarrantyRep: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT TOP 1'
      #9'IDWarrantyReport,'
      #9'IDSpecies,'
      #9'Report,'
      #9'ReportName,'
      #9'ReportDate'#9#9#9
      'FROM'
      #9'Pet_WarrantyReport'
      'ORDER BY'
      #9'IDWarrantyReport DESC')
    Left = 360
    Top = 461
    object qryWarrantyRepIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryWarrantyRepIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
      ProviderFlags = [pfInUpdate]
    end
    object qryWarrantyRepReport: TBlobField
      FieldName = 'Report'
      ProviderFlags = [pfInUpdate]
    end
    object qryWarrantyRepReportDate: TDateTimeField
      FieldName = 'ReportDate'
      ProviderFlags = [pfInUpdate]
    end
    object qryWarrantyRepReportName: TStringField
      FieldName = 'ReportName'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
  end
  object dspWarrantyRep: TDataSetProvider
    DataSet = qryWarrantyRep
    Options = [poIncFieldProps]
    Left = 359
    Top = 511
  end
  object ctWarrantyRep: TmrConfigTable
    DataSetProvider = dspWarrantyRep
    IdentityField = 'IDWarrantyReport'
    TableName = 'Pet_WarrantyReport'
    OnBeforeUpdateRecords = ctWarrantyRepBeforeUpdateRecords
    Left = 358
    Top = 413
  end
  object qryPetColor: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDColor,'
      #9'Color,'
      #9'System,'
      #9'Hidden,'
      #9'Desativado'
      'FROM'
      #9'Pet_Color'
      'WHERE'
      #9'Desativado = 0'
      #9'AND Hidden = 0')
    Left = 691
    Top = 132
    object qryPetColorIDColor: TIntegerField
      FieldName = 'IDColor'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPetColorColor: TStringField
      FieldName = 'Color'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object qryPetColorSystem: TIntegerField
      FieldName = 'System'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPetColorHidden: TBooleanField
      FieldName = 'Hidden'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
    object qryPetColorDesativado: TBooleanField
      FieldName = 'Desativado'
      ProviderFlags = [pfInUpdate]
      Visible = False
    end
  end
  object dspPetColor: TDataSetProvider
    DataSet = qryPetColor
    Options = [poIncFieldProps]
    Left = 691
    Top = 180
  end
  object ctPetColor: TmrConfigTable
    AutoGenerateIdentity = True
    DataSetProvider = dspPetColor
    DependentTables.Strings = (
      'Pet_ColorSpecies')
    IdentityField = 'IDColor'
    LogicalDeleteField = 'Desativado'
    TableName = 'Pet_Color'
    HiddenFields.Strings = (
      'IDColor')
    Left = 692
    Top = 84
  end
  object qryColorSpecies: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PC.IDColor,'
      #9'PC.IDSpecies,'
      #9'S.Species'
      'FROM'
      #9'Pet_ColorSpecies PC'
      #9'JOIN Pet_Color C ON (PC.IDColor = C.IDColor)'
      #9'JOIN Pet_Species S ON (S.IDSpecies = PC.IDSpecies)')
    Left = 697
    Top = 294
    object qryColorSpeciesIDColor: TIntegerField
      FieldName = 'IDColor'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryColorSpeciesIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryColorSpeciesSpecies: TStringField
      FieldName = 'Species'
      ProviderFlags = []
      Size = 50
    end
  end
  object dspColorSpecies: TDataSetProvider
    DataSet = qryColorSpecies
    Options = [poIncFieldProps]
    Left = 697
    Top = 346
  end
  object ctColorSpecies: TmrConfigTable
    DataSetProvider = dspColorSpecies
    ForeignField = 'IDColor'
    TableName = 'Pet_ColorSpecies'
    HiddenFields.Strings = (
      'IDColor'
      'IDSpecies')
    Left = 694
    Top = 245
  end
  object qryPetTransfer: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'T.IDPetTransfer,'
      #9'T.IDPet,'
      #9'T.IDStoreSource,'
      #9'T.IDStoreDest,'
      #9'T.IDUser,'
      #9'T.TransferDate,'
      #9'P.SKU,'
      #9'SS.Name as StoreSource,'
      #9'SD.Name as StoreDest,'
      #9'SU.SystemUser,'
      #9'PC.Color,'
      #9'PS.Species,'
      #9'PT.Porte,'
      #9'PB.Breed,'
      #9'PA.StatusCode,'
      #9'PA.Status'
      'FROM'
      #9'Pet_Transfer T (NOLOCK)'
      #9'JOIN Pet P (NOLOCK) ON (P.IDPet = T.IDPet)'
      #9'JOIN SystemUser SU (NOLOCK) ON (SU.IDUser = T.IDUser)'
      #9'LEFT JOIN Store SS (NOLOCK) ON (T.IDStoreSource = SS.IDStore)'
      #9'LEFT JOIN Store SD (NOLOCK) ON (T.IDStoreDest = SD.IDStore)'
      
        #9'LEFT JOIN Pet_Species PS (NOLOCK) ON (PS.IDSpecies = P.IDSpecie' +
        's)'
      #9'LEFT JOIN Pet_Porte PT (NOLOCK) ON (PT.IDPorte = P.IDPorte)'
      #9'LEFT JOIN Pet_Breed PB (NOLOCK) ON (PB.IDBreed = P.IDBreed)'
      #9'LEFT JOIN Pet_Status PA (NOLOCK) ON (PA.IDStatus = P.IDStatus)'
      #9'LEFT JOIN Pet_Color PC (NOLOCK) ON (P.IDColor = PC.IDColor)')
    Left = 479
    Top = 461
    object qryPetTransferIDPetTransfer: TIntegerField
      FieldName = 'IDPetTransfer'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryPetTransferIDPet: TIntegerField
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetTransferIDStoreSource: TIntegerField
      FieldName = 'IDStoreSource'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetTransferIDStoreDest: TIntegerField
      FieldName = 'IDStoreDest'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetTransferIDUser: TIntegerField
      FieldName = 'IDUser'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetTransferTransferDate: TDateTimeField
      FieldName = 'TransferDate'
      ProviderFlags = [pfInUpdate]
    end
    object qryPetTransferSKU: TStringField
      FieldName = 'SKU'
      ProviderFlags = []
      Size = 30
    end
    object qryPetTransferStoreSource: TStringField
      FieldName = 'StoreSource'
      ProviderFlags = []
      Size = 30
    end
    object qryPetTransferStoreDest: TStringField
      FieldName = 'StoreDest'
      ProviderFlags = []
      Size = 30
    end
    object qryPetTransferSystemUser: TStringField
      FieldName = 'SystemUser'
      ProviderFlags = []
      Size = 50
    end
    object qryPetTransferColor: TStringField
      FieldName = 'Color'
      ProviderFlags = []
      Size = 50
    end
    object qryPetTransferSpecies: TStringField
      FieldName = 'Species'
      ProviderFlags = []
      Size = 50
    end
    object qryPetTransferPorte: TStringField
      FieldName = 'Porte'
      ProviderFlags = []
      Size = 50
    end
    object qryPetTransferBreed: TStringField
      FieldName = 'Breed'
      ProviderFlags = []
      Size = 50
    end
    object qryPetTransferStatusCode: TStringField
      FieldName = 'StatusCode'
      ProviderFlags = []
      Size = 5
    end
    object qryPetTransferStatus: TStringField
      FieldName = 'Status'
      ProviderFlags = []
      Size = 30
    end
  end
  object dspPetTransfer: TDataSetProvider
    DataSet = qryPetTransfer
    Options = [poIncFieldProps]
    Left = 479
    Top = 513
  end
  object ctPetTransfer: TmrConfigTable
    DataSetProvider = dspPetTransfer
    ForeignField = 'IDPet'
    IdentityField = 'IDPetTransfer'
    TableName = 'Pet_Transfer'
    TableNamePrefix = 'T'
    HiddenFields.Strings = (
      'IDPet'
      'IDStoreSource'
      'IDStoreDest'
      'IDUser')
    OnBeforeGetRecords = ctPetTransferBeforeGetRecords
    OnBeforeUpdateRecords = ctPetTransferBeforeUpdateRecords
    Left = 480
    Top = 409
  end
end
