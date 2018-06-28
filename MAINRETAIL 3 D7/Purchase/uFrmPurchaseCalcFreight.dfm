inherited FrmPurchaseCalcFreight: TFrmPurchaseCalcFreight
  Left = 22
  Top = 120
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Calc Freight'
  ClientHeight = 523
  ClientWidth = 791
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 791
    inherited Image1: TImage
      Width = 564
    end
    inherited lblMenu: TLabel
      Left = 575
    end
    inherited EspacamentoSuperior: TPanel
      Width = 791
      inherited EEE: TPanel
        Width = 791
      end
    end
  end
  inherited Panel1: TPanel
    Top = 482
    Width = 791
    inherited EspacamentoInferior: TPanel
      Width = 791
      inherited Panel3: TPanel
        Width = 791
      end
    end
    inherited hhh: TPanel
      Left = 622
      Width = 169
      inherited btClose: TButton
        Left = 98
        OnClick = btCloseClick
      end
      object btnOK: TButton
        Left = 26
        Top = 3
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
        OnClick = btnOKClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 81
    Height = 401
  end
  inherited EspacamentoDireito: TPanel
    Left = 788
    Top = 81
    Height = 401
  end
  object pnlValues: TPanel [4]
    Left = 0
    Top = 40
    Width = 791
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object lbFreight: TLabel
      Left = 36
      Top = 12
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Freight :'
    end
    object lbOtherCost: TLabel
      Left = 229
      Top = 12
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Other Cost :'
    end
    object lbDiscount: TLabel
      Left = 446
      Top = 12
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = 'Discount :'
    end
    object edtFreight: TSuperEditCurrency
      Left = 83
      Top = 8
      Width = 117
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '0.00'
      OnKeyPress = edtFreightKeyPress
      Alignment = taRightJustify
    end
    object edtOtherCost: TSuperEditCurrency
      Left = 295
      Top = 8
      Width = 117
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0.00'
      OnKeyPress = edtFreightKeyPress
      Alignment = taRightJustify
    end
    object btnApply: TBitBtn
      Left = 683
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Apply'
      TabOrder = 2
      OnClick = btnApplyClick
    end
    object edtDiscount: TSuperEditCurrency
      Left = 500
      Top = 8
      Width = 117
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '0.00'
      OnKeyPress = edtFreightKeyPress
      Alignment = taRightJustify
    end
  end
  object grdPurchaseItem: TcxGrid [5]
    Left = 3
    Top = 81
    Width = 785
    Height = 401
    Align = alClient
    TabOrder = 5
    LookAndFeel.Kind = lfFlat
    object grdPurchaseItemDB: TcxGridDBTableView
      DataController.DataSource = dsPurchaseItem
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDPurchaseItem'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'CostPrice'
          Column = grdPurchaseItemDBCostPrice
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'Freight'
          Column = grdPurchaseItemDBFreight
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'OtherCost'
          Column = grdPurchaseItemDBOtherCost
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'NewSalePrice'
          Column = grdPurchaseItemDBNewSalePrice
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'NewMSRP'
          Column = grdPurchaseItemDBNewMSRP
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'NewCostPrice'
          Column = grdPurchaseItemDBNewCostPrice
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'Taxes'
          Column = grdPurchaseItemDBTaxes
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'Discount'
          Column = grdPurchaseItemDBDiscount
        end>
      DataController.Summary.SummaryGroups = <>
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdPurchaseItemDBModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        Options.Filtering = False
        Width = 79
      end
      object grdPurchaseItemDBDescription: TcxGridDBColumn
        DataBinding.FieldName = 'Description'
        Options.Filtering = False
        Width = 125
      end
      object grdPurchaseItemDBQty: TcxGridDBColumn
        DataBinding.FieldName = 'Qty'
        Options.Filtering = False
        Width = 43
      end
      object grdPurchaseItemDBCostPrice: TcxGridDBColumn
        DataBinding.FieldName = 'CostPrice'
        Options.Filtering = False
        Width = 69
      end
      object grdPurchaseItemDBDiscount: TcxGridDBColumn
        DataBinding.FieldName = 'Discount'
        Options.Filtering = False
        Width = 63
      end
      object grdPurchaseItemDBFreight: TcxGridDBColumn
        DataBinding.FieldName = 'Freight'
        Options.Filtering = False
        Width = 65
      end
      object grdPurchaseItemDBOtherCost: TcxGridDBColumn
        DataBinding.FieldName = 'OtherCost'
        Options.Filtering = False
        Width = 69
      end
      object grdPurchaseItemDBTaxes: TcxGridDBColumn
        DataBinding.FieldName = 'Taxes'
        Options.Filtering = False
        Width = 57
      end
      object grdPurchaseItemDBNewCostPrice: TcxGridDBColumn
        DataBinding.FieldName = 'NewCostPrice'
        Options.Filtering = False
        Width = 76
      end
      object grdPurchaseItemDBNewSalePrice: TcxGridDBColumn
        DataBinding.FieldName = 'NewSalePrice'
        Options.Filtering = False
        Width = 76
      end
      object grdPurchaseItemDBNewMSRP: TcxGridDBColumn
        DataBinding.FieldName = 'NewMSRP'
        Options.Filtering = False
        Width = 61
      end
    end
    object grdPurchaseItemLevel: TcxGridLevel
      GridView = grdPurchaseItemDB
    end
  end
  object cdsPurchaseItem: TClientDataSet [6]
    Aggregates = <>
    Params = <>
    Left = 172
    Top = 120
    object cdsPurchaseItemIDPurchaseItem: TIntegerField
      FieldName = 'IDPurchaseItem'
    end
    object cdsPurchaseItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsPurchaseItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsPurchaseItemCostPrice: TCurrencyField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsPurchaseItemFreight: TCurrencyField
      FieldName = 'Freight'
      DisplayFormat = '#,##0.00'
    end
    object cdsPurchaseItemOtherCost: TCurrencyField
      FieldName = 'OtherCost'
      DisplayFormat = '#,##0.00'
    end
    object cdsPurchaseItemTaxes: TCurrencyField
      FieldName = 'Taxes'
      DisplayFormat = '#,##0.00'
    end
    object cdsPurchaseItemNewCostPrice: TCurrencyField
      FieldName = 'NewCostPrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsPurchaseItemNewSalePrice: TCurrencyField
      FieldName = 'NewSalePrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsPurchaseItemNewMSRP: TCurrencyField
      FieldName = 'NewMSRP'
      DisplayFormat = '#,##0.00'
    end
    object cdsPurchaseItemQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsPurchaseItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsPurchaseItemIDCategory: TIntegerField
      FieldName = 'IDCategory'
    end
    object cdsPurchaseItemIDSubCategory: TIntegerField
      FieldName = 'IDSubCategory'
    end
    object cdsPurchaseItemIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object cdsPurchaseItemDiscount: TCurrencyField
      FieldName = 'Discount'
      DisplayFormat = '#,##0.00'
    end
  end
  object cdsItemTaxes: TClientDataSet [7]
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 120
    object cdsItemTaxesIDPurchaseItemTax: TIntegerField
      FieldName = 'IDPurchaseItemTax'
    end
    object cdsItemTaxesIDPurchaseItem: TIntegerField
      FieldName = 'IDPurchaseItem'
    end
    object cdsItemTaxesTaxValue: TCurrencyField
      FieldName = 'TaxValue'
    end
    object cdsItemTaxesDebit: TBooleanField
      FieldName = 'Debit'
    end
    object cdsItemTaxesFormula: TStringField
      FieldName = 'Formula'
      Size = 255
    end
    object cdsItemTaxesIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object cdsItemTaxesTaxPercentage: TBCDField
      FieldName = 'TaxPercentage'
      Size = 0
    end
  end
  object quPurchaseItem: TADODataSet [8]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'PI.IDPurchaseItem,'#13#10#9'PI.CostPrice,'#13#10#9'PI.FreightCost,'#13#10#9 +
      'PI.OtherCost,'#13#10#9'PI.Discount,'#13#10#9'PI.NewCostPrice,'#13#10#9'PI.NewSalePric' +
      'e,'#13#10#9'PI.NewSuggRetail,'#13#10#9'PI.Qty,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M' +
      '.IDModel,'#13#10#9'M.GroupID as IDCategory,'#13#10#9'M.IDModelGroup as IDSubCa' +
      'tegory,'#13#10#9'M.IDModelSubGroup as IDGroup'#13#10'FROM'#13#10#9'Pur_PurchaseItem ' +
      'PI (NOLOCK) '#13#10#9'LEFT JOIN Model M (NOLOCK) ON (PI.IDModel  = M.ID' +
      'Model)'#13#10'WHERE'#13#10#9'PI.IDPurchase = :IDPurchase'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDPurchase'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 72
    Top = 120
    object quPurchaseItemIDPurchaseItem: TIntegerField
      FieldName = 'IDPurchaseItem'
    end
    object quPurchaseItemCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object quPurchaseItemFreightCost: TBCDField
      FieldName = 'FreightCost'
      Precision = 19
    end
    object quPurchaseItemOtherCost: TBCDField
      FieldName = 'OtherCost'
      Precision = 19
    end
    object quPurchaseItemNewCostPrice: TBCDField
      FieldName = 'NewCostPrice'
      Precision = 19
    end
    object quPurchaseItemNewSalePrice: TBCDField
      FieldName = 'NewSalePrice'
      Precision = 19
    end
    object quPurchaseItemNewSuggRetail: TBCDField
      FieldName = 'NewSuggRetail'
      Precision = 19
    end
    object quPurchaseItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quPurchaseItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quPurchaseItemQty: TFloatField
      FieldName = 'Qty'
    end
    object quPurchaseItemIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quPurchaseItemIDCategory: TIntegerField
      FieldName = 'IDCategory'
    end
    object quPurchaseItemIDSubCategory: TIntegerField
      FieldName = 'IDSubCategory'
    end
    object quPurchaseItemIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quPurchaseItemDiscount: TBCDField
      FieldName = 'Discount'
      Precision = 19
    end
  end
  object dsPurchaseItem: TDataSource [9]
    DataSet = cdsPurchaseItem
    Left = 176
    Top = 172
  end
  object quItemTax: TADODataSet [10]
    Connection = DM.ADODBConnect
    CommandText = 
      'SELECT'#13#10#9'PIT.IDPurchaseItemTax,'#13#10#9'PIT.IDPurchaseItem,'#13#10#9'PIT.TaxV' +
      'alue,'#13#10#9'PIT.TaxPercentage,'#13#10#9'TG.IDTaxCategory,'#13#10#9'TG.TaxCategory,' +
      #13#10#9'TG.Debit,'#13#10#9'TG.Formula'#13#10'FROM '#13#10#9'Pur_PurchaseItemTax PIT (NOLO' +
      'CK) '#13#10#9'JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVen' +
      'dorTax)'#13#10#9'JOIN TaxCategory TG (NOLOCK)  ON (TG.IDTaxCategory = V' +
      'T.IDTaxCategory)'#13#10'WHERE'#13#10#9'PIT.IDPurchaseItem = :IDPurchaseItem'#13#10 +
      'ORDER BY'#13#10#9'LEN(TG.Formula)'
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 72
    Top = 180
    object quItemTaxIDPurchaseItemTax: TIntegerField
      FieldName = 'IDPurchaseItemTax'
    end
    object quItemTaxIDPurchaseItem: TIntegerField
      FieldName = 'IDPurchaseItem'
    end
    object quItemTaxTaxValue: TBCDField
      FieldName = 'TaxValue'
      Precision = 19
    end
    object quItemTaxTaxPercentage: TBCDField
      FieldName = 'TaxPercentage'
      Precision = 19
    end
    object quItemTaxIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quItemTaxTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
    object quItemTaxDebit: TBooleanField
      FieldName = 'Debit'
    end
    object quItemTaxFormula: TStringField
      FieldName = 'Formula'
      Size = 255
    end
  end
  object cmdUpdatePurchaseItem: TADOCommand [11]
    CommandText = 
      'UPDATE '#13#10#9'Pur_PurchaseItem '#13#10'SET '#13#10#9'FreightCost = :FreightCost, ' +
      #13#10#9'OtherCost = :OtherCost, '#13#10#9'NewCostPrice = :NewCostPrice,'#13#10#9'Ne' +
      'wSalePrice = IsNull(:NewSalePrice, NewSalePrice),'#13#10#9'NewSuggRetai' +
      'l = IsNull(:NewSuggRetail, NewSuggRetail),'#13#10#9'Discount = :Discoun' +
      't'#13#10'WHERE'#13#10#9'IDPurchaseItem = :IDPurchaseItem'
    CommandTimeout = 180
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'FreightCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'OtherCost'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewCostPrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewSalePrice'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'NewSuggRetail'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'Discount'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDPurchaseItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 288
    Top = 176
  end
  object cdmItemTax: TADOCommand [12]
    CommandText = 
      'UPDATE '#13#10#9'Pur_PurchaseItemTax'#13#10'SET'#13#10#9'TaxValue = :TaxValue'#13#10'WHERE' +
      #13#10#9'IDPurchaseItemTax = :IDPurchaseItemTax'#13#10
    CommandTimeout = 180
    Connection = DM.ADODBConnect
    Parameters = <
      item
        Name = 'TaxValue'
        Attributes = [paSigned, paNullable]
        DataType = ftBCD
        NumericScale = 4
        Precision = 19
        Size = 8
        Value = Null
      end
      item
        Name = 'IDPurchaseItemTax'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 404
    Top = 176
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPurchaseCalcFreight.sil'
  end
end
