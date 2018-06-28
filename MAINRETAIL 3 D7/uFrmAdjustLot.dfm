inherited FrmAdjustLot: TFrmAdjustLot
  Left = 96
  Top = 37
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'FrmAdjustLot'
  ClientHeight = 575
  ClientWidth = 826
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbManufect: TLabel [0]
    Left = 370
    Top = 72
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
    Left = 399
    Top = 120
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = 'Vertical :'
  end
  object lbHoriz: TLabel [2]
    Left = 387
    Top = 96
    Width = 55
    Height = 13
    Alignment = taRightJustify
    Caption = 'Horizontal :'
  end
  object lbCategory: TLabel [3]
    Left = 42
    Top = 72
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'Category :'
  end
  object lbGroup: TLabel [4]
    Left = 23
    Top = 96
    Width = 71
    Height = 13
    Alignment = taRightJustify
    Caption = 'Sub-Category:'
  end
  object lbStore: TLabel [5]
    Left = 61
    Top = 47
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Store :'
  end
  object lbSubGroup: TLabel [6]
    Left = 61
    Top = 119
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Group:'
  end
  object lbVendor: TLabel [7]
    Left = 401
    Top = 47
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
  object lbSalePeriod: TLabel [8]
    Left = 32
    Top = 145
    Width = 61
    Height = 13
    Alignment = taRightJustify
    Caption = 'Lot Expired :'
  end
  object lbDays: TLabel [9]
    Left = 222
    Top = 145
    Width = 3
    Height = 13
  end
  object lbLot: TLabel [10]
    Left = 419
    Top = 144
    Width = 22
    Height = 13
    Alignment = taRightJustify
    Caption = 'Lot :'
  end
  object Label1: TLabel [11]
    Left = 199
    Top = 144
    Width = 10
    Height = 13
    Alignment = taRightJustify
    Caption = 'to'
  end
  inherited Panel2: TPanel
    Width = 826
    TabOrder = 26
    inherited Image1: TImage
      Width = 599
    end
    inherited lblMenu: TLabel
      Left = 610
    end
    inherited EspacamentoSuperior: TPanel
      Width = 826
      inherited EEE: TPanel
        Width = 826
      end
    end
  end
  inherited Panel1: TPanel
    Top = 534
    Width = 826
    TabOrder = 25
    inherited EspacamentoInferior: TPanel
      Width = 826
      inherited Panel3: TPanel
        Width = 826
      end
    end
    inherited hhh: TPanel
      Left = 680
      Width = 146
      inherited btClose: TButton
        Left = 75
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 4
        Top = 4
        Width = 66
        Height = 31
        Caption = '&Save'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 158
    TabOrder = 23
  end
  inherited EspacamentoDireito: TPanel
    Left = 823
    Height = 158
    TabOrder = 24
  end
  object edBarcode: TEdit [16]
    Left = 327
    Top = 170
    Width = 300
    Height = 21
    TabOrder = 21
  end
  object btSearch: TBitBtn [17]
    Left = 636
    Top = 169
    Width = 91
    Height = 24
    Caption = '&Search'
    Default = True
    TabOrder = 22
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
  object cbxMethod: TComboBox [18]
    Left = 98
    Top = 170
    Width = 100
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 19
    Text = 'Start with'
    Items.Strings = (
      'Start with'
      'End with'
      'Contains')
  end
  object cbxType: TComboBox [19]
    Left = 199
    Top = 170
    Width = 125
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 20
    Items.Strings = (
      'Model'
      'Description'
      'Vendor Code')
  end
  object scFabricante: TSuperComboADO [20]
    Left = 447
    Top = 69
    Width = 181
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Text = '<-->'
    LookUpSource = DM.dsLookUpFabricante
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btFabricanteAll: TButton [21]
    Left = 635
    Top = 70
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 12
    TabStop = False
    OnClick = btFabricanteAllClick
  end
  object scColor: TSuperComboADO [22]
    Left = 447
    Top = 117
    Width = 181
    Height = 21
    TabOrder = 13
    Text = '<-->'
    LookUpSource = DM.dsLookUpColor
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object scSize: TSuperComboADO [23]
    Left = 447
    Top = 93
    Width = 181
    Height = 21
    TabOrder = 15
    Text = '<-->'
    LookUpSource = DM.dsLookUpSize
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnSizeClear: TButton [24]
    Left = 634
    Top = 93
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 16
    TabStop = False
    OnClick = btnSizeClearClick
  end
  object btnColorClear: TButton [25]
    Left = 634
    Top = 118
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 14
    TabStop = False
    OnClick = btnColorClearClick
  end
  object scCategory: TSuperComboADO [26]
    Left = 99
    Top = 69
    Width = 204
    Height = 21
    TabOrder = 1
    Text = '<-->'
    LookUpSource = DM.dsLookUpGroup
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnCategClear: TButton [27]
    Left = 308
    Top = 69
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 3
    TabStop = False
    OnClick = btnCategClearClick
  end
  object scGroup: TSuperComboADO [28]
    Left = 99
    Top = 93
    Width = 204
    Height = 21
    TabOrder = 2
    Text = '<-->'
    LookUpSource = DM.dsLookUpModelGroup
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnGroupClear: TButton [29]
    Left = 308
    Top = 93
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 4
    TabStop = False
    OnClick = btnGroupClearClick
  end
  object scSubGroup: TSuperComboADO [30]
    Left = 99
    Top = 116
    Width = 204
    Height = 21
    TabOrder = 5
    Text = '<-->'
    LookUpSource = DM.dsLookUpModelSubGroup
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnSubGroupClear: TButton [31]
    Left = 308
    Top = 116
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 6
    TabStop = False
    OnClick = btnSubGroupClearClick
  end
  object scVendor: TSuperComboADO [32]
    Left = 447
    Top = 44
    Width = 181
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    Text = '<-->'
    LookUpSource = DM.dsLookUpFornecedor
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnVendorclear: TButton [33]
    Left = 635
    Top = 45
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 10
    TabStop = False
    OnClick = btnVendorclearClick
  end
  object dtIniLot: TDateBox [34]
    Left = 99
    Top = 140
    Width = 92
    Height = 21
    TabOrder = 7
  end
  object scLot: TSuperComboADO [35]
    Left = 447
    Top = 141
    Width = 181
    Height = 21
    TabOrder = 17
    Text = '<-->'
    LookUpSource = DM.dsLookUpLot
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnlotClear: TButton [36]
    Left = 634
    Top = 142
    Width = 34
    Height = 20
    Caption = 'All'
    TabOrder = 18
    TabStop = False
    OnClick = btnlotClearClick
  end
  object dtEndLot: TDateBox [37]
    Left = 211
    Top = 140
    Width = 92
    Height = 21
    TabOrder = 8
  end
  object scStore: TSuperComboADO [38]
    Left = 99
    Top = 44
    Width = 203
    Height = 21
    TabStop = False
    Color = clScrollBar
    ReadOnly = True
    TabOrder = 0
    LookUpSource = DM.dsLookUpStore
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object Panel7: TPanel [39]
    Left = 0
    Top = 198
    Width = 826
    Height = 336
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 27
    object Panel8: TPanel
      Left = 709
      Top = 0
      Width = 117
      Height = 336
      Align = alRight
      TabOrder = 0
      object btExcel: TSpeedButton
        Tag = 7
        Left = 3
        Top = 3
        Width = 111
        Height = 26
        Hint = 'Export grid'
        Caption = 'E&xport'
        Flat = True
        Margin = 4
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = btExcelClick
      end
      object btGroup: TSpeedButton
        Tag = 3
        Left = 3
        Top = 37
        Width = 111
        Height = 25
        AllowAllUp = True
        GroupIndex = 88997
        Caption = '&Grouping'
        Flat = True
        Margin = 7
        Spacing = 8
        OnClick = btGroupClick
      end
      object btColumn: TSpeedButton
        Tag = 4
        Left = 3
        Top = 62
        Width = 111
        Height = 25
        AllowAllUp = True
        GroupIndex = 1235
        Caption = 'Colum&ns'
        Flat = True
        Margin = 6
        Spacing = 7
        OnClick = btColumnClick
      end
      object Panel9: TPanel
        Left = 8
        Top = 32
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 0
      end
      object Panel10: TPanel
        Left = 7
        Top = 90
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 1
      end
    end
    object cxGridLot: TcxGrid
      Left = 0
      Top = 0
      Width = 709
      Height = 336
      Align = alClient
      TabOrder = 1
      LookAndFeel.Kind = lfFlat
      object cxGridLotDB: TcxGridDBTableView
        OnKeyUp = cxGridLotDBKeyUp
        DataController.DataSource = dsLot
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDLote;IDStore;IDModel'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OnFocusedItemChanged = cxGridLotDBFocusedItemChanged
        Filtering.MaxDropDownCount = 50
        Filtering.Visible = fvNever
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        OnColumnHeaderClick = cxGridLotDBColumnHeaderClick
        OnCustomization = cxGridLotDBCustomization
        object cxGridLotDBMarked: TcxGridDBColumn
          Caption = ' '
          DataBinding.FieldName = 'Marked'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DisplayUnchecked = 'False'
          Properties.DisplayGrayed = 'False'
          Options.Moving = False
          Width = 30
        end
        object cxGridLotDBModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Options.Editing = False
          Width = 95
        end
        object cxGridLotDBDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Options.Editing = False
          Width = 135
        end
        object cxGridLotDBModelPrice: TcxGridDBColumn
          DataBinding.FieldName = 'ModelPrice'
          Visible = False
          Hidden = True
          Options.Editing = False
        end
        object cxGridLotDBManufacture: TcxGridDBColumn
          DataBinding.FieldName = 'Manufacture'
          Visible = False
          Options.Editing = False
        end
        object cxGridLotDBCategory: TcxGridDBColumn
          DataBinding.FieldName = 'Category'
          Visible = False
          Options.Editing = False
        end
        object cxGridLotDBSubCategory: TcxGridDBColumn
          DataBinding.FieldName = 'SubCategory'
          Visible = False
          Options.Editing = False
        end
        object cxGridLotDBMGroup: TcxGridDBColumn
          DataBinding.FieldName = 'MGroup'
          Visible = False
          Options.Editing = False
        end
        object cxGridLotDBLot: TcxGridDBColumn
          DataBinding.FieldName = 'Lot'
          Options.Editing = False
          Width = 69
        end
        object cxGridLotDBLotDate: TcxGridDBColumn
          DataBinding.FieldName = 'LotDate'
          Visible = False
          Options.Editing = False
          Width = 58
        end
        object cxGridLotDBExpirationDate: TcxGridDBColumn
          Caption = 'Lot Exp. Date'
          DataBinding.FieldName = 'ExpirationDate'
          Options.Editing = False
          Width = 96
        end
        object cxGridLotDBLocation: TcxGridDBColumn
          DataBinding.FieldName = 'Location'
          Visible = False
          Options.Editing = False
          Width = 82
        end
        object cxGridLotDBLotQty: TcxGridDBColumn
          Caption = 'Total Lot Qty'
          DataBinding.FieldName = 'LotQty'
          Options.Editing = False
          Width = 98
        end
        object cxGridLotDBQtyOnHand: TcxGridDBColumn
          Caption = 'OnHand'
          DataBinding.FieldName = 'QtyOnHand'
          Options.Editing = False
          Width = 98
        end
        object cxGridLotDBQtyOnPreSale: TcxGridDBColumn
          Caption = 'On Hold'
          DataBinding.FieldName = 'QtyOnPreSale'
          Visible = False
          Options.Editing = False
        end
        object cxGridLotDBQtyOnOrder: TcxGridDBColumn
          Caption = 'On Order'
          DataBinding.FieldName = 'QtyOnOrder'
          Visible = False
          Options.Editing = False
        end
        object cxGridLotDBQtyOnRepair: TcxGridDBColumn
          Caption = 'In Repair'
          DataBinding.FieldName = 'QtyOnRepair'
          Visible = False
          Options.Editing = False
        end
        object cxGridLotDBQtyStore: TcxGridDBColumn
          Caption = 'Actual Qty'
          DataBinding.FieldName = 'QtyStore'
          Width = 91
        end
      end
      object cxGridLotLevel: TcxGridLevel
        GridView = cxGridLotDB
      end
    end
  end
  object dspLot: TDataSetProvider [40]
    DataSet = quLot
    Options = [poIncFieldProps]
    Left = 308
    Top = 263
  end
  object quLot: TADODataSet [41]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      ' SELECT'#13#10#9'CAST(0 as bit) as Marked,'#13#10#9'IML.IDModel,'#13#10#9'IML.IDStore' +
      ','#13#10#9'IML.IDLote,'#13#10#9'IML.Qty as QtyStore,'#13#10#9'M.Model,'#13#10#9'M.Descriptio' +
      'n,'#13#10#9'M.SellingPrice as ModelPrice,'#13#10#9'P.Pessoa as Manufacture,'#13#10#9 +
      'TG.Name as Category,'#13#10#9'MG.ModelGroup as SubCategory,'#13#10#9'MGS.Model' +
      'SubGroup as MGroup,'#13#10#9'L.Lot,'#13#10#9'L.Qty as LotQty,'#13#10#9'L.ExpirationDa' +
      'te,'#13#10#9'L.LotDate,'#13#10#9'IM.Location,'#13#10#9'IM.QtyOnHand,'#13#10#9'IM.QtyOnPreSal' +
      'e,'#13#10#9'IM.QtyOnOrder,'#13#10#9'IM.QtyOnRepair'#13#10'FROM '#13#10#9'Inv_StoreModelLot ' +
      'IML (NOLOCK)'#13#10#9'JOIN Model M (NOLOCK) ON (M.IDModel = IML.IDModel' +
      ') '#13#10#9'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'#13#10#9'JOI' +
      'N Store S (NOLOCK) ON (S.IDStore = IML.IDStore)'#13#10#9'JOIN Inv_Lot L' +
      ' (NOLOCK) ON (L.IDLote = IML.IDLote)'#13#10#9'LEFT JOIN Inventory IM (N' +
      'OLOCK) ON (IM.ModelID = IML.IDModel AND IM.StoreID = IML.IDStore' +
      ')'#13#10#9'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = ' +
      'MG.IDModelGroup)'#13#10#9'LEFT OUTER JOIN ModelSubGroup MGS (NOLOCK) ON' +
      ' (M.IDModelSubGroup = MGS.IDModelSubGroup)'#13#10#9'LEFT OUTER JOIN Pes' +
      'soa P (NOLOCK) ON (P.IDPessoa = M.IDFabricante)'#13#10
    CommandTimeout = 380
    Parameters = <>
    Left = 212
    Top = 267
    object quLotMarked: TBooleanField
      FieldName = 'Marked'
    end
    object quLotIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quLotIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quLotIDLote: TIntegerField
      FieldName = 'IDLote'
    end
    object quLotQtyStore: TBCDField
      FieldName = 'QtyStore'
      DisplayFormat = '0.#####'
      Precision = 32
    end
    object quLotModel: TStringField
      FieldName = 'Model'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quLotDescription: TStringField
      FieldName = 'Description'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object quLotModelPrice: TBCDField
      FieldName = 'ModelPrice'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quLotManufacture: TStringField
      FieldName = 'Manufacture'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object quLotCategory: TStringField
      FieldName = 'Category'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quLotSubCategory: TStringField
      FieldName = 'SubCategory'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quLotMGroup: TStringField
      FieldName = 'MGroup'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quLotLot: TStringField
      FieldName = 'Lot'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
    object quLotLotQty: TBCDField
      FieldName = 'LotQty'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '0.#####'
      Precision = 32
    end
    object quLotExpirationDate: TDateTimeField
      FieldName = 'ExpirationDate'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = 'ddddd'
    end
    object quLotLotDate: TDateTimeField
      FieldName = 'LotDate'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = 'ddddd'
    end
    object quLotLocation: TStringField
      FieldName = 'Location'
      ProviderFlags = []
      ReadOnly = True
      Size = 30
    end
    object quLotQtyOnHand: TBCDField
      FieldName = 'QtyOnHand'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '0.#####'
      Precision = 32
    end
    object quLotQtyOnPreSale: TBCDField
      FieldName = 'QtyOnPreSale'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '0.#####'
      Precision = 32
    end
    object quLotQtyOnOrder: TBCDField
      FieldName = 'QtyOnOrder'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '0.#####'
      Precision = 32
    end
    object quLotQtyOnRepair: TBCDField
      FieldName = 'QtyOnRepair'
      ProviderFlags = []
      ReadOnly = True
      DisplayFormat = '0.#####'
      Precision = 32
    end
  end
  object cdsLot: TClientDataSet [42]
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLot'
    Left = 312
    Top = 311
  end
  object dsLot: TDataSource [43]
    DataSet = cdsLot
    Left = 313
    Top = 368
  end
  object strepPredefined: TcxStyleRepository [44]
    Left = 420
    Top = 259
    object cxMinMax: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object GridTableViewStyleSheetRose: TcxGridTableViewStyleSheet
      Caption = 'Rose'
      Styles.Selection = cxMinMax
    end
  end
  object cmdStoreModelLot: TADOCommand [45]
    CommandText = 
      'UPDATE'#13#10#9'Inv_StoreModelLot'#13#10'SET'#13#10#9'Qty = :Qty'#13#10'WHERE'#13#10#9'IDStore = ' +
      ':IDStore'#13#10#9'AND '#13#10#9'IDModel = :IDModel'#13#10#9'AND'#13#10#9'IDLote = :IDLote'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Qty'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 38
        Size = 19
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDLote'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 120
    Top = 267
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAdjustLot.sil'
  end
end
