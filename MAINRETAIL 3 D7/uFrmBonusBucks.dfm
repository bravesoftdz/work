inherited FrmBonusBucks: TFrmBonusBucks
  Left = 144
  Top = 7
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'FrmBonusBucks'
  ClientHeight = 517
  ClientWidth = 759
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 759
    TabOrder = 4
    DesignSize = (
      759
      40)
    inherited imgTopIni: TImage
      Height = 38
    end
    inherited Image1: TImage
      Width = 532
      Height = 38
    end
    inherited lblMenu: TLabel
      Left = 370
    end
    inherited Image3: TImage
      Height = 38
    end
    inherited EspacamentoSuperior: TPanel
      Top = 38
      Width = 759
      Height = 2
      inherited EEE: TPanel
        Width = 759
      end
    end
  end
  inherited Panel1: TPanel
    Top = 476
    Width = 759
    TabOrder = 3
    inherited EspacamentoInferior: TPanel
      Width = 759
      TabOrder = 1
      inherited Panel3: TPanel
        Width = 759
      end
    end
    inherited hhh: TPanel
      Left = 617
      Width = 142
      TabOrder = 0
      inherited btClose: TButton
        Left = 72
        Top = 4
        Cancel = True
        ModalResult = 2
        TabOrder = 1
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
        ModalResult = 1
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 188
    Height = 288
    TabOrder = 5
  end
  object pnlGrid: TPanel [3]
    Left = 3
    Top = 188
    Width = 753
    Height = 288
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlControl: TPanel
      Left = 635
      Top = 0
      Width = 118
      Height = 288
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object btExcel: TSpeedButton
        Tag = 7
        Left = 3
        Top = 4
        Width = 113
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
        Top = 36
        Width = 113
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
        Top = 61
        Width = 113
        Height = 25
        AllowAllUp = True
        GroupIndex = 1235
        Caption = 'Colum&ns'
        Flat = True
        Margin = 6
        Spacing = 7
        OnClick = btColumnClick
      end
      object btnApplyCalendar: TSpeedButton
        Tag = 4
        Left = 4
        Top = 117
        Width = 113
        Height = 25
        Caption = 'Apply Calendar'
        Flat = True
        Margin = 7
        Spacing = 5
        OnClick = btnApplyCalendarClick
      end
      object btnApplyCalendarAll: TSpeedButton
        Tag = 4
        Left = 4
        Top = 142
        Width = 113
        Height = 25
        Caption = 'Apply Calendar All'
        Flat = True
        Margin = 7
        Spacing = 5
        OnClick = btnApplyCalendarAllClick
      end
      object btnApplyPercAll: TSpeedButton
        Tag = 4
        Left = 3
        Top = 92
        Width = 114
        Height = 25
        Caption = 'Apply (%) All'
        Flat = True
        Margin = 7
        Spacing = 5
        OnClick = btnApplyPercAllClick
      end
      object btnRemoveCalendar: TSpeedButton
        Tag = 4
        Left = 4
        Top = 167
        Width = 113
        Height = 25
        Caption = 'Remove Calendar'
        Flat = True
        Margin = 7
        Spacing = 5
        OnClick = btnRemoveCalendarClick
      end
      object btnRemoveAllCalendar: TSpeedButton
        Tag = 4
        Left = 4
        Top = 192
        Width = 113
        Height = 25
        Caption = 'Remove All Calendar'
        Flat = True
        Margin = 7
        Spacing = 5
        OnClick = btnRemoveAllCalendarClick
      end
      object pnlDivisoria2: TPanel
        Left = 8
        Top = 32
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 0
      end
      object Panel5: TPanel
        Left = 7
        Top = 88
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 1
      end
    end
    object pnlRebateItemCalendar: TPanel
      Left = 0
      Top = 0
      Width = 635
      Height = 288
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Splitter: TSplitter
        Left = 0
        Top = 160
        Width = 635
        Height = 4
        Cursor = crVSplit
        Align = alBottom
      end
      object grdRebateItemCalendar: TcxGrid
        Left = 0
        Top = 164
        Width = 635
        Height = 124
        Align = alBottom
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object cxGridDBTableView: TcxGridDBTableView
          DataController.DataSource = dsRebateItemCalendar
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
          object cxGridDBTableViewDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 221
          end
          object cxGridDBTableViewDiscountPerc: TcxGridDBColumn
            DataBinding.FieldName = 'DiscountPerc'
            Width = 138
          end
          object cxGridDBTableViewStartDate: TcxGridDBColumn
            DataBinding.FieldName = 'StartDate'
            Width = 137
          end
          object cxGridDBTableViewEndDate: TcxGridDBColumn
            DataBinding.FieldName = 'EndDate'
            Width = 137
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridDBTableView
        end
      end
      object grdRebateItem: TcxGrid
        Left = 0
        Top = 0
        Width = 635
        Height = 160
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdRebateItemDBTableView: TcxGridDBTableView
          DataController.DataSource = dsRebateItem
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OnFocusedRecordChanged = grdRebateItemDBTableViewFocusedRecordChanged
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OnCustomization = grdRebateItemDBTableViewCustomization
          object grdRebateItemDBTableViewIDModel: TcxGridDBColumn
            DataBinding.FieldName = 'IDModel'
            Visible = False
            Options.Editing = False
          end
          object grdRebateItemDBTableViewModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Options.Editing = False
            Width = 159
          end
          object grdRebateItemDBTableViewDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Options.Editing = False
            Width = 247
          end
          object grdRebateItemDBTableViewCategoria: TcxGridDBColumn
            Caption = 'Category'
            DataBinding.FieldName = 'Categoria'
            Options.Editing = False
            Width = 141
          end
          object grdRebateItemDBTableViewModelSubGroup: TcxGridDBColumn
            DataBinding.FieldName = 'ModelSubGroup'
            Visible = False
            Options.Editing = False
            Width = 105
          end
          object grdRebateItemDBTableViewModelGroup: TcxGridDBColumn
            DataBinding.FieldName = 'ModelGroup'
            Visible = False
            Options.Editing = False
            Width = 107
          end
          object grdRebateItemDBTableViewDiscountPerc: TcxGridDBColumn
            DataBinding.FieldName = 'DiscountPerc'
            Width = 86
          end
        end
        object grdRebateItemLevel: TcxGridLevel
          GridView = grdRebateItemDBTableView
        end
      end
    end
  end
  inherited EspacamentoDireito: TPanel
    Left = 756
    Top = 188
    Height = 288
    TabOrder = 6
  end
  object pnlFilter: TPanel [5]
    Left = 0
    Top = 67
    Width = 759
    Height = 121
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbSubGroup: TLabel
      Left = 373
      Top = 8
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = 'Group :'
    end
    object lbGroup: TLabel
      Left = 21
      Top = 64
      Width = 74
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sub-Category :'
    end
    object lbCategory: TLabel
      Left = 43
      Top = 36
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Category :'
    end
    object lbStore: TLabel
      Left = 62
      Top = 8
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Store :'
    end
    object lblCalendar: TLabel
      Left = 359
      Top = 36
      Width = 50
      Height = 13
      Alignment = taRightJustify
      Caption = 'Calendar :'
    end
    object lblPercent: TLabel
      Left = 343
      Top = 64
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Caption = 'Percent (%) :'
    end
    object btnRefresh: TSpeedButton
      Left = 676
      Top = 42
      Width = 51
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
      OnClick = btnRefreshClick
    end
    object edBarcode: TEdit
      Left = 328
      Top = 92
      Width = 292
      Height = 21
      TabOrder = 12
    end
    object cbxMethod: TComboBox
      Left = 100
      Top = 92
      Width = 100
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 10
      Text = 'Start with'
      Items.Strings = (
        'Start with'
        'End with'
        'Contains')
    end
    object cbxType: TComboBox
      Left = 200
      Top = 92
      Width = 125
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 11
      Text = 'Model'
      Items.Strings = (
        'Model'
        'Description'
        'Vendor Code')
    end
    object scSubGroup: TSuperComboADO
      Left = 416
      Top = 4
      Width = 181
      Height = 21
      TabOrder = 5
      Text = '<-->'
      LookUpSource = DM.dsLookUpModelSubGroup
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object scStore: TSuperComboADO
      Left = 100
      Top = 4
      Width = 181
      Height = 21
      TabStop = False
      TabOrder = 0
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object scCategory: TSuperComboADO
      Left = 100
      Top = 32
      Width = 181
      Height = 21
      TabOrder = 1
      Text = '<-->'
      LookUpSource = DM.dsLookUpGroup
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object scGroup: TSuperComboADO
      Left = 100
      Top = 60
      Width = 181
      Height = 21
      TabOrder = 3
      Text = '<-->'
      LookUpSource = DM.dsLookUpModelGroup
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnSubGroupAll: TButton
      Left = 604
      Top = 4
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 6
      TabStop = False
      OnClick = btnSubGroupAllClick
    end
    object btnGroupAll: TButton
      Left = 288
      Top = 60
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 4
      TabStop = False
      OnClick = btnGroupAllClick
    end
    object btnCategAll: TButton
      Left = 288
      Top = 32
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 2
      TabStop = False
      OnClick = btnCategAllClick
    end
    object scCalendar: TSuperComboADO
      Left = 416
      Top = 32
      Width = 181
      Height = 21
      TabOrder = 7
      Text = '<-->'
      LookUpSource = DM.dsLookupRebateCalendar
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btCalendarAll: TButton
      Left = 604
      Top = 32
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 8
      TabStop = False
      OnClick = btCalendarAllClick
    end
    object edPercent: TEdit
      Left = 416
      Top = 60
      Width = 41
      Height = 21
      TabOrder = 9
      OnKeyPress = edPercentKeyPress
    end
  end
  object pnlRedeemed: TPanelRights [6]
    Left = 0
    Top = 40
    Width = 759
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    Color = 14548991
    TabOrder = 1
    object lblRedeemed: TLabel
      Left = 16
      Top = 7
      Width = 80
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Redeemed (%) :'
      ParentBiDiMode = False
      Visible = False
    end
    object lblDaysToUseBonus: TLabel
      Left = 158
      Top = 7
      Width = 102
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Days to use coupon :'
      ParentBiDiMode = False
    end
    object lblMinSaleValue: TLabel
      Left = 524
      Top = 7
      Width = 74
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Min sale value :'
      ParentBiDiMode = False
    end
    object lblDaysToExpireBonus: TLabel
      Left = 355
      Top = 7
      Width = 81
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Expiration days :'
      ParentBiDiMode = False
    end
    object btnShowFilter: TButton
      Left = 692
      Top = 4
      Width = 57
      Height = 17
      Caption = 'Show filter'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Visible = False
      OnClick = btnFilterClick
    end
    object btnHideFilter: TButton
      Left = 692
      Top = 4
      Width = 57
      Height = 17
      Caption = 'Hide filter'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnFilterClick
    end
    object edtRedeemed: TEdit
      Left = 100
      Top = 3
      Width = 41
      Height = 21
      TabOrder = 0
      Visible = False
      OnKeyPress = edtRedeemedKeyPress
    end
    object edtDaysToUseBonus: TEdit
      Left = 264
      Top = 3
      Width = 41
      Height = 21
      TabOrder = 1
      OnKeyPress = edtDaysToUseBonusKeyPress
    end
    object edtMinSaleValue: TEdit
      Left = 604
      Top = 3
      Width = 73
      Height = 21
      TabOrder = 3
      OnKeyPress = edtMinSaleValueKeyPress
    end
    object edtDaysToExpireBonus: TEdit
      Left = 440
      Top = 3
      Width = 41
      Height = 21
      TabOrder = 2
      OnKeyPress = edtDaysToUseBonusKeyPress
    end
  end
  object dsRebateItem: TDataSource [7]
    DataSet = cdsRebateItem
    Left = 56
    Top = 248
  end
  object dsRebateItemCalendar: TDataSource [8]
    DataSet = cdsRebateItemCalendar
    Left = 72
    Top = 396
  end
  object cdsRebateItem: TClientDataSet [9]
    Aggregates = <>
    Params = <>
    ProviderName = 'dspRebateItem'
    Left = 56
    Top = 200
    object cdsRebateItemIDStore: TIntegerField
      FieldName = 'IDStore'
      ReadOnly = True
    end
    object cdsRebateItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsRebateItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsRebateItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsRebateItemCategoria: TStringField
      FieldName = 'Categoria'
      Size = 30
    end
    object cdsRebateItemModelSubGroup: TStringField
      FieldName = 'ModelSubGroup'
      Size = 30
    end
    object cdsRebateItemModelGroup: TStringField
      FieldName = 'ModelGroup'
      Size = 30
    end
    object cdsRebateItemIDRebateItem: TIntegerField
      FieldName = 'IDRebateItem'
    end
    object cdsRebateItemDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
    end
  end
  object cdsRebateItemCalendar: TClientDataSet [10]
    Aggregates = <>
    Params = <>
    ProviderName = 'dspRebateItemCalendar'
    Left = 72
    Top = 348
    object cdsRebateItemCalendarIDRebateItem: TIntegerField
      FieldName = 'IDRebateItem'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsRebateItemCalendarIDRebateCalendar: TIntegerField
      FieldName = 'IDRebateCalendar'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsRebateItemCalendarIDModel: TIntegerField
      FieldName = 'IDModel'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsRebateItemCalendarIDStore: TIntegerField
      FieldName = 'IDStore'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsRebateItemCalendarDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
    object cdsRebateItemCalendarDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
    end
    object cdsRebateItemCalendarStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object cdsRebateItemCalendarEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
  end
  object dspRebateItem: TDataSetProvider [11]
    DataSet = qryRebateItem
    Options = [poIncFieldProps]
    Left = 132
    Top = 248
  end
  object qryRebateItem: TADOQuery [12]
    Connection = DM.ADODBConnect
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'1 IDStore,'
      #9'M.IDModel,'
      #9'M.Model,'
      #9'M.[Description],'
      #9'TG.[Name] Categoria,'
      #9'MSG.ModelSubGroup,'
      #9'MG.ModelGroup,'
      #9'RI.IDRebateItem,'
      #9'RI.DiscountPerc'
      'FROM'
      #9'Model M'
      #9'JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)'
      
        #9'LEFT OUTER JOIN ModelGroup MG ON (M.IDModelGroup = MG.IDModelGr' +
        'oup)'
      
        #9'LEFT OUTER JOIN ModelSubGroup MSG ON (M.IDModelSubGroup = MSG.I' +
        'DModelSubGroup)'
      #9'LEFT OUTER JOIN Sal_RebateItem RI ON (M.IDModel = RI.IDModel)'
      '')
    Left = 132
    Top = 200
    object qryRebateItemIDStore: TIntegerField
      FieldName = 'IDStore'
      ReadOnly = True
    end
    object qryRebateItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryRebateItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object qryRebateItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object qryRebateItemCategoria: TStringField
      FieldName = 'Categoria'
      Size = 30
    end
    object qryRebateItemModelSubGroup: TStringField
      FieldName = 'ModelSubGroup'
      Size = 30
    end
    object qryRebateItemModelGroup: TStringField
      FieldName = 'ModelGroup'
      Size = 30
    end
    object qryRebateItemIDRebateItem: TIntegerField
      FieldName = 'IDRebateItem'
    end
    object qryRebateItemDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
    end
  end
  object qryRebateItemCalendar: TADOQuery [13]
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'RI.IDRebateItem,'
      #9'RC.IDRebateCalendar,'
      #9'RI.IDModel,'
      #9'RI.IDStore,'
      #9'RC.[Description],'
      #9'RC.DiscountPerc,'
      #9'RC.StartDate,'
      #9'RC.EndDate'
      'FROM'
      #9'Sal_RebateItemCalendar SIC'
      #9'JOIN Sal_RebateItem RI ON (SIC.IDRebateItem = RI.IDRebateItem)'
      
        #9'JOIN Sal_RebateCalendar RC ON (SIC.IDRebateCalendar = RC.IDReba' +
        'teCalendar)'
      'WHERE'
      #9'RC.IDStore = :IDStore')
    Left = 192
    Top = 348
    object qryRebateItemCalendarIDRebateItem: TIntegerField
      FieldName = 'IDRebateItem'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryRebateItemCalendarIDRebateCalendar: TIntegerField
      FieldName = 'IDRebateCalendar'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryRebateItemCalendarIDModel: TIntegerField
      FieldName = 'IDModel'
      ProviderFlags = [pfInKey]
    end
    object qryRebateItemCalendarIDStore: TIntegerField
      FieldName = 'IDStore'
      ProviderFlags = [pfInKey]
    end
    object qryRebateItemCalendarDescription: TStringField
      FieldName = 'Description'
      ProviderFlags = []
      Size = 30
    end
    object qryRebateItemCalendarDiscountPerc: TFloatField
      FieldName = 'DiscountPerc'
      ProviderFlags = []
    end
    object qryRebateItemCalendarStartDate: TDateTimeField
      FieldName = 'StartDate'
      ProviderFlags = []
    end
    object qryRebateItemCalendarEndDate: TDateTimeField
      FieldName = 'EndDate'
      ProviderFlags = []
    end
  end
  object dspRebateItemCalendar: TDataSetProvider [14]
    DataSet = qryRebateItemCalendar
    Options = [poIncFieldProps]
    BeforeUpdateRecord = dspRebateItemCalendarBeforeUpdateRecord
    Left = 192
    Top = 396
  end
  object cmdInsertRebateItem: TADOCommand [15]
    CommandText = 
      'INSERT INTO Sal_RebateItem (IDRebateItem, IDStore, IDModel, Disc' +
      'ountPerc)'#13#10'VALUES (:IDRebateItem, :IDStore, :IDModel, :DiscountP' +
      'erc)'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'IDRebateItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
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
        Name = 'DiscountPerc'
        Attributes = [paSigned]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end>
    Left = 232
    Top = 200
  end
  object cmdUpdateRebateItem: TADOCommand [16]
    CommandText = 
      'UPDATE'#13#10#9'Sal_RebateItem'#13#10'SET'#13#10#9'DiscountPerc = :DiscountPerc'#13#10'WHE' +
      'RE'#13#10#9'IDRebateItem = :IDRebateItem'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'DiscountPerc'
        Attributes = [paSigned]
        DataType = ftFloat
        NumericScale = 255
        Precision = 15
        Size = 8
        Value = Null
      end
      item
        Name = 'IDRebateItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 232
    Top = 248
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmBonusBucks.sil'
    Left = 12
    Top = 8
  end
  object cmdUpdateRedeemedPerc: TADOCommand
    CommandText = 
      'UPDATE Sis_PropertyDomain'#13#10'SET PropertyValue = :PropertyValue'#13#10'W' +
      'HERE Property = :Property'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'PropertyValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    Left = 328
    Top = 396
  end
  object qryRedeemedPerc: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PD.PropertyValue'
      'FROM'
      #9'Sis_PropertyDomain PD'
      'WHERE'
      #9'PD.Property = :Property')
    Left = 328
    Top = 348
    object qryRedeemedPercPropertyValue: TStringField
      FieldName = 'PropertyValue'
      Size = 255
    end
  end
  object cmdUpdateDaysToUseBonus: TADOCommand
    CommandText = 
      'UPDATE Sis_PropertyDomain'#13#10'SET PropertyValue = :PropertyValue'#13#10'W' +
      'HERE Property = :Property'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'PropertyValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    Left = 460
    Top = 396
  end
  object qryDaysToUseBonus: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PD.PropertyValue'
      'FROM'
      #9'Sis_PropertyDomain PD'
      'WHERE'
      #9'PD.Property = :Property')
    Left = 460
    Top = 348
    object qryDaysToUseBonusPropertyValue: TStringField
      FieldName = 'PropertyValue'
      Size = 255
    end
  end
  object cmdUpdateMinSaleValue: TADOCommand
    CommandText = 
      'UPDATE Sis_PropertyDomain'#13#10'SET PropertyValue = :PropertyValue'#13#10'W' +
      'HERE Property = :Property'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'PropertyValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    Left = 600
    Top = 396
  end
  object qryMinSaleValue: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PD.PropertyValue'
      'FROM'
      #9'Sis_PropertyDomain PD'
      'WHERE'
      #9'PD.Property = :Property')
    Left = 600
    Top = 348
    object qryMinSaleValuePropertyValue: TStringField
      FieldName = 'PropertyValue'
      Size = 255
    end
  end
  object qryExpireDays: TADOQuery
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PD.PropertyValue'
      'FROM'
      #9'Sis_PropertyDomain PD'
      'WHERE'
      #9'PD.Property = :Property')
    Left = 356
    Top = 200
    object qryExpireDaysPropertyValue: TStringField
      FieldName = 'PropertyValue'
      Size = 255
    end
  end
  object cmdUpdateExpireDaysBonus: TADOCommand
    CommandText = 
      'UPDATE Sis_PropertyDomain'#13#10'SET PropertyValue = :PropertyValue'#13#10'W' +
      'HERE Property = :Property'
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'PropertyValue'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end
      item
        Name = 'Property'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 255
        Value = Null
      end>
    Left = 356
    Top = 248
  end
end
