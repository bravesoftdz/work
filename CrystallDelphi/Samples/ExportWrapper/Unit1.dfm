object frmMain: TfrmMain
  Left = 246
  Top = 107
  Width = 277
  Height = 184
  Caption = 'Export Wrapper Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 128
    Top = 64
    Width = 58
    Height = 13
    Caption = 'Destinations'
  end
  object btnExcelDataOnly: TButton
    Left = 8
    Top = 24
    Width = 105
    Height = 25
    Caption = 'Excel Data Only'
    TabOrder = 0
    OnClick = btnExcelDataOnlyClick
  end
  object btnExcel: TButton
    Left = 8
    Top = 56
    Width = 105
    Height = 25
    Caption = 'Excel'
    TabOrder = 1
    OnClick = btnExcelClick
  end
  object btnEditableRTF: TButton
    Left = 8
    Top = 88
    Width = 105
    Height = 25
    Caption = 'Editable RTF'
    TabOrder = 2
    OnClick = btnEditableRTFClick
  end
  object rdoApplication: TRadioButton
    Left = 128
    Top = 80
    Width = 97
    Height = 17
    Caption = 'Application'
    TabOrder = 3
  end
  object rdoDiskFile: TRadioButton
    Left = 128
    Top = 96
    Width = 97
    Height = 17
    Caption = 'Disk file'
    Checked = True
    TabOrder = 4
    TabStop = True
  end
  object edFileName: TEdit
    Left = 8
    Top = 128
    Width = 249
    Height = 21
    TabOrder = 5
    Text = 'c:\Export.xls'
  end
end
