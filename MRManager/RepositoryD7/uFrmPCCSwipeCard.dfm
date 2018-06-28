object frmPCCSwipeCard: TfrmPCCSwipeCard
  Left = 483
  Top = 311
  ActiveControl = edtTrack
  BorderStyle = bsDialog
  ClientHeight = 108
  ClientWidth = 121
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 88
    Width = 86
    Height = 13
    Caption = 'Swipe the card'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnDefault: TButton
    Left = 16
    Top = 40
    Width = 89
    Height = 25
    Default = True
    TabOrder = 2
    OnClick = btnDefaultClick
  end
  object edtTrack: TEdit
    Left = 16
    Top = 16
    Width = 89
    Height = 21
    TabOrder = 0
  end
  object Animate1: TAnimate
    Left = 0
    Top = 0
    Width = 120
    Height = 80
    HelpType = htKeyword
    FileName = '.\cartao.avi'
    StopFrame = 10
  end
end
