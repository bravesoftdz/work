inherited DMImportExport: TDMImportExport
  Left = 219
  Top = 310
  Height = 430
  Width = 805
  inherited LanguageDispatcher: TsiLangDispatcher
    Left = 52
    Top = 16
  end
  inherited imgSmall: TImageList
    Left = 152
    Top = 16
  end
  inherited imgLarge: TImageList
    Left = 240
    Top = 16
  end
  inherited imgPayments: TImageList
    Left = 332
    Top = 16
  end
  inherited DCOMConn: TDCOMConnection
    Left = 52
    Top = 76
  end
  inherited SocketConn: TSocketConnection
    Left = 52
    Top = 136
  end
  inherited WebConn: TWebConnection
    Left = 52
    Top = 196
  end
  object ImportConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMImport'
    Left = 264
    Top = 76
  end
  object cdsLookupStore: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLookupStore'
    RemoteServer = ImportConn
    Left = 152
    Top = 136
  end
  object dtsLookupStore: TDataSource
    DataSet = cdsLookupStore
    Left = 152
    Top = 196
  end
  object cdsLookupVendor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLookupVendor'
    RemoteServer = ImportConn
    Left = 264
    Top = 136
    object cdsLookupVendorIDVendor: TIntegerField
      FieldName = 'IDVendor'
      Required = True
    end
    object cdsLookupVendorVendor: TStringField
      FieldName = 'Vendor'
      FixedChar = True
      Size = 50
    end
  end
  object dtsLookupVendor: TDataSource
    DataSet = cdsLookupVendor
    Left = 264
    Top = 196
  end
  object cdsLookupUser: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLookupUser'
    RemoteServer = ImportConn
    Left = 716
    Top = 136
  end
  object dtsLookupUser: TDataSource
    DataSet = cdsLookupUser
    Left = 716
    Top = 196
  end
  object cdsLUCatalogVendor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLUVendor'
    RemoteServer = CatalogConn
    Left = 52
    Top = 260
  end
  object dtsLUCatalogVendor: TDataSource
    DataSet = cdsLUCatalogVendor
    Left = 52
    Top = 320
  end
  object ExportConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMExport'
    Left = 152
    Top = 76
  end
  object cdsLookupCategory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLuCategory'
    RemoteServer = LookupInvConn
    Left = 384
    Top = 136
  end
  object dtsLookupCategory: TDataSource
    DataSet = cdsLookupCategory
    Left = 384
    Top = 196
  end
  object CatalogConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMCatalog'
    Left = 512
    Top = 76
  end
  object LookupInvConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMLookupInventory'
    Left = 384
    Top = 76
  end
  object cdsLookupSubCategory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLuSubCategory'
    RemoteServer = LookupInvConn
    Left = 496
    Top = 140
  end
  object dtsLookupSubCategory: TDataSource
    DataSet = cdsLookupSubCategory
    Left = 496
    Top = 200
  end
  object dtsLookupGroup: TDataSource
    DataSet = cdsLookupGroup
    Left = 604
    Top = 196
  end
  object cdsLookupGroup: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLuGroup'
    RemoteServer = LookupInvConn
    Left = 604
    Top = 136
  end
  object cdsLUCatalogDepartment: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLUDepartment'
    RemoteServer = CatalogConn
    Left = 188
    Top = 260
  end
  object dtsLUCatalogDepartment: TDataSource
    DataSet = cdsLUCatalogDepartment
    Left = 188
    Top = 320
  end
  object cdsLUCatalogCategory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLUCategory'
    RemoteServer = CatalogConn
    Left = 324
    Top = 260
  end
  object dtsLUCatalogCategory: TDataSource
    DataSet = cdsLUCatalogCategory
    Left = 324
    Top = 320
  end
  object cdsLUCatalogSubCategory: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLUSubCategory'
    RemoteServer = CatalogConn
    Left = 460
    Top = 260
  end
  object dtsLUCatalogSubCategory: TDataSource
    DataSet = cdsLUCatalogSubCategory
    Left = 460
    Top = 320
  end
  object PetCenterConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMPetCenter'
    Left = 620
    Top = 80
  end
  object MaintConn: TSharedConnection
    ParentConnection = DCOMConn
    ChildName = 'RDMMaintenance'
    Left = 710
    Top = 75
  end
end
