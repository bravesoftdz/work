inherited FrmImportPO: TFrmImportPO
  Left = 206
  Top = 72
  Width = 1314
  Height = 636
  Caption = 'FrmImportPO'
  WindowState = wsMaximized
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 209
    Top = 40
    Width = 4
    Height = 517
  end
  inherited Panel2: TPanel
    Width = 1298
    inherited Image1: TImage
      Width = 1071
    end
    inherited lblMenu: TLabel
      Left = 980
    end
    inherited EspacamentoSuperior: TPanel
      Width = 1298
      inherited EEE: TPanel
        Width = 1298
      end
    end
  end
  inherited Panel1: TPanel
    Top = 557
    Width = 1298
    object lbDelItem: TLabel [2]
      Left = 719
      Top = 12
      Width = 263
      Height = 27
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 
        'Remove backordered items after receiving is enabled. After recei' +
        'ving, original PO can not be restored!!!'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    inherited EspacamentoInferior: TPanel
      Width = 1298
      inherited Panel3: TPanel
        Width = 1298
      end
    end
    inherited hhh: TPanel
      Left = 1039
      Width = 259
      object spHelp: TSpeedButton [0]
        Tag = 5
        Left = 6
        Top = 3
        Width = 65
        Height = 17
        Caption = '&Help'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          06030000424D060300000000000036000000280000000F0000000F0000000100
          180000000000D002000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFF3E1D7F4E3D9F4E3DAF3E2D8F3E1D7FF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FFF4E3D8F8FAFBE4E2E2CFB1A2D4
          AB96DDC6BBECF1F0F6F3F2F2E1D6FF00FFFF00FFFF00FF000000FF00FFFF00FF
          F5EAE2F4FFFFCF9A80B74C15B9643CD9AF9AC05823B95624D5AF9FF7FFFFF4E2
          D9FF00FFFF00FF000000FF00FFF2E1D7F8FFFFC77D58BB450CC64E13C2A495FF
          FFFFD9926FC14A0FB8450BCE9A80F8FFFFF2E0D6FF00FF000000FF00FFFAFAF9
          D8A890BD480DCD622ECD6029CB6B3AD88E68CA5E29CC622DC95D29B94710E0C9
          BDF6EDE8FF00FF000000F3E0D7F8FAFBC56232CA5C26CE6733CB5B23CA8969F7
          E7DFD06B38CA5A23CD6531C3531BC77850F8FCFDDCC8BE000000F3E1D8F2DED6
          C5561ECE6632CC6531CC5A21C28669FFFFFFE8AD91C44A0FCC622DCB5F28C35E
          2BF3F2F1F1DFD5000000F2E1D9F3D8CACD5B22CF6632CC642FCC602BC4551FCF
          B5A8FFFFFFE09C7AC7531ACD602BC65E29F5F1EDEFDED4000000F1E0D7FBEDE6
          DB6A32D36833CA5E28C95821C95419C14B10E2D0C6FFFFFFD0703FCD5A20CE6A
          38FCFBFBEEDDD2000000F1DED4FFFFFFF5986AE2662AC88B6DF0EAE3D77E51BD
          3000D79C7EFFFFFFDA8C65D15314E29A76FEFDFED3BDB2000000FF00FFF6F1EF
          FFEADBFF8A49DE875CEEFFFFFEFCFDE7B9A1FAFFFFF3F9FEE0723CE67035FFF3
          EEF4E7E0FF00FF000000FF00FFF1DED4FFFFFFFFE9CEFFB270ECAF87ECE2DFEB
          F0F4F1E4E0F6A478FE8C4DFFDECAFDFFFFF0DDD2FF00FF000000FF00FFFF00FF
          F0DFD6FFFFFFFFFFFBFFF3C6FEDDA8FCCF98FFC991FFD4A9FFFEF8FCFFFFF1DF
          D4FF00FFFF00FF000000FF00FFFF00FFFF00FFF1DCD3F5E8E4FDFCFDFFFFFFFF
          FFFFFFFFFFFCFBFDF3E6E0F1DDD2FF00FFFF00FFFF00FF000000FF00FFFF00FF
          FF00FFFF00FFFF00FFF1DCD1EFDBD0EFDBD1EFDCD1F1DBD0FF00FFFF00FFFF00
          FFFF00FFFF00FF000000}
        Margin = 5
        ParentFont = False
        OnClick = spHelpClick
      end
      object btnVideo: TSpeedButton [1]
        Tag = 5
        Left = 6
        Top = 19
        Width = 65
        Height = 16
        Caption = '&Video'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          D6020000424DD60200000000000036000000280000000F0000000E0000000100
          180000000000A002000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FF84474091251A961E1607A5CA07A5CA19839C556A6EFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FFA4331AB23011BA4327BA4F362B
          C7EC2BC7EC17C0E801AFD9226E80FF00FFFF00FFFF00FF000000FF00FFFF00FF
          B43B12C24D1DC8622FCE6A36D17A5143CCED43CCED4AC7E53AC4E402BBE82072
          84FF00FFFF00FF000000FF00FFB85328CB5B1BD0661DDE8F56F6DDCAFEF9F6F9
          FEFFD2F2FA73D6ED47C8E53BC3E301AFDA567179FF00FF000000FF00FFCE5C16
          DA741EE99C54F0EFEA888E93BEC0C1FBF9F9FFFFFFFFFFFF78D8EE48C7E51BC0
          E8138BA7FF00FF000000D0804AE17618EF8D21F4DEC1E9F1F81E1D1D131313A7
          A7A7CFCFCFFFFDFCE3F7FC4ACBEA37C5E707A8D0FF00FF000000CF7F46DE832B
          E9A448EAE7E0E9F1F84847481B1B1B0404041C1C1CCFCFCFE3E0E068D5ED38C0
          DE06A8CDFF00FF0000005373F01B4AFF4D73FFDADCE1E9F1F84847484E4E4E21
          2121080808646464EAE8E855B499288A72065A49FF00FF0000005373F01B4AFF
          4D73FFC5CBE1E9F1F84847486B6B6B797979C7C7C7FFFEFFE1EEE92CA1771C81
          5F0A533AFF00FF000000FF00FF1B48F84C71FF9EAFF5E9F1F86B6B6BC6C6C4EB
          E9E9F4EBEEF7EAEF67C4A0149B6D05734F2A6150FF00FF000000FF00FF3E63F4
          2E59FE5376FFA1B1F1C7CBDBD9D8D8D9D8D7C3DCD35FCEA301A96D068D610167
          45FF00FFFF00FF000000FF00FFFF00FF244EF7315AFE5376FF5D7DFF597AF530
          D1A80DD58401B773019C66017A4E578375FF00FFFF00FF000000FF00FFFF00FF
          FF00FF385EF51B47F9234DFC224EF901B99101BE7101A065098A5C689685FF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FF8EA2F25876EB3258EC1A
          A58B29AE785AA98CFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Margin = 5
        ParentFont = False
        OnClick = btnVideoClick
      end
      inherited btClose: TButton
        Left = 187
        Cancel = True
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btnSave: TBitBtn
        Left = 75
        Top = 4
        Width = 109
        Height = 30
        Anchors = [akTop, akRight]
        Caption = 'Import &PO'
        Default = True
        Enabled = False
        ModalResult = 1
        TabOrder = 1
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 517
  end
  inherited EspacamentoDireito: TPanel
    Left = 1295
    Height = 517
  end
  object pnlPO: TPanel [5]
    Left = 3
    Top = 40
    Width = 206
    Height = 517
    Align = alLeft
    BevelOuter = bvLowered
    Caption = 'pnlPO'
    TabOrder = 4
    object Label7: TLabel
      Left = 1
      Top = 1
      Width = 204
      Height = 18
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Purchase Orders'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object pnlPODetail: TPanel
      Left = 1
      Top = 424
      Width = 204
      Height = 92
      Align = alBottom
      BevelOuter = bvNone
      Color = clBtnShadow
      TabOrder = 0
      object Label8: TLabel
        Left = 33
        Top = 22
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'SubTotal :'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 4
        Top = 39
        Width = 78
        Height = 13
        Alignment = taRightJustify
        Caption = 'Other Charges :'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 47
        Top = 73
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Total :'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        Left = 41
        Top = 56
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'Freight :'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 22
        Top = 5
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'Order date :'
        Color = clGray
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object DBEdit1: TDBEdit
        Left = 87
        Top = 39
        Width = 111
        Height = 16
        AutoSize = False
        BorderStyle = bsNone
        DataField = 'Charges'
        DataSource = dsPO
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object DBEdit2: TDBEdit
        Left = 87
        Top = 22
        Width = 111
        Height = 16
        AutoSize = False
        BorderStyle = bsNone
        Color = clBtnFace
        DataField = 'SubTotal'
        DataSource = dsPO
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object DBEdit3: TDBEdit
        Left = 87
        Top = 56
        Width = 111
        Height = 16
        AutoSize = False
        BorderStyle = bsNone
        DataField = 'Freight'
        DataSource = dsPO
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object DBEdit4: TDBEdit
        Left = 87
        Top = 73
        Width = 111
        Height = 16
        AutoSize = False
        BorderStyle = bsNone
        Color = clBtnFace
        DataField = 'Total'
        DataSource = dsPO
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object DBEdit6: TDBEdit
        Left = 87
        Top = 5
        Width = 111
        Height = 16
        AutoSize = False
        BorderStyle = bsNone
        Color = clWhite
        DataField = 'DataPedido'
        DataSource = dsPO
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
    end
    object pnlPOToolBar: TPanel
      Left = 1
      Top = 19
      Width = 204
      Height = 25
      Align = alTop
      TabOrder = 1
      object DBEdit5: TDBEdit
        Left = 3
        Top = 5
        Width = 198
        Height = 16
        AutoSize = False
        BorderStyle = bsNone
        Color = clBtnFace
        DataField = 'Fornecedor'
        DataSource = dsPO
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
    end
    object grdPO: TcxGrid
      Left = 1
      Top = 44
      Width = 204
      Height = 380
      Align = alClient
      TabOrder = 2
      LookAndFeel.Kind = lfFlat
      object grdPODB: TcxGridDBTableView
        DataController.DataSource = dsPO
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDPO'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OnCellClick = grdPODBCellClick
        Filtering.MaxDropDownCount = 50
        Filtering.Visible = fvNever
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        object grdPODBIDPO: TcxGridDBColumn
          DataBinding.FieldName = 'IDPO'
          Width = 63
        end
        object grdPODBDataPedido: TcxGridDBColumn
          Caption = 'Date'
          DataBinding.FieldName = 'DataPedido'
          Width = 139
        end
      end
      object grdPOLevel: TcxGridLevel
        GridView = grdPODB
      end
    end
  end
  object pnlPOItem: TPanel [6]
    Left = 213
    Top = 40
    Width = 1082
    Height = 517
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'pnlPOItem'
    TabOrder = 5
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 1080
      Height = 18
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'PO Detail'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object grdPreSaleItem: TcxGrid
      Left = 1
      Top = 66
      Width = 967
      Height = 450
      Align = alClient
      TabOrder = 0
      object grdPreSaleItemDB: TcxGridDBTableView
        DataController.DataSource = dsPOItem
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDPreInventoryMov'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        Styles.Selection = cxHilight
        object grdPreSaleItemDBMarked: TcxGridDBColumn
          Caption = 'Checked'
          DataBinding.FieldName = 'Marked'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayUnchecked = 'False'
          Properties.ReadOnly = False
          Width = 51
        end
        object grdPreSaleItemDBQty: TcxGridDBColumn
          DataBinding.FieldName = 'QtyTotal'
          PropertiesClassName = 'TcxCalcEditProperties'
          Width = 73
        end
        object grdPreSaleItemDBQtyRealMov: TcxGridDBColumn
          DataBinding.FieldName = 'QtyRealMov'
          Visible = False
          Options.Editing = False
          Width = 65
        end
        object grdPreSaleItemDBVendorCode: TcxGridDBColumn
          Caption = 'Vendor Code'
          DataBinding.FieldName = 'VendorCode'
          Width = 104
        end
        object grdPreSaleItemDBModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Options.Editing = False
        end
        object grdPreSaleItemDBDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Options.Editing = False
          Width = 87
        end
        object grdPreSaleItemDBExtCaseCost: TcxGridDBColumn
          Caption = 'Ext Case Cost'
          DataBinding.FieldName = 'ExtCaseCost'
          Options.Editing = False
          Width = 78
        end
        object grdPreSaleItemDBCaseCost: TcxGridDBColumn
          Caption = 'Case Cost'
          DataBinding.FieldName = 'CaseCost'
          Width = 83
        end
        object grdPreSaleItemDBTotal: TcxGridDBColumn
          DataBinding.FieldName = 'CostPrice'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Properties.OnValidate = grdPreSaleItemDBTotalPropertiesValidate
          Width = 72
        end
        object grdPreSaleItemDBSalePrice: TcxGridDBColumn
          DataBinding.FieldName = 'SalePrice'
          Width = 69
        end
        object grdPreSaleItemDBSuggRetail: TcxGridDBColumn
          DataBinding.FieldName = 'SuggRetail'
          Width = 84
        end
        object grdPreSaleItemDBMarkup: TcxGridDBColumn
          DataBinding.FieldName = 'Markup'
          Visible = False
          Options.Editing = False
          Options.Filtering = False
          Width = 45
        end
        object grdPreSaleItemDBNewSalePrice: TcxGridDBColumn
          DataBinding.FieldName = 'NewSalePrice'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Properties.OnValidate = grdPreSaleItemDBTotalPropertiesValidate
          Styles.Content = cxValue
          Width = 99
        end
        object grdPreSaleItemDBNewSuggRetail: TcxGridDBColumn
          DataBinding.FieldName = 'NewSuggRetail'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Properties.OnValidate = grdPreSaleItemDBTotalPropertiesValidate
          Styles.Content = cxValue
          Width = 101
        end
      end
      object grdPreSaleItemLevel1: TcxGridLevel
        GridView = grdPreSaleItemDB
      end
    end
    object Panel4: TPanel
      Left = 968
      Top = 66
      Width = 113
      Height = 450
      Align = alRight
      TabOrder = 1
      object btMarked: TSpeedButton
        Tag = 7
        Left = 3
        Top = 2
        Width = 107
        Height = 26
        Hint = 'Export grid'
        Caption = 'Select all'
        Enabled = False
        Flat = True
        Glyph.Data = {
          76030000424D7603000000000000360000002800000011000000100000000100
          1800000000004003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF00FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8
          D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4
          FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFF00
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00
          FFFF00FF808080C8D0D4FFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF
          FFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFF
          FF000000000000000000000000000000FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
          00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFF000000000000FFFFFF0000
          00000000000000FFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF
          808080C8D0D4FFFFFF000000FFFFFFFFFFFFFFFFFF000000000000000000FFFF
          FFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFC8D0D4FF00FFFF00FFFF00
          FF00FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF000000FFFFFFC8D0D4FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8
          D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4
          FF00FFFF00FFFF00FF00FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8
          D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FF00FF00
          FFFF00FF80808080808080808080808080808080808080808080808080808080
          8080808080808080FF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
        Margin = 4
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = btMarkedClick
      end
      object btUnMarked: TSpeedButton
        Tag = 7
        Left = 3
        Top = 28
        Width = 107
        Height = 26
        Hint = 'Export grid'
        Caption = 'Un select all'
        Enabled = False
        Flat = True
        Glyph.Data = {
          EE030000424DEE03000000000000360000002800000012000000110000000100
          180000000000B803000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FF808080C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4
          C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
          808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
          808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FF808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
          808080C8D0D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFC8D0D4FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF808080C8D0D4C8D0
          D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4C8D0D4FF00FFFF
          00FFFF00FFFF00FF0000FF00FFFF00FF80808080808080808080808080808080
          8080808080808080808080808080808080808080FF00FFFF00FFFF00FFFF00FF
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
        Margin = 4
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = btUnMarkedClick
      end
      object btPOColumn: TSpeedButton
        Tag = 4
        Left = 4
        Top = 62
        Width = 106
        Height = 25
        GroupIndex = 1235
        Caption = 'Colum&ns'
        Flat = True
        Margin = 6
        Spacing = 7
        OnClick = btPOColumnClick
      end
      object Label2: TLabel
        Left = 4
        Top = 97
        Width = 42
        Height = 13
        Caption = 'Markup :'
      end
      object btnApply: TSpeedButton
        Left = 90
        Top = 94
        Width = 19
        Height = 21
        Enabled = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF84828400FFFF000000000000FF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF84828400FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00
          0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000FF
          FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF848284FFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000000000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00
          0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00
          FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00FFFF000000000000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF84
          8284FFFFFF00FFFF00FFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = btnApplyClick
      end
      object Panel9: TPanel
        Left = 7
        Top = 90
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 0
      end
      object edtMarkup: TEdit
        Left = 49
        Top = 94
        Width = 39
        Height = 21
        TabStop = False
        TabOrder = 1
        OnKeyPress = edtMarkupKeyPress
      end
      object Panel5: TPanel
        Left = 6
        Top = 57
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 2
      end
    end
    object pnlOption: TPanel
      Left = 1
      Top = 19
      Width = 1080
      Height = 47
      Align = alTop
      TabOrder = 2
      Visible = False
      object chkUpdateSalePrice: TCheckBox
        Left = 8
        Top = 5
        Width = 329
        Height = 17
        Caption = 'Update Sale Price after Final Receiving items'
        TabOrder = 0
      end
      object chkCalcTax: TCheckBox
        Left = 8
        Top = 26
        Width = 329
        Height = 17
        Caption = 'Auto-Calculate vendor tax'
        TabOrder = 1
      end
    end
  end
  object quPO: TADOQuery [7]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quPOCalcFields
    CommandTimeout = 900
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDFornecedor'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PO.IDPO,'
      #9'PO.IDFornecedor,'
      #9'PE.Pessoa Fornecedor,'
      #9'PO.DataPedido,'
      #9'PO.Aberto,'
      #9'PO.SubTotal,'
      #9'PO.Atendido,'
      #9'PO.EstArrival,'
      #9'PO.IDStore,'
      #9'PO.Charges,'
      #9'PO.Freight,'
      #9'PO.PaymenteType,'
      #9'PO.PayDays,'
      #9'PE.Code,'
      #9'PE.IDEstado,'
      #9'S.[Name] Store'
      'FROM'
      #9'PO PO (NOLOCK)'
      #9'JOIN Store S (NOLOCK) ON (PO.IDStore= S.IDStore)'
      
        #9'LEFT OUTER JOIN Pessoa PE (NOLOCK) ON (PO.IDFornecedor = PE.IDP' +
        'essoa)'
      'WHERE'
      #9'PO.IDStore = :IDStore'
      #9'AND PO.IDFornecedor = :IDFornecedor'
      #9'AND PO.SubTotal <> 0'
      #9'AND PO.Aberto = 1')
    Left = 74
    Top = 140
    object quPOIDPO: TIntegerField
      FieldName = 'IDPO'
      Origin = 'PO.IDPO'
    end
    object quPOIDFornecedor: TIntegerField
      FieldName = 'IDFornecedor'
      Origin = 'PO.IDFornecedor'
    end
    object quPODataPedido: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'DataPedido'
      Origin = 'PO.DataPedido'
      DisplayFormat = 'ddddd'
    end
    object quPOSubTotal: TFloatField
      FieldName = 'SubTotal'
      Origin = 'PO.SubTotal'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quPOIDStore: TIntegerField
      FieldName = 'IDStore'
      Origin = 'PO.IDStore'
    end
    object quPOCharges: TFloatField
      FieldName = 'Charges'
      Origin = 'PO.Charges'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quPOFreight: TFloatField
      FieldName = 'Freight'
      Origin = 'PO.Freight'
      DisplayFormat = '#,##0.00'
      currency = True
    end
    object quPOTotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Total'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quPOFornecedor: TStringField
      FieldName = 'Fornecedor'
      Origin = 'RETAIL.Pessoa.Pessoa'
      Size = 50
    end
    object quPOStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quPOEstArrival: TDateTimeField
      FieldName = 'EstArrival'
    end
    object quPOPayDays: TIntegerField
      FieldName = 'PayDays'
    end
    object quPOIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
  end
  object dsPO: TDataSource [8]
    DataSet = quPO
    Left = 74
    Top = 192
  end
  object quPOItem: TPowerADOQuery [9]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'PIM.IDPreInventoryMov,'#13#10#9'PIM.DocumentID,'#13#10#9'IsNull(SubMo' +
      'del.QtySubItem, PIM.Qty) Qty,'#13#10#9'IsNull(SubModel.QtySubRealMov, P' +
      'IM.QtyRealMov) QtyRealMov,'#13#10#9'PIM.MovDate,'#13#10#9'M.ModelType,'#13#10#9'PIM.D' +
      'ateEstimatedMov,'#13#10#9'Round(PIM.CostPrice,2) CostPrice,'#13#10#9'PIM.SaleP' +
      'rice,'#13#10#9'(CASE Round(PIM.SalePrice,2) WHEN 0 THEN M.SellingPrice ' +
      'ELSE Round(PIM.SalePrice,2) END) NewSalePrice,'#13#10#9'(CASE Round(PIM' +
      '.SuggRetail,2) WHEN 0 THEN M.SuggRetail ELSE Round(PIM.SuggRetai' +
      'l,2) END) NewSuggRetail,'#13#10#9'PIM.CaseQty,'#13#10#9'PIM.CaseCost,'#13#10#9'(PIM.C' +
      'aseQty * PIM.CaseCost) as ExtCaseCost,'#13#10#9'PIM.SuggRetail,'#13#10#9'PIM.M' +
      'arked,'#13#10#9'(IsNull(SubModel.SubItemTotal, (PIM.Qty * PIM.CostPrice' +
      '))) SubTotal,'#13#10#9'(IsNull(SubModel.QtySubItem, PIM.Qty) - IsNull(S' +
      'ubModel.QtySubRealMov, PIM.QtyRealMov)) QtyTotal,'#13#10#9'M.IDModel,'#13#10 +
      #9'M.Model,'#13#10#9'M.GroupID,'#13#10#9'M.IDModelGroup,'#13#10#9'M.IDModelSubGroup,'#13#10#9 +
      'M.SellingPrice CurrentSale,'#13#10#9'M.VendorCost CurrentCost,'#13#10#9'M.Sugg' +
      'Retail CurrentSuggRetail,'#13#10#9'M.[Description],'#13#10#9'(CASE WHEN ISNULL' +
      '(MV.CaseQty, -1) < 2 THEN IsNull(M.CaseQty,0) ELSE MV.CaseQty EN' +
      'D) as ModelCaseQty,'#13#10#9'M.Markup ModelMarkup,'#13#10#9'P.Pessoa,'#13#10#9'TG.[Na' +
      'me] Category,'#13#10#9'S.SizeName [Size],'#13#10#9'S.CodSize,'#13#10#9'C.Color,'#13#10#9'C.C' +
      'odColor,'#13#10#9'CASE WHEN PIM.SalePrice > 0 AND PIM.CostPrice <> 0 TH' +
      'EN (PIM.SalePrice - PIM.CostPrice)/PIM.CostPrice * 100 END as Ma' +
      'rkup,'#13#10#9'('#13#10#9'SELECT TOP 1'#13#10#9#9'VendorCode '#13#10#9'FROM '#13#10#9#9'VendorModelCo' +
      'de (NOLOCK)'#13#10#9'WHERE'#13#10#9#9'IDPessoa = PO.IDFornecedor'#13#10#9#9'AND'#13#10#9#9'IDMo' +
      'del = M.IDModel'#13#10#9') as VendorCode,'#13#10#9'NCM.MVAInterno,'#13#10#9'NCM.MVAIn' +
      'terestadual,'#13#10#9'NCM.Incide,'#13#10'                M.UpdatePrice'#13#10'FROM'#13 +
      #10#9'PreInventoryMov PIM (NOLOCK)'#13#10#9'JOIN PO (NOLOCK) ON (PIM.Docume' +
      'ntID = PO.IDPO AND PIM.InventMovTypeID = 2)'#13#10#9'JOIN Model M (NOLO' +
      'CK) ON (PIM.ModelID = M.IDModel)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON ' +
      '(M.GroupID = TG.IDGroup)'#13#10#9'LEFT OUTER JOIN InvColor C (NOLOCK) O' +
      'N (M.IDColor = C.IDColor)'#13#10#9'LEFT OUTER JOIN InvSize S (NOLOCK) O' +
      'N (M.IDSize = S.IDSize)'#13#10#9'LEFT OUTER JOIN Pessoa P (NOLOCK) ON (' +
      'M.IDFabricante = P.IDPessoa)'#13#10#9'LEFT OUTER JOIN Inv_ModelVendor M' +
      'V (NOLOCK) ON (MV.IDModel = M.IDModel and MV.IDPessoa = PO.IDFor' +
      'necedor)'#13#10#9'LEFT OUTER JOIN Inv_NCM NCM (NOLOCK) ON (NCM.IDNCM = ' +
      'M.IDNCM)'#13#10#9'LEFT OUTER JOIN'#9'('#13#10#9#9#9'SELECT'#13#10#9#9#9#9'SUM(IsNull(PIMT.Qty' +
      ',0)) QtySubItem,'#13#10#9#9#9#9'SUM(IsNull(PIMT.QtyRealMov,0)) QtySubRealM' +
      'ov,'#13#10#9#9#9#9'SUM(IsNull(PIMT.Qty,0) * IsNull(PIMT.CostPrice,0)) SubI' +
      'temTotal,'#13#10#9#9#9#9'PIMT.IDPreInventoryMovParent'#13#10#9#9#9'FROM'#13#10#9#9#9#9'PreInv' +
      'entoryMov PIMT (NOLOCK)'#13#10#9#9#9'GROUP BY'#13#10#9#9#9#9'PIMT.IDPreInventoryMov' +
      'Parent'#13#10#9#9#9') as SubModel ON (SubModel.IDPreInventoryMovParent = ' +
      'PIM.IDPreInventoryMov)'#13#10'WHERE'#13#10#9'PIM.DocumentID = :IDPO'#13#10#9'AND PIM' +
      '.InventMovTypeID = 2'#13#10#9'AND M.ModelType IN ('#39'R'#39', '#39'S'#39')'#13#10#9'AND IsNul' +
      'l(SubModel.QtySubItem, PIM.Qty) > IsNull(SubModel.QtySubRealMov,' +
      ' PIM.QtyRealMov)'#13#10#9'AND PIM.Qty <> 0'#13#10#13#10#13#10
    CommandTimeout = 900
    Parameters = <
      item
        Name = 'IDPO'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 279
    Top = 145
    object quPOItemIDPreInventoryMov: TIntegerField
      FieldName = 'IDPreInventoryMov'
      ReadOnly = True
    end
    object quPOItemDocumentID: TIntegerField
      FieldName = 'DocumentID'
      ReadOnly = True
    end
    object quPOItemIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object quPOItemModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object quPOItemDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object quPOItemCostPrice: TFloatField
      DisplayLabel = 'Cost Price'
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object quPOItemSalePrice: TFloatField
      DisplayLabel = 'Sale Price'
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
    end
    object quPOItemSuggRetail: TFloatField
      DisplayLabel = 'Sugg. Retail'
      FieldName = 'SuggRetail'
      DisplayFormat = '#,##0.00'
    end
    object quPOItemSubTotal: TFloatField
      FieldName = 'SubTotal'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object quPOItemPessoa: TStringField
      DisplayLabel = 'Manufacturer'
      FieldName = 'Pessoa'
      ReadOnly = True
      Size = 50
    end
    object quPOItemMovDate: TDateTimeField
      DisplayLabel = 'Ordered Date'
      FieldName = 'MovDate'
      ReadOnly = True
      DisplayFormat = 'ddddd'
    end
    object quPOItemDateEstimatedMov: TDateTimeField
      DisplayLabel = 'Arrive Date'
      FieldName = 'DateEstimatedMov'
      ReadOnly = True
      DisplayFormat = 'ddddd'
    end
    object quPOItemCurrentSale: TFloatField
      DisplayLabel = 'Current Sale Price'
      FieldName = 'CurrentSale'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object quPOItemCurrentCost: TFloatField
      DisplayLabel = 'Current Cost Price'
      FieldName = 'CurrentCost'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object quPOItemCurrentSuggRetail: TFloatField
      DisplayLabel = 'Current Sugg. Retail'
      FieldName = 'CurrentSuggRetail'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
    end
    object quPOItemCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object quPOItemSize: TStringField
      FieldName = 'Size'
      ReadOnly = True
    end
    object quPOItemCodSize: TStringField
      DisplayLabel = 'Size Code'
      FieldName = 'CodSize'
      ReadOnly = True
      Size = 10
    end
    object quPOItemColor: TStringField
      FieldName = 'Color'
      ReadOnly = True
    end
    object quPOItemCodColor: TStringField
      DisplayLabel = 'Color Code'
      FieldName = 'CodColor'
      ReadOnly = True
      Size = 10
    end
    object quPOItemModelType: TStringField
      FieldName = 'ModelType'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object quPOItemGroupID: TIntegerField
      FieldName = 'GroupID'
      ReadOnly = True
    end
    object quPOItemMarked: TBooleanField
      FieldName = 'Marked'
    end
    object quPOItemQty: TFloatField
      FieldName = 'Qty'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quPOItemQtyRealMov: TFloatField
      FieldName = 'QtyRealMov'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quPOItemQtyTotal: TFloatField
      FieldName = 'QtyTotal'
      DisplayFormat = '0.#####'
    end
    object quPOItemCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
    object quPOItemCaseCost: TBCDField
      FieldName = 'CaseCost'
      Precision = 19
    end
    object quPOItemIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
    end
    object quPOItemIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
    end
    object quPOItemNewSalePrice: TBCDField
      FieldName = 'NewSalePrice'
      Precision = 19
    end
    object quPOItemNewSuggRetail: TBCDField
      FieldName = 'NewSuggRetail'
      Precision = 19
    end
    object quPOItemMarkup: TBCDField
      FieldName = 'Markup'
      DisplayFormat = '#0.00 %'
      Precision = 19
    end
    object quPOItemModelMarkup: TBCDField
      FieldName = 'ModelMarkup'
      Precision = 19
    end
    object quPOItemModelCaseQty: TBCDField
      FieldName = 'ModelCaseQty'
      Precision = 32
    end
    object quPOItemExtCaseCost: TBCDField
      FieldName = 'ExtCaseCost'
      Precision = 32
      Size = 6
    end
    object quPOItemVendorCode: TStringField
      FieldName = 'VendorCode'
      ReadOnly = True
      Size = 35
    end
    object quPOItemMVAInterno: TBCDField
      FieldName = 'MVAInterno'
      Precision = 32
    end
    object quPOItemMVAInterestadual: TBCDField
      FieldName = 'MVAInterestadual'
      Precision = 32
    end
    object quPOItemIncide: TBooleanField
      FieldName = 'Incide'
    end
    object quPOItemUpdatePrice: TBooleanField
      FieldName = 'UpdatePrice'
    end
  end
  object dsPOItem: TDataSource [10]
    DataSet = cdsPOItem
    Left = 276
    Top = 305
  end
  object quCreateOrder: TADOCommand [11]
    CommandText = 
      'INSERT'#13#10#9'Pur_PurchaseItem'#13#10#9'('#13#10#9'IDPurchaseItem,'#13#10'        IDPurch' +
      'ase,'#13#10'        IDModel,'#13#10'        Qty,'#13#10'        IDGroup,'#13#10'        ' +
      'NewCostPrice,'#13#10'        NewSalePrice,'#13#10'        NewSuggRetail,'#13#10'  ' +
      '      IDFornecedor,'#13#10'        IDPOItem,'#13#10#9'CostPrice,'#13#10#9'CaseQty,'#13#10 +
      #9'CaseCost'#13#10#9')'#13#10'VALUES'#13#10#9'('#13#10#9':IDPurchaseItem,'#13#10#9':IDPurchase,'#13#10#9':I' +
      'DModel,'#13#10#9':Qty,'#13#10#9':GroupID,'#13#10#9':CostPrice,'#13#10#9':SalePrice,'#13#10#9':SuggR' +
      'etail,'#13#10#9':IDVendor,'#13#10#9':IDPreInventoryMov,'#13#10#9':CostWithTax,'#13#10#9':Cas' +
      'eQty,'#13#10#9':CaseCost'#13#10#9')'
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'Qty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'GroupID'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'CostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SalePrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'SuggRetail'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDVendor'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDPreInventoryMov'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'CostWithTax'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'CaseQty'
        Attributes = [paSigned, paNullable]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'CaseCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end>
    Left = 488
    Top = 161
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmImportPO.sil'
  end
  object cdsPOItem: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDPO'
        ParamType = ptInput
      end>
    ProviderName = 'dspPOItem'
    AfterOpen = cdsPOItemAfterOpen
    BeforePost = cdsPOItemBeforePost
    Left = 277
    Top = 252
    object cdsPOItemIDPreInventoryMov: TIntegerField
      FieldName = 'IDPreInventoryMov'
      ReadOnly = True
    end
    object cdsPOItemDocumentID: TIntegerField
      FieldName = 'DocumentID'
      ReadOnly = True
    end
    object cdsPOItemIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object cdsPOItemModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object cdsPOItemDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object cdsPOItemCostPrice: TFloatField
      FieldName = 'CostPrice'
      OnChange = cdsPOItemCostPriceChange
    end
    object cdsPOItemSalePrice: TFloatField
      FieldName = 'SalePrice'
      ReadOnly = True
    end
    object cdsPOItemSuggRetail: TFloatField
      FieldName = 'SuggRetail'
      ReadOnly = True
    end
    object cdsPOItemSubTotal: TFloatField
      FieldName = 'SubTotal'
      ReadOnly = True
    end
    object cdsPOItemPessoa: TStringField
      FieldName = 'Pessoa'
      ReadOnly = True
      Size = 50
    end
    object cdsPOItemMovDate: TDateTimeField
      FieldName = 'MovDate'
      ReadOnly = True
    end
    object cdsPOItemDateEstimatedMov: TDateTimeField
      FieldName = 'DateEstimatedMov'
      ReadOnly = True
    end
    object cdsPOItemCurrentSale: TFloatField
      FieldName = 'CurrentSale'
      ReadOnly = True
    end
    object cdsPOItemCurrentCost: TFloatField
      FieldName = 'CurrentCost'
      ReadOnly = True
    end
    object cdsPOItemCurrentSuggRetail: TFloatField
      FieldName = 'CurrentSuggRetail'
      ReadOnly = True
    end
    object cdsPOItemCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object cdsPOItemSize: TStringField
      FieldName = 'Size'
      ReadOnly = True
    end
    object cdsPOItemCodSize: TStringField
      FieldName = 'CodSize'
      ReadOnly = True
      Size = 10
    end
    object cdsPOItemColor: TStringField
      FieldName = 'Color'
      ReadOnly = True
    end
    object cdsPOItemCodColor: TStringField
      FieldName = 'CodColor'
      ReadOnly = True
      Size = 10
    end
    object cdsPOItemModelType: TStringField
      FieldName = 'ModelType'
      ReadOnly = True
      FixedChar = True
      Size = 1
    end
    object cdsPOItemGroupID: TIntegerField
      FieldName = 'GroupID'
      ReadOnly = True
    end
    object cdsPOItemMarked: TBooleanField
      FieldName = 'Marked'
    end
    object cdsPOItemQty: TFloatField
      FieldName = 'Qty'
      ReadOnly = True
    end
    object cdsPOItemQtyRealMov: TFloatField
      FieldName = 'QtyRealMov'
      ReadOnly = True
    end
    object cdsPOItemQtyTotal: TFloatField
      FieldName = 'QtyTotal'
    end
    object cdsPOItemCaseQty: TFloatField
      FieldName = 'CaseQty'
      ReadOnly = True
    end
    object cdsPOItemCaseCost: TBCDField
      FieldName = 'CaseCost'
      OnChange = cdsPOItemCaseCostChange
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsPOItemIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
    end
    object cdsPOItemIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
    end
    object cdsPOItemNewSalePrice: TBCDField
      FieldName = 'NewSalePrice'
      OnChange = cdsPOItemNewSalePriceChange
      Precision = 19
    end
    object cdsPOItemNewSuggRetail: TBCDField
      FieldName = 'NewSuggRetail'
      Precision = 19
    end
    object cdsPOItemMarkup: TBCDField
      FieldName = 'Markup'
      DisplayFormat = '0.00 %'
      Precision = 19
    end
    object cdsPOItemModelMarkup: TBCDField
      FieldName = 'ModelMarkup'
      Precision = 19
    end
    object cdsPOItemModelCaseQty: TBCDField
      FieldName = 'ModelCaseQty'
      DisplayFormat = '#,##0.00'
      Precision = 32
    end
    object cdsPOItemExtCaseCost: TBCDField
      FieldName = 'ExtCaseCost'
      DisplayFormat = '#,##0.00'
      Precision = 32
      Size = 6
    end
    object cdsPOItemVendorCode: TStringField
      FieldName = 'VendorCode'
      ReadOnly = True
      Size = 35
    end
    object cdsPOItemMVAInterno: TBCDField
      FieldName = 'MVAInterno'
      Precision = 32
    end
    object cdsPOItemMVAInterestadual: TBCDField
      FieldName = 'MVAInterestadual'
      Precision = 32
    end
    object cdsPOItemIncide: TBooleanField
      FieldName = 'Incide'
    end
    object cdsPOItemUpdatePrice: TBooleanField
      FieldName = 'UpdatePrice'
    end
  end
  object dspPOItem: TDataSetProvider
    DataSet = quPOItem
    Options = [poIncFieldProps]
    Left = 277
    Top = 196
  end
  object cmdUpdateTaxCost: TADOCommand
    CommandText = 
      'UPDATE '#13#10#9'PUI'#13#10'SET '#13#10#9'NewCostPrice = :NewCostPrice,'#13#10#9'NewSalePri' +
      'ce = :NewSalePrice,'#13#10#9'NewSuggRetail = :NewSuggRetail'#13#10'FROM'#13#10#9'Pur' +
      '_PurchaseItem PUI'#13#10'WHERE'#13#10#9'IDPurchaseItem = :IDPurchaseItem'#13#10
    CommandTimeout = 900
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'NewCostPrice'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'NewSalePrice'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'NewSuggRetail'
        DataType = ftFloat
        Size = -1
        Value = Null
      end
      item
        Name = 'IDPurchaseItem'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 489
    Top = 220
  end
  object strepPredefined: TcxStyleRepository
    Left = 488
    Top = 279
    object cxHilight: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = 8404992
    end
    object cxValue: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = 12615680
    end
    object GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet
      Caption = 'DevExpress'
      Styles.Header = cxHilight
    end
  end
end
