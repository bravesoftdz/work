object FrmImput: TFrmImput
  Left = 207
  Top = 207
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Informar valor'
  ClientHeight = 139
  ClientWidth = 273
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
  object lbInput: TLabel
    Left = 32
    Top = 20
    Width = 221
    Height = 57
    AutoSize = False
    Caption = 'lbInput'
    WordWrap = True
  end
  object Selecionar: TButton
    Left = 178
    Top = 108
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 2
    OnClick = SelecionarClick
  end
  object edtInput: TEdit
    Left = 32
    Top = 78
    Width = 217
    Height = 21
    TabOrder = 0
  end
  object btnAbort: TButton
    Left = 9
    Top = 108
    Width = 56
    Height = 25
    Cancel = True
    Caption = '&Abortar'
    TabOrder = 3
    OnClick = btnAbortClick
  end
  object edtCurrency: TSuperEditCurrency
    Left = 33
    Top = 78
    Width = 213
    Height = 21
    TabOrder = 1
    Text = '0,00'
    OnPressEnter = edtCurrencyPressEnter
    Alignment = taRightJustify
  end
  object btnVoltar: TButton
    Left = 70
    Top = 108
    Width = 56
    Height = 25
    Caption = '&Voltar'
    TabOrder = 4
    OnClick = btnVoltarClick
  end
end
