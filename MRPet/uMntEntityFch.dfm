inherited MntEntityFch: TMntEntityFch
  Caption = 'Entity'
  ClientHeight = 387
  ClientWidth = 494
  PixelsPerInch = 96
  TextHeight = 13
  object edtFax: TmrDBEdit [0]
    Left = 319
    Top = 168
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Fax'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 12
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Fax :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtCel: TmrDBEdit [1]
    Left = 319
    Top = 142
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Cellular'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 11
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Cell :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtPhone: TmrDBEdit [2]
    Left = 319
    Top = 117
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Telefone'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 10
    EditLabel.Width = 37
    EditLabel.Height = 13
    EditLabel.Caption = 'Phone :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object chkCompany: TmrDBCheckBox [3]
    Left = 456
    Top = 40
    Width = 21
    Height = 21
    TabStop = False
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Juridico'
    ParentColor = False
    Properties.DisplayUnchecked = 'False'
    Properties.DisplayGrayed = 'False'
    Properties.NullStyle = nssUnchecked
    Properties.ReadOnly = False
    Properties.OnChange = chkCompanyPropertiesChange
    Style.Color = clWindow
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 4
    EditLabel.Width = 57
    EditLabel.Height = 13
    EditLabel.Caption = 'Is Company'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object scCountry: TmrDBSuperCombo [4]
    Left = 72
    Top = 197
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
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 9
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ConnectionSourceName = 'MaintenanceConn'
    ProviderListName = 'dspLuCountry'
    ProviderSourceName = 'dspPais'
    FchClassName = 'TMntCountryFch'
    EditLabel.Width = 49
    EditLabel.Height = 13
    EditLabel.Caption = 'Country : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDPais'
  end
  object edtFirstName: TmrDBEdit [5]
    Left = 72
    Top = 65
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'PessoaFirstName'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 1
    EditLabel.Width = 58
    EditLabel.Height = 13
    EditLabel.Caption = 'First Name :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtLastName: TmrDBEdit [6]
    Left = 321
    Top = 65
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'PessoaLastName'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 2
    EditLabel.Width = 57
    EditLabel.Height = 13
    EditLabel.Caption = 'Last Name :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object scEntityType: TmrDBSuperCombo [7]
    Left = 71
    Top = 37
    Width = 154
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
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 0
    OnBeforeGetRecordsList = scEntityTypeBeforeGetRecordsList
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ProviderListName = 'dspLuEntityType'
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'Type : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = True
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDTipoPessoa'
  end
  object edtAddress: TmrDBEdit [8]
    Left = 71
    Top = 91
    Width = 404
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Endereco'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 5
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Address :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtCity: TmrDBEdit [9]
    Left = 71
    Top = 117
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Cidade'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 6
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.Caption = 'City :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object scState: TmrDBSuperCombo [10]
    Left = 72
    Top = 144
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
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 7
    DisableButtons = False
    ConnectionListName = 'LookUpMaintenanceConn'
    ConnectionSourceName = 'MaintenanceConn'
    ProviderListName = 'dspLuState'
    ProviderSourceName = 'dspEstado'
    FchClassName = 'TMntStateFch'
    EditLabel.Width = 36
    EditLabel.Height = 13
    EditLabel.Caption = 'State : '
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
    DependentLookUps = <>
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'IDEstado'
  end
  object edtZip: TmrDBEdit [11]
    Left = 72
    Top = 170
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'CEP'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 8
    EditLabel.Width = 21
    EditLabel.Height = 13
    EditLabel.Caption = 'Zip :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  object edtFullName: TmrDBEdit [12]
    Left = 71
    Top = 65
    Width = 404
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Pessoa'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 3
    Visible = False
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'Name :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  inherited pnlBottom: TPanel
    Top = 359
    Width = 494
    TabOrder = 13
    inherited btnOk: TXiButton
      Left = 339
    end
    inherited btnCancel: TXiButton
      Left = 417
    end
  end
  inherited pnlTitulo: TPanel
    Width = 494
    TabOrder = 14
    inherited lbLoop: TLabel
      Left = 438
    end
    inherited btnLoop: TXiButton
      Left = 466
    end
  end
  object mrDBEdit1: TmrDBEdit [15]
    Left = 319
    Top = 194
    Width = 154
    Height = 21
    DataBinding.DataSource = dsFch
    DataBinding.DataField = 'Email'
    Properties.ReadOnly = False
    Style.StyleController = DMMaintenance.cxStyleController
    TabOrder = 15
    EditLabel.Width = 35
    EditLabel.Height = 13
    EditLabel.Caption = 'E-mail :'
    LabelPosition = lpLeft
    LabelSpacing = 6
    Required = False
    Locked = False
  end
  inherited dsFch: TDataSource
    Left = 88
    Top = 228
  end
  inherited PrintFch: TPrintDialog
    Left = 140
    Top = 232
  end
  inherited ConfigFch: TmrConfigFch
    OnAfterAppend = ConfigFchAfterAppend
    Left = 28
    Top = 232
  end
end
