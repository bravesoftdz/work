inherited FrmServiceOrderFch: TFrmServiceOrderFch
  Left = 191
  Top = 67
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Service Order Detail'
  ClientHeight = 549
  ClientWidth = 577
  Font.Charset = ANSI_CHARSET
  Font.Name = 'Tahoma'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 66
    Top = 19
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'User :'
  end
  object lbProduct: TLabel [1]
    Left = 51
    Top = 47
    Width = 44
    Height = 13
    Alignment = taRightJustify
    Caption = 'Product :'
  end
  object lbSerial: TLabel [2]
    Left = 62
    Top = 76
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = 'Serial :'
  end
  object Label4: TLabel [3]
    Left = 38
    Top = 129
    Width = 57
    Height = 13
    Alignment = taRightJustify
    Caption = 'Start Date :'
  end
  object Label8: TLabel [4]
    Left = 60
    Top = 182
    Width = 35
    Height = 13
    Alignment = taRightJustify
    Caption = 'Notes :'
  end
  object Label37: TLabel [5]
    Left = 493
    Top = 43
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
  object Label5: TLabel [6]
    Left = 241
    Top = 73
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
  object Label6: TLabel [7]
    Left = 44
    Top = 157
    Width = 51
    Height = 13
    Alignment = taRightJustify
    Caption = 'End Date :'
  end
  object Label7: TLabel [8]
    Left = 241
    Top = 16
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
  object lbUsedTime: TLabel [9]
    Left = 39
    Top = 102
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = 'Used Time :'
  end
  object Panel1: TPanel [10]
    Left = 0
    Top = 512
    Width = 577
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      577
      37)
    object EspacamentoInferior: TPanel
      Left = 0
      Top = 0
      Width = 577
      Height = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 577
        Height = 2
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object hhh: TPanel
      Left = 495
      Top = 2
      Width = 82
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object btClose: TButton
        Left = 10
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Close'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 2
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnClick = btCloseClick
      end
    end
    object btnSave: TButton
      Left = 434
      Top = 5
      Width = 66
      Height = 31
      Anchors = [akTop, akRight]
      Caption = '&Save'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
      TabStop = False
      OnClick = btnSaveClick
    end
  end
  object scUser: TDBSuperComboADO [11]
    Left = 100
    Top = 15
    Width = 136
    Height = 21
    TabStop = False
    Color = clWhite
    TabOrder = 0
    Text = 'scUser'
    CodeLength = 80
    LookUpSource = DM.dsLookUpUser
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
    DataField = 'IDUser'
    DataSource = dsSOItemDetail
  end
  object dateStart: TcxDBDateEdit [12]
    Left = 100
    Top = 126
    Width = 139
    Height = 21
    DataBinding.DataSource = dsSOItemDetail
    DataBinding.DataField = 'IniDate'
    Properties.ShowTime = False
    Style.BorderStyle = ebs3D
    TabOrder = 5
  end
  object edtSerialNumber: TDBEdit [13]
    Left = 100
    Top = 72
    Width = 137
    Height = 21
    DataField = 'SerialNumber'
    DataSource = dsSOItemDetail
    TabOrder = 3
  end
  object memNotes: TDBMemo [14]
    Left = 100
    Top = 182
    Width = 266
    Height = 50
    Color = 15269887
    DataField = 'OBS'
    DataSource = dsSOItemDetail
    TabOrder = 7
  end
  object scStatus: TDBSuperComboADO [15]
    Left = 100
    Top = 42
    Width = 391
    Height = 21
    Color = clWhite
    TabOrder = 1
    Text = 'scStatus'
    CodeLength = 250
    LookUpSource = DMServiceOrder.dsSOCutomerProduct
    ShowEditCode = True
    EditCodePos = taEditCodeRight
    IDLanguage = 0
    DataField = 'IDSOCustomerProduct'
    DataSource = dsSOItemDetail
  end
  object cxDBDateEdit1: TcxDBDateEdit [16]
    Left = 100
    Top = 154
    Width = 139
    Height = 21
    DataBinding.DataSource = dsSOItemDetail
    DataBinding.DataField = 'EndDate'
    Properties.ShowTime = False
    Style.BorderStyle = ebs3D
    TabOrder = 6
  end
  object PageControl1: TPageControl [17]
    Left = 4
    Top = 236
    Width = 568
    Height = 273
    ActivePage = tsModel
    TabOrder = 8
    object tsDefects: TTabSheet
      Caption = 'Defects'
      object btAddCDefect: TSpeedButton
        Left = 407
        Top = 1
        Width = 74
        Height = 24
        Caption = 'Add'
        Flat = True
        Margin = 2
        OnClick = btAddCDefectClick
      end
      object btnDelCdefect: TSpeedButton
        Left = 407
        Top = 27
        Width = 74
        Height = 24
        Caption = 'Remove'
        Flat = True
        Margin = 2
        OnClick = btnDelCdefectClick
      end
      object scCDefect: TSuperComboADO
        Left = 126
        Top = 3
        Width = 277
        Height = 21
        TabOrder = 0
        LookUpSource = DM.dsLookUpDefectType
        IDLanguage = 0
      end
      object grdCDefects: TcxGrid
        Left = 2
        Top = 25
        Width = 402
        Height = 219
        BevelOuter = bvNone
        BevelKind = bkTile
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        object grdCDefectsDB: TcxGridDBTableView
          DataController.DataSource = dsCustDefect
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDSOItemDefect'
          DataController.Summary.DefaultGroupSummaryItems = <>
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
          OptionsView.Header = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.MaxLineCount = 2
          Preview.Visible = True
          Styles.Group = cxStyleGroup
          Styles.GroupByBox = cxStyleGroup
          object grdCDefectsDBDefectType: TcxGridDBColumn
            DataBinding.FieldName = 'DefectType'
          end
          object grdCDefectsDBTypeStr: TcxGridDBColumn
            Caption = 'Defect'
            DataBinding.FieldName = 'TypeStr'
            Visible = False
            GroupIndex = 0
            SortOrder = soAscending
          end
        end
        object grdCDefectsLevel: TcxGridLevel
          GridView = grdCDefectsDB
        end
      end
      object cbxDefectType: TComboBox
        Left = 3
        Top = 3
        Width = 121
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'Customer defect'
        Items.Strings = (
          'Customer defect'
          'Product defect')
      end
    end
    object tsModel: TTabSheet
      Caption = 'Products/Services'
      ImageIndex = 2
      object btnRemoveItem: TSpeedButton
        Left = 485
        Top = 27
        Width = 74
        Height = 24
        Caption = 'Remove'
        Flat = True
        Margin = 2
        OnClick = btnRemoveItemClick
      end
      object btnAddItem: TSpeedButton
        Left = 485
        Top = 1
        Width = 74
        Height = 24
        Caption = 'Add'
        Flat = True
        Margin = 2
        OnClick = btnAddItemClick
      end
      object grdSaleItem: TcxGrid
        Left = 0
        Top = 0
        Width = 482
        Height = 245
        BevelOuter = bvNone
        BevelKind = bkTile
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdSaleItemView: TcxGridDBTableView
          DataController.DataSource = dsItemSale
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDSOItemProduct'
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'Total'
              Column = grdSaleItemViewTotal
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              FieldName = 'Total'
              Column = grdSaleItemViewTotal
            end>
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
          Preview.MaxLineCount = 2
          Preview.Visible = True
          Styles.Footer = cxStyleGroup
          Styles.Group = cxStyleGroup
          Styles.GroupByBox = cxStyleGroup
          object grdSaleItemViewItemType: TcxGridDBColumn
            DataBinding.FieldName = 'ItemType'
            Visible = False
            GroupIndex = 0
            SortOrder = soAscending
          end
          object grdSaleItemViewMovDate: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'MovDate'
            Width = 28
          end
          object grdSaleItemViewModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Width = 49
          end
          object grdSaleItemViewDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 158
          end
          object grdSaleItemViewQty: TcxGridDBColumn
            DataBinding.FieldName = 'Qty'
            Width = 27
          end
          object grdSaleItemViewSalePrice: TcxGridDBColumn
            Caption = 'Sale'
            DataBinding.FieldName = 'SalePrice'
            Width = 43
          end
          object grdSaleItemViewDiscount: TcxGridDBColumn
            DataBinding.FieldName = 'Discount'
            Width = 51
          end
          object grdSaleItemViewSubTotal: TcxGridDBColumn
            DataBinding.FieldName = 'SubTotal'
            Width = 51
          end
          object grdSaleItemViewTotal: TcxGridDBColumn
            DataBinding.FieldName = 'Total'
            Width = 54
          end
        end
        object grdSaleItemLevel: TcxGridLevel
          GridView = grdSaleItemView
        end
      end
    end
  end
  object edtUsedTime: TDBEdit [18]
    Left = 100
    Top = 98
    Width = 137
    Height = 21
    DataField = 'UsedTime'
    DataSource = dsSOItemDetail
    TabOrder = 4
  end
  object quSOItemDetail: TADODataSet [19]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT '#13#10#9'SI.IDSOItem,'#13#10#9'SI.IDSOCustomerProduct,'#13#10#9'SI.IDUser,'#13#10#9 +
      'SI.IDServiceOrder,'#13#10#9'SI.SerialNumber,'#13#10#9'SI.IniDate,'#13#10#9'SI.EndDate' +
      ','#13#10#9'SI.OBS,'#13#10#9'SI.UsedTime'#13#10'FROM'#13#10#9'Ser_SOItem SI'#13#10'WHERE'#13#10#9'SI.IDSO' +
      'Item = :IDSOItem'#13#10#13#10#13#10
    Parameters = <
      item
        Name = 'IDSOItem'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 458
    Top = 108
  end
  object dspSOItemDetail: TDataSetProvider [20]
    DataSet = quSOItemDetail
    Left = 460
    Top = 120
  end
  object cdsSOItemDetail: TClientDataSet [21]
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Precision = 10
        Name = 'IDSOItem'
        ParamType = ptInput
        Size = 4
      end>
    ProviderName = 'dspSOItemDetail'
    AfterOpen = cdsSOItemDetailAfterOpen
    Left = 460
    Top = 135
    object cdsSOItemDetailIDSOItem: TIntegerField
      FieldName = 'IDSOItem'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cdsSOItemDetailIDSOCustomerProduct: TIntegerField
      FieldName = 'IDSOCustomerProduct'
      ProviderFlags = [pfInUpdate]
    end
    object cdsSOItemDetailIDUser: TIntegerField
      FieldName = 'IDUser'
      ProviderFlags = [pfInUpdate]
    end
    object cdsSOItemDetailIDServiceOrder: TIntegerField
      FieldName = 'IDServiceOrder'
      ProviderFlags = [pfInUpdate]
    end
    object cdsSOItemDetailSerialNumber: TStringField
      FieldName = 'SerialNumber'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object cdsSOItemDetailIniDate: TDateTimeField
      FieldName = 'IniDate'
      ProviderFlags = [pfInUpdate]
    end
    object cdsSOItemDetailEndDate: TDateTimeField
      FieldName = 'EndDate'
      ProviderFlags = [pfInUpdate]
    end
    object cdsSOItemDetailOBS: TStringField
      FieldName = 'OBS'
      ProviderFlags = [pfInUpdate]
      Size = 100
    end
    object cdsSOItemDetailUsedTime: TStringField
      FieldName = 'UsedTime'
    end
  end
  object dsSOItemDetail: TDataSource [22]
    DataSet = cdsSOItemDetail
    Left = 460
    Top = 150
  end
  object quCustDefect: TADODataSet [23]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quCustDefectCalcFields
    CommandText = 
      'SELECT'#13#10#9'I.Type,'#13#10#9'I.IDSOItemDefect,'#13#10#9'DT.DefectType'#13#10'FROM'#13#10#9'Ser' +
      '_SOItemDefect I (NOLOCK)'#13#10#9'JOIN Inv_DefectType DT (NOLOCK) ON (D' +
      'T.IDDefectType = I.IDDefectType)'#13#10'WHERE'#13#10#9'I.IDSOItem = :IDSOItem' +
      #13#10
    Parameters = <
      item
        Name = 'IDSOItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 61
    Top = 310
    object quCustDefectIDSOItemDefect: TIntegerField
      FieldName = 'IDSOItemDefect'
    end
    object quCustDefectDefectType: TStringField
      FieldName = 'DefectType'
      Size = 30
    end
    object quCustDefectType: TIntegerField
      FieldName = 'Type'
    end
    object quCustDefectTypeStr: TStringField
      FieldKind = fkCalculated
      FieldName = 'TypeStr'
      Size = 15
      Calculated = True
    end
  end
  object dsCustDefect: TDataSource [24]
    DataSet = quCustDefect
    Left = 61
    Top = 355
  end
  object strepSaleItem: TcxStyleRepository [25]
    Left = 285
    Top = 128
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyleContent: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16247513
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyleContentEven: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16247513
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 14811135
      TextColor = clBlack
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14811135
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clNavy
    end
    object cxStyleGroup: TcxStyle
      AssignedValues = [svColor]
      Color = 14872561
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 4707838
      TextColor = clBlack
    end
    object cxStyleHeader: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 13793052
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16046805
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clWhite
    end
    object cxStyle10: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle11: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 4707838
      TextColor = clBlack
    end
    object cxStyle12: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle13: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14811135
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clNavy
    end
    object cxStyleSelection: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 12937777
      TextColor = clWhite
    end
    object cxStyleContent2: TcxStyle
      AssignedValues = [svColor]
      Color = 14737632
    end
    object cxStyleSelection2: TcxStyle
      AssignedValues = [svColor]
      Color = clGray
    end
    object cxStyleHeader2: TcxStyle
      AssignedValues = [svColor]
      Color = 14548991
    end
    object GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet
      Caption = 'DevExpress'
      Styles.Background = cxStyle1
      Styles.Content = cxStyleContent
      Styles.ContentEven = cxStyleContentEven
      Styles.ContentOdd = cxStyle4
      Styles.Inactive = cxStyle10
      Styles.IncSearch = cxStyle11
      Styles.Selection = cxStyleSelection
      Styles.FilterBox = cxStyle5
      Styles.Footer = cxStyle6
      Styles.Group = cxStyleGroup
      Styles.GroupByBox = cxStyle8
      Styles.Header = cxStyleHeader
      Styles.Indicator = cxStyle12
      Styles.Preview = cxStyle13
    end
  end
  object quItemSale: TADODataSet [26]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quItemSaleCalcFields
    CommandText = 
      'SELECT'#13#10#9'SIP.IDSOItemProduct,'#13#10#9'SIP.SalePrice,'#13#10#9'SIP.Qty,'#13#10#9'IsNu' +
      'll(SIP.Discount, 0) as Discount,'#13#10#9'(SIP.Qty * SIP.SalePrice) as ' +
      'SubTotal,'#13#10#9'((SIP.Qty * SIP.SalePrice) - IsNull(SIP.Discount,0))' +
      ' as Total,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'SIP.MovDate,'#13#10#9'M.ModelT' +
      'ype'#13#10'FROM'#13#10#9'Ser_SOItemProduct SIP (NOLOCK)'#13#10#9'JOIN Model M (NOLOC' +
      'K) ON (SIP.IDModel = M.IDModel)'#13#10'WHERE'#13#10#9'SIP.IDSOItem = :IDSOIte' +
      'm'#13#10
    Parameters = <
      item
        Name = 'IDSOItem'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 309
    Top = 310
    object quItemSaleIDSOItemProduct: TIntegerField
      FieldName = 'IDSOItemProduct'
    end
    object quItemSaleSalePrice: TBCDField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quItemSaleQty: TBCDField
      FieldName = 'Qty'
      DisplayFormat = '0'
      Precision = 32
    end
    object quItemSaleModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quItemSaleDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quItemSaleMovDate: TDateTimeField
      FieldName = 'MovDate'
      DisplayFormat = 'ddddd'
    end
    object quItemSaleItemType: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'ItemType'
      Calculated = True
    end
    object quItemSaleModelType: TStringField
      FieldName = 'ModelType'
      FixedChar = True
      Size = 1
    end
    object quItemSaleSubTotal: TBCDField
      FieldName = 'SubTotal'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 32
      Size = 6
    end
    object quItemSaleDiscount: TBCDField
      FieldName = 'Discount'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object quItemSaleTotal: TBCDField
      FieldName = 'Total'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 38
      Size = 6
    end
  end
  object dsItemSale: TDataSource [27]
    DataSet = quItemSale
    Left = 309
    Top = 355
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmServiceOrderFch.sil'
  end
end
