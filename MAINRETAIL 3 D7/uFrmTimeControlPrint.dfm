inherited frmTimeControlPrint: TfrmTimeControlPrint
  Left = 215
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Preview'
  ClientHeight = 153
  ClientWidth = 371
  Font.Charset = ANSI_CHARSET
  Font.Name = 'Tahoma'
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [0]
    Left = 43
    Top = 67
    Width = 24
    Height = 13
    Alignment = taRightJustify
    Caption = 'From'
  end
  object Label3: TLabel [1]
    Left = 206
    Top = 69
    Width = 12
    Height = 13
    Alignment = taRightJustify
    Caption = 'To'
  end
  object edtDateIni: TDateBox [2]
    Left = 74
    Top = 64
    Width = 103
    Height = 21
    TabOrder = 0
    InputTime = False
    Language = Portuguese
    FirstDayOfWeek = Wednesday
  end
  object edtDateFim: TDateBox [3]
    Left = 224
    Top = 65
    Width = 97
    Height = 21
    TabOrder = 1
    InputTime = False
    Language = Portuguese
    FirstDayOfWeek = Wednesday
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 116
    Width = 371
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object spHelp: TSpeedButton
      Tag = 5
      Left = 167
      Top = 5
      Width = 66
      Height = 31
      Caption = '&Help'
      Glyph.Data = {
        0E060000424D0E06000000000000360000002800000016000000160000000100
        180000000000D8050000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFADA6A5BDBABDCECBCECED3D6D6D7D6D6D7D6D6D3
        D6CECBCEC6C3C6ADAEADFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00
        FFFF00FFFF00FFFF00FFA5A29CC6C3C6D6D7DEDEDFE7D6D7D6D6CBC6D6BEB5D6
        BEB5D6C7C6D6D7D6DEDFE7D6DBDEC6C7C6ADA6A5FF00FFFF00FFFF00FFFF00FF
        0000FF00FFFF00FFFF00FFB5B2ADD6D7D6E7EBEFE7D7CED6A28CC67952BD6539
        BD5D31BD5929BD5D31BD6D4AC69684D6CBC6DEE3E7D6D7D6B5B6B5FF00FFFF00
        FFFF00FF0000FF00FFFF00FFB5B6B5DEDFDEF7F7F7E7C3ADD67D52CE6D39CE6D
        42CE6D42B57D63AD7963B55D31BD5929B55521BD6139CEA694E7E3E7DEDFDEC6
        BEBDFF00FFFF00FF0000FF00FFBDB2ADDEDFDEFFFFFFF7C3ADDE7D4AE78252E7
        8252DE794ACE9E84D6DBDEC6CFD6B58A73BD5D29BD6131BD5929B55529CE967B
        E7E3E7E7E3E7C6B6B5FF00FF0000FF00FFD6D3D6FFFFFFFFD7C6EF8652EF8A5A
        EF8A63E78A5AE77D52DEB6A5FFFFFFD6DFE7B58E7BC65D31C66131BD6131BD5D
        31B55529CEA694E7E7EFDEDFDEFF00FF0000CEC3C6F7F7F7FFFFF7F79A73EF8A
        5AEF9263EF8E63EF8A63E7865ADE865ACEA294BD9684C66D42C66539C66131BD
        6131BD6131BD5929BD6139DECFC6E7EBEFCEC7C60000DEDBDEFFFFFFFFD3BDF7
        8E5AF79263F79263EF8E63EF8A5AE78652DE926BD6AE9CC69684C6714AC66539
        C66539C66131BD6131BD6131BD5521CE9684E7E7E7DEDBDE0000EFEBEFFFFFFF
        FFAE8CF79263F79263F79263EF8E63EF8A5AE78252E7AE9CFFFFFFCED7DEBD7D
        63CE6531C66539C66131BD6131BD6131BD5929C6714ADEDFDEDEDFDE0000F7FB
        FFFFFFFFFFA273F7966BF79263F79263EF8E63EF8A5AE78252DEAA94FFFFFFD6
        D7D6BD8A73C66131C66539C66131BD6131BD6131BD5D31BD6131DECFCEDEE3E7
        0000FFFFFFFFFBF7FF9E73F7966BF79263F79263EF8E63EF8A5AE78252DE8E6B
        FFFBFFF7F7F7C6C3C6B58263C66131C66131C66131BD6131BD5D31BD6131D6C7
        BDDEE3E70000FFFFFFFFFBF7FFA27BFF966BF79263F79263EF8E63EF8A5AE782
        52DE794AD69E84F7F7F7F7F7FFCECFCEB5866BC65D31C66131BD6131BD5D31BD
        6131D6C7BDDEDFE70000FFFFFFFFFFFFFFAA84FF9A6BF7966BF79263EF8A5AE7
        8252E77D4ADE7D4AD66D42CE8663F7EBE7F7F7F7C6C7C6B56D4AC66131BD6131
        BD5D31BD6539DED3CED6D7DE0000F7F7FFFFFFFFFFC39CFF9A6BF7966BF79263
        E7A284E7B6A5D6A28CD67D52D6754ACE6531D69273FFFFFFD6DFDEB58A73BD59
        29BD6131BD5929C67952DEDFDECECFCE0000EFE7E7FFFFFFFFE3CEFF9E73FF9A
        6BFF9263E7BAA5FFFFFFD6DFE7C6927BD66D39CE6531CE8663EFF3F7D6DFE7AD
        8A7BBD5929BD6131BD5529CEA28CDEE3E7BDBABD0000D6CFCEFFFFFFFFFFFFFF
        BA94FF9E6BFF9A6BEFA284FFFBFFF7F3F7CEC7C6C69E8CC69684CEC3BDE7E7E7
        C6CBCEAD715AC65D29BD5929BD6D42DED7D6D6D7DEFF00FF0000FF00FFEFEFEF
        FFFFFFFFF3E7FFAA7BFF9E73FF9A6BE7BEADFFFFFFF7FBFFE7EBEFDEE7EFE7E7
        EFD6D7DEAD968CB55D31BD5D29BD5D29D6B6ADDEE3E7BDBEBDFF00FF0000FF00
        FFFF00FFFFFFFFFFFFFFFFEBDEFFAE84FFA273FF9A6BE7AE94E7D7D6DEDFDED6
        D3D6BDBAB5AD8A7BB56139BD5929BD5D31D6AE9CE7E7E7CECFCEFF00FFFF00FF
        0000FF00FFFF00FFD6D3D6FFFFFFFFFFFFFFF7EFFFC39CFFA273FF9263E7865A
        CE8263C67952BD6939C65929BD5D29C67952D6BEB5E7E7E7D6D3D6FF00FFFF00
        FFFF00FF0000FF00FFFF00FFFF00FFCECBCEFFFBFFFFFFFFFFFFFFFFEBDEFFC7
        ADF7A27BE78A63D67D52CE7D5ACE9273D6B6A5DEDBDEDEE3E7CECFCEFF00FFFF
        00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFDEDFDEF7F7F7FF
        FFFFFFFFFFFFF7F7EFEBE7E7E3DEE7DFDEDEE3E7DEDFE7D6D7D6BDBEBDFF00FF
        FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        BDB6B5CECBCED6D7D6D6DBDED6DBDED6D7D6CED3D6C6C7C6B5B6B5FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0000}
      Margin = 10
      Spacing = 3
      Visible = False
      OnClick = spHelpClick
    end
    object EspacamentoInferior: TPanel
      Left = 0
      Top = 0
      Width = 371
      Height = 1
      Align = alTop
      BevelOuter = bvNone
      Caption = 'EspacamentoInferior'
      TabOrder = 0
      object Panel3: TPanel
        Left = 0
        Top = -2
        Width = 371
        Height = 3
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object btnPrint: TBitBtn
      Left = 236
      Top = 5
      Width = 66
      Height = 31
      Caption = '&Print'
      TabOrder = 1
      TabStop = False
      OnClick = btnPrintClick
      Glyph.Data = {
        06050000424D0605000000000000360000002800000012000000160000000100
        180000000000D004000000000000000000000000000000000000FF00FFA47874
        A47874A47874A47874A47874A47874A47874A47874A47874A47874A47874A478
        74A47874A47874A47874A478748C5D5C0000FF00FF897D8BCC9A99CABCB7FEE4
        CAFEE4CAFEE4CAFED6C9FEE4CAFED6C9FEDDBBFEDDBBFEDDBBFED0B7FED0B7FE
        D0B7FED0B78C5D5C0000458EB65D71ABAB8FA3C8ABABFEEBD7FEEBD7FEE4CAFE
        E4CAFEE4CAFEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED7ABFED0B78C5D5C
        000061C6FE3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CA
        FEE4CAFEDDBBFEDDBBFEDDBBFEDDBBFED7ABFED0B78C5D5C0000FF00FF5DB2FC
        3A80E05D71ABAB8FA3D5B3AFFEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDD
        BBFEDDBBFEDDBBFEDDBBFED0B78C5D5C0000FF00FF8F8F8F5DB2FC3A80E05D71
        ABAB8FA3E2BDB3FEEBD7FEEBD7FEE4CAFEE4CAFEE4CAFEE4CAFEDDBBFEDDBBFE
        DDBBFED0B78C5D5C0000FF00FFB48176CABCB75DB2FC3A80E05D71ABB9AAA6F3
        E3D1E2BDB3BF9895CDA6A0C8ABABE2BDB3FEDDBBFEDDBBFEDDBBFECFC28C5D5C
        0000FF00FFB48176F8F3ECFEF4E95DB2FC85AFCB8F8F8FBF9895DAB4A0FDE8B7
        FEFED3FDF6C6D8C5B5CC9A99E5CDBEFEDDBBFED0B78C5D5C0000FF00FFB48176
        F6EFE7FEF4E9F8F3ECDED7D3BF9895FED7ABFDF6C6FEFED3FEFFE1FEFFE1FFFD
        F8F6EFE7BF9895EDD9B7FECFC2986B660000FF00FFBA8E85F8F3ECFFF8EEFFF8
        EED5B3AFEAC8A1FDF6C6FDE8B7FEFED3FEFFE1FEF9F3FEFFFCFFFFFFDED2CACD
        A6A0FED6C9986B660000FF00FFBA8E85FAF3F2FFF8EEFEF9F3C8ABABFDE8B7FD
        E8B7FDF6C6FEFED3FEFFE1FFFDF8FEFFFCFFF8EEFDF6C6BF9895FED6C9986B66
        0000FF00FFCB9A82F9F6F5FEF9F3FFFDF8CDA6A0FDF6C6FED7ABFDE8B7FEFED3
        FEFED3FEFFE1FEFFE1FEFFE1FEFED3BF9895FED6C9986B660000FF00FFCB9A82
        F8F8F8FFFCFBFEFFFCCDA6A0FDF6C6FDE8B7FDE8B7FEFED3FEFED3FEFED3FEFF
        E1FEFED3FDF6C6BF9895FED6C9A478740000FF00FFCB9A82FCFEFBFFFEFEFFFF
        FFD5B3AFEDD9B7FEF0E2FDE8B7FED7ABFDF6C6FDF6C6FDF6C6FDF6C6EDD9B7BF
        9895FED6C9A478740000FF00FFDCA887FBFBFCFFFEFFFFFEFFDED7D3E2BDB3F9
        F6F5F9FFFEFDE8B7FDE8B7FED7ABFDE8B7FDE8B7D6A894D8C5B5FED0B7A47874
        0000FF00FFDCA887FBFBFCFFFFFFFFFFFFFFFEFFD5B3AFD8C5B5EFE4D8F5EADF
        FDE8B7FDE8B7EDD9B7D6A894CDA6A0FED6C9F3B9B5A478740000FF00FFDCA887
        FCFEFBFFFFFEFEFFFCFFFEFFFFFFFFD6BCBBCDA6A0DAB4A0C8ABABDAB4A0CDA6
        A0E2BDB3FED6C9F3B9B5FCA3A2B481760000FF00FFE3B18EFCFEFEFFFFFFFCFE
        FEFFFFFFFFFFFFFFFFFFFFFFFFEADBD4EFE4D8F1E3E2FFF8EEB48176B48176B4
        8176B48176B481760000FF00FFE3B18EFCFEFEFFFFFFFFFEFFFFFFFFFFFFFEFF
        FFFFFFFFFEFFFEFFFFFEFEFEFAF7FEF9F3B48176E3B18EFCB04CD39364D6A894
        0000FF00FFEDBD92FEFEFEFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFEFFFCFEFE
        FEFAF7FEF9F3FEF9F3B48176EAC8A1FCC47CD6A894FF00FF0000FF00FFEDBD92
        FEF0E2FEF0E2F5EADFF5EADFEFE4D8EFE4D8EADBD4EADBD4EADBD4DED2CADED2
        CAB48176DCA887E3B18EFF00FFFF00FF0000FF00FFEDBD92DCA887DCA887DCA8
        87DCA887DCA887DCA887DCA887DCA887DCA887DCA887DCA887B48176DCA887FF
        00FFFF00FFFF00FF0000}
    end
    object btReg: TButton
      Left = 304
      Top = 5
      Width = 66
      Height = 31
      Caption = '&Close'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 2
      TabStop = False
    end
  end
  object pnlAdmUser: TPanel [5]
    Left = 0
    Top = 0
    Width = 371
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label1: TLabel
      Left = 38
      Top = 15
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'User :'
    end
    object scUser: TSuperComboADO
      Left = 73
      Top = 12
      Width = 247
      Height = 21
      TabOrder = 0
      Text = '<-->'
      LookUpSource = dsLookUpPerson
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object btAreaTodas: TButton
      Left = 325
      Top = 11
      Width = 37
      Height = 21
      Caption = 'All'
      TabOrder = 1
      OnClick = btAreaTodasClick
    end
  end
  object pnlSingleUser: TPanel [6]
    Left = 0
    Top = 36
    Width = 371
    Height = 39
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    object lbUserN: TLabel
      Left = 75
      Top = 10
      Width = 33
      Height = 16
      Caption = 'User'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 38
      Top = 12
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'User :'
    end
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_frmTimeControlPrint.sil'
  end
  object quTimeControl: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    OnCalcFields = quTimeControlCalcFields
    CommandText = 
      'SELECT'#13#10'        TC.EnterDate,'#13#10#9'TC.ExitDate,'#13#10'        CONVERT(Da' +
      'teTime, (ExitDate - EnterDate)) as WorkedHour,'#13#10#9'DATEPART(hh,CON' +
      'VERT(DateTime, (ExitDate - EnterDate))) as WorkHourPay,'#13#10#9'ROUND(' +
      '(DATEPART(n,CONVERT(DateTime, (ExitDate - EnterDate)))*1.66)/100' +
      ',2) as WorkMunitPay,'#13#10#9'P.Pessoa,'#13#10#9'TC.IDUser,'#13#10#9'S.Name as Store'#13 +
      #10#13#10'FROM TMC_TimeControl TC (NOLOCK) '#13#10'JOIN Pessoa P (NOLOCK) ON ' +
      '(TC.IDPessoa = P.IDPessoa)'#13#10'JOIN Store S (NOLOCK) ON (S.IDStore ' +
      '= TC.IDStore)'
    Parameters = <>
    Left = 320
    Top = 65
    object quTimeControlEnterDate: TDateTimeField
      FieldName = 'EnterDate'
      DisplayFormat = 'ddddd'
    end
    object quTimeControlExitDate: TDateTimeField
      FieldName = 'ExitDate'
      DisplayFormat = 'ddddd'
    end
    object quTimeControlPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object quTimeControlIDUser: TIntegerField
      FieldName = 'IDUser'
    end
    object quTimeControlWorkedHour: TDateTimeField
      FieldName = 'WorkedHour'
      ReadOnly = True
      DisplayFormat = 'hh:mm:ss'
    end
    object quTimeControlWorkMunitPay: TBCDField
      FieldName = 'WorkMunitPay'
      ReadOnly = True
      Precision = 18
      Size = 6
    end
    object quTimeControlWorkHourPay: TIntegerField
      FieldName = 'WorkHourPay'
      ReadOnly = True
    end
    object quTimeControlTotalWorkHour: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TotalWorkHour'
      Calculated = True
    end
    object quTimeControlWeekDay: TStringField
      FieldKind = fkCalculated
      FieldName = 'WeekDay'
      Calculated = True
    end
    object quTimeControlStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
  end
  object dsTimeControl: TDataSource
    DataSet = quTimeControl
    Left = 325
    Top = 19
  end
  object rpUserTimeClock: TppReport
    AutoStop = False
    DataPipeline = ppUserTimeClock
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'User Log'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    DeviceType = 'Screen'
    Icon.Data = {
      0000010001002020100000000000E80200001600000028000000200000004000
      0000010004000000000080020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000900009000000000000000000000000009000
      0900000000000000000000000000999999999999999999999999999999999999
      9999999999999999999999999999999999000099999999900000000000009999
      9900099999999900000000000000999999009999999990000000000000009999
      9909999999990000000000000000999999999999999000000000000000009999
      9999999999000000000000000000999999999999900000000000000000009999
      9999999900000000000000000000999999999990000000000000000000009999
      9999990000000000000000000000999999999000000000000000000000009999
      99990000000000000000000000009999999000000000000000000000000003FF
      FFF803FFFFF003FFFFE003FFFFC003FFFF8003FFFF0003FFFE0003FFFC0003FF
      F80003FFF00003FFE00003FFC00003FF804003FF00C003FE01C003FC03C003F8
      07C0000000000000000003C01FFF03803FFF03007FFF0200FFFF0001FFFF0003
      FFFF0007FFFF000FFFFF001FFFFF003FFFFF007FFFFF00FFFFFF01FFFFFF}
    OnPreviewFormCreate = rpUserTimeClockPreviewFormCreate
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 265
    Top = 65
    Version = '7.02'
    mmColumnWidth = 203200
    DataPipelineName = 'ppUserTimeClock'
    object ppHeaderBand2: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 16669
      mmPrintPosition = 0
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsItalic]
        Transparent = True
        mmHeight = 3175
        mmLeft = 174625
        mmTop = 7938
        mmWidth = 26988
        BandType = 0
      end
      object lbTitle: TppLabel
        OnPrint = lbTitlePrint
        UserName = 'lbTitle'
        AutoSize = False
        Caption = 'Title'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = [fsBold, fsItalic]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5292
        mmLeft = 265
        mmTop = 0
        mmWidth = 203200
        BandType = 0
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'Printed by :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsItalic]
        Transparent = True
        mmHeight = 3175
        mmLeft = 1058
        mmTop = 7408
        mmWidth = 15875
        BandType = 0
      end
      object lbUserPrint: TppLabel
        OnPrint = lbUserPrintPrint
        UserName = 'lbUserPrint'
        Caption = 'lbUserPrint'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold, fsItalic]
        Transparent = True
        mmHeight = 3175
        mmLeft = 23813
        mmTop = 7408
        mmWidth = 15081
        BandType = 0
      end
      object ppLabel1: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Date'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3440
        mmLeft = 66146
        mmTop = 13229
        mmWidth = 29369
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Clock In'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3440
        mmLeft = 96838
        mmTop = 13229
        mmWidth = 24342
        BandType = 0
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Clock Out'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3440
        mmLeft = 122502
        mmTop = 13229
        mmWidth = 25135
        BandType = 0
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Caption = 'Worked Hours'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3440
        mmLeft = 148961
        mmTop = 13229
        mmWidth = 25400
        BandType = 0
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        AutoSize = False
        Caption = 'Hours'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taCentered
        mmHeight = 3440
        mmLeft = 175948
        mmTop = 13229
        mmWidth = 25400
        BandType = 0
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Store'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Name = 'Tahoma'
        Font.Size = 8
        Font.Style = [fsBold]
        mmHeight = 3440
        mmLeft = 34131
        mmTop = 13229
        mmWidth = 30692
        BandType = 0
      end
    end
    object ppDetailBand2: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 3175
      mmPrintPosition = 0
      object shpLine: TppShape
        UserName = 'shpLine'
        mmHeight = 3440
        mmLeft = 0
        mmTop = 0
        mmWidth = 203730
        BandType = 4
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'ExitDate'
        DataPipeline = ppUserTimeClock
        DisplayFormat = 'tt'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppUserTimeClock'
        mmHeight = 3175
        mmLeft = 122502
        mmTop = 0
        mmWidth = 25135
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'WorkedHour'
        DataPipeline = ppUserTimeClock
        DisplayFormat = 'hh:mm'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppUserTimeClock'
        mmHeight = 3175
        mmLeft = 148961
        mmTop = 0
        mmWidth = 25135
        BandType = 4
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'WeekDay'
        DataPipeline = ppUserTimeClock
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppUserTimeClock'
        mmHeight = 3175
        mmLeft = 2910
        mmTop = 0
        mmWidth = 25665
        BandType = 4
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'TotalWorkHour'
        DataPipeline = ppUserTimeClock
        DisplayFormat = '##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppUserTimeClock'
        mmHeight = 3175
        mmLeft = 175948
        mmTop = 0
        mmWidth = 25400
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'EnterDate'
        DataPipeline = ppUserTimeClock
        DisplayFormat = 'tt'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppUserTimeClock'
        mmHeight = 3175
        mmLeft = 96838
        mmTop = 0
        mmWidth = 24077
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'EnterDate'
        DataPipeline = ppUserTimeClock
        DisplayFormat = 'ddddd'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppUserTimeClock'
        mmHeight = 3175
        mmLeft = 66146
        mmTop = 0
        mmWidth = 28840
        BandType = 4
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        DataField = 'Store'
        DataPipeline = ppUserTimeClock
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppUserTimeClock'
        mmHeight = 3175
        mmLeft = 33867
        mmTop = 0
        mmWidth = 30692
        BandType = 4
      end
    end
    object ppFooterBand2: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 7408
      mmPrintPosition = 0
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsItalic]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 187855
        mmTop = 2381
        mmWidth = 14023
        BandType = 8
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'IDUser'
      DataPipeline = ppUserTimeClock
      KeepTogether = True
      OutlineSettings.CreateNode = True
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppUserTimeClock'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object ppDBText1: TppDBText
          UserName = 'DBText1'
          AutoSize = True
          DataField = 'Pessoa'
          DataPipeline = ppUserTimeClock
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Name = 'Tahoma'
          Font.Size = 12
          Font.Style = [fsBold, fsItalic]
          Transparent = True
          DataPipelineName = 'ppUserTimeClock'
          mmHeight = 5027
          mmLeft = 265
          mmTop = 0
          mmWidth = 14817
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 3440
        mmPrintPosition = 0
        object ppDBCalc1: TppDBCalc
          UserName = 'DBCalc1'
          DataField = 'TotalWorkHour'
          DataPipeline = ppUserTimeClock
          DisplayFormat = '##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taCentered
          Transparent = True
          DataPipelineName = 'ppUserTimeClock'
          mmHeight = 3175
          mmLeft = 175948
          mmTop = 265
          mmWidth = 25135
          BandType = 5
          GroupNo = 0
        end
      end
    end
  end
  object ppUserTimeClock: TppDBPipeline
    DataSource = dsTimeControl
    OpenDataSource = False
    UserName = 'UserTimeClock'
    Left = 270
    Top = 15
    object ppUserTimeClockppField1: TppField
      FieldAlias = 'EnterDate'
      FieldName = 'EnterDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppUserTimeClockppField2: TppField
      FieldAlias = 'ExitDate'
      FieldName = 'ExitDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppUserTimeClockppField3: TppField
      FieldAlias = 'Pessoa'
      FieldName = 'Pessoa'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppUserTimeClockppField4: TppField
      FieldAlias = 'IDUser'
      FieldName = 'IDUser'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppUserTimeClockppField5: TppField
      FieldAlias = 'WorkedHour'
      FieldName = 'WorkedHour'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppUserTimeClockppField6: TppField
      FieldAlias = 'WorkMunitPay'
      FieldName = 'WorkMunitPay'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppUserTimeClockppField7: TppField
      FieldAlias = 'WorkHourPay'
      FieldName = 'WorkHourPay'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppUserTimeClockppField8: TppField
      FieldAlias = 'TotalWorkHour'
      FieldName = 'TotalWorkHour'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppUserTimeClockppField9: TppField
      FieldAlias = 'WeekDay'
      FieldName = 'WeekDay'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppUserTimeClockppField10: TppField
      FieldAlias = 'Store'
      FieldName = 'Store'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
  end
  object LookUpPerson: TLookUpADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.IDPessoa IDComissionado,'#13#10#9'P.Pessoa,'#13#10#9 +
      'P.Code'#13#10'FROM '#9#13#10#9'Pessoa P (NOLOCK)'#13#10'WHERE '#9#13#10#9'P.IDTipoPessoaRoot' +
      ' = 4'#13#10#9'AND'#13#10#9'P.Desativado = 0'#13#10'ORDER BY '#13#10#9'P.Pessoa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pessoa'
    CodeField = 'Code'
    LookUpField = 'IDPessoa'
    Left = 32
    Top = 91
    object LookUpPersonIDPessoa: TIntegerField
      FieldName = 'IDPessoa'
    end
    object LookUpPersonIDComissionado: TIntegerField
      FieldName = 'IDComissionado'
    end
    object LookUpPersonPessoa: TStringField
      FieldName = 'Pessoa'
      Size = 50
    end
    object LookUpPersonCode: TIntegerField
      FieldName = 'Code'
    end
  end
  object dsLookUpPerson: TDataSource
    DataSet = LookUpPerson
    Left = 82
    Top = 92
  end
end
