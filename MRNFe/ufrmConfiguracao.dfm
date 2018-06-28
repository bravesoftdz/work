object frmConfiguracao: TfrmConfiguracao
  Left = 232
  Top = 139
  Width = 530
  Height = 447
  Caption = 'Configuracao'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    522
    420)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 0
    Top = 4
    Width = 250
    Height = 142
    Caption = '  WebService  '
    TabOrder = 0
    object Label6: TLabel
      Left = 8
      Top = 21
      Width = 121
      Height = 13
      Caption = 'Selecione UF de Destino:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object cbUF: TComboBox
      Left = 8
      Top = 37
      Width = 234
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ItemIndex = 24
      ParentFont = False
      TabOrder = 0
      Text = 'SP'
      Items.Strings = (
        'AC'
        'AL'
        'AP'
        'AM'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MT'
        'MS'
        'MG'
        'PA'
        'PB'
        'PR'
        'PE'
        'PI'
        'RJ'
        'RN'
        'RS'
        'RO'
        'RR'
        'SC'
        'SP'
        'SE'
        'TO')
    end
    object rgTipoAmb: TRadioGroup
      Left = 8
      Top = 76
      Width = 233
      Height = 52
      Caption = 'Selecione o Ambiente de Destino'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Produ'#231#227'o'
        'Homologa'#231#227'o')
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 265
    Top = 4
    Width = 250
    Height = 372
    Caption = '  Geral  '
    TabOrder = 1
    object Label7: TLabel
      Left = 10
      Top = 194
      Width = 57
      Height = 13
      Caption = 'Logo Marca'
    end
    object sbtnLogoMarca: TSpeedButton
      Left = 222
      Top = 208
      Width = 23
      Height = 24
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
        07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
        0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
      OnClick = sbtnLogoMarcaClick
    end
    object Label1: TLabel
      Left = 10
      Top = 232
      Width = 28
      Height = 13
      Caption = 'E-mail'
    end
    object Label2: TLabel
      Left = 10
      Top = 272
      Width = 39
      Height = 13
      Caption = 'Website'
    end
    object Label5: TLabel
      Left = 11
      Top = 75
      Width = 67
      Height = 13
      Caption = 'N'#176' de c'#243'pias :'
    end
    object edtLogoMarca: TEdit
      Left = 10
      Top = 210
      Width = 211
      Height = 21
      TabOrder = 0
    end
    object rgTipoDanfe: TRadioGroup
      Left = 8
      Top = 16
      Width = 233
      Height = 49
      Caption = 'DANFE'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Retrato'
        'Paisagem')
      TabOrder = 1
    end
    object rgFormaEmissao: TRadioGroup
      Left = 8
      Top = 100
      Width = 233
      Height = 97
      Caption = 'Forma de Emiss'#227'o'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Normal'
        'Conting'#234'ncia'
        'SCAN'
        'DPEC'
        'FSDA')
      TabOrder = 2
    end
    object edtEmail: TEdit
      Left = 10
      Top = 248
      Width = 211
      Height = 21
      TabOrder = 3
    end
    object edtWeb: TEdit
      Left = 11
      Top = 289
      Width = 211
      Height = 21
      TabOrder = 4
    end
    object edtNumCopia: TEdit
      Left = 84
      Top = 71
      Width = 35
      Height = 21
      TabOrder = 5
      Text = '1'
    end
    object udNumCopia: TUpDown
      Left = 119
      Top = 71
      Width = 15
      Height = 21
      Associate = edtNumCopia
      Min = 1
      Max = 5
      Position = 1
      TabOrder = 6
    end
  end
  object GroupBox2: TGroupBox
    Left = 1
    Top = 151
    Width = 250
    Height = 72
    Caption = '  Certificado  '
    TabOrder = 2
    object Label25: TLabel
      Left = 8
      Top = 21
      Width = 79
      Height = 13
      Caption = 'N'#250'mero de S'#233'rie'
    end
    object sbtnGetCert: TSpeedButton
      Left = 219
      Top = 35
      Width = 23
      Height = 24
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
        07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
        0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
      OnClick = sbtnGetCertClick
    end
    object edtNumSerie: TEdit
      Left = 8
      Top = 37
      Width = 211
      Height = 21
      TabOrder = 0
    end
  end
  object btSalvar: TButton
    Left = 355
    Top = 388
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Salvar'
    TabOrder = 3
    OnClick = btSalvarClick
  end
  object btCancelar: TButton
    Left = 440
    Top = 388
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancelar'
    TabOrder = 4
    OnClick = btCancelarClick
  end
  object rgMainRetail: TGroupBox
    Left = 2
    Top = 230
    Width = 250
    Height = 146
    Caption = '  MainRetail  '
    TabOrder = 5
    object Label3: TLabel
      Left = 10
      Top = 96
      Width = 170
      Height = 13
      Caption = 'Empresa para gerar NF-e de Venda:'
    end
    object Label4: TLabel
      Left = 10
      Top = 70
      Width = 79
      Height = 13
      Caption = 'Casas decimais :'
    end
    object ckValorAdicional: TCheckBox
      Left = 10
      Top = 17
      Width = 237
      Height = 17
      Caption = 'Calcular Outros Custos do pedido como Frete'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object scEmpresa: TSuperComboADO
      Left = 9
      Top = 113
      Width = 221
      Height = 21
      TabOrder = 1
      LookUpSource = dmSQL.dsLookUpEmpresa
      DropDownRows = 6
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object chkDescontoItem: TCheckBox
      Left = 10
      Top = 40
      Width = 237
      Height = 17
      Caption = 'Embutir desconto dentro no valor do item'
      TabOrder = 2
    end
    object edtDecimal: TEdit
      Left = 94
      Top = 66
      Width = 35
      Height = 21
      TabOrder = 3
      Text = '2'
    end
    object udDecimal: TUpDown
      Left = 129
      Top = 66
      Width = 15
      Height = 21
      Associate = edtDecimal
      Min = 2
      Max = 4
      Position = 2
      TabOrder = 4
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*-nfe.XML'
    Filter = 
      'Arquivos NFE (*-nfe.XML)|*-nfe.XML|Arquivos XML (*.XML)|*.XML|To' +
      'dos os Arquivos (*.*)|*.*'
    Title = 'Selecione a NFe'
    Left = 288
    Top = 160
  end
end
