object RDMReport: TRDMReport
  OldCreateOrder = False
  Left = 194
  Top = 207
  Height = 428
  Width = 596
  object qryPet: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT TOP 1'
      #9'P.IDPet,'
      #9'P.IDSpecies,'
      #9'P.IDPorte,'
      #9'P.IDBreed,'
      #9'P.IDStatus,'
      #9'P.IDBreeder,'
      #9'P.IDModel,'
      #9'P.IDStore,'
      #9'P.Name,'
      #9'P.Sex,'
      #9'PC.Color,'
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
      #9'PS.Species,'
      #9'PB.Breed,'
      #9'PA.StatusCode,'
      #9'PA.Status,'
      #9'B.Pessoa as Breeder,'
      #9'B.Endereco as BreederAddress,'
      #9'B.Cidade as BreederCity,'
      #9'B.IDEstado as BreederStateID,'
      #9'B.CEP as BreederZip,'
      #9'PPS.IDWarrantyReport,'
      #9'WC.Pessoa as WarrantyCustomerName,'
      #9'WC.PessoaFirstName as WCustomerFirstName,'
      #9'WC.PessoaLastName as WCustomerLastName,'
      #9'WC.Endereco as WCustomerAddress,'
      #9'WC.Cidade as WCustomerCity,'
      #9'WC.IDEstado as WCustomerStateID,'
      #9'WC.CEP as WCustomerZip,'
      #9'WC.Telefone as WCustomerPhone,'
      #9'WC.Email as WCustomerEmail,'
      #9'IM.MovDate as PetSaleDate,'
      #9'CAST((IM.Qty * IM.CostPrice) as Money) as PetSaleCost,'
      #9'CAST((IM.Qty * IM.SalePrice) as Money) as PetSaleSold,'
      #9'CAST((IM.Qty * IM.Discount)  as Money) as PetSaleDiscount,'
      #9'WC.Pessoa as SaleCustomerName,'
      #9'WC.PhoneAreaCode as WSalePhoneAreaCode,'
      #9'S.Name as StoreName,'
      #9'S.IDEstado as StoreState,'
      #9'S.Address as StoreAddress,'
      #9'S.City as StoreCity,'
      #9'S.Zip as StoreZip,'
      #9'S.Telephone as StorePhone,'
      #9'S.Fax as StoreFax,'
      #9'S.Email as StoreEmail,'
      #9'S.WebPage as StoreWebPage'
      'FROM'
      #9'Pet_PetSale PPS (NOLOCK)'
      #9'JOIN Pet P (NOLOCK) ON (PPS.IDPet = P.IDPet)'
      #9'JOIN Pet_Species PS (NOLOCK) ON (PS.IDSpecies = P.IDSpecies)'
      #9'JOIN Pet_Breed PB (NOLOCK) ON (PB.IDBreed = P.IDBreed)'
      #9'JOIN Pet_Status PA (NOLOCK) ON (PA.IDStatus = P.IDStatus)'
      #9'JOIN Pessoa B (NOLOCK) ON (B.IDPessoa = P.IDBreeder)'
      
        #9'JOIN Pessoa WC (NOLOCK) ON (WC.IDPessoa = PPS.IDWarrantyCustome' +
        'r)'
      
        #9'JOIN InventoryMov IM (NOLOCK) ON (PPS.IDPreInventoryMov = IM.Pr' +
        'eInventoryMovID)'
      #9'JOIN Pessoa C (NOLOCK) ON (C.IDPessoa = IM.IDPessoa)'
      #9'JOIN Store S (NOLOCK) ON (S.IDStore = P.IDStore)'
      #9'LEFT JOIN Pet_Color PC (NOLOCK) ON (P.IDColor = PC.IDColor)'
      'ORDER BY'
      #9'IM.MovDate DESC')
    Left = 40
    Top = 137
    object qryPetIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object qryPetIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object qryPetIDPorte: TIntegerField
      FieldName = 'IDPorte'
    end
    object qryPetIDBreed: TIntegerField
      FieldName = 'IDBreed'
    end
    object qryPetIDStatus: TIntegerField
      FieldName = 'IDStatus'
    end
    object qryPetIDBreeder: TIntegerField
      FieldName = 'IDBreeder'
    end
    object qryPetIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryPetName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object qryPetSex: TStringField
      FieldName = 'Sex'
      Size = 1
    end
    object qryPetColor: TStringField
      FieldName = 'Color'
      Size = 50
    end
    object qryPetSKU: TStringField
      FieldName = 'SKU'
      Size = 30
    end
    object qryPetPenNum: TStringField
      FieldName = 'PenNum'
      Size = 10
    end
    object qryPetVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object qryPetMSRP: TBCDField
      FieldName = 'MSRP'
      Precision = 19
    end
    object qryPetSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object qryPetPromoPrice: TBCDField
      FieldName = 'PromoPrice'
      Precision = 19
    end
    object qryPetUSDA: TStringField
      FieldName = 'USDA'
      Size = 50
    end
    object qryPetCollar: TStringField
      FieldName = 'Collar'
      Size = 50
    end
    object qryPetSire: TStringField
      FieldName = 'Sire'
      Size = 255
    end
    object qryPetDam: TStringField
      FieldName = 'Dam'
      Size = 255
    end
    object qryPetWhelpDate: TDateTimeField
      FieldName = 'WhelpDate'
    end
    object qryPetPurchaseDate: TDateTimeField
      FieldName = 'PurchaseDate'
    end
    object qryPetNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object qryPetSpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
    object qryPetBreed: TStringField
      FieldName = 'Breed'
      Size = 50
    end
    object qryPetStatusCode: TStringField
      FieldName = 'StatusCode'
      Size = 5
    end
    object qryPetStatus: TStringField
      FieldName = 'Status'
      Size = 30
    end
    object qryPetBreeder: TStringField
      FieldName = 'Breeder'
      Size = 50
    end
    object qryPetIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
    end
    object qryPetWarrantyCustomerName: TStringField
      FieldName = 'WarrantyCustomerName'
      Size = 50
    end
    object qryPetWCustomerFirstName: TStringField
      FieldName = 'WCustomerFirstName'
      Size = 30
    end
    object qryPetWCustomerLastName: TStringField
      FieldName = 'WCustomerLastName'
      Size = 30
    end
    object qryPetWCustomerAddress: TStringField
      FieldName = 'WCustomerAddress'
      Size = 80
    end
    object qryPetWCustomerCity: TStringField
      FieldName = 'WCustomerCity'
      Size = 40
    end
    object qryPetWCustomerStateID: TStringField
      FieldName = 'WCustomerStateID'
      FixedChar = True
      Size = 3
    end
    object qryPetWCustomerZip: TStringField
      FieldName = 'WCustomerZip'
      FixedChar = True
      Size = 12
    end
    object qryPetWCustomerPhone: TStringField
      FieldName = 'WCustomerPhone'
      Size = 40
    end
    object qryPetWCustomerEmail: TStringField
      FieldName = 'WCustomerEmail'
      Size = 50
    end
    object qryPetWSalePhoneAreaCode: TStringField
      FieldName = 'WSalePhoneAreaCode'
      Size = 5
    end
    object qryPetPetSaleDate: TDateTimeField
      FieldName = 'PetSaleDate'
    end
    object qryPetPetSaleCost: TBCDField
      FieldName = 'PetSaleCost'
      Precision = 19
    end
    object qryPetPetSaleSold: TBCDField
      FieldName = 'PetSaleSold'
      Precision = 19
    end
    object qryPetPetSaleDiscount: TBCDField
      FieldName = 'PetSaleDiscount'
      Precision = 19
    end
    object qryPetSaleCustomerName: TStringField
      FieldName = 'SaleCustomerName'
      Size = 50
    end
    object qryPetBreederAddress: TStringField
      FieldName = 'BreederAddress'
      Size = 80
    end
    object qryPetBreederCity: TStringField
      FieldName = 'BreederCity'
      Size = 40
    end
    object qryPetBreederStateID: TStringField
      FieldName = 'BreederStateID'
      FixedChar = True
      Size = 3
    end
    object qryPetBreederZip: TStringField
      FieldName = 'BreederZip'
      FixedChar = True
      Size = 12
    end
    object qryPetIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object qryPetStoreName: TStringField
      FieldName = 'StoreName'
      Size = 30
    end
    object qryPetStoreState: TStringField
      FieldName = 'StoreState'
      FixedChar = True
      Size = 3
    end
    object qryPetStoreAddress: TStringField
      FieldName = 'StoreAddress'
      Size = 80
    end
    object qryPetStoreCity: TStringField
      FieldName = 'StoreCity'
      Size = 40
    end
    object qryPetStoreZip: TStringField
      FieldName = 'StoreZip'
      FixedChar = True
      Size = 12
    end
    object qryPetStorePhone: TStringField
      FieldName = 'StorePhone'
      Size = 40
    end
    object qryPetStoreFax: TStringField
      FieldName = 'StoreFax'
      Size = 40
    end
    object qryPetStoreEmail: TStringField
      FieldName = 'StoreEmail'
      Size = 60
    end
    object qryPetStoreWebPage: TStringField
      FieldName = 'StoreWebPage'
      Size = 80
    end
  end
  object dspPet: TDataSetProvider
    DataSet = qryPet
    Options = [poIncFieldProps]
    Left = 39
    Top = 187
  end
  object ctPet: TmrConfigTable
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
    Left = 38
    Top = 89
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=MainRetailDB;Data Source=.'
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 16
  end
  object qryPetTreatment: TADOQuery
    CursorType = ctStatic
    OnCalcFields = qryPetTreatmentCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'T.TreatmentType,'
      #9'T.Treatment,'
      #9'T.Mfg,'
      #9'PT.TreatmentDate,'
      #9'TL.LotNumber'
      'FROM'
      #9'Pet_PetTreatment PT (NOLOCK)'
      
        #9'JOIN Pet_Treatment T (NOLOCK) ON (PT.IDTreatment = T.IDTreatmen' +
        't)'
      
        #9'LEFT JOIN Pet_TreatmentLot TL (NOLOCK) ON (TL.IDTreatmentLot = ' +
        'PT.IDTreatmentLot)'
      'ORDER BY'
      #9'T.TreatmentType')
    Left = 148
    Top = 139
    object qryPetTreatmentTreatmentType: TIntegerField
      FieldName = 'TreatmentType'
    end
    object qryPetTreatmentTreatment: TStringField
      FieldName = 'Treatment'
      Size = 50
    end
    object qryPetTreatmentMfg: TStringField
      FieldName = 'Mfg'
      Size = 50
    end
    object qryPetTreatmentLotNumber: TStringField
      FieldName = 'LotNumber'
      Size = 30
    end
    object qryPetTreatmentTreatmentTypeStr: TStringField
      FieldKind = fkCalculated
      FieldName = 'TreatmentTypeStr'
      Size = 15
      Calculated = True
    end
    object qryPetTreatmentTreatmentDate: TDateTimeField
      FieldName = 'TreatmentDate'
    end
  end
  object dspPetTreatment: TDataSetProvider
    DataSet = qryPetTreatment
    Options = [poIncFieldProps]
    Left = 147
    Top = 187
  end
  object ctPetTreatment: TmrConfigTable
    DataSetProvider = dspPetTreatment
    DependentTables.Strings = (
      'Pet_PetRegistry'
      'Pet_PetMicrochip'
      'Pet_Weight'
      'Pet_PetMedicalCondition'
      'Pet_PetTreatment'
      'Pet_TreatmentLot')
    TableName = 'Pet_PetTreatment'
    Left = 146
    Top = 89
  end
  object dspPetMicrochip: TDataSetProvider
    DataSet = qryPetMicrochip
    Options = [poIncFieldProps]
    Left = 257
    Top = 189
  end
  object qryPetMicrochip: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PM.IDMicrochip,'
      #9'PM.MicrochipNum,'
      #9'PM.IDPetSale,'
      #9'PS.IDPet,'
      #9'M.Microchip'
      'FROM'
      #9'Pet_MicrochipSale PM (NOLOCK)'
      
        #9'JOIN Pet_Microchip M (NOLOCK) ON (PM.IDMicrochip = M.IDMicrochi' +
        'p)'
      #9'JOIN Pet_PetSale PS (NOLOCK) ON (PS.IDPetSale = PM.IDPetSale)')
    Left = 257
    Top = 137
    object qryPetMicrochipIDMicrochip: TIntegerField
      FieldName = 'IDMicrochip'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
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
    object qryPetMicrochipIDPetSale: TIntegerField
      FieldName = 'IDPetSale'
    end
  end
  object ctPetMicrochip: TmrConfigTable
    DataSetProvider = dspPetMicrochip
    ForeignField = 'IDPet'
    TableName = 'Pet_PetMicrochip'
    HiddenFields.Strings = (
      'IDMicrochip'
      'IDPet')
    Left = 258
    Top = 89
  end
  object dspPetRegistry: TDataSetProvider
    DataSet = qryPetRegistry
    Options = [poIncFieldProps]
    Left = 357
    Top = 197
  end
  object qryPetRegistry: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PPR.IDRegistry,'
      #9'PPR.RegistrationNum,'
      #9'PPR.IDPetSale,'
      #9'PR.Registry,'
      #9'P.IDPet,'
      #9'P.SKU'
      'FROM'
      #9'Pet_RegistrySale PPR (NOLOCK)'
      
        #9'JOIN Pet_Registry PR (NOLOCK) ON (PPR.IDRegistry = PR.IDRegistr' +
        'y)'
      #9'JOIN Pet_PetSale PS (NOLOCK) ON (PS.IDPetSale = PPR.IDPetSale)'
      #9'JOIN Pet P (NOLOCK) ON (PS.IDPet = P.IDPet)')
    Left = 361
    Top = 145
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
    object qryPetRegistryIDPetSale: TIntegerField
      FieldName = 'IDPetSale'
    end
  end
  object ctPetRegistry: TmrConfigTable
    DataSetProvider = dspPetRegistry
    ForeignField = 'IDPet'
    TableName = 'Pet_PetRegistry'
    HiddenFields.Strings = (
      'IDRegistry'
      'IDPet'
      'SKU')
    Left = 362
    Top = 89
  end
  object qryEmptyPet: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT TOP 1'
      #9'P.IDPet,'
      #9'P.IDSpecies,'
      #9'P.IDPorte,'
      #9'P.IDBreed,'
      #9'P.IDStatus,'
      #9'P.IDBreeder,'
      #9'P.IDModel,'
      #9'P.IDStore,'
      #9'P.Name,'
      #9'P.Sex,'
      #9'PC.Color,'
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
      #9'PS.Species,'
      #9'PB.Breed,'
      #9'PA.StatusCode,'
      #9'PA.Status,'
      #9'B.Pessoa as Breeder,'
      #9'B.Endereco as BreederAddress,'
      #9'B.Cidade as BreederCity,'
      #9'B.IDEstado as BreederStateID,'
      #9'B.CEP as BreederZip,'
      #9'PWR.IDWarrantyReport,'
      #9'CAST('#39#39' as varchar(50)) as WarrantyCustomerName,'
      #9'CAST('#39#39' as varchar(30)) as WCustomerFirstName,'
      #9'CAST('#39#39' as varchar(30)) as WCustomerLastName,'
      #9'CAST('#39#39' as varchar(80)) as WCustomerAddress,'
      #9'CAST('#39#39' as varchar(40)) as WCustomerCity,'
      #9'CAST('#39#39' as varchar(3)) as WCustomerStateID,'
      #9'CAST('#39#39' as varchar(12)) as WCustomerZip,'
      #9'CAST('#39#39' as varchar(40)) as WCustomerPhone,'
      #9'CAST('#39#39' as varchar(50)) as WCustomerEmail,'
      #9'GetDate() as PetSaleDate,'
      #9'0.00 as PetSaleCost,'
      #9'0.00 as PetSaleSold,'
      #9'0.00 as PetSaleDiscount,'
      #9'CAST('#39#39' as varchar(50)) as SaleCustomerName,'
      #9'CAST('#39#39' as varchar(5)) as WSalePhoneAreaCode,'
      #9'S.Name as StoreName,'
      #9'S.IDEstado as StoreState,'
      #9'S.Address as StoreAddress,'
      #9'S.City as StoreCity,'
      #9'S.Zip as StoreZip,'
      #9'S.Telephone as StorePhone,'
      #9'S.Fax as StoreFax,'
      #9'S.Email as StoreEmail,'
      #9'S.WebPage as StoreWebPage'
      'FROM'
      #9'Pet P (NOLOCK)'
      #9'JOIN Pet_Species PS (NOLOCK) ON (PS.IDSpecies = P.IDSpecies)'
      
        #9'JOIN Pet_WarrantyReport PWR (NOLOCK) ON (PS.IDSpecies = PWR.IDS' +
        'pecies)'
      #9'JOIN Pet_Breed PB (NOLOCK) ON (PB.IDBreed = P.IDBreed)'
      #9'JOIN Pet_Status PA (NOLOCK) ON (PA.IDStatus = P.IDStatus)'
      #9'JOIN Pessoa B (NOLOCK) ON (B.IDPessoa = P.IDBreeder)'
      #9'JOIN Store S (NOLOCK) ON (S.IDStore = P.IDStore)'
      #9'LEFT JOIN Pet_Color PC (NOLOCK) ON (P.IDColor = PC.IDColor)'
      'ORDER BY'
      #9'PWR.IDWarrantyReport DESC'
      '')
    Left = 44
    Top = 293
    object qryEmptyPetIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object qryEmptyPetIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object qryEmptyPetIDPorte: TIntegerField
      FieldName = 'IDPorte'
    end
    object qryEmptyPetIDBreed: TIntegerField
      FieldName = 'IDBreed'
    end
    object qryEmptyPetIDStatus: TIntegerField
      FieldName = 'IDStatus'
    end
    object qryEmptyPetIDBreeder: TIntegerField
      FieldName = 'IDBreeder'
    end
    object qryEmptyPetIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryEmptyPetName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object qryEmptyPetSex: TStringField
      FieldName = 'Sex'
      Size = 1
    end
    object qryEmptyPetColor: TStringField
      FieldName = 'Color'
      Size = 50
    end
    object qryEmptyPetSKU: TStringField
      FieldName = 'SKU'
      Size = 30
    end
    object qryEmptyPetPenNum: TStringField
      FieldName = 'PenNum'
      Size = 10
    end
    object qryEmptyPetVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object qryEmptyPetMSRP: TBCDField
      FieldName = 'MSRP'
      Precision = 19
    end
    object qryEmptyPetSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object qryEmptyPetPromoPrice: TBCDField
      FieldName = 'PromoPrice'
      Precision = 19
    end
    object qryEmptyPetUSDA: TStringField
      FieldName = 'USDA'
      Size = 50
    end
    object qryEmptyPetCollar: TStringField
      FieldName = 'Collar'
      Size = 50
    end
    object qryEmptyPetSire: TStringField
      FieldName = 'Sire'
      Size = 255
    end
    object qryEmptyPetDam: TStringField
      FieldName = 'Dam'
      Size = 255
    end
    object qryEmptyPetWhelpDate: TDateTimeField
      FieldName = 'WhelpDate'
    end
    object qryEmptyPetPurchaseDate: TDateTimeField
      FieldName = 'PurchaseDate'
    end
    object qryEmptyPetNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object qryEmptyPetSpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
    object qryEmptyPetBreed: TStringField
      FieldName = 'Breed'
      Size = 50
    end
    object qryEmptyPetStatusCode: TStringField
      FieldName = 'StatusCode'
      Size = 5
    end
    object qryEmptyPetStatus: TStringField
      FieldName = 'Status'
      Size = 30
    end
    object qryEmptyPetBreeder: TStringField
      FieldName = 'Breeder'
      Size = 50
    end
    object qryEmptyPetBreederAddress: TStringField
      FieldName = 'BreederAddress'
      Size = 80
    end
    object qryEmptyPetBreederCity: TStringField
      FieldName = 'BreederCity'
      Size = 40
    end
    object qryEmptyPetBreederStateID: TStringField
      FieldName = 'BreederStateID'
      FixedChar = True
      Size = 3
    end
    object qryEmptyPetBreederZip: TStringField
      FieldName = 'BreederZip'
      FixedChar = True
      Size = 12
    end
    object qryEmptyPetIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
    end
    object qryEmptyPetWarrantyCustomerName: TStringField
      FieldName = 'WarrantyCustomerName'
      ReadOnly = True
      Size = 50
    end
    object qryEmptyPetWCustomerFirstName: TStringField
      FieldName = 'WCustomerFirstName'
      ReadOnly = True
      Size = 30
    end
    object qryEmptyPetWCustomerLastName: TStringField
      FieldName = 'WCustomerLastName'
      ReadOnly = True
      Size = 30
    end
    object qryEmptyPetWCustomerAddress: TStringField
      FieldName = 'WCustomerAddress'
      ReadOnly = True
      Size = 80
    end
    object qryEmptyPetWCustomerCity: TStringField
      FieldName = 'WCustomerCity'
      ReadOnly = True
      Size = 40
    end
    object qryEmptyPetWCustomerStateID: TStringField
      FieldName = 'WCustomerStateID'
      ReadOnly = True
      Size = 3
    end
    object qryEmptyPetWCustomerZip: TStringField
      FieldName = 'WCustomerZip'
      ReadOnly = True
      Size = 12
    end
    object qryEmptyPetWCustomerPhone: TStringField
      FieldName = 'WCustomerPhone'
      ReadOnly = True
      Size = 40
    end
    object qryEmptyPetWCustomerEmail: TStringField
      FieldName = 'WCustomerEmail'
      ReadOnly = True
      Size = 50
    end
    object qryEmptyPetPetSaleDate: TDateTimeField
      FieldName = 'PetSaleDate'
      ReadOnly = True
    end
    object qryEmptyPetPetSaleCost: TBCDField
      FieldName = 'PetSaleCost'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object qryEmptyPetPetSaleSold: TBCDField
      FieldName = 'PetSaleSold'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object qryEmptyPetPetSaleDiscount: TBCDField
      FieldName = 'PetSaleDiscount'
      ReadOnly = True
      Precision = 2
      Size = 2
    end
    object qryEmptyPetSaleCustomerName: TStringField
      FieldName = 'SaleCustomerName'
      ReadOnly = True
      Size = 50
    end
    object qryEmptyPetWSalePhoneAreaCode: TStringField
      FieldName = 'WSalePhoneAreaCode'
      ReadOnly = True
      Size = 5
    end
    object qryEmptyPetIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object qryEmptyPetStoreName: TStringField
      FieldName = 'StoreName'
      Size = 30
    end
    object qryEmptyPetStoreState: TStringField
      FieldName = 'StoreState'
      FixedChar = True
      Size = 3
    end
    object qryEmptyPetStoreAddress: TStringField
      FieldName = 'StoreAddress'
      Size = 80
    end
    object qryEmptyPetStoreCity: TStringField
      FieldName = 'StoreCity'
      Size = 40
    end
    object qryEmptyPetStoreZip: TStringField
      FieldName = 'StoreZip'
      FixedChar = True
      Size = 12
    end
    object qryEmptyPetStorePhone: TStringField
      FieldName = 'StorePhone'
      Size = 40
    end
    object qryEmptyPetStoreFax: TStringField
      FieldName = 'StoreFax'
      Size = 40
    end
    object qryEmptyPetStoreEmail: TStringField
      FieldName = 'StoreEmail'
      Size = 60
    end
    object qryEmptyPetStoreWebPage: TStringField
      FieldName = 'StoreWebPage'
      Size = 80
    end
  end
  object dspEmptyPet: TDataSetProvider
    DataSet = qryEmptyPet
    Options = [poIncFieldProps]
    Left = 43
    Top = 343
  end
  object ctEmptyPet: TmrConfigTable
    DataSetProvider = dspEmptyPet
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
    Left = 42
    Top = 245
  end
end
