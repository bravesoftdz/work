inherited FrmPayPartial: TFrmPayPartial
  Left = 64
  Top = 119
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pay Partial'
  ClientHeight = 311
  ClientWidth = 632
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnDel: TSpeedButton [0]
    Left = 435
    Top = 128
    Width = 77
    Height = 25
    Caption = '&Delete'
    Margin = 0
    OnClick = btnDelClick
  end
  object btnAdd: TSpeedButton [1]
    Left = 435
    Top = 101
    Width = 77
    Height = 25
    Caption = '&Add'
    Margin = 0
    OnClick = btnAddClick
  end
  object sbSerasa: TSpeedButton [2]
    Left = 435
    Top = 155
    Width = 77
    Height = 25
    Caption = '&Serasa'
    Glyph.Data = {
      1E060000424D1E06000000000000360000002800000018000000150000000100
      180000000000E805000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF4239632929524A4A63736B84FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF31215273425A52315229215218184A
      18184A2929524A4A63737384FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B73946B4263EFA584EF
      B58CDE9C84BD7B739C636B6B39524A295229215218185210184A29214A4A4A63
      737384FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3131
      63AD636BFFBD8CFFCE94FFCEA5FFD6ADFFDEBDFFE7CEEFCEC6D69C94BD84849C
      636B6B425A4A295231215218104AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF29215AD67B73FFB584FFB584FFB584FFBD8CFFC69CFFD6ADFFE7
      C6FFD6BDFFD6B5FFD6BDF7CEBDE7B5ADCE9C9C6B5A7BFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF84849C63395AEF9473FFB57BFFB584FFBD8CFFBD8C
      FFC68CFFBD94FFBD94FFC69CFFCEADFFDEC6F7E7D6C6ADA5B5ADB5FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1818526B3952F7844AFF8C52FF
      9C63FFA56BFFB57BFFBD8CFFC694FFCE94FFC694FFD6ADFFDEBDFFD6B5847B73
      52525AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2929630808
      4A29184A52314A7B424AAD5A4ACE6B4AE77B4AFF945AFFA56BFFAD73FFAD7BFF
      B584FFC69CA59C946B6363737373FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF73739408085210105210185210185A10216318216329296339315A5A42
      5A845252A5635ACE7B5AE78C635A42528C8C8C4A4A4AFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFA59CA57B7B8C08105210185A18216318296318296B21316B
      21316B21317321397321397B29397B21397B31427318185263636B7373736B6B
      6BFFFFFFFFFFFFFFFFFFFFFFFF73737B948C9473737B18185218296B18296B21
      316B21317321397321397321427B29427B294A84294A84294A8C31528C29427B
      3931528C8C8C4A4A52FFFFFFFFFFFFFFFFFFBDBDBDADADADC6D6DEBDD6DE424A
      7B29427B29427B21397B21427B21427B29427B294A84314A8431528C31528C31
      5294395A94395A94182152737373848484635A63FFFFFFFFFFFFBDBDBDB5B5B5
      6BB5DE1894DE106BB518317B21427B314A8431528C395A9442639C42639C3963
      9C42639C39639C39639C39639C426B9C29397B5A5A6B9494945A525A9C9C9CFF
      FFFFBDBDBDB5B5B573B5DE1894DE1094DE1094DE108CD6107BC60873BD0863AD
      08529C4263945A5A84394A7B394284314A84395A9442639C426BA539395A9C9C
      9C7373735A525AFFFFFFBDBDBDB5B5B5DEE7E7C6DEE7B5D6E79CCEE78CC6E773
      BDE75AB5E742ADE731A5DE9CCEEFD6D6D6A57B52DEA56BD69C73CECECE6B637B
      6B6B8CADADC6FFFFFF7B7B7B636363ADA5ADBDBDBDB5B5B5E7E7E7E7E7E7EFE7
      EFEFE7EFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFF7F7D6D6D69C5A21CE6300CE
      6300FFF7E7948C94C6BDC6FFFFFFFFFFFFFFFFFF8C8C8CFFFFFFBDBDBDB5B5B5
      DEAD84D68442DE9452DE9C63DEAD7BE7B58CE7C6A5E7D6BDF7E7CEF7F7EFDEDE
      DEAD845ADE9452DE944AFFF7EF948C94CEC6C6FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFBDBDBDB5B5B5DE9C63CE6300CE6300CE6300CE6300CE6300CE6300CE6300
      CE6300E7BD8CD6DEDE8C8C8CBDB5BDBDC6BDBDC6C67B7B7BFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFC6BDC6B5B5ADDEBD9CD68C4AD68C42D68431D67B29CE
      7321D67310CE6B08CE6300EFBD94DEDEDE737373D6D6D6D6D6D6CECECEFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484ADADADBDBDBDBDBD
      BDCECEC6CECECEDED6D6DED6D6EFE7DEEFE7DEF7F7EFBDBDBD949494FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFCECECECECECEBDBDBDBDB5BDB5ADB5ADADADADADADADADAD9C9C9CA5A5
      A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF}
    Margin = 0
    OnClick = sbSerasaClick
  end
  object lblConsulta: TLabel [3]
    Left = 435
    Top = 192
    Width = 138
    Height = 13
    Caption = 'Fazer Consulta SERASA'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  inherited Panel1: TPanel
    Top = 270
    Width = 632
    TabOrder = 7
    inherited EspacamentoInferior: TPanel
      Width = 632
      inherited Panel3: TPanel
        Width = 632
      end
    end
    inherited hhh: TPanel
      Left = 421
      Width = 211
      object btnDelAll: TSpeedButton [1]
        Left = 145
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Cancel'
        OnClick = btnDelAllClick
      end
      inherited btClose: TButton
        Left = 75
        Caption = '&OK'
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 264
    TabOrder = 0
  end
  inherited EspacamentoDireito: TPanel
    Left = 629
    Height = 264
    TabOrder = 1
  end
  inherited EspacamentoSuperior: TPanel
    Width = 632
    TabOrder = 2
  end
  object cmbPaymentType: TSuperComboADO [8]
    Tag = 1
    Left = 437
    Top = 227
    Width = 154
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    Text = 'cmbPaymentType'
    Visible = False
    LookUpSource = DM.dsLookUpMeioPag
    DropDownRows = 18
    ShowBtnAddNew = False
    ShowBtnUpdate = False
    IDLanguage = 0
  end
  object pnlCustomer: TPanel [9]
    Left = 437
    Top = 9
    Width = 189
    Height = 88
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 5
    object shpHelp: TShape
      Left = 0
      Top = 0
      Width = 189
      Height = 88
      Align = alClient
      Brush.Color = clBtnFace
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object lbCustomerInfo: TLabel
      Left = 0
      Top = 0
      Width = 194
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Customer'
      Color = 12615680
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lbName: TLabel
      Left = 15
      Top = 19
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'Name :'
    end
    object lbDoc: TLabel
      Left = 24
      Top = 42
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Caption = 'Doc :'
    end
    object lbPhone: TLabel
      Left = 12
      Top = 66
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Phone :'
    end
    object edtName: TEdit
      Left = 55
      Top = 15
      Width = 125
      Height = 21
      TabOrder = 0
    end
    object edtCustomerDocument: TEdit
      Left = 55
      Top = 39
      Width = 125
      Height = 21
      TabOrder = 1
    end
    object edtPhone: TEdit
      Left = 86
      Top = 62
      Width = 92
      Height = 21
      TabOrder = 3
    end
    object edtDDD: TEdit
      Left = 55
      Top = 62
      Width = 28
      Height = 21
      TabOrder = 2
    end
  end
  object pnlPaymentInfo: TPanel [10]
    Left = 5
    Top = 9
    Width = 424
    Height = 88
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 4
    object Shape1: TShape
      Left = 0
      Top = 0
      Width = 424
      Height = 88
      Align = alClient
      Brush.Color = clBtnFace
      Pen.Color = clGray
      Shape = stRoundRect
    end
    object lbPayment: TLabel
      Left = 0
      Top = 0
      Width = 427
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'PaymentInfo'
      Color = 12615680
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object pnlEdit: TPanel
      Left = 4
      Top = 15
      Width = 261
      Height = 69
      BevelOuter = bvNone
      TabOrder = 0
      object pnlFinalNumber: TPanel
        Left = 0
        Top = 68
        Width = 261
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object lbCheckEnd: TLabel
          Left = 7
          Top = 8
          Width = 61
          Height = 13
          Alignment = taRightJustify
          Caption = 'Final Check :'
        end
        object edtFinalNumber: TEdit
          Left = 74
          Top = 4
          Width = 66
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '0'
          OnChange = edtFinalNumberChange
          OnKeyPress = edtAmountKeyPress
        end
      end
      object pnlInitialNumber: TPanel
        Left = 0
        Top = 45
        Width = 261
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lbIniCheck: TLabel
          Left = 3
          Top = 6
          Width = 65
          Height = 13
          Alignment = taRightJustify
          Caption = 'Initial Check :'
        end
        object edtInitialNumber: TEdit
          Left = 74
          Top = 2
          Width = 67
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '0'
          OnChange = edtInitialNumberChange
          OnKeyPress = edtAmountKeyPress
        end
      end
      object pnlBank: TPanel
        Left = 0
        Top = 22
        Width = 261
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbBank: TLabel
          Left = 38
          Top = 6
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'Bank :'
        end
        object scBank: TSuperComboADO
          Left = 74
          Top = 2
          Width = 183
          Height = 21
          TabOrder = 0
          LookUpSource = DM.dsLookUpBank
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
      end
      object pnlFrequency: TPanel
        Left = 0
        Top = 0
        Width = 261
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
        object lbFrequency: TLabel
          Left = 10
          Top = 5
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Frequency :'
        end
        object edtFrequency: TEdit
          Left = 75
          Top = 1
          Width = 69
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '1'
          OnChange = edtFrequencyChange
          OnKeyPress = edtFrequencyKeyPress
        end
      end
    end
    object pnlDepositDate: TPanel
      Left = 266
      Top = 16
      Width = 157
      Height = 26
      BevelOuter = bvNone
      TabOrder = 1
      object lbDate: TLabel
        Left = 16
        Top = 5
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date :'
      end
      object EditDepositDate: TDateBox
        Tag = 2
        Left = 49
        Top = 1
        Width = 101
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        InputTime = False
        Language = Portuguese
      end
    end
    object pnlAmount: TPanel
      Left = 265
      Top = 39
      Width = 158
      Height = 24
      BevelOuter = bvNone
      TabOrder = 2
      object lbAmount: TLabel
        Left = 2
        Top = 5
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = 'Amount :'
      end
      object edtAmount: TEdit
        Left = 50
        Top = 1
        Width = 100
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = '0'
        OnKeyPress = edtAmountKeyPress
      end
    end
    object pnlPaymentPlace: TPanel
      Left = 256
      Top = 62
      Width = 161
      Height = 20
      BevelOuter = bvNone
      TabOrder = 3
      object lblPaymentPlace: TLabel
        Left = 10
        Top = 7
        Width = 45
        Height = 13
        Caption = 'P. Place :'
      end
      object cmbPaymentPlace: TComboBox
        Left = 59
        Top = 1
        Width = 101
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Store'
        Items.Strings = (
          'Store'
          'Outside'
          'Other'
          '')
      end
    end
  end
  object pnlPayments: TPanel [11]
    Left = 4
    Top = 100
    Width = 424
    Height = 168
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 6
    object Shape2: TShape
      Left = 0
      Top = 0
      Width = 424
      Height = 168
      Align = alClient
      Brush.Color = clBtnFace
      Pen.Color = clGray
    end
    object lbPayments: TLabel
      Left = 0
      Top = 0
      Width = 435
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'Payments'
      Color = clTeal
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object tvPartialPay: TTreeView
      Left = 2
      Top = 15
      Width = 122
      Height = 148
      HideSelection = False
      Images = ImageList1
      Indent = 30
      TabOrder = 0
      OnChange = tvPartialPayChange
      OnClick = tvPartialPayClick
    end
    object pnlPayDetail: TPanel
      Left = 127
      Top = 27
      Width = 295
      Height = 136
      BevelOuter = bvNone
      TabOrder = 1
      object pnlOBSDetail: TPanel
        Left = 0
        Top = 94
        Width = 295
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 4
        Visible = False
        object lbPOBS: TLabel
          Left = 20
          Top = 6
          Width = 27
          Height = 13
          Caption = 'OBS :'
        end
        object sbSaveOBS: TSpeedButton
          Left = 271
          Top = 2
          Width = 23
          Height = 22
          Glyph.Data = {
            96030000424D960300000000000036000000280000000F000000120000000100
            18000000000060030000C40E0000C40E00000000000000000000FF00FF000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000FF00FF000000848284C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6
            C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6C6C3C6000000000000848284FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFC6C3C6000000000000848284FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C3C6000000000000848284FFFFFF
            FFFFFF000000000000000000000000000000000000000000000000FFFFFFFFFF
            FFC6C3C6000000000000848284FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C3C6000000000000848284FFFFFF
            FFFFFF000000000000000000000000FFFFFF000000000000000000FFFFFFFFFF
            FFC6C3C6000000000000848284FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C3C6000000000000848284FFFFFF
            FFFFFF000000000000000000000000000000000000000000000000FFFFFFFFFF
            FFC6C3C600000000000000000000000000000000000000000000000000000000
            0000000000FFFFFFFFFFFFFFFFFFFFFFFFC6C3C6000000000000000000008080
            000000000000000000FFFFFF000000008080000000FFFFFF000000FFFFFFFFFF
            FFC6C3C600000000000000000000808000000000000000000000000000000000
            8080000000FFFFFFFFFFFFFFFFFFFFFFFFC6C3C6000000000000000000008080
            008080008080008080008080008080008080000000000000000000FFFFFFFFFF
            FFC6C3C600000000000000000000808000808000808000808000808000808000
            8080000000FFFFFFFFFFFFFFFFFFFFFFFFC6C3C6000000000000000000008080
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080000000FFFFFFFFFFFFFFFFFFFFFF
            FFC6C3C6000000000000000000008080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
            8080000000FFFFFF000000FFFFFF000000FFFFFF000000000000000000008080
            C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0008080000000848284FFFFFF848284FFFF
            FF000000FF00FF00000000000000000000000000000000000000000000000000
            0000000000FF00FF000000FF00FF000000FF00FFFF00FF000000}
          OnClick = sbSaveOBSClick
        end
        object edtOBS: TEdit
          Left = 55
          Top = 3
          Width = 215
          Height = 21
          MaxLength = 255
          TabOrder = 0
          OnExit = edtOBSExit
        end
      end
      object pnlAmountDetail: TPanel
        Left = 0
        Top = 71
        Width = 295
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 3
        Visible = False
        object lbPAmount: TLabel
          Left = 5
          Top = 6
          Width = 44
          Height = 13
          Alignment = taRightJustify
          Caption = 'Amount :'
        end
        object edtValue: TEdit
          Left = 56
          Top = 3
          Width = 121
          Height = 21
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object pnlDocDetail: TPanel
        Left = 0
        Top = 46
        Width = 295
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 2
        Visible = False
        object lbPDoc: TLabel
          Left = 23
          Top = 7
          Width = 25
          Height = 13
          Alignment = taRightJustify
          Caption = 'Doc :'
        end
        object edtDoc: TEdit
          Left = 56
          Top = 4
          Width = 121
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 0
        end
      end
      object pnlDateDetail: TPanel
        Left = 0
        Top = 23
        Width = 295
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        Visible = False
        object lbPDate: TLabel
          Left = 19
          Top = 5
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data :'
        end
        object edtDate: TDateBox
          Tag = 2
          Left = 56
          Top = 3
          Width = 101
          Height = 21
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          InputTime = False
          Language = Portuguese
        end
      end
      object pnlBankDetail: TPanel
        Left = 0
        Top = 0
        Width = 295
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        Visible = False
        object lbPBank: TLabel
          Left = 18
          Top = 4
          Width = 30
          Height = 13
          Alignment = taRightJustify
          Caption = 'Bank :'
        end
        object scBankEdit: TSuperComboADO
          Left = 56
          Top = 2
          Width = 184
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 0
          LookUpSource = DM.dsLookUpBank
          DropDownRows = 10
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
      end
    end
  end
  object ImageList1: TImageList [12]
    Left = 368
    Top = 8
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001001000000000000008
      000000000000000000000000000000000000000000000000E830A528AE410000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000086280E2D85286324
      A528293100000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000009535FF463F535F57
      9F673D6317429335A92886280000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FA39DF42DF42FF46
      5F579F635F5B5F5FDC56794E0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000104E5D3ADF3EFF46FF46
      FF4AFF4A3F577F63B852B65A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5306524CA247525B925
      5F2E9F36BF3EDF42744A8D310000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE494228622882308330
      C72C0B2D942DF92D0B2931460000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000007452EF45622C8330A334C434
      C438E438E53CE43C63288C35AD35000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F75E586F576F053D053D043D043D
      25412641464546496749832810426C3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F75ECD6E436EC33C043D46456749
      884D874D874D874DA84DE53C524A4B2D00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F75ECE6E436E426E226AC15D8155
      88496B4107412641884DA851734ECE3900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F75E9C739C739D77BD77BD77BD77
      DD7B5A6B99019901324AF8620000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F75EBB421A227B32BB3E1C535C5F
      DE777B6F5B2A5B26324A19630000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F75E7B3299019901990199019901
      FC467A6FD75E175FEF3D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000B556F75E396339675B6B9D6F
      DE77F75E00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003967F75ED75EB556B556
      734E945200000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E3FF000000000000E07F000000000000
      E007000000000000E007000000000000C007000000000000C007000000000000
      C007000000000000800300000000000000010000000000000001000000000000
      000100000000000000070000000000000007000000000000000F000000000000
      807F000000000000C07F00000000000000000000000000000000000000000000
      000000000000}
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmPayPartial.sil'
  end
end
