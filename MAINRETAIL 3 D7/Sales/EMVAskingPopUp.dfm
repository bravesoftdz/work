object viewEMVAsking: TviewEMVAsking
  Left = 77
  Top = 12
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'EMV - Transaction '
  ClientHeight = 135
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object labelTimeOut: TLabel
    Left = 2
    Top = 8
    Width = 304
    Height = 13
    Caption = 'Pin Pad Time Out. Choose what you want to do:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object buttonClose: TBitBtn
    Left = 85
    Top = 38
    Width = 119
    Height = 25
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 0
    OnClick = buttonCloseClick
    NumGlyphs = 2
  end
  object buttonManual: TBitBtn
    Tag = 1
    Left = 86
    Top = 69
    Width = 119
    Height = 25
    Cancel = True
    Caption = 'Manual Entry'
    ModalResult = 2
    TabOrder = 1
    OnClick = buttonCloseClick
    NumGlyphs = 2
  end
  object buttonSwipe: TBitBtn
    Tag = 2
    Left = 86
    Top = 101
    Width = 121
    Height = 25
    Cancel = True
    Caption = 'Swipe/Insert Card'
    ModalResult = 2
    TabOrder = 2
    OnClick = buttonCloseClick
    NumGlyphs = 2
  end
end
