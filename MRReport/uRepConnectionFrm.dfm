object RepConnectionFrm: TRepConnectionFrm
  Left = 461
  Top = 208
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Server Connection'
  ClientHeight = 195
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 25
    Top = 30
    Width = 83
    Height = 13
    Alignment = taRightJustify
    Caption = 'Connection type :'
  end
  object lbHost: TLabel
    Left = 78
    Top = 63
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'Host :'
  end
  object lbPort: TLabel
    Left = 81
    Top = 126
    Width = 25
    Height = 13
    Alignment = taRightJustify
    Caption = 'Port :'
  end
  object Label2: TLabel
    Left = 57
    Top = 93
    Width = 49
    Height = 13
    Alignment = taRightJustify
    Caption = 'Client ID : '
  end
  object Panel1: TPanel
    Left = 0
    Top = 167
    Width = 318
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object bvBottom: TBevel
      Left = 0
      Top = 0
      Width = 318
      Height = 3
      Align = alTop
      Shape = bsTopLine
    end
    object BNext: TButton
      Left = 154
      Top = 4
      Width = 80
      Height = 23
      Caption = '&Ok'
      TabOrder = 0
      OnClick = BNextClick
    end
    object BClose: TButton
      Left = 237
      Top = 4
      Width = 80
      Height = 23
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = BCloseClick
    end
  end
  object cbxConnectionType: TComboBox
    Left = 116
    Top = 26
    Width = 121
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 0
    OnChange = cbxConnectionTypeChange
    Items.Strings = (
      'DCOM'
      'Socket'
      'Web')
  end
  object edtHost: TEdit
    Left = 116
    Top = 59
    Width = 119
    Height = 21
    TabOrder = 1
    Text = 'edtHost'
  end
  object edtPort: TEdit
    Left = 116
    Top = 122
    Width = 119
    Height = 21
    TabOrder = 3
    Text = 'edtPort'
  end
  object edtClientID: TEdit
    Left = 116
    Top = 89
    Width = 119
    Height = 21
    TabOrder = 2
    Text = 'edtClientID'
  end
end
