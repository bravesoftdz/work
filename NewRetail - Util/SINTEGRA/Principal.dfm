object frmPrincipal: TfrmPrincipal
  Left = 192
  Top = 107
  Width = 380
  Height = 246
  Caption = 'Gerador de arquivos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 372
    Height = 196
    Color = clWindow
    TabOrder = 0
    object Label1: TLabel
      Left = 130
      Top = 76
      Width = 113
      Height = 33
      Caption = 'Sintegra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -28
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 2
      Top = 183
      Width = 100
      Height = 11
      Caption = 'Powered by Main Retail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbInfo: TLabel
      Left = 269
      Top = 181
      Width = 100
      Height = 11
      Alignment = taRightJustify
      Caption = 'Powered by Main Retail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 53
    Top = 65
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object emrpesa1: TMenuItem
        Caption = 'Empresa'
        OnClick = emrpesa1Click
      end
    end
    object Gerao1: TMenuItem
      Caption = 'Gera'#231#227'o'
      object Gerararquivoparaentrega1: TMenuItem
        Caption = 'Gerar'
        OnClick = Gerararquivoparaentrega1Click
      end
    end
  end
end
