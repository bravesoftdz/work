object DMWarrantyPrintThread: TDMWarrantyPrintThread
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 76
  Top = 228
  Height = 416
  Width = 625
  object cdsPetPrint: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSearchPetSale'
    RemoteServer = SearchPetConn
    BeforeGetRecords = cdsPetPrintBeforeGetRecords
    Left = 48
    Top = 24
  end
  object ReportConn: TSharedConnection
    ChildName = 'RDMReport'
    Left = 148
    Top = 160
  end
  object PetCenterConn: TSharedConnection
    ChildName = 'RDMPetCenter'
    Left = 152
    Top = 92
  end
  object SearchPetConn: TSharedConnection
    ChildName = 'RDMSearchPet'
    Left = 156
    Top = 26
  end
  object cdsRepWarranty: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspWarrantyRep'
    RemoteServer = DMPet.PetCenterConn
    Left = 52
    Top = 80
    object cdsRepWarrantyIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
    end
    object cdsRepWarrantyIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object cdsRepWarrantyReport: TBlobField
      FieldName = 'Report'
    end
    object cdsRepWarrantyReportDate: TDateTimeField
      FieldName = 'ReportDate'
    end
    object cdsRepWarrantyReportName: TStringField
      FieldName = 'ReportName'
      Size = 30
    end
  end
  object cdsDBPet: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPet'
    RemoteServer = DMPet.ReportConn
    BeforeGetRecords = cdsDBPetBeforeGetRecords
    Left = 280
    Top = 192
    object cdsDBPetIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object cdsDBPetIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object cdsDBPetIDPorte: TIntegerField
      FieldName = 'IDPorte'
    end
    object cdsDBPetIDBreed: TIntegerField
      FieldName = 'IDBreed'
    end
    object cdsDBPetIDStatus: TIntegerField
      FieldName = 'IDStatus'
    end
    object cdsDBPetIDBreeder: TIntegerField
      FieldName = 'IDBreeder'
    end
    object cdsDBPetIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsDBPetName: TStringField
      FieldName = 'Name'
      Size = 50
    end
    object cdsDBPetSex: TStringField
      FieldName = 'Sex'
      Size = 1
    end
    object cdsDBPetColor: TStringField
      FieldName = 'Color'
      Size = 50
    end
    object cdsDBPetSKU: TStringField
      FieldName = 'SKU'
      Size = 30
    end
    object cdsDBPetPenNum: TStringField
      FieldName = 'PenNum'
      Size = 10
    end
    object cdsDBPetVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object cdsDBPetMSRP: TBCDField
      FieldName = 'MSRP'
      Precision = 19
    end
    object cdsDBPetSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object cdsDBPetPromoPrice: TBCDField
      FieldName = 'PromoPrice'
      Precision = 19
    end
    object cdsDBPetUSDA: TStringField
      FieldName = 'USDA'
      Size = 50
    end
    object cdsDBPetCollar: TStringField
      FieldName = 'Collar'
      Size = 50
    end
    object cdsDBPetSire: TStringField
      FieldName = 'Sire'
      Size = 255
    end
    object cdsDBPetDam: TStringField
      FieldName = 'Dam'
      Size = 255
    end
    object cdsDBPetWhelpDate: TDateTimeField
      FieldName = 'WhelpDate'
    end
    object cdsDBPetPurchaseDate: TDateTimeField
      FieldName = 'PurchaseDate'
    end
    object cdsDBPetNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object cdsDBPetSpecies: TStringField
      FieldName = 'Species'
      Size = 50
    end
    object cdsDBPetBreed: TStringField
      FieldName = 'Breed'
      Size = 50
    end
    object cdsDBPetStatusCode: TStringField
      FieldName = 'StatusCode'
      Size = 5
    end
    object cdsDBPetStatus: TStringField
      FieldName = 'Status'
      Size = 30
    end
    object cdsDBPetBreeder: TStringField
      FieldName = 'Breeder'
      Size = 50
    end
    object cdsDBPetIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
    end
    object cdsDBPetWarrantyCustomerName: TStringField
      FieldName = 'WarrantyCustomerName'
      Size = 50
    end
    object cdsDBPetWCustomerFirstName: TStringField
      FieldName = 'WCustomerFirstName'
      Size = 30
    end
    object cdsDBPetWCustomerLastName: TStringField
      FieldName = 'WCustomerLastName'
      Size = 30
    end
    object cdsDBPetWCustomerAddress: TStringField
      FieldName = 'WCustomerAddress'
      Size = 80
    end
    object cdsDBPetWCustomerCity: TStringField
      FieldName = 'WCustomerCity'
      Size = 40
    end
    object cdsDBPetWCustomerStateID: TStringField
      FieldName = 'WCustomerStateID'
      FixedChar = True
      Size = 3
    end
    object cdsDBPetWCustomerZip: TStringField
      FieldName = 'WCustomerZip'
      FixedChar = True
      Size = 12
    end
    object cdsDBPetWCustomerPhone: TStringField
      FieldName = 'WCustomerPhone'
      Size = 40
    end
    object cdsDBPetWCustomerEmail: TStringField
      FieldName = 'WCustomerEmail'
      Size = 50
    end
    object cdsDBPetPetSaleDate: TDateTimeField
      FieldName = 'PetSaleDate'
    end
    object cdsDBPetPetSaleCost: TBCDField
      FieldName = 'PetSaleCost'
      Precision = 19
    end
    object cdsDBPetPetSaleSold: TBCDField
      FieldName = 'PetSaleSold'
      Precision = 19
    end
    object cdsDBPetPetSaleDiscount: TBCDField
      FieldName = 'PetSaleDiscount'
      Precision = 19
    end
    object cdsDBPetSaleCustomerName: TStringField
      FieldName = 'SaleCustomerName'
      Size = 50
    end
    object cdsDBPetBreederAddress: TStringField
      FieldName = 'BreederAddress'
      Size = 80
    end
    object cdsDBPetBreederCity: TStringField
      FieldName = 'BreederCity'
      Size = 40
    end
    object cdsDBPetBreederStateID: TStringField
      FieldName = 'BreederStateID'
      FixedChar = True
      Size = 3
    end
    object cdsDBPetBreederZip: TStringField
      FieldName = 'BreederZip'
      FixedChar = True
      Size = 12
    end
    object cdsDBPetWSalePhoneAreaCode: TStringField
      FieldName = 'WSalePhoneAreaCode'
      Size = 5
    end
    object cdsDBPetIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsDBPetStoreName: TStringField
      FieldName = 'StoreName'
      Size = 30
    end
    object cdsDBPetStoreState: TStringField
      FieldName = 'StoreState'
      FixedChar = True
      Size = 3
    end
    object cdsDBPetStoreAddress: TStringField
      FieldName = 'StoreAddress'
      Size = 80
    end
    object cdsDBPetStoreCity: TStringField
      FieldName = 'StoreCity'
      Size = 40
    end
    object cdsDBPetStoreZip: TStringField
      FieldName = 'StoreZip'
      FixedChar = True
      Size = 12
    end
    object cdsDBPetStorePhone: TStringField
      FieldName = 'StorePhone'
      Size = 40
    end
    object cdsDBPetStoreFax: TStringField
      FieldName = 'StoreFax'
      Size = 40
    end
    object cdsDBPetStoreEmail: TStringField
      FieldName = 'StoreEmail'
      Size = 60
    end
    object cdsDBPetStoreWebPage: TStringField
      FieldName = 'StoreWebPage'
      Size = 80
    end
  end
  object dsDBPet: TDataSource
    DataSet = cdsDBPet
    Left = 279
    Top = 192
  end
  object ppDBPet: TppDBPipeline
    DataSource = dsDBPet
    CloseDataSource = True
    UserName = 'DBPet'
    Left = 280
    Top = 192
  end
  object cdsWarranty: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspWarrantyRep'
    RemoteServer = DMPet.PetCenterConn
    BeforeGetRecords = cdsWarrantyBeforeGetRecords
    Left = 366
    Top = 194
    object cdsWarrantyIDWarrantyReport: TIntegerField
      FieldName = 'IDWarrantyReport'
    end
    object cdsWarrantyIDSpecies: TIntegerField
      FieldName = 'IDSpecies'
    end
    object cdsWarrantyReport: TBlobField
      FieldName = 'Report'
    end
    object cdsWarrantyReportDate: TDateTimeField
      FieldName = 'ReportDate'
    end
    object cdsWarrantyReportName: TStringField
      FieldName = 'ReportName'
      Size = 30
    end
  end
  object dsWarranty: TDataSource
    DataSet = cdsWarranty
    Left = 366
    Top = 194
  end
  object ppDBWarranty: TppDBPipeline
    DataSource = dsWarranty
    CloseDataSource = True
    UserName = 'DBWarranty'
    Visible = False
    Left = 367
    Top = 194
    object ppDBWarrantyppField1: TppField
      FieldAlias = 'IDWarrantyReport'
      FieldName = 'IDWarrantyReport'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBWarrantyppField2: TppField
      FieldAlias = 'IDSpecies'
      FieldName = 'IDSpecies'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBWarrantyppField3: TppField
      FieldAlias = 'Report'
      FieldName = 'Report'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBWarrantyppField4: TppField
      FieldAlias = 'ReportDate'
      FieldName = 'ReportDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBWarrantyppField5: TppField
      FieldAlias = 'ReportName'
      FieldName = 'ReportName'
      FieldLength = 30
      DisplayWidth = 30
      Position = 4
      Searchable = False
      Sortable = False
    end
  end
  object cdsMicrochip: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPetMicrochip'
    RemoteServer = DMPet.ReportConn
    BeforeGetRecords = cdsMicrochipBeforeGetRecords
    Left = 462
    Top = 193
    object cdsMicrochipIDMicrochip: TIntegerField
      FieldName = 'IDMicrochip'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsMicrochipIDPet: TIntegerField
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsMicrochipMicrochip: TStringField
      FieldName = 'Microchip'
      ProviderFlags = []
      Size = 50
    end
    object cdsMicrochipMicrochipNum: TStringField
      DisplayLabel = 'Microchip Num'
      FieldName = 'MicrochipNum'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
  object dsMicrochip: TDataSource
    DataSet = cdsMicrochip
    Left = 462
    Top = 193
  end
  object ppDBMicrochip: TppDBPipeline
    DataSource = dsMicrochip
    CloseDataSource = True
    UserName = 'DBMicrochip'
    Left = 461
    Top = 193
    object ppDBMicrochipppField1: TppField
      FieldAlias = 'IDMicrochip'
      FieldName = 'IDMicrochip'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBMicrochipppField2: TppField
      FieldAlias = 'IDPet'
      FieldName = 'IDPet'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBMicrochipppField3: TppField
      FieldAlias = 'Microchip'
      FieldName = 'Microchip'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBMicrochipppField4: TppField
      FieldAlias = 'MicrochipNum'
      FieldName = 'MicrochipNum'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
  end
  object cdsRegistry: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPetRegistry'
    RemoteServer = DMPet.ReportConn
    BeforeGetRecords = cdsRegistryBeforeGetRecords
    Left = 282
    Top = 273
    object cdsRegistryIDRegistry: TIntegerField
      FieldName = 'IDRegistry'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsRegistryIDPet: TIntegerField
      FieldName = 'IDPet'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsRegistryRegistrationNum: TStringField
      DisplayLabel = 'Registration Num'
      FieldName = 'RegistrationNum'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 50
    end
    object cdsRegistryRegistry: TStringField
      FieldName = 'Registry'
      ProviderFlags = []
      Size = 50
    end
    object cdsRegistrySKU: TStringField
      FieldName = 'SKU'
      ProviderFlags = []
      Size = 30
    end
  end
  object dsRegistry: TDataSource
    DataSet = cdsRegistry
    Left = 282
    Top = 273
  end
  object ppDBRegistry: TppDBPipeline
    DataSource = dsRegistry
    CloseDataSource = True
    UserName = 'DBRegistry'
    Left = 282
    Top = 273
  end
  object cdsPetMedical: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPetMedicalCondition'
    RemoteServer = DMPet.PetCenterConn
    BeforeGetRecords = cdsPetMedicalBeforeGetRecords
    Left = 368
    Top = 273
    object cdsPetMedicalIDPetMedicalCondition: TIntegerField
      FieldName = 'IDPetMedicalCondition'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsPetMedicalMedicalCondition: TStringField
      DisplayLabel = 'Medical Condition'
      FieldName = 'MedicalCondition'
      ProviderFlags = []
      Size = 50
    end
    object cdsPetMedicalSubMedicalCondition: TStringField
      DisplayLabel = 'Sub M. Condition'
      FieldName = 'SubMedicalCondition'
      ProviderFlags = []
      Size = 255
    end
    object cdsPetMedicalRecordDate: TDateTimeField
      DisplayLabel = 'Record Date'
      FieldName = 'RecordDate'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object cdsPetMedicalNotes: TStringField
      FieldName = 'Notes'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
  end
  object dsPetMedical: TDataSource
    DataSet = cdsPetMedical
    Left = 369
    Top = 273
  end
  object ppDBPetMedical: TppDBPipeline
    DataSource = dsPetMedical
    CloseDataSource = True
    UserName = 'DBPetMedical'
    Left = 369
    Top = 273
    object ppDBPetMedicalppField1: TppField
      FieldAlias = 'IDPetMedicalCondition'
      FieldName = 'IDPetMedicalCondition'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPetMedicalppField2: TppField
      FieldAlias = 'MedicalCondition'
      FieldName = 'MedicalCondition'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPetMedicalppField3: TppField
      FieldAlias = 'SubMedicalCondition'
      FieldName = 'SubMedicalCondition'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPetMedicalppField4: TppField
      FieldAlias = 'RecordDate'
      FieldName = 'RecordDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBPetMedicalppField5: TppField
      FieldAlias = 'Notes'
      FieldName = 'Notes'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
  end
  object cdsPetTreatment: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPetTreatment'
    RemoteServer = DMPet.ReportConn
    BeforeGetRecords = cdsPetTreatmentBeforeGetRecords
    Left = 461
    Top = 271
    object cdsPetTreatmentTreatmentType: TIntegerField
      FieldName = 'TreatmentType'
    end
    object cdsPetTreatmentTreatment: TStringField
      FieldName = 'Treatment'
      Size = 50
    end
    object cdsPetTreatmentMfg: TStringField
      FieldName = 'Mfg'
      Size = 50
    end
    object cdsPetTreatmentLotNumber: TStringField
      FieldName = 'LotNumber'
      Size = 30
    end
    object cdsPetTreatmentTreatmentTypeStr: TStringField
      FieldName = 'TreatmentTypeStr'
      ReadOnly = True
      Size = 15
    end
    object cdsPetTreatmentTreatmentDate: TDateTimeField
      FieldName = 'TreatmentDate'
    end
  end
  object dsPetTreatment: TDataSource
    DataSet = cdsPetTreatment
    Left = 462
    Top = 272
  end
  object ppDBPetTreatment: TppDBPipeline
    DataSource = dsPetTreatment
    CloseDataSource = True
    UserName = 'DBPetTreatment'
    Left = 462
    Top = 273
    object ppDBPetTreatmentppField1: TppField
      FieldAlias = 'TreatmentType'
      FieldName = 'TreatmentType'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPetTreatmentppField2: TppField
      FieldAlias = 'Treatment'
      FieldName = 'Treatment'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPetTreatmentppField3: TppField
      FieldAlias = 'Mfg'
      FieldName = 'Mfg'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPetTreatmentppField4: TppField
      FieldAlias = 'LotNumber'
      FieldName = 'LotNumber'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBPetTreatmentppField5: TppField
      FieldAlias = 'TreatmentTypeStr'
      FieldName = 'TreatmentTypeStr'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDBPetTreatmentppField6: TppField
      FieldAlias = 'TreatmentDate'
      FieldName = 'TreatmentDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
  end
  object RBExportrControl: TPsRBExportMasterControl
    PDF.ExportImageFormat = ifJPG
    PDF.EncryptionLevel = el40Bit
    HTML.DefaultFont.Charset = DEFAULT_CHARSET
    HTML.DefaultFont.Color = clWindowText
    HTML.DefaultFont.Height = -13
    HTML.DefaultFont.Name = 'Arial'
    HTML.DefaultFont.Style = []
    HTML.DocumentPreferences.AutoMaximizeWindow = False
    HTML.DocumentPreferences.DisableRightClick = False
    HTML.DocumentPreferences.DisableCopying = False
    HTML.LinkFont.Charset = DEFAULT_CHARSET
    HTML.LinkFont.Color = clBlue
    HTML.LinkFont.Height = -24
    HTML.LinkFont.Name = 'Wingdings'
    HTML.LinkFont.Style = []
    HTML.LinkTextFirst = #217
    HTML.LinkTextNext = #216
    HTML.LinkTextPrev = #215
    HTML.LinkTextLast = #218
    XHTML.DefaultFont.Charset = DEFAULT_CHARSET
    XHTML.DefaultFont.Color = clWindowText
    XHTML.DefaultFont.Height = -13
    XHTML.DefaultFont.Name = 'Arial'
    XHTML.DefaultFont.Style = []
    XHTML.DocumentPreferences.AutoMaximizeWindow = False
    XHTML.DocumentPreferences.DisableRightClick = False
    XHTML.DocumentPreferences.DisableCopying = False
    XHTML.LinkFont.Charset = DEFAULT_CHARSET
    XHTML.LinkFont.Color = clBlue
    XHTML.LinkFont.Height = -24
    XHTML.LinkFont.Name = 'Wingdings'
    XHTML.LinkFont.Style = []
    RTF.Active = True
    Excel.Active = True
    Excel.PositionalGridDimensions.Height = 4234
    Excel.PositionalGridDimensions.Width = 16934
    GIF.Active = True
    GIF.ScaleX = 1.000000000000000000
    GIF.ScaleY = 1.000000000000000000
    JPEG.Active = True
    JPEG.ScaleX = 1.000000000000000000
    JPEG.ScaleY = 1.000000000000000000
    JPEG.ProgressiveEncoding = True
    BMP.Active = True
    BMP.ScaleX = 1.000000000000000000
    BMP.ScaleY = 1.000000000000000000
    EMF.Active = True
    EMF.ScaleX = 1.000000000000000000
    EMF.ScaleY = 1.000000000000000000
    WMF.Active = True
    WMF.ScaleX = 1.000000000000000000
    WMF.ScaleY = 1.000000000000000000
    Left = 436
    Top = 112
  end
  object ppReport: TppReport
    DataPipeline = ppDBPet
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    Template.DatabaseSettings.DataPipeline = ppDBWarranty
    Template.DatabaseSettings.Name = 'Warranty'
    Template.DatabaseSettings.NameField = 'ReportName'
    Template.DatabaseSettings.TemplateField = 'Report'
    Template.SaveTo = stDatabase
    AllowPrintToFile = True
    DeviceType = 'Screen'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    PreviewFormSettings.WindowState = wsMaximized
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 308
    Top = 112
    Version = '7.02'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPet'
    object ppTitleBand: TppTitleBand
      mmBottomOffset = 0
      mmHeight = 190236
      mmPrintPosition = 0
      object ppImage: TppImage
        UserName = 'Image'
        MaintainAspectRatio = False
        mmHeight = 17992
        mmLeft = 6085
        mmTop = 794
        mmWidth = 29898
        BandType = 1
      end
      object ppShape10: TppShape
        UserName = 'Shape10'
        Pen.Width = 5
        mmHeight = 18256
        mmLeft = 38365
        mmTop = 529
        mmWidth = 160602
        BandType = 1
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        Caption = 'XXXXXXXXX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 16
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 6632
        mmLeft = 91811
        mmTop = 3175
        mmWidth = 34290
        BandType = 1
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        Caption = 'Animal Warranty'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 16
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 6615
        mmLeft = 85461
        mmTop = 10319
        mmWidth = 44186
        BandType = 1
      end
      object ppRichText1: TppRichText
        UserName = 'RichText1'
        Caption = 'RichText1'
        RichText = 
          '{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\froman\fc' +
          'harset0 Times New Roman;}{\f1\fnil MS Sans Serif;}}'#13#10'\viewkind4\' +
          'uc1\pard\i\f0\fs20 Dear Customer,\par'#13#10'\par'#13#10'We try to obtain on' +
          'ly healthy animals, and we provide the highest quality of care f' +
          'or them while they are with us. Our dogs are all vaccinated, dew' +
          'ormed, and microchipped. Our veterinarians have examined this pe' +
          't and their exam notes are attached. Animals may have health pro' +
          'blems that we are unable to detect. We want you to be happy with' +
          ' your pet for many years, so we require that you have the pet ex' +
          'amined by a licensed veterinarian within 5 calendar days of your' +
          ' purchase. This examination is at your expense and is required t' +
          'o validate this warranty\b . In the event that a medical problem' +
          ' is found you will need to contact XXXXXXXXX prior to treatment.' +
          ' X_____ If you elect to treat your pet, prior to approval of cov' +
          'erage under this warranty, you will not be eligible for reimburs' +
          'ement on expenses that are incurred. X_____ XXXXXXXXX requires a' +
          'ny medical conditions covered by this warranty to be treated at ' +
          'Reston Animal Hospital. You will need to contact XXXXXXXX prior ' +
          'to your visit so that we can send a voucher to Reston Animal Hos' +
          'pital. This warranty does not cover cost associated with fleas, ' +
          'ear mites, or parasites. X_____ If you need to return your pet f' +
          'or any reason, other than animal medical claims, you may do so f' +
          'or up to 48 hours for a refund of the purchase price less any de' +
          'posits used to place this pet on hold. All returns will be asses' +
          'sed a $150 administrative fee. X_____ \b0 After 48 hours, refund' +
          's will be at the discretion of the store managers and will be re' +
          'duced by 10% of the purchase price for each calendar day that th' +
          'e dog was in your possession. If a veterinarian certifies your p' +
          'et to be unfit for purchase within ten days following receipt of' +
          ' the pet, you may return the pet for a refund of the purchase pr' +
          'ice. Refunds will be issued after we receive your veterinarian'#39's' +
          ' letter stating the medical condition on their letterhead with t' +
          'he original paperwork from purchase. Claims must be received wit' +
          'hin three days of the exam date. No refunds or exchanges will be' +
          ' made if the prescribed diet and care instructions are not follo' +
          'wed. Supplies that have been used may not be returned.\par'#13#10'\par' +
          'd\qc\ul\b This section applies to purebred animals only.\ulnone\' +
          'par'#13#10'\pard\b0 Registration papers will be held for pick up at XX' +
          'XXXXXXX for 3 months. All pure bred animals have met our standar' +
          'ds for health and breed representation. Purebred animals are con' +
          'sidered pet quality and are not intended for breeding. Registrat' +
          'ion papers are usually available for pick-up after four weeks. X' +
          'XXXXXXXX aid in registration problems for up to 3 months after t' +
          'he purchase date. XXXXXXXXXX will not be responsible for registr' +
          'ation of pets after 3 months.  \par'#13#10'\pard\qc\b Three-Year Hered' +
          'itary Warranty\par'#13#10'\pard\b0 Purebred dogs include a three-year ' +
          'warranty on hereditary defects. Reimbursement is limited to the ' +
          'actual purchase price of the dog and will vary based on the seve' +
          'rity of the problem. Claims must be made within the guidelines a' +
          'nd time limits of this warranty. Claims will require supporting ' +
          'documentation from your veterinarian. \par'#13#10'\pard\qc\i0 Notice \' +
          'par'#13#10'\pard\tab The sale of certain dogs and cats described as be' +
          'ing registered or capable of being registered with any animal pe' +
          'digree organization is subject to the provision of the Virginia ' +
          'Consumer Protection Act (59.1-196 et seq.). In the event that a ' +
          'licensed veterinarian certifies your animal to be unfit for purc' +
          'hase within ten days following receipt of your animal, you may c' +
          'hoose (I) to return the animal and receive a refund of the purch' +
          'ase price or (ii) to return the animal and receive an exchange a' +
          'nimal of your choice of equivalent value.\par'#13#10'\tab In order to ' +
          'exercise these rights you must present a written veterinary cert' +
          'ification that the animal is unfit within three business days af' +
          'ter receiving such certification. If the pet dealer has promised' +
          ' to register your animal or to provide the papers necessary ther' +
          'efore and fails to do so within 120 days following the date of t' +
          'he contract, you are entitled to return the animal and receive a' +
          ' refund of the purchase price or retain the animal and receive a' +
          ' refund of an amount not to exceed fifty percent of the purchase' +
          ' price.\par'#13#10'\par'#13#10'\pard\qc\i No warranty or representation has ' +
          'been made with respect to this animal except as set forth herein' +
          '.\par'#13#10'This pet was taken home as of the date of this contract.\' +
          'i0\par'#13#10'\f1\fs16\par'#13#10'}'#13#10
        mmHeight = 170392
        mmLeft = 6350
        mmTop = 19579
        mmWidth = 192617
        BandType = 1
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
      end
    end
    object ppDetailBand: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 103188
      mmPrintPosition = 0
      object ppSubRepTerms: TppSubReport
        UserName = 'SubRepTerms'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        ShiftRelativeTo = ppRegion1
        TraverseAllData = False
        DataPipelineName = 'ppDBPet'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 57150
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildRepTerm: TppChildReport
          AutoStop = False
          DataPipeline = ppDBPet
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'Letter'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 279401
          PrinterSetup.mmPaperWidth = 215900
          PrinterSetup.PaperSize = 1
          Template.DatabaseSettings.DataPipeline = ppDBWarranty
          Template.DatabaseSettings.NameField = 'ReportName'
          Template.DatabaseSettings.TemplateField = 'Report'
          Template.SaveTo = stDatabase
          Version = '7.02'
          mmColumnWidth = 0
          DataPipelineName = 'ppDBPet'
          object ppTitleBand1: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 245005
            mmPrintPosition = 0
            object ppRichTerm: TppRichText
              UserName = 'RichTerm'
              Caption = 'RichTerm'
              RichText = 
                '{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\froman\fc' +
                'harset0 Times New Roman;}}'#13#10'\viewkind4\uc1\pard\qc\f0\fs20 Terms' +
                ' and Conditions of Warranty\par'#13#10'\par'#13#10'\pard\tab The XXXXXXXXX w' +
                'arranty provides veterinary care for your new pet only. Veterina' +
                'ry services provided by this warranty are limited to the purchas' +
                'e price of the pet*. XXXXXXXXX does not provide refunds for vete' +
                'rinary expenses incurred from your veterinarian. This warranty r' +
                'equires that a licensed veterinarian perform a complete physical' +
                ' exam within 5 days of your purchase date. Failure to have the p' +
                'et seen by a veterinarian within 5 days of the purchase date wil' +
                'l void this warranty. We will not extend this period for any rea' +
                'son.\par'#13#10'\tab XXXXXXXXX will consider the notification date the' +
                ' first symptom date. You may contact the store during business h' +
                'ours at 703-435-5541. If you have an after hours emergency you c' +
                'an contact the Emergency Veterinary Clinic in Vienna, VA. Their ' +
                'phone number is 703-281-5121. This number is for after-hours eme' +
                'rgencies only. XXXXXXXXX will not cover veterinary expenses from' +
                ' the Emergency Veterinary Clinic.\par'#13#10'\par'#13#10'\b Respiratory Infe' +
                'ctions. \b0 Must be diagnosed within 10 days of the purchase dat' +
                'e. The warranty will provide veterinary care from our veterinari' +
                'ans up to the cost of the pet.\par'#13#10'\b\par'#13#10'Eye Entropian, \b0 E' +
                'ctropion \b & Cherry Eye. \b0 Must be diagnosed within 10 days o' +
                'f the purchase date. The warranty will provide veterinary care f' +
                'rom our veterinarians up to a $100.00 value per eye.\par'#13#10'\b\par' +
                #13#10'Canine Parvo Virus and Distemper. \b0 Must be diagnosed within' +
                ' 10 days of the purchase date. The warranty will provide veterin' +
                'ary care from our veterinarians up to the cost of the pet.\par'#13#10 +
                '\par'#13#10'\b Hypoglycemia. \b0 Must be diagnosed within 24 hours of ' +
                'the purchase date. The warranty will provide veterinary care fro' +
                'm our veterinarians up to the cost of the pet.\par'#13#10'\par'#13#10'\b Gen' +
                'eralized Demodicosis. \b0 Must be diagnosed by 1 year of age. Th' +
                'e warranty will provide veterinary care from our veterinarians u' +
                'p to a $400.00 value.\par'#13#10'\par'#13#10'\b Localized Demodicosis. \b0 M' +
                'ust be diagnosed by 1 year of age. The warranty will provide vet' +
                'erinary care from our veterinarians up to a $100.00 value.\par'#13#10 +
                '\par'#13#10'\b Sarcoptic Mange. \b0 Must be diagnosed within 6 weeks o' +
                'f the purchase date. The warranty will provide veterinary care f' +
                'rom our veterinarians up to $250.\par'#13#10'\par'#13#10'\b Monorchid/Crypto' +
                'rchid Dogs. \b0 The warranty will provide veterinary care from o' +
                'ur veterinarians for any additional amount above the normal cost' +
                ' of neutering. This condition must be noted by your veterinarian' +
                ' upon the pets'#39' initial exam.\par'#13#10'\par'#13#10'\b Hernia Repairs. \b0 ' +
                'The warranty will provide veterinary care from our veterinarians' +
                ' up to a $100.00 value. This condition must be noted by your vet' +
                'erinarian upon the pets'#39' initial exam.\par'#13#10'\par'#13#10'\b Luxating Pa' +
                'tellas/Carpal Laxity. \b0 Due to the many factors that can affec' +
                't this condition luxating patellas and carpal laxity must be dia' +
                'gnosed during the initial vet exam and reported within 5 days of' +
                ' purchase. This condition is not covered by the hereditary warra' +
                'nty.\par'#13#10'\par'#13#10'\b Angular Limb Deformities \b0 due to Premature' +
                ' Closure of the Distal Ulnar Physis are only considered heredita' +
                'ry in Skye Terriers. Therefore, this condition will not be eligi' +
                'ble for credit in any other breed.\par'#13#10'\par'#13#10'\b Brachycephalic ' +
                'Breeds: \b0 Any respiratory tree abnormalities are not covered b' +
                'y the warranty.\par'#13#10'\par'#13#10'\b Allergic reactions and anesthetic ' +
                'deaths are not covered under this warranty.\par'#13#10'\par'#13#10'Hereditar' +
                'y Defects. Must be diagnosed by 3 years of age. \b0 The warranty' +
                ' will provide a refund up to the purchase price for any heredita' +
                'ry or congenital defect(s) that affects the general health and d' +
                'aily activity of the pet. You must supply all supporting documen' +
                'tation from your veterinarian within 30 days of the date of diag' +
                'nosis. Should death occur resulting\par'#13#10'from a covered illness,' +
                ' the maximum benefit will be the purchaser'#39's cost of the pet. \p' +
                'ar'#13#10'\b\par'#13#10'We will not cover treatments for any other pets resu' +
                'lting from contact with your new pet. \b0 We recommend that you ' +
                'closely monitor your new pet and separate them from other animal' +
                's if there are any signs of disease or stress. This warranty doe' +
                's not cover common ailments such as fleas, ear mites, and/or par' +
                'asites. Internal and external parasites\par'#13#10'are easily treated ' +
                'and are very common in puppies. We make every effort to control ' +
                'parasites but it is not always possible to eradicate all of them' +
                '. It is the responsibility of the owner and their veterinarian t' +
                'o maintain an effective protocol for parasite control.\par'#13#10'\par' +
                #13#10'}'#13#10
              mmHeight = 245005
              mmLeft = 6085
              mmTop = 0
              mmWidth = 192352
              BandType = 1
              mmBottomOffset = 0
              mmOverFlowOffset = 0
              mmStopPosition = 0
            end
          end
          object ppDetailBand1: TppDetailBand
            mmBottomOffset = 0
            mmHeight = 12965
            mmPrintPosition = 0
            object ppLabel12: TppLabel
              UserName = 'Label12'
              Caption = 'Agent for XXXXXXXXX'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Times New Roman'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              mmHeight = 4233
              mmLeft = 9790
              mmTop = 1058
              mmWidth = 37306
              BandType = 4
            end
            object ppLabel13: TppLabel
              UserName = 'Label13'
              Caption = 'Customer Signature'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Times New Roman'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              mmHeight = 4233
              mmLeft = 10054
              mmTop = 8731
              mmWidth = 28310
              BandType = 4
            end
            object ppLabel14: TppLabel
              UserName = 'Label14'
              Caption = 'Date'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Times New Roman'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              mmHeight = 4233
              mmLeft = 143669
              mmTop = 1058
              mmWidth = 6615
              BandType = 4
            end
            object ppLabel15: TppLabel
              UserName = 'Label15'
              Caption = 'Date'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Times New Roman'
              Font.Size = 10
              Font.Style = []
              Transparent = True
              mmHeight = 4233
              mmLeft = 143669
              mmTop = 8731
              mmWidth = 6615
              BandType = 4
            end
            object ppLine4: TppLine
              UserName = 'Line1'
              Weight = 0.750000000000000000
              mmHeight = 529
              mmLeft = 47890
              mmTop = 4763
              mmWidth = 94721
              BandType = 4
            end
            object ppLine7: TppLine
              UserName = 'Line7'
              Weight = 0.750000000000000000
              mmHeight = 529
              mmLeft = 39158
              mmTop = 12435
              mmWidth = 103452
              BandType = 4
            end
            object ppLine8: TppLine
              UserName = 'Line8'
              Weight = 0.750000000000000000
              mmHeight = 265
              mmLeft = 151342
              mmTop = 4763
              mmWidth = 34131
              BandType = 4
            end
            object ppLine9: TppLine
              UserName = 'Line9'
              Weight = 0.750000000000000000
              mmHeight = 265
              mmLeft = 151342
              mmTop = 12435
              mmWidth = 34131
              BandType = 4
            end
            object ppDBText14: TppDBText
              UserName = 'DBText14'
              DataField = 'PetSaleDate'
              DataPipeline = ppDBPet
              DisplayFormat = 'mmmm d, yyyy'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 11
              Font.Style = []
              ParentDataPipeline = False
              Transparent = True
              DataPipelineName = 'ppDBPet'
              mmHeight = 4763
              mmLeft = 152400
              mmTop = 0
              mmWidth = 32279
              BandType = 4
            end
            object ppDBText15: TppDBText
              UserName = 'DBText15'
              DataField = 'PetSaleDate'
              DataPipeline = ppDBPet
              DisplayFormat = 'mmmm d, yyyy'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Arial'
              Font.Size = 11
              Font.Style = []
              ParentDataPipeline = False
              Transparent = True
              DataPipelineName = 'ppDBPet'
              mmHeight = 4763
              mmLeft = 152400
              mmTop = 7673
              mmWidth = 32279
              BandType = 4
            end
          end
          object ppSummaryBand1: TppSummaryBand
            mmBottomOffset = 0
            mmHeight = 0
            mmPrintPosition = 0
          end
          object raCodeModule1: TraCodeModule
            ProgramStream = {00}
          end
        end
      end
      object ppRegion1: TppRegion
        UserName = 'RegionPetInfo'
        Caption = 'RegionPetInfo'
        Pen.Style = psClear
        Stretch = True
        mmHeight = 57150
        mmLeft = 5556
        mmTop = 0
        mmWidth = 196586
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppShape: TppShape
          UserName = 'Shape'
          mmHeight = 55033
          mmLeft = 6350
          mmTop = 1323
          mmWidth = 193411
          BandType = 4
        end
        object ppLabel5: TppLabel
          UserName = 'Label5'
          Caption = 'Animal #:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 7673
          mmWidth = 14023
          BandType = 4
        end
        object ppDBText5: TppDBText
          UserName = 'DBText5'
          DataField = 'SKU'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 23548
          mmTop = 7673
          mmWidth = 61383
          BandType = 4
        end
        object ppLabel6: TppLabel
          UserName = 'Label6'
          Caption = 'Sex:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 86519
          mmTop = 7673
          mmWidth = 6085
          BandType = 4
        end
        object ppDBText6: TppDBText
          UserName = 'DBText6'
          DataField = 'Sex'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 93663
          mmTop = 7673
          mmWidth = 14023
          BandType = 4
        end
        object ppLabel7: TppLabel
          UserName = 'Label7'
          Caption = 'Breeder :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 13229
          mmWidth = 13229
          BandType = 4
        end
        object ppDBText7: TppDBText
          UserName = 'DBText7'
          DataField = 'Breeder'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 23283
          mmTop = 13229
          mmWidth = 61913
          BandType = 4
        end
        object ppLabel8: TppLabel
          UserName = 'Label8'
          Caption = 'Sire:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 18785
          mmWidth = 6615
          BandType = 4
        end
        object ppDBText1: TppDBText
          UserName = 'DBText1'
          DataField = 'Sire'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 23548
          mmTop = 18785
          mmWidth = 174625
          BandType = 4
        end
        object ppLabel9: TppLabel
          UserName = 'Label9'
          Caption = 'Dam:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 24077
          mmWidth = 7673
          BandType = 4
        end
        object ppDBText2: TppDBText
          UserName = 'DBText2'
          DataField = 'Dam'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 23548
          mmTop = 24077
          mmWidth = 174625
          BandType = 4
        end
        object ppLine1: TppLine
          UserName = 'Line1'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 6614
          mmTop = 6879
          mmWidth = 192882
          BandType = 4
        end
        object ppLine2: TppLine
          UserName = 'Line2'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 6614
          mmTop = 12435
          mmWidth = 192882
          BandType = 4
        end
        object ppLine: TppLine
          UserName = 'Line4'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 6614
          mmTop = 23283
          mmWidth = 192882
          BandType = 4
        end
        object ppLine5: TppLine
          UserName = 'Line5'
          Position = lpRight
          Weight = 0.750000000000000000
          mmHeight = 5821
          mmLeft = 84931
          mmTop = 6879
          mmWidth = 794
          BandType = 4
        end
        object ppLine6: TppLine
          UserName = 'Line6'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 6614
          mmTop = 28840
          mmWidth = 193146
          BandType = 4
        end
        object ppLabel10: TppLabel
          UserName = 'Label10'
          Caption = 'Michochip'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 29369
          mmWidth = 14288
          BandType = 4
        end
        object ppLabel11: TppLabel
          UserName = 'Label101'
          Caption = 'Registry'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 111654
          mmTop = 29369
          mmWidth = 11377
          BandType = 4
        end
        object ppLabel: TppLabel
          UserName = 'Label'
          Caption = 'Breed :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 2381
          mmWidth = 10319
          BandType = 4
        end
        object ppDBText: TppDBText
          UserName = 'DBText'
          DataField = 'Breed'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 23548
          mmTop = 2381
          mmWidth = 82286
          BandType = 4
        end
        object ppLabelw: TppLabel
          UserName = 'Labelw'
          Caption = 'Color :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 113771
          mmTop = 2381
          mmWidth = 9260
          BandType = 4
        end
        object ppDBTextw: TppDBText
          UserName = 'DBTextw'
          DataField = 'Color'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 123825
          mmTop = 2381
          mmWidth = 74348
          BandType = 4
        end
        object ppLinew: TppLine
          UserName = 'Linew'
          Position = lpRight
          Weight = 0.750000000000000000
          mmHeight = 11377
          mmLeft = 107950
          mmTop = 1323
          mmWidth = 794
          BandType = 4
        end
        object ppLine12: TppLine
          UserName = 'Line12'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 6085
          mmTop = 41804
          mmWidth = 193146
          BandType = 4
        end
        object ppLine13: TppLine
          UserName = 'Linew2'
          Position = lpRight
          Weight = 0.750000000000000000
          mmHeight = 17727
          mmLeft = 107950
          mmTop = 28840
          mmWidth = 794
          BandType = 4
        end
        object ppLabel21: TppLabel
          UserName = 'Label102'
          Caption = 'Name :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 42333
          mmWidth = 10319
          BandType = 4
        end
        object ppLabel22: TppLabel
          UserName = 'Label22'
          Caption = 'Address :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 47096
          mmWidth = 13494
          BandType = 4
        end
        object ppLine14: TppLine
          UserName = 'Line14'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 6350
          mmTop = 46567
          mmWidth = 193146
          BandType = 4
        end
        object ppLine15: TppLine
          UserName = 'Line15'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 6350
          mmTop = 51329
          mmWidth = 193146
          BandType = 4
        end
        object ppLabel23: TppLabel
          UserName = 'Label23'
          Caption = 'Phone :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 111919
          mmTop = 42333
          mmWidth = 11113
          BandType = 4
        end
        object ppLabel24: TppLabel
          UserName = 'Label24'
          Caption = 'Email :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3951
          mmLeft = 6879
          mmTop = 51858
          mmWidth = 9737
          BandType = 4
        end
        object ppLabel25: TppLabel
          UserName = 'Label25'
          Caption = 'Price :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 114036
          mmTop = 51858
          mmWidth = 8996
          BandType = 4
        end
        object ppLine16: TppLine
          UserName = 'Linew3'
          Position = lpRight
          Weight = 0.750000000000000000
          mmHeight = 4498
          mmLeft = 107950
          mmTop = 51329
          mmWidth = 794
          BandType = 4
        end
        object ppDBText16: TppDBText
          UserName = 'DBText4'
          DataField = 'WarrantyCustomerName'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 23548
          mmTop = 42333
          mmWidth = 82286
          BandType = 4
        end
        object ppDBText17: TppDBText
          UserName = 'DBText17'
          DataField = 'WCustomerEmail'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 23548
          mmTop = 51858
          mmWidth = 82286
          BandType = 4
        end
        object ppDBText18: TppDBText
          UserName = 'DBText18'
          DataField = 'WCustomerPhone'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 123825
          mmTop = 42333
          mmWidth = 74083
          BandType = 4
        end
        object ppVariable4: TppVariable
          UserName = 'Variable4'
          AutoSize = False
          CalcOrder = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3969
          mmLeft = 23548
          mmTop = 47096
          mmWidth = 174361
          BandType = 4
        end
        object ppVariable5: TppVariable
          UserName = 'Variable5'
          AutoSize = False
          CalcOrder = 2
          DataType = dtCurrency
          DisplayFormat = '#,0.00;-#,0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3969
          mmLeft = 123825
          mmTop = 51858
          mmWidth = 73554
          BandType = 4
        end
        object ppLine17: TppLine
          UserName = 'Line17'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 6350
          mmTop = 17727
          mmWidth = 192882
          BandType = 4
        end
        object ppLabel27: TppLabel
          UserName = 'Label27'
          Caption = 'Br Addr:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 85990
          mmTop = 13229
          mmWidth = 11906
          BandType = 4
        end
        object ppVariable6: TppVariable
          UserName = 'Variable6'
          AutoSize = False
          CalcOrder = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3969
          mmLeft = 98425
          mmTop = 13229
          mmWidth = 99219
          BandType = 4
        end
        object ppLabel29: TppLabel
          UserName = 'Label29'
          Caption = 'D.O.B.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3969
          mmLeft = 112713
          mmTop = 7673
          mmWidth = 10583
          BandType = 4
        end
        object ppDBText20: TppDBText
          UserName = 'DBText20'
          DataField = 'WhelpDate'
          DataPipeline = ppDBPet
          DisplayFormat = 'mm/dd/yyyy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 124090
          mmTop = 7673
          mmWidth = 73819
          BandType = 4
        end
      end
      object SubRepTreatment: TppSubReport
        UserName = 'SubRepTreatment'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        ShiftRelativeTo = ppRegion2
        TraverseAllData = False
        DataPipelineName = 'ppDBPetTreatment'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 92869
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport1: TppChildReport
          AutoStop = False
          DataPipeline = ppDBPetTreatment
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'Letter'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 279401
          PrinterSetup.mmPaperWidth = 215900
          PrinterSetup.PaperSize = 1
          Template.DatabaseSettings.DataPipeline = ppDBWarranty
          Template.DatabaseSettings.NameField = 'ReportName'
          Template.DatabaseSettings.TemplateField = 'Report'
          Template.SaveTo = stDatabase
          Version = '7.02'
          mmColumnWidth = 0
          DataPipelineName = 'ppDBPetTreatment'
          object ppHeaderBand1: TppHeaderBand
            mmBottomOffset = 0
            mmHeight = 265
            mmPrintPosition = 0
            object ppLine26: TppLine
              UserName = 'Line202'
              Weight = 0.750000000000000000
              mmHeight = 265
              mmLeft = 6350
              mmTop = 0
              mmWidth = 193675
              BandType = 0
            end
          end
          object ppDetailBand2: TppDetailBand
            mmBottomOffset = 0
            mmHeight = 3969
            mmPrintPosition = 0
            object ppDBText11: TppDBText
              UserName = 'DBText11'
              DataField = 'TreatmentDate'
              DataPipeline = ppDBPetTreatment
              DisplayFormat = 'mmmm d, yyyy'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppDBPetTreatment'
              mmHeight = 3440
              mmLeft = 7938
              mmTop = 265
              mmWidth = 29369
              BandType = 4
            end
            object ppVariable1: TppVariable
              UserName = 'Variable1'
              AutoSize = False
              CalcOrder = 0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              mmHeight = 3440
              mmLeft = 38365
              mmTop = 265
              mmWidth = 146844
              BandType = 4
            end
            object ppLine18: TppLine
              UserName = 'Line18'
              Position = lpLeft
              Weight = 0.750000000000000000
              mmHeight = 3969
              mmLeft = 6350
              mmTop = 0
              mmWidth = 1058
              BandType = 4
            end
            object ppLine19: TppLine
              UserName = 'Line19'
              Position = lpRight
              Weight = 0.750000000000000000
              mmHeight = 3969
              mmLeft = 198967
              mmTop = 0
              mmWidth = 1058
              BandType = 4
            end
          end
          object ppFooterBandTreat: TppFooterBand
            mmBottomOffset = 0
            mmHeight = 0
            mmPrintPosition = 0
          end
          object ppGroup: TppGroup
            BreakName = 'TreatmentType'
            DataPipeline = ppDBPetTreatment
            KeepTogether = True
            OutlineSettings.CreateNode = True
            UserName = 'Group'
            mmNewColumnThreshold = 0
            mmNewPageThreshold = 0
            DataPipelineName = 'ppDBPetTreatment'
            object ppGroupHeaderBand1: TppGroupHeaderBand
              mmBottomOffset = 0
              mmHeight = 3969
              mmPrintPosition = 0
              object ppDBText10: TppDBText
                UserName = 'DBText10'
                DataField = 'TreatmentTypeStr'
                DataPipeline = ppDBPetTreatment
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 9
                Font.Style = [fsItalic]
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDBPetTreatment'
                mmHeight = 3969
                mmLeft = 79111
                mmTop = 0
                mmWidth = 47361
                BandType = 3
                GroupNo = 0
              end
              object ppLine24: TppLine
                UserName = 'Line24'
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 3969
                mmLeft = 6350
                mmTop = 0
                mmWidth = 1058
                BandType = 3
                GroupNo = 0
              end
              object ppLine25: TppLine
                UserName = 'Line25'
                Position = lpRight
                Weight = 0.750000000000000000
                mmHeight = 3969
                mmLeft = 198967
                mmTop = 0
                mmWidth = 1058
                BandType = 3
                GroupNo = 0
              end
            end
            object ppGroupFooterBand1: TppGroupFooterBand
              mmBottomOffset = 0
              mmHeight = 265
              mmPrintPosition = 0
              object ppLine20: TppLine
                UserName = 'Line20'
                Weight = 0.750000000000000000
                mmHeight = 265
                mmLeft = 6350
                mmTop = 0
                mmWidth = 193675
                BandType = 5
                GroupNo = 0
              end
            end
          end
          object raCodeModule3: TraCodeModule
            ProgramStream = {
              01060F5472614576656E7448616E646C65720B50726F6772616D4E616D65060F
              5661726961626C65314F6E43616C630B50726F6772616D54797065070B747450
              726F63656475726506536F7572636506B270726F636564757265205661726961
              626C65314F6E43616C63287661722056616C75653A2056617269616E74293B0D
              0A626567696E0D0A0D0A202056616C7565203A3D202044425065745472656174
              6D656E745B2754726561746D656E74275D202B2027202D2027202B2020444250
              657454726561746D656E745B274C6F744E756D626572275D20202B2027202720
              2B2020444250657454726561746D656E745B274D6667275D3B0D0A0D0A656E64
              3B0D0A0D436F6D706F6E656E744E616D6506095661726961626C653109457665
              6E744E616D6506064F6E43616C63074576656E74494402210000}
          end
        end
      end
      object ppRegion2: TppRegion
        UserName = 'RegionPetMedical'
        Caption = 'RegionPetMedical'
        Pen.Style = psClear
        ShiftRelativeTo = ppSubRepTerms
        Stretch = True
        mmHeight = 30692
        mmLeft = 4233
        mmTop = 62177
        mmWidth = 197380
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppShape2: TppShape
          UserName = 'Shape2'
          mmHeight = 10848
          mmLeft = 6350
          mmTop = 80962
          mmWidth = 193675
          BandType = 4
        end
        object ppLabel3: TppLabel
          UserName = 'Label3'
          Caption = 'Medical History Report'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 14
          Font.Style = [fsUnderline]
          Transparent = True
          mmHeight = 5821
          mmLeft = 74348
          mmTop = 66939
          mmWidth = 51065
          BandType = 4
        end
        object ppLabel4: TppLabel
          UserName = 'Label4'
          Caption = 'Date of Report :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4763
          mmLeft = 72760
          mmTop = 73818
          mmWidth = 29898
          BandType = 4
        end
        object ppSystemVariable1: TppSystemVariable
          UserName = 'SystemVariable1'
          DisplayFormat = 'mmmm d, yyyy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 11
          Font.Style = []
          Transparent = True
          mmHeight = 4763
          mmLeft = 103187
          mmTop = 73818
          mmWidth = 23813
          BandType = 4
        end
        object ppLabel16: TppLabel
          UserName = 'Label11'
          Caption = 'Breed :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 81756
          mmWidth = 10319
          BandType = 4
        end
        object ppDBText3: TppDBText
          UserName = 'DBText3'
          DataField = 'Breed'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 23548
          mmTop = 81756
          mmWidth = 81756
          BandType = 4
        end
        object ppLabel18: TppLabel
          UserName = 'Label18'
          Caption = 'Animal #:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 6879
          mmTop = 87048
          mmWidth = 14023
          BandType = 4
        end
        object ppDBText8: TppDBText
          UserName = 'DBText8'
          DataField = 'SKU'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 23548
          mmTop = 87048
          mmWidth = 54769
          BandType = 4
        end
        object ppLine3: TppLine
          UserName = 'Line3'
          Weight = 0.750000000000000000
          mmHeight = 265
          mmLeft = 6350
          mmTop = 86254
          mmWidth = 193411
          BandType = 4
        end
        object ppLine10: TppLine
          UserName = 'Linew1'
          Position = lpRight
          Weight = 0.750000000000000000
          mmHeight = 10583
          mmLeft = 109273
          mmTop = 80962
          mmWidth = 794
          BandType = 4
        end
        object ppLabel17: TppLabel
          UserName = 'Labelw1'
          Caption = 'Color :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 113771
          mmTop = 81756
          mmWidth = 9260
          BandType = 4
        end
        object ppDBText4: TppDBText
          UserName = 'DBTextw1'
          DataField = 'Color'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 123825
          mmTop = 81756
          mmWidth = 70379
          BandType = 4
        end
        object ppDBText9: TppDBText
          UserName = 'DBText9'
          DataField = 'Sex'
          DataPipeline = ppDBPet
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 89165
          mmTop = 87048
          mmWidth = 17463
          BandType = 4
        end
        object ppLabel19: TppLabel
          UserName = 'Label19'
          Caption = 'Sex:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          Transparent = True
          mmHeight = 3969
          mmLeft = 82021
          mmTop = 87048
          mmWidth = 6085
          BandType = 4
        end
        object ppLine11: TppLine
          UserName = 'Line11'
          Position = lpRight
          Weight = 0.750000000000000000
          mmHeight = 5027
          mmLeft = 80168
          mmTop = 86519
          mmWidth = 794
          BandType = 4
        end
        object ppLabel28: TppLabel
          UserName = 'Label28'
          Caption = 'D.O.B.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 9
          Font.Style = [fsItalic]
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3951
          mmLeft = 112448
          mmTop = 87048
          mmWidth = 10583
          BandType = 4
        end
        object ppDBText19: TppDBText
          UserName = 'DBText19'
          DataField = 'WhelpDate'
          DataPipeline = ppDBPet
          DisplayFormat = 'mm/dd/yyyy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Verdana'
          Font.Size = 9
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppDBPet'
          mmHeight = 3969
          mmLeft = 123825
          mmTop = 87048
          mmWidth = 69850
          BandType = 4
        end
      end
      object ppSubRepMedical: TppSubReport
        UserName = 'SubRepMedical'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        ShiftRelativeTo = SubRepTreatment
        TraverseAllData = False
        DataPipelineName = 'ppDBPetMedical'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 98161
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport: TppChildReport
          AutoStop = False
          DataPipeline = ppDBPetMedical
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'Letter'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 279401
          PrinterSetup.mmPaperWidth = 215900
          PrinterSetup.PaperSize = 1
          Template.DatabaseSettings.DataPipeline = ppDBWarranty
          Template.DatabaseSettings.NameField = 'ReportName'
          Template.DatabaseSettings.TemplateField = 'Report'
          Template.SaveTo = stDatabase
          Version = '7.02'
          mmColumnWidth = 0
          DataPipelineName = 'ppDBPetMedical'
          object ppTitleBand4: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 5027
            mmPrintPosition = 0
            object ppShape4: TppShape
              UserName = 'Shape4'
              mmHeight = 5292
              mmLeft = 6350
              mmTop = 0
              mmWidth = 193675
              BandType = 1
            end
            object ppLabel20: TppLabel
              UserName = 'Label20'
              Caption = 'Medical Notes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 9
              Font.Style = [fsItalic]
              TextAlignment = taCentered
              Transparent = True
              mmHeight = 3969
              mmLeft = 88371
              mmTop = 529
              mmWidth = 26458
              BandType = 1
            end
          end
          object ppDetailBand3: TppDetailBand
            mmBottomOffset = 0
            mmHeight = 3969
            mmPrintPosition = 0
            object ppDBText12: TppDBText
              UserName = 'DBText12'
              DataField = 'RecordDate'
              DataPipeline = ppDBPetMedical
              DisplayFormat = 'mmmm d, yyyy'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppDBPetMedical'
              mmHeight = 3387
              mmLeft = 8467
              mmTop = 265
              mmWidth = 28840
              BandType = 4
            end
            object ppVariable2: TppVariable
              UserName = 'Variable2'
              AutoSize = False
              CalcOrder = 0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              mmHeight = 3440
              mmLeft = 38100
              mmTop = 265
              mmWidth = 160338
              BandType = 4
            end
            object ppLine21: TppLine
              UserName = 'Line21'
              Position = lpLeft
              Weight = 0.750000000000000000
              mmHeight = 3969
              mmLeft = 6350
              mmTop = 0
              mmWidth = 1058
              BandType = 4
            end
            object ppLine22: TppLine
              UserName = 'Line22'
              Position = lpRight
              Weight = 0.750000000000000000
              mmHeight = 3969
              mmLeft = 198967
              mmTop = 0
              mmWidth = 1058
              BandType = 4
            end
          end
          object ppSummaryBand3: TppSummaryBand
            mmBottomOffset = 0
            mmHeight = 265
            mmPrintPosition = 0
            object ppLine23: TppLine
              UserName = 'Line201'
              Weight = 0.750000000000000000
              mmHeight = 265
              mmLeft = 6350
              mmTop = 0
              mmWidth = 193675
              BandType = 7
            end
          end
          object raCodeModule4: TraCodeModule
            ProgramStream = {
              01060F5472614576656E7448616E646C65720B50726F6772616D4E616D65060F
              5661726961626C65324F6E43616C630B50726F6772616D54797065070B747450
              726F63656475726506536F75726365069C70726F636564757265205661726961
              626C65324F6E43616C63287661722056616C75653A2056617269616E74293B0D
              0A626567696E0D0A0D0A202056616C7565203A3D2044425065744D6564696361
              6C5B274D65646963616C436F6E646974696F6E275D202B2027202027202B2044
              425065744D65646963616C5B275375624D65646963616C436F6E646974696F6E
              275D3B0D0A0D0A656E643B0D0A0D436F6D706F6E656E744E616D650609566172
              6961626C6532094576656E744E616D6506064F6E43616C63074576656E744944
              02210000}
          end
        end
      end
      object ppRegion3: TppRegion
        UserName = 'RegionMicrochip'
        Pen.Style = psClear
        Stretch = True
        mmHeight = 12435
        mmLeft = 23283
        mmTop = 29369
        mmWidth = 84667
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppSubRepMicrochip: TppSubReport
          UserName = 'SubRepMicrochip'
          ExpandAll = False
          NewPrintJob = False
          OutlineSettings.CreateNode = True
          TraverseAllData = False
          DataPipelineName = 'ppDBMicrochip'
          mmHeight = 5027
          mmLeft = 23283
          mmTop = 30163
          mmWidth = 84667
          BandType = 4
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          object ppChildReport2: TppChildReport
            AutoStop = False
            DataPipeline = ppDBMicrochip
            PrinterSetup.BinName = 'Default'
            PrinterSetup.DocumentName = 'Report'
            PrinterSetup.PaperName = 'Letter'
            PrinterSetup.PrinterName = 'Default'
            PrinterSetup.mmMarginBottom = 6350
            PrinterSetup.mmMarginLeft = 6350
            PrinterSetup.mmMarginRight = 6350
            PrinterSetup.mmMarginTop = 6350
            PrinterSetup.mmPaperHeight = 279401
            PrinterSetup.mmPaperWidth = 215900
            PrinterSetup.PaperSize = 1
            Template.DatabaseSettings.DataPipeline = ppDBWarranty
            Template.DatabaseSettings.NameField = 'ReportName'
            Template.DatabaseSettings.TemplateField = 'Report'
            Template.SaveTo = stDatabase
            Version = '7.02'
            mmColumnWidth = 0
            DataPipelineName = 'ppDBMicrochip'
            object ppTitleBand5: TppTitleBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppDetailBand4: TppDetailBand
              mmBottomOffset = 0
              mmHeight = 3704
              mmPrintPosition = 0
              object ppDBText13: TppDBText
                UserName = 'DBText13'
                DataField = 'MicrochipNum'
                DataPipeline = ppDBMicrochip
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 9
                Font.Style = [fsBold]
                Transparent = True
                DataPipelineName = 'ppDBMicrochip'
                mmHeight = 3951
                mmLeft = 6350
                mmTop = 0
                mmWidth = 41275
                BandType = 4
              end
            end
            object ppSummaryBand4: TppSummaryBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object raCodeModule6: TraCodeModule
              ProgramStream = {00}
            end
          end
        end
      end
      object ppRegion4: TppRegion
        UserName = 'RegionRegistry'
        Pen.Style = psClear
        Stretch = True
        mmHeight = 12435
        mmLeft = 123561
        mmTop = 29369
        mmWidth = 74877
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppSubRepRegistry: TppSubReport
          UserName = 'SubRepRegistry'
          ExpandAll = False
          NewPrintJob = False
          OutlineSettings.CreateNode = True
          TraverseAllData = False
          DataPipelineName = 'ppDBRegistry'
          mmHeight = 5027
          mmLeft = 123561
          mmTop = 30163
          mmWidth = 74877
          BandType = 4
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          object ppChildReport3: TppChildReport
            AutoStop = False
            DataPipeline = ppDBRegistry
            PrinterSetup.BinName = 'Default'
            PrinterSetup.DocumentName = 'Report'
            PrinterSetup.PaperName = 'Letter'
            PrinterSetup.PrinterName = 'Default'
            PrinterSetup.mmMarginBottom = 6350
            PrinterSetup.mmMarginLeft = 6350
            PrinterSetup.mmMarginRight = 6350
            PrinterSetup.mmMarginTop = 6350
            PrinterSetup.mmPaperHeight = 279401
            PrinterSetup.mmPaperWidth = 215900
            PrinterSetup.PaperSize = 1
            Template.DatabaseSettings.DataPipeline = ppDBWarranty
            Template.DatabaseSettings.NameField = 'ReportName'
            Template.DatabaseSettings.TemplateField = 'Report'
            Template.SaveTo = stDatabase
            Version = '7.02'
            mmColumnWidth = 0
            DataPipelineName = 'ppDBRegistry'
            object ppTitleBand6: TppTitleBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppDetailBand5: TppDetailBand
              mmBottomOffset = 0
              mmHeight = 3704
              mmPrintPosition = 0
              object ppVariable3: TppVariable
                UserName = 'Variable3'
                CalcOrder = 0
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 9
                Font.Style = [fsBold]
                Transparent = True
                mmHeight = 3951
                mmLeft = 6350
                mmTop = 0
                mmWidth = 15804
                BandType = 4
              end
            end
            object ppSummaryBand5: TppSummaryBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object raCodeModule5: TraCodeModule
              ProgramStream = {
                01060F5472614576656E7448616E646C65720B50726F6772616D4E616D65060F
                5661726961626C65334F6E43616C630B50726F6772616D54797065070B747450
                726F63656475726506536F75726365068B70726F636564757265205661726961
                626C65334F6E43616C63287661722056616C75653A2056617269616E74293B0D
                0A626567696E0D0A0D0A202056616C7565203A3D20444252656769737472795B
                275265676973747279275D202B20272027202B20444252656769737472795B27
                526567697374726174696F6E4E756D275D3B0D0A0D0A656E643B0D0A0D436F6D
                706F6E656E744E616D6506095661726961626C6533094576656E744E616D6506
                064F6E43616C63074576656E74494402210000}
            end
          end
        end
      end
    end
    object ppFooterBand: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 4498
      mmPrintPosition = 0
      object ppLabel26: TppLabel
        UserName = 'Label26'
        Caption = 
          'XXXXXXXXX '#183' 0000 Street '#183' State, SateCode Zip '#183' (000) 000-0000 '#183 +
          ' Fax: (000) 000-0000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3440
        mmLeft = 45773
        mmTop = 529
        mmWidth = 111654
        BandType = 8
      end
    end
    object raCodeModule2: TraCodeModule
      ProgramStream = {
        01060F5472614576656E7448616E646C65720B50726F6772616D4E616D65060F
        5661726961626C65344F6E43616C630B50726F6772616D54797065070B747450
        726F63656475726506536F757263650C1E01000070726F636564757265205661
        726961626C65344F6E43616C63287661722056616C75653A2056617269616E74
        293B0D0A626567696E0D0A0D0A202056616C7565203A3D2044425065745B2757
        437573746F6D657241646472657373275D202B20272027202B2044425065745B
        2757437573746F6D657243697479275D3B0D0A0D0A202069662044425065745B
        2757437573746F6D657253746174654944275D203C3E202727207468656E0D0A
        20200956616C7565203A3D2056616C7565202B20272C2027202B204442506574
        5B2757437573746F6D657253746174654944275D3B0D0A20200D0A202056616C
        7565203A3D2056616C7565202B20272027202B2044425065745B275743757374
        6F6D65725A6970275D3B0D0A656E643B0D0A0D436F6D706F6E656E744E616D65
        06095661726961626C6534094576656E744E616D6506064F6E43616C63074576
        656E74494402210001060F5472614576656E7448616E646C65720B50726F6772
        616D4E616D65060F5661726961626C65354F6E43616C630B50726F6772616D54
        797065070B747450726F63656475726506536F75726365067F70726F63656475
        7265205661726961626C65354F6E43616C63287661722056616C75653A205661
        7269616E74293B0D0A626567696E0D0A0D0A202056616C7565203A3D20204442
        5065745B2750657453616C65536F6C64275D202D2044425065745B2750657453
        616C65446973636F756E74275D3B0D0A0D0A656E643B0D0A0D436F6D706F6E65
        6E744E616D6506095661726961626C6535094576656E744E616D6506064F6E43
        616C63074576656E74494402210001060F5472614576656E7448616E646C6572
        0B50726F6772616D4E616D65060F5661726961626C65364F6E43616C630B5072
        6F6772616D54797065070B747450726F63656475726506536F7572636506A070
        726F636564757265205661726961626C65364F6E43616C63287661722056616C
        75653A2056617269616E74293B0D0A626567696E0D0A0D0A202056616C756520
        3A3D2044425065745B274272656564657243697479275D202B20272027202B20
        2044425065745B274272656564657253746174654944275D202B20272027202B
        2044425065745B27427265656465725A6970275D3B0D0A0D0A656E643B0D0A0D
        436F6D706F6E656E744E616D6506095661726961626C6536094576656E744E61
        6D6506064F6E43616C63074576656E74494402210000}
    end
    object ppParameterList1: TppParameterList
    end
  end
end
