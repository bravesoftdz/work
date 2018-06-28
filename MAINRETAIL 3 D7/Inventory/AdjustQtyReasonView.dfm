object vwAdjustReason: TvwAdjustReason
  Left = 486
  Top = 52
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Adjust Quantity Reasons'
  ClientHeight = 538
  ClientWidth = 817
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 817
    Height = 41
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object bbtnAdd: TBitBtn
      Left = 10
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Create'
      TabOrder = 0
      OnClick = bbtnAddClick
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 497
    Width = 817
    Height = 41
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    Caption = 'pnBottom'
    TabOrder = 1
  end
  object stgReason: TStringGrid
    Left = 0
    Top = 41
    Width = 817
    Height = 456
    Align = alClient
    ColCount = 7
    TabOrder = 2
    OnDrawCell = stgReasonDrawCell
    OnSelectCell = stgReasonSelectCell
  end
end
