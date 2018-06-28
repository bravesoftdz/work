inherited FrmPromoItemList: TFrmPromoItemList
  Left = 3
  Top = 15
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmPromoItemList'
  ClientHeight = 515
  ClientWidth = 709
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbManufect: TLabel [0]
    Left = 345
    Top = 74
    Width = 72
    Height = 13
    Alignment = taRightJustify
    Caption = 'Manufacturer :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbVerti: TLabel [1]
    Left = 374
    Top = 125
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = 'Vertical :'
  end
  object lbHoriz: TLabel [2]
    Left = 362
    Top = 100
    Width = 55
    Height = 13
    Alignment = taRightJustify
    Caption = 'Hotizontal :'
  end
  object lbCategory: TLabel [3]
    Left = 25
    Top = 75
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'Category :'
  end
  object lbGroup: TLabel [4]
    Left = 6
    Top = 102
    Width = 71
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sub-Category:'
  end
  object lbStore: TLabel [5]
    Left = 44
    Top = 49
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Store :'
  end
  object lbSubGroup: TLabel [6]
    Left = 44
    Top = 129
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Group:'
  end
  object lbVendor: TLabel [7]
    Left = 376
    Top = 50
    Width = 41
    Height = 13
    Alignment = taRightJustify
    Caption = 'Vendor :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  inherited Panel2: TPanel
    Width = 709
    inherited Image1: TImage
      Width = 482
    end
    inherited lblMenu: TLabel
      Left = 493
    end
    inherited EspacamentoSuperior: TPanel
      Width = 709
      inherited EEE: TPanel
        Width = 709
      end
    end
  end
  inherited Panel1: TPanel
    Top = 474
    Width = 709
    inherited EspacamentoInferior: TPanel
      Width = 709
      inherited Panel3: TPanel
        Width = 709
      end
    end
    inherited hhh: TPanel
      Left = 532
      Width = 177
      inherited btClose: TButton
        Left = 102
        Cancel = True
        ModalResult = 2
      end
      object btnSave: TButton
        Left = 32
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 154
  end
  inherited EspacamentoDireito: TPanel
    Left = 706
    Height = 154
  end
  object edBarcode: TEdit [12]
    Left = 310
    Top = 169
    Width = 292
    Height = 21
    TabOrder = 4
  end
  object btSearch: TBitBtn [13]
    Left = 609
    Top = 165
    Width = 91
    Height = 27
    Caption = '&Search'
    TabOrder = 5
    OnClick = btSearchClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000130B0000130B00000000000000000000FF00FF7D8497
      747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF747DAE4985D6767DAC747DAEFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA4B1F75BB9FD
      4589DF707CAF747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFA0A5FA55B5FC4588DE727CAF747DAEFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      A1AFFA57B6FC4689DE747DAE747DAEFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA1A5FB57B1FC468AD59385A6FF
      00FFFF00FFCEA890CEA890CEA890CEA890FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFA5ADFA95BFE4A69E9EC86DA4E0A5A3EDD5ADF0E4C2F2E7C9EBD6
      BDDE8EBECEA890FE02FDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEADA9E6
      C1A0FBF0C2FFFCD1FFFFD9FFFFE7FFFFF6F8F2EED4B6B5CEA890FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFDEB6ABFFEDBCFFEFBAFFFCD0FFFFDFFFFDF2FFFF
      FFFEFEFCEEE1D0D57FB6FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E9D2B4FF
      EABAFFE4B2FFFCD1FFFFDFFFFEF6FFFDFAFFFCF3FCF6D7CBA693FF00FFFF00FF
      FF00FFFF00FFFF00FFCEA890F2E1BCFFE4B2FFE4B2FFF8C9FFFFDAFFFEE6FFFD
      EAFFFEDFFFFDD3D1B7A5FF00FFFF00FFFF00FFFF00FFFF00FFCEA890F1DFBBFF
      F1C3FFE9B6FFECB9FFF9CBFFFDD4FFFDD5FFFDD3FFF6CAD0A993FF00FFFF00FF
      FF00FFFF00FFFF00FFCEA890E7CAB6FFF9E8FFF2DAFFE2BBFFEBB5FFF0BCFFF1
      BDFFF6C4F7E4BCCDA294FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCEA890F4
      E7E0FEFDFCFFEACBFFE4B3FBDCADFFE8B9FCEEBEDDAA94CEA890FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFCEA890E8D2CAF9EED1FFF4C3FDF2C1F2E0
      B7DFAF9BCEA890FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFCEA890CCA590CEA890D1B09DD5B1A8CEA890FF00FFFF00FF}
  end
  object cbxMethod: TComboBox [14]
    Left = 81
    Top = 169
    Width = 100
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 6
    Text = 'Start with'
    Items.Strings = (
      'Start with'
      'End with'
      'Contains')
  end
  object cbxType: TComboBox [15]
    Left = 182
    Top = 169
    Width = 125
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 7
    Items.Strings = (
      'Barcode'
      'Model'
      'Description'
      'Vendor Code')
  end
  object scFabricante: TSuperComboADO [16]
    Left = 422
    Top = 71
    Width = 181
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Text = '<-->'
    LookUpSource = DM.dsLookUpFabricante
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btFabricanteAll: TButton [17]
    Left = 610
    Top = 72
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 9
    TabStop = False
    OnClick = btFabricanteAllClick
  end
  object scColor: TSuperComboADO [18]
    Left = 422
    Top = 122
    Width = 181
    Height = 21
    TabOrder = 10
    Text = '<-->'
    LookUpSource = DM.dsLookUpColor
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object scSize: TSuperComboADO [19]
    Left = 422
    Top = 97
    Width = 181
    Height = 21
    TabOrder = 11
    Text = '<-->'
    LookUpSource = DM.dsLookUpSize
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnSizeClear: TButton [20]
    Left = 609
    Top = 97
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 12
    TabStop = False
    OnClick = btnSizeClearClick
  end
  object btnColorClear: TButton [21]
    Left = 609
    Top = 123
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 13
    TabStop = False
    OnClick = btnColorClearClick
  end
  object scCategory: TSuperComboADO [22]
    Left = 82
    Top = 72
    Width = 181
    Height = 21
    TabOrder = 14
    Text = '<-->'
    LookUpSource = DM.dsLookUpGroup
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnCategClear: TButton [23]
    Left = 270
    Top = 72
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 15
    TabStop = False
    OnClick = btnCategClearClick
  end
  object scGroup: TSuperComboADO [24]
    Left = 82
    Top = 99
    Width = 181
    Height = 21
    TabOrder = 16
    Text = '<-->'
    LookUpSource = DM.dsLookUpModelGroup
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnGroupClear: TButton [25]
    Left = 270
    Top = 99
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 17
    TabStop = False
    OnClick = btnGroupClearClick
  end
  object scStore: TSuperComboADO [26]
    Left = 82
    Top = 46
    Width = 181
    Height = 21
    TabOrder = 18
    Text = '<-->'
    LookUpSource = DM.dsLookUpStore
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnStoreAll: TButton [27]
    Left = 269
    Top = 46
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 19
    TabStop = False
    OnClick = btnStoreAllClick
  end
  object scSubGroup: TSuperComboADO [28]
    Left = 82
    Top = 126
    Width = 181
    Height = 21
    TabOrder = 20
    Text = '<-->'
    LookUpSource = DM.dsLookUpModelSubGroup
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnSubGroupClear: TButton [29]
    Left = 270
    Top = 126
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 21
    TabStop = False
    OnClick = btnSubGroupClearClick
  end
  object scVendor: TSuperComboADO [30]
    Left = 422
    Top = 47
    Width = 181
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 22
    Text = '<-->'
    LookUpSource = DM.dsLookUpFornecedor
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnVendorAll: TButton [31]
    Left = 610
    Top = 48
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 23
    TabStop = False
    OnClick = btnVendorAllClick
  end
  object Panel4: TPanel [32]
    Left = 0
    Top = 194
    Width = 709
    Height = 280
    Align = alBottom
    Caption = 'Panel4'
    TabOrder = 24
    object pnlButtons: TPanel
      Left = 591
      Top = 1
      Width = 117
      Height = 278
      Align = alRight
      TabOrder = 0
      object btSelectAll: TSpeedButton
        Tag = 7
        Left = 3
        Top = 3
        Width = 111
        Height = 26
        Hint = 'Select All'
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
        Left = 3
        Top = 29
        Width = 111
        Height = 26
        Hint = 'Un Select All'
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
      object Panel9: TPanel
        Left = 8
        Top = 55
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object grdPromoPrizeItem: TcxGrid
      Left = 1
      Top = 1
      Width = 590
      Height = 278
      Align = alClient
      TabOrder = 1
      LookAndFeel.Kind = lfFlat
      object grdPromoPrizeItemDB: TcxGridDBTableView
        DataController.DataSource = dsModel
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDModel'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        Filtering.MaxDropDownCount = 50
        Filtering.Visible = fvNever
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        object grdPromoPrizeItemDBMarked: TcxGridDBColumn
          DataBinding.FieldName = 'Marked'
          Width = 44
        end
        object grdPromoPrizeItemDBModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Width = 57
        end
        object grdPromoPrizeItemDBDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 173
        end
        object grdPromoPrizeItemDBCategory: TcxGridDBColumn
          DataBinding.FieldName = 'Category'
          Width = 87
        end
        object grdPromoPrizeItemDBManufacture: TcxGridDBColumn
          DataBinding.FieldName = 'Manufacture'
          Width = 105
        end
        object grdPromoPrizeItemDBVendor: TcxGridDBColumn
          DataBinding.FieldName = 'Vendor'
          Width = 122
        end
      end
      object grdPromoPrizeItemLevel: TcxGridLevel
        GridView = grdPromoPrizeItemDB
      end
    end
  end
  object cbxPrimaryBarcode: TCheckBox [33]
    Left = 83
    Top = 151
    Width = 178
    Height = 17
    Caption = 'Primary Barcode'
    TabOrder = 25
  end
  object cbxPrimVendor: TCheckBox [34]
    Left = 422
    Top = 147
    Width = 182
    Height = 17
    Caption = 'List primary vendor only'
    TabOrder = 26
  end
  object quModel: TADOQuery [35]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '      M.IDModel,'
      '      M.Model,'
      '      M.Description,'
      '      M.SellingPrice as ModelPrice,'
      '      I.SellingPrice as StoreSellingPrice,'
      '      I.QtyOnHand,'
      '      P.Pessoa as Manufacture,'
      '      TG.Name as Category,'
      '      '#39#39' as CatSubGroup,'
      '      V.Pessoa as Vendor,'
      '      Cast(1as Bit) as Marked'
      'FROM'
      '      Model M (NOLOCK) '
      '      JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'
      
        '      LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = M.IDFab' +
        'ricante)'
      
        '      LEFT OUTER JOIN Inventory I (NOLOCK) ON (M.IDModel = I.Mod' +
        'elID)'
      
        '      LEFT JOIN Inv_ModelVendor MV (NOLOCK) ON (M.IDModel = MV.I' +
        'DModel)'
      '      LEFT JOIN Pessoa V (NOLOCK) ON (V.IDPessoa = MV.IDPessoa)'
      'ORDER BY'
      '      M.Model'
      ' '
      ' ')
    Left = 521
    Top = 216
    object quModelIDModel: TIntegerField
      FieldName = 'IDModel'
      ReadOnly = True
    end
    object quModelModel: TStringField
      FieldName = 'Model'
      ReadOnly = True
      Size = 30
    end
    object quModelDescription: TStringField
      FieldName = 'Description'
      ReadOnly = True
      Size = 50
    end
    object quModelModelPrice: TBCDField
      FieldName = 'ModelPrice'
      ReadOnly = True
      Precision = 19
    end
    object quModelStoreSellingPrice: TBCDField
      FieldName = 'StoreSellingPrice'
      ReadOnly = True
      Precision = 19
    end
    object quModelQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      ReadOnly = True
    end
    object quModelManufacture: TStringField
      FieldName = 'Manufacture'
      ReadOnly = True
      Size = 50
    end
    object quModelCategory: TStringField
      FieldName = 'Category'
      ReadOnly = True
      Size = 30
    end
    object quModelVendor: TStringField
      FieldName = 'Vendor'
      ReadOnly = True
      Size = 50
    end
    object quModelMarked: TBooleanField
      FieldName = 'Marked'
    end
  end
  object dsModel: TDataSource [36]
    DataSet = cdsModel
    Left = 521
    Top = 368
  end
  object quPromoItem: TADODataSet [37]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'SPI.IDPromoItem,'#13#10#9'SPI.IDModel'#13#10'FROM'#13#10#9'Sal_PromoItem SP' +
      'I (NOLOCK) '#13#10#9'JOIN Model M (NOLOCK) ON (M.IDModel = SPI.IDModel)' +
      #13#10'WHERE'#13#10#9'SPI.IDPromo = :IDPromo'
    Parameters = <
      item
        Name = 'IDPromo'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 616
    Top = 204
    object quPromoItemIDPromoItem: TIntegerField
      FieldName = 'IDPromoItem'
    end
    object quPromoItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
  end
  object dsPromoItem: TDataSource [38]
    DataSet = quPromoItem
    Left = 616
    Top = 272
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPromoItemList.sil'
  end
  object cdsModel: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModel'
    Left = 520
    Top = 320
  end
  object dspModel: TDataSetProvider
    DataSet = quModel
    Left = 520
    Top = 264
  end
end
