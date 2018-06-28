object CrpeExportRecordsDlg: TCrpeExportRecordsDlg
  Left = 609
  Top = 208
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Records Export'
  ClientHeight = 173
  ClientWidth = 185
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 14
    Top = 137
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 97
    Top = 137
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pnlRecords: TPanel
    Left = 9
    Top = 9
    Width = 168
    Height = 120
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object cbUseRptNumberFmt: TCheckBox
      Left = 18
      Top = 71
      Width = 141
      Height = 17
      Caption = 'Use Rpt Number Format'
      TabOrder = 0
    end
    object cbUseRptDateFmt: TCheckBox
      Left = 18
      Top = 90
      Width = 125
      Height = 17
      Caption = 'Use Rpt Date Format'
      TabOrder = 1
    end
    object rgRecordsType: TRadioGroup
      Left = 11
      Top = 6
      Width = 146
      Height = 59
      Caption = ' Records Type '
      Items.Strings = (
        'ColumnsWithSpaces'
        'ColumnsNoSpaces')
      TabOrder = 2
    end
  end
end
