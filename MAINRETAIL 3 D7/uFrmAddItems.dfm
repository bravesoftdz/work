inherited FrmAddItems: TFrmAddItems
  Left = 128
  Top = 9
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'FrmAddItens'
  ClientHeight = 540
  ClientWidth = 790
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 790
    TabOrder = 5
    DesignSize = (
      790
      40)
    inherited Image1: TImage
      Width = 563
    end
    inherited EspacamentoSuperior: TPanel
      Width = 790
      inherited EEE: TPanel
        Width = 790
      end
    end
  end
  inherited Panel1: TPanel
    Top = 499
    Width = 790
    TabOrder = 2
    inherited EspacamentoInferior: TPanel
      Width = 790
      inherited Panel3: TPanel
        Width = 790
      end
    end
    inherited hhh: TPanel
      Left = 577
      Width = 213
      inherited btClose: TButton
        Left = 144
        Top = 4
        OnClick = btCloseClick
      end
      object btSave: TButton
        Left = 76
        Top = 4
        Width = 66
        Height = 31
        Caption = '&Save'
        TabOrder = 1
        TabStop = False
        OnClick = btSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 127
    Height = 269
    TabOrder = 3
  end
  inherited EspacamentoDireito: TPanel
    Left = 787
    Top = 127
    Height = 269
    TabOrder = 4
  end
  object pnlFilter: TPanel [4]
    Left = 0
    Top = 40
    Width = 790
    Height = 87
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblCategory: TLabel
      Left = 24
      Top = 8
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Category :'
    end
    object lblGroup: TLabel
      Left = 1
      Top = 36
      Width = 74
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sub-Category :'
    end
    object lblSubGroup: TLabel
      Left = 384
      Top = 36
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = 'Group :'
    end
    object scCategory: TSuperComboADO
      Left = 80
      Top = 4
      Width = 229
      Height = 21
      TabOrder = 0
      Text = '<-->'
      LookUpSource = DM.dsLookUpGroup
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnCategClear: TButton
      Left = 316
      Top = 4
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 1
      TabStop = False
      OnClick = btnCategClearClick
    end
    object scGroup: TSuperComboADO
      Left = 80
      Top = 32
      Width = 229
      Height = 21
      TabOrder = 2
      Text = '<-->'
      LookUpSource = DM.dsLookUpModelGroup
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnGroupClear: TButton
      Left = 316
      Top = 32
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 3
      TabStop = False
      OnClick = btnGroupClearClick
    end
    object scSubGroup: TSuperComboADO
      Left = 424
      Top = 32
      Width = 197
      Height = 21
      TabOrder = 4
      Text = '<-->'
      LookUpSource = DM.dsLookUpModelSubGroup
      DropDownRows = 10
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btnSubGroupClear: TButton
      Left = 628
      Top = 32
      Width = 34
      Height = 20
      Caption = 'All'
      TabOrder = 5
      TabStop = False
      OnClick = btnSubGroupClearClick
    end
    object cbxMethod: TComboBox
      Left = 80
      Top = 60
      Width = 100
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 6
      Items.Strings = (
        'Start with'
        'End with'
        'Contains')
    end
    object cbxType: TComboBox
      Left = 184
      Top = 60
      Width = 125
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 7
      Items.Strings = (
        'Barcode'
        'Model'
        'Description')
    end
    object edBarcode: TEdit
      Left = 312
      Top = 60
      Width = 309
      Height = 21
      TabOrder = 8
    end
    object btnSearch: TBitBtn
      Left = 688
      Top = 48
      Width = 91
      Height = 27
      Caption = '&Search'
      TabOrder = 9
      OnClick = btnSearchClick
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
  end
  object pnlClient: TPanel [5]
    Left = 3
    Top = 127
    Width = 784
    Height = 269
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter: TSplitter
      Left = 0
      Top = 159
      Width = 784
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object pnlModelAdd: TPanel
      Left = 0
      Top = 162
      Width = 784
      Height = 107
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object lblModelAddTitle: TLabel
        Left = 0
        Top = 0
        Width = 784
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = 'Products to add'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object pnlBtnModelAdd: TPanel
        Left = 679
        Top = 14
        Width = 105
        Height = 93
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object btnRemoveAll: TSpeedButton
          Tag = 4
          Left = 0
          Top = 26
          Width = 105
          Height = 25
          Caption = 'R&emove all'
          Enabled = False
          Flat = True
          Margin = 7
          Spacing = 5
          OnClick = btnRemoveAllClick
        end
        object btnRemove: TSpeedButton
          Tag = 4
          Left = 0
          Top = 1
          Width = 105
          Height = 25
          Caption = '&Remove'
          Enabled = False
          Flat = True
          Margin = 7
          Spacing = 5
          OnClick = btnRemoveClick
        end
      end
      object grdModelAdd: TcxGrid
        Left = 0
        Top = 14
        Width = 679
        Height = 93
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdModelAddTableView: TcxGridDBTableView
          DataController.DataSource = dsModelAdd
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDModel'
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
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object grdModelAddTableViewIDModel: TcxGridDBColumn
            DataBinding.FieldName = 'IDModel'
            Visible = False
            Options.Editing = False
          end
          object grdModelAddTableViewModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Options.Editing = False
          end
          object grdModelAddTableViewDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Options.Editing = False
          end
          object grdModelAddTableViewManufacturer: TcxGridDBColumn
            DataBinding.FieldName = 'Manufacturer'
          end
          object grdModelAddTableViewQty: TcxGridDBColumn
            DataBinding.FieldName = 'Qty'
            Options.Editing = False
          end
          object grdModelAddTableViewCostPrice: TcxGridDBColumn
            DataBinding.FieldName = 'CostPrice'
          end
          object grdModelAddTableViewSalePrice: TcxGridDBColumn
            DataBinding.FieldName = 'SalePrice'
          end
        end
        object grdModelAddLevel: TcxGridLevel
          GridView = grdModelAddTableView
        end
      end
    end
    object pnlModelResult: TPanel
      Left = 0
      Top = 0
      Width = 784
      Height = 159
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object lblModelResultTitle: TLabel
        Left = 0
        Top = 0
        Width = 784
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = 'Products'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object grdModelResult: TcxGrid
        Left = 0
        Top = 14
        Width = 679
        Height = 145
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdModelResultTableView: TcxGridDBTableView
          OnDblClick = grdModelResultTableViewDblClick
          DataController.DataSource = dsModelResult
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDModel'
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
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          OnCustomization = grdModelResultTableViewCustomization
          object grdModelResultTableViewIDBarcode: TcxGridDBColumn
            Caption = 'Barcode'
            DataBinding.FieldName = 'IDBarcode'
            Options.Editing = False
          end
          object grdModelResultTableViewIDModel: TcxGridDBColumn
            DataBinding.FieldName = 'IDModel'
            Visible = False
            Options.Editing = False
          end
          object grdModelResultTableViewModel: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Options.Editing = False
          end
          object grdModelResultTableViewDescription: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Options.Editing = False
          end
          object grdModelResultTableViewManufacturer: TcxGridDBColumn
            DataBinding.FieldName = 'Manufacturer'
          end
          object grdModelResultTableViewSellingPrice: TcxGridDBColumn
            Caption = 'Selling Price'
            DataBinding.FieldName = 'SellingPrice'
            Options.Editing = False
          end
          object grdModelResultTableViewVendorCost: TcxGridDBColumn
            Caption = 'Vendor Cost'
            DataBinding.FieldName = 'VendorCost'
            Options.Editing = False
          end
          object grdModelResultTableViewIDGroup: TcxGridDBColumn
            DataBinding.FieldName = 'IDGroup'
            Visible = False
            Options.Editing = False
          end
          object grdModelResultTableViewName: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Visible = False
            Options.Editing = False
          end
          object grdModelResultTableViewIDModelGroup: TcxGridDBColumn
            DataBinding.FieldName = 'IDModelGroup'
            Visible = False
            Options.Editing = False
          end
          object grdModelResultTableViewModelGroup: TcxGridDBColumn
            DataBinding.FieldName = 'ModelGroup'
            Visible = False
            Options.Editing = False
          end
          object grdModelResultTableViewIDModelSubGroup: TcxGridDBColumn
            DataBinding.FieldName = 'IDModelSubGroup'
            Visible = False
            Options.Editing = False
          end
          object grdModelResultTableViewModelSubGroup: TcxGridDBColumn
            DataBinding.FieldName = 'ModelSubGroup'
            Visible = False
            Options.Editing = False
          end
          object grdModelResultTableViewQty: TcxGridDBColumn
            DataBinding.FieldName = 'Qty'
          end
        end
        object grdModelResultLevel: TcxGridLevel
          GridView = grdModelResultTableView
        end
      end
      object pnlBtnModelResult: TPanel
        Left = 679
        Top = 14
        Width = 105
        Height = 145
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object btnAdd: TSpeedButton
          Tag = 4
          Left = 0
          Top = 1
          Width = 105
          Height = 25
          Caption = '&Add'
          Enabled = False
          Flat = True
          Margin = 7
          Spacing = 5
          OnClick = btnAddClick
        end
        object btnAddAll: TSpeedButton
          Tag = 4
          Left = 0
          Top = 26
          Width = 105
          Height = 25
          Caption = 'A&dd all'
          Enabled = False
          Flat = True
          Margin = 7
          Spacing = 5
          OnClick = btnAddAllClick
        end
        object btnShowDetails: TSpeedButton
          Tag = 4
          Left = 0
          Top = 112
          Width = 105
          Height = 25
          AllowAllUp = True
          GroupIndex = 3
          Caption = 'Show &Details'
          Enabled = False
          Flat = True
          Margin = 7
          Spacing = 5
          OnClick = btnShowDetailsClick
        end
        object btnGroup: TSpeedButton
          Tag = 3
          Left = 0
          Top = 81
          Width = 105
          Height = 25
          AllowAllUp = True
          GroupIndex = 2
          Caption = '&Grouping'
          Flat = True
          Margin = 7
          Spacing = 8
          OnClick = btnGroupClick
        end
        object btnColumn: TSpeedButton
          Tag = 4
          Left = 0
          Top = 56
          Width = 105
          Height = 25
          AllowAllUp = True
          GroupIndex = 1
          Caption = 'Colum&ns'
          Flat = True
          Margin = 6
          Spacing = 7
          OnClick = btnColumnClick
        end
        object pnlDivisoria2: TPanel
          Left = 3
          Top = 108
          Width = 101
          Height = 2
          BevelOuter = bvLowered
          TabOrder = 0
        end
        object Panel4: TPanel
          Left = 3
          Top = 53
          Width = 101
          Height = 2
          BevelOuter = bvLowered
          TabOrder = 1
        end
      end
    end
  end
  object slModelDetail: TSubListPanel [6]
    Left = 0
    Top = 396
    Width = 790
    Height = 103
    Align = alBottom
    BevelOuter = bvNone
    Color = clBtnShadow
    TabOrder = 6
    Visible = False
    SubListClassName = 'TSubStoreQty'
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmAddItems.sil'
    Left = 12
    Top = 12
  end
  object dsModelAdd: TDataSource
    DataSet = cdsModelAdd
    Left = 100
    Top = 376
  end
  object cdsModelAdd: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsModelAddAfterScroll
    Left = 100
    Top = 328
    object cdsModelAddIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsModelAddModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsModelAddDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsModelAddQty: TFloatField
      FieldName = 'Qty'
    end
    object cdsModelAddCostPrice: TCurrencyField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsModelAddSalePrice: TCurrencyField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
    end
    object cdsModelAddTax: TFloatField
      FieldName = 'Tax'
    end
    object cdsModelAddManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
  end
  object spSalePrice: TADOStoredProc
    Connection = DM.ADODBConnect
    ProcedureName = 'sp_PreSale_CalcSalePrice;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ModelID'
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
        Name = '@IDCustomer'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@SpecialPriceID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@SalePrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@CostPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@Discount'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@AvgCostPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@ReplacementCost'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@StoreSalePrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@RequestCustomer'
        Attributes = [paNullable]
        DataType = ftBoolean
        Direction = pdInputOutput
        Value = Null
      end
      item
        Name = '@PuppyTracker'
        Attributes = [paNullable]
        DataType = ftBoolean
        Direction = pdInputOutput
        Value = Null
      end
      item
        Name = '@StoreCostPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@StoreAvgCost'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end
      item
        Name = '@AddKitItems'
        Attributes = [paNullable]
        DataType = ftBoolean
        Direction = pdInputOutput
        Value = Null
      end
      item
        Name = '@PromotionPrice'
        Attributes = [paNullable]
        DataType = ftBCD
        Direction = pdInputOutput
        Precision = 19
        Value = Null
      end>
    Left = 172
    Top = 376
  end
  object quModelResult: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.SellingPrice' +
      ','#13#10#9'M.VendorCost,'#13#10#9'IsNull(M.CaseQty,0) as CaseQty,'#13#10#9'TG.IDGroup' +
      ','#13#10#9'TG.Name,'#13#10#9'B.IDBarcode,'#13#10#9'IsNull(MG.IDModelGroup, 0) as IDMo' +
      'delGroup,'#13#10#9'IsNull(MG.ModelGroup, '#39#39') as ModelGroup,'#13#10#9'IsNull(MS' +
      'G.IDModelSubGroup, 0) as IDModelSubGroup,'#13#10#9'IsNull(MSG.ModelSubG' +
      'roup, '#39#39') as ModelSubGroup,'#13#10#9'1 as Qty,'#13#10#9'F.Pessoa as Manufactur' +
      'er'#13#10'FROM'#13#10#9'Model M (NOLOCK)'#13#10#9'JOIN TabGroup TG (NOLOCK) ON (M.Gr' +
      'oupID = TG.IDgroup)'#13#10#9'LEFT JOIN ModelGroup MG (NOLOCK) ON (M.IDM' +
      'odelGroup = MG.IDModelGroup)'#13#10#9'LEFT JOIN ModelSubGroup MSG (NOLO' +
      'CK) ON (M.IDModelSubGroup = MSG.IDModelSubGroup)'#13#10#9'LEFT JOIN Bar' +
      'code B (NOLOCK) ON (M.IDModel = B.IDModel AND B.BarcodeOrder = 1' +
      ')'#13#10#9'LEFT JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)'
    Parameters = <>
    Left = 100
    Top = 180
    object quModelResultIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object quModelResultModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quModelResultDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quModelResultSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object quModelResultVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object quModelResultIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quModelResultName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quModelResultIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
      ReadOnly = True
    end
    object quModelResultModelGroup: TStringField
      FieldName = 'ModelGroup'
      Size = 30
    end
    object quModelResultIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
      ReadOnly = True
    end
    object quModelResultModelSubGroup: TStringField
      FieldName = 'ModelSubGroup'
      Size = 30
    end
    object quModelResultIDBarcode: TStringField
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object quModelResultCaseQty: TBCDField
      FieldName = 'CaseQty'
      ReadOnly = True
      Precision = 32
    end
    object quModelResultQty: TIntegerField
      FieldName = 'Qty'
    end
    object quModelResultManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
  end
  object dsModelResult: TDataSource
    DataSet = cdsModelResult
    OnDataChange = dsModelResultDataChange
    Left = 344
    Top = 180
  end
  object dspModelResult: TDataSetProvider
    DataSet = quModelResult
    Left = 184
    Top = 180
  end
  object cdsModelResult: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModelResult'
    AfterScroll = cdsModelResultAfterScroll
    Left = 264
    Top = 180
    object cdsModelResultIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsModelResultModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object cdsModelResultDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object cdsModelResultSellingPrice: TBCDField
      FieldName = 'SellingPrice'
      Precision = 19
    end
    object cdsModelResultVendorCost: TBCDField
      FieldName = 'VendorCost'
      Precision = 19
    end
    object cdsModelResultIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object cdsModelResultName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object cdsModelResultIDModelGroup: TIntegerField
      FieldName = 'IDModelGroup'
      ReadOnly = True
    end
    object cdsModelResultModelGroup: TStringField
      FieldName = 'ModelGroup'
      Size = 30
    end
    object cdsModelResultIDModelSubGroup: TIntegerField
      FieldName = 'IDModelSubGroup'
      ReadOnly = True
    end
    object cdsModelResultModelSubGroup: TStringField
      FieldName = 'ModelSubGroup'
      Size = 30
    end
    object cdsModelResultIDBarcode: TStringField
      FieldName = 'IDBarcode'
      FixedChar = True
    end
    object cdsModelResultCaseQty: TBCDField
      FieldName = 'CaseQty'
      ReadOnly = True
      Precision = 32
    end
    object cdsModelResultQty: TIntegerField
      FieldName = 'Qty'
    end
    object cdsModelResultManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
  end
end
