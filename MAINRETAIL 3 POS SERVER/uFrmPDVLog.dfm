object FrmPDVLog: TFrmPDVLog
  Left = 280
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Log files'
  ClientHeight = 569
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 396
    Height = 96
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    TabOrder = 0
    object lbHistory: TLabel
      Left = 69
      Top = 32
      Width = 30
      Height = 13
      Alignment = taRightJustify
      Caption = 'Log :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Image1: TImage
      Left = 374
      Top = 4
      Width = 19
      Height = 19
      Cursor = crHandPoint
      Hint = 'Tudo'
      ParentShowHint = False
      ShowHint = True
      OnClick = Image1Click
    end
    object Image2: TImage
      Left = 374
      Top = 28
      Width = 19
      Height = 19
      Cursor = crHandPoint
      Hint = 'Lista'
      ParentShowHint = False
      ShowHint = True
      OnClick = Image2Click
    end
    object lbCaixa: TLabel
      Left = 59
      Top = 5
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Caixa :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbxLog: TComboBox
      Left = 104
      Top = 29
      Width = 196
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
      OnChange = cbxLogChange
    end
    object chkUser: TCheckBox
      Left = 104
      Top = 53
      Width = 197
      Height = 17
      Caption = 'Exibir vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = cbxLogChange
    end
    object chkCanceled: TCheckBox
      Left = 104
      Top = 73
      Width = 197
      Height = 17
      Caption = 'Exibir cancelados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = cbxLogChange
    end
    object cbxCaixas: TComboBox
      Left = 104
      Top = 2
      Width = 196
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnChange = cbxCaixasChange
    end
  end
  object WebBrowser: TWebBrowser
    Left = 0
    Top = 96
    Width = 396
    Height = 435
    Align = alClient
    TabOrder = 1
    ControlData = {
      4C000000EE280000F52C00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object pnlButtom: TPanel
    Left = 0
    Top = 531
    Width = 396
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object hhh: TPanel
      Left = 246
      Top = 0
      Width = 150
      Height = 38
      Align = alRight
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object btClose: TButton
        Left = 77
        Top = 4
        Width = 66
        Height = 31
        Cancel = True
        Caption = 'Close'
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 1
        ParentFont = False
        TabOrder = 0
        TabStop = False
      end
    end
    object pbOpenLine: TProgressBar
      Left = 16
      Top = 12
      Width = 205
      Height = 16
      TabOrder = 1
      Visible = False
    end
  end
  object cdsSystemUser: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSystemUser'
    Left = 66
    Top = 104
  end
  object cdsModel: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspModel'
    Left = 148
    Top = 108
  end
  object cdsMeioPag: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMeioPag'
    Left = 221
    Top = 112
  end
  object cdsCashRegLogReason: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCashRegLogReason'
    Left = 69
    Top = 165
    object cdsCashRegLogReasonIDCashRegLogReason: TIntegerField
      FieldName = 'IDCashRegLogReason'
    end
    object cdsCashRegLogReasonReason: TStringField
      FieldName = 'Reason'
      Size = 30
    end
  end
end
