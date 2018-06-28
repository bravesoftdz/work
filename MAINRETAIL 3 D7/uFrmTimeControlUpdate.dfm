inherited FrmTimeControlUpdate: TFrmTimeControlUpdate
  Left = 248
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Update Time'
  ClientHeight = 321
  ClientWidth = 554
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object sbInsert: TSpeedButton [0]
    Left = 494
    Top = 50
    Width = 57
    Height = 21
    Hint = 'Insert new date'
    Caption = '&Insert'
    Flat = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000010000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphRight
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = sbInsertClick
  end
  object sbDelete: TSpeedButton [1]
    Left = 494
    Top = 75
    Width = 57
    Height = 21
    Hint = 'Delete date'
    Caption = '&Delete'
    Enabled = False
    Flat = True
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000C40E0000C40E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDD07DDDDDDDDD0DDD0007DDDDDDDD7DDD0000DDDDDD
      D0DDDDD0007DDDDD07DDDDDD0007DDD00DDDDDDDD0007D007DDDDDDDDD000007
      DDDDDDDDDDD0007DDDDDDDDDDD000007DDDDDDDDD0007D007DDDDDD00007DDD0
      07DDDD00007DDDDD007DDD0007DDDDDDDD0DDDDDDDDDDDDDDDDD}
    Layout = blGlyphRight
    ParentShowHint = False
    ShowHint = True
    OnClick = sbDeleteClick
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 284
    Width = 554
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object spHelp: TSpeedButton
      Tag = 5
      Left = 355
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
      Margin = 5
      Spacing = 3
      Visible = False
    end
    object EspacamentoInferior: TPanel
      Left = 0
      Top = 0
      Width = 554
      Height = 1
      Align = alTop
      BevelOuter = bvNone
      Caption = 'EspacamentoInferior'
      TabOrder = 0
      object Panel3: TPanel
        Left = 0
        Top = -2
        Width = 554
        Height = 3
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 0
      end
    end
    object btClose: TButton
      Left = 423
      Top = 5
      Width = 66
      Height = 31
      Caption = 'Save'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnClick = btCloseClick
    end
    object btCancel: TButton
      Left = 491
      Top = 5
      Width = 66
      Height = 31
      Cancel = True
      Caption = '&Close'
      Default = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
    end
  end
  object pnlAdmUser: TPanel [3]
    Left = 0
    Top = 0
    Width = 554
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    Color = clGrayText
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
      Left = 254
      Top = 11
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'From'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 391
      Top = 10
      Width = 14
      Height = 13
      Alignment = taRightJustify
      Caption = 'To'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btRefresh: TSpeedButton
      Left = 496
      Top = 8
      Width = 56
      Height = 21
      Caption = '&GO'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880FAFAF07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F00A2200F
        77037F3737333737FF7F080A0A2A220A07037F737F3333737F7F0F0F0AAAA20F
        07037F737F3333737F7F0F0A0FAA2A0A08037F737FF33373737F0F7F00FFA00F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80FAFAF08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      Layout = blGlyphRight
      NumGlyphs = 2
      OnClick = btRefreshClick
    end
    object Label1: TLabel
      Left = 20
      Top = 11
      Width = 32
      Height = 13
      Alignment = taRightJustify
      Caption = 'User :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object scUserUpdate: TSuperComboADO
      Left = 58
      Top = 7
      Width = 166
      Height = 21
      TabOrder = 0
      LookUpSource = dsLookUpPerson
      DropDownRows = 18
      ShowBtnAddNew = False
      ShowBtnUpdate = False
      IDLanguage = 0
    end
    object edtDateIniUp: TDateBox
      Left = 285
      Top = 7
      Width = 83
      Height = 21
      TabOrder = 1
      InputTime = False
      FirstDayOfWeek = Wednesday
    end
    object edtDateFimUp: TDateBox
      Left = 407
      Top = 7
      Width = 83
      Height = 21
      TabOrder = 2
      InputTime = False
      FirstDayOfWeek = Wednesday
    end
  end
  object pnlUpdateHour: TPanel [4]
    Left = -5
    Top = 203
    Width = 487
    Height = 79
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Panel1: TPanel
      Left = 59
      Top = 8
      Width = 189
      Height = 62
      BevelOuter = bvNone
      TabOrder = 0
      object Label4: TLabel
        Left = 7
        Top = 8
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date In :'
      end
      object Label5: TLabel
        Left = 1
        Top = 38
        Width = 58
        Height = 13
        Alignment = taRightJustify
        Caption = 'Begin Time :'
      end
      object beginTime: TDateTimePicker
        Left = 66
        Top = 35
        Width = 114
        Height = 21
        Date = 42324.578760486110000000
        Time = 42324.578760486110000000
        Kind = dtkTime
        TabOrder = 0
      end
      object beginDate: TDateTimePicker
        Left = 66
        Top = 5
        Width = 114
        Height = 21
        Date = 42324.578760486110000000
        Time = 42324.578760486110000000
        TabOrder = 1
      end
    end
    object Panel5: TPanel
      Left = 278
      Top = -1
      Width = 216
      Height = 69
      BevelOuter = bvNone
      TabOrder = 1
      object Label6: TLabel
        Left = 16
        Top = 18
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Date Out:'
      end
      object Label7: TLabel
        Left = 19
        Top = 45
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'End Time :'
      end
      object endTime: TDateTimePicker
        Left = 73
        Top = 40
        Width = 113
        Height = 22
        Date = 42324.578760486110000000
        Time = 42324.578760486110000000
        Kind = dtkTime
        TabOrder = 0
      end
      object endDate: TDateTimePicker
        Left = 73
        Top = 13
        Width = 114
        Height = 21
        Date = 42324.578760486110000000
        Time = 42324.578760486110000000
        TabOrder = 1
      end
    end
  end
  object grdObjeto: TSMDBGrid [5]
    Left = 0
    Top = 45
    Width = 485
    Height = 151
    DataSource = dsListTimeGrid
    FixedColor = 14607076
    Options = [dgTitles, dgColumnResize, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Flat = True
    Groupings = <>
    GridStyle.Style = gsCustom
    GridStyle.OddColor = clWindow
    GridStyle.EvenColor = 14607076
    FooterColor = clBtnFace
    ExOptions = [eoAutoWidth, eoKeepSelection]
    RegistryKey = 'Software\Scalabium'
    RegistrySection = 'SMDBGrid'
    WidthOfIndicator = 11
    DefaultRowHeight = 17
    ScrollBars = ssVertical
    ColCount = 2
    RowCount = 2
    Columns = <
      item
        Expanded = False
        FieldName = 'EnterDate'
        ReadOnly = True
        Title.Caption = 'Clock In'
        Width = 239
        Visible = True
        FooterType = ftCustom
      end
      item
        Expanded = False
        FieldName = 'ExitDate'
        ReadOnly = True
        Title.Caption = 'Clock Out'
        Width = 225
        Visible = True
        FooterType = ftCustom
      end>
  end
  object quListTimeGrid: TADOQuery [6]
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterScroll = quListTimeGridAfterScroll
    Parameters = <
      item
        Name = 'IniDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'IDUser'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'FimDate'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '        EnterDate,'
      '        ExitDate,'
      '        IDTime'
      'FROM'
      '        TMC_TimeControl (NOLOCK) '
      'WHERE'
      '        EnterDate >= :IniDate'
      '        AND'
      '        IDPessoa = :IDUser'
      '        AND'
      '        (ExitDate < :FimDate or ExitDate is null)'
      'ORDER BY'
      '        EnterDate DESC'
      ' '
      ' ')
    Left = 262
    Top = 140
    object quListTimeGridEnterDate: TDateTimeField
      DisplayLabel = 'Clock IN'
      FieldName = 'EnterDate'
      Origin = 'RETAIL.TMC_TimeControl.EnterDate'
      DisplayFormat = 'mm/dd/yyyy tt'
    end
    object quListTimeGridExitDate: TDateTimeField
      DisplayLabel = 'Clock OUT'
      FieldName = 'ExitDate'
      Origin = 'RETAIL.TMC_TimeControl.ExitDate'
      DisplayFormat = 'mm/dd/yyyy tt'
    end
    object quListTimeGridIDTime: TIntegerField
      FieldName = 'IDTime'
      Origin = 'RETAIL.TMC_TimeControl.IDTime'
    end
  end
  object dsListTimeGrid: TDataSource [7]
    DataSet = quListTimeGrid
    OnStateChange = dsListTimeGridStateChange
    Left = 355
    Top = 105
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmTimeControlUpdate.sil'
  end
  object dsLookUpPerson: TDataSource
    DataSet = LookUpPerson
    Left = 194
    Top = 92
  end
  object LookUpPerson: TLookUpADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT'#13#10#9'P.IDPessoa,'#13#10#9'P.IDPessoa IDComissionado,'#13#10#9'P.Pessoa,'#13#10#9 +
      'P.Code'#13#10'FROM '#9#13#10#9'Pessoa P (NOLOCK)'#13#10'WHERE '#9#13#10#9'P.IDTipoPessoaRoot' +
      ' = 4'#13#10'ORDER BY '#13#10#9'P.Pessoa'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Pessoa'
    CodeField = 'Code'
    LookUpField = 'IDPessoa'
    Left = 100
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
end
