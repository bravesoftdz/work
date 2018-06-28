inherited brwGroup: TbrwGroup
  Left = 218
  Top = 156
  HelpContext = 1680
  Caption = 'brwGroup'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited Image3: TImage [0]
    end
    inherited imgTopIni: TImage [1]
    end
    inherited lblBasicFilter: TLabel [2]
    end
    inherited Image1: TImage [3]
    end
    inherited lblMenu: TLabel [4]
    end
    inherited lblSubMenu: TLabelEffect [5]
    end
    inherited imgMenu: TImage [6]
    end
  end
  inherited pnlMain: TPanel
    inherited pnlButton: TPanelRights
      object btnSubGroup: TSpeedButton [11]
        Left = 1
        Top = 222
        Width = 111
        Height = 25
        AllowAllUp = True
        Caption = '&Model Group'
        Flat = True
        Margin = 7
        Spacing = 8
        OnClick = btnSubGroupClick
      end
      object Panel4: TPanel
        Left = 11
        Top = 218
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 2
      end
    end
    inherited pnlMainBrowse: TPanel
      inherited grdBrowse: TcxGrid
        inherited grdBrowseDB: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDGroup'
          OptionsView.Footer = False
          object grdBrowseDBIDGroup: TcxGridDBColumn
            Caption = 'ID'
            DataBinding.FieldName = 'IDGroup'
            Width = 105
          end
          object grdBrowseDBName: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Width = 256
          end
          object grdBrowseDBSerialNumber: TcxGridDBColumn
            DataBinding.FieldName = 'SerialNumber'
            Width = 76
          end
          object grdBrowseDBSizeAndColor: TcxGridDBColumn
            DataBinding.FieldName = 'SizeAndColor'
            Width = 79
          end
          object grdBrowseDBPackModel: TcxGridDBColumn
            DataBinding.FieldName = 'PackModel'
            Visible = False
          end
          object grdBrowseDBService: TcxGridDBColumn
            DataBinding.FieldName = 'Service'
            Visible = False
          end
          object grdBrowseDBCredit: TcxGridDBColumn
            DataBinding.FieldName = 'Credit'
            Visible = False
          end
          object grdBrowseDBUserCode: TcxGridDBColumn
            DataBinding.FieldName = 'UserCode'
            Visible = False
          end
          object grdBrowseDBPuppyTracker: TcxGridDBColumn
            DataBinding.FieldName = 'PuppyTracker'
            Visible = False
            Hidden = True
          end
          object grdBrowseDBRequestCustomer: TcxGridDBColumn
            Caption = 'Request Customer'
            DataBinding.FieldName = 'RequestCustomer'
            Visible = False
          end
          object grdBrowseDBGiftCard: TcxGridDBColumn
            DataBinding.FieldName = 'GiftCard'
            Visible = False
            Options.Editing = False
            Options.Filtering = False
          end
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_brwGroup.sil'
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
      6E67730D0A73744F74686572537472696E67730D0A67726442726F7773652E49
      6E6946696C654E616D65010101010D0A67726442726F7773652E496E69536563
      74696F6E4E616D65010101010D0A67726442726F7773652E4B65794669656C64
      010101010D0A67726442726F7773652E507265766965774669656C644E616D65
      010101010D0A67726442726F7773652E52656769737472795061746801010101
      0D0A67726442726F7773652E53756D6D617279536570617261746F72012C2001
      01010D0A717542726F7773652E436F6D6D616E6454657874010101010D0A7175
      42726F7773652E436F6E6E656374696F6E537472696E67010101010D0A717542
      726F7773652E46696C746572010101010D0A717542726F7773652E496E646578
      4669656C644E616D6573010101010D0A717542726F7773652E4B65794669656C
      6473010101010D0A42726F777365436F6E6669672E44656661756C7442757474
      6F6E01627444657461696C0101010D0A42726F777365436F6E6669672E466368
      436C6173734E616D65010101010D0A42726F777365436F6E6669672E56696577
      44656C6574655461626C65010101010D0A53442E46696C746572014D6963726F
      736F667420457863656C7C2A2E786C730101010D0A53442E5469746C65010101
      010D0A73744C6F63616C65730D0A43757272656E637920537472696E67012401
      01010D0A54686F7573616E6420536570617261746F72012C0101010D0A446563
      696D616C20536570617261746F72012E0101010D0A4461746520536570617261
      746F72012F0101010D0A53686F7274204461746520466F726D6174014D2F642F
      797979790101010D0A4C6F6E67204461746520466F726D617401646464642C20
      4D4D4D4D2064642C20797979790101010D0A54696D6520536570617261746F72
      013A0101010D0A54696D6520414D20537472696E6701414D0101010D0A54696D
      6520504D20537472696E6701504D0101010D0A53686F72742054696D6520466F
      726D617401683A6D6D20414D504D0101010D0A4C6F6E672054696D6520466F72
      6D617401683A6D6D3A737320414D504D0101010D0A53686F7274204D6F6E7468
      204E616D6573014A616E2C4665622C4D61722C4170722C4D61792C4A756E2C4A
      756C2C4175672C5365702C4F63742C4E6F762C4465630101010D0A4C6F6E6720
      4D6F6E7468204E616D6573014A616E756172792C46656272756172792C4D6172
      63682C417072696C2C4D61792C4A756E652C4A756C792C4175677573742C5365
      7074656D6265722C4F63746F6265722C4E6F76656D6265722C446563656D6265
      720101010D0A53686F727420446179204E616D65730153756E2C4D6F6E2C5475
      652C5765642C5468752C4672692C5361740101010D0A4C6F6E6720446179204E
      616D65730153756E6461792C4D6F6E6461792C547565736461792C5765646E65
      736461792C54687572736461792C4672696461792C5361747572646179010101
      0D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A}
  end
  inherited quBrowse: TPowerADOQuery
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10'      IDGroup,'#13#10'      Name,'#13#10'      Taxable,'#13#10'      Seria' +
      'lNumber,'#13#10'      PackModel,'#13#10'      SizeAndColor,'#13#10'      Service,'#13 +
      #10'      Credit,'#13#10'      UserCode,'#13#10'      GiftCard,'#13#10'      PuppyTra' +
      'cker,'#13#10'      RequestCustomer'#13#10'FROM'#13#10'      TabGroup (NOLOCK)'#13#10
    object quBrowseIDGroup: TAutoIncField
      FieldName = 'IDGroup'
      ReadOnly = True
    end
    object quBrowseName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quBrowseSerialNumber: TBooleanField
      FieldName = 'SerialNumber'
    end
    object quBrowseSizeAndColor: TBooleanField
      FieldName = 'SizeAndColor'
    end
    object quBrowsePackModel: TBooleanField
      FieldName = 'PackModel'
    end
    object quBrowseService: TBooleanField
      FieldName = 'Service'
    end
    object quBrowseCredit: TBooleanField
      FieldName = 'Credit'
    end
    object quBrowseUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
    object quBrowseTaxable: TBooleanField
      FieldName = 'Taxable'
    end
    object quBrowsePuppyTracker: TBooleanField
      FieldName = 'PuppyTracker'
    end
    object quBrowseRequestCustomer: TBooleanField
      FieldName = 'RequestCustomer'
    end
    object quBrowseGiftCard: TBooleanField
      FieldName = 'GiftCard'
    end
  end
  inherited BrowseConfig: TBrowseConfig
    Top = 185
  end
  inherited SD: TSaveDialog
    Left = 233
    Top = 129
  end
  inherited TimeAviso: TTimer
    Top = 185
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    Top = 169
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 37946.613938958340000000
      PrinterPage.Footer = 363
      PrinterPage.Header = 20
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210007
      PrinterPage.PageSize.Y = 297002
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      BuiltInReportLink = True
    end
  end
end
