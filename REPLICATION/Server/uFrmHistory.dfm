object FrmHistory: TFrmHistory
  Left = 124
  Top = 32
  Width = 596
  Height = 483
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Replication History'
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
  object Panel1: TPanel
    Left = 0
    Top = 415
    Width = 588
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      588
      41)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 588
      Height = 6
      Align = alTop
      Shape = bsTopLine
    end
    object BitBtn2: TBitBtn
      Left = 507
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'C&lose'
      ModalResult = 2
      TabOrder = 0
    end
    object BtnSave: TBitBtn
      Left = 427
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Save'
      Enabled = False
      ModalResult = 1
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 346
      Top = 11
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Clear'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object memHistory: TMemo
    Left = 0
    Top = 0
    Width = 588
    Height = 415
    Align = alClient
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
