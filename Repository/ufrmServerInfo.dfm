object FrmServerInfo: TFrmServerInfo
  Left = 205
  Top = 169
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SQLServer Configuration'
  ClientHeight = 253
  ClientWidth = 284
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
    Left = 51
    Top = 79
    Width = 50
    Height = 13
    Alignment = taRightJustify
    Caption = 'IP Server :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 43
    Top = 107
    Width = 59
    Height = 13
    Alignment = taRightJustify
    Caption = 'User Name :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 50
    Top = 132
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'Password :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 18
    Top = 156
    Width = 83
    Height = 13
    Alignment = taRightJustify
    Caption = 'Database Name :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnOK: TSpeedButton
    Left = 120
    Top = 184
    Width = 66
    Height = 22
    Caption = 'OK'
    OnClick = btnOKClick
  end
  object edtServer: TEdit
    Left = 106
    Top = 77
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0.0.0.0'
    OnEnter = edtServerEnter
    OnExit = edtServerExit
  end
  object edtUser: TEdit
    Left = 106
    Top = 102
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'sa'
    OnEnter = edtUserEnter
    OnExit = edtServerExit
  end
  object edtPassword: TEdit
    Left = 106
    Top = 127
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = 'sauser7740'
    OnEnter = edtPasswordEnter
    OnExit = edtServerExit
  end
  object edtDatabase: TEdit
    Left = 106
    Top = 151
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'MainRetailDB'
    OnEnter = edtDatabaseEnter
    OnExit = edtServerExit
  end
  object menInfo: TMemo
    Left = 0
    Top = 211
    Width = 284
    Height = 42
    Align = alBottom
    BorderStyle = bsNone
    Color = clWhite
    Enabled = False
    Lines.Strings = (
      '')
    ReadOnly = True
    TabOrder = 4
  end
  object pnlInfo: TPanel
    Left = 0
    Top = 0
    Width = 284
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object Label5: TLabel
      Left = 2
      Top = 5
      Width = 277
      Height = 13
      Caption = 'Enter Client information to access MainRetailDB.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbInfo: TLabel
      Left = 3
      Top = 20
      Width = 279
      Height = 45
      AutoSize = False
      WordWrap = True
    end
  end
end
