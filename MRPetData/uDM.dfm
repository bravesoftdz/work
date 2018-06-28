object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 536
  Top = 222
  Height = 516
  Width = 610
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=MR_DB_User;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=MainRetailDB;Data Source=(LOCAL)\P' +
      'inogy'
    Provider = 'SQLOLEDB.1'
    Left = 27
    Top = 17
  end
  object qryMRPetSate: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    CommandTimeout = 18000
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT'
      #9'IM.DocumentID,'
      #9'IM.IDInventoryMov,'
      #9'BA.IDBarcode as Barcode,'
      #9'M.Model,'
      #9'TG.Name as Category,'
      #9'MG.ModelGroup, '
      #9'MSG.ModelSubGroup,'
      #9'M.Description,'
      #9'PPS.IDPetSale,'
      #9'PMS.MicrochipNum,'
      #9'P.IDPet,'
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
      #9'cast(cast(P.WhelpDate as date) as SmallDateTime) as WhelpDate,'
      
        #9'cast(cast(P.PurchaseDate as date) as smallDateTime) as  Purchas' +
        'eDate,'
      #9'P.Notes,'
      #9'PS.Species,'
      #9'PB.Breed,'
      #9'PA.StatusCode,'
      #9'PA.Status,'
      #9'B.Pessoa as Breeder,'
      #9'B.Endereco as BreederAddress,'
      #9'B.Cidade as BreederCity,'
      #9'B.IDEstado as BreederState,'
      #9'B.CEP as BreederZip,'
      #9'B.Telefone as BreederPhone,'
      #9'B.PhoneAreaCode as BreederPhoneAreaCode,'
      #9'B.Cellular as BreederCellPhone,'
      #9'B.CellAreaCode as BreederCellAreaCode,'
      #9'B.Email as BreederEmail,'
      #9'PPS.IDWarrantyReport,'
      #9'WC.PessoaFirstName as WCustomerFirstName,'
      #9'WC.PessoaLastName as WCustomerLastName,'
      #9'WC.Endereco as WCustomerAddress,'
      #9'WC.Cidade as WCustomerCity,'
      #9'WC.IDEstado as WCustomerStateID,'
      #9'WC.CEP as WCustomerZip,'
      #9'WC.Telefone as WCustomerPhone,'
      #9'WC.PhoneAreaCode as WCustomerPhoneAreaCode,'
      #9'WC.Cellular as WCustomerCell,'
      #9'WC.CellAreaCode as WCustomerCellAreaCode,'
      #9'WC.Email as WCustomerEmail,'
      #9'cast(cast(IM.Movdate as date) as smallDateTime) as PetSaleDate,'
      #9'IM.CostPrice as PetSaleCost,'
      #9'IM.SalePrice as PetSaleSold,'
      #9'IM.Discount as PetSaleDiscount,'
      #9'WC.Pessoa as SaleCustomerName,'
      #9'S.Name as Store,'
      #9'I.QtyOnHand,'
      #9'IM.Qty'
      'FROM '
      #9'InventoryMov IM (NOLOCK)'
      #9'JOIN Store S (NOLOCK) ON (S.IDStore = IM.StoreID)'
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)'
      
        #9'JOIN Inventory I (NOLOCK) ON (I.StoreID = IM.StoreID AND I.Mode' +
        'lID = IM.ModelID)'
      #9'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'
      #9'LEFT JOIN Pessoa C (NOLOCK) ON (C.IDPessoa = IM.IDPessoa)'
      
        #9'LEFT JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDMode' +
        'lGroup)'
      
        #9'LEFT JOIN ModelSubGroup MSG (NOLOCK) ON (M.IDModelSubGroup = MS' +
        'G.IDModelSubGroup)'
      
        #9'LEFT JOIN Barcode BA (NOLOCK) ON (M.IDModel = BA.IDModel AND BA' +
        '.BarcodeOrder = 1)'
      
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
      #9'LEFT JOIN Pet_Color PC (NOLOCK) ON (P.IDColor = PC.IDColor)')
    Left = 28
    Top = 236
  end
  object dspMRPetSale: TDataSetProvider
    DataSet = qryMRPetSate
    Left = 27
    Top = 186
  end
  object ctMRPetSale: TmrConfigTable
    DataSetProvider = dspMRPetSale
    OnBeforeGetRecords = ctMRPetSaleBeforeGetRecords
    Left = 28
    Top = 285
  end
  object cdsMRPetSale: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftDateTime
        Name = 'param_movdate'
        ParamType = ptInput
        Size = -1
      end>
    ProviderName = 'dspMRPetSale'
    BeforeGetRecords = cdsMRPetSaleBeforeGetRecords
    Left = 30
    Top = 147
  end
  object dsMRPetSale: TDataSource
    DataSet = cdsMRPetSale
    Left = 30
    Top = 89
  end
  object qryMRPetInventory: TADOQuery
    Connection = ADOConnection
    CursorType = ctStatic
    CommandTimeout = 18000
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
    Left = 133
    Top = 236
  end
  object dspMRPetInventory: TDataSetProvider
    DataSet = qryMRPetInventory
    Left = 132
    Top = 191
  end
  object cdsMRPetInventory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMRPetInventory'
    Left = 135
    Top = 137
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
    Left = 135
    Top = 89
  end
  object ctMRPetInventory: TmrConfigTable
    DataSetProvider = dspMRPetInventory
    Left = 133
    Top = 285
  end
end
