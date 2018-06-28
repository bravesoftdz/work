inherited FrmModelPrice: TFrmModelPrice
  Left = 307
  Top = 178
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'FrmModelPrice'
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
      Left = 546
      Width = 146
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
    Left = 585
    Height = 292
  end
  object grdModelPrice: TcxGrid [4]
    Left = 3
    Top = 40
    Width = 582
    Height = 292
    Align = alClient
    TabOrder = 4
    LookAndFeel.Kind = lfFlat
    object grdModelPriceDBTableView: TcxGridDBTableView
      DataController.DataSource = dsModelPrice
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdModelPriceDBTableViewIDVendor: TcxGridDBColumn
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
      object grdModelPriceDBTableViewIDDescriptionPrice: TcxGridDBColumn
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
      object grdModelPriceDBTableViewCostPrice: TcxGridDBColumn
        Caption = 'Cost Price'
        DataBinding.FieldName = 'CostPrice'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Width = 68
      end
      object grdModelPriceDBTableViewSuggPrice: TcxGridDBColumn
        Caption = 'Sugg Price'
        DataBinding.FieldName = 'SuggPrice'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Width = 69
      end
      object grdModelPriceDBTableViewSalePrice: TcxGridDBColumn
        Caption = 'Sale Price'
        DataBinding.FieldName = 'SalePrice'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Width = 73
      end
    end
    object grdModelPriceLevel: TcxGridLevel
      GridView = grdModelPriceDBTableView
    end
  end
  object pnlButton: TPanelRights [5]
    Left = 588
    Top = 40
    Width = 104
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
    object Panel4: TPanel
      Left = 3
      Top = 58
      Width = 97
      Height = 2
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmModelPrice.sil'
    Top = 92
  end
  object dsModelPrice: TDataSource
    DataSet = cdsModelPrice
    Left = 140
    Top = 236
  end
  object dspModelPrice: TDataSetProvider
    DataSet = qryModelPrice
    Options = [poIncFieldProps]
    Left = 140
    Top = 140
  end
  object qryModelPrice: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
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
      #9'IMP.IDModel,'
      #9'IMP.IDDescriptionPrice,'
      #9'IMP.IDVendor,'
      #9'IMP.CostPrice,'
      #9'IMP.SuggPrice,'
      #9'IMP.SalePrice'
      'FROM'
      #9'Inv_ModelPrice IMP (NOLOCK) '
      'WHERE'
      #9'IMP.IDModel = :IDModel')
    Left = 140
    Top = 92
    object qryModelPriceIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object qryModelPriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object qryModelPriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object qryModelPriceCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryModelPriceSuggPrice: TBCDField
      FieldName = 'SuggPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryModelPriceSalePrice: TBCDField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object cdsModelPrice: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModelPrice'
    BeforePost = cdsModelPriceBeforePost
    OnNewRecord = cdsModelPriceNewRecord
    Left = 140
    Top = 188
    object cdsModelPriceIDModel: TIntegerField
      FieldName = 'IDModel'
    end
    object cdsModelPriceIDDescriptionPrice: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object cdsModelPriceIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object cdsModelPriceCostPrice: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceSuggPrice: TBCDField
      FieldName = 'SuggPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsModelPriceSalePrice: TBCDField
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
