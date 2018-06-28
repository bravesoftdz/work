inherited SubRupture: TSubRupture
  Left = 330
  Top = 159
  Width = 578
  Height = 248
  Caption = 'SubRupture'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object grdRupture: TcxGrid [0]
    Left = 0
    Top = 0
    Width = 496
    Height = 221
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    object grdRuptureDB: TcxGridDBTableView
      DataController.DataSource = dsRupture
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'Model'
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = grdRuptureDBLostRevenue
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = grdRuptureDBNetProfit
        end>
      DataController.Summary.SummaryGroups = <>
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
      OptionsView.Footer = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      OnCustomization = grdRuptureDBCustomization
      object grdRuptureDBIDModel: TcxGridDBColumn
        DataBinding.FieldName = 'IDModel'
        Visible = False
      end
      object grdRuptureDBModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
      end
      object grdRuptureDBDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
      end
      object grdRuptureDBSalePrice: TcxGridDBColumn
        Caption = 'Sale Price'
        DataBinding.FieldName = 'SellingPrice'
      end
      object grdRuptureDBVendor: TcxGridDBColumn
        Caption = 'Vendor'
        DataBinding.FieldName = 'Pessoa'
      end
      object grdRuptureDBInitialQty: TcxGridDBColumn
        Caption = 'Initial Qty'
        DataBinding.FieldName = 'QtdInicial'
        Visible = False
      end
      object grdRuptureDBNumDaysZeroSupply: TcxGridDBColumn
        Caption = 'Num Days Zero Supply'
        DataBinding.FieldName = 'NumDiasRuptura'
      end
      object grdRuptureDBGiro: TcxGridDBColumn
        Caption = 'Avg Sales'
        DataBinding.FieldName = 'Giro'
      end
      object grdRuptureDBLostRevenue: TcxGridDBColumn
        Caption = 'Lost Revenue'
        DataBinding.FieldName = 'Ruptura'
      end
      object grdRuptureDBVendorCost: TcxGridDBColumn
        DataBinding.FieldName = 'VendorCost'
      end
      object grdRuptureDBTax: TcxGridDBColumn
        DataBinding.FieldName = 'Tax'
      end
      object grdRuptureDBNetProfit: TcxGridDBColumn
        Caption = 'Net Profit'
        DataBinding.FieldName = 'Lucro'
      end
      object grdRuptureDBFinalQty: TcxGridDBColumn
        Caption = 'Final Qty'
        DataBinding.FieldName = 'QtdFinal'
        Visible = False
      end
    end
    object grdRuptureLevel: TcxGridLevel
      GridView = grdRuptureDB
    end
  end
  object Panel1: TPanel [1]
    Left = 496
    Top = 0
    Width = 74
    Height = 221
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
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
    object pnlDivisoria2: TPanel
      Left = 7
      Top = 57
      Width = 60
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  object qryRuptura: TADODataSet [2]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.SellingPrice,'#13#10#9'M.Model,'#13#10#9'M.[Descriptio' +
      'n],'#13#10#9'M.VendorCost,'#13#10#9'M.GroupID as IDGroup,'#13#10#9'P.Pessoa,'#13#10#9'CAST(0' +
      ' as Int) NumDiasRuptura,'#13#10#9'CAST(0 as Float) Giro,'#13#10#9'CAST(0 as Fl' +
      'oat) Balance,'#13#10#9'CAST(0 as Money) Ruptura,'#13#10#9'CAST(0.0 as Float) Q' +
      'tdFinal,'#13#10#9'CAST(0 as Money) Lucro,'#13#10#9'CAST(0 as Money) Tax'#13#10'FROM'#13 +
      #10#9'Model M (NOLOCK)'#13#10#9'LEFT JOIN InventoryMov IM (NOLOCK) ON (M.ID' +
      'Model = IM.ModelID AND IM.StoreID = (CASE WHEN :IDStore1 = 0 THE' +
      'N IM.StoreID ELSE :IDStore2 END))'#13#10#9'LEFT JOIN InventoryMovType I' +
      'MT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)'#13#10#9'LEFT' +
      ' JOIN Inv_ModelVendor MV (NOLOCK) ON (M.IDModel = MV.IDModel AND' +
      ' MV.VendorOrder = 1)'#13#10#9'LEFT JOIN Pessoa P (NOLOCK) ON (MV.IDPess' +
      'oa = P.IDPessoa)'#13#10'WHERE'#13#10#9'dbo.fn_Sys_RemoveTime(IM.MovDate) > :D' +
      'ataInicio'#13#10#9'AND'#13#10#9'M.Desativado = 0'#13#10'GROUP BY'#13#10#9'M.IDModel,'#13#10#9'M.Mo' +
      'del,'#13#10#9'M.[Description],'#13#10#9'M.SellingPrice,'#13#10#9'M.VendorCost,'#13#10#9'M.Gr' +
      'oupID,'#13#10#9'P.Pessoa'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDStore1'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'IDStore2'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DataInicio'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end>
    Left = 320
    Top = 28
    object qryRupturaIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryRupturaSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object qryRupturaModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object qryRupturaDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object qryRupturaVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object qryRupturaIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object qryRupturaPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object qryRupturaNumDiasRuptura: TIntegerField
      FieldName = 'NumDiasRuptura'
    end
    object qryRupturaGiro: TFloatField
      FieldName = 'Giro'
    end
    object qryRupturaRuptura: TBCDField
      FieldName = 'Ruptura'
      Precision = 19
    end
    object qryRupturaQtdFinal: TFloatField
      FieldName = 'QtdFinal'
    end
    object qryRupturaLucro: TBCDField
      FieldName = 'Lucro'
      Precision = 19
    end
    object qryRupturaTax: TBCDField
      FieldName = 'Tax'
      Precision = 19
    end
    object qryRupturaBalance: TFloatField
      FieldName = 'Balance'
    end
  end
  object dsRupture: TDataSource [3]
    DataSet = cdsRuptura
    Left = 380
    Top = 80
  end
  object qryMovimento: TADODataSet [4]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'IM.MovDate,'#13#10#9'((2 * IMT.UpdateOnHand-1) * IsNull(IM.Qty' +
      ', 0)) Qty'#13#10'FROM'#13#10#9'InventoryMov IM (NOLOCK)'#13#10#9'JOIN InventoryMovTy' +
      'pe IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)'#13#10'W' +
      'HERE'#13#10#9'IM.ModelID = :IDModel'#13#10#9'AND dbo.fn_Sys_RemoveTime(IM.MovD' +
      'ate) >= :DataInicial'#13#10#9'AND dbo.fn_Sys_RemoveTime(IM.MovDate) <= ' +
      ':DataFinal'#13#10#9'AND IMT.UpdateOnHand IS NOT NULL'#13#10#9'AND IM.StoreID =' +
      ' (CASE WHEN :IDStore1 = 0 THEN IM.StoreID ELSE :IDStore2 END)'#13#10'O' +
      'RDER BY'#13#10#9'IM.MovDate'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDStore1'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore2'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 224
    Top = 84
    object qryMovimentoMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object qryMovimentoQty: TFloatField
      FieldName = 'Qty'
      ReadOnly = True
    end
  end
  object qryGiro: TADODataSet [5]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'SUM(Qty) BalanceQty'#13#10'FROM'#9#13#10#9'InventoryMov IM (NOLOCK)'#13#10 +
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)'#13#10#9'JOIN TabGro' +
      'up TG (NOLOCK) ON (M.GroupID = TG.IDGroup)'#13#10'WHERE'#13#10#9'IM.InventMov' +
      'TypeID = 1'#13#10#9'AND IM.ModelID = :IDModel'#13#10#9'AND dbo.fn_Sys_RemoveTi' +
      'me(IM.MovDate) >= :DataInicial'#13#10#9'AND dbo.fn_Sys_RemoveTime(IM.Mo' +
      'vDate) <= :DataFinal'#13#10#9'AND IM.StoreID = (CASE WHEN :IDStore1 = 0' +
      ' THEN IM.StoreID ELSE :IDStore2 END)'#13#10'GROUP BY'#13#10#9'IM.ModelID'
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'DataFinal'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDStore1'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore2'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 228
    Top = 136
    object qryGiroBalanceQty: TFloatField
      FieldName = 'BalanceQty'
      ReadOnly = True
    end
  end
  object cdsRuptura: TClientDataSet [6]
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'IDStore1'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDStore2'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DataInicio'
        ParamType = ptInput
      end>
    ProviderName = 'dspRuptura'
    Left = 444
    Top = 29
    object cdsRupturaIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsRupturaSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsRupturaModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsRupturaDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsRupturaVendorCost: TBCDField
      FieldName = 'VendorCost'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsRupturaIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object cdsRupturaPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object cdsRupturaNumDiasRuptura: TIntegerField
      FieldName = 'NumDiasRuptura'
    end
    object cdsRupturaGiro: TFloatField
      FieldName = 'Giro'
      DisplayFormat = '#,##0.000'
    end
    object cdsRupturaRuptura: TBCDField
      FieldName = 'Ruptura'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsRupturaQtdFinal: TFloatField
      FieldName = 'QtdFinal'
    end
    object cdsRupturaLucro: TBCDField
      FieldName = 'Lucro'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsRupturaTax: TBCDField
      FieldName = 'Tax'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsRupturaBalance: TFloatField
      FieldName = 'Balance'
    end
  end
  object dspRuptura: TDataSetProvider [7]
    DataSet = qryRuptura
    Options = [poIncFieldProps]
    Left = 380
    Top = 29
  end
  object gridPrinter: TdxComponentPrinter [8]
    CurrentLink = gridPrinterLink
    PreviewOptions.WindowState = wsMaximized
    PreviewOptions.PreviewBoundsRect = {00000000000000002003000058020000}
    Version = 0
    Left = 114
    Top = 22
    object gridPrinterLink: TdxGridReportLink
      Caption = 'New Report'
      Component = grdRupture
      DesignerHelpContext = 0
      PrinterPage.Footer = 250
      PrinterPage.Header = 106
      PrinterPage.Margins.Bottom = 500
      PrinterPage.Margins.Left = 500
      PrinterPage.Margins.Right = 500
      PrinterPage.Margins.Top = 500
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
      PrinterPage.PageSize.X = 8500
      PrinterPage.PageSize.Y = 11000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 1
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
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubRupture.sil'
  end
  object qryImposto: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'SUM((2 * IsNull(TC.Debit, 0)-1) * IsNull(TC.Tax, 0))*-1' +
      ' Tax'#13#10'FROM'#13#10'  '#9'StoreToTabGroup STTG (NOLOCK)'#13#10'  '#9'LEFT JOIN TaxCa' +
      'tegory TC (NOLOCK) ON (STTG.IDSaleTax = TC.IDTaxCategory)'#13#10'WHERE' +
      #13#10'  '#9'STTG.IDGroup = :IDGroup'#13#10'  '#9'AND STTG.IDStore = :IDStore'
    Parameters = <
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 48
    Top = 88
    object qryImpostoTax: TBCDField
      FieldName = 'Tax'
      ReadOnly = True
      Precision = 19
    end
  end
  object qryEncargos: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'SUM((2 * IsNull(TC.Debit, 0)-1) * IsNull(TC.Tax, 0))*-1' +
      ' Tax'#13#10'FROM'#13#10#9'StoreToTabGroup STTG (NOLOCK)'#13#10#9'LEFT OUTER JOIN Tax' +
      'Category TC (NOLOCK) ON (STTG.IDTaxCategory = TC.IDTaxCategoryPa' +
      'rent)'#13#10#9'LEFT OUTER JOIN TaxCategory TCP (NOLOCK) ON (TCP.IDTaxCa' +
      'tegory = TC.IDTaxCategoryParent)'#13#10'WHERE'#13#10#9'STTG.IDGroup = :IDGrou' +
      'p'#13#10'  '#9'AND STTG.IDStore = :IDStore'
    Parameters = <
      item
        Name = 'IDGroup'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 48
    Top = 136
    object qryEncargosTax: TBCDField
      FieldName = 'Tax'
      ReadOnly = True
      Precision = 19
    end
  end
  object qtyBalance: TADODataSet
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'SUM(((2 * IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))) Bal' +
      'anceQty'#13#10'FROM'#9#13#10#9'InventoryMov IM (NOLOCK)'#13#10#9'JOIN InventoryMovTyp' +
      'e IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)'#13#10'WH' +
      'ERE'#13#10#9'IM.ModelID = :IDModel'#13#10#9'AND dbo.fn_Sys_RemoveTime(IM.MovDa' +
      'te) < :DataInicial'#13#10#9'AND IM.StoreID = (CASE WHEN :IDStore1 = 0 T' +
      'HEN IM.StoreID ELSE :IDStore2 END)'#13#10
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'DataInicial'
        Attributes = [paNullable]
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = Null
      end
      item
        Name = 'IDStore1'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDStore2'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 228
    Top = 36
    object FloatField1: TFloatField
      FieldName = 'BalanceQty'
      ReadOnly = True
    end
  end
end
