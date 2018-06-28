inherited brwPromo: TbrwPromo
  Left = 309
  Top = 24
  Width = 806
  Height = 487
  Caption = 'brwPromo'
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel2: TPanel
    Width = 790
    inherited Image1: TImage
      Width = 563
    end
    inherited lblMenu: TLabel
      Left = 583
    end
    inherited EspacamentoSuperior: TPanel
      Width = 790
      inherited EEE: TPanel
        Width = 790
      end
    end
  end
  inherited Panel1: TPanel
    Top = 408
    Width = 790
    inherited EspacamentoInferior: TPanel
      Width = 790
      inherited Panel3: TPanel
        Width = 790
      end
    end
    inherited hhh: TPanel
      Left = 642
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 374
  end
  inherited EspacamentoDireito: TPanel
    Left = 790
    Height = 374
  end
  inherited pnlMain: TPanel
    Width = 790
    Height = 374
    inherited pnlBasicFilter: TPanel
      Width = 790
      Height = 65
      Visible = True
      object Label3: TLabel [0]
        Left = 368
        Top = 8
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Store :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel [1]
        Left = 29
        Top = 37
        Width = 77
        Height = 13
        Alignment = taRightJustify
        Caption = 'DayOfWeek :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object lblType: TLabel [2]
        Left = 70
        Top = 10
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Type :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited pblGO: TPanel
        Left = 709
        Height = 65
        TabOrder = 3
        Visible = True
        inherited pnlAviso: TPanel
          Top = 19
          Width = 63
          Height = 32
          inherited btnExec: TSpeedButton
            Left = 4
            Top = 3
            OnClick = btnExecClick
          end
        end
      end
      object scStore: TSuperComboADO
        Left = 408
        Top = 4
        Width = 217
        Height = 21
        TabOrder = 2
        Text = '<-->'
        CodeLength = 5
        LookUpSource = DM.dsLookUpStore
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object Button1: TButton
        Left = 261
        Top = 34
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 4
        Visible = False
        OnClick = Button1Click
      end
      object Button3: TButton
        Left = 630
        Top = 4
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 5
        OnClick = Button3Click
      end
      object cbxPromoType: TComboBox
        Left = 110
        Top = 6
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'All'
        Items.Strings = (
          'All'
          'Coupon'
          'Promo')
      end
      object cbxDayofWeek: TComboBox
        Left = 109
        Top = 33
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = 'All'
        Visible = False
        Items.Strings = (
          'All'
          'Sunday'
          'Monday'
          'Tuesday'
          'Wednesday'
          'Thursday'
          'Friday'
          'Saturday')
      end
      object Button2: TButton
        Left = 261
        Top = 6
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 6
        OnClick = Button2Click
      end
      object statusPromo: TRadioGroup
        Left = 315
        Top = 27
        Width = 351
        Height = 34
        Caption = 'Status'
        Columns = 4
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Future'
          'Expired'
          'All')
        ParentFont = False
        TabOrder = 7
      end
    end
    inherited pnlButton: TPanelRights
      Left = 677
      Top = 65
      Height = 309
      inherited btRestore: TSpeedButton
        Visible = False
      end
      inherited btAdd: TSpeedButton
        Left = 1
        Top = 0
      end
      inherited btColumn: TSpeedButton
        Tag = 6
      end
      inherited btGroup: TSpeedButton
        Tag = 5
      end
      inherited btDetail: TSpeedButton
        Top = 25
      end
      inherited imgFolder: TImage
        Top = 239
      end
      inherited ImgTrash: TImage
        Top = 274
      end
      inherited btPrint: TSpeedButton
        Tag = 3
      end
      inherited btExcel: TSpeedButton
        Tag = 4
      end
      inherited btFilter: TSpeedButton
        Tag = 7
      end
    end
    inherited pnlMainBrowse: TPanel
      Top = 65
      Width = 677
      Height = 309
      inherited pnlPage: TPanel
        Top = 290
        Width = 677
        inherited pnlDivisor: TPanel
          Width = 677
        end
      end
      inherited pnlGenFilter: TPanel
        Width = 677
        inherited lblGenFilter: TLabel
          Width = 677
        end
      end
      inherited grdBrowse: TcxGrid
        Width = 677
        Height = 262
        inherited grdBrowseDB: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IdDiscount'
          OptionsView.Footer = False
          object grdBrowseDBDBColumn1: TcxGridDBColumn
            Caption = 'IdDiscount'
            DataBinding.FieldName = 'IDDiscount'
            Width = 77
          end
          object grdBrowseDBDBColumn2: TcxGridDBColumn
            Caption = 'Discount'
            DataBinding.FieldName = 'DiscountName'
            Width = 93
          end
          object grdBrowseDBDBColumn3: TcxGridDBColumn
            Caption = 'Start Date'
            DataBinding.FieldName = 'StartOn'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.ReadOnly = True
            Properties.SaveTime = False
            Properties.ShowTime = False
            Width = 82
          end
          object grdBrowseDBDBColumn4: TcxGridDBColumn
            Caption = 'End Date'
            DataBinding.FieldName = 'EndOn'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.ReadOnly = True
            Properties.SaveTime = False
            Properties.ShowTime = False
            Width = 87
          end
          object grdBrowseDBDBColumn5: TcxGridDBColumn
            Caption = 'Start Time'
            DataBinding.FieldName = 'BeginTimeOfDay'
            PropertiesClassName = 'TcxTimeEditProperties'
            Properties.TimeFormat = tfHourMin
            Width = 68
          end
          object grdBrowseDBDBColumn6: TcxGridDBColumn
            Caption = 'End Time'
            DataBinding.FieldName = 'EndTimeOfDay'
            PropertiesClassName = 'TcxTimeEditProperties'
            Properties.TimeFormat = tfHourMin
            Width = 69
          end
          object grdBrowseDBDBColumn7: TcxGridDBColumn
            Caption = 'Discount Type'
            DataBinding.FieldName = 'DiscType'
            SortOrder = soAscending
            Width = 101
          end
          object grdBrowseDBDBColumn8: TcxGridDBColumn
            Caption = 'Amount of Type'
            DataBinding.FieldName = 'amountType'
            Width = 106
          end
          object grdBrowseDBDBColumn9: TcxGridDBColumn
            Caption = 'IsBogo?'
            DataBinding.FieldName = 'IsBogo'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.DisplayUnchecked = 'False'
            Properties.NullStyle = nssUnchecked
          end
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_BrwPromo.sil'
    Left = 6
    Top = 5
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
      6E67730D0A73744F74686572537472696E67730D0A717542726F7773652E436F
      6D6D616E6454657874010101010D0A717542726F7773652E436F6E6E65637469
      6F6E537472696E67010101010D0A717542726F7773652E46696C746572010101
      010D0A717542726F7773652E496E6465784669656C644E616D6573010101010D
      0A717542726F7773652E4B65794669656C6473010101010D0A42726F77736543
      6F6E6669672E44656661756C74427574746F6E01627444657461696C0101010D
      0A42726F777365436F6E6669672E466368436C6173734E616D65010101010D0A
      42726F777365436F6E6669672E5669657744656C6574655461626C6501010101
      0D0A53442E46696C746572014D6963726F736F667420457863656C7C2A2E786C
      730101010D0A53442E5469746C65010101010D0A73744C6F63616C65730D0A43
      757272656E637920537472696E6701240101010D0A54686F7573616E64205365
      70617261746F72012C0101010D0A446563696D616C20536570617261746F7201
      2E0101010D0A4461746520536570617261746F72012F0101010D0A53686F7274
      204461746520466F726D6174014D2F642F797979790101010D0A4C6F6E672044
      61746520466F726D617401646464642C204D4D4D4D2064642C20797979790101
      010D0A54696D6520536570617261746F72013A0101010D0A54696D6520414D20
      537472696E6701414D0101010D0A54696D6520504D20537472696E6701504D01
      01010D0A53686F72742054696D6520466F726D617401683A6D6D20414D504D01
      01010D0A4C6F6E672054696D6520466F726D617401683A6D6D3A737320414D50
      4D0101010D0A53686F7274204D6F6E7468204E616D6573014A616E2C4665622C
      4D61722C4170722C4D61792C4A756E2C4A756C2C4175672C5365702C4F63742C
      4E6F762C4465630101010D0A4C6F6E67204D6F6E7468204E616D6573014A616E
      756172792C46656272756172792C4D617263682C417072696C2C4D61792C4A75
      6E652C4A756C792C4175677573742C53657074656D6265722C4F63746F626572
      2C4E6F76656D6265722C446563656D6265720101010D0A53686F727420446179
      204E616D65730153756E2C4D6F6E2C5475652C5765642C5468752C4672692C53
      61740101010D0A4C6F6E6720446179204E616D65730153756E6461792C4D6F6E
      6461792C547565736461792C5765646E65736461792C54687572736461792C46
      72696461792C53617475726461790101010D0A7374436F6C6C656374696F6E73
      0D0A737443686172536574730D0A}
  end
  inherited quBrowse: TPowerADOQuery
    CursorType = ctStatic
    OnCalcFields = quBrowseCalcFields
    CommandText = 
      'select d.IdDiscount, d.DiscountName, d.StartOn, d.EndOn, d.Begin' +
      'TimeOfDay, d.EndTimeOfDay, d.DiscType, d.idStore,'#13#10'd.amountType,' +
      ' d.IsBogo'#13#10'from Discounts d'#13#10'     left join Store s on d.IDStore' +
      ' = s.IDStore'#13#10
    Left = 66
    Top = 145
  end
  inherited BrowseConfig: TBrowseConfig
    AutoOpen = False
  end
  inherited SD: TSaveDialog
    Left = 358
    Top = 177
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 38798.438474386570000000
      PrinterPage.Footer = 254
      PrinterPage.Header = 254
      PrinterPage.Margins.Bottom = 508
      PrinterPage.Margins.Left = 508
      PrinterPage.Margins.Right = 508
      PrinterPage.Margins.Top = 508
      PrinterPage.PageSize.X = 8280
      PrinterPage.PageSize.Y = 11684
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      BuiltInReportLink = True
    end
  end
end
