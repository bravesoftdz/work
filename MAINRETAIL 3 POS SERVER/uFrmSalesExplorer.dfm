object frmSalesExplorer: TfrmSalesExplorer
  Left = 48
  Top = 112
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Visualiza'#231#227'o de Vendas'
  ClientHeight = 507
  ClientWidth = 787
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 787
    Height = 71
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      787
      71)
    object Label1: TLabel
      Left = 30
      Top = 9
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'From'
    end
    object Label2: TLabel
      Left = 178
      Top = 9
      Width = 9
      Height = 13
      Alignment = taRightJustify
      Caption = 'to'
    end
    object Label3: TLabel
      Left = 311
      Top = 9
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'POS :'
    end
    object lblType: TLabel
      Left = 29
      Top = 41
      Width = 24
      Height = 13
      Alignment = taRightJustify
      Caption = 'Type'
    end
    object clbCashReg: TCheckListBox
      Left = 341
      Top = 5
      Width = 328
      Height = 61
      Columns = 3
      ItemHeight = 13
      TabOrder = 2
    end
    object edtBeginDate: TDateBox
      Left = 60
      Top = 5
      Width = 101
      Height = 21
      TabOrder = 0
    end
    object edtEndDate: TDateBox
      Left = 192
      Top = 5
      Width = 101
      Height = 21
      TabOrder = 1
    end
    object btnRefresh: TBitBtn
      Left = 691
      Top = 21
      Width = 70
      Height = 30
      Anchors = [akTop, akRight]
      Caption = 'GO!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnRefreshClick
    end
    object cmbItemType: TComboBox
      Left = 60
      Top = 37
      Width = 229
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        'Sale Items'
        'Removed Items')
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 71
    Width = 787
    Height = 436
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object grdSaleItems: TcxGrid
      Left = 0
      Top = 0
      Width = 672
      Height = 395
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      LookAndFeel.Kind = lfStandard
      object grdSaleItemsDBTableView: TcxGridDBTableView
        DataController.DataSource = dsSaleItems
        DataController.Filter.Options = [fcoShowOperatorDescription]
        DataController.Filter.AutoDataSetFilter = True
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Kind = skSum
            Column = grdSaleItemsDBTableViewQtd
          end
          item
            Kind = skSum
            Column = grdSaleItemsDBTableViewCusto
          end
          item
            Kind = skSum
            Column = grdSaleItemsDBTableViewVenda
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = grdSaleItemsDBTableViewQtd
          end
          item
            Kind = skSum
            Column = grdSaleItemsDBTableViewCusto
          end
          item
            Kind = skSum
            Column = grdSaleItemsDBTableViewVenda
          end>
        DataController.Summary.SummaryGroups = <>
        Filtering.Visible = fvNever
        OptionsBehavior.IncSearch = True
        OptionsBehavior.IncSearchItem = grdSaleItemsDBTableViewIDModel
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object grdSaleItemsDBTableViewIDStore: TcxGridDBColumn
          DataBinding.FieldName = 'Store'
          Width = 78
        end
        object grdSaleItemsDBTableViewSaleDate: TcxGridDBColumn
          Caption = 'Date'
          DataBinding.FieldName = 'SaleDate'
          Width = 58
        end
        object grdSaleItemsDBTableViewSaleTime: TcxGridDBColumn
          Caption = 'Time'
          DataBinding.FieldName = 'SaleTime'
          Width = 57
        end
        object grdSaleItemsDBTableViewCategory: TcxGridDBColumn
          DataBinding.FieldName = 'Category'
          Width = 59
        end
        object grdSaleItemsDBTableViewVendor: TcxGridDBColumn
          DataBinding.FieldName = 'Vendor'
          Width = 71
        end
        object grdSaleItemsDBTableViewModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Width = 56
        end
        object grdSaleItemsDBTableViewIDModel: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 159
        end
        object grdSaleItemsDBTableViewFabricante: TcxGridDBColumn
          DataBinding.FieldName = 'Manufacture'
          Visible = False
          Width = 111
        end
        object grdSaleItemsDBTableViewCusto: TcxGridDBColumn
          Caption = 'Cost'
          DataBinding.FieldName = 'Custo'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Visible = False
          Width = 108
        end
        object grdSaleItemsDBTableViewQtd: TcxGridDBColumn
          Caption = 'Qty'
          DataBinding.FieldName = 'Qtd'
          Width = 53
        end
        object grdSaleItemsDBTableViewVenda: TcxGridDBColumn
          Caption = 'Sale'
          DataBinding.FieldName = 'Venda'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Width = 77
        end
      end
      object grdSaleItemsLevel: TcxGridLevel
        GridView = grdSaleItemsDBTableView
      end
    end
    object Panel1: TPanel
      Left = 672
      Top = 0
      Width = 115
      Height = 395
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object btnColumn: TSpeedButton
        Left = 4
        Top = 3
        Width = 109
        Height = 28
        Caption = 'Column'
        Glyph.Data = {
          12040000424D1204000000000000360000002800000011000000130000000100
          180000000000DC03000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00D07622993401993401993401993401993401
          9934019934019934019934019934019934019934019934019934019934018080
          8000D07622FFFFFFF8E1D7FDF4F0FFFFFFFEFCFBFAF3EEF8EFE8F7EDE6F7EDE6
          F7EDE6F8EFE9FDFAF9FFFFFF9D39039C380380808000D07622FFFFFFF6D5C7FB
          EEE9FFFFFFFEFCFBF9F1ECF7EDE6F7EDE6F7EDE6F8EEE7F8EFE9FDFAF9FFFFFF
          A23E0696958080808000D07622FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
          FDFCFDFAF9FCF9F7FDFAF9FFFFFFFFFFFFFFFFFFA74509A4551F80808000D076
          22FFFFFF87F0F4FFFFFFFFFFFFFCF9F7F5E9E0F4E7DDF4E7DDF5E9E0F7ECE5F9
          F2EDFCF8F6FFFFFFB55510B5561180808000D07622FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD5D14A6
          9E7C80808000D07622FFFFFFFE0102FFFFFFFFFFFFF6E9E1F1DFD2F2E1D5F5E7
          DEF7ECE5FAF3EEFDFBFAFFFFFFFFFFFFC36618A4B29680808000D07622FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFCA6E1BCA6E1B80808000D0762257C9FF57C9FF57C9FF57C9FF57C9FF
          57C9FF57C9FF57C9FF57C9FF57C9FF2CBCFF49C5FFC6EDFFD0751FD0751F8080
          8000D07622BEEBFFBEEBFFC6EDFFC6EDFFC6EDFFC6EDFFC6EDFFC6EDFFC6EDFF
          C6ECFDC6EDFFFFFFFFFFFFFFD77D23AFBA9580808000D07622B8F3FEA6F0FEEC
          FCFFFFFFFFFFFEFEF6EBE3F6ECE4F5E8DFF9F1ECFDFBFAFFFFFFFFFFFFFFFFFF
          DE8527D0964980808000D07622F4FDFFCDF7FFFFFFFFFFFFFFFFFFFFFCF7F5FC
          F8F6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE58D2BE58D2B80808000D076
          22E8F6E891D491F4FBF3FFFFFFF3E3D8F3E3D9F3E3D9F6EAE2F6EAE2F9F1EBFF
          FFFFFFFFFFFFFFFFEB952EC5BA8180808000D07622DBF1DB67C466FCFEFCFFFF
          FFFBF6F2FBF5F1FBF6F2FCF8F6FCF8F5FDFAF9FFFFFFFFFFFFFFFFFFF19C32BB
          CA9D80808000D07622FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF9C32E2A85180808000D07622D07622
          4666B73C78C2A77254E38B2DE28A2DE08A2DE08A2EE18B2FE28C2DE28E2DE28C
          2DE38D2EE58F2EE38F2D80808000D07622DD86293B92CA4694BEA47862E08A2C
          E0882CE0892DE0892CDF892DE0892EE08A2DDF892CE0892CE08A2DDE882CFF00
          FF00FF00FFF8A436DF8729E38B2AEC9732F5A035F49E35F39E35F29D34F19D34
          F09C34EF9B33EF9A32F09B32F09B33FF00FFFF00FF00}
        Margin = 0
        OnClick = btnColumnClick
      end
      object btnGroup: TSpeedButton
        Left = 4
        Top = 32
        Width = 109
        Height = 28
        Caption = 'Group'
        Glyph.Data = {
          AA040000424DAA04000000000000360000002800000013000000130000000100
          1800000000007404000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FF7BDDFE7BDDFE7BDD
          FE7BDDFEA47874A47874A47874A47874A47874A47874A47874A47874A47874A4
          7874A47874A47874FF00FF000000FF00FF99FDFE7BDDFE7BDDFE7BDDFE7BDDFE
          A47874D8C5B5FECFC2FECFC2FECFC2FECFC2FECFC2FECFC2FECFC2FECFC2FECF
          C2FECFC2FECFC200000041B3DA99FDFE84E9FE84E9FE84E9FE84E9FEA47874DB
          C9C6F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7
          FEDDBB00000041B3DAADFBFE84E9FE84E9FE84E9FE84E9FECB9A82EADBD4F6EF
          E7FECC9AFECC9AFECC9AFECC9AFECC9AFECC9AFECC9AFECC9AF6EFE7FEDDBB00
          000041B3DAADFBFE8DF3FE84E9FE8DF3FE84E9FECB9A82EADBD4F6EFE7F6EFE7
          F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7F6EFE7FEDDBB00000041B3
          DAADFBFE8DF3FE8DF3FE8DF3FE8DF3FECB9A82EFE4D8F9F6F5FEDDBBFEDDBBFE
          DDBBFEDDBBFEDDBBFEDDBBFEDDBBFEDDBBF6EFE7FEDDBB00000041B3DAC2FDFF
          8DF3FE99FDFE8DF3FE99FDFEDCA887EFE4D8F9F6F5FECC9AFECC9AFECC9AFECC
          9AFECC9AFECC9AFECC9AFECC9AF6EFE7FEDDBB00000041B3DAC2FDFF99FDFE99
          FDFE99FDFE99FDFEDCA887F5EADFFFFEFEFFFFFFFFFCFBFEFAF7FFF8EEFEF4E9
          FEF4E9FEF0E2FEEBD7FEE4CAFED0B700000041B3DAD4FDFF99FDFE99FDFE99FD
          FE99FDFEE3B18EF5EADFFFFFFFFEFEFEFFFFFFFFFCFFFEF9F3FEF9F3FFF8EEFE
          F0E2F3E3D1F3B9B5FCA3A200000041B3DAD4FDFF99FDFEADFBFE99FDFEADFBFE
          EDBD92FEF4E9FFFFFEFEFEFEFBFBFCFBFBFCFAFAFAFAFAFAF9F6F5F8F3ECB481
          76E3B18ED8C5B500000041B3DAD4FDFFADFBFEADFBFEADFBFEADFBFEEDBD92DC
          A887DCA887DCA887DCA887DCA887DCA887DCA887DCA887DCA887B48176E5CDBE
          FF00FF00000041B3DAE4FDFEC2FDFFC2FDFFC2FDFFC2FDFFC2FDFFC2FDFFC2FD
          FFC2FDFFC2FDFFC2FDFFC2FDFFC2FDFFC2FDFFC2FDFF90D1F1059ACDFF00FF00
          000041B3DAE4FDFED4FDFFC2FDFFD4FDFFD4FDFFD4FDFFD4FDFFD4FDFFD4FDFF
          D4FDFFD4FDFFD4FDFFD4FDFFD4FDFFD4FDFF90D1F1059ACDFF00FF00000041B3
          DAF0FEFED4FDFFD4FDFFD4FDFFD4FDFFD4FDFFD4FDFFD4FDFFD4FDFFD4FDFFD4
          FDFFD4FDFFD4FDFFD4FDFFD4FDFF90D1F1059ACDFF00FF00000041B3DAF0FEFE
          E4FDFEE4FDFEE4FDFEE4FDFEE4FDFEE4FDFEE4FDFEE4FDFEE4FDFEE4FDFEE4FD
          FEE4FDFEE4FDFEE4FDFE90D1F1059ACDFF00FF000000FF00FF2EACD89BC3D89B
          C3D89BC3D89BC3D89BC3D89BC3D89BC3D89BC3D89BC3D89BC3D89BC3D89BC3D8
          9BC3D87ECBE6059ACDFF00FFFF00FF000000FF00FFFF00FF41B3DA41B3DA41B3
          DA41B3DA41B3DA41B3DA41B3DA41B3DA41B3DA41B3DA41B3DA41B3DA41B3DA4B
          BDE0FF00FFFF00FFFF00FF000000}
        Margin = 0
        OnClick = btnGroupClick
      end
      object cbxLanguage: TdxImageComboBox
        Left = 4
        Top = 62
        Width = 110
        Height = 24
        Alignment = taLeftJustify
        ImageAlign = dxliLeft
        ItemHeight = 0
        ImageList = DMGlobal.imgSmall
        MultiLines = False
        VertAlignment = tvaCenter
        Items.Strings = (
          'Spreadsheet'
          'HTML'
          'XML'
          'Text')
        TabOrder = 0
        OnChange = cbxLanguageChange
        SaveStrings = (
          '45,1'
          '46,2'
          '93,3'
          '47,4'
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          ''
          '')
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 395
      Width = 787
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        787
        41)
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 787
        Height = 6
        Align = alTop
        Shape = bsTopLine
      end
      object btnClose: TBitBtn
        Left = 702
        Top = 10
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = '&Close'
        ModalResult = 2
        TabOrder = 0
        OnClick = btnCloseClick
      end
    end
  end
  object cdsSaleItems: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 237
  end
  object dsSaleItems: TDataSource
    DataSet = cdsSaleItems
    Left = 40
    Top = 288
  end
  object cdsCashRegister: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 124
    Top = 245
  end
  object SD: TSaveDialog
    Left = 124
    Top = 188
  end
  object siLang: TsiLang
    Version = '6.1.0.1'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 3
    LangDispatcher = DMGlobal.LanguageDispatcher
    LangDelim = 1
    LangNames.Strings = (
      'English'
      'Portugu'#234's'
      'Espa'#241'ol')
    Language = 'English'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields')
    Left = 52
    Top = 100
    TranslationData = {
      737443617074696F6E730D0A5466726D53616C65734578706C6F726572015669
      7375616C697A61E7E36F2064652056656E6461730156697375616C697A61E7E3
      6F2064652056656E64617301010D0A50616E656C31010101010D0A4C6162656C
      310146726F6D014465014465010D0A4C6162656C3201746F016174E90141010D
      0A4C6162656C3301504F53203A0150445673203A0150445673203A010D0A706E
      6C46696C746572010101010D0A62746E5265667265736801474F210149522101
      495221010D0A706E6C47726964010101010D0A67726453616C654974656D7344
      425461626C6556696577494453746F72650153746F7265014C6F6A6101416C6D
      6163E96E010D0A67726453616C654974656D7344425461626C65566965775361
      6C654461746501446174650144617461014665636861010D0A67726453616C65
      4974656D7344425461626C655669657749444D6F64656C014465736372697074
      696F6E01446573637269E7E36F01446573637269706369F36E010D0A67726453
      616C654974656D7344425461626C6556696577466162726963616E7465014D61
      6E756661637475726501466162726963616E746501466162726963616369F36E
      010D0A67726453616C654974656D7344425461626C655669657756656E646101
      53616C650156656E64610156656E7461010D0A67726453616C654974656D7344
      425461626C6556696577437573746F01436F737401437573746F01436F737465
      010D0A67726453616C654974656D7344425461626C6556696577517464015174
      790151746401437464010D0A67726453616C654974656D734C6576656C010101
      010D0A62746E436F6C756D6E01436F6C756D6E01436F6C756E617301436F6C75
      6D6E61010D0A62746E47726F75700147726F7570014167727570617201477275
      706F010D0A50616E656C32010101010D0A62746E436C6F73650126436C6F7365
      014665266368617201436965727265010D0A6C626C5479706501547970650154
      69706F015469706F010D0A67726453616C654974656D7344425461626C655669
      657753616C6554696D650154696D6501486F7261015469656D706F010D0A6772
      6453616C654974656D7344425461626C655669657756656E646F720156656E64
      6F7201466F726E656365646F72015375727469646F72010D0A67726453616C65
      4974656D7344425461626C655669657743617465676F72790143617465676F72
      790143617465676F7269610143617465676F72ED61010D0A737448696E74730D
      0A5466726D53616C65734578706C6F72657201010D0A50616E656C3101010101
      0D0A426576656C31010101010D0A4C6162656C3101010D0A4C6162656C320101
      0D0A4C6162656C33010101010D0A706E6C46696C74657201010D0A636C624361
      736852656701010D0A656474426567696E4461746501010D0A656474456E6444
      61746501010D0A62746E5265667265736801010D0A706E6C4772696401010D0A
      67726453616C654974656D7301010D0A62746E436F6C756D6E01010D0A62746E
      47726F757001010D0A6362784C616E677561676501010D0A50616E656C320101
      0D0A62746E436C6F736501010D0A6C626C54797065010101010D0A636D624974
      656D54797065010101010D0A7374446973706C61794C6162656C730D0A737446
      6F6E74730D0A5466726D53616C65734578706C6F726572014D532053616E7320
      53657269660101010D0A706E6C46696C746572014D532053616E732053657269
      660101010D0A62746E52656672657368014D532053616E732053657269660101
      010D0A73744D756C74694C696E65730D0A636C62436173685265672E4974656D
      73010101010D0A6362784C616E67756167652E4974656D730153707265616473
      686565742C48544D4C2C584D4C2C5465787401457863656C2C48544D4C2C584D
      4C2C546578746F01457863656C2C48544D4C2C584D4C2C546578746F010D0A63
      6D624974656D547970652E4974656D73012253616C65204974656D73222C2252
      656D6F766564204974656D732201224974656E732056656E6469646F73222C22
      4974656E732052656D6F7669646F73220122417274ED63756C6F73206465206C
      612076656E7461222C22417274ED63756C6F73207175697461646F7322010D0A
      7374446C677343617074696F6E730D0A5761726E696E67015761726E696E6701
      01010D0A4572726F72014572726F720101010D0A496E666F726D6174696F6E01
      496E666F726D6174696F6E0101010D0A436F6E6669726D01436F6E6669726D01
      01010D0A59657301265965730101010D0A4E6F01264E6F0101010D0A4F4B014F
      4B0101010D0A43616E63656C0143616E63656C0101010D0A41626F7274012641
      626F72740101010D0A5265747279012652657472790101010D0A49676E6F7265
      012649676E6F72650101010D0A416C6C0126416C6C0101010D0A4E6F20546F20
      416C6C014E266F20746F20416C6C0101010D0A59657320546F20416C6C015965
      7320746F2026416C6C0101010D0A48656C70012648656C700101010D0A737453
      7472696E67730D0A73744F74686572537472696E67730D0A5466726D53616C65
      734578706C6F7265722E48656C7046696C65010101010D0A656474426567696E
      446174652E54657874010101010D0A656474456E64446174652E546578740101
      01010D0A67726453616C654974656D7344425461626C6556696577494453746F
      72652E50726F70657274696573436C6173734E616D65015463784C6F6F6B7570
      436F6D626F426F7850726F706572746965730101010D0A67726453616C654974
      656D7344425461626C655669657753616C65446174652E50726F706572746965
      73436C6173734E616D65010101010D0A67726453616C654974656D7344425461
      626C655669657749444D6F64656C2E50726F70657274696573436C6173734E61
      6D65015463784C6F6F6B7570436F6D626F426F7850726F706572746965730101
      010D0A67726453616C654974656D7344425461626C6556696577466162726963
      616E74652E50726F70657274696573436C6173734E616D65015463784C6F6F6B
      7570436F6D626F426F7850726F706572746965730101010D0A67726453616C65
      4974656D7344425461626C655669657756656E64612E50726F70657274696573
      436C6173734E616D650154637843757272656E63794564697450726F70657274
      6965730101010D0A67726453616C654974656D7344425461626C655669657743
      7573746F2E50726F70657274696573436C6173734E616D650154637843757272
      656E63794564697450726F706572746965730101010D0A67726453616C654974
      656D7344425461626C65566965775174642E50726F70657274696573436C6173
      734E616D65010101010D0A63647353616C654974656D732E436F6D6D616E6454
      657874010101010D0A63647353616C654974656D732E46696C74657201010101
      0D0A63647353616C654974656D732E496E6465784669656C644E616D65730101
      01010D0A63647353616C654974656D732E50726F76696465724E616D65010101
      010D0A6364734361736852656769737465722E436F6D6D616E64546578740101
      01010D0A6364734361736852656769737465722E46696C746572010101010D0A
      6364734361736852656769737465722E496E6465784669656C644E616D657301
      0101010D0A6364734361736852656769737465722E50726F76696465724E616D
      65010101010D0A53442E46696C746572010101010D0A53442E5469746C650101
      01010D0A636D624974656D547970652E54657874010101010D0A67726453616C
      654974656D7344425461626C655669657753616C6554696D652E50726F706572
      74696573436C6173734E616D65010101010D0A67726453616C654974656D7344
      425461626C655669657756656E646F722E50726F70657274696573436C617373
      4E616D65015463784C6F6F6B7570436F6D626F426F7850726F70657274696573
      0101010D0A67726453616C654974656D7344425461626C655669657743617465
      676F72792E50726F70657274696573436C6173734E616D65015463784C6F6F6B
      7570436F6D626F426F7850726F706572746965730101010D0A73744C6F63616C
      65730D0A43757272656E637920537472696E6701240101010D0A54686F757361
      6E6420536570617261746F72012C0101010D0A446563696D616C205365706172
      61746F72012E0101010D0A4461746520536570617261746F72012F0101010D0A
      53686F7274204461746520466F726D6174014D2F642F797979790101010D0A4C
      6F6E67204461746520466F726D617401646464642C204D4D4D4D2064642C2079
      7979790101010D0A54696D6520536570617261746F72013A0101010D0A54696D
      6520414D20537472696E6701414D0101010D0A54696D6520504D20537472696E
      6701504D0101010D0A53686F72742054696D6520466F726D617401683A6D6D20
      414D504D0101010D0A4C6F6E672054696D6520466F726D617401683A6D6D3A73
      7320414D504D0101010D0A53686F7274204D6F6E7468204E616D6573014A616E
      2C4665622C4D61722C4170722C4D61792C4A756E2C4A756C2C4175672C536570
      2C4F63742C4E6F762C4465630101010D0A4C6F6E67204D6F6E7468204E616D65
      73014A616E756172792C46656272756172792C4D617263682C417072696C2C4D
      61792C4A756E652C4A756C792C4175677573742C53657074656D6265722C4F63
      746F6265722C4E6F76656D6265722C446563656D6265720101010D0A53686F72
      7420446179204E616D65730153756E2C4D6F6E2C5475652C5765642C5468752C
      4672692C5361740101010D0A4C6F6E6720446179204E616D65730153756E6461
      792C4D6F6E6461792C547565736461792C5765646E65736461792C5468757273
      6461792C4672696461792C53617475726461790101010D0A7374436F6C6C6563
      74696F6E730D0A737443686172536574730D0A5466726D53616C65734578706C
      6F7265720144454641554C545F434841525345540101010D0A706E6C46696C74
      65720144454641554C545F43484152534554010D0A62746E5265667265736801
      44454641554C545F43484152534554010D0A}
  end
end
