object vwAdjustQtyReasonUpsert: TvwAdjustQtyReasonUpsert
  Left = 699
  Top = 57
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'vwAdjustQtyReasonUpsert'
  ClientHeight = 239
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblReason: TLabel
    Left = 25
    Top = 30
    Width = 40
    Height = 13
    Caption = 'Reason:'
  end
  object pnBottom: TPanel
    Left = 0
    Top = 198
    Width = 363
    Height = 41
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    TabOrder = 0
    object bbtnAdd: TBitBtn
      Left = 205
      Top = 3
      Width = 75
      Height = 35
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = bbtnAddClick
    end
    object btnCancel: TBitBtn
      Left = 285
      Top = 4
      Width = 75
      Height = 34
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object edtReason: TEdit
    Left = 82
    Top = 28
    Width = 261
    Height = 21
    TabOrder = 1
  end
  object chkHidden: TCheckBox
    Left = 90
    Top = 90
    Width = 97
    Height = 17
    Caption = 'Hidden'
    TabOrder = 2
  end
  object chkSystem: TCheckBox
    Left = 91
    Top = 119
    Width = 97
    Height = 17
    Caption = 'System'
    TabOrder = 3
  end
  object chkActive: TCheckBox
    Left = 93
    Top = 148
    Width = 97
    Height = 17
    Caption = 'Active'
    TabOrder = 4
  end
end
