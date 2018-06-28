object frmPrincipal: TfrmPrincipal
  Left = 195
  Top = 149
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 
    'Aplicativo de exemplo para geração do relatório Sintegra na impr' +
    'essora fiscal MFD BEMATECH'
  ClientHeight = 428
  ClientWidth = 604
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 16
    Width = 585
    Height = 233
    Caption = ' Dados do Estabelecimento '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 74
      Height = 13
      Caption = 'Razão Social:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 80
      Width = 55
      Height = 13
      Caption = 'Endereço:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 472
      Top = 80
      Width = 47
      Height = 13
      Caption = 'Número:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 24
      Top = 128
      Width = 82
      Height = 13
      Caption = 'Complemento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 192
      Top = 128
      Width = 37
      Height = 13
      Caption = 'Bairro:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 376
      Top = 128
      Width = 41
      Height = 13
      Caption = 'Cidade:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 24
      Top = 176
      Width = 23
      Height = 13
      Caption = 'CEP:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 136
      Top = 176
      Width = 52
      Height = 13
      Caption = 'Telefone:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 272
      Top = 176
      Width = 23
      Height = 13
      Caption = 'Fax:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 416
      Top = 176
      Width = 48
      Height = 13
      Caption = 'Contato:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object txtRazaoSocial: TEdit
      Left = 32
      Top = 48
      Width = 521
      Height = 21
      MaxLength = 35
      TabOrder = 0
      Text = 'Bematech Ind Com Equip Eletron S/A'
    end
    object txtNumero: TEdit
      Left = 480
      Top = 96
      Width = 73
      Height = 21
      MaxLength = 5
      TabOrder = 2
      Text = '263'
    end
    object txtEndereco: TEdit
      Left = 32
      Top = 96
      Width = 433
      Height = 21
      MaxLength = 34
      TabOrder = 1
      Text = 'Estrada de Santa Candida'
    end
    object txtComplemento: TEdit
      Left = 32
      Top = 144
      Width = 153
      Height = 21
      MaxLength = 22
      TabOrder = 3
    end
    object txtBairro: TEdit
      Left = 200
      Top = 144
      Width = 169
      Height = 21
      MaxLength = 15
      TabOrder = 4
      Text = 'Sta Candida'
    end
    object txtCidade: TEdit
      Left = 384
      Top = 144
      Width = 169
      Height = 21
      MaxLength = 30
      TabOrder = 5
      Text = 'Curitiba'
    end
    object txtCEP: TEdit
      Left = 32
      Top = 192
      Width = 97
      Height = 21
      MaxLength = 10
      TabOrder = 6
      Text = '82.630-490'
    end
    object txtTelefone: TEdit
      Left = 188
      Top = 192
      Width = 78
      Height = 21
      MaxLength = 9
      TabOrder = 8
      Text = '351-2700'
    end
    object txtDDDTelefone: TEdit
      Left = 144
      Top = 192
      Width = 41
      Height = 21
      MaxLength = 4
      TabOrder = 7
      Text = '(41)'
    end
    object txtDDDFax: TEdit
      Left = 280
      Top = 192
      Width = 41
      Height = 21
      MaxLength = 4
      TabOrder = 9
      Text = '(41)'
    end
    object txtFax: TEdit
      Left = 324
      Top = 192
      Width = 86
      Height = 21
      MaxLength = 9
      TabOrder = 10
      Text = '351-2863'
    end
    object txtContato: TEdit
      Left = 424
      Top = 192
      Width = 130
      Height = 21
      MaxLength = 28
      TabOrder = 11
      Text = 'Fulano de Tal'
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 256
    Width = 273
    Height = 97
    Caption = ' Mês e Ano para Geração do Relatório Sintegra'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label11: TLabel
      Left = 49
      Top = 36
      Width = 26
      Height = 13
      Caption = 'Mês:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 161
      Top = 36
      Width = 25
      Height = 13
      Caption = 'Ano:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object txtMes: TEdit
      Left = 55
      Top = 52
      Width = 42
      Height = 21
      MaxLength = 2
      TabOrder = 0
      Text = '11'
    end
    object txtAno: TEdit
      Left = 167
      Top = 52
      Width = 58
      Height = 21
      MaxLength = 4
      TabOrder = 1
      Text = '2003'
    end
  end
  object GroupBox3: TGroupBox
    Left = 288
    Top = 256
    Width = 305
    Height = 97
    Caption = ' Gerar os Registros Tipo? '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object check60M: TCheckBox
      Left = 24
      Top = 24
      Width = 97
      Height = 17
      Caption = '60 M (Mestre)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 0
    end
    object check60A: TCheckBox
      Left = 24
      Top = 45
      Width = 113
      Height = 17
      Caption = '60 A (Analítico)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 1
    end
    object check60D: TCheckBox
      Left = 24
      Top = 66
      Width = 97
      Height = 17
      Caption = '60 D (Diário)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 2
    end
    object check75: TCheckBox
      Left = 144
      Top = 66
      Width = 97
      Height = 17
      Caption = 'Tipo 75'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
    object check60R: TCheckBox
      Left = 144
      Top = 45
      Width = 145
      Height = 17
      Caption = '60 R (Resumo Mensal)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 4
    end
    object check60I: TCheckBox
      Left = 144
      Top = 24
      Width = 97
      Height = 17
      Caption = '60 I (Item)'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 3
    end
  end
  object cmdGerar: TButton
    Left = 504
    Top = 360
    Width = 91
    Height = 25
    Caption = '&Gerar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = cmdGerarClick
  end
  object cmdSair: TButton
    Left = 504
    Top = 392
    Width = 91
    Height = 25
    Caption = '&Sair'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = cmdSairClick
  end
end
