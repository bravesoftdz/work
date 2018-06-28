inherited FrmInventoryUpdate: TFrmInventoryUpdate
  Left = 268
  Top = 59
  Width = 758
  Height = 568
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Price Cost Update'
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grdProducts: TcxGrid [0]
    Left = 0
    Top = 85
    Width = 750
    Height = 417
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    object grdProductsTableView: TcxGridDBTableView
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OnCustomDrawCell = grdProductsTableViewCustomDrawCell
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
    end
    object grdProductsLevel: TcxGridLevel
      GridView = grdProductsTableView
    end
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 0
    Width = 750
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    Color = clBtnShadow
    TabOrder = 1
    DesignSize = (
      750
      85)
    object Label1: TLabel
      Left = 9
      Top = 34
      Width = 59
      Height = 13
      Alignment = taRightJustify
      Caption = 'Category :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVendor: TLabel
      Left = 18
      Top = 8
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Vendor :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 310
      Top = 8
      Width = 85
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sub-Category :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 352
      Top = 34
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Group :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 660
      Top = 24
      Width = 75
      Height = 37
      Anchors = [akRight, akBottom]
      Caption = 'GO!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object cbxCategory: TcxLookupComboBox
      Left = 71
      Top = 30
      Width = 186
      Height = 21
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'IDCategory'
      Properties.ListColumns = <
        item
          FieldName = 'Category'
        end>
      Properties.ListOptions.GridLines = glNone
      Properties.ListOptions.ShowHeader = False
      Style.BorderStyle = ebs3D
      TabOrder = 1
    end
    object btnAllCategory: TButton
      Left = 262
      Top = 31
      Width = 31
      Height = 22
      Caption = 'All'
      TabOrder = 2
      OnClick = btnAllCategoryClick
    end
    object cbxVendor: TcxLookupComboBox
      Left = 71
      Top = 4
      Width = 186
      Height = 21
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'IDVendor'
      Properties.ListColumns = <
        item
          FieldName = 'Vendor'
        end>
      Properties.ListOptions.GridLines = glNone
      Properties.ListOptions.ShowHeader = False
      Style.BorderStyle = ebs3D
      TabOrder = 3
    end
    object btnAllVendor: TButton
      Left = 262
      Top = 5
      Width = 31
      Height = 21
      Caption = 'All'
      TabOrder = 4
      OnClick = btnAllVendorClick
    end
    object cbxSubCategory: TcxLookupComboBox
      Left = 398
      Top = 4
      Width = 186
      Height = 21
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'IDSubCategory'
      Properties.ListColumns = <
        item
          FieldName = 'SubCategory'
        end>
      Properties.ListOptions.GridLines = glNone
      Properties.ListOptions.ShowHeader = False
      Style.BorderStyle = ebs3D
      TabOrder = 5
    end
    object btnAllSubCateg: TButton
      Left = 589
      Top = 5
      Width = 31
      Height = 22
      Caption = 'All'
      TabOrder = 6
      OnClick = btnAllSubCategClick
    end
    object cbxGroup: TcxLookupComboBox
      Left = 398
      Top = 30
      Width = 186
      Height = 21
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'IDGroup'
      Properties.ListColumns = <
        item
          FieldName = 'ModelGroup'
        end>
      Properties.ListOptions.GridLines = glNone
      Properties.ListOptions.ShowHeader = False
      Style.BorderStyle = ebs3D
      TabOrder = 7
    end
    object Button2: TButton
      Left = 589
      Top = 31
      Width = 31
      Height = 22
      Caption = 'All'
      TabOrder = 8
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 502
    Width = 750
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    DesignSize = (
      750
      39)
    object BNext: TButton
      Left = 568
      Top = 10
      Width = 80
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Update'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BNextClick
    end
    object BClose: TButton
      Left = 653
      Top = 10
      Width = 80
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 1
      OnClick = BCloseClick
    end
    object btnColumns: TButton
      Left = 487
      Top = 10
      Width = 75
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'Columns'
      TabOrder = 2
      OnClick = btnColumnsClick
    end
    object btnGroup: TButton
      Left = 408
      Top = 10
      Width = 75
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'Group'
      TabOrder = 3
      OnClick = btnGroupClick
    end
    object btExpand: TButton
      Left = 326
      Top = 10
      Width = 75
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'Expand'
      TabOrder = 4
      OnClick = btExpandClick
    end
  end
  inherited siLang: TsiLang
    Left = 38
    Top = 147
  end
  object cdsProducts: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 160
    Top = 120
  end
  object dsProducts: TDataSource
    DataSet = cdsProducts
    Left = 160
    Top = 180
  end
  object cdsModelUpdate: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 120
    object cdsModelUpdateIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsModelUpdateCostPrice: TCurrencyField
      FieldName = 'CostPrice'
    end
    object cdsModelUpdateSalePrice: TCurrencyField
      FieldName = 'SalePrice'
    end
    object cdsModelUpdateMSRP: TCurrencyField
      FieldName = 'MSRP'
    end
    object cdsModelUpdateModel: TStringField
      FieldName = 'Model'
    end
    object cdsModelUpdateIDUserLastSellingPrice: TIntegerField
      FieldName = 'IDUserLastSellingPrice'
    end
  end
  object cdsInventoryUpdate: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 196
    object cdsInventoryUpdateIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsInventoryUpdateDescription: TStringField
      FieldName = 'Description'
    end
    object cdsInventoryUpdateModel: TStringField
      FieldName = 'Model'
    end
  end
end
