inherited FrmChoosePrice: TFrmChoosePrice
  Left = 402
  Top = 197
  Width = 505
  Height = 377
  Caption = 'FrmChoosePrice'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 497
    inherited Image1: TImage
      Width = 270
    end
    inherited lblMenu: TLabel
      Left = 281
    end
    inherited EspacamentoSuperior: TPanel
      Width = 497
      inherited EEE: TPanel
        Width = 497
      end
    end
  end
  inherited Panel1: TPanel
    Top = 309
    Width = 497
    inherited EspacamentoInferior: TPanel
      Width = 497
      inherited Panel3: TPanel
        Width = 497
      end
    end
    inherited hhh: TPanel
      Left = 415
      inherited btClose: TButton
        Caption = '&Ok'
        Default = True
        ModalResult = 1
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 269
  end
  inherited EspacamentoDireito: TPanel
    Left = 494
    Height = 269
  end
  object grdPriceTable: TcxGrid [4]
    Left = 3
    Top = 40
    Width = 491
    Height = 269
    Align = alClient
    TabOrder = 4
    LookAndFeel.Kind = lfFlat
    object grdPriceTableDBTableView: TcxGridDBTableView
      OnDblClick = grdPriceTableDBTableViewDblClick
      DataController.DataSource = dsPriceTable
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object grdPriceTableDBTableViewVendor: TcxGridDBColumn
        DataBinding.FieldName = 'Vendor'
      end
      object grdPriceTableDBTableViewDescriptionPrice: TcxGridDBColumn
        Caption = 'Description'
        DataBinding.FieldName = 'DescriptionPrice'
      end
      object grdPriceTableDBTableViewCostPrice: TcxGridDBColumn
        Caption = 'Cost Price'
        DataBinding.FieldName = 'CostPrice'
      end
      object grdPriceTableDBTableViewSuggPrice: TcxGridDBColumn
        Caption = 'Sugg Price'
        DataBinding.FieldName = 'SuggPrice'
      end
      object grdPriceTableDBTableViewSalePrice: TcxGridDBColumn
        Caption = 'Sale Price'
        DataBinding.FieldName = 'SalePrice'
      end
    end
    object grdPriceTableLevel: TcxGridLevel
      GridView = grdPriceTableDBTableView
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmChoosePrice.sil'
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
      #9'IMP.IDDescriptionPrice,'
      #9'IMP.IDVendor,'
      #9'IMP.CostPrice,'
      #9'IMP.SuggPrice,'
      #9'IMP.SalePrice,'
      #9'IDP.DescriptionPrice,'
      #9'V.Pessoa Vendor'
      'FROM'
      #9'Inv_ModelPrice IMP (NOLOCK) '
      
        #9'JOIN Inv_DescriptionPrice IDP (NOLOCK)  ON (IMP.IDDescriptionPr' +
        'ice = IDP.IDDescriptionPrice)'
      #9'LEFT JOIN Pessoa V (NOLOCK)  ON (IMP.IDVendor = V.IDPessoa)'
      'WHERE'
      #9'IMP.IDModel = :IDModel')
    Left = 140
    Top = 92
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
    object qryModelPriceDescriptionPrice: TStringField
      FieldName = 'DescriptionPrice'
    end
    object qryModelPriceVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
  object dsPriceTable: TDataSource
    Left = 180
    Top = 144
  end
  object qryStorePrice: TADOQuery
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
      #9'ISP.IDDescriptionPrice,'
      #9'ISP.IDVendor,'
      #9'ISP.CostPrice,'
      #9'ISP.SuggPrice,'
      #9'ISP.SalePrice,'
      #9'IDP.DescriptionPrice,'
      #9'V.Pessoa Vendor'
      'FROM'
      #9'Inv_StorePrice ISP (NOLOCK) '
      
        #9'JOIN Inv_DescriptionPrice IDP (NOLOCK)  ON (ISP.IDDescriptionPr' +
        'ice = IDP.IDDescriptionPrice)'
      #9'LEFT JOIN Pessoa V (NOLOCK)  ON (ISP.IDVendor = V.IDPessoa)'
      'WHERE'
      #9'ISP.IDModel = :IDModel'
      #9'AND ISP.IDStore = :IDStore')
    Left = 216
    Top = 92
    object IntegerField1: TIntegerField
      FieldName = 'IDDescriptionPrice'
    end
    object IntegerField2: TIntegerField
      FieldName = 'IDVendor'
    end
    object BCDField1: TBCDField
      FieldName = 'CostPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object BCDField2: TBCDField
      FieldName = 'SuggPrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object BCDField3: TBCDField
      FieldName = 'SalePrice'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object StringField1: TStringField
      FieldName = 'DescriptionPrice'
    end
    object StringField2: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
  end
end
