inherited BrwTaxCategory: TBrwTaxCategory
  Left = 305
  Top = 161
  HelpContext = 2100
  Caption = 'BrwTaxCategory'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    inherited pnlBasicFilter: TPanel
      Height = 58
      object Label2: TLabel [0]
        Left = 60
        Top = 11
        Width = 58
        Height = 13
        Alignment = taRightJustify
        Caption = 'Tax Type :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel [1]
        Left = 32
        Top = 35
        Width = 85
        Height = 13
        Alignment = taRightJustify
        Caption = 'Sale Tax Type :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited pblGO: TPanel
        Height = 58
        inherited pnlAviso: TPanel
          Top = 12
          inherited btnExec: TSpeedButton
            OnClick = btnExecClick
          end
        end
      end
      object cbxTaxType: TComboBox
        Left = 128
        Top = 7
        Width = 142
        Height = 21
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ItemIndex = 0
        ParentFont = False
        TabOrder = 1
        Text = 'Sale'
        OnChange = cbxTaxTypeChange
        Items.Strings = (
          'Sale'
          'Purchase')
      end
      object cbxSaleType: TComboBox
        Left = 128
        Top = 31
        Width = 142
        Height = 21
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 13
        ItemIndex = 0
        ParentFont = False
        TabOrder = 2
        Text = 'Sale Charge'
        OnChange = cbxSaleTypeChange
        Items.Strings = (
          'Sale Charge'
          'Tax')
      end
    end
    inherited pnlButton: TPanelRights
      Top = 58
      Height = 321
      inherited imgFolder: TImage
        Top = 251
      end
      inherited ImgTrash: TImage
        Top = 286
      end
    end
    inherited pnlMainBrowse: TPanel
      Top = 58
      Height = 321
      inherited pnlPage: TPanel
        Top = 302
      end
      inherited grdBrowse: TcxGrid
        Height = 274
        inherited grdBrowseDB: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDTaxCategory'
          OptionsView.Footer = False
          object grdBrowseDBIDTaxCategory: TcxGridDBColumn
            Caption = 'ID'
            DataBinding.FieldName = 'IDTaxCategory'
            Visible = False
          end
          object grdBrowseDBTaxCategory: TcxGridDBColumn
            DataBinding.FieldName = 'TaxCategory'
          end
          object grdBrowseDBTax: TcxGridDBColumn
            DataBinding.FieldName = 'Tax'
          end
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_BrwTaxCategory.sil'
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
      0A717542726F7773652E496E6465784E616D65010101010D0A717542726F7773
      652E4B65794669656C6473010101010D0A717542726F7773652E4D6173746572
      4669656C6473010101010D0A42726F777365436F6E6669672E44656661756C74
      427574746F6E01627444657461696C0101010D0A42726F777365436F6E666967
      2E466368436C6173734E616D65010101010D0A42726F777365436F6E6669672E
      5669657744656C6574655461626C65010101010D0A53442E44656661756C7445
      7874012A2E786C730101010D0A53442E46696C654E616D65010101010D0A5344
      2E46696C746572014D6963726F736F667420457863656C7C2A2E786C73010101
      0D0A53442E496E697469616C44697201433A5C0101010D0A53442E5469746C65
      010101010D0A73744C6F63616C65730D0A43757272656E637920537472696E67
      01240101010D0A54686F7573616E6420536570617261746F72012C0101010D0A
      446563696D616C20536570617261746F72012E0101010D0A4461746520536570
      617261746F72012F0101010D0A53686F7274204461746520466F726D6174014D
      2F642F797979790101010D0A4C6F6E67204461746520466F726D617401646464
      642C204D4D4D4D2064642C20797979790101010D0A54696D6520536570617261
      746F72013A0101010D0A54696D6520414D20537472696E6701414D0101010D0A
      54696D6520504D20537472696E6701504D0101010D0A53686F72742054696D65
      20466F726D617401683A6D6D20414D504D0101010D0A4C6F6E672054696D6520
      466F726D617401683A6D6D3A737320414D504D0101010D0A53686F7274204D6F
      6E7468204E616D6573014A616E2C4665622C4D61722C4170722C4D61792C4A75
      6E2C4A756C2C4175672C5365702C4F63742C4E6F762C4465630101010D0A4C6F
      6E67204D6F6E7468204E616D6573014A616E756172792C46656272756172792C
      4D617263682C417072696C2C4D61792C4A756E652C4A756C792C417567757374
      2C53657074656D6265722C4F63746F6265722C4E6F76656D6265722C44656365
      6D6265720101010D0A53686F727420446179204E616D65730153756E2C4D6F6E
      2C5475652C5765642C5468752C4672692C5361740101010D0A4C6F6E67204461
      79204E616D65730153756E6461792C4D6F6E6461792C547565736461792C5765
      646E65736461792C54687572736461792C4672696461792C5361747572646179
      0101010D0A7374436F6C6C656374696F6E730D0A737443686172536574730D0A}
  end
  inherited quBrowse: TPowerADOQuery
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'T.IDTaxCategory, '#13#10#9'T.SpecialDateStart, '#13#10#9'T.SpecialDa' +
      'teEnd, '#13#10#9'T.Tax, '#13#10#9'T.SpecialTax, '#13#10#9'T.TaxCategory, '#13#10#9'T.System,' +
      ' '#13#10#9'T.Hidden, '#13#10#9'T.Desativado, '#13#10#9'T.TaxExempt,'#13#10#9'T.Debit,'#13#10#9'T.Op' +
      'erationType,'#13#10#9'T.SaleTaxType'#13#10'FROM '#13#10#9'TaxCategory T (NOLOCK)'#13#10'WH' +
      'ERE'#13#10#9'T.IDTaxCategoryParent = 0'#13#10
    object quBrowseIDTaxCategory: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'IDTaxCategory'
      Origin = 'RETAIL.TaxCategory.IDTaxCategory'
    end
    object quBrowseTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Origin = 'RETAIL.TaxCategory.TaxCategory'
      Size = 50
    end
    object quBrowseTax: TFloatField
      FieldName = 'Tax'
      Origin = 'RETAIL.TaxCategory.Tax'
      DisplayFormat = '0.0000 %'
    end
  end
  inherited gridPrinter: TdxComponentPrinter
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    inherited gridPrinterLink: TdxGridReportLink
      DateTime = 37946.740956747690000000
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