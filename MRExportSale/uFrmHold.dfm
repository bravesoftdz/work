object FrmHold: TFrmHold
  Left = 149
  Top = 22
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Exportar Pedidos'
  ClientHeight = 609
  ClientWidth = 772
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
  object pnlClient: TPanel
    Left = 0
    Top = 375
    Width = 772
    Height = 234
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 2
    object lblTransportador: TLabel
      Left = 12
      Top = 40
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Transportador :'
    end
    object Label2: TLabel
      Left = 32
      Top = 68
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Endere'#231'o :'
    end
    object Label10: TLabel
      Left = 352
      Top = 68
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bairro :'
    end
    object Label11: TLabel
      Left = 564
      Top = 68
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'CEP :'
    end
    object Label12: TLabel
      Left = 352
      Top = 96
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'CNPJ :'
    end
    object Label13: TLabel
      Left = 28
      Top = 96
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Munic'#237'pio :'
    end
    object Label14: TLabel
      Left = 284
      Top = 96
      Width = 20
      Height = 13
      Alignment = taRightJustify
      Caption = 'UF :'
    end
    object Label15: TLabel
      Left = 516
      Top = 96
      Width = 73
      Height = 13
      Alignment = taRightJustify
      Caption = 'Insc. Estadual :'
    end
    object Label16: TLabel
      Left = 500
      Top = 36
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'Frete por conta de :'
    end
    object Label17: TLabel
      Left = 623
      Top = 36
      Width = 130
      Height = 13
      Alignment = taRightJustify
      Caption = '(1=emitente; 2=destinat'#225'rio)'
    end
    object Label18: TLabel
      Left = 16
      Top = 12
      Width = 124
      Height = 20
      Caption = 'Transportadora'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 16
      Top = 124
      Width = 95
      Height = 20
      Caption = 'Embalagem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label20: TLabel
      Left = 23
      Top = 208
      Width = 61
      Height = 13
      Alignment = taRightJustify
      Caption = 'Quantidade :'
    end
    object Label21: TLabel
      Left = 40
      Top = 180
      Width = 44
      Height = 13
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie :'
    end
    object Label22: TLabel
      Left = 44
      Top = 152
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = 'Marca :'
    end
    object Label23: TLabel
      Left = 253
      Top = 152
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'N'#250'mero :'
    end
    object Label24: TLabel
      Left = 239
      Top = 208
      Width = 57
      Height = 13
      Alignment = taRightJustify
      Caption = 'Peso bruto :'
    end
    object Label25: TLabel
      Left = 235
      Top = 180
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Peso l'#237'quido :'
    end
    object Label26: TLabel
      Left = 402
      Top = 152
      Width = 54
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor frete :'
    end
    object Label27: TLabel
      Left = 391
      Top = 180
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor seguro :'
    end
    object Label28: TLabel
      Left = 385
      Top = 207
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = 'Outros custos :'
    end
    object Bevel4: TBevel
      Left = 24
      Top = 1
      Width = 721
      Height = 4
      Shape = bsTopLine
    end
    object edtEnderecoTrans: TcxTextEdit
      Left = 88
      Top = 64
      Width = 249
      Height = 21
      TabOrder = 2
    end
    object edtBairroTrans: TcxTextEdit
      Left = 388
      Top = 64
      Width = 117
      Height = 21
      TabOrder = 3
    end
    object edtCEPTrans: TcxTextEdit
      Left = 596
      Top = 64
      Width = 69
      Height = 21
      TabOrder = 4
    end
    object edtCNPJTrans: TcxTextEdit
      Left = 388
      Top = 92
      Width = 117
      Height = 21
      TabOrder = 7
    end
    object edtMunicipioTrans: TcxTextEdit
      Left = 88
      Top = 92
      Width = 137
      Height = 21
      TabOrder = 5
    end
    object edtUFTrans: TcxTextEdit
      Left = 308
      Top = 92
      Width = 29
      Height = 21
      TabOrder = 6
    end
    object edtFreteTrans: TcxTextEdit
      Left = 596
      Top = 32
      Width = 25
      Height = 21
      TabOrder = 1
      Text = '1'
    end
    object edtInscEstTrans: TcxTextEdit
      Left = 596
      Top = 92
      Width = 69
      Height = 21
      TabOrder = 8
    end
    object edtEspecieEmb: TcxTextEdit
      Left = 88
      Top = 176
      Width = 97
      Height = 21
      TabOrder = 11
    end
    object edtMarcaEmb: TcxTextEdit
      Left = 88
      Top = 148
      Width = 141
      Height = 21
      TabOrder = 9
    end
    object edtNumeroEmb: TcxTextEdit
      Left = 300
      Top = 148
      Width = 57
      Height = 21
      TabOrder = 10
    end
    object edtFreteEmb: TcxCalcEdit
      Left = 460
      Top = 148
      Width = 89
      Height = 21
      EditValue = 0c
      TabOrder = 15
    end
    object edtSeguroEmb: TcxCalcEdit
      Left = 460
      Top = 176
      Width = 89
      Height = 21
      EditValue = 0c
      TabOrder = 16
    end
    object edtOutrosCustosEmb: TcxCalcEdit
      Left = 460
      Top = 204
      Width = 89
      Height = 21
      EditValue = 0c
      TabOrder = 17
    end
    object edtPesoLiqEmb: TcxSpinEdit
      Left = 300
      Top = 176
      Width = 57
      Height = 21
      Properties.ValueType = vtFloat
      TabOrder = 13
    end
    object edtPesoBrutoEmb: TcxSpinEdit
      Left = 300
      Top = 204
      Width = 57
      Height = 21
      Properties.ValueType = vtFloat
      TabOrder = 14
    end
    object edtQtdEmb: TcxSpinEdit
      Left = 88
      Top = 204
      Width = 41
      Height = 21
      Properties.ValueType = vtFloat
      TabOrder = 12
    end
    object cbxTransp: TcxLookupComboBox
      Left = 88
      Top = 36
      Width = 249
      Height = 21
      Properties.KeyFieldNames = 'IDPessoa'
      Properties.ListColumns = <
        item
          FieldName = 'Pessoa'
        end>
      Properties.ListOptions.GridLines = glNone
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsTransp
      Properties.OnEditValueChanged = cbxTranspPropertiesEditValueChanged
      TabOrder = 0
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 173
    Width = 772
    Height = 202
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    DesignSize = (
      772
      202)
    object Bevel1: TBevel
      Left = 567
      Top = 147
      Width = 177
      Height = 73
      Shape = bsFrame
      Style = bsRaised
    end
    object lbOtherExpenses: TLabel
      Left = 491
      Top = 169
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = 'Outros custos :'
    end
    object edtOtherCosts: TDBText
      Left = 605
      Top = 168
      Width = 136
      Height = 17
      Alignment = taRightJustify
      Color = 14671839
      DataField = 'OutrosCustos'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbDiscount: TLabel
      Left = 510
      Top = 188
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Desconto :'
    end
    object edtDiscount: TDBText
      Left = 605
      Top = 186
      Width = 136
      Height = 17
      Alignment = taRightJustify
      Color = 14671839
      DataField = 'ValorDesconto'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbSubTotal: TLabel
      Left = 513
      Top = 151
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'SubTotal :'
    end
    object edtSubTotal: TDBText
      Left = 605
      Top = 150
      Width = 136
      Height = 17
      Alignment = taRightJustify
      Color = 14671839
      DataField = 'SubTotal'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object lbInvoiceTotal: TLabel
      Left = 493
      Top = 207
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'Total da nota :'
    end
    object DBText1: TDBText
      Left = 605
      Top = 204
      Width = 136
      Height = 17
      Alignment = taRightJustify
      Color = 14671839
      DataField = 'Total'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Bevel5: TBevel
      Left = 569
      Top = 201
      Width = 174
      Height = 5
      Shape = bsTopLine
    end
    object Bevel2: TBevel
      Left = 569
      Top = 183
      Width = 174
      Height = 4
      Shape = bsTopLine
    end
    object Bevel3: TBevel
      Left = 569
      Top = 165
      Width = 174
      Height = 4
      Shape = bsTopLine
    end
    object grdItems: TcxGrid
      Left = 24
      Top = 4
      Width = 720
      Height = 145
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      BevelKind = bkTile
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object grdItemsDB: TcxGridDBTableView
        DataController.DataSource = dsPedidoItem
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDPreInventoryMov'
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
        object grdItemsDBIDPreInventoryMov: TcxGridDBColumn
          DataBinding.FieldName = 'IDPreInventoryMov'
          Visible = False
        end
        object grdItemsDBQtd: TcxGridDBColumn
          DataBinding.FieldName = 'Qtd'
          Width = 36
        end
        object grdItemsDBModelo: TcxGridDBColumn
          DataBinding.FieldName = 'Modelo'
          Width = 101
        end
        object grdItemsDBDescricao: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'Descricao'
          Width = 200
        end
        object grdItemsDBPrecoVenda: TcxGridDBColumn
          Caption = 'Pre'#231'o Venda'
          DataBinding.FieldName = 'PrecoVenda'
          Width = 74
        end
        object grdItemsDBDesconto: TcxGridDBColumn
          Caption = 'Desc'
          DataBinding.FieldName = 'Desconto'
          Width = 61
        end
        object grdItemsDBVendedor: TcxGridDBColumn
          DataBinding.FieldName = 'Vendedor'
          Width = 145
        end
        object grdItemsDBUnidade: TcxGridDBColumn
          DataBinding.FieldName = 'Unidade'
          Visible = False
        end
        object grdItemsDBTotal: TcxGridDBColumn
          DataBinding.FieldName = 'Total'
          Width = 99
        end
      end
      object grdItemsLevel: TcxGridLevel
        GridView = grdItemsDB
      end
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 61
    Width = 772
    Height = 112
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object lbDate: TLabel
      Left = 622
      Top = 28
      Width = 35
      Height = 16
      Alignment = taRightJustify
      Caption = 'Data :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lbHoldNum: TLabel
      Left = 592
      Top = 8
      Width = 65
      Height = 16
      Alignment = taRightJustify
      Caption = 'Pedido n'#186' :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPedido: TDBText
      Left = 665
      Top = 8
      Width = 68
      Height = 16
      AutoSize = True
      DataField = 'SaleCode'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDataPedido: TDBText
      Left = 663
      Top = 28
      Width = 101
      Height = 16
      AutoSize = True
      DataField = 'PreSaleDate'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 28
      Top = 28
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Endere'#231'o :'
    end
    object Label3: TLabel
      Left = 47
      Top = 48
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bairro :'
    end
    object Label4: TLabel
      Left = 47
      Top = 88
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'CNPJ :'
    end
    object Label5: TLabel
      Left = 27
      Top = 68
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Munic'#237'pio :'
    end
    object Label6: TLabel
      Left = 298
      Top = 48
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'CEP :'
    end
    object Label7: TLabel
      Left = 252
      Top = 88
      Width = 73
      Height = 13
      Alignment = taRightJustify
      Caption = 'Insc. Estadual :'
    end
    object Label8: TLabel
      Left = 305
      Top = 68
      Width = 20
      Height = 13
      Alignment = taRightJustify
      Caption = 'UF :'
    end
    object Label9: TLabel
      Left = 438
      Top = 48
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tel\Fax :'
    end
    object lblCliente: TDBText
      Left = 16
      Top = 8
      Width = 66
      Height = 16
      AutoSize = True
      DataField = 'Cliente'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEndereco: TDBText
      Left = 87
      Top = 28
      Width = 68
      Height = 13
      AutoSize = True
      DataField = 'Endereco'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblBairro: TDBText
      Left = 87
      Top = 48
      Width = 47
      Height = 13
      AutoSize = True
      DataField = 'Bairro'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCEP: TDBText
      Left = 332
      Top = 48
      Width = 38
      Height = 13
      AutoSize = True
      DataField = 'CEP'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTel: TDBText
      Left = 488
      Top = 48
      Width = 32
      Height = 13
      AutoSize = True
      DataField = 'Telefone'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMunicipio: TDBText
      Left = 87
      Top = 68
      Width = 68
      Height = 13
      AutoSize = True
      DataField = 'Cidade'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblUF: TDBText
      Left = 332
      Top = 68
      Width = 30
      Height = 13
      AutoSize = True
      DataField = 'UF'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblInscEstadual: TDBText
      Left = 332
      Top = 88
      Width = 87
      Height = 13
      AutoSize = True
      DataField = 'InscEstadual'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel6: TBevel
      Left = 587
      Top = 48
      Width = 179
      Height = 4
      Shape = bsTopLine
    end
    object lblDocumento: TDBText
      Left = 87
      Top = 88
      Width = 78
      Height = 13
      AutoSize = True
      DataField = 'Documento'
      DataSource = dsPedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlButton: TPanel
    Left = 0
    Top = 0
    Width = 772
    Height = 61
    Align = alTop
    BevelOuter = bvNone
    Color = 14475748
    TabOrder = 3
    object btnProcurar: TSpeedButton
      Left = 3
      Top = 1
      Width = 65
      Height = 57
      Caption = '&Procurar'
      Flat = True
      Glyph.Data = {
        36050000424D3605000000000000360000002800000015000000140000000100
        18000000000000050000130B0000130B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        FF00FFFF00FF8695A1427AA5858895C8C4C5FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        FF00FFFF00FF83B1D342A3F1357FB57A818FC0BDBDFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FF
        C88847C78849B3804B739CB53F9FEA367EB3838087A77C55C88746C98745C887
        44C88745C88747C98746C98745C98845C98541FF00FFFF00FF00FF00FFB78A5D
        D8D1C4DBE9EFDAE8EECADCE779BDEE42A4F1377EB2808793C8D5DAC4CFD4B5BA
        BEB7BBC0C0CCD1D4E2E8DAE8EEDBE9EFD6C2A8C2986EFF00FF00FF00FFB78A5D
        D8D1C4CFDEE3C2D1D6C1D0D6ABC3D06FB5E753A1DC758390A49D9DB3A099BDB0
        A1C5B9ADB5A4A0A0A0A3B6C4C9D1DFE5D6C2A8C2986DFF00FF00FF00FFB78A5D
        D8D1C4DBE9EFDBE9EFDBE9EFDAE8EECCDEE8B5CAD5B0A2A1DEC7B3F0ECCEF2F6
        DAF2F7E1F0F4E5CEC0BCA6A3A4D3E0E6D6C2A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D3E2E7CBDADFCBDADFCBDADFCBDADFBDC4C8CFBBADECE6C7ECEBCBEDF2
        DAEDF2E5EDF2EFE9ECE8B5A79FBDC6CAD5C1A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D4E2E8CDDBE1CDDBE1CDDBE1CCDBE0BCBBBAE3D7C0EDE0C0EDEACBEDF2
        DBEEF3E7EEF2ECEEF3E2D5CCBAACADAFD4C0A7C2976CFF00FF00FF00FFB78A5D
        D8D1C4D7E5EBD4E2E8D4E2E8D4E2E8D3E1E7C4BFBCEAE1C8EFDCBCEFE8C8EFF3
        D7F0F5DFF0F5E2EFF5DDDED7C1AEABABD4C0A7C2976CFF00FF00FF00FFB78A5D
        D8D1C4D0DFE4C5D4D9C5D4D9C5D4D9C5D4D9BDBEBEE1D9C2EADFC4EADEBEEAE6
        C6EAECCEEBEDD0EAECCDD2C2AEBABCBED5C1A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D9E7EDD7E5EBD7E5EBD7E5EBD7E5EBCDD5DAD5CCBFF0F2EDF0ECDAF0E2
        C2F0E4C4F0E7C8ECE4C8C3B0A6CED7DCD6C2A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D0DFE4C4D3D8C4D3D8C4D3D8C4D3D8C2D1D6BABDC0D6D0CBE8E7D6EAE4
        C7EAE0C2E7DCBFCCB8AAB6B8BAD0DEE4D6C2A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D9E7EDD7E5EBD7E5EBD7E5EBD7E5EBD7E5EBD6E4EACCD0D4C6BCB9D2C3
        B6D8CABDCBC1BECED4D8D6E4EAD9E7EDD6C2A8C2976CFF00FF00FF00FFB78A5D
        D8D1C4D1DFE5C5D4DAC5D4DAC5D4DAC5D4DAC5D4DAC5D4DAC5D4D9C2D1D6BDC9
        CEBFCCD1C3D2D7C5D4DAC5D4DAD3E1E7D6C2A8C3976DFF00FF00FF00FFB78A5C
        D7CBB8D8DFDED6DDDCD6DDDCD6DDDCD6DDDCD6DDDCD6DDDCD6DDDCD6DDDCD6DD
        DCD6DDDCD6DDDCD6DDDCD6DDDCD8DFDED5BC9EC29A71FF00FF00FF00FFB8834E
        D38B41CF8D49CF8D49CF8D49CF8D49CF8D49CF8D49CF8D49CF8D49CF8D49CF8D
        49CF8D49CF8D49CF8D49CF8D49CF8D49CF8234C2986DFF00FF00FF00FFBF8952
        EB8A26E07A17DA7410DA7410DA7410DA7410DA7410DA7410DA7410DA7410DA74
        10DA7410DA7410DA7410DA7410D46E0ACC6702C49D76FF00FF00FF00FFFF00FF
        D47B22D7720FD6700DD6700DD6700DD6700DD6700DD6700DD6700DD6700DD670
        0DD6700DD6700DD6700DD6700DD36E0AC9731DFF00FFFF00FF00FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00}
      Layout = blGlyphTop
      Spacing = 5
      OnClick = btnProcurarClick
    end
    object btnImprimir: TSpeedButton
      Left = 68
      Top = 1
      Width = 65
      Height = 57
      Caption = '&Imprimir'
      Enabled = False
      Flat = True
      Glyph.Data = {
        A2070000424DA207000000000000360000002800000019000000190000000100
        1800000000006C070000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C7C69C96949C9694FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECBCEBDBA
        BDDEDBDEDEDFDEADAEADB5B2B59C9694BD8E84A58E84ADAEADFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFBDBABDCECFCEEFEFEFEFEFEFDEDBDEADAEADB5B2B58C8E8C4A4D4A63
        61636361638C8A8C9C9694FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFBDBEBDC6C3C6EFEBEFF7F3F7EFEFEFEFEBEFD6D3D6AD
        AAADADAEAD8C8E8C4A4D4A4241426361636361638486848C8E8CADAEADC6C7C6
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFBDBABDDEDFDEFFFBFFFFF7F7EF
        EFEFEFEBEFE7E3E7D6D3D6ADAAADADAAADADAEADADAEADADAAAD8C8A8C737173
        6361638486848C8E8CB5B2B59C9E9CFFFFFFFFFFFF00FFFFFFFFFFFFBDBABDFF
        FFFFFFFBFFFFF7F7EFEFEFEFEBEFDEDBDEB5B2B58C8E8C8482848C8E8CADAAAD
        ADAEADADAEADB5B2B5BDBABDADAEAD9C9E9C636163525152CECBCEFFFFFFFFFF
        FF00FFFFFFFFFFFFADAEADFFFBFFFFF7F7EFEFEFDEDBDE9C9E9C9C9E9CBDBABD
        C6C7C69C9E9C8C8E8C8482848482848C8E8C9C9E9CB5B2B5BDBABDBDBEBDC6C3
        C6BDBABDC6C7C6FFFFFFFFFFFF00FFFFFFFFFFFFADAAADF7F3F7CECFCE9C9694
        9C9E9CD6D3D6DEDBDED6D3D6D6D3D6CECBCEBDBEBDADAAADADAAAD9C9E9C8C8E
        8C8486848C8A8C9C9E9CBDBABD8CBE8C8CBE8CFFFFFFFFFFFF00FFFFFFFFFFFF
        9C9E9C8C8A8C9C9694DEDBDEDEDFDEDEDBDED6D3D6CECBCEEFEBEFE7E7E7E7E7
        E7EFEBEFDEDBDECECBCEBDBABDADAEADADAEAD9C96948486848482849C9694FF
        FFFFFFFFFF00FFFFFFFFFFFF8C8E8CEFEBEFE7E3E7DEDFDEDEDBDED6D3D6CECF
        CEE7E3E7DEDBDEB5B2B5BDBABDBDBABDBDBEBDCECFCEE7E7E7E7E7E7D6D3D6C6
        C7C6BDBEBDBDBABDADAAADFFFFFFFFFFFF00FFFFFFFFFFFF8C8A8CE7E3E7DEDF
        DEDEDBDED6D3D6CECFCEDEDBDEE7E7E7C6C3C6EFEFEFEFEFEFEFEBEFCECFCEBD
        BEBDBDBABDBDBABDBDBEBDD6D3D6E7E3E7DEDFDED6D3D6FFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFD6D3D6DEDBDED6D3D6CECFCEDEDFDECECFCEC6C3C6F7F3F7F7
        F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEFDEDBDEC6C7C6BDBABDBDBABDBDBABD
        CECBCEFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFE7E7E7ADAEADBDBEBDC6
        C3C6D6D3D6C6C7C6CECBCEE7E7E7F7F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEF
        E7E7E7E7E7E7D6D3D6ADAEADFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFADAAADE7E7E7E7E7E7ADAEADB5B2B5BDBABDBDBABDC6C3C6
        CECBCEDEDBDEE7E7E7E7E7E7EFEBEFCECBCEB5B2B5FFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADAAADFFFBF7FFF3E7EFDBCE
        D6D3D6C6C7C6C6C7C6BDBABDC6C3C6BDBEBDBDAAA5BDAAA5B5B2B5DEDBDEFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFCE9A84FFD7ADFFD7ADFFD7ADFFDFBDFFDFBDFFEBD6F7E3D6EFE7DECEAA
        ADDEDBDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6AA94FFDFBDFFD7ADFFDFBDFFD7ADFFDF
        BDFFD7ADFFDFBDF7D3A5BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3B5FFDF
        BDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDD6B2ADBD9A94FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFDEC7B5FFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEBD
        9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD9A94FFEBD6FFEBD6FFEBD6FFEBD6FF
        EBD6FFEBD6FFEBD6EFDBCEBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDECBC6FF
        F3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7D6B2ADBD9A94FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFD6BEBDFFF7EFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFF7EF
        BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED7D6FFFFFFFFFBFFFFFFFFFFFFFF
        FFFBFFFFFFFFFFFFFFEFEBEFBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFCEBEB5BD9A94
        BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00}
      Layout = blGlyphTop
      Spacing = 3
    end
    object btnExportar: TSpeedButton
      Left = 133
      Top = 1
      Width = 65
      Height = 57
      Caption = '&Exportar'
      Enabled = False
      Flat = True
      Glyph.Data = {
        760C0000424D760C00000000000036000000280000001C0000001C0000000100
        200000000000400C000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F8F8F000E0C8C000D8C0
        B000D0B8A800D8C0B000E0C8C000F0F0E800FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00F0E8E800D8B8A000F0E8D000F8F0D800FFF8E000F8F8D800F0E8D000D8B8
        A000E8D8D000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00F8F8F800D8A89800FFFFE800FFFFE800FFFF
        E800FFF8F800FFF8F800FFFFE000FFF8E000E0B8A000E8D8D000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00C8B8B000E0D8D000D8C8C000C8B8B000D0C8B800D0C8B800D8D0C800E0D8
        D000C8B8B000D0C8C000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00D8C0B000D8B8A000E0B8A000E0C0
        A800F8F0D000E8C0A800E0C0A800E8C8B000C8A89800F0E8E800F0E8E800F8F0
        E800F8F8F800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00D0B0A800F8E0C800FFFFE800FFF0D800C8B0A000FF00
        FF00C8A89000E0C8A800D8C0A800E0A89000F0D0B800E8C0A800E0B09800D8A8
        9000D0A89000C8A08800C0A08800D8C8B800FF00FF00FF00FF00FF00FF00FF00
        FF00C0988000D0B8A000C8B0A000D0B8A800E0C8C000D8C0B000E0D0C800E8C8
        B000FFFFE800FFE8D000E0C8C000C0A08000C0887000F0D8C000E8D8B800F0B8
        A000FFF0D800FFE8D000FFE8D000FFE0C800FFE0C800FFE0C000E0A08800D8C0
        A800FF00FF00FF00FF00FF00FF00FF00FF00C8A89000F8F0D000E8E0D000F0E8
        C800E8E0C800E8E0C800E0D8C000E0D0B800D8C8B000D0B8A000B8907000C8A0
        9000B8706000D0B09800C8B09000E0A89000FFE8D800E0D8A800E8C8B000F8B8
        A800E0C0C000FFD0B800D8A08000D8C0A800FF00FF00FF00FF00FF00FF00FF00
        FF00C8A89000E8E0D000FFA06000F8B06800F8B06800F8B87800E0C08000E0C8
        9000E0C89000E0D0A800F0E8C800E8E0C800E0D8B800E0D0B800E0C0A800C8A0
        8800FFE0C800E8D8B000F0C8B000F0B8A800D0B8B000FFD0B800D8987800D8C0
        A800FF00FF00FF00FF00FF00FF00FF00FF00D0A89000E8E0D000F8B06800FFC8
        8000FFC88000FFC88000FFC88000FFE08800FFE08800FFE08800FFE08800FFE0
        8800FFE08800FFE08800E8D0B000D8A89800E0C8C000E0D0C800B8989000B898
        8800D8C8B800E0C8C000D0887000D0B8A000FF00FF00FF00FF00FF00FF00FF00
        FF00D0A89000E8E0D000F8B06800FFC88000FFC88000FFC88000FFC88000FFD8
        8800FFD88800FFD88800FFE08800FFE08800FFE88800FFF89000E8D0B000D8A8
        9800FFE0C800E8B0A00090383000E0987800D8987800FFE0C000D0887000D0B8
        A000FF00FF00FF00FF00FF00FF00FF00FF00D0A89000E8E0D000F8B06800FFC8
        8000FFC88000FFC88000FFD88800FFD88800FFD88800FFE08800FFE08800FFE8
        9000FFE89000FFF89000E8D0B000D8A89800FFD8C800FFE0C800D0887000C078
        6800F8C8B000FFD8B800D0887000D0B8A000FF00FF00FF00FF00FF00FF00FF00
        FF00D0A89000E8E0D000F8B06800FFC88000FFC88000F8D08000FFD88800FFD8
        8800FFE08800FFE08800FFE89000FFE89000FFE89000FFF89000E8D0B000D8A8
        9800FFD8C000FFE0C800FFE8D000FFE8D000FFE0C000FFD8B800D0887000D0B8
        A000FF00FF00FF00FF00FF00FF00FF00FF00D0A89000E8E0D000F8C07000F8D0
        8000F8D08000FFD88800FFD88800FFE08800FFE08800FFE08800FFE89000FFE8
        9000FFF89000FFFF9800E8D0B000D8A89800FFD8C800F8D0B800F0C0A800E8B0
        9800E8B09800F8C0A800D0886800D0B8A000FF00FF00FF00FF00FF00FF00FF00
        FF00D0A89000E8E0D000F8C07000FFD88800FFD88800FFD88800FFF89000FFF8
        9000FFF89000FFF89000FFF89000FFF89000FFF89000FFF89000E8D0B000D8A8
        9800E0D0C800D0B8B000B8A09800B8989000B8989000C0989800D8987800C8C0
        B000FF00FF00FF00FF00FF00FF00FF00FF00D0A89000E8E0D000347C2000347C
        2000347C2000347C2000347C2000347C2000FFE89000FFE89000FFE89000FFF8
        9000FFF89000FFFF9800E8D0B000D8A89800F0C8B800F8D0C000FFD8C000FFD8
        C000FFD8C000FFD8C000D8987800D0B8A000FF00FF00FF00FF00FF00FF00FF00
        FF00D0A89000E8E0D0002874100048A0440048A0440048A0440048A044002874
        1000FFE89000FFE89000FFF89000FFF89800FFFF9800FFFF9800E8D0B000D8A8
        9800FFE0C800FFE0C800FFD8C000FFD8C000FFD0B800FFD0B800D0886800D0B8
        A000FF00FF00FF00FF00FF00FF00FF00FF00D0A89000E8E0D000307C1C0058B8
        600058B8600058B8600058B86000307C1C00FFF89000FFF89000FFF89000FFFF
        9800FFFF9800FFFF9800E8D8B000D8A89800F0C8B000F0C8B000F0C8B000F0C8
        B800F8C8B000F8D0B800D8A08000D0B8A000FF00FF00FF00FF00FF00FF00FF00
        FF00D0B09800E8E0D000307C1C0058BC640058BC640058BC640058BC6400307C
        1C00FFE89000F8F09800FFF89800FFF89800FFFF9800FFFF9800E8D8B000D8A0
        9000E0B09800E8B0A000E8B0A000F0C0A800F8C0A800E8B09800C0785800D8C0
        A800FF00FF00FF00FF00FF00FF00FF00FF00D0A89000E8E0D000347C200064C4
        700064C4700064C4700064C47000347C2000E0D8C000E0D8C000E8E0C800F0E8
        C800F0E8D000E8E0C000F0D8C000D8A89000E8C0B000F0C8B800F0C8B000E8B8
        A800E8C0A800E0A08800B8785800D8C8A800FF00FF00FF00FF00FF00FF00FF00
        FF00D0A89000D0D0C800347C200064C4700064C4700064C4700064C47000347C
        2000D0C0B800D0C8B800C8B8A800C0A8A000B8A09800C8B0A800C8B8A800D8A8
        9800D0B8B000D0B8B000D0B8B000D8C8B800D8C8B800D8C8B800B0684800E0D0
        B800FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00347C200074C8
        780074C8780074C8780074C87800347C2000FFFFE800FF00FF00F8D8C000E0A8
        9800B8706000E8C8B000E8D0B000B0584000F8D0B800F8C8B800F8C0B000F8C0
        A800F8C0A800E0987800B0684800E0D0B800FF00FF00FF00FF00FF00FF002064
        04003C842800509840005CA4500080CC800080CC800080CC800080CC80005CA4
        5000509840003C84280020640400D0A08800B8806800E0C0A800E8E0C000C8A0
        8800D0B09800D0A89000D0A89000D0A89000D0A89000D0A89000D8B8A000D8C0
        A000FF00FF00FF00FF00FF00FF00FF00FF00286C0C0074B86C008CCE88008CCE
        88008CCE88008CCE88008CCE88008CCE880074B86C00286C0C00E8D8C800D8C8
        B800C8B0A000C8B0A000D0B8A800D0B8A800D0B8A800D0B8A800D0B8A800D0B8
        A800D0B8A800D0B8A800D0B8A800D8C8B800FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00286C0C0088C07C0098D08E0098D08E0098D08E0098D08E0088C0
        7C00286C0C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00347C20008CCE
        88008CCE88008CCE88008CCE8800347C2000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00387C20008CCE88008CCE8800387C2000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0034781C0034781C00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Layout = blGlyphTop
      Spacing = 3
      OnClick = btnExportarClick
    end
    object btnSair: TSpeedButton
      Left = 703
      Top = 1
      Width = 65
      Height = 57
      Caption = '&Sair'
      Flat = True
      Glyph.Data = {
        16070000424D1607000000000000360000002800000014000000160000000100
        200000000000E006000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00267D27000450070005710A000571
        0A0005710A000450070004500700255E2800668E6700FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000F8319000571
        0A0018992E0009B2190009B2190009B2190009B2190009B2190009B21900029A
        030005710A0004500700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FFFF
        FF00FFFFFF0005710A0018992E0016B4320016B4320016B4320016B4320009B2
        190009B2190009B2190009B2190009B2190009B21900029A030004500700FF00
        FF00FF00FF00FF00FF00FF00FF00FFFFFF000F83190016B4320025BB4F0025BB
        4F0016B4320016B4320016B4320016B4320016B4320009B2190009B2190009B2
        190009B2190009B21900029A030004500700FF00FF00FF00FF00FF00FF000F83
        190025A63D0025BB4F0025BB4F0025BB4F0025BB4F0016B4320047CE7100F2FA
        F500F2FAF50039C3390016B4320009B2190009B2190009B2190009B219000EA3
        1B0004500700FF00FF00FF00FF0018992E0030C3690030C3690025BB4F0025BB
        4F0025BB4F0025BB4F0091DEA900FEFEFE00FFFFFF00F2FAF50030C3690016B4
        320009B2190009B2190009B2190009B219000EA31B0004500700FF00FF0030C3
        690030C3690030C3690030C3690030C3690025BB4F0025BB4F0047CE7100EFF9
        F000FFFFFF00FCFEFE00F8F8F80039C3390016B4320016B4320009B2190009B2
        190009B2190005710A00FF00FF0030C3690030C3690030C3690030C3690030C3
        690030C3690025BB4F0025BB4F0047CE7100F2FAF500FFFEFF00FFFFFF00EFF9
        F00030C3690016B4320016B4320009B2190009B219000EA31B00FF00FF0030C3
        690030C3690030C3690030C3690030C3690030C3690030C3690030C3690030C3
        690047CE7100F2FAF500FCFEFE00FFFFFE00F2FAF50030C3690016B4320016B4
        320016B4320009B21900FF00FF0030C3690030C3690058E08700AFE6BF0091DE
        A90091DEA90091DEA90091DEA90091DEA90091DEA900AFE6BF00FFFFFF00FFFE
        FF00FFFFFF00F2FAF50030C3690016B4320016B4320016B43200FF00FF0030C3
        690030C3690091DEA900FFFFFF00FFFEFF00FEFEFE00FFFFFF00FFFFFF00FEFE
        FE00FFFFFF00FFFEFF00FFFFFF00FFFEFF00FFFFFF00FEFEFE00F2FAF50030C3
        690025BB4F0016B43200FF00FF0030C3690030C3690091DEA900FBFBFC00FCFE
        FE00FFFFFF00F9FFFE00FCFEFE00FFFFFF00FFFFFF00FFFFFF00FCFEFE00FFFE
        FF00FCFEFE00FFFFFF00D9F3E20025BB4F0016B4320016B43200FF00FF0030C3
        690030C3690058E08700AFE6BF0091DEA90091DEA900AFE6BF0091DEA90091DE
        A90091DEA900D9F3E200FFFFFF00FFFEFF00FFFFFF00D9F3E20030C3690025BB
        4F0025BB4F0025BB4F00FF00FF0047CE710030C3690030C3690030C3690030C3
        690030C3690030C3690030C3690030C3690091DEA900F9FFFE00FFFEFF00FEFE
        FE00D9F3E20030C3690030C3690025BB4F0025BB4F0025BB4F00FF00FF007ACE
        7F0047CE710047CE710030C3690030C3690030C3690030C3690030C3690091DE
        A900FFFFFE00FFFFFF00FCFEFE00D9F3E20030C3690030C3690030C3690030C3
        690025BB4F0018992E00FF00FF007ACE7F0091DEA90058E0870047CE710030C3
        690030C3690030C3690058E08700FBFBFC00FEFEFE00FFFEFF00D9F3E20047CE
        710030C3690030C3690030C3690030C3690030C369000F831900FF00FF0016B4
        320091DEA90091DEA90058E087007ACE7F0047CE710030C369007ACE7F00FFFE
        FF00FEFEFE00D9F3E20047CE710030C3690030C3690030C3690030C3690030C3
        690025A63D0049AA4900FF00FF0039C3390039C33900AFE6BF0091DEA90091DE
        A90058E0870047CE710047CE710091DEA900AFE6BF0047CE710030C3690030C3
        690030C3690030C3690030C3690025BB4F000F831900FF00FF00FF00FF00FFFF
        FF0039C3390039C33900BBE5B90091DEA90091DEA9007ACE7F0058E0870051B4
        940030C3690030C3690030C3690030C3690030C3690030C3690025BB4F00029A
        0300FF00FF00FF00FF00FF00FF00FF00FF00FFFFFF0039C3390039C3390091DE
        A900BBE5B90091DEA90091DEA90058E0870058E0870030C3690030C3690030C3
        690030C3690016B432000EA31B00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF007ACE7F0009B2190039C339007ACE7F007ACE7F007ACE
        7F007ACE7F0047CE710025BB4F0016B43200029A030047CE7100FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0039C3390039C3390009B2190009B2190009B2190039C33900FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Layout = blGlyphTop
      Spacing = 5
      OnClick = btnSairClick
    end
    object Panel1: TPanel
      Left = 0
      Top = 59
      Width = 772
      Height = 2
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  object qryPedido: TADODataSet
    Connection = FrmMain.Connection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'I.IDPreSale,'#13#10#9'I.PreSaleDate,'#13#10#9'I.SaleCode,'#13#10#9'IsNull(I.' +
      'OtherExpences, 0) OutrosCustos,'#13#10#9'CAST(0.00 as money) SubTotal,'#13 +
      #10#9'CAST(0.00 as money) ValorDesconto,'#13#10#9'CAST(0.00 as money) Total' +
      ','#13#10#9'P.Pessoa Cliente,'#13#10#9'P.Endereco,'#13#10#9'P.Bairro,'#13#10#9'P.Cidade,'#13#10#9'P.' +
      'CEP,'#13#10#9'P.IDEstado UF,'#13#10#9'P.NomeJuridico as InscEstadual,'#13#10#9'P.Tele' +
      'fone,'#13#10#9'CASE WHEN P.Juridico = 1 THEN P.InscEstadual ELSE P.CPF ' +
      'END Documento'#13#10'FROM'#13#10#9'Invoice I'#13#10#9'JOIN Pessoa P ON (I.IDCustomer' +
      ' = P.IDPessoa)'#13#10'WHERE'#13#10#9'I.IDPreSale = :IDPreSale'
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 232
    Top = 208
    object qryPedidoIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object qryPedidoPreSaleDate: TDateTimeField
      FieldName = 'PreSaleDate'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object qryPedidoSaleCode: TStringField
      FieldName = 'SaleCode'
    end
    object qryPedidoCliente: TStringField
      FieldName = 'Cliente'
      Size = 50
    end
    object qryPedidoEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object qryPedidoBairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object qryPedidoCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object qryPedidoCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object qryPedidoUF: TStringField
      FieldName = 'UF'
      FixedChar = True
      Size = 3
    end
    object qryPedidoInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Size = 30
    end
    object qryPedidoTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
    object qryPedidoDocumento: TStringField
      FieldName = 'Documento'
      ReadOnly = True
      Size = 30
    end
    object qryPedidoOutrosCustos: TBCDField
      FieldName = 'OutrosCustos'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryPedidoSubTotal: TBCDField
      FieldName = 'SubTotal'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryPedidoValorDesconto: TBCDField
      FieldName = 'ValorDesconto'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryPedidoTotal: TBCDField
      FieldName = 'Total'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object qryPedidoItem: TADODataSet
    Connection = FrmMain.Connection
    CursorType = ctStatic
    AfterOpen = qryPedidoItemAfterOpen
    CommandText = 
      'SELECT'#13#10#9'PIM.IDPreInventoryMov,'#13#10#9'PIM.SalePrice PrecoVenda,'#13#10#9'PI' +
      'M.Qty Qtd,'#13#10#9'IsNull(PIM.Discount, 0) Desconto,'#13#10#9'(PIM.SalePrice ' +
      '* PIM.Qty) - IsNull(PIM.Discount, 0) Total,'#13#10#9'P.Pessoa Vendedor,' +
      #13#10#9'M.Model Modelo,'#13#10#9'M.[Description] Descricao,'#13#10#9'CAST('#39'UN'#39' as c' +
      'har(2)) Unidade,'#13#10#9'CASE'#13#10#9#9'WHEN STG.IDSaleTax = 14 THEN '#39'T01'#39#13#10#9 +
      #9'WHEN STG.IDSaleTax IN (5, 17) THEN '#39'T02'#39#13#10#9#9'WHEN STG.IDSaleTax ' +
      '= 38 THEN  '#39'F01'#39#13#10#9'END CodTrib'#13#10'FROM'#13#10#9'PreInventoryMov PIM'#13#10#9'JOI' +
      'N Model M ON (PIM.ModelID = M.IDModel)'#13#10#9'LEFT JOIN [SystemUser] ' +
      'SU ON (PIM.UserID = SU.IDUser)'#13#10#9'LEFT JOIN Pessoa P ON (SU.Comis' +
      'sionID = P.IDPessoa)'#13#10#9'LEFT JOIN StoreToTabGroup STG ON (M.Group' +
      'ID = STG.IDGroup AND PIM.StoreID = STG.IDStore)'#13#10'WHERE'#13#10#9'PIM.Doc' +
      'umentID = :IDPreSale'#13#10#9'AND PIM.InventMovTypeID = 1'#13#10
    Parameters = <
      item
        Name = 'IDPreSale'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 324
    Top = 208
    object qryPedidoItemIDPreInventoryMov: TIntegerField
      FieldName = 'IDPreInventoryMov'
    end
    object qryPedidoItemPrecoVenda: TBCDField
      FieldName = 'PrecoVenda'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryPedidoItemQtd: TFloatField
      FieldName = 'Qtd'
    end
    object qryPedidoItemVendedor: TStringField
      FieldName = 'Vendedor'
      Size = 50
    end
    object qryPedidoItemModelo: TStringField
      FieldName = 'Modelo'
      Size = 30
    end
    object qryPedidoItemDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object qryPedidoItemUnidade: TStringField
      FieldName = 'Unidade'
      ReadOnly = True
      FixedChar = True
      Size = 2
    end
    object qryPedidoItemDesconto: TBCDField
      FieldName = 'Desconto'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object qryPedidoItemCodTrib: TStringField
      DisplayWidth = 3
      FieldName = 'CodTrib'
      ReadOnly = True
      Size = 3
    end
    object qryPedidoItemTotal: TBCDField
      FieldName = 'Total'
      ReadOnly = True
      DisplayFormat = '#,##0.00'
      Precision = 32
      Size = 6
    end
  end
  object dsPedido: TDataSource
    DataSet = cdsPedido
    Left = 232
    Top = 368
  end
  object dsPedidoItem: TDataSource
    DataSet = qryPedidoItem
    Left = 324
    Top = 260
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
  object cdsPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedido'
    AfterScroll = cdsPedidoAfterScroll
    Left = 232
    Top = 313
    object cdsPedidoIDPreSale: TIntegerField
      FieldName = 'IDPreSale'
    end
    object cdsPedidoPreSaleDate: TDateTimeField
      FieldName = 'PreSaleDate'
    end
    object cdsPedidoSaleCode: TStringField
      FieldName = 'SaleCode'
    end
    object cdsPedidoCliente: TStringField
      FieldName = 'Cliente'
      Size = 50
    end
    object cdsPedidoEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object cdsPedidoBairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object cdsPedidoCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object cdsPedidoCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object cdsPedidoUF: TStringField
      FieldName = 'UF'
      FixedChar = True
      Size = 3
    end
    object cdsPedidoInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Size = 30
    end
    object cdsPedidoTelefone: TStringField
      FieldName = 'Telefone'
      Size = 40
    end
    object cdsPedidoDocumento: TStringField
      FieldName = 'Documento'
      ReadOnly = True
      Size = 30
    end
    object cdsPedidoOutrosCustos: TBCDField
      FieldName = 'OutrosCustos'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsPedidoSubTotal: TBCDField
      FieldName = 'SubTotal'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsPedidoValorDesconto: TBCDField
      FieldName = 'ValorDesconto'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
    object cdsPedidoTotal: TBCDField
      FieldName = 'Total'
      DisplayFormat = '#,##0.00'
      Precision = 19
    end
  end
  object dspPedido: TDataSetProvider
    DataSet = qryPedido
    Options = [poIncFieldProps]
    Left = 232
    Top = 261
  end
  object qryTransp: TADODataSet
    Connection = FrmMain.Connection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.Pessoa'#13#10'FROM'#13#10#9'Pessoa P'#13#10'WHERE'#13#10#9'IDTipo' +
      'Pessoa = 2'
    Parameters = <>
    Left = 148
    Top = 208
    object qryTranspIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object qryTranspPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
  end
  object dsTransp: TDataSource
    DataSet = qryTransp
    Left = 148
    Top = 261
  end
  object qryTranspProp: TADODataSet
    Connection = FrmMain.Connection
    CursorType = ctStatic
    CommandText = 
      'SELECT'#13#10#9'P.Endereco,'#13#10#9'P.Bairro,'#13#10#9'P.Cidade,'#13#10#9'P.IDEstado,'#13#10#9'P.C' +
      'EP,'#13#10#9'P.NomeJuridico as CGC,'#13#10#9'P.InscEstadual'#13#10'FROM'#13#10#9'Pessoa P'#13#10 +
      'WHERE'#13#10#9'P.IDPessoa = :IDPessoa'#13#10
    Parameters = <
      item
        Name = 'IDPessoa'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 72
    Top = 209
    object qryTranspPropEndereco: TStringField
      FieldName = 'Endereco'
      Size = 80
    end
    object qryTranspPropBairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object qryTranspPropCidade: TStringField
      FieldName = 'Cidade'
      Size = 40
    end
    object qryTranspPropIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object qryTranspPropCEP: TStringField
      FieldName = 'CEP'
      FixedChar = True
      Size = 12
    end
    object qryTranspPropCGC: TStringField
      FieldName = 'CGC'
      Size = 30
    end
    object qryTranspPropInscEstadual: TStringField
      FieldName = 'InscEstadual'
      Size = 30
    end
  end
end
