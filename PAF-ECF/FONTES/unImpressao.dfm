object frmImpressao: TfrmImpressao
  Left = 196
  Top = 111
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Exemplo da Impress'#227'o'
  ClientHeight = 390
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object memEditor: TMemo
    Left = -1
    Top = 0
    Width = 266
    Height = 355
    TabStop = False
    BorderStyle = bsNone
    ReadOnly = True
    TabOrder = 0
    WordWrap = False
  end
  object btnOk: TBitBtn
    Left = 98
    Top = 360
    Width = 75
    Height = 23
    Caption = '&Fechar'
    TabOrder = 1
    OnClick = btnOkClick
    Kind = bkOK
  end
end
