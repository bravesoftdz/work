object frmGeraArquivo: TfrmGeraArquivo
  Left = 210
  Top = 193
  Width = 425
  Height = 264
  VertScrollBar.Range = 41
  ActiveControl = btnGerar
  BorderStyle = bsDialog
  Caption = 'Gerar arquivo para entregra'
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 417
    Height = 196
    Align = alClient
    BorderWidth = 5
    TabOrder = 0
    object rgOperacao: TRadioGroup
      Left = 6
      Top = 49
      Width = 405
      Height = 81
      Align = alTop
      Caption = 'Opera'#231#227'o '
      ItemIndex = 0
      Items.Strings = (
        'Totalidade das opera'#231#245'es do informante'
        
          'Interestaduais somente opera'#231#245'es sujeitas ao regime de Substitui' +
          #231#227'o Tribut'#225'ria'
        'Interestaduais - Opera'#231#245'es com ou sem Substitui'#231#227'o Tribut'#225'ria')
      TabOrder = 1
    end
    object rgFinalidade: TRadioGroup
      Left = 6
      Top = 130
      Width = 405
      Height = 60
      Align = alClient
      Caption = 'Finalidade'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Normal'
        'Retifica'#231#227'o Total'
        'Retifica'#231#227'o Aditiva'
        'Desfazimento')
      TabOrder = 2
    end
    object Panel4: TPanel
      Left = 6
      Top = 6
      Width = 405
      Height = 43
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 38
        Height = 13
        Caption = 'Per'#237'odo'
      end
      object Label2: TLabel
        Left = 128
        Top = 20
        Width = 15
        Height = 13
        Caption = 'at'#233
      end
      object edData01: TDateBox
        Left = 0
        Top = 15
        Width = 121
        Height = 21
        TabOrder = 0
        Language = Portuguese
      end
      object edData02: TDateBox
        Left = 149
        Top = 15
        Width = 121
        Height = 21
        TabOrder = 1
        Language = Portuguese
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 196
    Width = 417
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Panel3: TPanel
      Left = 154
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
        TabOrder = 1
        Kind = bkCancel
      end
      object btnGerar: TBitBtn
        Left = 5
        Top = 7
        Width = 121
        Height = 25
        Caption = '&OK'
        Default = True
        TabOrder = 0
        OnClick = btnGerarClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          04000000000068010000120B0000120B00001000000010000000000000000000
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
    object pb: TProgressBar
      Left = 10
      Top = 12
      Width = 121
      Height = 16
      TabOrder = 1
      Visible = False
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.txt'
    FileName = 'Sintegra.txt'
    Filter = 'Arquivos de texto|*.txt'
    FilterIndex = 0
    InitialDir = '\'
    Title = 'Salvar arquivo'
    Left = 372
    Top = 26
  end
end
