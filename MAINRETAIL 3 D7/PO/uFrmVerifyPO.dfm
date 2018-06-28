inherited FrmVerifyPO: TFrmVerifyPO
  Left = 270
  Top = 101
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Verify PO'
  ClientHeight = 607
  ClientWidth = 961
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 961
    inherited Image1: TImage
      Width = 734
    end
    inherited lblMenu: TLabel
      Left = 745
    end
    inherited EspacamentoSuperior: TPanel
      Width = 961
      inherited EEE: TPanel
        Width = 961
      end
    end
  end
  inherited Panel1: TPanel
    Top = 566
    Width = 961
    inherited EspacamentoInferior: TPanel
      Width = 961
      inherited Panel3: TPanel
        Width = 961
      end
    end
    inherited hhh: TPanel
      Left = 645
      Width = 316
      object spHelp: TSpeedButton [0]
        Tag = 5
        Left = 0
        Top = 3
        Width = 65
        Height = 17
        Caption = '&Help'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          06030000424D060300000000000036000000280000000F0000000F0000000100
          180000000000D002000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFF3E1D7F4E3D9F4E3DAF3E2D8F3E1D7FF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FFF4E3D8F8FAFBE4E2E2CFB1A2D4
          AB96DDC6BBECF1F0F6F3F2F2E1D6FF00FFFF00FFFF00FF000000FF00FFFF00FF
          F5EAE2F4FFFFCF9A80B74C15B9643CD9AF9AC05823B95624D5AF9FF7FFFFF4E2
          D9FF00FFFF00FF000000FF00FFF2E1D7F8FFFFC77D58BB450CC64E13C2A495FF
          FFFFD9926FC14A0FB8450BCE9A80F8FFFFF2E0D6FF00FF000000FF00FFFAFAF9
          D8A890BD480DCD622ECD6029CB6B3AD88E68CA5E29CC622DC95D29B94710E0C9
          BDF6EDE8FF00FF000000F3E0D7F8FAFBC56232CA5C26CE6733CB5B23CA8969F7
          E7DFD06B38CA5A23CD6531C3531BC77850F8FCFDDCC8BE000000F3E1D8F2DED6
          C5561ECE6632CC6531CC5A21C28669FFFFFFE8AD91C44A0FCC622DCB5F28C35E
          2BF3F2F1F1DFD5000000F2E1D9F3D8CACD5B22CF6632CC642FCC602BC4551FCF
          B5A8FFFFFFE09C7AC7531ACD602BC65E29F5F1EDEFDED4000000F1E0D7FBEDE6
          DB6A32D36833CA5E28C95821C95419C14B10E2D0C6FFFFFFD0703FCD5A20CE6A
          38FCFBFBEEDDD2000000F1DED4FFFFFFF5986AE2662AC88B6DF0EAE3D77E51BD
          3000D79C7EFFFFFFDA8C65D15314E29A76FEFDFED3BDB2000000FF00FFF6F1EF
          FFEADBFF8A49DE875CEEFFFFFEFCFDE7B9A1FAFFFFF3F9FEE0723CE67035FFF3
          EEF4E7E0FF00FF000000FF00FFF1DED4FFFFFFFFE9CEFFB270ECAF87ECE2DFEB
          F0F4F1E4E0F6A478FE8C4DFFDECAFDFFFFF0DDD2FF00FF000000FF00FFFF00FF
          F0DFD6FFFFFFFFFFFBFFF3C6FEDDA8FCCF98FFC991FFD4A9FFFEF8FCFFFFF1DF
          D4FF00FFFF00FF000000FF00FFFF00FFFF00FFF1DCD3F5E8E4FDFCFDFFFFFFFF
          FFFFFFFFFFFCFBFDF3E6E0F1DDD2FF00FFFF00FFFF00FF000000FF00FFFF00FF
          FF00FFFF00FFFF00FFF1DCD1EFDBD0EFDBD1EFDCD1F1DBD0FF00FFFF00FFFF00
          FFFF00FFFF00FF000000}
        Margin = 5
        ParentFont = False
        Visible = False
        OnClick = spHelpClick
      end
      object btnVideo: TSpeedButton [1]
        Tag = 5
        Left = 0
        Top = 19
        Width = 65
        Height = 16
        Caption = '&Video'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          D6020000424DD60200000000000036000000280000000F0000000E0000000100
          180000000000A002000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FF84474091251A961E1607A5CA07A5CA19839C556A6EFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FFA4331AB23011BA4327BA4F362B
          C7EC2BC7EC17C0E801AFD9226E80FF00FFFF00FFFF00FF000000FF00FFFF00FF
          B43B12C24D1DC8622FCE6A36D17A5143CCED43CCED4AC7E53AC4E402BBE82072
          84FF00FFFF00FF000000FF00FFB85328CB5B1BD0661DDE8F56F6DDCAFEF9F6F9
          FEFFD2F2FA73D6ED47C8E53BC3E301AFDA567179FF00FF000000FF00FFCE5C16
          DA741EE99C54F0EFEA888E93BEC0C1FBF9F9FFFFFFFFFFFF78D8EE48C7E51BC0
          E8138BA7FF00FF000000D0804AE17618EF8D21F4DEC1E9F1F81E1D1D131313A7
          A7A7CFCFCFFFFDFCE3F7FC4ACBEA37C5E707A8D0FF00FF000000CF7F46DE832B
          E9A448EAE7E0E9F1F84847481B1B1B0404041C1C1CCFCFCFE3E0E068D5ED38C0
          DE06A8CDFF00FF0000005373F01B4AFF4D73FFDADCE1E9F1F84847484E4E4E21
          2121080808646464EAE8E855B499288A72065A49FF00FF0000005373F01B4AFF
          4D73FFC5CBE1E9F1F84847486B6B6B797979C7C7C7FFFEFFE1EEE92CA1771C81
          5F0A533AFF00FF000000FF00FF1B48F84C71FF9EAFF5E9F1F86B6B6BC6C6C4EB
          E9E9F4EBEEF7EAEF67C4A0149B6D05734F2A6150FF00FF000000FF00FF3E63F4
          2E59FE5376FFA1B1F1C7CBDBD9D8D8D9D8D7C3DCD35FCEA301A96D068D610167
          45FF00FFFF00FF000000FF00FFFF00FF244EF7315AFE5376FF5D7DFF597AF530
          D1A80DD58401B773019C66017A4E578375FF00FFFF00FF000000FF00FFFF00FF
          FF00FF385EF51B47F9234DFC224EF901B99101BE7101A065098A5C689685FF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FF8EA2F25876EB3258EC1A
          A58B29AE785AA98CFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Margin = 5
        ParentFont = False
        Visible = False
        OnClick = btnVideoClick
      end
      inherited btClose: TButton
        Left = 250
        ModalResult = 2
      end
      object btnUpdate: TButton
        Left = 114
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Update'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = False
        Visible = False
        OnClick = btnUpdateClick
      end
      object btnVerify: TButton
        Left = 183
        Top = 3
        Width = 66
        Height = 31
        Caption = '&Verify'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
        OnClick = btnVerifyClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 169
    Height = 251
  end
  inherited EspacamentoDireito: TPanel
    Left = 958
    Top = 169
    Height = 251
  end
  object pnlResult: TPanel [4]
    Left = 0
    Top = 420
    Width = 961
    Height = 146
    Align = alBottom
    BevelOuter = bvNone
    Color = 14607076
    TabOrder = 4
    object Label3: TLabel
      Left = 53
      Top = 30
      Width = 145
      Height = 25
      Alignment = taRightJustify
      Caption = 'Total Counted :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 103
      Top = 66
      Width = 94
      Height = 25
      Alignment = taRightJustify
      Caption = 'Total PO :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 87
      Top = 102
      Width = 110
      Height = 25
      Alignment = taRightJustify
      Caption = 'Difference :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbTotCounted: TLabel
      Left = 204
      Top = 32
      Width = 11
      Height = 25
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbTotPO: TLabel
      Left = 204
      Top = 68
      Width = 11
      Height = 25
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbTotDiff: TLabel
      Left = 204
      Top = 104
      Width = 11
      Height = 25
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 961
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Total counted'
      Color = clBtnShadow
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnlLegend: TPanel
      Left = 510
      Top = 42
      Width = 249
      Height = 84
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object lbItemNotImp: TLabel
        Left = 38
        Top = 10
        Width = 87
        Height = 13
        Caption = 'Product not found'
      end
      object lbQtyExceeds: TLabel
        Left = 38
        Top = 28
        Width = 151
        Height = 13
        Caption = 'Quantity exceeds ordered total'
      end
      object lbQtyBellow: TLabel
        Left = 38
        Top = 47
        Width = 139
        Height = 13
        Caption = 'Quantity below ordered total'
      end
      object lbEqual: TLabel
        Left = 38
        Top = 65
        Width = 150
        Height = 13
        Caption = 'Quantity equal to ordered total'
      end
      object pnlBadItem: TPanel
        Left = 19
        Top = 10
        Width = 14
        Height = 14
        BevelOuter = bvNone
        Color = clRed
        TabOrder = 0
      end
      object pnlGreaterQty: TPanel
        Left = 19
        Top = 28
        Width = 14
        Height = 14
        BevelOuter = bvNone
        Color = clBlue
        TabOrder = 1
      end
      object pnlLessQty: TPanel
        Left = 19
        Top = 47
        Width = 14
        Height = 14
        BevelOuter = bvNone
        Color = 33023
        TabOrder = 2
      end
      object pnEqualOrder: TPanel
        Left = 19
        Top = 65
        Width = 14
        Height = 14
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 3
      end
    end
  end
  object pnlScan: TPanel [5]
    Left = 0
    Top = 40
    Width = 961
    Height = 129
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    TabStop = True
    DesignSize = (
      961
      129)
    object lbBarcode: TLabel
      Left = 41
      Top = 20
      Width = 90
      Height = 25
      Alignment = taRightJustify
      Caption = 'Barcode :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnOpenFile: TSpeedButton
      Left = 349
      Top = 99
      Width = 22
      Height = 21
      Flat = True
      Glyph.Data = {
        96030000424D9603000000000000360000002800000010000000120000000100
        18000000000060030000D40E0000D40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF23A8D68FD8F447BFE92DB1E07AAEEEFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF15A3D48BD5F4
        94E3FF78DAFF65D2F954C9F147C1EA53C9EEFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF0BA0D377CEF0A3EAFF81E7FF81E7FF81E7FF81E7FF7C
        E6FD72DDF766D8F455CEEF55CEEFFF00FFFF00FFFF00FFFF00FF11A3D66CCBF6
        A2EAFB8DEFFF8CF3FF8BF2FF8BF2FF8CF3FF8BF2FF8CF2FF80E6FE75DCFD55CE
        EFFF00FFFF00FFFF00FF27ADDE5FC5F49DE4F4A6FFFF99FDFF95F9FF95F9FF99
        FDFF92F8FF97FBFF85EAFF87E7FF55CEEFFF00FFFF00FFFF00FF2AAFDE55C4F1
        86D5EDB9FCFDA3FDFFA3FDFFA3FDFFA3FDFFA3FDFFA3FDFF90F2FF97E4FF9FEC
        F7FF00FFFF00FFFF00FF2BB0DE6DD5FA5AC8ED75D2EE93DEF1B7EBFBCDF9FFC1
        FDFFBCFDFFBCFDFFA3EFFF9AE3FFCFF5FC77A4EAFF00FFFF00FF38B8E382E8FF
        75DEFC77E0FA50BFE74ABEEA59C0E6D1EFF4D3FFFFD3FFFFB2EEFF9CE0F444A1
        5477C0BAFF00FFFF00FF3DBCE48EF5FF8EF5FF8EF5FF8EF5FF8EF5FF82F1FF3E
        C1E452C1E550C4EA44B8D62C9B5E3CC6672A9F4DFF00FFFF00FF43C0E79FFEFF
        9CFFFF9CFFFFA0FFFFAEFFFFABFFFFA4FDFF96FCFF71E0E22C9F6B2DBB575AE3
        8449D06C2A9F4DFF00FF50C4EBBCFDFFA5FCFF9DFEFFB7F9FC91DEF174D7F16B
        D5F16BD7E767BE852BA94351DA795AE3845AE3844AC769FF00FF42BBE88ED7F2
        9EE3F5B0ECF892D7F54DA8EAFF00FFFF00FFFF00FF78B1784C9D4F33BD565AE3
        8442C66449AC5673AB6EFF00FF4AA6E94DA8EA50A9EA4DA8EAFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF4A885E47D3773BBC5BFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4390593CC9
        6C5BA177FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF67756729B551379754FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF88608D7E547A5D4A634C7255209D2D239738FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA4
        A2A85A9D5566A562FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnOpenFileClick
    end
    object lbPrinter: TLabel
      Left = 137
      Top = 84
      Width = 40
      Height = 13
      Caption = 'lbPrinter'
    end
    object edtBarcode: TmrBarCodeEdit
      Left = 136
      Top = 16
      Width = 210
      Height = 33
      Color = 8454143
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Connection = DM.ADODBConnect
      SQL.Strings = (
        'SELECT'
        '      B.IDModel'
        'FROM'
        '      Barcode B'
        'WHERE'
        '      B.IDBarcode = :IDBarcode')
      SecondSQL.Strings = (
        'SELECT'
        '      M.IDModel'
        'FROM'
        '      Model M'
        'WHERE'
        '      M.Model = :Model')
      KeyField = 'IDBarcode'
      SecondKeyField = 'Model'
      DisplayQty = False
      RunSecondSQL = True
      CheckBarcodeDigit = 0
      MinimalDigits = 0
      AfterSearchBarcode = edtBarcodeAfterSearchBarcode
    end
    object pnLastScan: TPanel
      Left = 579
      Top = 0
      Width = 379
      Height = 123
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Color = 14607076
      TabOrder = 2
      Visible = False
      object lbModelGroup2: TLabel
        Left = 46
        Top = 41
        Width = 35
        Height = 13
        Alignment = taRightJustify
        Caption = 'Model :'
      end
      object lbSalePrice: TLabel
        Left = 165
        Top = 92
        Width = 106
        Height = 25
        Alignment = taRightJustify
        Caption = 'Sale Price :'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbPriceResult: TLabel
        Left = 276
        Top = 93
        Width = 46
        Height = 25
        Caption = '0.00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 35
        Top = 22
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'Barcode :'
      end
      object Label2: TLabel
        Left = 21
        Top = 61
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'Description :'
      end
      object lbBarcodeResult: TLabel
        Left = 85
        Top = 22
        Width = 12
        Height = 13
        Caption = '....'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbModelResult: TLabel
        Left = 84
        Top = 41
        Width = 12
        Height = 13
        Caption = '....'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbDescResult: TLabel
        Left = 85
        Top = 61
        Width = 12
        Height = 13
        Caption = '....'
        FocusControl = Panel1
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlModelMeasure: TPanel
        Left = 0
        Top = 0
        Width = 379
        Height = 16
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Last Item Scanned'
        Color = clBtnShadow
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object chkPrint: TCheckBox
      Left = 137
      Top = 65
      Width = 229
      Height = 17
      TabStop = False
      Caption = 'Print'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 3
      OnClick = chkPrintClick
    end
    object edtReportFile: TEdit
      Left = 136
      Top = 99
      Width = 212
      Height = 21
      TabStop = False
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 4
    end
  end
  object pnlDetail: TPanel [6]
    Left = 3
    Top = 169
    Width = 955
    Height = 251
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 6
    object pnlButtons: TPanel
      Left = 838
      Top = 0
      Width = 117
      Height = 251
      Align = alRight
      BevelOuter = bvNone
      Color = 14607076
      TabOrder = 1
      object btExcel: TSpeedButton
        Tag = 7
        Left = 3
        Top = 88
        Width = 111
        Height = 26
        Hint = 'Export grid'
        Caption = 'E&xport'
        Flat = True
        Margin = 4
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = btExcelClick
      end
      object btGroup: TSpeedButton
        Tag = 3
        Left = 3
        Top = 120
        Width = 111
        Height = 25
        AllowAllUp = True
        GroupIndex = 88997
        Caption = '&Grouping'
        Flat = True
        Margin = 7
        Spacing = 8
        OnClick = btGroupClick
      end
      object btColumn: TSpeedButton
        Tag = 4
        Left = 3
        Top = 145
        Width = 111
        Height = 25
        AllowAllUp = True
        GroupIndex = 1235
        Caption = 'Colum&ns'
        Flat = True
        Margin = 6
        Spacing = 7
        OnClick = btColumnClick
      end
      object btFilter: TSpeedButton
        Tag = 4
        Left = 3
        Top = 170
        Width = 111
        Height = 25
        AllowAllUp = True
        GroupIndex = 87741
        Caption = 'Show &Filters'
        Flat = True
        Margin = 7
        Spacing = 5
        OnClick = btFilterClick
      end
      object btnRemove: TSpeedButton
        Tag = 7
        Left = 3
        Top = 56
        Width = 111
        Height = 26
        Hint = 'Export grid'
        Caption = '&Remove'
        Flat = True
        Margin = 4
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = btnRemoveClick
      end
      object Label6: TLabel
        Left = 4
        Top = 6
        Width = 40
        Height = 13
        Caption = '# Copy:'
      end
      object btPrint: TSpeedButton
        Tag = 7
        Left = 3
        Top = 25
        Width = 111
        Height = 26
        Caption = '&Print'
        Flat = True
        Margin = 4
        ParentShowHint = False
        ShowHint = True
        Spacing = 5
        OnClick = btPrintClick
      end
      object pnlDivisoria2: TPanel
        Left = 8
        Top = 116
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 0
      end
      object Panel5: TPanel
        Left = 8
        Top = 84
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 1
      end
      object Panel6: TPanel
        Left = 10
        Top = 53
        Width = 101
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 2
      end
      object edtNumCopy: TEdit
        Left = 48
        Top = 2
        Width = 40
        Height = 21
        TabStop = False
        TabOrder = 3
        Text = '1'
      end
      object udCopy: TUpDown
        Left = 88
        Top = 2
        Width = 15
        Height = 21
        Associate = edtNumCopy
        Min = 1
        Max = 30000
        Position = 1
        TabOrder = 4
      end
    end
    object grdVerifySearch: TcxGrid
      Left = 0
      Top = 0
      Width = 838
      Height = 251
      Align = alClient
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      object grdVerifySearchDB: TcxGridDBTableView
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDPurchaseVerify'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.##'
            Kind = skSum
            FieldName = 'QtyReceiving'
            Column = grdVerifySearchDBQtyReceiving
          end
          item
            Format = '0.##'
            Kind = skSum
            FieldName = 'QtyCounted'
            Column = grdVerifySearchDBQtyCounted
          end
          item
            Format = '0.##'
            Kind = skSum
            FieldName = 'Difference'
            Column = grdVerifySearchDBDifference
          end>
        DataController.Summary.SummaryGroups = <>
        OnCustomDrawCell = grdVerifySearchDBCustomDrawCell
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
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        object grdVerifySearchDBDBColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'EnterDate'
          Width = 82
        end
        object grdVerifySearchDBIDBarcode: TcxGridDBColumn
          DataBinding.FieldName = 'IDBarcode'
          Width = 101
        end
        object grdVerifySearchDBModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Width = 93
        end
        object grdVerifySearchDBDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 231
        end
        object grdVerifySearchDBCategory: TcxGridDBColumn
          DataBinding.FieldName = 'Category'
          Visible = False
          Width = 68
        end
        object grdVerifySearchDBSystemUser: TcxGridDBColumn
          DataBinding.FieldName = 'SystemUser'
          Visible = False
          Width = 68
        end
        object grdVerifySearchDBQtyReceiving: TcxGridDBColumn
          Caption = 'Qty.On Order'
          DataBinding.FieldName = 'QtyReceiving'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Width = 78
        end
        object grdVerifySearchDBQtyCounted: TcxGridDBColumn
          Caption = 'Qty.Received'
          DataBinding.FieldName = 'QtyCounted'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Width = 87
        end
        object grdVerifySearchDBDifference: TcxGridDBColumn
          DataBinding.FieldName = 'Difference'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Width = 78
        end
        object grdVerifySearchDBScanDate: TcxGridDBColumn
          Caption = 'Scan Date'
          DataBinding.FieldName = 'ScanDate'
          Width = 86
        end
      end
      object grdVerifySearchLevel: TcxGridLevel
        GridView = grdVerifySearchDB
      end
    end
  end
  object OD: TOpenDialog [7]
    Filter = 'Report file|*.rtm'
    Left = 249
    Top = 243
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmVerifyPO.sil'
  end
  object spRemoveItem: TADOStoredProc
    Connection = DM.ADODBConnect
    CommandTimeout = 1800
    ProcedureName = 'sp_Purchase_RemoveItem;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPurchase'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IDPurchaseItem'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@TaxInCost'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end>
    Left = 319
    Top = 489
  end
  object tmrRefresh: TTimer
    Enabled = False
    OnTimer = tmrRefreshTimer
    Left = 368
    Top = 84
  end
end
