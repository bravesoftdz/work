inherited FrmInventoryList: TFrmInventoryList
  Left = 7
  Top = 9
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmInventoryList'
  ClientHeight = 513
  ClientWidth = 758
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 472
    Width = 758
    inherited EspacamentoInferior: TPanel
      Width = 758
      inherited Panel3: TPanel
        Width = 758
      end
    end
    inherited hhh: TPanel
      Left = 608
      Width = 150
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 54
    Height = 418
  end
  inherited EspacamentoDireito: TPanel
    Left = 642
    Top = 54
    Height = 418
  end
  inherited EspacamentoSuperior: TPanel
    Top = 54
    Width = 758
    Height = 0
    Visible = False
  end
  object pnlBasicFilter: TPanel [4]
    Left = 0
    Top = 0
    Width = 758
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label4: TLabel
      Left = 8
      Top = 6
      Width = 83
      Height = 13
      Alignment = taRightJustify
      Caption = 'Manufacturer :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 33
      Top = 32
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = 'Category :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 402
      Top = 6
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Store :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pblGO: TPanel
      Left = 677
      Top = 0
      Width = 81
      Height = 54
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object pnlAviso: TPanel
        Left = 6
        Top = 10
        Width = 65
        Height = 30
        BevelOuter = bvNone
        Color = clGray
        TabOrder = 0
        object btnExec: TSpeedButton
          Left = 5
          Top = 2
          Width = 56
          Height = 26
          Caption = '&GO!'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          Layout = blGlyphRight
          ParentFont = False
          OnClick = btnExecClick
        end
      end
    end
    object scFabricante: TSuperComboADO
      Left = 99
      Top = 3
      Width = 211
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      LookUpSource = DM.dsLookUpFabricante
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btFabricanteAll: TButton
      Left = 314
      Top = 4
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 2
      OnClick = btFabricanteAllClick
    end
    object scGroup: TSuperComboADO
      Left = 99
      Top = 28
      Width = 211
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      CodeLength = 315
      LookUpSource = DM.dsLookUpGroup
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      EditCodePos = taEditCodeRight
      IDLanguage = 0
    end
    object btGroupAll: TButton
      Left = 314
      Top = 29
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 4
      OnClick = btGroupAllClick
    end
    object scStore: TSuperComboADO
      Left = 447
      Top = 3
      Width = 166
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnClearStore: TButton
      Left = 618
      Top = 4
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 6
      OnClick = btnClearStoreClick
    end
  end
  object grdModelList: TcxGrid [5]
    Left = 3
    Top = 54
    Width = 639
    Height = 418
    Align = alClient
    TabOrder = 5
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    object grdModelListDB: TcxGridDBTableView
      DataController.DataSource = dsModelList
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDModel'
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '0'
          Kind = skCount
          Position = spFooter
          FieldName = 'Model'
          Column = grdModelListDBModel
        end>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
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
      OptionsView.Footer = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      Styles.Background = cxStyle
      Styles.Content = cxStyle
      Styles.ContentEven = cxStyle
      Styles.ContentOdd = cxStyle
      Styles.Inactive = cxStyle
      Styles.IncSearch = cxStyle
      Styles.Selection = cxStyle
      Styles.FilterBox = cxStyle
      Styles.Footer = cxStyle
      Styles.Group = cxStyle
      Styles.GroupByBox = cxStyle
      Styles.Header = cxStyle
      Styles.Indicator = cxStyle
      Styles.Preview = cxStyle
      object grdModelListDBModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        SortOrder = soAscending
        Width = 109
      end
      object grdModelListDBDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Width = 377
      end
      object grdModelListDBCategory: TcxGridDBColumn
        DataBinding.FieldName = 'Category'
        Visible = False
        GroupIndex = 0
        SortOrder = soAscending
        Width = 201
      end
      object grdModelListDBIDModel: TcxGridDBColumn
        DataBinding.FieldName = 'IDModel'
        Visible = False
        Hidden = True
      end
      object grdModelListDBTotQtyOnHandF: TcxGridDBColumn
        Caption = 'OnHandF'
        DataBinding.FieldName = 'TotQtyOnHandF'
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        Hidden = True
        Width = 73
      end
      object grdModelListDBTotQtyOnOrder: TcxGridDBColumn
        DataBinding.FieldName = 'TotQtyOnOrder'
        FooterAlignmentHorz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 61
      end
      object grdModelListDBTotQtyOnHand: TcxGridDBColumn
        DataBinding.FieldName = 'TotQtyOnHand'
        Visible = False
        HeaderAlignmentHorz = taCenter
        Hidden = True
        Width = 50
      end
      object grdModelListDBTotQtyOnPreSale: TcxGridDBColumn
        Caption = 'OnPreSale'
        DataBinding.FieldName = 'TotQtyOnPreSale'
        Visible = False
        Hidden = True
        Width = 50
      end
      object grdModelListDBTotQtyOnPrePurchase: TcxGridDBColumn
        DataBinding.FieldName = 'TotQtyOnPrePurchase'
        Visible = False
        Width = 50
      end
      object grdModelListDBHasInStore: TcxGridDBColumn
        DataBinding.FieldName = 'HasInStore'
        Visible = False
        Hidden = True
      end
      object grdModelListDBManufacture: TcxGridDBColumn
        DataBinding.FieldName = 'Manufacture'
        Visible = False
      end
    end
    object grdModelListLevel: TcxGridLevel
      GridView = grdModelListDB
    end
  end
  object pnlButton: TPanelRights [6]
    Left = 645
    Top = 54
    Width = 113
    Height = 418
    Align = alRight
    BevelOuter = bvNone
    Color = 14607076
    TabOrder = 6
    object btColumn: TSpeedButton
      Tag = 4
      Left = 2
      Top = 92
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
    object btGroup: TSpeedButton
      Tag = 3
      Left = 2
      Top = 67
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
    object btPrint: TSpeedButton
      Tag = 5
      Left = 2
      Top = 3
      Width = 111
      Height = 26
      Caption = '&Preview'
      Flat = True
      Margin = 6
      Spacing = 7
      OnClick = btPrintClick
    end
    object btFilter: TSpeedButton
      Tag = 4
      Left = 2
      Top = 117
      Width = 111
      Height = 25
      AllowAllUp = True
      GroupIndex = 87741
      Caption = 'Show &Filters'
      Flat = True
      Margin = 7
      Spacing = 5
      OnClick = btFilterClick
    end
    object btExcel: TSpeedButton
      Tag = 7
      Left = 2
      Top = 30
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
    object panel8: TPanel
      Left = 7
      Top = 60
      Width = 101
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  object quModel: TPowerADOQuery [7]
    Connection = DM.ADODBConnect
    OnCalcFields = quModelCalcFields
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.SellingPrice' +
      ','#13#10#9'(M.VendorCost+M.OtherCost+M.FreightCost) as CurrentCost,'#13#10#9'M' +
      '.FloatPercent,'#13#10#9'SUM(Inv.QtyOnHand) as TotQtyOnHand,'#13#10#9'SUM(Inv.Q' +
      'tyOnRepair) as TotQtyOnRepair,'#13#10#9'SUM(Inv.QtyOnPreSale) as TotQty' +
      'OnPreSale,'#13#10#9'SUM(Inv.QtyOnPrePurchase) as TotQtyOnPrePurchase,'#13#10 +
      #9'CASE WHEN SUM(Inv.QtyOnOrder) < 0 THEN 0 ELSE SUM(Inv.QtyOnOrde' +
      'r) END AS TotQtyOnOrder,'#13#10#9'M.ReplacementCost,'#13#10#9'TG.Name as Categ' +
      'ory,'#13#10#9'F.Pessoa as Manufacture'#13#10'FROM'#13#10#9'Model M (NOLOCK) '#13#10#9'JOIN ' +
      'TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)'#13#10#9'LEFT OUTER JO' +
      'IN Pessoa F (NOLOCK) ON (F.IDPessoa = M.IDFabricante)'#13#10#9'JOIN Inv' +
      'entory Inv (NOLOCK) ON (Inv.ModelID = M.IDModel)'#13#10'WHERE'#13#10#9'M.Mode' +
      'lType IN ('#39'S'#39', '#39'R'#39', '#39'C'#39', '#39'K'#39')'#13#10#9'AND'#13#10#9'M.Desativado = 0'#13#10#9'AND'#13#10#9'M' +
      '.Hidden = 0'#13#10#9'AND'#13#10#9'M.NotVerifyQty = 0'#13#10'GROUP BY'#13#10#9'M.IDModel,'#13#10#9 +
      'M.Model,'#13#10#9'M.Description,'#13#10#9'M.SellingPrice,'#13#10#9'(M.VendorCost+M.Ot' +
      'herCost+M.FreightCost),'#13#10#9'M.FloatPercent,'#13#10#9'M.ReplacementCost,'#13#10 +
      #9'TG.Name,'#13#10#9'F.Pessoa'#13#10
    CommandTimeout = 180
    Parameters = <>
    Left = 49
    Top = 153
    object quModelIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object quModelCurrentCost: TBCDField
      FieldName = 'CurrentCost'
      ReadOnly = True
      Precision = 19
    end
    object quModelFloatPercent: TIntegerField
      FieldName = 'FloatPercent'
    end
    object quModelReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Precision = 19
    end
    object quModelModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quModelHasInStore: TStringField
      FieldKind = fkCalculated
      FieldName = 'HasInStore'
      Calculated = True
    end
    object quModelManufacture: TStringField
      FieldName = 'Manufacture'
      Size = 50
    end
    object quModelTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quModelTotQtyOnRepair: TFloatField
      FieldName = 'TotQtyOnRepair'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quModelTotQtyOnPreSale: TFloatField
      FieldName = 'TotQtyOnPreSale'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quModelTotQtyOnPrePurchase: TFloatField
      FieldName = 'TotQtyOnPrePurchase'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quModelTotQtyOnOrder: TFloatField
      FieldName = 'TotQtyOnOrder'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quModelTotQtyOnHandF: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotQtyOnHandF'
      DisplayFormat = '0.#####'
      Calculated = True
    end
  end
  object dsModelList: TDataSource [8]
    DataSet = quModel
    Left = 51
    Top = 203
  end
  object gridPrinter: TdxComponentPrinter [9]
    CurrentLink = gridPrinterLink
    PreviewOptions.WindowState = wsMaximized
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    Version = 0
    Left = 114
    Top = 156
    object gridPrinterLink: TdxGridReportLink
      Active = True
      Caption = 'InventoryReport'
      Component = grdModelList
      DateTime = 40802.562588240740000000
      DesignerHelpContext = 0
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 250
      PrinterPage.Header = 250
      PrinterPage.Margins.Bottom = 500
      PrinterPage.Margins.Left = 500
      PrinterPage.Margins.Right = 500
      PrinterPage.Margins.Top = 500
      PrinterPage.MinMargins.Bottom = 0
      PrinterPage.MinMargins.Left = 0
      PrinterPage.MinMargins.Right = 0
      PrinterPage.MinMargins.Top = 0
      PrinterPage.PageFooter.Background.Mode = bmBrush
      PrinterPage.PageFooter.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageFooter.Font.Color = clWindowText
      PrinterPage.PageFooter.Font.Height = -11
      PrinterPage.PageFooter.Font.Name = 'Tahoma'
      PrinterPage.PageFooter.Font.Style = []
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageHeader.Background.Mode = bmBrush
      PrinterPage.PageHeader.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageHeader.Font.Color = clWindowText
      PrinterPage.PageHeader.Font.Height = -11
      PrinterPage.PageHeader.Font.Name = 'Tahoma'
      PrinterPage.PageHeader.Font.Style = []
      PrinterPage.PageHeader.LeftTitle.Strings = (
        '')
      PrinterPage.PageSize.X = 8268
      PrinterPage.PageSize.Y = 11693
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
      ReportTitle.Font.Charset = ANSI_CHARSET
      ReportTitle.Font.Color = clWindowText
      ReportTitle.Font.Height = -11
      ReportTitle.Font.Name = 'Tahoma'
      ReportTitle.Font.Style = []
      ReportTitle.Mode = tmOnFirstPage
      ReportTitle.Text = 'Inventory List'
      ReportTitle.TextAlignX = taLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      OptionsCards.Shadow.Color = clBlack
      OptionsExpanding.ExpandGroupRows = True
      OptionsExpanding.ExpandMasterRows = True
      OptionsFormatting.LookAndFeelKind = lfFlat
      OptionsOnEveryPage.FilterBar = False
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.Headers = False
      OptionsView.Caption = False
      OptionsView.ExpandButtons = False
      OptionsView.FilterBar = False
      OptionsView.Footers = False
      OptionsView.GroupFooters = False
      BuiltInReportLink = True
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmInventoryList.sil'
  end
  object strepPredefined: TcxStyleRepository
    Left = 134
    Top = 214
    object cxStyle: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clDefault
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxGridTableViewStyleSheet: TcxGridTableViewStyleSheet
      Styles.Background = cxStyle
    end
  end
end
