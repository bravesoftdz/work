inherited FrmSERASA: TFrmSERASA
  Left = -3
  Top = -1
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'SERASA'
  ClientHeight = 559
  ClientWidth = 794
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 518
    Width = 794
    inherited EspacamentoInferior: TPanel
      Width = 794
      inherited Panel3: TPanel
        Width = 794
      end
    end
    inherited hhh: TPanel
      Left = 507
      Width = 287
      inherited sbHelp: TSpeedButton
        Left = 4
      end
      inherited btClose: TButton
        Left = 215
        ModalResult = 2
      end
      object btnSearch: TButton
        Left = 145
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Search'
        TabOrder = 1
        TabStop = False
        OnClick = btnSearchClick
      end
      object btnPrint: TButton
        Left = 74
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Print'
        TabOrder = 2
        TabStop = False
        OnClick = btnPrintClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Height = 512
  end
  inherited EspacamentoDireito: TPanel
    Left = 791
    Height = 512
  end
  inherited EspacamentoSuperior: TPanel
    Width = 794
  end
  object Panel5: TPanel [4]
    Left = 3
    Top = 6
    Width = 223
    Height = 512
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
    object Panel2: TPanel
      Left = 1
      Top = 92
      Width = 218
      Height = 229
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object Shape1: TShape
        Left = 0
        Top = 0
        Width = 218
        Height = 229
        Align = alClient
        Brush.Color = clBtnFace
        Pen.Color = clGray
        Shape = stRoundRect
      end
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 222
        Height = 23
        Alignment = taCenter
        AutoSize = False
        Caption = 'Check'
        Color = 12615680
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label2: TLabel
        Left = 25
        Top = 131
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'Initial :'
      end
      object Label3: TLabel
        Left = 29
        Top = 154
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'Final :'
      end
      object Label4: TLabel
        Left = 28
        Top = 31
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Bank :'
      end
      object lbDate: TLabel
        Left = 28
        Top = 181
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date :'
      end
      object lbAmount: TLabel
        Left = 14
        Top = 205
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = 'Amount :'
      end
      object Label8: TLabel
        Left = 27
        Top = 56
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Type :'
      end
      object Label14: TLabel
        Left = 18
        Top = 82
        Width = 40
        Height = 13
        Alignment = taRightJustify
        Caption = 'Branch :'
      end
      object Label15: TLabel
        Left = 12
        Top = 106
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'Account :'
      end
      object scBank: TSuperComboADO
        Left = 63
        Top = 26
        Width = 141
        Height = 21
        TabStop = False
        Color = clSilver
        ReadOnly = True
        TabOrder = 1
        LookUpSource = DM.dsLookUpBank
        DropDownRows = 10
        ShowBtnAddNew = False
        ShowBtnUpdate = False
        IDLanguage = 0
      end
      object EditDepositDate: TDateBox
        Tag = 2
        Left = 63
        Top = 177
        Width = 141
        Height = 21
        TabStop = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        InputTime = False
        Language = Portuguese
      end
      object edtAmount: TEdit
        Left = 63
        Top = 201
        Width = 141
        Height = 21
        TabStop = False
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
      end
      object cmbTipoConsulta: TComboBox
        Left = 63
        Top = 52
        Width = 142
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = '1 - N'#250'mero do Cheque'
        OnChange = cmbTipoConsultaChange
        Items.Strings = (
          '1 - N'#250'mero do Cheque'
          '2 - CMC7')
      end
      object pnlInitial: TPanel
        Left = 63
        Top = 127
        Width = 142
        Height = 21
        TabOrder = 4
        object edtInitialCheck: TEdit
          Left = -1
          Top = 0
          Width = 122
          Height = 21
          TabStop = False
          Color = clSilver
          MaxLength = 30
          ReadOnly = True
          TabOrder = 0
        end
        object edtDigitiIni: TEdit
          Left = 122
          Top = 0
          Width = 18
          Height = 21
          MaxLength = 1
          TabOrder = 1
        end
      end
      object pnlFinal: TPanel
        Left = 63
        Top = 152
        Width = 142
        Height = 21
        TabOrder = 5
        object edtFinalCheck: TEdit
          Left = -1
          Top = 0
          Width = 122
          Height = 21
          TabStop = False
          Color = clSilver
          MaxLength = 30
          ReadOnly = True
          TabOrder = 0
        end
        object edtDigitEnd: TEdit
          Left = 122
          Top = 0
          Width = 18
          Height = 21
          MaxLength = 1
          TabOrder = 1
        end
      end
      object edtBranch: TEdit
        Left = 63
        Top = 77
        Width = 141
        Height = 21
        MaxLength = 30
        TabOrder = 2
      end
      object edtAccount: TEdit
        Left = 63
        Top = 101
        Width = 141
        Height = 21
        MaxLength = 30
        TabOrder = 3
      end
    end
    object pnlCustomer: TPanel
      Left = 2
      Top = 2
      Width = 218
      Height = 88
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      object shpHelp: TShape
        Left = 0
        Top = 0
        Width = 218
        Height = 88
        Align = alClient
        Brush.Color = clBtnFace
        Pen.Color = clGray
        Shape = stRoundRect
      end
      object lbCustomerInfo: TLabel
        Left = 0
        Top = 0
        Width = 221
        Height = 17
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
        Left = 23
        Top = 23
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Name :'
      end
      object lbDoc: TLabel
        Left = 32
        Top = 44
        Width = 25
        Height = 13
        Alignment = taRightJustify
        Caption = 'Doc :'
      end
      object lbPhone: TLabel
        Left = 19
        Top = 67
        Width = 37
        Height = 13
        Alignment = taRightJustify
        Caption = 'Phone :'
      end
      object edtName: TEdit
        Left = 63
        Top = 19
        Width = 145
        Height = 21
        TabStop = False
        Color = clSilver
        ReadOnly = True
        TabOrder = 0
      end
      object edtCustomerDocument: TEdit
        Left = 63
        Top = 41
        Width = 145
        Height = 21
        TabStop = False
        Color = clSilver
        ReadOnly = True
        TabOrder = 1
      end
      object edtPhone: TEdit
        Left = 95
        Top = 63
        Width = 113
        Height = 21
        TabStop = False
        Color = clSilver
        ReadOnly = True
        TabOrder = 3
      end
      object edtDDD: TEdit
        Left = 63
        Top = 63
        Width = 25
        Height = 21
        MaxLength = 3
        TabOrder = 2
        Text = '021'
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 323
      Width = 218
      Height = 189
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      object Shape2: TShape
        Left = 0
        Top = 0
        Width = 218
        Height = 189
        Align = alClient
        Brush.Color = clBtnFace
        Pen.Color = clGray
        Shape = stRoundRect
      end
      object Label5: TLabel
        Left = 0
        Top = 0
        Width = 221
        Height = 19
        Alignment = taCenter
        AutoSize = False
        Caption = 'SERASA login'
        Color = clGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label6: TLabel
        Left = 28
        Top = 118
        Width = 29
        Height = 13
        Alignment = taRightJustify
        Caption = 'User :'
      end
      object Label7: TLabel
        Left = 34
        Top = 141
        Width = 23
        Height = 13
        Alignment = taRightJustify
        Caption = 'PW :'
      end
      object Label9: TLabel
        Left = 5
        Top = 25
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'Server IP :'
      end
      object Label10: TLabel
        Left = 30
        Top = 48
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Port :'
      end
      object Label11: TLabel
        Left = 31
        Top = 71
        Width = 25
        Height = 13
        Alignment = taRightJustify
        Caption = 'Doc :'
      end
      object Label12: TLabel
        Left = 15
        Top = 94
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'Station :'
      end
      object sbEditConnection: TSpeedButton
        Left = 196
        Top = 1
        Width = 19
        Height = 17
        Flat = True
        Glyph.Data = {
          76030000424D7603000000000000360000002800000011000000100000000100
          18000000000040030000C40E0000C40E00000000000000000000CED3D6CED3D6
          CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6CED3D60000000000000000
          00000000CED3D6CED3D6CED3D600CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6
          CED3D6CED3D6CED3D6000000FFFFFFFFFFFFFFFFFFFFFFFF000000CED3D6CED3
          D600CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6CED3D6000000FFFFFF
          FFFFFFFFFFFF008000FFFFFFFFFFFF000000CED3D600CED3D600000000000000
          0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF008000008000
          FFFFFFFFFFFF00000000CED3D6000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          0000FFFFFF00800000800000800000FF0000FF00008000FFFFFF00000000CED3
          D6000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF00FF0000FF0000
          FF0000FF0000FF0000FF00FFFFFF00000000CED3D6000000FFFFFFFFFFFF8400
          00840000FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00FF0000FF00FFFFFFFF
          FFFF00000000CED3D6000000FFFFFFFFFFFF840000848284FFFFFFFFFFFF0000
          00FFFFFFFFFFFFFFFFFF00FF00FFFFFFFFFFFF000000CED3D600CED3D6000000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
          FFFFFFFF000000CED3D6CED3D600CED3D6000000FFFFFFFFFFFF840000840000
          FFFFFF840000840000840000000000000000000000000000CED3D6CED3D6CED3
          D600CED3D6000000FFFFFFFFFFFF840000848284FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF000000CED3D6CED3D6CED3D600CED3D6000000FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
          CED3D6CED3D6CED3D600CED3D6000000FFFFFFFFFFFF840000840000FFFFFF84
          0000840000840000840000FFFFFFFFFFFF000000CED3D6CED3D6CED3D600CED3
          D6000000FFFFFFFFFFFF840000848284FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF000000CED3D6CED3D6CED3D600CED3D6000000FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000CED3D6CE
          D3D6CED3D600CED3D60000000000000000000000000000000000000000000000
          00000000000000000000000000000000CED3D6CED3D6CED3D600}
        OnClick = sbEditConnectionClick
      end
      object Label13: TLabel
        Left = 18
        Top = 165
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Option :'
      end
      object edtLogin: TEdit
        Left = 63
        Top = 114
        Width = 145
        Height = 21
        Color = clSilver
        ReadOnly = True
        TabOrder = 4
        OnChange = edtServerChange
      end
      object edtPw: TEdit
        Left = 63
        Top = 138
        Width = 145
        Height = 21
        Color = clSilver
        PasswordChar = '*'
        ReadOnly = True
        TabOrder = 5
        OnChange = edtServerChange
      end
      object edtServer: TEdit
        Left = 63
        Top = 21
        Width = 145
        Height = 21
        Color = clSilver
        ReadOnly = True
        TabOrder = 0
        OnChange = edtServerChange
      end
      object edtPort: TEdit
        Left = 63
        Top = 45
        Width = 145
        Height = 21
        Color = clSilver
        ReadOnly = True
        TabOrder = 1
        OnChange = edtServerChange
      end
      object edtDoc: TEdit
        Left = 63
        Top = 67
        Width = 145
        Height = 21
        Color = clSilver
        ReadOnly = True
        TabOrder = 2
        OnChange = edtServerChange
      end
      object edtStation: TEdit
        Left = 63
        Top = 91
        Width = 145
        Height = 21
        Color = clSilver
        ReadOnly = True
        TabOrder = 3
        OnChange = edtServerChange
      end
      object cmbOpcaoConsulta: TComboBox
        Left = 63
        Top = 160
        Width = 146
        Height = 21
        Style = csDropDownList
        Color = clSilver
        Enabled = False
        ItemHeight = 13
        TabOrder = 6
        OnChange = edtServerChange
        Items.Strings = (
          'PF'
          'CH'
          'CP')
      end
    end
  end
  object webResult: TWebBrowser [5]
    Left = 226
    Top = 6
    Width = 565
    Height = 512
    Align = alClient
    TabOrder = 5
    ControlData = {
      4C000000653A0000EB3400000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmSERASA.sil'
  end
end
