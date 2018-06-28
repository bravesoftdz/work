inherited FinTaxComper: TFinTaxComper
  Left = -1
  Top = -2
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'FinTaxComper'
  ClientHeight = 545
  ClientWidth = 791
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 397
    Top = 145
    Width = 3
    Height = 338
    Cursor = crHSplit
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 145
    Height = 338
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 788
    Top = 145
    Height = 338
    Visible = False
  end
  inherited EspacamentoSuperior: TPanel
    Width = 791
    Height = 145
    Caption = 'Filter'
    object pnlBasicFilter: TPanel
      Left = 0
      Top = 0
      Width = 791
      Height = 145
      Align = alClient
      BevelOuter = bvNone
      Color = clBtnShadow
      TabOrder = 0
      object Label2: TLabel
        Left = 150
        Top = 31
        Width = 32
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'to'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 419
        Top = 31
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
      object Label1: TLabel
        Left = 25
        Top = 30
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'From :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 6
        Top = 53
        Width = 54
        Height = 13
        Alignment = taRightJustify
        Caption = 'Sale Tax :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 378
        Top = 53
        Width = 82
        Height = 13
        Alignment = taRightJustify
        Caption = 'Purchase Tax :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlExecuta: TPanel
        Left = 726
        Top = 0
        Width = 65
        Height = 145
        Align = alRight
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object pnlExecutaAviso: TPanel
          Left = 4
          Top = 41
          Width = 54
          Height = 45
          BevelOuter = bvNone
          Color = clGray
          TabOrder = 0
          object btExecuta: TButton
            Left = 4
            Top = 4
            Width = 48
            Height = 38
            Caption = '&GO!'
            Font.Charset = ANSI_CHARSET
            Font.Color = clMaroon
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            TabStop = False
            OnClick = btExecutaClick
          end
        end
      end
      object dbFim: TDateBox
        Left = 184
        Top = 27
        Width = 88
        Height = 21
        TabOrder = 1
        InputTime = False
      end
      object dbInicio: TDateBox
        Left = 66
        Top = 27
        Width = 81
        Height = 21
        TabOrder = 2
        InputTime = False
      end
      object scStore: TSuperComboADO
        Left = 463
        Top = 26
        Width = 208
        Height = 21
        TabOrder = 3
        CodeLength = 45
        LookUpSource = DM.dsLookUpStore
        DropDownRows = 16
        ShowBtnAddNew = False
        ShowBtnUpdate = False
      end
      object btTodasPessoas: TButton
        Left = 678
        Top = 27
        Width = 37
        Height = 21
        Caption = 'All'
        TabOrder = 4
        OnClick = btTodasPessoasClick
      end
      object chkSaleTax: TCheckListBox
        Left = 65
        Top = 53
        Width = 207
        Height = 87
        ItemHeight = 13
        TabOrder = 5
      end
      object chkPurchase: TCheckListBox
        Left = 463
        Top = 53
        Width = 207
        Height = 87
        ItemHeight = 13
        TabOrder = 6
      end
    end
  end
  inherited pnlEspacamentoInferiror: TPanel
    Top = 506
    Width = 791
    Height = 2
  end
  inherited pnlPBarra: TPanel
    Top = 508
    Width = 791
    inherited pnlPDAlignRight: TPanel
      Left = 591
      inherited btCancel: TBitBtn
        Visible = False
      end
      inherited btOk: TBitBtn
        Left = 106
        ModalResult = 1
      end
    end
    inherited pnlPLinhaSuperior: TPanel
      Width = 791
    end
  end
  object Panel1: TPanel [6]
    Left = 0
    Top = 483
    Width = 791
    Height = 23
    Align = alBottom
    Color = clBtnShadow
    TabOrder = 5
    object Label6: TLabel
      Left = 645
      Top = 5
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Diferrence :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbTotal: TLabel
      Left = 757
      Top = 5
      Width = 24
      Height = 13
      Alignment = taRightJustify
      Caption = '0.00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel [7]
    Left = 3
    Top = 145
    Width = 394
    Height = 338
    Align = alLeft
    Caption = 'Sale'
    TabOrder = 6
    object Label7: TLabel
      Left = 1
      Top = 1
      Width = 392
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Sale Tax'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object grdSale: TdxDBGrid
      Left = 1
      Top = 17
      Width = 392
      Height = 320
      Bands = <
        item
        end>
      DefaultLayout = True
      HeaderPanelRowCount = 1
      KeyField = 'IDInventoryMov'
      ShowSummaryFooter = True
      SummaryGroups = <
        item
          DefaultGroup = False
          SummaryItems = <
            item
              SummaryField = 'TaxValue'
              SummaryFormat = '(###,##0.00)'
              SummaryType = cstSum
            end>
          Name = 'brwGridSummaryGroup2'
        end>
      SummarySeparator = ', '
      Align = alClient
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ArrowsColor = clBlue
      BandFont.Charset = ANSI_CHARSET
      BandFont.Color = clWindowText
      BandFont.Height = -11
      BandFont.Name = 'Tahoma'
      BandFont.Style = []
      DataSource = dsSaleTaxValue
      Filter.Criteria = {00000000}
      GroupPanelColor = clWhite
      GroupPanelFontColor = clBlack
      GroupNodeColor = clWhite
      HeaderColor = 16768991
      HeaderFont.Charset = ANSI_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Tahoma'
      HeaderFont.Style = []
      LookAndFeel = lfFlat
      OptionsBehavior = [edgoAutoSearch, edgoAutoSort, edgoCaseInsensitive, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSelect, edgoSeekDetail, edgoShowHourGlass, edgoTabThrough, edgoVertThrough]
      OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoSmartReload, edgoUseBookmarks]
      OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoUseBitmap]
      PreviewFieldName = 'Historico'
      PreviewFont.Charset = DEFAULT_CHARSET
      PreviewFont.Color = clNavy
      PreviewFont.Height = -11
      PreviewFont.Name = 'Tahoma'
      PreviewFont.Style = []
      RowFooterColor = 16243912
      ShowGrid = False
      ShowRowFooter = True
      object grdSaleInvoiceCode: TdxDBGridMaskColumn
        Caption = 'Invoice'
        Sorted = csUp
        Visible = False
        Width = 69
        BandIndex = 0
        RowIndex = 0
        FieldName = 'InvoiceCode'
        GroupIndex = 0
        SummaryGroupName = 'brwGridSummaryGroup2'
      end
      object grdSaleModel: TdxDBGridMaskColumn
        Width = 159
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Model'
      end
      object grdSaleInvoiceDate: TdxDBGridDateColumn
        Caption = 'Date'
        Width = 66
        BandIndex = 0
        RowIndex = 0
        FieldName = 'InvoiceDate'
      end
      object grdSaleSubTotal: TdxDBGridCurrencyColumn
        Visible = False
        Width = 111
        BandIndex = 0
        RowIndex = 0
        FieldName = 'SubTotal'
        Nullable = False
      end
      object grdSaleItemDiscount: TdxDBGridCurrencyColumn
        Visible = False
        Width = 111
        BandIndex = 0
        RowIndex = 0
        FieldName = 'ItemDiscount'
        Nullable = False
      end
      object grdSaleAditionalExpenses: TdxDBGridCurrencyColumn
        Visible = False
        Width = 111
        BandIndex = 0
        RowIndex = 0
        FieldName = 'AditionalExpenses'
        Nullable = False
      end
      object grdSaleTaxValue: TdxDBGridCurrencyColumn
        Width = 75
        BandIndex = 0
        RowIndex = 0
        FieldName = 'TaxValue'
        SummaryFooterType = cstSum
        SummaryFooterFormat = '#,##0.00'
        DisplayFormat = '#,#0.00'
        Nullable = False
        SummaryField = 'TaxValue'
      end
      object grdSaleIDPreSale: TdxDBGridMaskColumn
        Visible = False
        Width = 56
        BandIndex = 0
        RowIndex = 0
        FieldName = 'IDPreSale'
      end
      object grdSaleDescription: TdxDBGridMaskColumn
        Visible = False
        Width = 272
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Description'
      end
    end
  end
  object Panel3: TPanel [8]
    Left = 400
    Top = 145
    Width = 388
    Height = 338
    Align = alClient
    Caption = 'Purchase'
    TabOrder = 7
    object Label8: TLabel
      Left = 1
      Top = 1
      Width = 386
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Purchase Tax'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object grdPurchase: TdxDBGrid
      Left = 1
      Top = 17
      Width = 386
      Height = 320
      Bands = <
        item
        end>
      DefaultLayout = True
      HeaderPanelRowCount = 1
      KeyField = 'IDPurchaseItemTax'
      ShowSummaryFooter = True
      SummaryGroups = <
        item
          DefaultGroup = False
          SummaryItems = <
            item
              SummaryField = 'TaxValue'
              SummaryFormat = '(#,##0.00)'
              SummaryType = cstSum
            end>
          Name = 'grdPurchaseSummaryGroup2'
        end>
      SummarySeparator = ', '
      Align = alClient
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ArrowsColor = clBlue
      BandFont.Charset = ANSI_CHARSET
      BandFont.Color = clWindowText
      BandFont.Height = -11
      BandFont.Name = 'Tahoma'
      BandFont.Style = []
      DataSource = dsPurTaxValue
      Filter.Criteria = {00000000}
      GroupPanelColor = clWhite
      GroupPanelFontColor = clBlack
      GroupNodeColor = clWhite
      HeaderColor = 14155755
      HeaderFont.Charset = ANSI_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Tahoma'
      HeaderFont.Style = []
      LookAndFeel = lfFlat
      OptionsBehavior = [edgoAutoSearch, edgoAutoSort, edgoCaseInsensitive, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSelect, edgoSeekDetail, edgoShowHourGlass, edgoTabThrough, edgoVertThrough]
      OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoSmartReload, edgoUseBookmarks]
      OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoUseBitmap]
      PreviewFieldName = 'Historico'
      PreviewFont.Charset = DEFAULT_CHARSET
      PreviewFont.Color = clNavy
      PreviewFont.Height = -11
      PreviewFont.Name = 'Tahoma'
      PreviewFont.Style = []
      RowFooterColor = 16243912
      ShowGrid = False
      ShowRowFooter = True
      object grdPurchaseIDPurchaseItemTax: TdxDBGridMaskColumn
        Visible = False
        Width = 96
        BandIndex = 0
        RowIndex = 0
        FieldName = 'IDPurchaseItemTax'
      end
      object grdPurchaseDocumentNumber: TdxDBGridMaskColumn
        Caption = 'Number'
        Sorted = csUp
        Visible = False
        Width = 92
        BandIndex = 0
        RowIndex = 0
        FieldName = 'DocumentNumber'
        GroupIndex = 1
        SummaryGroupName = 'grdPurchaseSummaryGroup2'
      end
      object grdPurchaseModel: TdxDBGridMaskColumn
        Width = 146
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Model'
      end
      object grdPurchaseDateFinalreceiving: TdxDBGridDateColumn
        Width = 79
        BandIndex = 0
        RowIndex = 0
        FieldName = 'DateFinalreceiving'
      end
      object grdPurchaseDocumentTotal: TdxDBGridCurrencyColumn
        Visible = False
        Width = 118
        BandIndex = 0
        RowIndex = 0
        FieldName = 'DocumentTotal'
        Nullable = False
      end
      object grdPurchaseDescription: TdxDBGridMaskColumn
        Visible = False
        Width = 288
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Description'
      end
      object grdPurchaseTaxValue: TdxDBGridCurrencyColumn
        Width = 88
        BandIndex = 0
        RowIndex = 0
        FieldName = 'TaxValue'
        SummaryFooterType = cstSum
        SummaryFooterField = 'TaxValue'
        SummaryFooterFormat = '#,##0.00'
        DisplayFormat = '0.00;-0.00'
        Nullable = False
        SummaryField = 'TaxValue'
      end
      object grdPurchaseVendor: TdxDBGridColumn
        Sorted = csUp
        Visible = False
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Vendor'
        GroupIndex = 0
        SummaryGroupName = 'grdPurchaseSummaryGroup2'
      end
    end
  end
  inherited siLang: TsiLangRT
    Left = 615
    Top = 10
  end
  object quPurchaseTax: TADODataSet
    Connection = DM.DBADOConnection
    CommandText = 
      'Select'#13#10#9'IDTaxCategory,'#13#10#9'TaxCategory'#13#10'From'#13#10#9'TaxCategory'#13#10'Where' +
      #13#10#9'OperationType = 2'#13#10#9'and'#13#10#9'SaleTaxType IS NULL'#13#10#9'and'#13#10#9'Desativ' +
      'ado = 0'#13#10#9'and'#13#10#9'Hidden = 0'#13#10'ORDER BY'#13#10#9'TaxCategory'
    Parameters = <>
    Left = 520
    Top = 60
    object quPurchaseTaxIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quPurchaseTaxTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
  end
  object quSaleTax: TADODataSet
    Connection = DM.DBADOConnection
    CommandText = 
      'Select'#13#10#9'IDTaxCategory,'#13#10#9'TaxCategory'#13#10'From'#13#10#9'TaxCategory'#13#10'Where' +
      #13#10#9'IsNull(OperationType,1) = 1'#13#10#9'and'#13#10#9'Desativado = 0'#13#10#9'and'#13#10#9'Hi' +
      'dden = 0'#13#10#9'and'#13#10#9'(SaleTaxType = 2'#13#10#9'or'#13#10#9'IDTaxCategoryParent<>0)' +
      #13#10'ORDER BY'#13#10#9'TaxCategory'
    Parameters = <>
    Left = 150
    Top = 60
    object quSaleTaxIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quSaleTaxTaxCategory: TStringField
      FieldName = 'TaxCategory'
      Size = 50
    end
  end
  object quSaleTaxValue: TADODataSet
    Connection = DM.DBADOConnection
    CommandText = 
      'Select'#13#10#9'I.IDPreSale,'#13#10#9'IMV.IDInventoryMov,'#13#10#9'I.InvoiceCode,'#13#10#9'I' +
      '.InvoiceDate,'#13#10#9'I.SubTotal,'#13#10#9'I.ItemDiscount,'#13#10#9'I.AditionalExpen' +
      'ses,'#13#10#9'T.TaxValue,'#13#10#9'M.Model,'#13#10#9'M.Description'#13#10'From'#13#10#9'Invoice I'#13 +
      #10#9'JOIN InventoryMov IMV ON (IMV.DocumentID = I.IDInvoice and IMV' +
      '.InventMovTypeID = 1)'#13#10#9'JOIN Model M ON (M.IDModel = IMV.ModelID' +
      ')'#13#10#9'JOIN InventoryMovTax T ON (T.IDInventoryMov = IMV.IDInventor' +
      'yMov)'#13#10
    Parameters = <>
    Left = 148
    Top = 230
    object quSaleTaxValueInvoiceCode: TStringField
      FieldName = 'InvoiceCode'
    end
    object quSaleTaxValueInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
      DisplayFormat = 'ddddd'
    end
    object quSaleTaxValueSubTotal: TBCDField
      FieldName = 'SubTotal'
      Precision = 19
    end
    object quSaleTaxValueItemDiscount: TBCDField
      FieldName = 'ItemDiscount'
      Precision = 19
    end
    object quSaleTaxValueAditionalExpenses: TBCDField
      FieldName = 'AditionalExpenses'
      Precision = 19
    end
    object quSaleTaxValueTaxValue: TBCDField
      FieldName = 'TaxValue'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quSaleTaxValueIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quSaleTaxValueIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object quSaleTaxValueModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quSaleTaxValueDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
  end
  object dsSaleTaxValue: TDataSource
    DataSet = quSaleTaxValue
    Left = 153
    Top = 290
  end
  object dsPurTaxValue: TDataSource
    DataSet = quPurTaxValue
    Left = 568
    Top = 290
  end
  object quPurTaxValue: TADODataSet
    Connection = DM.DBADOConnection
    CommandText = 
      'Select '#13#10#9'PX.IDPurchaseItemTax,'#13#10#9'P.DateFinalreceiving,'#13#10#9'P.Docu' +
      'mentTotal,'#13#10#9'P.DocumentNumber,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'(PX' +
      '.TaxValue - IsNull(PXR.TaxValue,0)) as TaxValue,'#13#10#9'F.Pessoa as V' +
      'endor'#13#10'From '#13#10#9'Pur_Purchase P'#13#10#9'JOIN Pur_PurchaseItem PUI ON (P.' +
      'IDPurchase = PUI.IDPurchase)'#13#10#9'JOIN Pur_PurchaseItemTax PX ON (P' +
      'X.IDPurchaseItem  = PUI.IDPurchaseItem)'#13#10#9'LEFT JOIN Pur_Purchase' +
      'ItemTaxRet PXR ON (PXR.IDPurchaseItem  = PUI.IDPurchaseItem AND ' +
      'PX.IDVendorTax = PXR.IDVendorTax)'#13#10#9'JOIN VendorTax VT ON (VT.IDV' +
      'endorTax = PX.IDVendorTax)'#13#10#9'JOIN Model M ON (M.IDModel = PUI.ID' +
      'Model)'#13#10#9'JOIN Pessoa F ON (F.IDPessoa = P.IDFornecedor)'#13#10
    Parameters = <>
    Left = 563
    Top = 230
    object quPurTaxValueIDPurchaseItemTax: TIntegerField
      FieldName = 'IDPurchaseItemTax'
    end
    object quPurTaxValueDateFinalreceiving: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'DateFinalreceiving'
      DisplayFormat = 'ddddd'
    end
    object quPurTaxValueDocumentTotal: TBCDField
      FieldName = 'DocumentTotal'
      Precision = 19
    end
    object quPurTaxValueDocumentNumber: TStringField
      FieldName = 'DocumentNumber'
    end
    object quPurTaxValueModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quPurTaxValueDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quPurTaxValueTaxValue: TBCDField
      FieldName = 'TaxValue'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quPurTaxValueVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
end
