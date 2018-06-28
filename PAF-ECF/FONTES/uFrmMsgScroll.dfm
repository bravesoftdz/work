inherited FrmMsgScroll: TFrmMsgScroll
  Left = 113
  Top = 206
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Mensagem'
  ClientHeight = 162
  ClientWidth = 458
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TBitBtn [0]
    Left = 188
    Top = 134
    Width = 75
    Height = 25
    Caption = 'Fechar'
    Default = True
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object memMessage: TMemo [1]
    Left = 12
    Top = 8
    Width = 438
    Height = 122
    TabStop = False
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    Lines.Strings = (
      'este e um teste para saber como funciona')
    ParentColor = True
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
