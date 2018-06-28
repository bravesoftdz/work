inherited FrmStorePrice: TFrmStorePrice
  Left = 295
  Top = 221
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmStorePrice'
  ClientHeight = 373
  ClientWidth = 692
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 692
    inherited Image1: TImage
      Width = 465
    end
    inherited lblMenu: TLabel
      Left = 476
    end
    inherited EspacamentoSuperior: TPanel
      Width = 692
      inherited EEE: TPanel
        Width = 692
      end
    end
  end
  inherited Panel1: TPanel
    Top = 332
    Width = 692
    inherited EspacamentoInferior: TPanel
      Width = 692
      inherited Panel3: TPanel
        Width = 692
      end
    end
    inherited hhh: TPanel
      Left = 544
      Width = 148
      inherited btClose: TButton
        Left = 76
        Top = 4
        Cancel = True
        ModalResult = 2
      end
      object btSave: TButton
        Left = 4
        Top = 4
        Width = 66
        Height = 31
        Caption = '&Save'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btSaveClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 292
  end
  inherited EspacamentoDireito: TPanel
    Left = 689
    Height = 292
  end
  object Panel4: TPanel [4]
    Left = 585
    Top = 40
    Width = 3
    Height = 292
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
  end
  object pnlButton: TPanelRights [5]
    Left = 588
    Top = 40
    Width = 101
    Height = 292
    Align = alRight
    BevelOuter = bvNone
    Color = 14607076
    TabOrder = 5
    object btRemove: TSpeedButton
      Tag = 7
      Left = 2
      Top = 29
      Width = 98
      Height = 26
      Caption = '&Remove'
      Flat = True
      Margin = 4
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btRemoveClick
    end
    object btAdd: TSpeedButton
      Tag = 7
      Left = 2
      Top = 3
      Width = 98
      Height = 26
      Caption = '&Add'
      Flat = True
      Margin = 4
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btAddClick
    end
    object btDescription: TSpeedButton
      Tag = 7
      Left = 2
      Top = 62
      Width = 98
      Height = 26
      Caption = '&Descriptions'
      Flat = True
      Margin = 4
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btDescriptionClick
    end
    object btAddAllDesc: TSpeedButton
      Tag = 7
      Left = 2
      Top = 88
      Width = 98
      Height = 26
      Caption = '&Add all desc.'
      Flat = True
      Margin = 4
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btAddAllDescClick
    end
    object Panel5: TPanel
      Left = 3
      Top = 58
      Width = 97
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  object grdStorePrice: TcxGrid [6]
    Left = 3
    Top = 40
    Width = 582
    Height = 292
    Align = alClient
    TabOrder = 6
    LookAndFeel.Kind = lfFlat
    object grdStorePriceDBTableView: TcxGridDBTableView
      DataController.DataSource = dsStorePrice
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdStorePriceDBTableViewIDVendor: TcxGridDBColumn
        Caption = 'Vendor'
        DataBinding.FieldName = 'IDVendor'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'IDVendor'
        Properties.ListColumns = <
          item
            FieldName = 'Vendor'
          end>
        Properties.ListOptions.GridLines = glNone
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsLUVendor
        Width = 190
      end
      object grdStorePriceDBTableViewIDDescriptionPrice: TcxGridDBColumn
        Caption = 'Description'
        DataBinding.FieldName = 'IDDescriptionPrice'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'IDDescriptionPrice'
        Properties.ListColumns = <
          item
            FieldName = 'DescriptionPrice'
          end>
        Properties.ListOptions.GridLines = glNone
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dsLUDescriptionPrice
        Width = 161
      end
      object grdStorePriceDBTableViewCostPrice: TcxGridDBColumn
        Caption = 'Cost Price'
        DataBinding.FieldName = 'CostPrice'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Width = 68
      end
      object grdStorePriceDBTableViewSuggPrice: TcxGridDBColumn
        Caption = 'Sugg Price'
        DataBinding.FieldName = 'SuggPrice'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Width = 69
      end
      object grdStorePriceDBTableViewSalePrice: TcxGridDBColumn
        Caption = 'Sale Price'
        DataBinding.FieldName = 'SalePrice'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Width = 73
      end
    end
    object grdStorePriceLevel: TcxGridLevel
      GridView = grdStorePriceDBTableView
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmStorePrice.sil'
  end
  object dsStorePrice: TDataSource
    DataSet = cdsStorePrice
    Left = 140
    Top = 236
  end
  object dspStorePrice: TDataSetProvider
    DataSet = qryStorePrice
    Options = [poIncFieldProps]
    Left = 140
    Top = 140
  end
  object qryStorePrice: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDStore'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'ISP.IDStore,'
      #9'ISP.IDModel,'
      #9'ISP.IDDescriptionPrice,'
      #9'ISP.IDVendor,'
      #9'ISP.CostPrice,'
      #9'ISP.SuggPrice,'
      #9'ISP.SalePrice'
      'FROM'
      #9'Inv_StorePrice ISP (NOLOCK) '
      'WHERE'
      #9'ISP.IDStore = :IDStore'
      #9'AND ISP.IDModel = :IDModel')
    Left = 140
    Top = 92
    object qryStorePriceIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object qryStorePriceIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryStorePriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object qryStorePriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object qryStorePriceCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryStorePriceSuggPrice: TBCDField
      FieldName = 'SuggPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryStorePriceSalePrice: TBCDField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object cdsStorePrice: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspStorePrice'
    BeforePost = cdsStorePriceBeforePost
    OnNewRecord = cdsStorePriceNewRecord
    Left = 140
    Top = 188
    object cdsStorePriceIDStore: TIntegerField
      FieldName = 'IDStore'
    end
    object cdsStorePriceIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsStorePriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object cdsStorePriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsStorePriceCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsStorePriceSuggPrice: TBCDField
      FieldName = 'SuggPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsStorePriceSalePrice: TBCDField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object qryLUVendor: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'P.IDPessoa IDVendor,'
      #9'P.Pessoa Vendor'
      'FROM'
      #9'Pessoa P (NOLOCK) '
      
        #9'JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoaRoot = TP.IDTipoP' +
        'essoa)'
      'WHERE'
      #9'TP.Path LIKE '#39'.002%'#39)
    Left = 244
    Top = 92
    object qryLUVendorIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object qryLUVendorVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
  object dsLUVendor: TDataSource
    DataSet = qryLUVendor
    Left = 244
    Top = 140
  end
  object dsLUDescriptionPrice: TDataSource
    DataSet = qryLUDescriptionPrice
    Left = 348
    Top = 140
  end
  object qryLUDescriptionPrice: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'IDP.IDDescriptionPrice,'
      #9'IDP.DescriptionPrice'
      'FROM'
      #9'Inv_DescriptionPrice IDP (NOLOCK) ')
    Left = 348
    Top = 92
    object qryLUDescriptionPriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object qryLUDescriptionPriceDescriptionPrice: TStringField
      FieldName = 'DescriptionPrice'
    end
  end
end
