inherited FrmPDVLog: TFrmPDVLog
  Left = 229
  Top = 6
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Log files'
  ClientHeight = 599
  ClientWidth = 396
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlButtom: TPanel
    Top = 561
    Width = 396
    Height = 38
    inherited lblUserName: TLabel
      Top = 15
    end
    inherited Label15: TLabel
      Top = 14
    end
    inherited hhh: TPanel
      Left = 246
      Height = 38
      inherited spHelp: TSpeedButton
        Top = 4
        OnClick = spHelpClick
      end
      inherited btClose: TButton
        Top = 4
        Default = True
        ModalResult = 1
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
  inherited pnlLine: TPanel
    Top = 559
    Width = 396
  end
  object pnlFilter: TPanel [2]
    Left = 0
    Top = 0
    Width = 396
    Height = 78
    Align = alTop
    BevelOuter = bvNone
    Color = clGray
    TabOrder = 2
    object lbHistory: TLabel
      Left = 67
      Top = 11
      Width = 30
      Height = 13
      Caption = 'Log :'
      Font.Charset = DEFAULT_CHARSET
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
    object cbxLog: TComboBox
      Left = 104
      Top = 8
      Width = 196
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnChange = cbxLogChange
    end
    object chkUser: TCheckBox
      Left = 104
      Top = 35
      Width = 197
      Height = 17
      Caption = 'Display sales person on sale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = cbxLogChange
    end
    object chkCanceled: TCheckBox
      Left = 104
      Top = 56
      Width = 197
      Height = 17
      Caption = 'Exibir cancelados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = cbxLogChange
    end
  end
  object WebBrowser: TWebBrowser [3]
    Left = 0
    Top = 78
    Width = 396
    Height = 481
    Align = alClient
    TabOrder = 3
    ControlData = {
      4C000000EE280000B63100000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPDVLog.sil'
  end
end
