object FrmConfigNetworkDrive: TFrmConfigNetworkDrive
  Left = 195
  Top = 128
  BorderStyle = bsDialog
  Caption = 'Configure Network Drive'
  ClientHeight = 217
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object panHeader: TPanel
    Left = 0
    Top = 0
    Width = 383
    Height = 49
    Align = alTop
    Color = clWhite
    TabOrder = 0
    object labHeader: TLabel
      Left = 10
      Top = 4
      Width = 105
      Height = 18
      Caption = 'Instructions:'
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object labDescription: TLabel
      Left = 14
      Top = 27
      Width = 360
      Height = 14
      Caption = 'Enter UNC path to have backups pushed to another host'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object gbxBody: TGroupBox
    Left = 0
    Top = 49
    Width = 383
    Height = 131
    Align = alClient
    TabOrder = 1
    object labUsername: TLabel
      Left = 10
      Top = 71
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = 'Username'
    end
    object labPassword: TLabel
      Left = 12
      Top = 98
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Password'
    end
    object labFolder: TLabel
      Left = 29
      Top = 26
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Folder'
      WordWrap = True
    end
    object labExample: TLabel
      Left = 76
      Top = 42
      Width = 116
      Height = 13
      Caption = 'Example: \\server\share'
    end
    object edtFolder: TEdit
      Left = 70
      Top = 18
      Width = 275
      Height = 21
      TabOrder = 0
    end
    object edtUsername: TEdit
      Left = 70
      Top = 66
      Width = 275
      Height = 21
      TabOrder = 1
    end
    object edtPassword: TEdit
      Left = 70
      Top = 93
      Width = 275
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
    end
  end
  object panFooter: TPanel
    Left = 0
    Top = 180
    Width = 383
    Height = 37
    Align = alBottom
    TabOrder = 2
    object btnOK: TButton
      Left = 220
      Top = 6
      Width = 75
      Height = 25
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 299
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
