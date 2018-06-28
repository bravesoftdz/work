object FrmServerConnection: TFrmServerConnection
  Left = 275
  Top = 153
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Server Connection'
  ClientHeight = 273
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 28
    Width = 87
    Height = 13
    Alignment = taRightJustify
    Caption = 'Connection Type :'
  end
  object pnlFTP: TPanel
    Left = 4
    Top = 47
    Width = 277
    Height = 181
    BevelOuter = bvNone
    TabOrder = 3
    object Label2: TLabel
      Left = 64
      Top = 12
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'FTP :'
    end
    object Label3: TLabel
      Left = 65
      Top = 40
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'Port :'
    end
    object Label4: TLabel
      Left = 62
      Top = 67
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'User :'
    end
    object Label5: TLabel
      Left = 38
      Top = 95
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'Password :'
    end
    object Label6: TLabel
      Left = 19
      Top = 123
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = 'Global files dir :'
    end
    object Label7: TLabel
      Left = 27
      Top = 151
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'POS files dir :'
    end
    object edtFTP: TEdit
      Left = 100
      Top = 8
      Width = 145
      Height = 21
      TabOrder = 0
    end
    object edtPort: TEdit
      Left = 100
      Top = 36
      Width = 145
      Height = 21
      TabOrder = 1
    end
    object edtUser: TEdit
      Left = 100
      Top = 63
      Width = 145
      Height = 21
      TabOrder = 2
    end
    object edtPW: TEdit
      Left = 100
      Top = 91
      Width = 145
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
    end
    object edtGlobalDir: TEdit
      Left = 100
      Top = 119
      Width = 145
      Height = 21
      TabOrder = 4
    end
    object edtPOSDir: TEdit
      Left = 100
      Top = 147
      Width = 145
      Height = 21
      TabOrder = 5
    end
  end
  object pnlServer: TPanel
    Left = 4
    Top = 48
    Width = 281
    Height = 180
    BevelOuter = bvNone
    TabOrder = 2
    object lbServer: TLabel
      Left = 36
      Top = 10
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = 'Server Info :'
    end
    object btnSetConnection: TSpeedButton
      Left = 250
      Top = 9
      Width = 23
      Height = 22
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF84828400FFFF000000000000FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF84828400FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00
        0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000000000000000FF
        FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF848284FFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF000000000000FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00
        0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF848284FFFFFF00FFFF000000000000FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF848284FFFFFF00
        FFFF00FFFF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF848284FFFFFF00FFFF00FFFF000000000000FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF84
        8284FFFFFF00FFFF00FFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnSetConnectionClick
    end
    object memServerInfo: TMemo
      Left = 100
      Top = 8
      Width = 145
      Height = 157
      Color = clSilver
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 232
    Width = 291
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      291
      41)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 291
      Height = 6
      Align = alTop
      Shape = bsTopLine
    end
    object btnSave: TBitBtn
      Left = 130
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Save'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object BitBtn2: TBitBtn
      Left = 210
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object cbxConnection: TComboBox
    Left = 104
    Top = 24
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Direct to the server'
    OnChange = cbxConnectionChange
    Items.Strings = (
      'Direct to the server'
      'FTP')
  end
end
