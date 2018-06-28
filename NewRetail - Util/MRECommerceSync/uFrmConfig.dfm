object FrmConfig: TFrmConfig
  Left = 497
  Top = 209
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#227'o'
  ClientHeight = 392
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgOption: TPageControl
    Left = 0
    Top = 0
    Width = 456
    Height = 352
    ActivePage = tsMainRetail
    Align = alClient
    TabOrder = 1
    object tsLogin: TTabSheet
      Caption = '  E-commerce  '
      ImageIndex = 2
      object lbUser: TLabel
        Left = 55
        Top = 35
        Width = 42
        Height = 13
        Alignment = taRightJustify
        Caption = 'Usu'#225'rio :'
      end
      object Label3: TLabel
        Left = 60
        Top = 65
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Senha :'
      end
      object lbURL: TLabel
        Left = 70
        Top = 95
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'URL :'
      end
      object lbResult: TLabel
        Left = 185
        Top = 115
        Width = 246
        Height = 38
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object lblImportarPedido: TLabel
        Left = 50
        Top = 198
        Width = 84
        Height = 13
        Caption = 'Importar pedidos :'
      end
      object lblEstoque: TLabel
        Left = 90
        Top = 228
        Width = 45
        Height = 13
        Caption = 'Estoque :'
      end
      object Label4: TLabel
        Left = 5
        Top = 283
        Width = 132
        Height = 13
        Caption = 'Categorias do e-plataforma :'
      end
      object edtUser: TEdit
        Left = 100
        Top = 30
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object edtPW: TEdit
        Left = 100
        Top = 60
        Width = 121
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
      end
      object edtURL: TEdit
        Left = 100
        Top = 90
        Width = 330
        Height = 21
        TabOrder = 2
      end
      object btnConectar: TButton
        Left = 100
        Top = 120
        Width = 75
        Height = 25
        Caption = 'Conectar'
        TabOrder = 3
        OnClick = btnConectarClick
      end
      object cbxStatusPedido: TComboBox
        Left = 140
        Top = 193
        Width = 221
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Aguardando An'#225'lise de Fraude'
        Items.Strings = (
          'Aguardando An'#225'lise de Fraude'
          'Aguardando Estoque F'#237'sico'
          'Analise Manual de Fraude'
          'Cancelado'
          'Cancelado Manualmente'
          'Cr'#233'dito Aprovado'
          'Entregue Transportadora'
          'Enviado Pagamento'
          'Pagamento n'#227'o Aprovado'
          'Pedido Entregue com Sucesso'
          'Pendente'
          'Rejeitado no Fraude (*)'
          'Recebimento de Insucesso de Entrega ')
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 448
        Height = 21
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '   Conex'#227'o'
        Color = clBackground
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
      end
      object Panel2: TPanel
        Left = 0
        Top = 158
        Width = 448
        Height = 21
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '   Setup'
        Color = clBackground
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
      end
      object cbxEstoque: TComboBox
        Left = 140
        Top = 223
        Width = 221
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 5
      end
      object chkExportarDepartamento: TCheckBox
        Left = 375
        Top = 188
        Width = 36
        Height = 17
        Caption = 'Exportar departamento como categoria'
        TabOrder = 6
        Visible = False
        OnClick = chkImportacaoAutoClick
      end
      object chkProdutosCategoria: TCheckBox
        Left = 140
        Top = 252
        Width = 266
        Height = 17
        Caption = 'Enviar todos os produtos para uma '#250'nica categoria.'
        TabOrder = 9
        OnClick = chkProdutosCategoriaClick
      end
      object cbxCategoriaEPlataforma: TComboBox
        Left = 141
        Top = 278
        Width = 221
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 10
      end
    end
    object tsMainRetail: TTabSheet
      Caption = '  MainRetail  '
      object PGMainRetail: TPageControl
        Left = 0
        Top = 0
        Width = 448
        Height = 324
        ActivePage = tsConfig
        Align = alClient
        TabOrder = 0
        object tsConfig: TTabSheet
          Caption = 'Setup'
          object Label1: TLabel
            Left = 66
            Top = 88
            Width = 95
            Height = 13
            Alignment = taRightJustify
            Caption = 'Caixa Registradora :'
          end
          object ldDefStore: TLabel
            Left = 136
            Top = 23
            Width = 26
            Height = 13
            Alignment = taRightJustify
            Caption = 'Loja :'
          end
          object Label2: TLabel
            Left = 58
            Top = 124
            Width = 104
            Height = 13
            Alignment = taRightJustify
            Caption = 'Usuario para vendas :'
          end
          object lblMidia: TLabel
            Left = 69
            Top = 160
            Width = 93
            Height = 13
            Alignment = taRightJustify
            Caption = 'Midia para vendas :'
          end
          object lblFrete: TLabel
            Left = 43
            Top = 196
            Width = 119
            Height = 13
            Alignment = taRightJustify
            Caption = 'Outros custos para frete :'
          end
          object lblTipoPessoa: TLabel
            Left = 57
            Top = 232
            Width = 105
            Height = 13
            Alignment = taRightJustify
            Caption = 'Categoria de clientes :'
          end
          object Label5: TLabel
            Left = 93
            Top = 55
            Width = 68
            Height = 13
            Caption = 'Loja Estoque :'
          end
          object scCashReg: TSuperComboADO
            Left = 168
            Top = 83
            Width = 136
            Height = 21
            TabOrder = 1
            LookUpSource = DM.dsLookUpCashReg
            DropDownRows = 18
            ShowBtnAddNew = False
            ShowBtnUpdate = False
            IDLanguage = 0
          end
          object scDefaultSaleStore: TSuperComboADO
            Left = 168
            Top = 19
            Width = 136
            Height = 21
            TabOrder = 0
            LookUpSource = DM.dsLookUpStore
            DropDownRows = 18
            ShowBtnAddNew = False
            ShowBtnUpdate = False
            IDLanguage = 0
          end
          object scUser: TSuperComboADO
            Left = 168
            Top = 120
            Width = 136
            Height = 21
            TabOrder = 2
            LookUpSource = DM.dsLookUpUser
            DropDownRows = 18
            ShowBtnAddNew = False
            ShowBtnUpdate = False
            IDLanguage = 0
          end
          object scMedia: TSuperComboADO
            Left = 168
            Top = 156
            Width = 136
            Height = 21
            TabOrder = 3
            LookUpSource = DM.dsLookUpMedia
            DropDownRows = 18
            ShowBtnAddNew = False
            ShowBtnUpdate = False
            IDLanguage = 0
          end
          object scFreight: TSuperComboADO
            Left = 168
            Top = 192
            Width = 136
            Height = 21
            TabOrder = 4
            LookUpSource = DM.dsLookUpOtherCosts
            DropDownRows = 18
            ShowBtnAddNew = False
            ShowBtnUpdate = False
            IDLanguage = 0
          end
          object scPersonType: TSuperComboADO
            Left = 168
            Top = 228
            Width = 136
            Height = 21
            TabOrder = 5
            LookUpSource = DM.dsLookUpPersonType
            DropDownRows = 18
            ShowBtnAddNew = False
            ShowBtnUpdate = False
            IDLanguage = 0
          end
          object scInventoryStore: TSuperComboADO
            Left = 169
            Top = 51
            Width = 136
            Height = 21
            TabOrder = 6
            LookUpSource = DM.dsLookUpStore
            DropDownRows = 18
            ShowBtnAddNew = False
            ShowBtnUpdate = False
            IDLanguage = 0
          end
        end
        object tsPayments: TTabSheet
          Caption = 'Formas Pgto'
          ImageIndex = 1
          object sgColumns: TStringGrid
            Left = 0
            Top = 0
            Width = 440
            Height = 296
            Align = alClient
            ColCount = 2
            DefaultRowHeight = 20
            FixedCols = 0
            RowCount = 3
            TabOrder = 0
            OnSelectCell = sgColumnsSelectCell
            ColWidths = (
              201
              217)
          end
          object cbColumns: TComboBox
            Left = 192
            Top = 102
            Width = 145
            Height = 21
            ItemHeight = 0
            TabOrder = 1
            Visible = False
            OnChange = cbColumnsChange
            OnExit = cbColumnsExit
          end
        end
      end
    end
    object tsHorario: TTabSheet
      Caption = '  Hor'#225'rio  '
      ImageIndex = 2
      object lblDiasImportacao: TLabel
        Left = 80
        Top = 40
        Width = 186
        Height = 13
        Caption = 'Importar os                     dias anteriores.'
      end
      object lblDiasExportacao: TLabel
        Left = 80
        Top = 195
        Width = 187
        Height = 13
        Caption = 'Exportar os                     dias anteriores.'
      end
      object chkExportacaoAuto: TCheckBox
        Left = 80
        Top = 225
        Width = 266
        Height = 17
        Caption = 'Exporta'#231#227'o autom'#225'tica a cada                     minutos'
        TabOrder = 6
        OnClick = chkExportacaoAutoClick
      end
      object edtMinExportacao: TdxSpinEdit
        Left = 250
        Top = 220
        Width = 51
        TabOrder = 7
      end
      object chkImportacaoAuto: TCheckBox
        Left = 80
        Top = 75
        Width = 266
        Height = 17
        Caption = 'Importa'#231#227'o autom'#225'tica a cada                     minutos'
        TabOrder = 1
        OnClick = chkImportacaoAutoClick
      end
      object edtMinImportacao: TdxSpinEdit
        Left = 250
        Top = 70
        Width = 51
        TabOrder = 2
      end
      object pnlImportacao: TPanel
        Left = 0
        Top = 0
        Width = 448
        Height = 21
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '   Importa'#231#227'o'
        Color = clBackground
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
      end
      object pnlExportacao: TPanel
        Left = 0
        Top = 161
        Width = 448
        Height = 21
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '   Exporta'#231#227'o'
        Color = clBackground
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
      end
      object edtDiasImportacao: TdxSpinEdit
        Left = 140
        Top = 35
        Width = 51
        TabOrder = 0
      end
      object edtDiasExportacao: TdxSpinEdit
        Left = 140
        Top = 190
        Width = 51
        TabOrder = 5
      end
      object chkImpCliente: TCheckBox
        Left = 80
        Top = 105
        Width = 266
        Height = 17
        Caption = 'Importar cliente automaticamente'
        TabOrder = 3
        OnClick = chkImportacaoAutoClick
      end
      object chkImpPedido: TCheckBox
        Left = 80
        Top = 135
        Width = 266
        Height = 17
        Caption = 'Importar pedido automaticamente'
        TabOrder = 4
        OnClick = chkImportacaoAutoClick
      end
      object chkExpFabricante: TCheckBox
        Left = 80
        Top = 250
        Width = 266
        Height = 17
        Caption = 'Exportar fabricante automaticamente'
        TabOrder = 8
        OnClick = chkExportacaoAutoClick
      end
      object chkExpEstoque: TCheckBox
        Left = 80
        Top = 275
        Width = 266
        Height = 17
        Caption = 'Exportar estoque automaticamente'
        TabOrder = 9
        OnClick = chkExportacaoAutoClick
      end
      object chkExpQuantidade: TCheckBox
        Left = 80
        Top = 300
        Width = 266
        Height = 17
        Caption = 'Exportar quantidade automaticamente'
        TabOrder = 10
        OnClick = chkExportacaoAutoClick
      end
    end
  end
  object pnlComple: TPanel
    Left = 0
    Top = 352
    Width = 456
    Height = 40
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      456
      40)
    object btnClose: TButton
      Left = 370
      Top = 10
      Width = 80
      Height = 23
      Anchors = [akTop, akRight]
      Caption = '&Salvar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnCancelar: TButton
      Left = 285
      Top = 10
      Width = 80
      Height = 23
      Anchors = [akTop, akRight]
      Caption = '&Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
end
