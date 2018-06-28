inherited FrmServerConnection: TFrmServerConnection
  Left = 625
  Top = 481
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Server Connection'
  ClientHeight = 232
  ClientWidth = 277
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 198
    Width = 277
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object bvBottom: TBevel
      Left = 0
      Top = 0
      Width = 277
      Height = 3
      Align = alTop
      Shape = bsTopLine
    end
    object BNext: TButton
      Left = 104
      Top = 7
      Width = 80
      Height = 23
      Caption = 'Save'
      TabOrder = 0
      OnClick = BNextClick
    end
    object BClose: TButton
      Left = 189
      Top = 7
      Width = 80
      Height = 23
      Caption = 'Close'
      TabOrder = 1
      OnClick = BCloseClick
    end
  end
  object pgOption: TPageControl [1]
    Left = 0
    Top = 0
    Width = 277
    Height = 198
    ActivePage = tsConnection
    Align = alClient
    TabOrder = 1
    object tsConnection: TTabSheet
      Caption = 'Connection'
      object Label1: TLabel
        Left = 25
        Top = 21
        Width = 83
        Height = 13
        Alignment = taRightJustify
        Caption = 'Connection type :'
      end
      object lbHost: TLabel
        Left = 78
        Top = 62
        Width = 28
        Height = 13
        Alignment = taRightJustify
        Caption = 'Host :'
      end
      object lbPort: TLabel
        Left = 81
        Top = 141
        Width = 25
        Height = 13
        Alignment = taRightJustify
        Caption = 'Port :'
      end
      object Label2: TLabel
        Left = 57
        Top = 100
        Width = 49
        Height = 13
        Alignment = taRightJustify
        Caption = 'Client ID : '
      end
      object cbxConnectionType: TComboBox
        Left = 116
        Top = 17
        Width = 121
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 0
        OnChange = cbxConnectionTypeChange
        Items.Strings = (
          'DCOM'
          'Socket'
          'Web')
      end
      object edtHost: TEdit
        Left = 116
        Top = 58
        Width = 119
        Height = 21
        TabOrder = 1
      end
      object edtPort: TEdit
        Left = 116
        Top = 137
        Width = 119
        Height = 21
        TabOrder = 2
      end
      object edtClientID: TEdit
        Left = 116
        Top = 96
        Width = 119
        Height = 21
        TabOrder = 3
      end
    end
    object tsLicense: TTabSheet
      Caption = 'License'
      ImageIndex = 1
      object Label3: TLabel
        Left = 42
        Top = 40
        Width = 24
        Height = 13
        Alignment = taRightJustify
        Caption = 'Key :'
      end
      object Label4: TLabel
        Left = 14
        Top = 76
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'Expiration :'
      end
      object lbKey: TLabel
        Left = 69
        Top = 41
        Width = 32
        Height = 13
        Caption = 'lbKey'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbExpiration: TLabel
        Left = 69
        Top = 77
        Width = 54
        Height = 13
        Caption = 'lbExpiration'
      end
      object btnLicense: TButton
        Left = 91
        Top = 119
        Width = 109
        Height = 25
        Caption = 'Renew license'
        TabOrder = 0
        OnClick = btnLicenseClick
      end
    end
  end
end
