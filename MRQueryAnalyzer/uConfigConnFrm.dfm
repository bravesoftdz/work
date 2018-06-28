object Form1: TForm1
  Left = 392
  Top = 300
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Connect to SQL Server'
  ClientHeight = 179
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 60
    Top = 12
    Width = 37
    Height = 13
    Caption = 'Server :'
  end
  object Label2: TLabel
    Left = 42
    Top = 36
    Width = 55
    Height = 13
    Caption = 'Data base :'
  end
  object Label3: TLabel
    Left = 69
    Top = 60
    Width = 28
    Height = 13
    Caption = 'User :'
  end
  object Label4: TLabel
    Left = 45
    Top = 84
    Width = 52
    Height = 13
    Caption = 'Password :'
  end
  object Button1: TButton
    Left = 116
    Top = 139
    Width = 75
    Height = 25
    Caption = '&Ok'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 100
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '(local)'
  end
  object Edit2: TEdit
    Left = 100
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'MainRetailDB'
  end
  object Edit3: TEdit
    Left = 100
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'mruser'
  end
  object Edit4: TEdit
    Left = 100
    Top = 80
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
    Text = 'mruser2000'
  end
  object CheckBox1: TCheckBox
    Left = 101
    Top = 110
    Width = 149
    Height = 17
    Caption = 'Use network library'
    TabOrder = 4
  end
end
