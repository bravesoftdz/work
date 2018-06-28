inherited frmPurchaseBarcodeMessage: TfrmPurchaseBarcodeMessage
  Left = 167
  Top = 571
  Width = 338
  Height = 139
  BorderIcons = []
  Caption = ''
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 12
    Top = 20
    Width = 306
    Height = 16
    Caption = 'Items exist in Print Queue. Merge or Delete ?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnMerge: TButton [1]
    Left = 45
    Top = 60
    Width = 115
    Height = 25
    Caption = 'Merge'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 0
    OnClick = btnMergeClick
  end
  object btnDelete: TButton [2]
    Tag = 1
    Left = 170
    Top = 60
    Width = 115
    Height = 25
    Caption = 'Delete'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
    OnClick = btnDeleteClick
  end
end
