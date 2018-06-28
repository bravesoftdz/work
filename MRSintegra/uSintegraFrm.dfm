object SintegraFrm: TSintegraFrm
  Left = 121
  Top = 124
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Sintegra'
  ClientHeight = 341
  ClientWidth = 671
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 311
    Width = 671
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      671
      30)
    object lbDisplay: TLabel
      Left = 155
      Top = 10
      Width = 3
      Height = 13
    end
    object btnClose: TcxButton
      Left = 591
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnOk: TcxButton
      Left = 511
      Top = 4
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Gerar Sintegra'
      TabOrder = 1
      OnClick = btnOkClick
    end
    object pb: TProgressBar
      Left = 5
      Top = 8
      Width = 150
      Height = 16
      Smooth = True
      Step = 1
      TabOrder = 2
      Visible = False
    end
  end
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 671
    Height = 77
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      671
      77)
    object Label1: TLabel
      Left = 15
      Top = 8
      Width = 56
      Height = 13
      Caption = 'Per'#237'odo de '
    end
    object Label2: TLabel
      Left = 180
      Top = 8
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object Label3: TLabel
      Left = 347
      Top = 8
      Width = 51
      Height = 13
      Caption = 'Conv'#234'nio :'
    end
    object Label4: TLabel
      Left = 322
      Top = 32
      Width = 76
      Height = 13
      Caption = 'Nat. Opera'#231#227'o :'
    end
    object Label5: TLabel
      Left = 344
      Top = 56
      Width = 54
      Height = 13
      Caption = 'Finalidade :'
    end
    object Label6: TLabel
      Left = 2
      Top = 35
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = 'CFOP Padr'#227'o :'
    end
    object edtFirstDate: TcxDateEdit
      Left = 76
      Top = 4
      Width = 101
      Height = 21
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 0
    end
    object edtLastDate: TcxDateEdit
      Left = 200
      Top = 4
      Width = 101
      Height = 21
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
    end
    object btnGo: TcxButton
      Left = 602
      Top = 16
      Width = 49
      Height = 45
      Anchors = [akTop, akRight]
      Caption = 'GO!'
      TabOrder = 6
      OnClick = btnGoClick
    end
    object cbxConvenio: TcxComboBox
      Left = 404
      Top = 4
      Width = 181
      Height = 21
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        '3-CONVENIO nr. 69/02')
      TabOrder = 3
    end
    object cbxNatOperacao: TcxComboBox
      Left = 404
      Top = 28
      Width = 181
      Height = 21
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        '1-INTERESTADUAIS OP. SUBST. TRIBUTARIA'
        '2-INTERESTADUAIS OP. COM OU SEM S.TRIB.'
        '3-TOTALIDADE DAS OPERACOES DO INFORMANTE')
      TabOrder = 4
    end
    object cbxFinalidade: TcxComboBox
      Left = 404
      Top = 52
      Width = 181
      Height = 21
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        '1-NORMAL'
        '2-RETIFICACAO TOTAL DO ARQUIVO'
        '3-RETIFICACAO ADITIVA DE ARQUIVO'
        '4-RETIFICACAO CORRETIVA DE ARQUIVO'
        '5-DESFAZIMENTO')
      TabOrder = 5
    end
    object edtCFOP: TcxTextEdit
      Left = 77
      Top = 31
      Width = 100
      Height = 21
      Properties.MaxLength = 4
      TabOrder = 2
      Text = '5929'
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 77
    Width = 671
    Height = 234
    ActivePage = TabSheet
    Align = alClient
    TabOrder = 2
    object TabSheet: TTabSheet
      Caption = '  Compras  '
      object grdPurchase: TcxGrid
        Left = 0
        Top = 0
        Width = 663
        Height = 206
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
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
          object grdPurchaseDBTableViewCodFornecedor: TcxGridDBColumn
            DataBinding.FieldName = 'CodFornecedor'
          end
          object grdPurchaseDBTableViewCodProduto: TcxGridDBColumn
            DataBinding.FieldName = 'CodProduto'
          end
          object grdPurchaseDBTableViewQtd: TcxGridDBColumn
            DataBinding.FieldName = 'Qtd'
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
          object grdPurchaseDBTableViewTipo: TcxGridDBColumn
            DataBinding.FieldName = 'Tipo'
          end
          object grdPurchaseDBTableViewNotaFiscal: TcxGridDBColumn
            DataBinding.FieldName = 'NotaFiscal'
          end
          object grdPurchaseDBTableViewDataRegistro: TcxGridDBColumn
            DataBinding.FieldName = 'DataRegistro'
          end
          object grdPurchaseDBTableViewDataFatura: TcxGridDBColumn
            DataBinding.FieldName = 'DataFatura'
          end
          object grdPurchaseDBTableViewCFOP: TcxGridDBColumn
            DataBinding.FieldName = 'CFOP'
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
          object grdPurchaseDBTableViewUF: TcxGridDBColumn
            DataBinding.FieldName = 'UF'
          end
          object grdPurchaseDBTableViewFornecedor: TcxGridDBColumn
            DataBinding.FieldName = 'Fornecedor'
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
    end
    object TabSheet1: TTabSheet
      Caption = '  NF Vendas  '
      ImageIndex = 1
      object grdSale: TcxGrid
        Left = 0
        Top = 0
        Width = 663
        Height = 206
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
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
          object grdSaleDBTableViewCodFornecedor: TcxGridDBColumn
            DataBinding.FieldName = 'CodFornecedor'
          end
          object grdSaleDBTableViewCFOP: TcxGridDBColumn
            DataBinding.FieldName = 'CFOP'
          end
          object grdSaleDBTableViewCodProduto: TcxGridDBColumn
            DataBinding.FieldName = 'CodProduto'
          end
          object grdSaleDBTableViewQtd: TcxGridDBColumn
            DataBinding.FieldName = 'Qtd'
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
          object grdSaleDBTableViewNotaFiscal: TcxGridDBColumn
            DataBinding.FieldName = 'NotaFiscal'
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
          object grdSaleDBTableViewUF: TcxGridDBColumn
            DataBinding.FieldName = 'UF'
          end
          object grdSaleDBTableViewCliente: TcxGridDBColumn
            DataBinding.FieldName = 'Cliente'
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
    end
    object TabSheet2: TTabSheet
      Caption = '  ECF  Totalizadores  '
      ImageIndex = 2
      object grdReducaoZ: TcxGrid
        Left = 0
        Top = 0
        Width = 663
        Height = 206
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdReducaoZTableView: TcxGridDBTableView
          DataController.DataSource = dsReducaoZ
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object grdReducaoZTableViewNumeroECF: TcxGridDBColumn
            DataBinding.FieldName = 'NumeroECF'
          end
          object grdReducaoZTableViewNumeroSerie: TcxGridDBColumn
            DataBinding.FieldName = 'NumeroSerie'
          end
          object grdReducaoZTableViewIDReducaoZ: TcxGridDBColumn
            DataBinding.FieldName = 'IDReducaoZ'
          end
          object grdReducaoZTableViewMovDate: TcxGridDBColumn
            DataBinding.FieldName = 'MovDate'
          end
          object grdReducaoZTableViewNumReducaoZ: TcxGridDBColumn
            Caption = 'ReducaoZ'
            DataBinding.FieldName = 'NumReducaoZ'
          end
          object grdReducaoZTableViewCOOInicial: TcxGridDBColumn
            DataBinding.FieldName = 'COOInicial'
          end
          object grdReducaoZTableViewCOOFinal: TcxGridDBColumn
            DataBinding.FieldName = 'COOFinal'
          end
          object grdReducaoZTableViewNumCancelamentos: TcxGridDBColumn
            DataBinding.FieldName = 'NumCancelamentos'
          end
          object grdReducaoZTableViewValCancelamentos: TcxGridDBColumn
            DataBinding.FieldName = 'ValCancelamentos'
          end
          object grdReducaoZTableViewValDescontos: TcxGridDBColumn
            DataBinding.FieldName = 'ValDescontos'
          end
          object grdReducaoZTableViewGTInicial: TcxGridDBColumn
            DataBinding.FieldName = 'GTInicial'
          end
          object grdReducaoZTableViewGTFinal: TcxGridDBColumn
            DataBinding.FieldName = 'GTFinal'
          end
          object grdReducaoZTableViewSubstituicaoTrib: TcxGridDBColumn
            DataBinding.FieldName = 'SubstituicaoTrib'
          end
          object grdReducaoZTableViewIsencao: TcxGridDBColumn
            DataBinding.FieldName = 'Isencao'
          end
          object grdReducaoZTableViewNaoTributavel: TcxGridDBColumn
            DataBinding.FieldName = 'NaoTributavel'
          end
        end
        object grdReducaoZLevel: TcxGridLevel
          GridView = grdReducaoZTableView
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = '  Produtos  '
      ImageIndex = 3
      object grdProduto: TcxGrid
        Left = 0
        Top = 0
        Width = 663
        Height = 206
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfFlat
        object grdProdutoDBTV: TcxGridDBTableView
          DataController.DataSource = ds60R
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
          object grdProdutoDBTVCodigoProduto: TcxGridDBColumn
            DataBinding.FieldName = 'CodigoProduto'
          end
          object grdProdutoDBTVProduto: TcxGridDBColumn
            DataBinding.FieldName = 'Produto'
          end
          object grdProdutoDBTVQuantidade: TcxGridDBColumn
            DataBinding.FieldName = 'Quantidade'
          end
          object grdProdutoDBTVValorTotal: TcxGridDBColumn
            DataBinding.FieldName = 'ValorTotal'
          end
          object grdProdutoDBTVPercImposto: TcxGridDBColumn
            DataBinding.FieldName = 'PercImposto'
          end
          object grdProdutoDBTVUnidade: TcxGridDBColumn
            DataBinding.FieldName = 'Unidade'
          end
          object grdProdutoDBTVCF: TcxGridDBColumn
            DataBinding.FieldName = 'CF'
          end
        end
        object grdProdutoLevel: TcxGridLevel
          GridView = grdProdutoDBTV
        end
      end
    end
  end
  object dsPurchase: TDataSource
    DataSet = DMSintegra.quPurchase
    Left = 336
    Top = 132
  end
  object dsSale: TDataSource
    DataSet = DMSintegra.quSale
    Left = 264
    Top = 180
  end
  object ds60R: TDataSource
    DataSet = DMSintegra.qu60R
    Left = 336
    Top = 180
  end
  object dsReducaoZ: TDataSource
    DataSet = DMSintegra.cdsReducaoZ
    Left = 264
    Top = 132
  end
end
