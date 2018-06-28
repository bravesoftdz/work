inherited FrmSaleItemTax: TFrmSaleItemTax
  Left = 0
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Sale Item Tax'
  ClientHeight = 542
  ClientWidth = 792
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 792
    inherited Image1: TImage
      Width = 565
    end
    inherited lblMenu: TLabel
      Left = 576
    end
    inherited EspacamentoSuperior: TPanel
      Width = 792
      Visible = False
      inherited EEE: TPanel
        Width = 792
      end
    end
  end
  inherited Panel1: TPanel
    Top = 501
    Width = 792
    inherited EspacamentoInferior: TPanel
      Width = 792
      inherited Panel3: TPanel
        Width = 792
      end
    end
    inherited hhh: TPanel
      Left = 710
      inherited btClose: TButton
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 106
    Height = 395
    Visible = False
  end
  inherited EspacamentoDireito: TPanel
    Left = 789
    Top = 106
    Height = 395
    Visible = False
  end
  object pnlBasicFilter: TPanel [4]
    Left = 0
    Top = 40
    Width = 792
    Height = 66
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
    object Label3: TLabel
      Left = 395
      Top = 11
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = 'Store :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbFrom: TLabel
      Left = 397
      Top = 38
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = 'From :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbTo: TLabel
      Left = 553
      Top = 38
      Width = 16
      Height = 13
      Alignment = taRightJustify
      Caption = 'To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 22
      Top = 13
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = 'Invoice #'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pblGO: TPanel
      Left = 714
      Top = 0
      Width = 78
      Height = 66
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object pnlAviso: TPanel
        Left = 6
        Top = 17
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
    object cmbStore: TSuperComboADO
      Left = 439
      Top = 7
      Width = 214
      Height = 21
      TabOrder = 1
      Text = '<-->'
      OnChange = edtHoldNumberChange
      LookUpSource = DM.dsLookUpStore
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object Button2: TButton
      Left = 658
      Top = 8
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 2
      OnClick = Button2Click
    end
    object DateInicio: TDateBox
      Left = 439
      Top = 34
      Width = 87
      Height = 21
      TabOrder = 3
      OnChange = edtHoldNumberChange
      InputTime = False
    end
    object DateFim: TDateBox
      Left = 572
      Top = 34
      Width = 82
      Height = 21
      TabOrder = 4
      OnChange = edtHoldNumberChange
      InputTime = False
      Language = Portuguese
    end
    object chkInvCalceled: TCheckBox
      Left = 84
      Top = 39
      Width = 235
      Height = 17
      Caption = 'Display Canceled Invoices'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = edtHoldNumberChange
    end
    object edtHoldNumber: TEdit
      Left = 84
      Top = 9
      Width = 133
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnChange = edtHoldNumberChange
    end
  end
  object pnlProducts: TPanel [5]
    Left = 223
    Top = 115
    Width = 551
    Height = 206
    BevelOuter = bvNone
    TabOrder = 5
    object Shape1: TShape
      Left = 0
      Top = 0
      Width = 551
      Height = 176
      Brush.Color = clGray
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object Shape2: TShape
      Left = 0
      Top = 30
      Width = 551
      Height = 176
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object Label1: TLabel
      Left = 20
      Top = 6
      Width = 51
      Height = 13
      Caption = 'Products'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Panel4: TPanel
      Left = 1
      Top = 25
      Width = 549
      Height = 158
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object grdItem: TcxGrid
        Left = 4
        Top = 6
        Width = 540
        Height = 149
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdItemDB: TcxGridDBTableView
          DataController.DataSource = dsPreSaleItem
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDInventoryMov'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'SubTotal'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'Tax'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'TotalInvoice'
            end>
          DataController.Summary.SummaryGroups = <>
          OnCellClick = grdItemDBCellClick
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
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          Preview.Visible = True
          object grdItemDBSaleCode: TcxGridDBColumn
            Caption = 'Hold #'
            DataBinding.FieldName = 'SaleCode'
            Width = 54
          end
          object grdItemDBInvoiceCode: TcxGridDBColumn
            Caption = 'Invoice #'
            DataBinding.FieldName = 'InvoiceCode'
            Width = 67
          end
          object grdItemDBModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Width = 75
          end
          object grdItemDBDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 223
          end
          object grdItemDBIsDelivered: TcxGridDBColumn
            Caption = 'Delivered'
            DataBinding.FieldName = 'IsDelivered'
            Visible = False
          end
          object grdItemDBQty: TcxGridDBColumn
            DataBinding.FieldName = 'Qty'
            Width = 35
          end
          object grdItemDBTotalItem: TcxGridDBColumn
            DataBinding.FieldName = 'TotalItem'
            Width = 79
          end
        end
        object cxgrdItem: TcxGridLevel
          GridView = grdItemDB
        end
      end
    end
  end
  object pnlInvoices: TPanel [6]
    Left = 3
    Top = 106
    Width = 212
    Height = 395
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 6
    object Shape3: TShape
      Left = 1
      Top = 5
      Width = 210
      Height = 369
      Brush.Color = clGray
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object Shape4: TShape
      Left = 1
      Top = 35
      Width = 210
      Height = 369
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object Label4: TLabel
      Left = 12
      Top = 16
      Width = 49
      Height = 13
      Caption = 'Invoices'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Panel5: TPanel
      Left = 2
      Top = 34
      Width = 208
      Height = 348
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object grdInvoice: TcxGrid
        Left = 5
        Top = 6
        Width = 199
        Height = 338
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdInvoiceDB: TcxGridDBTableView
          DataController.DataSource = dsInvoice
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDPreSale'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '0'
              Kind = skCount
              FieldName = 'SaleCode'
              Column = grdInvoiceDBInvoiceCode
            end>
          DataController.Summary.SummaryGroups = <>
          OnCellClick = grdInvoiceDBCellClick
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
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object grdInvoiceDBName: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Visible = False
            GroupIndex = 0
            SortOrder = soAscending
          end
          object grdInvoiceDBInvoiceCode: TcxGridDBColumn
            Caption = 'Invoice'
            DataBinding.FieldName = 'InvoiceCode'
            SortOrder = soAscending
            Width = 72
          end
          object grdInvoiceDBInvoiceDate: TcxGridDBColumn
            DataBinding.FieldName = 'InvoiceDate'
            Width = 106
          end
        end
        object grdInvoiceLevel: TcxGridLevel
          GridView = grdInvoiceDB
        end
      end
    end
  end
  object Panel6: TPanel [7]
    Left = 221
    Top = 327
    Width = 288
    Height = 185
    BevelOuter = bvNone
    TabOrder = 7
    object Shape5: TShape
      Left = 0
      Top = 0
      Width = 288
      Height = 176
      Brush.Color = clGray
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object Shape6: TShape
      Left = 0
      Top = 30
      Width = 288
      Height = 154
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object Label5: TLabel
      Left = 19
      Top = 6
      Width = 22
      Height = 13
      Caption = 'Tax'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Panel7: TPanel
      Left = 1
      Top = 25
      Width = 286
      Height = 133
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object btSaveTax: TSpeedButton
        Left = 218
        Top = 9
        Width = 64
        Height = 26
        Caption = 'Save'
        Enabled = False
        Flat = True
        Glyph.Data = {
          72010000424D7201000000000000760000002800000014000000150000000100
          040000000000FC00000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888800008800000000000000000800008033300000008880330800008033
          3000000088803308000080333000000088803308000080333000000088803308
          0000803330000000888033080000803330000000888033080000803330000000
          0000330800008033333333333333330800008033333333333333330800008033
          3000000000033308000080330888888888803308000080330888888888803308
          0000803308888888888033080000803308888888888033080000803308888888
          8880330800008033088888888880000800008033088888888880880800008000
          00000000000000080000888888888888888888880000}
        Margin = 4
        Spacing = 10
        OnClick = btSaveTaxClick
      end
      object grdItemTax: TcxGrid
        Left = 6
        Top = 8
        Width = 211
        Height = 116
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdItemTaxDBTableView1: TcxGridDBTableView
          DataController.DataSource = dsTax
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
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
          object grdItemTaxDBTableView1IDInventoryMov: TcxGridDBColumn
            DataBinding.FieldName = 'IDInventoryMov'
            Visible = False
          end
          object grdItemTaxDBTableView1Tax: TcxGridDBColumn
            DataBinding.FieldName = 'Tax'
            PropertiesClassName = 'TcxCalcEditProperties'
            Width = 99
          end
          object grdItemTaxDBTableView1TaxValue: TcxGridDBColumn
            DataBinding.FieldName = 'TaxValue'
            PropertiesClassName = 'TcxCalcEditProperties'
            Width = 106
          end
        end
        object grdItemTaxLevel1: TcxGridLevel
          GridView = grdItemTaxDBTableView1
        end
      end
    end
  end
  object Panel8: TPanel [8]
    Left = 512
    Top = 329
    Width = 269
    Height = 185
    BevelOuter = bvNone
    TabOrder = 8
    object Shape7: TShape
      Left = 0
      Top = 0
      Width = 261
      Height = 176
      Brush.Color = clGray
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object Shape8: TShape
      Left = 0
      Top = 30
      Width = 261
      Height = 155
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object lbInvOBD: TLabel
      Left = 19
      Top = 6
      Width = 69
      Height = 13
      Caption = 'Observation'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Panel9: TPanel
      Left = 1
      Top = 24
      Width = 259
      Height = 145
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object btnAddObs: TSpeedButton
        Left = 183
        Top = 7
        Width = 75
        Height = 26
        Caption = 'Save'
        Flat = True
        Glyph.Data = {
          72010000424D7201000000000000760000002800000014000000150000000100
          040000000000FC00000000000000000000001000000010000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888800008800000000000000000800008033300000008880330800008033
          3000000088803308000080333000000088803308000080333000000088803308
          0000803330000000888033080000803330000000888033080000803330000000
          0000330800008033333333333333330800008033333333333333330800008033
          3000000000033308000080330888888888803308000080330888888888803308
          0000803308888888888033080000803308888888888033080000803308888888
          8880330800008033088888888880000800008033088888888880880800008000
          00000000000000080000888888888888888888880000}
        Margin = 4
        Spacing = 10
        OnClick = btnAddObsClick
      end
      object btDeleteObs: TSpeedButton
        Left = 183
        Top = 31
        Width = 75
        Height = 26
        Caption = 'Delete'
        Flat = True
        Margin = 4
        Spacing = 10
        OnClick = btDeleteObsClick
      end
      object gridObs: TcxGrid
        Left = 0
        Top = 64
        Width = 259
        Height = 81
        Align = alBottom
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object gridObsDB: TcxGridDBTableView
          DataController.DataSource = dsInvObs
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Preview.Column = gridObsDBObs
          Preview.Visible = True
          object gridObsObsDate: TcxGridDBColumn
            DataBinding.FieldName = 'ObsDate'
          end
          object gridObsDBObs: TcxGridDBColumn
            DataBinding.FieldName = 'Obs'
          end
        end
        object gridObsLevel: TcxGridLevel
          GridView = gridObsDB
        end
      end
      object memObs: TMemo
        Left = 5
        Top = 5
        Width = 180
        Height = 56
        MaxLength = 255
        TabOrder = 1
      end
    end
  end
  object dsInvoice: TDataSource [9]
    DataSet = quInvoice
    Left = 82
    Top = 220
  end
  object quInvoice: TPowerADOQuery [10]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 500
    AfterOpen = quInvoiceAfterOpen
    CommandText = 
      'SELECT'#13#10#9'I.IDPreSale,'#13#10#9'I.IDInvoice,'#13#10#9'I.InvoiceDate,'#13#10#9'I.PreSal' +
      'eDate,'#13#10#9'I.SaleCode,'#13#10#9'I.InvoiceCode,'#13#10#9'S.IDStore,'#13#10#9'S.Name'#13#10'FRO' +
      'M'#13#10#9'Invoice I (NOLOCK) '#13#10#9'LEFT OUTER JOIN Store S (NOLOCK) ON (I' +
      '.IDStore = S.IDStore)'#13#10'ORDER BY'#13#10#9'I.IDStore,'#13#10#9'I.PreSaleDate'
    CommandTimeout = 180
    Parameters = <>
    Left = 85
    Top = 169
    object quInvoiceIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quInvoiceIDInvoice: TIntegerField
      FieldName = 'IDInvoice'
    end
    object quInvoiceInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
      DisplayFormat = 'ddddd'
    end
    object quInvoicePreSaleDate: TDateTimeField
      FieldName = 'PreSaleDate'
      DisplayFormat = 'ddddd'
    end
    object quInvoiceSaleCode: TStringField
      FieldName = 'SaleCode'
    end
    object quInvoiceInvoiceCode: TStringField
      FieldName = 'InvoiceCode'
    end
    object quInvoiceIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object quInvoiceName: TStringField
      FieldName = 'Name'
      Size = 30
    end
  end
  object TimeAviso: TTimer [11]
    Enabled = False
    Interval = 300
    OnTimer = TimeAvisoTimer
    Left = 691
    Top = 93
  end
  object quPreSaleItem: TADOStoredProc [12]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quPreSaleItemAfterOpen
    OnCalcFields = quPreSaleItemCalcFields
    ProcedureName = 'sp_PreSale_quPreSaleItemSplited;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@DocumentID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IsPreSale'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end>
    Left = 351
    Top = 267
    object quPreSaleItemModelID: TIntegerField
      FieldName = 'ModelID'
    end
    object quPreSaleItemModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quPreSaleItemDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quPreSaleItemSalePrice: TFloatField
      FieldName = 'SalePrice'
      DisplayFormat = '0.00'
    end
    object quPreSaleItemDiscount: TFloatField
      FieldName = 'Discount'
      DisplayFormat = '0.00'
    end
    object quPreSaleItemIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object quPreSaleItemTotalItem: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalItem'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object quPreSaleItemSalesPerson: TStringField
      FieldName = 'SalesPerson'
      Size = 50
    end
    object quPreSaleItemIDComission: TIntegerField
      FieldName = 'IDComission'
    end
    object quPreSaleItemCostPrice: TFloatField
      FieldName = 'CostPrice'
    end
    object quPreSaleItemIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quPreSaleItemExchangeInvoice: TIntegerField
      FieldName = 'ExchangeInvoice'
    end
    object quPreSaleItemTax: TBCDField
      FieldName = 'Tax'
      Precision = 19
    end
    object quPreSaleItemUnitSalePrice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'UnitSalePrice'
      Calculated = True
    end
    object quPreSaleItemTaxValue: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TaxValue'
      Calculated = True
    end
    object quPreSaleItemCodSize: TStringField
      FieldName = 'CodSize'
      Size = 10
    end
    object quPreSaleItemSizeName: TStringField
      FieldName = 'SizeName'
    end
    object quPreSaleItemCodColor: TStringField
      FieldName = 'CodColor'
      Size = 10
    end
    object quPreSaleItemColor: TStringField
      FieldName = 'Color'
    end
    object quPreSaleItemSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object quPreSaleItemIsDelivered: TBooleanField
      FieldName = 'IsDelivered'
    end
    object quPreSaleItemSerialNumber: TBooleanField
      FieldName = 'SerialNumber'
    end
    object quPreSaleItemSaleCode: TStringField
      DisplayWidth = 20
      FieldName = 'SaleCode'
    end
    object quPreSaleItemInvoiceCode: TStringField
      DisplayWidth = 20
      FieldName = 'InvoiceCode'
    end
    object quPreSaleItemQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#####'
    end
  end
  object dsPreSaleItem: TDataSource [13]
    DataSet = quPreSaleItem
    Left = 272
    Top = 265
  end
  object dsTax: TDataSource [14]
    DataSet = quTax
    Left = 274
    Top = 397
  end
  object quTax: TADODataSet [15]
    Connection = DM.ADODBConnect
    AfterEdit = quTaxAfterEdit
    AfterPost = quTaxAfterPost
    CommandText = 
      'SELECT '#13#10#9'IT.IDInventoryMov,'#13#10#9'IT.IDTaxCategory,'#13#10#9'IT.Tax,'#13#10#9'IT.' +
      'TaxValue'#13#10'FROM '#13#10#9'InventoryMovTax IT (NOLOCK) '#13#10'WHERE'#13#10#9'IDInvent' +
      'oryMov = :IDInventoryMov'
    Parameters = <
      item
        Name = 'IDInventoryMov'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 329
    Top = 397
    object quTaxIDInventoryMov: TIntegerField
      FieldName = 'IDInventoryMov'
    end
    object quTaxIDTaxCategory: TIntegerField
      FieldName = 'IDTaxCategory'
    end
    object quTaxTax: TBCDField
      FieldName = 'Tax'
      OnValidate = quTaxTaxValidate
      DisplayFormat = '0.0000'
      Precision = 19
    end
    object quTaxTaxValue: TBCDField
      FieldName = 'TaxValue'
      OnValidate = quTaxTaxValueValidate
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmSaleItemTax.sil'
  end
  object dsInvObs: TDataSource
    DataSet = quInvOBS
    Left = 612
    Top = 415
  end
  object quInvOBS: TPowerADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    MaxRecords = 500
    CommandText = 
      'SELECT'#13#10#9'IDInvoiceOBS,'#13#10#9'IDPreSale,'#13#10#9'ObsDate,'#13#10#9'Obs'#13#10'FROM '#13#10#9'In' +
      'voiceOBS (NOLOCK) '#13#10'WHERE'#13#10#9'IDPreSale = :IDPreSale'#13#10
    CommandTimeout = 180
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 615
    Top = 364
    object quInvOBSIDInvoiceOBS: TIntegerField
      FieldName = 'IDInvoiceOBS'
    end
    object quInvOBSIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object quInvOBSObsDate: TDateTimeField
      FieldName = 'ObsDate'
      DisplayFormat = 'ddddd'
    end
    object quInvOBSObs: TStringField
      FieldName = 'Obs'
      Size = 255
    end
  end
end
