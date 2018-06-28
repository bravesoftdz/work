inherited frmModelPriceAdj: TfrmModelPriceAdj
  Left = 108
  Top = 7
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Selling Prices Adjust'
  ClientHeight = 462
  ClientWidth = 701
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 701
    TabOrder = 2
    DesignSize = (
      701
      40)
    inherited lblSubMenu: TLabelEffect [1]
    end
    inherited lblMenu: TLabel
      Left = 484
    end
    inherited Image1: TImage [3]
      Width = 474
    end
    inherited EspacamentoSuperior: TPanel
      Width = 701
      inherited EEE: TPanel
        Width = 701
      end
    end
  end
  inherited Panel1: TPanel
    Top = 421
    Width = 701
    TabOrder = 1
    inherited EspacamentoInferior: TPanel
      Width = 701
      inherited Panel3: TPanel
        Width = 701
      end
    end
    inherited hhh: TPanel
      Left = 558
      Width = 143
      inherited btClose: TButton
        Left = 74
        Cancel = True
        Caption = '&Cancel'
        ModalResult = 2
        OnClick = btCloseClick
      end
      object btOk: TButton
        Left = 4
        Top = 3
        Width = 66
        Height = 31
        Caption = '&OK'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btOkClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 381
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 698
    Height = 381
    TabOrder = 4
  end
  object pgModelInfo: TPageControl [4]
    Left = 3
    Top = 40
    Width = 695
    Height = 381
    ActivePage = tsPrice
    Align = alClient
    TabOrder = 0
    OnChanging = pgModelInfoChanging
    object tsPrice: TTabSheet
      Caption = '  Price Range  '
      DesignSize = (
        687
        353)
      object Label4: TLabel
        Left = 248
        Top = -1
        Width = 437
        Height = 16
        AutoSize = False
        Caption = '  List of Categories'
        Color = clBtnShadow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object btSelectAll: TSpeedButton
        Tag = 7
        Left = 575
        Top = 19
        Width = 111
        Height = 26
        Hint = 'Export grid'
        Caption = 'Select all'
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
        OnClick = btSelectAllClick
      end
      object btUnSelectAll: TSpeedButton
        Tag = 7
        Left = 575
        Top = 45
        Width = 111
        Height = 26
        Hint = 'Export grid'
        Caption = 'Un select all'
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
        OnClick = btUnSelectAllClick
      end
      object Label1: TLabel
        Left = 24
        Top = 40
        Width = 78
        Height = 13
        Caption = 'Adjust Based on'
      end
      object Label2: TLabel
        Left = 24
        Top = 84
        Width = 47
        Height = 13
        Caption = 'Calc Type'
      end
      object lblValue: TLabel
        Left = 24
        Top = 128
        Width = 59
        Height = 13
        Caption = 'Percent (%)'
      end
      object Label3: TLabel
        Left = 174
        Top = 143
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
      object clbCategories: TCheckListBox
        Left = 247
        Top = 16
        Width = 327
        Height = 337
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 4
      end
      object cmbAdjType: TComboBox
        Left = 24
        Top = 56
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'Selling Price'
          'Profit')
      end
      object cmbCalcType: TComboBox
        Left = 24
        Top = 100
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cmbCalcTypeChange
        Items.Strings = (
          'Percent (%)'
          'Amount ($)')
      end
      object edtValue: TEdit
        Left = 24
        Top = 144
        Width = 145
        Height = 21
        TabOrder = 2
        OnKeyPress = edtValueKeyPress
      end
      object grdPriceRange: TGroupBox
        Left = 24
        Top = 172
        Width = 201
        Height = 73
        Caption = ' Selling Price Range '
        TabOrder = 3
        object Label5: TLabel
          Left = 17
          Top = 24
          Width = 24
          Height = 13
          Caption = 'From'
        end
        object Label6: TLabel
          Left = 29
          Top = 48
          Width = 12
          Height = 13
          Caption = 'To'
        end
        object edtPrice1: TEdit
          Left = 48
          Top = 20
          Width = 97
          Height = 21
          TabOrder = 0
          OnKeyPress = edtValueKeyPress
        end
        object edtPrice2: TEdit
          Left = 48
          Top = 44
          Width = 97
          Height = 21
          TabOrder = 1
          OnKeyPress = edtValueKeyPress
        end
      end
    end
    object tsFloating: TTabSheet
      Caption = '  Floating  '
      ImageIndex = 1
      object lbCateg: TLabel
        Left = 32
        Top = 16
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'Category :'
      end
      object lbManu: TLabel
        Left = 12
        Top = 44
        Width = 72
        Height = 13
        Alignment = taRightJustify
        Caption = 'Manufacturer :'
      end
      object btnRefresh: TSpeedButton
        Left = 628
        Top = 18
        Width = 46
        Height = 32
        Caption = '&GO'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333000003333333333F777773FF333333008877700
          33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
          703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
          77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
          07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
          780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
          8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
          3333333773FFFF77333333333000003333333333377777333333}
        Layout = blGlyphRight
        NumGlyphs = 2
        OnClick = btnGoClick
      end
      object lblVendor: TLabel
        Left = 347
        Top = 16
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vendor :'
      end
      object lbNewFloat: TLabel
        Left = 343
        Top = 44
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = 'New % :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object scGroup: TSuperComboADO
        Left = 88
        Top = 12
        Width = 181
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        CodeLength = 315
        LookUpSource = DM.dsLookUpGroup
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        EditCodePos = taEditCodeRight
        IDLanguage = 0
      end
      object btGroupAll: TButton
        Left = 272
        Top = 12
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 1
        OnClick = btGroupAllClick
      end
      object scFabricante: TSuperComboADO
        Left = 88
        Top = 40
        Width = 181
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        LookUpSource = DM.dsLookUpFabricante
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btFabricanteAll: TButton
        Left = 272
        Top = 40
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 3
        OnClick = btFabricanteAllClick
      end
      object grdFloating: TcxGrid
        Left = 0
        Top = 68
        Width = 685
        Height = 285
        TabOrder = 4
        LookAndFeel.Kind = lfFlat
        object grdFloatingTableView: TcxGridDBTableView
          DataController.DataSource = dsModelFloating
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDModel'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object grdFloatingTableViewModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Options.Editing = False
            Width = 89
          end
          object grdFloatingTableViewDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Options.Editing = False
            Width = 147
          end
          object grdFloatingTableViewName: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Options.Editing = False
            Width = 89
          end
          object grdFloatingTableViewPessoa: TcxGridDBColumn
            DataBinding.FieldName = 'Pessoa'
            Options.Editing = False
            Width = 98
          end
          object grdFloatingTableViewFloatPercent: TcxGridDBColumn
            DataBinding.FieldName = 'FloatPercent'
            Width = 80
          end
        end
        object grdFloatingLevel: TcxGridLevel
          GridView = grdFloatingTableView
        end
      end
      object scVendor: TSuperComboADO
        Left = 392
        Top = 12
        Width = 181
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        LookUpSource = DM.dsLookUpFornecedor
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btVendorAll: TButton
        Left = 576
        Top = 12
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 6
        OnClick = btVendorAllClick
      end
      object edtNewFloat: TEdit
        Left = 392
        Top = 40
        Width = 181
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        OnKeyPress = edtValueKeyPress
      end
    end
    object tsPricing: TTabSheet
      Caption = '  Price  '
      ImageIndex = 2
      object lbCate1: TLabel
        Left = 40
        Top = 44
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'Category :'
      end
      object lbManu1: TLabel
        Left = 20
        Top = 72
        Width = 72
        Height = 13
        Alignment = taRightJustify
        Caption = 'Manufacturer :'
      end
      object lbVer: TLabel
        Left = 360
        Top = 16
        Width = 42
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vertical :'
      end
      object lbHor: TLabel
        Left = 348
        Top = 44
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'Horizontal :'
      end
      object lbNew: TLabel
        Left = 41
        Top = 100
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = 'Adjust to :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbDesc: TLabel
        Left = 344
        Top = 72
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'Description :'
      end
      object btnPriceGo: TSpeedButton
        Left = 628
        Top = 34
        Width = 46
        Height = 32
        Caption = '&GO'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          0400000000000001000000000000000000001000000010000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333000003333333333F777773FF333333008877700
          33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
          703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
          77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
          07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
          780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
          8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
          3333333773FFFF77333333333000003333333333377777333333}
        Layout = blGlyphRight
        NumGlyphs = 2
        OnClick = btnGoClick
      end
      object lblStore: TLabel
        Left = 59
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'Store :'
      end
      object scCategoryPrice: TSuperComboADO
        Left = 96
        Top = 40
        Width = 163
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        CodeLength = 315
        LookUpSource = DM.dsLookUpGroup
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        EditCodePos = taEditCodeRight
        IDLanguage = 0
      end
      object scManufacturePrice: TSuperComboADO
        Left = 96
        Top = 68
        Width = 163
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        LookUpSource = DM.dsLookUpFabricante
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btnManuAll: TButton
        Left = 264
        Top = 68
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 5
        OnClick = btnManuAllClick
      end
      object scVerticalPrice: TSuperComboADO
        Left = 408
        Top = 12
        Width = 163
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        LookUpSource = DM.dsLookUpColor
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btnVerticalAll: TButton
        Left = 576
        Top = 12
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 7
        OnClick = btnVerticalAllClick
      end
      object scHorizontalPrice: TSuperComboADO
        Left = 408
        Top = 40
        Width = 163
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        LookUpSource = DM.dsLookUpSize
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object btnHorizAll: TButton
        Left = 576
        Top = 40
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 9
        OnClick = btnHorizAllClick
      end
      object edtAdjustValue: TEdit
        Left = 180
        Top = 96
        Width = 79
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnKeyPress = edtValueKeyPress
      end
      object edtDescription: TEdit
        Left = 408
        Top = 68
        Width = 163
        Height = 21
        TabOrder = 10
        OnExit = edtDescriptionExit
      end
      object gdUpdatePrice: TcxGrid
        Left = 2
        Top = 128
        Width = 683
        Height = 225
        TabOrder = 13
        LookAndFeel.Kind = lfFlat
        object gdUpdatePriceDBTableView: TcxGridDBTableView
          DataController.DataSource = dsModelPrice
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object gdUpdatePriceDBTableModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Width = 89
          end
          object gdUpdatePriceDBTableDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 154
          end
          object gdUpdatePriceDBTableRealMarkUp: TcxGridDBColumn
            Caption = '(%) MarkUp'
            DataBinding.FieldName = 'RealMarkUp'
            Visible = False
          end
          object gdUpdatePriceDBTableVendorCost: TcxGridDBColumn
            Caption = 'Cost Price'
            DataBinding.FieldName = 'VendorCost'
            Visible = False
            Width = 94
          end
          object gdUpdatePriceDBTableOriginalSellingPrice: TcxGridDBColumn
            Caption = 'Old Our Price'
            DataBinding.FieldName = 'OriginalSellingPrice'
            Visible = False
          end
          object gdUpdatePriceDBTableSellingPrice: TcxGridDBColumn
            Caption = 'Our Price'
            DataBinding.FieldName = 'SellingPrice'
            Visible = False
          end
          object gdUpdatePriceDBTableRealStoreMarkUp: TcxGridDBColumn
            Caption = '(%) MarkUp'
            DataBinding.FieldName = 'RealStoreMarkUp'
            Visible = False
          end
          object gdUpdatePriceDBTableStoreCostPrice: TcxGridDBColumn
            Caption = 'Cost Price'
            DataBinding.FieldName = 'StoreCostPrice'
            Visible = False
            Width = 93
          end
          object gdUpdatePriceDBTableOrigStoreSellingPrice: TcxGridDBColumn
            Caption = 'Old Our Price'
            DataBinding.FieldName = 'OrigStoreSellingPrice'
            Visible = False
          end
          object gdUpdatePriceDBTableStoreSellingPrice: TcxGridDBColumn
            Caption = 'Our Price'
            DataBinding.FieldName = 'StoreSellingPrice'
            Visible = False
            Width = 94
          end
        end
        object gdUpdatePriceLevel: TcxGridLevel
          GridView = gdUpdatePriceDBTableView
        end
      end
      object btnCatgAll: TButton
        Left = 264
        Top = 40
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 3
        OnClick = btnCatgAllClick
      end
      object scStore: TSuperComboADO
        Left = 96
        Top = 12
        Width = 163
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        CodeLength = 315
        LookUpSource = DM.dsLookUpStore
        DropDownRows = 18
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        EditCodePos = taEditCodeRight
        IDLanguage = 0
        OnSelectItem = scStoreSelectItem
      end
      object btnStoreAll: TButton
        Left = 264
        Top = 12
        Width = 34
        Height = 20
        Caption = 'All'
        TabOrder = 1
        OnClick = btnStoreAllClick
      end
      object cbxAdjustMode: TComboBox
        Left = 96
        Top = 96
        Width = 81
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 11
        Text = 'Markup (%)'
        OnChange = cmbCalcTypeChange
        Items.Strings = (
          'Markup (%)'
          'Amount ($)')
      end
      object pnlPrices: TPanel
        Left = 332
        Top = 92
        Width = 269
        Height = 24
        BevelOuter = bvNone
        TabOrder = 14
        Visible = False
        object lbUpdate: TLabel
          Left = 30
          Top = 5
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'Update :'
        end
        object rbSalePrice: TRadioButton
          Left = 77
          Top = 5
          Width = 89
          Height = 17
          Caption = 'Sale Price'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object rbPromoPrice: TRadioButton
          Left = 169
          Top = 5
          Width = 91
          Height = 17
          Caption = 'Promo Price'
          TabOrder = 1
        end
      end
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_frmModelPriceAdj.sil'
    Left = 16
    Top = 8
  end
  object quCategory: TPowerADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT IDGroup, Name'#13#10'FROM TabGroup (NOLOCK) '#13#10'WHERE Desativado ' +
      '= 0 AND Hidden = 0'#13#10'ORDER BY Name'#13#10
    Parameters = <>
    Left = 460
    Top = 224
  end
  object quUpdate: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <>
    Left = 460
    Top = 272
  end
  object quModelFloating: TADODataSet
    Connection = DM.ADODBConnect
    MaxRecords = 20000
    CommandText = 
      'SELECT'#13#10#9'M.Model,'#13#10#9'M.IDModel,'#13#10#9'M.[Description],'#13#10#9'M.FloatPerce' +
      'nt,'#13#10#9'P.Pessoa,'#13#10#9'C.[Name]'#13#10'FROM'#13#10#9'Model M (NOLOCK) '#13#10#9'JOIN TabG' +
      'roup C (NOLOCK) ON (C.IDGroup = M.GroupID)'#13#10#9'LEFT OUTER JOIN Pes' +
      'soa P (NOLOCK) ON (P.IDPessoa = M.IDFabricante)'#13#10'WHERE'#13#10#9'M.IDFab' +
      'ricante = IsNull(:IDFabricante, M.IDFabricante)'#13#10#9'AND M.GroupID ' +
      '= IsNull(:GroupID, M.GroupID)'#13#10#9'AND M.ModelType IN ('#39'R'#39', '#39'S'#39', '#39'K' +
      #39')'#13#10#9'AND M.Desativado = 0'#13#10'ORDER BY'#13#10#9'M.Model'#13#10
    Parameters = <
      item
        Name = 'IDFabricante'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'GroupID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 284
    Top = 224
    object quModelFloatingIDModel: TIntegerField
      FieldName = 'IDModel'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object quModelFloatingModel: TStringField
      FieldName = 'Model'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quModelFloatingDescription: TStringField
      FieldName = 'Description'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object quModelFloatingPessoa: TStringField
      DisplayLabel = 'Manufacturer'
      FieldName = 'Pessoa'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object quModelFloatingName: TStringField
      DisplayLabel = 'Category'
      FieldName = 'Name'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quModelFloatingFloatPercent: TIntegerField
      DisplayLabel = 'Float %'
      FieldName = 'FloatPercent'
      ProviderFlags = [pfInUpdate]
    end
  end
  object dsModelFloating: TDataSource
    DataSet = cdsModelFloating
    Left = 284
    Top = 368
  end
  object cdsModelFloating: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModelFloating'
    Left = 284
    Top = 320
    object cdsModelFloatingIDModel: TIntegerField
      FieldName = 'IDModel'
      ProviderFlags = [pfInWhere]
    end
    object cdsModelFloatingModel: TStringField
      FieldName = 'Model'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object cdsModelFloatingDescription: TStringField
      FieldName = 'Description'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object cdsModelFloatingPessoa: TStringField
      FieldName = 'Pessoa'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object cdsModelFloatingName: TStringField
      FieldName = 'Name'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object cdsModelFloatingFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
      ProviderFlags = [pfInUpdate]
    end
  end
  object dspModelFloating: TDataSetProvider
    DataSet = quModelFloating
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 284
    Top = 272
  end
  object quModelPrice: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 20000
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.[Description],'#13#10#9'M.SellingPri' +
      'ce OriginalSellingPrice,'#13#10#9'M.SellingPrice,'#13#10#9'M.VendorCost,'#13#10#9'M.M' +
      'arkup,'#13#10#9'CASE WHEN M.SellingPrice > 0 AND M.VendorCost <> 0 THEN' +
      ' (M.SellingPrice - M.VendorCost) / M.VendorCost * 100 END RealMa' +
      'rkUp,'#13#10#9'P.Pessoa,'#13#10#9'C.[Name],'#13#10#9'CAST(0 as money) OrigStoreSellin' +
      'gPrice,'#13#10#9'CAST(0 as money) StoreSellingPrice,'#13#10#9'CAST(0 as money)' +
      ' StoreCostPrice,'#13#10#9'CASE WHEN M.SellingPrice > 0 AND M.VendorCost' +
      ' <> 0 THEN (M.SellingPrice - M.VendorCost) / M.VendorCost * 100 ' +
      'END RealStoreMarkUp'#13#10'FROM'#13#10#9'Model M (NOLOCK) '#13#10#9'JOIN TabGroup C ' +
      '(NOLOCK) ON (C.IDGroup = M.GroupID)'#13#10#9'LEFT JOIN Pessoa P (NOLOCK' +
      ') ON (P.IDPessoa = M.IDFabricante)'#13#10'WHERE'#13#10#9'M.IDFabricante = IsN' +
      'ull(:IDFabricante, M.IDFabricante)'#13#10#9'AND M.GroupID = IsNull(:Gro' +
      'upID, M.GroupID)'#13#10#9'AND M.IDSize = IsNull(:IDSize, M.IDSize)'#13#10#9'AN' +
      'D M.IDColor = IsNull(:IDColor, M.IDColor)'#13#10#9'AND M.IDModelSubGrou' +
      'p = IsNull(:IDSubGroup, M.IDModelSubGroup)'#13#10#9'AND M.ModelType IN ' +
      '('#39'R'#39', '#39'S'#39', '#39'K'#39')'#13#10#9'AND M.Desativado = 0'#13#10'ORDER BY'#13#10#9'M.Model'#13#10
    Parameters = <
      item
        Name = 'IDFabricante'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'GroupID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDSize'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDColor'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDSubGroup'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 372
    Top = 224
    object IntegerField1: TIntegerField
      FieldName = 'IDModel'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object StringField1: TStringField
      FieldName = 'Model'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object StringField2: TStringField
      FieldName = 'Description'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object StringField4: TStringField
      DisplayLabel = 'Category'
      FieldName = 'Name'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quModelPriceOriginalSellingPrice: TBCDField
      FieldName = 'OriginalSellingPrice'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object BCDField1: TBCDField
      DisplayLabel = 'Our Price'
      FieldName = 'SellingPrice'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelPriceVendorCost: TBCDField
      FieldName = 'VendorCost'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelPriceMarkup: TBCDField
      FieldName = 'Markup'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelPriceRealMarkUp: TBCDField
      FieldName = 'RealMarkUp'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelPriceOrigStoreSellingPrice: TBCDField
      FieldName = 'OrigStoreSellingPrice'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelPriceStoreSellingPrice: TBCDField
      FieldName = 'StoreSellingPrice'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelPriceStoreCostPrice: TBCDField
      FieldName = 'StoreCostPrice'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quModelPriceRealStoreMarkUp: TBCDField
      FieldName = 'RealStoreMarkUp'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dspModelPrice: TDataSetProvider
    DataSet = quModelPrice
    Options = [poIncFieldProps, poAllowCommandText]
    Left = 372
    Top = 272
  end
  object cdsModelPrice: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModelPrice'
    Left = 372
    Top = 320
    object cdsModelPriceIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsModelPriceModel: TStringField
      FieldName = 'Model'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object cdsModelPriceDescription: TStringField
      FieldName = 'Description'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object cdsModelPriceName: TStringField
      FieldName = 'Name'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object cdsModelPriceOriginalSellingPrice: TBCDField
      FieldName = 'OriginalSellingPrice'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceVendorCost: TBCDField
      FieldName = 'VendorCost'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceMarkup: TBCDField
      FieldName = 'Markup'
      ProviderFlags = [pfInUpdate]
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceRealMarkUp: TBCDField
      FieldName = 'RealMarkUp'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceOrigStoreSellingPrice: TBCDField
      FieldName = 'OrigStoreSellingPrice'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceStoreSellingPrice: TBCDField
      FieldName = 'StoreSellingPrice'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceStoreCostPrice: TBCDField
      FieldName = 'StoreCostPrice'
      ProviderFlags = []
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceRealStoreMarkUp: TBCDField
      FieldName = 'RealStoreMarkUp'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dsModelPrice: TDataSource
    DataSet = cdsModelPrice
    Left = 372
    Top = 368
  end
end
