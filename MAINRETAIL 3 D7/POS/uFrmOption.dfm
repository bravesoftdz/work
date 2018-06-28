object FrmOption: TFrmOption
  Left = 224
  Top = 233
  Width = 288
  Height = 302
  BorderIcons = [biSystemMenu]
  Caption = 'FrmOption'
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
  object Selecionar: TButton
    Left = 194
    Top = 232
    Width = 75
    Height = 25
    Caption = '&Selecionar'
    Default = True
    TabOrder = 1
    OnClick = SelecionarClick
  end
  object lbxOption: TListBox
    Left = 8
    Top = 4
    Width = 261
    Height = 221
    ItemHeight = 13
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 9
    Top = 232
    Width = 53
    Height = 24
    Cancel = True
    Caption = '&Abortar'
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object btnVoltar: TButton
    Left = 69
    Top = 232
    Width = 53
    Height = 24
    Caption = '&Voltar'
    TabOrder = 3
    OnClick = btnVoltarClick
  end
end
