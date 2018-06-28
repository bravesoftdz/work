inherited PctPetSaleFrm: TPctPetSaleFrm
  Left = 161
  Top = 226
  Caption = 'Pet Sale'
  ClientHeight = 370
  ClientWidth = 486
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 21
    Top = 162
    Width = 44
    Height = 13
    Caption = 'Microchip'
  end
  object Bevel1: TBevel [1]
    Left = 72
    Top = 168
    Width = 395
    Height = 7
    Shape = bsTopLine
  end
  object Bevel2: TBevel [2]
    Left = 74
    Top = 296
    Width = 395
    Height = 7
    Shape = bsTopLine
  end
  object Label2: TLabel [3]
    Left = 23
    Top = 290
    Width = 46
    Height = 13
    Caption = 'Warranty'
  end
  object lbMAddress: TLabel [4]
    Left = 250
    Top = 119
    Width = 218
    Height = 25
    AutoSize = False
    WordWrap = True
  end
  object lbWAddress: TLabel [5]
    Left = 250
    Top = 312
    Width = 218
    Height = 25
    AutoSize = False
    WordWrap = True
  end
  object lbEmail: TLabel [6]
    Left = 76
    Top = 148
    Width = 393
    Height = 13
    AutoSize = False
  end
  inherited pnlBottom: TPanel
    Top = 342
    Width = 486
    TabOrder = 7
    inherited btnOk: TXiButton
      Left = 331
    end
    inherited btnCancel: TXiButton
      Left = 409
    end
  end
  object scPet: TmrDBSuperCombo
    Left = 75
    Top = 49
    Width = 147
    Height = 21
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.OnEditValueChanged = scPetPropertiesEditValueChanged
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end
      item
        Glyph.Data = {
          EE010000424DEE0100000000000036000000280000000D0000000B0000000100
          180000000000B801000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF203040FF00FFFF00FFFF00
          FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3050604078C0
          304860FF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF30
          50703080D04098E050B0F0506870FF00FF00FF00FFFF00FFFF00FFFF00FF7068
          6060686050586040709040A0E060C8FF7090A0FF00FFFF00FF00FF00FFFF00FF
          909090B0A8A0D0C0B0D0B0A08078705058506090B07098B0FF00FFFF00FFFF00
          FF00FF00FFB0B0B0C0B8B0FFF0E0FFE8E0F0D8C0F0D0B0807870949298FF00FF
          FF00FFFF00FFFF00FF00FF00FFA09890F0E8E0FFF8F0FFF0F0FFE8E0F0D8D0D0
          B0A0606861FF00FFFF00FFFF00FFFF00FF00FF00FFA0A090F0E8E0FFFFFFFFF8
          F0FFF0F0FFE8E0E0C0B06E6F6FFF00FFFF00FFFF00FFFF00FF00FF00FFC0C8C0
          C0C0C0FFFFFFFFFFFFFFF8F0FFF0E0B0A0909C9EA0FF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FFC0B8B0C0C0C0F0E8E0F0E8E0B0B0A0707060FF00FFFF00FF
          FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFC0C8C0A0A090909080909090FF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
        Kind = bkGlyph
      end>
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 0
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ConnectionSourceName = 'PetCenterConn'
    ProviderListName = 'dspLuPet'
    ProviderSourceName = 'dspPet'
    FchClassName = 'TPctPetFch'
    SchClassName = 'TPctPetSearch'
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'SKU :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsPetSale
    DataBinding.DataField = 'IDPet'
  end
  object scSystemUser: TmrDBSuperCombo
    Left = 75
    Top = 16
    Width = 147
    Height = 21
    TabStop = False
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end>
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 1
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ProviderListName = 'dspLuSystemUser'
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'User : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsPetSale
    DataBinding.DataField = 'IDUser'
  end
  object edtRecordDate: TmrDBDateEdit
    Left = 75
    Top = 81
    Width = 148
    Height = 21
    DataBinding.DataSource = dsPetSale
    DataBinding.DataField = 'SaleDate'
    Properties.ReadOnly = False
    Properties.ShowTime = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 3
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = 'Sale Date :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object edtSale: TmrDBCurrencyEdit
    Left = 322
    Top = 49
    Width = 145
    Height = 21
    DataBinding.DataSource = dsPetSale
    DataBinding.DataField = 'SalePrice'
    Properties.DisplayFormat = '0.00;-0.00'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 2
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'Price :'
    EditLabel.Layout = tlCenter
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object scCustomerPurchase: TmrDBSuperCombo
    Left = 75
    Top = 116
    Width = 148
    Height = 21
    ParentShowHint = False
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.OnEditValueChanged = scCustomerPurchasePropertiesEditValueChanged
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end>
    ShowHint = True
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 5
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ConnectionSourceName = 'MaintenanceConn'
    ProviderListName = 'dspLuCustomer'
    ProviderSourceName = 'dspPessoa'
    FchClassName = 'TMntEntityFch'
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Customer : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <
      item
        LookUp = scCustomerWarranty
      end>
    DataBinding.DataSource = dsPetSale
    DataBinding.DataField = 'IDPessoa'
  end
  object scCustomerWarranty: TmrDBSuperCombo
    Left = 75
    Top = 309
    Width = 154
    Height = 21
    ParentShowHint = False
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.OnEditValueChanged = scCustomerWarrantyPropertiesEditValueChanged
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end>
    ShowHint = True
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 6
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ConnectionSourceName = 'MaintenanceConn'
    ProviderListName = 'dspLuCustomer'
    ProviderSourceName = 'dspPessoa'
    FchClassName = 'TMntEntityFch'
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Customer : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <
      item
        LookUp = scCustomerPurchase
      end>
    DataBinding.DataSource = dsPetSale
    DataBinding.DataField = 'IDWarrantyCustomer'
  end
  object scPetSatus: TmrDBSuperCombo
    Left = 322
    Top = 17
    Width = 146
    Height = 21
    TabStop = False
    ParentColor = True
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = True
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end>
    Style.Color = clBtnFace
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 8
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ProviderListName = 'dspLuPetStatus'
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'Status : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = True
    DependentLookUps = <>
    DataBinding.DataSource = dsPetSale
    DataBinding.DataField = 'IDStatus'
  end
  object pnlMicrochips: TPanel
    Left = 75
    Top = 175
    Width = 392
    Height = 107
    BevelOuter = bvNone
    TabOrder = 9
    object grdMicrochip: TcxGrid
      Left = 0
      Top = 0
      Width = 392
      Height = 107
      Align = alClient
      TabOrder = 0
      object grdMicrochipDBTableView: TcxGridDBTableView
        DataController.DataSource = dsMicrochipSale
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDPet; IDMicrochip'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        object grdMicrochipDBTableViewMarked: TcxGridDBColumn
          DataBinding.FieldName = 'Marked'
          Options.Filtering = False
          Width = 43
        end
        object grdMicrochipDBTableViewMicrochip: TcxGridDBColumn
          Caption = 'Microchip enrollment'
          DataBinding.FieldName = 'Microchip'
          Options.Editing = False
          Options.Filtering = False
          Width = 136
        end
        object grdMicrochipDBTableViewMicrochipNum: TcxGridDBColumn
          Caption = 'Microchip number'
          DataBinding.FieldName = 'MicrochipNum'
          Options.Editing = False
          Options.Filtering = False
          Width = 126
        end
        object grdMicrochipDBTableViewAmount: TcxGridDBColumn
          DataBinding.FieldName = 'Amount'
          Options.Editing = False
          Options.Filtering = False
          Width = 85
        end
      end
      object grdMicrochipLevel: TcxGridLevel
        GridView = grdMicrochipDBTableView
      end
    end
  end
  object edtInvoiceTotal: TmrDBCurrencyEdit
    Left = 322
    Top = 80
    Width = 145
    Height = 21
    DataBinding.DataSource = dsPetSale
    DataBinding.DataField = 'InvoiceTotal'
    Properties.DisplayFormat = '0.00;-0.00'
    Properties.ReadOnly = False
    Style.StyleController = DMPetCenter.cxStyleController
    TabOrder = 4
    EditLabel.Width = 69
    EditLabel.Height = 13
    EditLabel.Caption = 'Invoice Total :'
    EditLabel.Layout = tlCenter
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object cdsPetSale: TClientDataSet
    Aggregates = <>
    Params = <>
    OnNewRecord = cdsPetSaleNewRecord
    Left = 12
    Top = 8
    object cdsPetSaleIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object cdsPetSaleIDStatus: TIntegerField
      FieldName = 'IDStatus'
    end
    object cdsPetSaleStoreID: TIntegerField
      FieldName = 'StoreID'
    end
    object cdsPetSaleModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object cdsPetSaleIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object cdsPetSaleIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsPetSaleIDWarrantyCustomer: TIntegerField
      FieldName = 'IDWarrantyCustomer'
    end
    object cdsPetSaleCostPrice: TCurrencyField
      FieldName = 'CostPrice'
    end
    object cdsPetSaleSalePrice: TCurrencyField
      FieldName = 'SalePrice'
      Required = True
    end
    object cdsPetSaleDiscount: TCurrencyField
      FieldName = 'Discount'
    end
    object cdsPetSaleSaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
    object cdsPetSaleInvoiceTotal: TCurrencyField
      FieldName = 'InvoiceTotal'
    end
  end
  object dsPetSale: TDataSource
    DataSet = cdsPetSale
    Left = 28
    Top = 8
  end
  object cdsMicrochipSale: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPetMicrochip'
    RemoteServer = DMPet.PetCenterConn
    BeforeGetRecords = cdsMicrochipSaleBeforeGetRecords
    Left = 384
    Top = 8
    object cdsMicrochipSaleIDPet: TIntegerField
      FieldName = 'IDPet'
    end
    object cdsMicrochipSaleIDMicrochip: TIntegerField
      FieldName = 'IDMicrochip'
    end
    object cdsMicrochipSaleMicrochip: TStringField
      FieldName = 'Microchip'
      Size = 50
    end
    object cdsMicrochipSaleMicrochipNum: TStringField
      FieldName = 'MicrochipNum'
    end
    object cdsMicrochipSaleAmount: TBCDField
      FieldName = 'Amount'
      DisplayFormat = '#,##0.00'
    end
    object cdsMicrochipSaleMarked: TBooleanField
      FieldName = 'Marked'
    end
    object cdsMicrochipSaleIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  object cdsRegistrySale: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 284
    Top = 8
    object cdsRegistrySaleMarked: TBooleanField
      FieldName = 'Marked'
    end
    object cdsRegistrySaleIDRegistry: TIntegerField
      FieldName = 'IDRegistry'
    end
    object cdsRegistrySaleRegistry: TStringField
      FieldName = 'Registry'
      Size = 50
    end
    object cdsRegistrySaleRegistrationNum: TStringField
      FieldName = 'RegistrationNum'
      Size = 50
    end
  end
  object dsMicrochipSale: TDataSource
    DataSet = cdsMicrochipSale
    Left = 388
    Top = 12
  end
end
