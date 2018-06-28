inherited brwFrmModelGroup: TbrwFrmModelGroup
  Left = 238
  Top = 95
  Caption = 'brwFrmModelGroup'
  ClientHeight = 360
  ClientWidth = 442
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 442
    TabOrder = 3
    inherited Image1: TImage
      Width = 168
    end
    inherited lblMenu: TLabel
      Left = 184
    end
    inherited EspacamentoSuperior: TPanel
      Width = 442
      inherited EEE: TPanel
        Width = 442
      end
    end
    inherited pnlAutoInc: TPanel
      Left = 395
    end
  end
  inherited Panel1: TPanel
    Top = 319
    Width = 442
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 442
      inherited Panel3: TPanel
        Width = 442
      end
    end
    inherited hhh: TPanel
      Left = 221
    end
  end
  inherited pnlKey: TPanel
    Width = 442
    Height = 6
    TabOrder = 6
    inherited Panel4: TPanel
      Top = 4
      Width = 442
    end
  end
  inherited pnlDetail: TPanel
    Top = 46
    Width = 442
    Height = 106
    TabOrder = 0
    object Label1: TLabel
      Left = 61
      Top = 77
      Width = 36
      Height = 13
      Caption = 'Group :'
      FocusControl = DBEdit1
    end
    object Label20: TLabel
      Left = 45
      Top = 17
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Category :'
    end
    object Label2: TLabel
      Left = 330
      Top = 14
      Width = 14
      Height = 23
      Hint = 'Field can not be empty'
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object Label3: TLabel
      Left = 330
      Top = 76
      Width = 14
      Height = 23
      Hint = 'Field can not be empty'
      Caption = '*'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object lbUserCode: TLabel
      Left = 43
      Top = 47
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = 'UserCode :'
    end
    object DBEdit1: TDBEdit
      Left = 100
      Top = 73
      Width = 226
      Height = 21
      DataField = 'ModelGroup'
      DataSource = dsForm
      TabOrder = 2
    end
    object cmbGroup: TDBSuperComboADO
      Tag = 99
      Left = 100
      Top = 13
      Width = 226
      Height = 21
      TabStop = False
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'cmbGroup'
      LookUpSource = DM.dsLookUpGroup
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      EditCodePos = taEditCodeRight
      IDLanguage = 0
      DataField = 'IDGroup'
      DataSource = dsForm
    end
    object DBEdit2: TDBEdit
      Left = 100
      Top = 43
      Width = 76
      Height = 21
      DataField = 'UserCode'
      DataSource = dsForm
      TabOrder = 1
    end
  end
  inherited PageControl: TPageControl
    Top = 152
    Width = 436
    Height = 167
    ActivePage = tsPricing
    TabOrder = 1
    object tsPricing: TTabSheet
      Caption = 'Pricing'
      object Panel9: TPanel
        Left = 1
        Top = -1
        Width = 210
        Height = 139
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 0
        object lbQuestion: TLabel
          Left = 5
          Top = 25
          Width = 79
          Height = 13
          Caption = 'Calculate margin'
        end
        object pnSalePrice: TPanel
          Left = 0
          Top = 0
          Width = 210
          Height = 16
          BevelOuter = bvNone
          Caption = 'Sale Price Margin'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
        end
        object scSalePriceMargemType: TDBSuperComboADO
          Left = 6
          Top = 70
          Width = 113
          Height = 21
          TabOrder = 1
          Text = 'scSalePriceMargemType'
          LookUpSource = DM.dsLookUpMargemType
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
          OnSelectItem = scSalePriceMargemTypeSelectItem
          DataField = 'IDSalePriceMargemTable'
          DataSource = dsForm
        end
        object dbSalePricePercent: TDBEdit
          Left = 6
          Top = 70
          Width = 67
          Height = 21
          DataField = 'SalePriceMargemPercent'
          DataSource = dsForm
          TabOrder = 2
          OnKeyPress = dbSalePricePercentKeyPress
        end
        object cbSalePrice: TComboBox
          Left = 6
          Top = 44
          Width = 138
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cbSalePriceChange
          Items.Strings = (
            'With flat margin'
            'With margin table')
        end
        object chkRecalcPrices: TCheckBox
          Left = 6
          Top = 118
          Width = 171
          Height = 17
          Caption = 'Recalculate Prices'
          TabOrder = 4
          OnClick = chkRecalcPricesClick
        end
      end
      object Panel13: TPanel
        Left = 216
        Top = 0
        Width = 212
        Height = 138
        BevelOuter = bvNone
        Color = 14607076
        TabOrder = 1
        object lbQuestion2: TLabel
          Left = 5
          Top = 25
          Width = 79
          Height = 13
          Caption = 'Calculate margin'
        end
        object pnMSRP: TPanel
          Left = 0
          Top = 0
          Width = 213
          Height = 16
          BevelOuter = bvNone
          Caption = 'MSRP Margin'
          Color = clBtnShadow
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
        end
        object scMSRPMargemType: TDBSuperComboADO
          Left = 5
          Top = 67
          Width = 113
          Height = 21
          TabOrder = 1
          Text = 'scMSRPMargemType'
          LookUpSource = DM.dsLookUpMargemType
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
          OnSelectItem = scSalePriceMargemTypeSelectItem
          DataField = 'IDMSRPMargemTable'
          DataSource = dsForm
        end
        object dbMSRPPercent: TDBEdit
          Left = 4
          Top = 67
          Width = 67
          Height = 21
          DataField = 'MSRPMargemPercent'
          DataSource = dsForm
          TabOrder = 2
          OnKeyPress = dbSalePricePercentKeyPress
        end
        object cbMSRP: TComboBox
          Left = 4
          Top = 42
          Width = 160
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = cbMSRPChange
          Items.Strings = (
            'With flat margin'
            'With margin table')
        end
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 152
    Height = 167
  end
  inherited EspacamentoDireito: TPanel
    Left = 439
    Top = 152
    Height = 167
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_BrwFrmModelGroup.sil'
    TranslationData = {
      737443617074696F6E730D0A737448696E74730D0A7374446973706C61794C61
      62656C730D0A7374466F6E74730D0A73744D756C74694C696E65730D0A737444
      6C677343617074696F6E730D0A5761726E696E67015761726E696E670101010D
      0A4572726F72014572726F720101010D0A496E666F726D6174696F6E01496E66
      6F726D6174696F6E0101010D0A436F6E6669726D01436F6E6669726D0101010D
      0A59657301265965730101010D0A4E6F01264E6F0101010D0A4F4B014F4B0101
      010D0A43616E63656C0143616E63656C0101010D0A41626F7274012641626F72
      740101010D0A5265747279012652657472790101010D0A49676E6F7265012649
      676E6F72650101010D0A416C6C0126416C6C0101010D0A4E6F20546F20416C6C
      014E266F20746F20416C6C0101010D0A59657320546F20416C6C015965732074
      6F2026416C6C0101010D0A48656C70012648656C700101010D0A737453747269
      6E67730D0A73744F74686572537472696E67730D0A7175466F726D2E436F6D6D
      616E6454657874010101010D0A7175466F726D2E436F6E6E656374696F6E5374
      72696E67010101010D0A7175466F726D2E46696C746572010101010D0A717546
      6F726D2E496E6465784669656C644E616D6573010101010D0A7175466F726D2E
      496E6465784E616D65010101010D0A7175466F726D2E4B65794669656C647301
      0101010D0A7175466F726D2E4D61737465724669656C6473010101010D0A466F
      726D436F6E6669672E456E7469646164654E6F6D65010101010D0A73744C6F63
      616C65730D0A43757272656E637920537472696E6701240101010D0A54686F75
      73616E6420536570617261746F72012C0101010D0A446563696D616C20536570
      617261746F72012E0101010D0A4461746520536570617261746F72012F010101
      0D0A53686F7274204461746520466F726D6174014D2F642F797979790101010D
      0A4C6F6E67204461746520466F726D617401646464642C204D4D4D4D2064642C
      20797979790101010D0A54696D6520536570617261746F72013A0101010D0A54
      696D6520414D20537472696E6701414D0101010D0A54696D6520504D20537472
      696E6701504D0101010D0A53686F72742054696D6520466F726D617401683A6D
      6D20414D504D0101010D0A4C6F6E672054696D6520466F726D617401683A6D6D
      3A737320414D504D0101010D0A53686F7274204D6F6E7468204E616D6573014A
      616E2C4665622C4D61722C4170722C4D61792C4A756E2C4A756C2C4175672C53
      65702C4F63742C4E6F762C4465630101010D0A4C6F6E67204D6F6E7468204E61
      6D6573014A616E756172792C46656272756172792C4D617263682C417072696C
      2C4D61792C4A756E652C4A756C792C4175677573742C53657074656D6265722C
      4F63746F6265722C4E6F76656D6265722C446563656D6265720101010D0A5368
      6F727420446179204E616D65730153756E2C4D6F6E2C5475652C5765642C5468
      752C4672692C5361740101010D0A4C6F6E6720446179204E616D65730153756E
      6461792C4D6F6E6461792C547565736461792C5765646E65736461792C546875
      72736461792C4672696461792C53617475726461790101010D0A7374436F6C6C
      656374696F6E730D0A737443686172536574730D0A}
  end
  inherited dsForm: TDataSource
    Left = 366
    Top = 61
  end
  inherited quForm: TPowerADOQuery
    BeforePost = quFormBeforePost
    OnNewRecord = quFormNewRecord
    CommandText = 
      'SELECT'#13#10#9'IDModelGroup,'#13#10#9'ModelGroup,'#13#10#9'IDGroup,'#13#10#9'SalePriceMarge' +
      'mPercent,'#13#10#9'UseSalePricePercent,'#13#10#9'IDSalePriceMargemTable,'#13#10#9'IDM' +
      'SRPMargemTable,'#13#10#9'MSRPMargemPercent,'#13#10#9'UseMSRPPercent,'#13#10#9'UserCod' +
      'e'#13#10'FROM'#13#10#9'ModelGroup'#13#10'WHERE'#13#10#9'IDModelGroup = :IDModelGroup'
    Parameters = <
      item
        Name = 'IDModelGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 366
    Top = 117
    object quFormIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
    end
    object quFormModelGroup: TStringField
      FieldName = 'ModelGroup'
      Required = True
      Size = 30
    end
    object quFormIDGroup: TIntegerField
      FieldName = 'IDGroup'
      Required = True
    end
    object quFormSalePriceMargemPercent: TFloatField
      FieldName = 'SalePriceMargemPercent'
    end
    object quFormUseSalePricePercent: TBooleanField
      FieldName = 'UseSalePricePercent'
    end
    object quFormIDSalePriceMargemTable: TIntegerField
      FieldName = 'IDSalePriceMargemTable'
    end
    object quFormIDMSRPMargemTable: TIntegerField
      FieldName = 'IDMSRPMargemTable'
    end
    object quFormMSRPMargemPercent: TFloatField
      FieldName = 'MSRPMargemPercent'
    end
    object quFormUseMSRPPercent: TBooleanField
      FieldName = 'UseMSRPPercent'
    end
    object quFormUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
  end
  inherited FormConfig: TFormConfig
    PostOnInsert = True
    AutoIncField = 'IDModelGroup'
    Left = 366
    Top = 174
  end
end
