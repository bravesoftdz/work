object FrmDefaultValues: TFrmDefaultValues
  Left = 508
  Top = 202
  BorderStyle = bsSingle
  Caption = 'Default Values'
  ClientHeight = 210
  ClientWidth = 426
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
  object Label1: TLabel
    Left = 95
    Top = 40
    Width = 31
    Height = 13
    Alignment = taRightJustify
    Caption = 'Store :'
  end
  object Label2: TLabel
    Left = 78
    Top = 95
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'Category :'
  end
  object Panel1: TPanel
    Left = 0
    Top = 169
    Width = 426
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      426
      41)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 426
      Height = 6
      Align = alTop
      Shape = bsTopLine
    end
    object BitBtn1: TBitBtn
      Left = 265
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
      Left = 345
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object scStore: TSuperComboADO
    Left = 135
    Top = 35
    Width = 201
    Height = 21
    TabOrder = 1
    Text = 'scStore'
    LookUpSource = DM.dsLookUpStore
    DropDownRows = 15
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object scCateg: TSuperComboADO
    Left = 135
    Top = 90
    Width = 201
    Height = 21
    TabOrder = 2
    Text = 'scCateg'
    LookUpSource = DM.dsLookUpCategory
    DropDownRows = 15
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
end
