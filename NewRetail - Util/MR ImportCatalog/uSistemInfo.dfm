object FrmError: TFrmError
  Left = 263
  Top = 208
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'System Info'
  ClientHeight = 259
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton
    Left = 330
    Top = 230
    Width = 75
    Height = 25
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 0
  end
  object memSummary: TMemo
    Left = 0
    Top = 1
    Width = 410
    Height = 221
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
