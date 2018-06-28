inherited SubBestSeller: TSubBestSeller
  Left = 219
  Top = 208
  Width = 756
  Height = 269
  Caption = 'SubBestSeller'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 666
    Top = 0
    Width = 74
    Height = 231
    Align = alRight
    TabOrder = 0
    object btPrint: TSpeedButton
      Tag = 5
      Left = 4
      Top = 3
      Width = 66
      Height = 26
      Caption = '&Preview'
      Flat = True
      Margin = 4
      Spacing = 7
      OnClick = btPrintClick
    end
    object btExcel: TSpeedButton
      Tag = 7
      Left = 4
      Top = 29
      Width = 66
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
      Left = 4
      Top = 61
      Width = 66
      Height = 25
      AllowAllUp = True
      GroupIndex = 88997
      Caption = '&Grouping'
      Flat = True
      Margin = 4
      Spacing = 8
      OnClick = btGroupClick
    end
    object btColumn: TSpeedButton
      Tag = 4
      Left = 4
      Top = 86
      Width = 66
      Height = 25
      AllowAllUp = True
      GroupIndex = 1235
      Caption = 'Colum&ns'
      Flat = True
      Margin = 4
      Spacing = 7
      OnClick = btColumnClick
    end
    object btnFilter: TSpeedButton
      Tag = 4
      Left = 4
      Top = 111
      Width = 66
      Height = 25
      AllowAllUp = True
      GroupIndex = 1235
      Caption = '&Filter'
      Flat = True
      Margin = 4
      Spacing = 7
      OnClick = btnFilterClick
    end
    object pnlDivisoria2: TPanel
      Left = 11
      Top = 57
      Width = 56
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  object grdBestSeller: TcxGrid [1]
    Left = 0
    Top = 0
    Width = 666
    Height = 231
    Align = alClient
    TabOrder = 1
    LookAndFeel.Kind = lfFlat
    object grdBestSellerDB: TcxGridDBTableView
      DataController.DataSource = dsBestSeller
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'Model'
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'AccProfitPerc'
          Column = grdBestSellerDBAccProfitPerc
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'StokeTurnOver'
          Column = grdBestSellerDBDBStokeTurnOver
        end
        item
          Format = '0'
          Kind = skSum
          Position = spFooter
          FieldName = 'QtySold'
          Column = grdBestSellerDBQtySold
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TotalSold'
          Column = grdBestSellerDBTotalSold
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '0'
          Kind = skSum
          FieldName = 'QtyOnHand'
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'QtyOnOrder'
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'QtyOnPrePurchase'
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'QtyOnPreSale'
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'QtyOnRepair'
        end
        item
          Format = '0'
          Kind = skSum
          FieldName = 'QtySold'
          Column = grdBestSellerDBQtySold
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'Profit'
          Column = grdBestSellerDBProfit
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'TotalSold'
          Column = grdBestSellerDBTotalSold
        end>
      DataController.Summary.SummaryGroups = <
        item
          Links = <
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end
            item
            end>
          SummaryItems = <>
        end>
      Filtering.CustomizeDialog = False
      Filtering.MaxDropDownCount = 1000
      OptionsBehavior.DragOpening = False
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsSelection.HideFocusRect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      OnCustomization = grdBestSellerDBCustomization
      object grdBestSellerDBModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        Width = 51
      end
      object grdBestSellerDBDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Visible = False
        Width = 89
      end
      object grdBestSellerDBCategory: TcxGridDBColumn
        DataBinding.FieldName = 'Category'
        Width = 75
      end
      object grdBestSellerDBQtySold: TcxGridDBColumn
        DataBinding.FieldName = 'QtySold'
        Width = 48
      end
      object grdBestSellerDBProfit: TcxGridDBColumn
        DataBinding.FieldName = 'Profit'
        Width = 49
      end
      object grdBestSellerDBLastSaleDate: TcxGridDBColumn
        DataBinding.FieldName = 'LastSaleDate'
        Visible = False
        Width = 87
      end
      object grdBestSellerDBPercents: TcxGridDBColumn
        DataBinding.FieldName = 'Percents'
        Width = 53
      end
      object grdBestSellerDBTotQtyOnHand: TcxGridDBColumn
        Caption = 'OnHand'
        DataBinding.FieldName = 'TotQtyOnHand'
        Width = 53
      end
      object grdBestSellerDBVendorCost: TcxGridDBColumn
        DataBinding.FieldName = 'VendorCost'
        Visible = False
        Width = 68
      end
      object grdBestSellerDBAvgCost: TcxGridDBColumn
        DataBinding.FieldName = 'AvgCost'
        Width = 52
      end
      object grdBestSellerDBNetCost: TcxGridDBColumn
        DataBinding.FieldName = 'NetCost'
        Visible = False
        Width = 44
      end
      object grdBestSellerDBOurPrice: TcxGridDBColumn
        DataBinding.FieldName = 'OurPrice'
        Width = 51
      end
      object grdBestSellerDBDBStokeTurnOver: TcxGridDBColumn
        DataBinding.FieldName = 'StokeTurnOver'
        Visible = False
        Width = 59
      end
      object grdBestSellerDBAccProfitPerc: TcxGridDBColumn
        DataBinding.FieldName = 'AccProfitPerc'
        SortOrder = soDescending
        Width = 92
      end
      object grdBestSellerDBFreight: TcxGridDBColumn
        DataBinding.FieldName = 'Freight'
        Visible = False
      end
      object grdBestSellerDBOtherCost: TcxGridDBColumn
        DataBinding.FieldName = 'OtherCost'
        Visible = False
      end
      object grdBestSellerDBLastPurchaseDate: TcxGridDBColumn
        DataBinding.FieldName = 'LastPurchaseDate'
        Visible = False
      end
      object grdBestSellerDBMarkUp: TcxGridDBColumn
        DataBinding.FieldName = 'MarkUp'
        Visible = False
      end
      object grdBestSellerDBMSRP: TcxGridDBColumn
        DataBinding.FieldName = 'MSRP'
        Visible = False
      end
      object grdBestSellerDBLastMovDate: TcxGridDBColumn
        DataBinding.FieldName = 'LastMovDate'
        Visible = False
      end
      object grdBestSellerDBClassification: TcxGridDBColumn
        DataBinding.FieldName = 'Classification'
        Visible = False
      end
      object grdBestSellerDBVendor: TcxGridDBColumn
        DataBinding.FieldName = 'Vendor'
        Visible = False
      end
      object grdBestSellerDBTotalSold: TcxGridDBColumn
        DataBinding.FieldName = 'TotalSold'
        Visible = False
      end
      object grdBestSellerDBColor: TcxGridDBColumn
        DataBinding.FieldName = 'Color'
        Visible = False
      end
      object grdBestSellerDBSizeName: TcxGridDBColumn
        DataBinding.FieldName = 'SizeName'
        Visible = False
      end
      object grdBestSellerDBMGroup: TcxGridDBColumn
        DataBinding.FieldName = 'MGroup'
        Visible = False
      end
      object grdBestSellerDBSubCategory: TcxGridDBColumn
        DataBinding.FieldName = 'SubCategory'
        Visible = False
      end
      object grdBestSellerDBTotalCostSold: TcxGridDBColumn
        DataBinding.FieldName = 'TotalCostSold'
        Visible = False
      end
    end
    object grdBestSellerLevel: TcxGridLevel
      GridView = grdBestSellerDB
    end
  end
  object quBestSeller: TADODataSet [2]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quBestSellerCalcFields
    CommandText = 
      'SELECT'#13#10#9'M.Model,'#13#10#9'M.[Description],'#13#10#9'M.FreightCost Freight,'#13#10#9 +
      'M.OtherCost,'#13#10#9'M.VendorCost VCost,'#13#10#9'M.ReplacementCost,'#13#10#9'M.Date' +
      'LastCost LastPurchaseDate,'#13#10#9'M.MarkUp,'#13#10#9'M.SellingPrice OurPrice' +
      ','#13#10#9'M.SuggRetail MSRP,'#13#10#9'M.TotQtyOnHand,'#13#10#9'M.LastMovDate,'#13#10#9'IsNu' +
      'll(M.AvgCost, M.FinalCost) AvgCost,'#13#10#9'M.FinalCost NetCost,'#13#10#9'M.D' +
      'ateLastSellingPrice LastSaleDate,'#13#10#9'M.ClasseABC Classification,'#13 +
      #10#9'TG.Category,'#13#10#9'MG.ModelGroup as SubCategory,'#13#10#9'MGS.ModelSubGro' +
      'up as MGroup,'#13#10#9'C.Color,'#13#10#9'S.SizeName,'#13#10#9'SUM(IM.Qty) QtySold,'#13#10#9 +
      'SUM((IM.SalePrice * IM.Qty) - IM.Discount) TotalSold,'#13#10#9'SUM((IM.' +
      'CostPrice * IM.Qty)) TotalCostSold,'#13#10#9'SUM((IM.SalePrice - IM.Cos' +
      'tPrice) * IM.Qty - IM.Discount) Profit,'#13#10#9'V.Pessoa Vendor'#13#10'FROM'#13 +
      #10#9'vw_Rep_InventoryMov IM (NOLOCK)'#13#10#9'JOIN vw_Rep_Model M (NOLOCK)' +
      ' ON (IM.IDModel = M.IDModel)'#13#10#9'JOIN vw_Rep_Category TG (NOLOCK) ' +
      'ON (M.GroupID = TG.IDCategory)'#13#10#9'LEFT JOIN Inv_ModelVendor MD (N' +
      'OLOCK) ON (M.IDModel = MD.IDModel AND VendorOrder = 1)'#13#10#9'LEFT JO' +
      'IN Pessoa V (NOLOCK) ON (MD.IDPessoa = V.IDPessoa)'#13#10#9'LEFT JOIN I' +
      'nvColor C (NOLOCK) ON (M.IDColor = C.IDColor)'#13#10#9'LEFT JOIN InvSiz' +
      'e S (NOLOCK) ON (M.IDSize = S.IDSize)'#13#10#9'LEFT OUTER JOIN ModelGro' +
      'up MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup)'#13#10#9'LEFT OUTE' +
      'R JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.ID' +
      'ModelSubGroup)'#13#10'GROUP BY '#13#10#9'M.Model,'#13#10#9'M.[Description],'#13#10#9'M.Frei' +
      'ghtCost,'#13#10#9'M.OtherCost,'#13#10#9'M.VendorCost,'#13#10#9'M.DateLastCost,'#13#10#9'M.Ma' +
      'rkUp,'#13#10#9'M.SellingPrice,'#13#10#9'M.DateLastSellingPrice,'#13#10#9'M.ClasseABC,' +
      #13#10#9'M.SuggRetail,'#13#10#9'M.TotQtyOnHand,'#13#10#9'M.LastMovDate,'#13#10#9'M.AvgCost,' +
      #13#10#9'M.FinalCost,'#13#10#9'TG.Category,'#13#10#9'MG.ModelGroup,'#13#10#9'MGS.ModelSubGr' +
      'oup,'#13#10#9'C.Color,'#13#10#9'S.SizeName,'#13#10#9'M.ReplacementCost,'#13#10#9'V.Pessoa'
    CommandTimeout = 600
    Parameters = <>
    Left = 91
    Top = 84
    object quBestSellerModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quBestSellerDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quBestSellerFreight: TBCDField
      FieldName = 'Freight'
      Precision = 19
    end
    object quBestSellerOtherCost: TBCDField
      FieldName = 'OtherCost'
      Precision = 19
    end
    object quBestSellerLastPurchaseDate: TDateTimeField
      FieldName = 'LastPurchaseDate'
    end
    object quBestSellerMarkUp: TBCDField
      FieldName = 'MarkUp'
      Precision = 19
    end
    object quBestSellerOurPrice: TBCDField
      FieldName = 'OurPrice'
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object quBestSellerMSRP: TBCDField
      FieldName = 'MSRP'
      Precision = 19
    end
    object quBestSellerLastMovDate: TDateTimeField
      FieldName = 'LastMovDate'
    end
    object quBestSellerAvgCost: TBCDField
      FieldName = 'AvgCost'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBestSellerNetCost: TBCDField
      FieldName = 'NetCost'
      Precision = 19
    end
    object quBestSellerLastSaleDate: TDateTimeField
      FieldName = 'LastSaleDate'
    end
    object quBestSellerCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quBestSellerProfit: TBCDField
      FieldName = 'Profit'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quBestSellerPercents: TBCDField
      DisplayLabel = 'Profit %'
      FieldName = 'Percents'
      ReadOnly = True
      DisplayFormat = '0.00 %'
      Precision = 19
    end
    object quBestSellerAccProfitPerc: TBCDField
      DisplayLabel = 'Acc. Profit %'
      FieldName = 'AccProfitPerc'
      ReadOnly = True
      DisplayFormat = '0.##### %'
      Precision = 19
    end
    object quBestSellerStokeTurnOver: TCurrencyField
      DisplayLabel = 'SKU Turn'
      FieldName = 'StokeTurnOver'
      DisplayFormat = '#,##0.00'
    end
    object quBestSellerVendorCost: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'VendorCost'
      Calculated = True
    end
    object quBestSellerVCost: TBCDField
      FieldName = 'VCost'
      Precision = 19
    end
    object quBestSellerReplacementCost: TBCDField
      FieldName = 'ReplacementCost'
      Precision = 19
    end
    object quBestSellerClassification: TStringField
      FieldName = 'Classification'
      Size = 1
    end
    object quBestSellerTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
      DisplayFormat = '0.#####'
    end
    object quBestSellerQtySold: TFloatField
      FieldName = 'QtySold'
      ReadOnly = True
      DisplayFormat = '0.#####'
    end
    object quBestSellerVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object quBestSellerTotalSold: TBCDField
      FieldName = 'TotalSold'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 32
      Size = 6
    end
    object quBestSellerColor: TStringField
      FieldName = 'Color'
    end
    object quBestSellerSizeName: TStringField
      FieldName = 'SizeName'
    end
    object quBestSellerSubCategory: TStringField
      FieldName = 'SubCategory'
      Size = 30
    end
    object quBestSellerMGroup: TStringField
      FieldName = 'MGroup'
      Size = 30
    end
    object quBestSellerTotalCostSold: TBCDField
      DisplayLabel = 'Total Cost Sold'
      FieldName = 'TotalCostSold'
      DisplayFormat = '#,##0.00'
    end
  end
  object dsBestSeller: TDataSource [3]
    DataSet = quBestSeller
    Left = 90
    Top = 31
  end
  object quTempTable: TADOCommand [4]
    CommandTimeout = 600
    Connection = DM.ADODBConnect
    Parameters = <>
    Left = 90
    Top = 145
  end
  object gridPrinter: TdxComponentPrinter [5]
    CurrentLink = gridPrinterLink
    PreviewOptions.WindowState = wsMaximized
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    Version = 0
    Left = 170
    Top = 34
    object gridPrinterLink: TdxGridReportLink
      Caption = 'New Report'
      Component = grdBestSeller
      DesignerHelpContext = 0
      PrinterPage.Footer = 6350
      PrinterPage.Header = 2692
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.MinMargins.Bottom = 0
      PrinterPage.MinMargins.Left = 0
      PrinterPage.MinMargins.Right = 0
      PrinterPage.MinMargins.Top = 0
      PrinterPage.PageFooter.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageFooter.Font.Color = clWindowText
      PrinterPage.PageFooter.Font.Height = -11
      PrinterPage.PageFooter.Font.Name = 'Tahoma'
      PrinterPage.PageFooter.Font.Style = []
      PrinterPage.PageHeader.Font.Charset = DEFAULT_CHARSET
      PrinterPage.PageHeader.Font.Color = clWindowText
      PrinterPage.PageHeader.Font.Height = -11
      PrinterPage.PageHeader.Font.Name = 'Tahoma'
      PrinterPage.PageHeader.Font.Style = []
      PrinterPage.PageSize.X = 215900
      PrinterPage.PageSize.Y = 279400
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportTitle.Font.Charset = DEFAULT_CHARSET
      ReportTitle.Font.Color = clWindowText
      ReportTitle.Font.Height = -19
      ReportTitle.Font.Name = 'Times New Roman'
      ReportTitle.Font.Style = [fsBold]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Times New Roman'
      Font.Style = []
      OptionsCards.Shadow.Color = clBlack
      BuiltInReportLink = True
    end
  end
  object quTempPurchaseTime: TADOCommand [6]
    CommandTimeout = 600
    Connection = DM.ADODBConnect
    Parameters = <>
    Left = 195
    Top = 145
  end
  object quTotalSales: TADODataSet [7]
    Connection = DM.ADODBConnect
    CommandTimeout = 600
    Parameters = <>
    Left = 180
    Top = 88
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubBestSeller.sil'
  end
end
