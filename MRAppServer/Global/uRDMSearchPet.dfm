object RDMSearchPet: TRDMSearchPet
  OldCreateOrder = False
  Left = 302
  Top = 202
  Height = 538
  Width = 722
  object qrySearchPet: TADOQuery
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
      #9'P.System,'
      #9'P.Hidden,'
      #9'P.Desativado,'
      #9'PS.Species,'
      #9'PT.Porte,'
      #9'PB.Breed,'
      #9'PA.StatusCode,'
      #9'PA.Status,'
      #9'B.Pessoa,'
      #9'B.Telefone,'
      #9'S.Name as Store'
      'FROM'
      #9'Pet P'
      
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
    Left = 32
    Top = 17
  end
  object dspSearchPet: TDataSetProvider
    DataSet = qrySearchPet
    Left = 31
    Top = 67
  end
  object ctSearchPet: TmrConfigTable
    DataSetProvider = dspSearchPet
    Left = 32
    Top = 124
  end
  object qrySearchTreatment: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'T.IDTreatment,'
      #9'T.Treatment,'
      #9'T.Mfg,'
      #9'T.TreatmentLotSize'
      'FROM'
      #9'Pet_Treatment T (NOLOCK)'
      'WHERE'
      #9'T.Desativado = 0'
      #9'AND T.Hidden = 0'
      #9'AND T.System = 0')
    Left = 142
    Top = 17
  end
  object dspSearchTreatment: TDataSetProvider
    DataSet = qrySearchTreatment
    Left = 141
    Top = 67
  end
  object ctSearchTreatment: TmrConfigTable
    DataSetProvider = dspSearchTreatment
    Left = 142
    Top = 124
  end
  object qrySearchPetSale: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PPS.IDPetSale,'
      #9'PPS.InvoiceTotal,'
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
      
        #9'CAST(((IM.Qty * IM.SalePrice) - IM.Discount) as Money) as PetNe' +
        'tSale,'
      #9'IM.Discount as PetSaleDiscount,'
      #9'WC.Pessoa as SaleCustomerName,'
      #9'S.Name as Store'
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
      
        #9'LEFT JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID AN' +
        'D IM.InventMovTypeID = 1)'
      #9'LEFT JOIN Pet_Color PC (NOLOCK) ON (P.IDColor = PC.IDColor)'
      #9'LEFT JOIN Store S (NOLOCK) ON (S.IDStore = P.IDStore)')
    Left = 264
    Top = 17
  end
  object dspSearchPetSale: TDataSetProvider
    DataSet = qrySearchPetSale
    Left = 263
    Top = 67
  end
  object ctSearchPetSale: TmrConfigTable
    DataSetProvider = dspSearchPetSale
    Left = 264
    Top = 124
  end
  object qryMRPetSate: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT'
      #9'IM.DocumentID,'
      #9'M.Model,'
      #9'M.Description,'
      #9'PPS.IDPetSale,'
      #9'PPS.InvoiceTotal,'
      #9'PMS.MicrochipNum,'
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
      #9'PPS.IDWarrantyReport,'
      #9'WC.Pessoa as WarrantyCustomerName,'
      #9'WC.PessoaFirstName as WCustomerFirstName,'
      #9'WC.PessoaLastName as WCustomerLastName,'
      #9'WC.Endereco as WCustomerAddress,'
      #9'WC.Cidade as WCustomerCity,'
      #9'WC.IDEstado as WCustomerStateID,'
      #9'WC.CEP as WCustomerZip,'
      #9'WC.Telefone as WCustomerPhone,'
      #9'WC.PhoneAreaCode as WCustomerPhoneAreaCode,'
      #9'WC.Email as WCustomerEmail,'
      #9'IM.MovDate as PetSaleDate,'
      #9'(IM.Qty * IM.CostPrice) as PetSaleCost,'
      #9'(IM.Qty * IM.SalePrice) as PetSaleSold,'
      #9'IM.Discount as PetSaleDiscount,'
      #9'WC.Pessoa as SaleCustomerName,'
      #9'S.Name as Store,'
      #9'I.QtyOnHand'
      'FROM'
      #9'InventoryMov IM (NOLOCK)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)'
      
        #9'JOIN Inventory I (NOLOCK) ON (I.StoreID = IM.StoreID AND I.Mode' +
        'lID = IM.ModelID)'
      #9'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'
      #9'JOIN Pessoa C (NOLOCK) ON (C.IDPessoa = IM.IDPessoa)'
      
        #9'LEFT JOIN Pet_PetSale PPS (NOLOCK) ON (PPS.IDPreInventoryMov = ' +
        'IM.PreInventoryMovID)'
      #9'LEFT JOIN Pet P (NOLOCK) ON (PPS.IDPet = P.IDPet)'
      
        #9'LEFT JOIN Pet_MicrochipSale PMS (NOLOCK) ON (PPS.IDPetSale = PM' +
        'S.IDPetSale)'
      
        #9'LEFT JOIN Pet_Species PS (NOLOCK) ON (PS.IDSpecies = P.IDSpecie' +
        's)'
      #9'LEFT JOIN Pet_Breed PB (NOLOCK) ON (PB.IDBreed = P.IDBreed)'
      #9'LEFT JOIN Pet_Status PA (NOLOCK) ON (PA.IDStatus = P.IDStatus)'
      #9'LEFT JOIN Pessoa B (NOLOCK) ON (B.IDPessoa = P.IDBreeder)'
      
        #9'LEFT JOIN Pessoa WC (NOLOCK) ON (WC.IDPessoa = PPS.IDWarrantyCu' +
        'stomer)'
      #9'LEFT JOIN Pet_Color PC (NOLOCK) ON (P.IDColor = PC.IDColor)'
      #9'LEFT JOIN Store S (NOLOCK) ON (S.IDStore = P.IDStore)')
    Left = 28
    Top = 361
  end
  object dspMRPetSale: TDataSetProvider
    DataSet = qryMRPetSate
    Left = 27
    Top = 411
  end
  object ctMRPetSale: TmrConfigTable
    DataSetProvider = dspMRPetSale
    OnBeforeGetRecords = ctMRPetSaleBeforeGetRecords
    Left = 28
    Top = 460
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=fudeu;Persist Security Info=True;Us' +
      'er ID=sa;Initial Catalog=RodrigoTestDB;Data Source=.'
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 212
  end
  object cdsMRPetSale: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMRPetSale'
    BeforeGetRecords = cdsMRPetSaleBeforeGetRecords
    Left = 30
    Top = 262
    object cdsMRPetSaleDocumentID: TIntegerField
      FieldName = 'DocumentID'
    end
    object cdsMRPetSaleModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsMRPetSaleDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsMRPetSaleIDPetSale: TIntegerField
      FieldName = 'IDPetSale'
    end
    object cdsMRPetSaleMicrochipNum: TStringField
      FieldName = 'MicrochipNum'
    end
    object cdsMRPetSaleIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object cdsMRPetSaleIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object cdsMRPetSaleIDPorte: TIntegerField
      FieldName = 'IDPorte'
    end
    object cdsMRPetSaleIDBreed: TIntegerField
      FieldName = 'IDBreed'
    end
    object cdsMRPetSaleIDStatus: TIntegerField
      FieldName = 'IDStatus'
    end
    object cdsMRPetSaleIDBreeder: TIntegerField
      FieldName = 'IDBreeder'
    end
    object cdsMRPetSaleIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsMRPetSaleIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsMRPetSaleName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object cdsMRPetSaleSex: TStringField
      FieldName = 'Sex'
      Size = 1
    end
    object cdsMRPetSaleColor: TStringField
      FieldName = 'Color'
      Size = 50
    end
    object cdsMRPetSaleSKU: TStringField
      FieldName = 'SKU'
      Size = 30
    end
    object cdsMRPetSalePenNum: TStringField
      FieldName = 'PenNum'
      Size = 10
    end
    object cdsMRPetSaleVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object cdsMRPetSaleMSRP: TBCDField
      FieldName = 'MSRP'
      Precision = 19
    end
    object cdsMRPetSaleSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object cdsMRPetSalePromoPrice: TBCDField
      FieldName = 'PromoPrice'
      Precision = 19
    end
    object cdsMRPetSaleUSDA: TStringField
      FieldName = 'USDA'
      Size = 50
    end
    object cdsMRPetSaleCollar: TStringField
      FieldName = 'Collar'
      Size = 50
    end
    object cdsMRPetSaleSire: TStringField
      FieldName = 'Sire'
      Size = 255
    end
    object cdsMRPetSaleDam: TStringField
      FieldName = 'Dam'
      Size = 255
    end
    object cdsMRPetSaleWhelpDate: TDateTimeField
      FieldName = 'WhelpDate'
    end
    object cdsMRPetSalePurchaseDate: TDateTimeField
      FieldName = 'PurchaseDate'
    end
    object cdsMRPetSaleNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object cdsMRPetSaleSpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
    object cdsMRPetSaleBreed: TStringField
      FieldName = 'Breed'
      Size = 50
    end
    object cdsMRPetSaleStatusCode: TStringField
      FieldName = 'StatusCode'
      Size = 5
    end
    object cdsMRPetSaleStatus: TStringField
      FieldName = 'Status'
      Size = 30
    end
    object cdsMRPetSaleBreeder: TStringField
      FieldName = 'Breeder'
      Size = 50
    end
    object cdsMRPetSaleIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
    end
    object cdsMRPetSaleWarrantyCustomerName: TStringField
      FieldName = 'WarrantyCustomerName'
      Size = 50
    end
    object cdsMRPetSaleWCustomerFirstName: TStringField
      FieldName = 'WCustomerFirstName'
      Size = 30
    end
    object cdsMRPetSaleWCustomerLastName: TStringField
      FieldName = 'WCustomerLastName'
      Size = 50
    end
    object cdsMRPetSaleWCustomerAddress: TStringField
      FieldName = 'WCustomerAddress'
      Size = 80
    end
    object cdsMRPetSaleWCustomerCity: TStringField
      FieldName = 'WCustomerCity'
      Size = 40
    end
    object cdsMRPetSaleWCustomerStateID: TStringField
      FieldName = 'WCustomerStateID'
      FixedChar = True
      Size = 3
    end
    object cdsMRPetSaleWCustomerZip: TStringField
      FieldName = 'WCustomerZip'
      FixedChar = True
      Size = 12
    end
    object cdsMRPetSaleWCustomerPhoneAreaCode: TStringField
      FieldName = 'WCustomerPhoneAreaCode'
      Size = 5
    end
    object cdsMRPetSaleWCustomerPhone: TStringField
      FieldName = 'WCustomerPhone'
      Size = 40
    end
    object cdsMRPetSaleWCustomerEmail: TStringField
      FieldName = 'WCustomerEmail'
      Size = 50
    end
    object cdsMRPetSalePetSaleDate: TDateTimeField
      FieldName = 'PetSaleDate'
    end
    object cdsMRPetSalePetSaleCost: TBCDField
      FieldName = 'PetSaleCost'
      Precision = 19
    end
    object cdsMRPetSalePetSaleSold: TBCDField
      FieldName = 'PetSaleSold'
      Precision = 19
    end
    object cdsMRPetSalePetSaleDiscount: TBCDField
      FieldName = 'PetSaleDiscount'
      Precision = 19
    end
    object cdsMRPetSaleSaleCustomerName: TStringField
      FieldName = 'SaleCustomerName'
      Size = 50
    end
    object cdsMRPetSaleStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object cdsMRPetSaleQtyOnHand: TBCDField
      FieldName = 'QtyOnHand'
      Precision = 32
    end
  end
  object dsMRPetSale: TDataSource
    DataSet = cdsMRPetSale
    Left = 30
    Top = 314
  end
  object qryMRPetInventory: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT'
      #9'P.IDPet,'
      #9'P.SKU,'
      #9'P.Sex,'
      #9'PC.Color,'
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
      #9'PT.Porte as Port,'
      #9'PB.Breed,'
      #9'PA.StatusCode,'
      #9'PA.Status,'
      #9'B.Pessoa as Breeder,'
      #9'B.PhoneAreaCode,'
      #9'B.Telefone as BreederPhone,'
      #9'S.Name as Store,'
      #9'PW.EntryDate as WeightEntryDate,'
      #9'PW.Weight,'
      #9'PR.Registry,'
      #9'PPR.RegistrationNum'
      'FROM'
      #9'Pet P'
      
        #9'LEFT JOIN Pet_Species PS (NOLOCK) ON (PS.IDSpecies = P.IDSpecie' +
        's)'
      #9'LEFT JOIN Pet_Porte PT (NOLOCK) ON (PT.IDPorte = P.IDPorte)'
      #9'LEFT JOIN Pet_Breed PB (NOLOCK) ON (PB.IDBreed = P.IDBreed)'
      #9'LEFT JOIN Pet_Status PA (NOLOCK) ON (PA.IDStatus = P.IDStatus)'
      #9'LEFT JOIN Pessoa B (NOLOCK) ON (B.IDPessoa = P.IDBreeder)'
      #9'LEFT JOIN Pet_Color PC (NOLOCK) ON (P.IDColor = PC.IDColor)'
      #9'LEFT JOIN Store S (NOLOCK) ON (S.IDStore = P.IDStore)'
      #9'LEFT JOIN Pet_Weight PW (NOLOCK) ON (PW.IDPet = P.IDPet)'
      #9'LEFT JOIN Pet_PetRegistry PPR (NOLOCK) ON (PPR.IDPet = P.IDPet)'
      
        #9'LEFT JOIN Pet_Registry PR (NOLOCK) ON (PR.IDRegistry = PPR.IDRe' +
        'gistry)'
      'WHERE'
      #9'P.Desativado = 0'
      #9'AND P.Hidden = 0'
      #9'AND P.System = 0'
      #9'AND P.IDStatus IN (1, 2, 3)')
    Left = 128
    Top = 361
  end
  object dspMRPetInventory: TDataSetProvider
    DataSet = qryMRPetInventory
    Left = 127
    Top = 411
  end
  object ctMRPetInventory: TmrConfigTable
    DataSetProvider = dspMRPetInventory
    Left = 128
    Top = 460
  end
  object cdsMRPetInventory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMRPetInventory'
    Left = 130
    Top = 262
    object cdsMRPetInventoryIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object cdsMRPetInventorySKU: TStringField
      FieldName = 'SKU'
      Size = 30
    end
    object cdsMRPetInventorySex: TStringField
      FieldName = 'Sex'
      Size = 1
    end
    object cdsMRPetInventoryColor: TStringField
      FieldName = 'Color'
      Size = 50
    end
    object cdsMRPetInventoryPenNum: TStringField
      FieldName = 'PenNum'
      Size = 10
    end
    object cdsMRPetInventoryVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object cdsMRPetInventoryMSRP: TBCDField
      FieldName = 'MSRP'
      Precision = 19
    end
    object cdsMRPetInventorySalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object cdsMRPetInventoryPromoPrice: TBCDField
      FieldName = 'PromoPrice'
      Precision = 19
    end
    object cdsMRPetInventoryUSDA: TStringField
      FieldName = 'USDA'
      Size = 50
    end
    object cdsMRPetInventoryCollar: TStringField
      FieldName = 'Collar'
      Size = 50
    end
    object cdsMRPetInventorySire: TStringField
      FieldName = 'Sire'
      Size = 255
    end
    object cdsMRPetInventoryDam: TStringField
      FieldName = 'Dam'
      Size = 255
    end
    object cdsMRPetInventoryWhelpDate: TDateTimeField
      FieldName = 'WhelpDate'
    end
    object cdsMRPetInventoryPurchaseDate: TDateTimeField
      FieldName = 'PurchaseDate'
    end
    object cdsMRPetInventoryNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object cdsMRPetInventorySpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
    object cdsMRPetInventoryPort: TStringField
      FieldName = 'Port'
      Size = 50
    end
    object cdsMRPetInventoryBreed: TStringField
      FieldName = 'Breed'
      Size = 50
    end
    object cdsMRPetInventoryStatusCode: TStringField
      FieldName = 'StatusCode'
      Size = 5
    end
    object cdsMRPetInventoryStatus: TStringField
      FieldName = 'Status'
      Size = 30
    end
    object cdsMRPetInventoryBreeder: TStringField
      FieldName = 'Breeder'
      Size = 50
    end
    object cdsMRPetInventoryPhoneAreaCode: TStringField
      FieldName = 'PhoneAreaCode'
      Size = 5
    end
    object cdsMRPetInventoryBreederPhone: TStringField
      FieldName = 'BreederPhone'
      Size = 40
    end
    object cdsMRPetInventoryStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object cdsMRPetInventoryWeightEntryDate: TDateTimeField
      FieldName = 'WeightEntryDate'
    end
    object cdsMRPetInventoryWeight: TBCDField
      FieldName = 'Weight'
      Precision = 32
    end
    object cdsMRPetInventoryRegistry: TStringField
      FieldName = 'Registry'
      Size = 50
    end
    object cdsMRPetInventoryRegistrationNum: TStringField
      FieldName = 'RegistrationNum'
      Size = 50
    end
  end
  object dsMRPetInventory: TDataSource
    DataSet = cdsMRPetInventory
    Left = 130
    Top = 314
  end
end
