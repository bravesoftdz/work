inherited FrmSintegra: TFrmSintegra
  Left = 154
  Top = 150
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerar Sintegra'
  ClientHeight = 434
  ClientWidth = 612
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlButtom: TPanel
    Top = 393
    Width = 612
    inherited hhh: TPanel
      Left = 396
      Width = 216
      inherited spHelp: TSpeedButton
        Visible = False
      end
      inherited btClose: TButton
        Left = 145
        OnClick = btCloseClick
      end
      object btnGerar: TButton
        Left = 74
        Top = 6
        Width = 66
        Height = 31
        Caption = 'Gerar'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnGerarClick
      end
    end
  end
  inherited pnlLine: TPanel
    Top = 391
    Width = 612
  end
  object GroupBox1: TGroupBox [2]
    Left = 16
    Top = 11
    Width = 585
    Height = 266
    Caption = ' Dados do Estabelecimento '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label1: TLabel
      Left = 35
      Top = 32
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'Raz'#227'o Social:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 50
      Top = 60
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Endere'#231'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 58
      Top = 88
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'N'#250'mero:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 30
      Top = 116
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'Complemento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 67
      Top = 144
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'Bairro:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 62
      Top = 172
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cidade:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 76
      Top = 225
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'CEP:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 378
      Top = 88
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Telefone:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 402
      Top = 116
      Width = 22
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fax:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 381
      Top = 144
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Contato:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 347
      Top = 172
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cod. Convenio :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 347
      Top = 200
      Width = 77
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cod. Natureza :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 343
      Top = 224
      Width = 81
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cod. Finalidade :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 52
      Top = 199
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'Munic'#237'pio:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object txtRazaoSocial: TEdit
      Left = 104
      Top = 28
      Width = 433
      Height = 21
      MaxLength = 35
      TabOrder = 0
    end
    object txtNumero: TEdit
      Left = 104
      Top = 84
      Width = 73
      Height = 21
      MaxLength = 5
      TabOrder = 2
    end
    object txtEndereco: TEdit
      Left = 104
      Top = 56
      Width = 361
      Height = 21
      MaxLength = 34
      TabOrder = 1
    end
    object txtComplemento: TEdit
      Left = 104
      Top = 112
      Width = 153
      Height = 21
      MaxLength = 22
      TabOrder = 3
    end
    object txtBairro: TEdit
      Left = 104
      Top = 140
      Width = 169
      Height = 21
      MaxLength = 15
      TabOrder = 4
    end
    object txtCidade: TEdit
      Left = 104
      Top = 168
      Width = 169
      Height = 21
      MaxLength = 30
      TabOrder = 5
    end
    object txtCEP: TEdit
      Left = 104
      Top = 221
      Width = 97
      Height = 21
      MaxLength = 10
      TabOrder = 7
    end
    object txtTelefone: TEdit
      Left = 472
      Top = 84
      Width = 78
      Height = 21
      MaxLength = 9
      TabOrder = 9
    end
    object txtDDDTelefone: TEdit
      Left = 428
      Top = 84
      Width = 41
      Height = 21
      MaxLength = 4
      TabOrder = 8
    end
    object txtDDDFax: TEdit
      Left = 428
      Top = 112
      Width = 41
      Height = 21
      MaxLength = 4
      TabOrder = 10
    end
    object txtFax: TEdit
      Left = 472
      Top = 112
      Width = 86
      Height = 21
      MaxLength = 9
      TabOrder = 11
    end
    object txtContato: TEdit
      Left = 428
      Top = 140
      Width = 130
      Height = 21
      MaxLength = 28
      TabOrder = 12
    end
    object edtCodConvenio: TEdit
      Left = 428
      Top = 168
      Width = 41
      Height = 21
      MaxLength = 4
      TabOrder = 13
      Text = '3'
    end
    object edtCodNatureza: TEdit
      Left = 428
      Top = 196
      Width = 41
      Height = 21
      MaxLength = 4
      TabOrder = 14
      Text = '3'
    end
    object edtCodFinalidade: TEdit
      Left = 428
      Top = 220
      Width = 41
      Height = 21
      MaxLength = 4
      TabOrder = 15
      Text = '1'
    end
    object edtEstado: TEdit
      Left = 104
      Top = 195
      Width = 169
      Height = 21
      MaxLength = 30
      TabOrder = 6
    end
  end
  object GroupBox2: TGroupBox [3]
    Left = 16
    Top = 282
    Width = 273
    Height = 106
    Caption = ' M'#234's e Ano para Gera'#231#227'o do Relat'#243'rio Sintegra'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label11: TLabel
      Left = 49
      Top = 36
      Width = 23
      Height = 13
      Caption = 'M'#234's:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 49
      Top = 69
      Width = 23
      Height = 13
      Caption = 'Ano:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object txtMes: TEdit
      Left = 83
      Top = 32
      Width = 58
      Height = 21
      MaxLength = 2
      TabOrder = 0
      Text = '11'
    end
    object txtAno: TEdit
      Left = 83
      Top = 65
      Width = 58
      Height = 21
      MaxLength = 4
      TabOrder = 1
      Text = '2003'
    end
  end
  object GroupBox3: TGroupBox [4]
    Left = 296
    Top = 282
    Width = 305
    Height = 106
    Caption = ' Gerar os Registros Tipo? '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object check60M: TCheckBox
      Left = 24
      Top = 41
      Width = 97
      Height = 17
      Caption = '60 M (Mestre)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 0
    end
    object check60A: TCheckBox
      Left = 24
      Top = 62
      Width = 113
      Height = 17
      Caption = '60 A (Anal'#237'tico)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
    end
    object check60D: TCheckBox
      Left = 24
      Top = 83
      Width = 97
      Height = 17
      Caption = '60 D (Di'#225'rio)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
    object check75: TCheckBox
      Left = 144
      Top = 83
      Width = 97
      Height = 17
      Caption = 'Tipo 75'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
    object check60R: TCheckBox
      Left = 144
      Top = 62
      Width = 145
      Height = 17
      Caption = '60 R (Resumo Mensal)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object check60I: TCheckBox
      Left = 144
      Top = 41
      Width = 97
      Height = 17
      Caption = '60 I (Item)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 3
    end
    object chekTodos: TCheckBox
      Left = 25
      Top = 20
      Width = 164
      Height = 17
      Caption = 'Todos os registros'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 6
      OnClick = chekTodosClick
    end
  end
end
