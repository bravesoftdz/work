inherited PctPetFch: TPctPetFch
  Left = 218
  Top = 0
  Caption = 'PctPetFch'
  ClientHeight = 568
  ClientWidth = 518
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object scStore: TmrDBSuperCombo [0]
    Left = 332
    Top = 60
    Width = 154
    Height = 21
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
    TabOrder = 2
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ProviderListName = 'dspLuStore'
    EditLabel.Width = 36
    EditLabel.Height = 13
    EditLabel.Caption = 'Store : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDStore'
  end
  object scColor: TmrDBSuperCombo [1]
    Left = 332
    Top = 86
    Width = 154
    Height = 21
    Properties.ListColumns = <>
    Properties.ListOptions.ShowHeader = False
    Properties.ReadOnly = False
    Properties.Buttons = <
      item
        Default = True
      end
      item
        Kind = bkEllipsis
      end
      item
        Kind = bkGlyph
        Visible = False
      end>
    TabOrder = 4
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ConnectionSourceName = 'PetCenterConn'
    ProviderListName = 'dspLuPetColor'
    ProviderSourceName = 'dspPetColor'
    FchClassName = 'TPctColorFch'
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Color : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDColor'
  end
  object edtSugg: TmrDBCurrencyEdit [2]
    Left = 332
    Top = 295
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'MSRP'
    Properties.DisplayFormat = '0.00;-0.00'
    Properties.ReadOnly = False
    TabOrder = 18
    Visible = False
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'MSRP :'
    EditLabel.Layout = tlCenter
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtPromo: TmrDBCurrencyEdit [3]
    Left = 332
    Top = 270
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'PromoPrice'
    Properties.DisplayFormat = '0.00;-0.00'
    Properties.ReadOnly = False
    TabOrder = 16
    EditLabel.Width = 60
    EditLabel.Height = 13
    EditLabel.Caption = 'PromoPrice :'
    EditLabel.Layout = tlCenter
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtSale: TmrDBCurrencyEdit [4]
    Left = 79
    Top = 295
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'SalePrice'
    Properties.DisplayFormat = '0.00;-0.00'
    Properties.ReadOnly = False
    TabOrder = 17
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.Caption = 'SalePrice :'
    EditLabel.Layout = tlCenter
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object pgPetInfo: TPageControl [5]
    Left = 78
    Top = 359
    Width = 406
    Height = 173
    ActivePage = tsRegistry
    Images = DMPet.imgSmall
    Style = tsButtons
    TabOrder = 20
    OnChange = pgPetInfoChange
    object tsRegistry: TTabSheet
      Caption = 'Registry'
      ImageIndex = -1
      object slpRegistry: TmrSubListPanel
        Left = 0
        Top = 0
        Width = 398
        Height = 142
        Align = alClient
        BevelOuter = bvNone
        Caption = 'TPctPetRegistrySubList'
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TPctPetRegistrySubList'
        OnGetFilter = slpRegistryGetFilter
        OnStateChange = slpRegistryStateChange
        OnGetTransaction = slpRegistryGetTransaction
        OnGetForeignKeyValue = slpRegistryGetForeignKeyValue
      end
    end
    object tsMicrochip: TTabSheet
      Caption = 'Microchip'
      ImageIndex = -1
      object slpMicrochip: TmrSubListPanel
        Left = 0
        Top = 0
        Width = 398
        Height = 141
        Align = alClient
        BevelOuter = bvNone
        Caption = 'TPctPetMicrochipSubList'
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TPctPetMicrochipSubList'
        OnGetFilter = slpMicrochipGetFilter
        OnStateChange = slpMicrochipStateChange
        OnGetTransaction = slpMicrochipGetTransaction
        OnGetForeignKeyValue = slpMicrochipGetForeignKeyValue
      end
    end
    object tsWeight: TTabSheet
      Caption = 'Weight'
      ImageIndex = -1
      object slpWeight: TmrSubListPanel
        Left = 0
        Top = 0
        Width = 398
        Height = 141
        Align = alClient
        BevelOuter = bvNone
        Caption = 'TPctPetWeightSubList'
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TPctPetWeightSubList'
        OnGetFilter = slpWeightGetFilter
        OnStateChange = slpWeightStateChange
        OnGetTransaction = slpWeightGetTransaction
        OnGetForeignKeyValue = slpWeightGetForeignKeyValue
      end
    end
    object tsTreatment: TTabSheet
      Caption = 'Treatment'
      ImageIndex = -1
      object slpTreatment: TmrSubListPanel
        Left = 0
        Top = 0
        Width = 398
        Height = 141
        Align = alClient
        BevelOuter = bvNone
        Caption = 'TPctPetTreatmentSubList'
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TPctPetTreatmentSubList'
        OnGetFilter = slpTreatmentGetFilter
        OnStateChange = slpTreatmentStateChange
        OnGetTransaction = slpTreatmentGetTransaction
        OnGetForeignKeyValue = slpTreatmentGetForeignKeyValue
      end
    end
    object tsMedicalCondition: TTabSheet
      Caption = 'Medical Condition'
      ImageIndex = -1
      object slpMedicalCon: TmrSubListPanel
        Left = 0
        Top = 0
        Width = 398
        Height = 141
        Align = alClient
        BevelOuter = bvNone
        Caption = 'TPctPetMedicalConditionSubList'
        Color = clBtnShadow
        TabOrder = 0
        SubListClassName = 'TPctPetMedicalConditionSubList'
        OnGetFilter = slpMedicalConGetFilter
        OnStateChange = slpMedicalConStateChange
        OnGetTransaction = slpMedicalConGetTransaction
        OnGetForeignKeyValue = slpMedicalConGetForeignKeyValue
      end
    end
  end
  object memNotes: TmrDBMemo [6]
    Left = 79
    Top = 319
    Width = 405
    Height = 34
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Notes'
    Properties.ReadOnly = False
    TabOrder = 19
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'Notes :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtPurchaseDate: TmrDBDateEdit [7]
    Left = 332
    Top = 193
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'PurchaseDate'
    Properties.ReadOnly = False
    TabOrder = 12
    EditLabel.Width = 77
    EditLabel.Height = 13
    EditLabel.Caption = 'Purchase Date :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtWhelpDate: TmrDBDateEdit [8]
    Left = 79
    Top = 195
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'WhelpDate'
    Properties.ReadOnly = False
    TabOrder = 11
    EditLabel.Width = 63
    EditLabel.Height = 13
    EditLabel.Caption = 'Whelp Date :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtUSDA: TmrDBEdit [9]
    Left = 332
    Top = 139
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'USDA'
    Properties.ReadOnly = False
    Style.Color = clWindow
    TabOrder = 8
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'USDA :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtPenNum: TmrDBEdit [10]
    Left = 79
    Top = 167
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'PenNum'
    Properties.ReadOnly = False
    Style.Color = clWindow
    TabOrder = 9
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'PenNum :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtCost: TmrDBCurrencyEdit [11]
    Left = 79
    Top = 270
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'VendorCost'
    Properties.DisplayFormat = '0.00;-0.00'
    Properties.ReadOnly = False
    TabOrder = 15
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = 'Cost :'
    EditLabel.Layout = tlCenter
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object scBreed: TmrDBSuperCombo [12]
    Left = 79
    Top = 112
    Width = 154
    Height = 21
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
    TabOrder = 5
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ConnectionSourceName = 'PetCenterConn'
    ProviderListName = 'dspLuPetBreed'
    ProviderSourceName = 'dspBreed'
    FchClassName = 'TPctBreedFch'
    EditLabel.Width = 38
    EditLabel.Height = 13
    EditLabel.Caption = 'Breed : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDBreed'
  end
  object edtSKU: TmrDBEdit [13]
    Left = 79
    Top = 60
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'SKU'
    Properties.ReadOnly = False
    Style.Color = 15532031
    TabOrder = 0
    OnKeyPress = edtSKUKeyPress
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'SKU :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object scPetSatus: TmrDBSuperCombo [14]
    Left = 332
    Top = 35
    Width = 154
    Height = 21
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
    TabOrder = 1
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ProviderListName = 'dspLuPetStatus'
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'Status : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDStatus'
  end
  object scBreeder: TmrDBSuperCombo [15]
    Left = 79
    Top = 139
    Width = 154
    Height = 21
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
    TabOrder = 7
    OnBeforeGetRecordsList = scBreederBeforeGetRecordsList
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ConnectionSourceName = 'MaintenanceConn'
    ProviderListName = 'dspManufacture'
    ProviderSourceName = 'dspPessoa'
    FchClassName = 'TMntEntityFch'
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Breeder : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDBreeder'
  end
  object edtCollar: TmrDBEdit [16]
    Left = 332
    Top = 166
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Collar'
    Properties.ReadOnly = False
    Style.Color = clWindow
    TabOrder = 10
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'Collar :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object cbxSex: TmrDBImageComboBox [17]
    Left = 332
    Top = 112
    Width = 153
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Sex'
    Properties.Items = <
      item
        Description = 'Male'
        Value = 'M'
      end
      item
        Description = 'Female'
        Value = 'F'
      end
      item
        Description = 'Unknown'
        Value = 'U'
      end>
    Properties.ReadOnly = False
    TabOrder = 6
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Sex : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
  end
  object edtSire: TmrDBEdit [18]
    Left = 79
    Top = 220
    Width = 406
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Sire'
    Properties.ReadOnly = False
    Style.Color = clWindow
    TabOrder = 13
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Sire :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtDam: TmrDBEdit [19]
    Left = 79
    Top = 245
    Width = 406
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Dam'
    Properties.ReadOnly = False
    Style.Color = clWindow
    TabOrder = 14
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Dam :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object scSpecies: TmrDBSuperCombo [20]
    Left = 79
    Top = 86
    Width = 154
    Height = 21
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
    TabOrder = 3
    DisableButtons = False
    ConnectionListName = 'LookUpPetConn'
    ConnectionSourceName = 'PetCenterConn'
    ProviderListName = 'dspLuPetSpecies'
    ProviderSourceName = 'dspSpecies'
    FchClassName = 'TPctSpeciesFch'
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Species : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDSpecies'
  end
  inherited pnlBottom: TPanel
    Top = 540
    Width = 518
    TabOrder = 22
    inherited btnOk: TXiButton
      Left = 363
    end
    inherited btnCancel: TXiButton
      Left = 441
    end
  end
  inherited pnlTitulo: TPanel
    Width = 518
    TabOrder = 21
    inherited lbLoop: TLabel
      Left = 463
    end
    inherited btnLoop: TXiButton
      Left = 490
    end
  end
  inherited dsFch: TDataSource
    OnDataChange = dsFchDataChange
    Left = 84
    Top = 0
  end
  inherited PrintFch: TPrintDialog
    Left = 136
    Top = 4
  end
  inherited ConfigFch: TmrConfigFch
    OnAfterAppend = ConfigFchAfterAppend
    OnAfterNavigation = ConfigFchAfterNavigation
    OnBeforeApplyChanges = ConfigFchBeforeApplyChanges
    Left = 24
    Top = 4
  end
end
