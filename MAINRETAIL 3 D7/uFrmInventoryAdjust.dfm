inherited FrmInventoryAdjust: TFrmInventoryAdjust
  Left = 338
  Top = 91
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Inventory Adjust'
  ClientHeight = 489
  ClientWidth = 527
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 276
    Top = 15
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'User :'
  end
  object Label2: TLabel [1]
    Left = 44
    Top = 15
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Store :'
  end
  object Label3: TLabel [2]
    Left = 40
    Top = 80
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Model :'
  end
  object Label4: TLabel [3]
    Left = 330
    Top = 230
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'Date :'
  end
  object Label6: TLabel [4]
    Left = 18
    Top = 112
    Width = 57
    Height = 13
    Alignment = taRightJustify
    Caption = 'Adjust. Qty :'
  end
  object Label7: TLabel [5]
    Left = 41
    Top = 258
    Width = 34
    Height = 13
    Alignment = taRightJustify
    Caption = 'Notes :'
  end
  object Label8: TLabel [6]
    Left = 466
    Top = 149
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
  object Label9: TLabel [7]
    Left = 464
    Top = 228
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
  object Label12: TLabel [8]
    Left = 493
    Top = 75
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
  object Label11: TLabel [9]
    Left = 226
    Top = 228
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
  object Label10: TLabel [10]
    Left = 29
    Top = 49
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = 'Barcode :'
  end
  object Label14: TLabel [11]
    Left = 299
    Top = 113
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = 'Qty on Hand :'
  end
  object Label13: TLabel [12]
    Left = 31
    Top = 230
    Width = 43
    Height = 13
    Alignment = taRightJustify
    Caption = 'Reason :'
  end
  object Label15: TLabel [13]
    Left = 178
    Top = 106
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
  inherited Panel1: TPanel
    Top = 448
    Width = 527
    TabOrder = 13
    inherited EspacamentoInferior: TPanel
      Width = 527
      inherited Panel3: TPanel
        Width = 527
      end
    end
    inherited hhh: TPanel
      Left = 312
      Width = 215
      inherited sbHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 145
        OnClick = btCloseClick
      end
      object btnSave: TButton
        Left = 75
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Save'
        TabOrder = 1
        TabStop = False
        OnClick = btnSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 307
    TabOrder = 14
  end
  inherited EspacamentoDireito: TPanel
    Left = 524
    Height = 307
    TabOrder = 15
  end
  inherited EspacamentoSuperior: TPanel
    Width = 527
    TabOrder = 16
  end
  object scStore: TSuperComboADO [18]
    Left = 80
    Top = 13
    Width = 173
    Height = 21
    TabStop = False
    Color = clSilver
    ReadOnly = True
    TabOrder = 0
    Text = '<-->'
    LookUpSource = DM.dsLookUpStore
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object scUser: TSuperComboADO [19]
    Left = 309
    Top = 13
    Width = 153
    Height = 21
    TabStop = False
    Color = clSilver
    ReadOnly = True
    TabOrder = 1
    Text = '<-->'
    LookUpSource = DM.dsLookUpUser
    DropDownRows = 10
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object btnSearchDesc: TBitBtn [20]
    Left = 466
    Top = 74
    Width = 23
    Height = 22
    TabOrder = 4
    OnClick = btnSearchDescClick
  end
  object dtMov: TDateBox [21]
    Left = 364
    Top = 226
    Width = 98
    Height = 21
    TabOrder = 9
  end
  object edtQty: TEdit [22]
    Left = 80
    Top = 107
    Width = 95
    Height = 21
    TabOrder = 5
    OnKeyPress = edtQtyKeyPress
  end
  object memOBS: TMemo [23]
    Left = 80
    Top = 258
    Width = 377
    Height = 49
    TabOrder = 10
  end
  object rgAdjustType: TRadioGroup [24]
    Left = 80
    Top = 183
    Width = 384
    Height = 36
    Caption = 'Type'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Add'
      'Subtract'
      'Replace')
    TabOrder = 7
    Visible = False
  end
  object btnAdd: TBitBtn [25]
    Left = 461
    Top = 259
    Width = 57
    Height = 25
    Caption = 'Add'
    Default = True
    TabOrder = 11
    OnClick = btnAddClick
  end
  object grdItems: TcxGrid [26]
    Left = 0
    Top = 313
    Width = 527
    Height = 135
    Align = alBottom
    TabOrder = 17
    LookAndFeel.Kind = lfFlat
    object grdItemsDB: TcxGridDBTableView
      DataController.DataSource = dsItems
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubSellingPrice'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubFinalCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubVendorCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubFreightCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubOtherCost'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubRealMarkUpValue'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubSuggRetail'
        end
        item
          Format = '0'
          Kind = skSum
          Position = spFooter
          FieldName = 'PositiveQty'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          FieldName = 'SubSellingPrice'
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
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      object grdItemsDBModel: TcxGridDBColumn
        DataBinding.FieldName = 'Model'
        Width = 70
      end
      object grdItemsDBMovType: TcxGridDBColumn
        DataBinding.FieldName = 'MovType'
        Width = 80
      end
      object grdItemsDBMovDate: TcxGridDBColumn
        DataBinding.FieldName = 'MovDate'
        Width = 74
      end
      object grdItemsDBQty: TcxGridDBColumn
        DataBinding.FieldName = 'Qty'
        Width = 39
      end
      object grdItemsDBReason: TcxGridDBColumn
        DataBinding.FieldName = 'Reason'
        Width = 120
      end
      object grdItemsDBOBS: TcxGridDBColumn
        Caption = 'Notes'
        DataBinding.FieldName = 'OBS'
        Width = 142
      end
    end
    object grdItemsLevel: TcxGridLevel
      GridView = grdItemsDB
    end
  end
  object edtBarCode: TmrBarCodeEdit [27]
    Left = 81
    Top = 46
    Width = 140
    Height = 21
    Color = 8454143
    TabOrder = 2
    OnEnter = edtBarCodeEnter
    OnExit = edtBarCodeExit
    Connection = DM.ADODBConnect
    SQL.Strings = (
      'SELECT'
      '      B.IDModel'
      'FROM'
      '      Barcode B'
      'WHERE'
      '      B.IDBarcode = :IDBarcode')
    SecondSQL.Strings = (
      'SELECT'
      '      M.IDModel'
      'FROM'
      '      Model M'
      'WHERE'
      '      M.Model = :Model')
    KeyField = 'IDBarcode'
    SecondKeyField = 'Model'
    DisplayQty = False
    RunSecondSQL = False
    CheckBarcodeDigit = 0
    MinimalDigits = 0
    AfterSearchBarcode = edtBarCodeAfterSearchBarcode
  end
  object edtQtyOnHand: TEdit [28]
    Left = 370
    Top = 108
    Width = 92
    Height = 21
    TabStop = False
    Color = clSilver
    TabOrder = 19
    OnKeyPress = edtQtyKeyPress
  end
  object scReason: TSuperComboADO [29]
    Left = 80
    Top = 227
    Width = 142
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    LookUpSource = DM.dsLookUpInvReason
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    EditCodePos = taEditCodeRight
    IDLanguage = 0
  end
  object scModel: TSuperComboADO [30]
    Left = 80
    Top = 75
    Width = 382
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = 'scModel'
    CodeLength = 220
    LookUpSource = DM.dsLookUpModel
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    ShowEditCode = True
    EditCodePos = taEditCodeRight
    IDLanguage = 0
    OnSelectItem = scModelSelectItem
  end
  object rgMoveType: TRadioGroup [31]
    Left = 79
    Top = 139
    Width = 384
    Height = 41
    Caption = ' Move Type '
    Columns = 3
    Items.Strings = (
      'Store Use'
      'Stock Loss'
      'Inventory Adjustment')
    TabOrder = 6
    OnClick = rgMoveTypeClick
  end
  object btnDel: TBitBtn [32]
    Left = 461
    Top = 285
    Width = 57
    Height = 25
    Caption = 'Delete'
    TabOrder = 12
    OnClick = btnDelClick
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmInventoryAdjust.sil'
    Left = 4
    Top = 244
  end
  object cdsItems: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 304
    object cdsItemsID: TIntegerField
      FieldName = 'ID'
    end
    object cdsItemsIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object cdsItemsUser: TStringField
      FieldName = 'User'
      Size = 50
    end
    object cdsItemsIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsItemsStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object cdsItemsIDMovType: TIntegerField
      FieldName = 'IDMovType'
    end
    object cdsItemsMovType: TStringField
      FieldName = 'MovType'
    end
    object cdsItemsIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsItemsModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsItemsMovDate: TDateTimeField
      FieldName = 'MovDate'
    end
    object cdsItemsQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsItemsOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
    object cdsItemsQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
    end
    object cdsItemsQtyReplace: TFloatField
      FieldName = 'QtyReplace'
    end
    object cdsItemsIDMovReason: TIntegerField
      FieldName = 'IDMovReason'
    end
    object cdsItemsReason: TStringField
      FieldName = 'Reason'
      Size = 50
    end
  end
  object dsItems: TDataSource
    DataSet = cdsItems
    Left = 104
    Top = 304
  end
  object spAdjustInventory: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_Inventory_Adjust;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDMovType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDModel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDStore'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Qty'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 15
        Value = Null
      end
      item
        Name = '@IDUser'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@Date'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@Notes'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@IDMovReason'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 70
    Top = 364
  end
  object quInventory: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quInventoryAfterOpen
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
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        I.QtyOnPreSale,'
      '        I.QtyOnHand,'
      '        I.QtyOnOrder,'
      '        I.QtyOnRepair,'
      '        I.DataContagem,'
      '        TG.Name as Category'
      'FROM'
      '        Inventory I (NOLOCK) '
      '        JOIN Model M (NOLOCK) ON (M.IDModel = I.ModelID)'
      '        JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)'
      ''
      'WHERE'
      '        IDModel = :IDModel'
      '        AND'
      '        StoreID = :IDStore'
      ' ')
    Left = 148
    Top = 372
    object quInventoryDataContagem: TDateTimeField
      FieldName = 'DataContagem'
      Origin = 'Inventory.DataContagem'
    end
    object quInventoryCategory: TStringField
      FieldName = 'Category'
      Origin = 'TabGroup.Name'
      Size = 30
    end
    object quInventoryQtyOnPreSale: TFloatField
      FieldName = 'QtyOnPreSale'
      DisplayFormat = '0.#####'
    end
    object quInventoryQtyOnHand: TFloatField
      FieldName = 'QtyOnHand'
      DisplayFormat = '0.#####'
    end
    object quInventoryQtyOnOrder: TFloatField
      FieldName = 'QtyOnOrder'
      DisplayFormat = '0.#####'
    end
    object quInventoryQtyOnRepair: TFloatField
      FieldName = 'QtyOnRepair'
      DisplayFormat = '0.#####'
    end
  end
end
