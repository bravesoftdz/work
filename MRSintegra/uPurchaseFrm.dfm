object SintegraPurchaseFrm: TSintegraPurchaseFrm
  Left = 256
  Top = 234
  Width = 600
  Height = 350
  Caption = 'Compras'
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
  object grdPurchase: TcxGrid
    Left = 0
    Top = 33
    Width = 592
    Height = 260
    Align = alClient
    TabOrder = 1
    object grdPurchaseDBTableView: TcxGridDBTableView
      DataController.DataSource = dsPurchase
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object grdPurchaseDBTableViewCodigoFornecedor: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoFornecedor'
      end
      object grdPurchaseDBTableViewCFOP: TcxGridDBColumn
        DataBinding.FieldName = 'CFOP'
      end
      object grdPurchaseDBTableViewCodigoProduto: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoProduto'
      end
      object grdPurchaseDBTableViewQuantidade: TcxGridDBColumn
        DataBinding.FieldName = 'Quantidade'
      end
      object grdPurchaseDBTableViewValorTotal: TcxGridDBColumn
        DataBinding.FieldName = 'ValorTotal'
      end
      object grdPurchaseDBTableViewValorImposto: TcxGridDBColumn
        DataBinding.FieldName = 'ValorImposto'
      end
      object grdPurchaseDBTableViewPercImposto: TcxGridDBColumn
        DataBinding.FieldName = 'PercImposto'
      end
      object grdPurchaseDBTableViewFrete: TcxGridDBColumn
        DataBinding.FieldName = 'Frete'
      end
      object grdPurchaseDBTableViewOutrosCustos: TcxGridDBColumn
        DataBinding.FieldName = 'OutrosCustos'
      end
      object grdPurchaseDBTableViewNovoCusto: TcxGridDBColumn
        DataBinding.FieldName = 'NovoCusto'
      end
      object grdPurchaseDBTableViewNF: TcxGridDBColumn
        DataBinding.FieldName = 'NF'
      end
      object grdPurchaseDBTableViewDataRegistro: TcxGridDBColumn
        DataBinding.FieldName = 'DataRegistro'
      end
      object grdPurchaseDBTableViewDataFatura: TcxGridDBColumn
        DataBinding.FieldName = 'DataFatura'
      end
      object grdPurchaseDBTableViewCNPJ: TcxGridDBColumn
        DataBinding.FieldName = 'CNPJ'
      end
      object grdPurchaseDBTableViewInscEstadual: TcxGridDBColumn
        DataBinding.FieldName = 'InscEstadual'
      end
      object grdPurchaseDBTableViewGrupoFornecido: TcxGridDBColumn
        DataBinding.FieldName = 'GrupoFornecido'
      end
      object grdPurchaseDBTableViewEstado: TcxGridDBColumn
        DataBinding.FieldName = 'Estado'
      end
      object grdPurchaseDBTableViewNomeFornecedor: TcxGridDBColumn
        DataBinding.FieldName = 'NomeFornecedor'
      end
      object grdPurchaseDBTableViewProduto: TcxGridDBColumn
        DataBinding.FieldName = 'Produto'
      end
      object grdPurchaseDBTableViewCF: TcxGridDBColumn
        DataBinding.FieldName = 'CF'
      end
    end
    object grdPurchaseLevel: TcxGridLevel
      GridView = grdPurchaseDBTableView
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 293
    Width = 592
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      592
      30)
    object btnOk: TcxButton
      Left = 512
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      TabOrder = 0
    end
  end
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 59
      Height = 13
      Caption = 'Compras de '
    end
    object Label2: TLabel
      Left = 204
      Top = 8
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object edtFirstPurchaseDate: TcxDateEdit
      Left = 76
      Top = 4
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtLastPurchaseDate: TcxDateEdit
      Left = 228
      Top = 4
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object btnGo: TcxButton
      Left = 356
      Top = 2
      Width = 29
      Height = 25
      Caption = 'GO!'
      TabOrder = 2
      OnClick = btnGoClick
    end
  end
  object dsPurchase: TDataSource
    DataSet = DMSintegra.quPurchase
    Left = 220
    Top = 76
  end
end
