object FrmSchedule: TFrmSchedule
  Left = 326
  Top = 166
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Manage Schedule'
  ClientHeight = 352
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    444
    352)
  PixelsPerInch = 96
  TextHeight = 13
  object lbSchedule: TLabel
    Left = 119
    Top = 289
    Width = 18
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '      '
  end
  object lbStartat: TLabel
    Left = 119
    Top = 268
    Width = 18
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '      '
  end
  object Label4: TLabel
    Left = 77
    Top = 162
    Width = 117
    Height = 13
    Alignment = taRightJustify
    Caption = 'Verify schedule (minutes)'
  end
  object Label5: TLabel
    Left = 99
    Top = 193
    Width = 95
    Height = 13
    Alignment = taRightJustify
    Caption = 'Delete history (days)'
  end
  object Panel1: TPanel
    Left = 0
    Top = 311
    Width = 444
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    DesignSize = (
      444
      41)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 444
      Height = 6
      Align = alTop
      Shape = bsTopLine
    end
    object BitBtn1: TBitBtn
      Left = 283
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Save'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 363
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object rdOccurs: TRadioGroup
    Left = 10
    Top = 12
    Width = 111
    Height = 126
    Caption = 'Occurs '
    ItemIndex = 0
    Items.Strings = (
      'Daily'
      'Weekly'
      'Monthly')
    TabOrder = 0
    OnClick = rdOccursClick
  end
  object GroupBox1: TGroupBox
    Left = 130
    Top = 13
    Width = 301
    Height = 125
    Caption = 'Frequency '
    TabOrder = 1
    object Label1: TLabel
      Left = 15
      Top = 31
      Width = 52
      Height = 13
      Caption = 'Start date :'
    end
    object Label2: TLabel
      Left = 15
      Top = 96
      Width = 33
      Height = 13
      Caption = 'Every :'
    end
    object Label3: TLabel
      Left = 16
      Top = 63
      Width = 51
      Height = 13
      Caption = 'Starting at:'
    end
    object IniDate: TDateBox
      Left = 97
      Top = 27
      Width = 121
      Height = 21
      TabOrder = 0
      OnChange = rdOccursClick
      InputTime = False
    end
    object edtTime: TEdit
      Left = 97
      Top = 93
      Width = 105
      Height = 21
      TabOrder = 1
      Text = '1'
      OnChange = rdOccursClick
    end
    object UpDownTime: TUpDown
      Left = 202
      Top = 93
      Width = 15
      Height = 21
      Associate = edtTime
      Min = 1
      Max = 60
      Position = 1
      TabOrder = 2
    end
    object cbxTime: TComboBox
      Left = 220
      Top = 93
      Width = 67
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = rdOccursClick
      Items.Strings = (
        'Hour(s)'
        'Minute(s)')
    end
    object edtStartAt: TDateTimePicker
      Left = 97
      Top = 59
      Width = 121
      Height = 21
      Date = 37951.706294201390000000
      Time = 37951.706294201390000000
      Kind = dtkTime
      TabOrder = 4
      OnClick = rdOccursClick
    end
  end
  object edtRefresh: TEdit
    Left = 198
    Top = 158
    Width = 70
    Height = 21
    TabOrder = 2
    Text = '10'
  end
  object udRefresh: TUpDown
    Left = 268
    Top = 158
    Width = 15
    Height = 21
    Associate = edtRefresh
    Min = 1
    Max = 120
    Position = 10
    TabOrder = 4
  end
  object chkDisableSchedule: TCheckBox
    Left = 80
    Top = 228
    Width = 209
    Height = 17
    Caption = 'Disable Schedule'
    TabOrder = 6
  end
  object edtDelHist: TEdit
    Left = 198
    Top = 189
    Width = 70
    Height = 21
    TabOrder = 3
    Text = '15'
  end
  object UpDownDelHist: TUpDown
    Left = 268
    Top = 189
    Width = 15
    Height = 21
    Associate = edtDelHist
    Min = 1
    Max = 120
    Position = 15
    TabOrder = 7
  end
end
