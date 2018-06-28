object FrmTransporter: TFrmTransporter
  Left = 112
  Top = 187
  BorderStyle = bsSingle
  Caption = 'Transportadoras'
  ClientHeight = 426
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 391
    Width = 802
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      802
      35)
    object btnOk: TButton
      Left = 721
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Fechar'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object grdItems: TcxGrid
    Left = 0
    Top = 0
    Width = 802
    Height = 391
    Align = alClient
    BevelOuter = bvNone
    BevelKind = bkTile
    TabOrder = 1
    LookAndFeel.Kind = lfFlat
    object grdItemsDB: TcxGridDBTableView
      DataController.DataSource = dsTransp
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDPessoa'
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
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.AutoHeight = False
      Preview.MaxLineCount = 2
      Styles.Content = cxStyleContent
      Styles.ContentEven = cxStyleContentEven
      Styles.Selection = cxStyleSelection2
      Styles.Header = cxStyleHeader2
      object grdItemsDBPessoa: TcxGridDBColumn
        Caption = 'Transportadora'
        DataBinding.FieldName = 'Pessoa'
        Width = 133
      end
      object grdItemsDBEndereco: TcxGridDBColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'Endereco'
        Width = 211
      end
      object grdItemsDBBairro: TcxGridDBColumn
        DataBinding.FieldName = 'Bairro'
        Width = 116
      end
      object grdItemsDBCidade: TcxGridDBColumn
        DataBinding.FieldName = 'Cidade'
        Width = 75
      end
      object grdItemsDBIDEstado: TcxGridDBColumn
        Caption = 'Estado'
        DataBinding.FieldName = 'IDEstado'
        Width = 62
      end
      object grdItemsDBCEP: TcxGridDBColumn
        DataBinding.FieldName = 'CEP'
        Width = 66
      end
      object grdItemsDBCGC: TcxGridDBColumn
        Caption = 'CNPJ'
        DataBinding.FieldName = 'CGC'
        Width = 52
      end
      object grdItemsDBInscEstadual: TcxGridDBColumn
        Caption = 'Insc. Estadual'
        DataBinding.FieldName = 'InscEstadual'
        Width = 83
      end
    end
    object grdItemsLevel: TcxGridLevel
      GridView = grdItemsDB
    end
  end
  object dsTransp: TDataSource
    DataSet = qryTransp
    Left = 200
    Top = 192
  end
  object qryTransp: TADODataSet
    Connection = FrmMain.Connection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.Pessoa,'#13#10#9'P.Endereco,'#13#10#9'P.Bairro,'#13#10#9'P.C' +
      'idade,'#13#10#9'P.IDEstado,'#13#10#9'P.CEP,'#13#10#9'P.CGC,'#13#10#9'P.InscEstadual'#13#10'FROM'#13#10#9 +
      'Pessoa P'#13#10'WHERE'#13#10#9'IDTipoPessoa = 2'
    Parameters = <>
    Left = 200
    Top = 136
    object qryTranspIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object qryTranspPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object qryTranspEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object qryTranspBairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object qryTranspCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object qryTranspIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object qryTranspCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object qryTranspCGC: TStringField
      FieldName = 'CGC'
      Size = 30
    end
    object qryTranspInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Size = 30
    end
  end
  object strepSaleItem: TcxStyleRepository
    Left = 420
    Top = 207
    object cxStyle: TcxStyle
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
    object cxStyle7: TcxStyle
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
      Styles.Background = cxStyle
      Styles.Content = cxStyleContent
      Styles.ContentEven = cxStyleContentEven
      Styles.ContentOdd = cxStyle4
      Styles.Inactive = cxStyle10
      Styles.IncSearch = cxStyle11
      Styles.Selection = cxStyleSelection
      Styles.FilterBox = cxStyle5
      Styles.Footer = cxStyle6
      Styles.Group = cxStyle7
      Styles.GroupByBox = cxStyle8
      Styles.Header = cxStyleHeader
      Styles.Indicator = cxStyle12
      Styles.Preview = cxStyle13
    end
  end
end
