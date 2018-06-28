object tagsAvailableView: TtagsAvailableView
  Left = 481
  Top = 148
  Width = 550
  Height = 370
  Caption = 'Tags Available'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object listAvailableTags: TListBox
    Left = 5
    Top = 5
    Width = 421
    Height = 321
    ItemHeight = 13
    TabOrder = 0
  end
  object buttonSelect: TButton
    Left = 445
    Top = 9
    Width = 75
    Height = 25
    Caption = 'Select'
    TabOrder = 1
    OnClick = buttonSelectClick
  end
  object buttonClose: TButton
    Left = 445
    Top = 299
    Width = 75
    Height = 25
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 2
  end
end
