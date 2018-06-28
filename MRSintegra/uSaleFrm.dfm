object SintegraSaleFrm: TSintegraSaleFrm
  Left = 277
  Top = 231
  Width = 600
  Height = 350
  Caption = 'Vendas'
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
  object grdSale: TcxGrid
    Left = 0
    Top = 33
    Width = 592
    Height = 258
    Align = alClient
    TabOrder = 1
    object grdSaleDBTableView: TcxGridDBTableView
      DataController.DataSource = dsSale
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object grdSaleDBTableViewCodigoFornecedor: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoFornecedor'
      end
      object grdSaleDBTableViewCodigoProduto: TcxGridDBColumn
        DataBinding.FieldName = 'CodigoProduto'
      end
      object grdSaleDBTableViewQuantidade: TcxGridDBColumn
        DataBinding.FieldName = 'Quantidade'
      end
      object grdSaleDBTableViewValorTotal: TcxGridDBColumn
        DataBinding.FieldName = 'ValorTotal'
      end
      object grdSaleDBTableViewValorImposto: TcxGridDBColumn
        DataBinding.FieldName = 'ValorImposto'
      end
      object grdSaleDBTableViewPercImposto: TcxGridDBColumn
        DataBinding.FieldName = 'PercImposto'
      end
      object grdSaleDBTableViewFrete: TcxGridDBColumn
        DataBinding.FieldName = 'Frete'
      end
      object grdSaleDBTableViewOutrosCustos: TcxGridDBColumn
        DataBinding.FieldName = 'OutrosCustos'
      end
      object grdSaleDBTableViewNovoCusto: TcxGridDBColumn
        DataBinding.FieldName = 'NovoCusto'
      end
      object grdSaleDBTableViewNF: TcxGridDBColumn
        DataBinding.FieldName = 'NF'
      end
      object grdSaleDBTableViewDataRegistro: TcxGridDBColumn
        DataBinding.FieldName = 'DataRegistro'
      end
      object grdSaleDBTableViewDataFatura: TcxGridDBColumn
        DataBinding.FieldName = 'DataFatura'
      end
      object grdSaleDBTableViewCPF: TcxGridDBColumn
        DataBinding.FieldName = 'CPF'
      end
      object grdSaleDBTableViewInscEstadual: TcxGridDBColumn
        DataBinding.FieldName = 'InscEstadual'
      end
      object grdSaleDBTableViewGrupoFornecido: TcxGridDBColumn
        DataBinding.FieldName = 'GrupoFornecido'
      end
      object grdSaleDBTableViewEstado: TcxGridDBColumn
        DataBinding.FieldName = 'Estado'
      end
      object grdSaleDBTableViewNomeCliente: TcxGridDBColumn
        DataBinding.FieldName = 'NomeCliente'
      end
      object grdSaleDBTableViewProduto: TcxGridDBColumn
        DataBinding.FieldName = 'Produto'
      end
      object grdSaleDBTableViewCF: TcxGridDBColumn
        DataBinding.FieldName = 'CF'
      end
    end
    object grdSaleLevel: TcxGridLevel
      GridView = grdSaleDBTableView
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 291
    Width = 592
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      592
      32)
    object btnOk: TcxButton
      Left = 513
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
      Left = 16
      Top = 8
      Width = 54
      Height = 13
      Caption = 'Vendas de '
    end
    object Label2: TLabel
      Left = 204
      Top = 8
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object edtFirstSaleDate: TcxDateEdit
      Left = 76
      Top = 4
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtLastSaleDate: TcxDateEdit
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
  object dsSale: TDataSource
    DataSet = DMSintegra.quSale
    Left = 244
    Top = 168
  end
end
