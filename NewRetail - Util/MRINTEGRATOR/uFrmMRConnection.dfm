object FrmMRConnection: TFrmMRConnection
  Left = 162
  Top = 194
  Width = 429
  Height = 345
  BorderIcons = [biSystemMenu]
  Caption = 'MRConnection'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 270
    Width = 421
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      421
      41)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 421
      Height = 6
      Align = alTop
      Shape = bsTopLine
    end
    object BitBtn1: TBitBtn
      Left = 260
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
      Left = 340
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object edtServer: TLabeledEdit
    Left = 180
    Top = 46
    Width = 121
    Height = 21
    EditLabel.Width = 37
    EditLabel.Height = 13
    EditLabel.Caption = 'Server :'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object edtDB: TLabeledEdit
    Left = 180
    Top = 91
    Width = 121
    Height = 21
    EditLabel.Width = 52
    EditLabel.Height = 13
    EditLabel.Caption = 'Database :'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object edtUser: TLabeledEdit
    Left = 180
    Top = 135
    Width = 121
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Use :'
    LabelPosition = lpLeft
    TabOrder = 3
  end
  object edtPW: TLabeledEdit
    Left = 180
    Top = 181
    Width = 121
    Height = 21
    EditLabel.Width = 52
    EditLabel.Height = 13
    EditLabel.Caption = 'Password :'
    LabelPosition = lpLeft
    TabOrder = 4
  end
end
