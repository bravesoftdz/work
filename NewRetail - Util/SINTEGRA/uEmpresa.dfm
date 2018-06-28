object frmEmpresa: TfrmEmpresa
  Left = 166
  Top = 70
  Width = 484
  Height = 418
  VertScrollBar.Range = 41
  BorderStyle = bsDialog
  Caption = 'Cadastro de Empresa'
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 350
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 63
      Height = 13
      Caption = 'Raz'#227'o Social'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 27
      Height = 13
      Caption = 'CNPJ'
    end
    object Label3: TLabel
      Left = 200
      Top = 48
      Width = 87
      Height = 13
      Caption = 'Inscri'#231#227'o Estadual'
    end
    object Label4: TLabel
      Left = 8
      Top = 88
      Width = 46
      Height = 13
      Caption = 'Endere'#231'o'
    end
    object Label5: TLabel
      Left = 8
      Top = 128
      Width = 64
      Height = 13
      Caption = 'Complemento'
    end
    object Label6: TLabel
      Left = 384
      Top = 88
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object Label7: TLabel
      Left = 232
      Top = 128
      Width = 27
      Height = 13
      Caption = 'Bairro'
    end
    object Label8: TLabel
      Left = 8
      Top = 168
      Width = 47
      Height = 13
      Caption = 'Munic'#237'pio'
    end
    object Label9: TLabel
      Left = 304
      Top = 168
      Width = 21
      Height = 13
      Caption = 'CEP'
    end
    object Label10: TLabel
      Left = 432
      Top = 168
      Width = 14
      Height = 13
      Caption = 'UF'
    end
    object Label11: TLabel
      Left = 8
      Top = 208
      Width = 17
      Height = 13
      Caption = 'Fax'
    end
    object Label12: TLabel
      Left = 176
      Top = 208
      Width = 24
      Height = 13
      Caption = 'Fone'
    end
    object Label13: TLabel
      Left = 8
      Top = 248
      Width = 62
      Height = 13
      Caption = 'Respons'#225'vel'
    end
    object RazaoSocial: TEdit
      Left = 7
      Top = 23
      Width = 413
      Height = 21
      TabOrder = 0
      Text = 'RazaoSocial'
    end
    object CNPJ: TEdit
      Left = 9
      Top = 64
      Width = 177
      Height = 21
      TabOrder = 1
      Text = 'CNPJ'
    end
    object InscEstadual: TEdit
      Left = 200
      Top = 65
      Width = 266
      Height = 21
      TabOrder = 2
      Text = 'InscEstadual'
    end
    object Endereco: TEdit
      Left = 10
      Top = 105
      Width = 361
      Height = 21
      TabOrder = 3
      Text = 'Endereco'
    end
    object Numero: TEdit
      Left = 385
      Top = 105
      Width = 72
      Height = 21
      TabOrder = 4
      Text = 'Numero'
    end
    object Complemento: TEdit
      Left = 10
      Top = 145
      Width = 216
      Height = 21
      TabOrder = 5
      Text = 'Complemento'
    end
    object Bairro: TEdit
      Left = 235
      Top = 145
      Width = 121
      Height = 21
      TabOrder = 6
      Text = 'Bairro'
    end
    object Municipio: TEdit
      Left = 10
      Top = 185
      Width = 121
      Height = 21
      TabOrder = 7
      Text = 'Municipio'
    end
    object CEP: TEdit
      Left = 305
      Top = 180
      Width = 76
      Height = 21
      TabOrder = 8
      Text = 'CEP'
    end
    object UF: TEdit
      Left = 430
      Top = 182
      Width = 31
      Height = 21
      TabOrder = 9
      Text = 'UF'
    end
    object Fax: TEdit
      Left = 10
      Top = 225
      Width = 121
      Height = 21
      TabOrder = 10
      Text = 'Fax'
    end
    object Fone: TEdit
      Left = 175
      Top = 225
      Width = 121
      Height = 21
      TabOrder = 11
      Text = 'Fone'
    end
    object Responsavel: TEdit
      Left = 10
      Top = 265
      Width = 456
      Height = 21
      TabOrder = 12
      Text = 'Responsavel'
    end
    object rbTributario: TRadioGroup
      Left = 8
      Top = 290
      Width = 185
      Height = 56
      Caption = 'Substituto Tribut'#225'rio'
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 13
    end
    object rbIPI: TRadioGroup
      Left = 195
      Top = 290
      Width = 185
      Height = 56
      Caption = 'Contribuinte do IPI'
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 14
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 350
    Width = 476
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Panel3: TPanel
      Left = 213
      Top = 1
      Width = 262
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object btnCancela: TBitBtn
        Left = 133
        Top = 7
        Width = 121
        Height = 25
        Caption = 'Cancela'
        TabOrder = 0
        OnClick = btnOKClick
        Kind = bkCancel
      end
    end
    object btOk: TBitBtn
      Left = 219
      Top = 8
      Width = 120
      Height = 25
      Caption = 'Save'
      ModalResult = 1
      TabOrder = 1
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
end
