object FrmMain: TFrmMain
  Left = 98
  Top = 0
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pet Center Start-Up'
  ClientHeight = 523
  ClientWidth = 609
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 67
    Width = 593
    Height = 7
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 12
    Top = 73
    Width = 41
    Height = 18
    AutoSize = False
    Caption = 'Step'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object lbFindServer: TLabel
    Left = 95
    Top = 78
    Width = 62
    Height = 13
    Caption = 'SQL Server'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbVerifySQL: TLabel
    Left = 115
    Top = 107
    Width = 153
    Height = 13
    Caption = 'Verifying SQL Server installation'
  end
  object imgVerifySQL: TImage
    Left = 94
    Top = 106
    Width = 16
    Height = 16
    AutoSize = True
    Transparent = True
  end
  object imgStep1: TImage
    Left = 36
    Top = 88
    Width = 32
    Height = 29
    AutoSize = True
    Transparent = True
  end
  object imgStep2: TImage
    Left = 36
    Top = 201
    Width = 32
    Height = 29
    AutoSize = True
    Transparent = True
  end
  object Bevel2: TBevel
    Left = 8
    Top = 174
    Width = 593
    Height = 7
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 12
    Top = 185
    Width = 41
    Height = 18
    AutoSize = False
    Caption = 'Step'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 95
    Top = 190
    Width = 54
    Height = 13
    Caption = 'Database'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbInstallDB: TLabel
    Left = 115
    Top = 269
    Width = 230
    Height = 13
    Caption = 'Creating Pet Center database and user account'
  end
  object imgCreateDB: TImage
    Left = 94
    Top = 268
    Width = 16
    Height = 16
    AutoSize = True
    Transparent = True
  end
  object imgStartService: TImage
    Left = 94
    Top = 218
    Width = 16
    Height = 16
    AutoSize = True
    Transparent = True
  end
  object lbStartServer: TLabel
    Left = 115
    Top = 219
    Width = 97
    Height = 13
    Caption = 'Starting SQL service'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object imgStep3: TImage
    Left = 36
    Top = 381
    Width = 32
    Height = 29
    AutoSize = True
    Transparent = True
  end
  object Bevel3: TBevel
    Left = 8
    Top = 354
    Width = 593
    Height = 7
    Shape = bsTopLine
  end
  object Label5: TLabel
    Left = 12
    Top = 365
    Width = 41
    Height = 18
    AutoSize = False
    Caption = 'Step'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 95
    Top = 370
    Width = 52
    Height = 13
    Caption = 'Finalizing'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbDelFiles: TLabel
    Left = 115
    Top = 412
    Width = 88
    Height = 13
    Caption = 'Deleting temp files'
  end
  object imgDelFiles: TImage
    Left = 94
    Top = 411
    Width = 16
    Height = 16
    AutoSize = True
    Transparent = True
  end
  object lbSQLInstallResume: TLabel
    Left = 146
    Top = 131
    Width = 450
    Height = 34
    AutoSize = False
    Caption = 'Not started'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBackground
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    WordWrap = True
  end
  object lbDBResume: TLabel
    Left = 146
    Top = 290
    Width = 450
    Height = 57
    AutoSize = False
    Caption = 'Not started'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBackground
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    WordWrap = True
  end
  object imgLogIn: TImage
    Left = 94
    Top = 243
    Width = 16
    Height = 16
    AutoSize = True
    Transparent = True
  end
  object lbLogIn: TLabel
    Left = 115
    Top = 244
    Width = 87
    Height = 13
    Caption = 'SQL Server Log In'
  end
  object lbRunMain: TLabel
    Left = 115
    Top = 434
    Width = 126
    Height = 13
    Caption = 'Starting MainRetail Wizard'
  end
  object imgRunMainRetail: TImage
    Left = 94
    Top = 433
    Width = 16
    Height = 16
    AutoSize = True
    Transparent = True
  end
  object lbFinallResume: TLabel
    Left = 146
    Top = 453
    Width = 450
    Height = 28
    AutoSize = False
    Caption = 'Not started'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBackground
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    WordWrap = True
  end
  object lbMainRetailInfo: TLabel
    Left = 7
    Top = 3
    Width = 181
    Height = 13
    Caption = 'Checking computer information.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object imgInstallRep: TImage
    Left = 94
    Top = 388
    Width = 16
    Height = 16
    AutoSize = True
    Transparent = True
  end
  object lbInstallRep: TLabel
    Left = 115
    Top = 389
    Width = 79
    Height = 13
    Caption = 'Installing Report'
  end
  object pnlOpSystem: TPanel
    Left = 12
    Top = 23
    Width = 279
    Height = 43
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    Visible = False
    object Label12: TLabel
      Left = 0
      Top = 2
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'Operating System :'
    end
    object lbOpSystem: TLabel
      Left = 98
      Top = 2
      Width = 57
      Height = 13
      Caption = 'lbOpSystem'
    end
    object Label13: TLabel
      Left = 51
      Top = 20
      Width = 42
      Height = 13
      Alignment = taRightJustify
      Caption = 'Version :'
    end
    object lbVersion: TLabel
      Left = 98
      Top = 20
      Width = 57
      Height = 13
      Caption = 'lbOpSystem'
    end
  end
  object pnlAnalyze: TPanel
    Left = 9
    Top = 17
    Width = 234
    Height = 50
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label11: TLabel
      Left = 67
      Top = 6
      Width = 146
      Height = 28
      AutoSize = False
      Caption = 'Please wait ...'
      WordWrap = True
    end
    object Animate: TAnimate
      Left = 4
      Top = 1
      Width = 55
      Height = 47
      AutoSize = False
      CommonAVI = aviFindComputer
      StopFrame = 8
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 482
    Width = 609
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnClose: TSpeedButton
      Left = 514
      Top = 12
      Width = 81
      Height = 22
      Caption = '&Close'
      OnClick = btnCloseClick
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TimerTimer
    Left = 473
    Top = 15
  end
end
