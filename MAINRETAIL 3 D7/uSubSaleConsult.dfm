inherited SubSaleConsult: TSubSaleConsult
  Left = 188
  Top = 82
  Width = 543
  Height = 390
  Caption = 'SubSaleConsult'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFilter: TPanel [0]
    Left = 0
    Top = 34
    Width = 535
    Height = 141
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label4: TLabel
      Left = 9
      Top = 4
      Width = 32
      Height = 13
      Caption = 'Hold #'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 163
      Top = 4
      Width = 23
      Height = 13
      Caption = 'Date'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 9
      Top = 84
      Width = 89
      Height = 13
      Caption = 'Search Documents'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbParamSearch: TLabel
      Left = 163
      Top = 84
      Width = 23
      Height = 13
      Caption = 'Docs'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 9
      Top = 42
      Width = 50
      Height = 13
      Caption = 'Search for'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbSearchName: TLabel
      Left = 163
      Top = 42
      Width = 27
      Height = 13
      Caption = 'Name'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbStatus: TLabel
      Left = 282
      Top = 4
      Width = 31
      Height = 13
      Caption = 'Status'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dtCustFileDate: TDateBox
      Left = 161
      Top = 19
      Width = 113
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnChange = edtParamTextChange
      Language = Portuguese
    end
    object cbSearchFor: TComboBox
      Left = 6
      Top = 99
      Width = 137
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 5
      OnChange = cbSearchForChange
      Items.Strings = (
        ''
        'Customer Card'
        'Employee ID'
        'Federal ID #'
        'Social Security')
    end
    object edtParamText: TEdit
      Left = 161
      Top = 99
      Width = 199
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnChange = edtParamTextChange
    end
    object edtHold: TEdit
      Left = 6
      Top = 19
      Width = 137
      Height = 21
      TabOrder = 0
      OnChange = edtParamTextChange
    end
    object cbSearchForName: TComboBox
      Left = 6
      Top = 58
      Width = 137
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 3
      OnChange = cbSearchForNameChange
      Items.Strings = (
        ''
        'First Name'
        'Last Name'
        'Full Name')
    end
    object edtNameSearch: TEdit
      Left = 161
      Top = 58
      Width = 289
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = edtParamTextChange
    end
    object pnlAviso: TPanel
      Left = 464
      Top = 93
      Width = 65
      Height = 35
      BevelOuter = bvNone
      TabOrder = 8
      object btnExec: TSpeedButton
        Left = 5
        Top = 4
        Width = 56
        Height = 26
        Caption = '&GO!'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Layout = blGlyphRight
        ParentFont = False
        OnClick = btnExecClick
      end
    end
    object cbxHoldStatus: TComboBox
      Left = 280
      Top = 19
      Width = 171
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 1
      ParentFont = False
      TabOrder = 2
      Text = 'Confirmed Holds'
      OnChange = cbxHoldStatusChange
      Items.Strings = (
        ''
        'Confirmed Holds'
        'Canceled Holds')
    end
    object btnShowNote: TButton
      Left = 366
      Top = 99
      Width = 84
      Height = 21
      Caption = 'Show Notes'
      TabOrder = 7
      OnClick = btnShowNoteClick
    end
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 0
    Width = 535
    Height = 34
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object imgTopIni: TImage
      Left = 0
      Top = 0
      Width = 211
      Height = 34
      Align = alLeft
      Picture.Data = {
        07544269746D617066030000424D660300000000000036000000280000000800
        0000220000000100180000000000300300000000000000000000000000000000
        0000D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1DBDBDBDBDBDB
        DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBE7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
        E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E4E4E4E4E4E4
        E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E6E6E6E6E6E6E6E6E6E6E6E6E6E6
        E6E6E6E6E6E6E6E6E6E6E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E5E5E5E5E5E5E5E5E5E5E5E5E5E5
        E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
        E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E6E6E6E6E6E6
        E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E8E8E8E8E8E8
        E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8EDEDEDEDEDEDEDEDEDEDEDEDEDED
        EDEDEDEDEDEDEDEDEDEDECECECECECECECECECECECECECECECECECECECECECEC
        ECECEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
        EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
        EDEDEDEDEDEDEDEDEDEDECECECECECECECECECECECECECECECECECECECECECEC
        ECECEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEFEFEFEFEFEF
        EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
        EFEFF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0D9D9D9D9D9D9
        D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9}
      Stretch = True
    end
    object lblBasicFilter: TLabel
      Left = -20
      Top = 35
      Width = 681
      Height = 18
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clAqua
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Image1: TImage
      Left = 227
      Top = 0
      Width = 308
      Height = 34
      Align = alClient
      AutoSize = True
      Picture.Data = {
        07544269746D617076040000424D760400000000000036000000280000000A00
        0000220000000100180000000000400400000000000000000000000000000000
        0000BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
        0000A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3
        0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        0000C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
        0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        0000C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2
        0000C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        0000BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
        0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        0000C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
        0000C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2C2
        0000C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        0000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        0000BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
        0000C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
        0000C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7C7
        0000C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
        0000C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
        0000C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8
        0000CBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCB
        0000CFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCFCF
        0000CECECECECECECECECECECECECECECECECECECECECECECECECECECECECECE
        0000D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1
        0000D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4
        0000D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3D3
        0000D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6
        0000D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
        0000D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
        0000D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9D9
        0000CFCFCECFCFCECFCFCECFCFCECFCFCECFCFCECFCFCECFCFCECFCFCECFCFCE
        0000}
      Stretch = True
    end
    object lblSubMenu: TLabelEffect
      Left = 6
      Top = 6
      Width = 435
      Height = 28
      DepthShadow = 0
      DirectionHighlight = edDownRight
      ColourHighlight = clSilver
      GraduateFrom = clWindowText
      StyleHighlight = eoExtrude
      EffectStyle = esCustom
      ColourScheme = csCustom
      Caption = 'Search'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -17
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Image3: TImage
      Left = 211
      Top = 0
      Width = 16
      Height = 34
      Align = alLeft
      Picture.Data = {
        07544269746D61701E070000424D1E0700000000000036000000280000001100
        0000220000000100180000000000E80600000000000000000000000000000000
        0000D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1D1B4B4B5C7C7C6D7D7D6B4B4B5
        B4B4B5C7C7C6B4B4B5C7C7C6B4B4B5BBBBBBBBBBBB00DBDBDBDBDBDBDBDBDBDB
        DBDBDBDBDBDBDBDBC7C7C6B4B4B5C7C7C6C7C7C69C9D9D9C9D9D9C9D9D9C9D9D
        9C9D9DA3A3A3A3A3A300E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7D7
        D7D6B4B4B5D7D7D6C7C7C6C7C7C6C7C7C6C7C7C6B4B4B5BFBFBFBFBFBF00E5E5
        E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5C7C7C6B4B4B5D7D7D6C7
        C7C6B4B4B5C7C7C6C7C7C6C4C4C4C4C4C400E5E5E5E5E5E5E5E5E5E5E5E5E5E5
        E5E5E5E5E5E5E5E5E5E5E5E5E5C7C7C6B4B4B5D7D7D6C7C7C6B4B4B5C7C7C6C0
        C0C0C0C0C000E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4E4
        E4D7D7D6C7C7C6D7D7D6D7D7D6C7C7C6C7C7C6BFBFBFBFBFBF00E6E6E6E6E6E6
        E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E5E5E5C7C7C6B4B4B5E5E5
        E5C7C7C6C7C7C6BFBFBFBFBFBF00E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7D7D7D6C7C7C6D7D7D6D7D7D6C7C7C6C2C2C2C2C2
        C200E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E5E5E5C7C7C6C7C7C6D7D7D6B4B4B5C3C3C3C3C3C300E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7C7C7C6B4B4B5E5E5E5
        C7C7C6BBBBBBBBBBBB00E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
        E5E5E5E5E5E5E5E5E5E5E5D7D7D6C7C7C6D7D7D6D7D7D6BFBFBFBFBFBF00E5E5
        E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5
        E5E5B4B4B5C7C7C6D7D7D6C4C4C4C4C4C400E5E5E5E5E5E5E5E5E5E5E5E5E5E5
        E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5E5C7C7C6C7C7C6D7D7D6C2
        C2C2C2C2C200E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6
        E6E6E6E6E6E6E6E5E5E5C7C7C6B4B4B5E5E5E5C3C3C3C3C3C300E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7C7C7
        C69C9D9DE7E7E7C0C0C0C0C0C000E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7C7C7C69C9D9DE7E7E7BFBFBFBFBF
        BF00E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7D7D7D69C9D9DE7E7E7BFBFBFBFBFBF00E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7C7C7C69C9D9D
        E7E7E7BFBFBFBFBFBF00E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7C7C7C69C9D9DE7E7E7C4C4C4C4C4C400E7E7
        E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7
        E7E7C7C7C6B4B4B5E7E7E7C7C7C7C7C7C700E9E9E9E9E9E9E9E9E9E9E9E9E9E9
        E9E9E9E9E9E9E9E9E9E9E5E5E5E5E5E5E9E9E9E9E9E9C7C7C6B4B4B5E5E5E5C8
        C8C8C8C8C800E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
        E8E8E8E8E8E8E8E5E5E5C7C7C6C7C7C6D7D7D6C8C8C8C8C8C800EDEDEDEDEDED
        EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE5E5E5C7C7
        C6C7C7C6E5E5E5C8C8C8C8C8C800ECECECECECECECECECECECECECECECECECEC
        ECECECECECECECECECECECECECECECD7D7D6C7C7C6D7D7D6D7D7D6CBCBCBCBCB
        CB00EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
        E5E5E5D7D7D6B4B4B5EDEDEDC7C7C6CFCFCFCFCFCF00EDEDEDEDEDEDEDEDEDED
        EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDC7C7C6C7C7C6E5E5E5
        C7C7C6CECECECECECE00EDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDED
        EDEDEDEDEDEDEDEDD7D7D6C7C7C6D7D7D6E5E5E5C7C7C6D1D1D1D1D1D100ECEC
        ECECECECECECECECECECECECECECECECECECECECECECECECECE5E5E5D7D7D6B4
        B4B5E5E5E5D7D7D6D7D7D6D4D4D4D4D4D400EEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEE5E5E5C7C7C6D7D7D6D7D7D6D7D7D6D7D7D6D3
        D3D3D3D3D300EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
        EFC7C7C6C7C7C6E5E5E5D7D7D6D7D7D6D7D7D6D6D6D6D6D6D600EEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEED7D7D6B4B4B5E5E5E5D7D7D6D7D7
        D6E5E5E5D7D7D6D9D9D9D9D9D900EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF
        EFEFEFD7D7D6C7C7C6E5E5E5D7D7D6D7D7D6D7D7D6D7D7D6D7D7D6D9D9D9D9D9
        D900F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0E5E5E5C7C7C6D7D7D6E5E5E5
        D7D7D6D7D7D6D7D7D6D7D7D6D7D7D6D9D9D9D9D9D900D9D9D9D9D9D9D9D9D9D9
        D9D9D9D9D9D9D9D9C7C7C6C7C7C6E5E5E5C7C7C6C7C7C6C7C7C6C7C7C6C7C7C6
        C7C7C6CFCFCECFCFCE00}
      Stretch = True
    end
    object EspacamentoSuperior: TPanel
      Left = 0
      Top = 34
      Width = 535
      Height = 0
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      Visible = False
      object EEE: TPanel
        Left = 0
        Top = 0
        Width = 535
        Height = 2
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 0
        Visible = False
      end
    end
  end
  object grdBrowse: TcxGrid [2]
    Left = 0
    Top = 175
    Width = 535
    Height = 188
    Align = alClient
    TabOrder = 2
    LookAndFeel.Kind = lfFlat
    object grdBrowseDB: TcxGridDBTableView
      DataController.DataSource = dsPreSale
      DataController.Filter.Criteria = {FFFFFFFF0000000000}
      DataController.KeyFieldNames = 'IDPreSale'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ValorNominal'
        end>
      DataController.Summary.SummaryGroups = <>
      Filtering.MaxDropDownCount = 50
      Filtering.Visible = fvNever
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnFiltering = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellEndEllipsis = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glHorizontal
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfVisibleWhenExpanded
      OptionsView.HeaderAutoHeight = True
      OptionsView.HeaderEndEllipsis = True
      Preview.Column = grdBrowseDBNote
      Preview.MaxLineCount = 5
      object grdBrowseDBSaleCode: TcxGridDBColumn
        DataBinding.FieldName = 'SaleCode'
        Width = 66
      end
      object grdBrowseDBCustomer: TcxGridDBColumn
        DataBinding.FieldName = 'Pessoa'
        Width = 297
      end
      object grdBrowseDBPessoaFirstName: TcxGridDBColumn
        DataBinding.FieldName = 'PessoaFirstName'
        Visible = False
        Width = 114
      end
      object grdBrowseDBPessoaLastName: TcxGridDBColumn
        DataBinding.FieldName = 'PessoaLastName'
        Visible = False
        Width = 120
      end
      object grdBrowseDBPreSaleDate: TcxGridDBColumn
        DataBinding.FieldName = 'PreSaleDate'
        Width = 84
      end
      object grdBrowseDBTotInvoice: TcxGridDBColumn
        DataBinding.FieldName = 'TotInvoice'
        Width = 86
      end
      object grdBrowseDBNote: TcxGridDBColumn
        DataBinding.FieldName = 'Note'
      end
    end
    object grdBrowseLevel: TcxGridLevel
      GridView = grdBrowseDB
    end
  end
  object quPreSale: TADOQuery [3]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quPreSaleCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'I.IDPreSale,'
      #9'I.PreSaleDate,'
      #9'I.SaleCode,'
      #9'I.Note,'
      #9'P.PessoaFirstName,'
      #9'P.PessoaLastName,'
      #9'P.Pessoa,'
      
        #9'(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNu' +
        'll(I.AditionalExpenses, 0)) as TotalInvoice,'
      
        #9'(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax) as Su' +
        'bTotalInvoice,'
      #9'I.IDTouristGroup,'
      #9'I.OtherComissionID,'
      
        #9'('#9'SELECT SUM(IP.SubTotal - IP.InvoiceDiscount - IP.ItemDiscount' +
        ' + IP.Tax + IsNull(IP.AditionalExpenses, 0))'
      #9#9'FROM Invoice IP'
      #9#9'WHERE IP.IDPreSaleParent = I.IDPreSale'
      #9') as TotalParent,'
      
        #9'('#9'SELECT SUM(IP.SubTotal - IP.InvoiceDiscount - IP.ItemDiscount' +
        ' + IP.Tax)'
      #9#9'FROM Invoice IP'
      #9#9'WHERE IP.IDPreSaleParent = I.IDPreSale'
      #9') as SubTotalParent'
      'FROM'
      #9'Invoice I (NOLOCK)'
      #9'INNER JOIN Pessoa P (NOLOCK) ON I.IDCustomer = P.IDPessoa'
      
        #9'LEFT OUTER JOIN DeliverType DT (NOLOCK) ON (DT.IDDeliverType = ' +
        'I.DeliverTypeID)'
      'WHERE'
      #9'P.IDTipoPessoa = 1'
      #9'AND I.IDInvoice Is Null'
      #9'AND I.Layaway = 1'
      #9'AND I.Canceled = 0'
      #9'AND I.PreSaleDate <= GetDate()')
    Left = 135
    Top = 250
    object quPreSaleIDPreSale: TIntegerField
      DisplayLabel = 'Number'
      FieldName = 'IDPreSale'
    end
    object quPreSalePreSaleDate: TDateTimeField
      DisplayLabel = 'Date'
      FieldName = 'PreSaleDate'
    end
    object quPreSalePessoaFirstName: TStringField
      DisplayLabel = 'First Name'
      FieldName = 'PessoaFirstName'
      Size = 30
    end
    object quPreSalePessoaLastName: TStringField
      DisplayLabel = 'Last Name'
      FieldName = 'PessoaLastName'
      Size = 30
    end
    object quPreSaleIDTouristGroup: TIntegerField
      FieldName = 'IDTouristGroup'
      Visible = False
    end
    object quPreSaleOtherComissionID: TIntegerField
      FieldName = 'OtherComissionID'
      Visible = False
    end
    object quPreSalePessoa: TStringField
      DisplayLabel = 'Customer'
      FieldName = 'Pessoa'
      Size = 50
    end
    object quPreSaleSaleCode: TStringField
      DisplayLabel = 'Hold #'
      FieldName = 'SaleCode'
    end
    object quPreSaleTotalInvoice: TBCDField
      FieldName = 'TotalInvoice'
      ReadOnly = True
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object quPreSaleTotalParent: TBCDField
      FieldName = 'TotalParent'
      ReadOnly = True
      Precision = 19
    end
    object quPreSaleTotInvoice: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TotInvoice'
      DisplayFormat = '#,##0.00##'
      Calculated = True
    end
    object quPreSaleSubTotalInvoice: TBCDField
      FieldName = 'SubTotalInvoice'
      ReadOnly = True
      DisplayFormat = '#,##0.00##'
      Precision = 19
    end
    object quPreSaleSubTotalParent: TBCDField
      FieldName = 'SubTotalParent'
      ReadOnly = True
      Precision = 19
    end
    object quPreSaleNote: TStringField
      FieldName = 'Note'
      Size = 150
    end
  end
  object dsPreSale: TDataSource [4]
    DataSet = quPreSale
    Left = 135
    Top = 206
  end
  object TimeAviso: TTimer [5]
    Enabled = False
    Interval = 300
    OnTimer = TimeAvisoTimer
    Left = 233
    Top = 242
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_SubSaleConsult.sil'
  end
end
