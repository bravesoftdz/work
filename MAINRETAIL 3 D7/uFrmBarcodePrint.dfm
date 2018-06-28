inherited FrmBarcodePrint: TFrmBarcodePrint
  Left = 2
  Top = 2
  HorzScrollBar.Range = 0
  VertScrollBar.Range = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Barcode Print'
  ClientHeight = 476
  ClientWidth = 653
  KeyPreview = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 435
    Width = 653
    TabOrder = 4
    inherited EspacamentoInferior: TPanel
      Width = 653
      inherited Panel3: TPanel
        Width = 653
      end
    end
    inherited hhh: TPanel
      Left = 350
      Width = 303
      inherited sbHelp: TSpeedButton
        Left = 307
        Width = 64
        Margin = -1
        Visible = False
      end
      object btnPrint: TBitBtn [1]
        Left = 119
        Top = 3
        Width = 86
        Height = 31
        Caption = 'Print'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnPrintClick
        Glyph.Data = {
          A2070000424DA207000000000000360000002800000019000000190000000100
          1800000000006C070000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6C7C69C96949C9694FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCECBCEBDBA
          BDDEDBDEDEDFDEADAEADB5B2B59C9694BD8E84A58E84ADAEADFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFBDBABDCECFCEEFEFEFEFEFEFDEDBDEADAEADB5B2B58C8E8C4A4D4A63
          61636361638C8A8C9C9694FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFBDBEBDC6C3C6EFEBEFF7F3F7EFEFEFEFEBEFD6D3D6AD
          AAADADAEAD8C8E8C4A4D4A4241426361636361638486848C8E8CADAEADC6C7C6
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFBDBABDDEDFDEFFFBFFFFF7F7EF
          EFEFEFEBEFE7E3E7D6D3D6ADAAADADAAADADAEADADAEADADAAAD8C8A8C737173
          6361638486848C8E8CB5B2B59C9E9CFFFFFFFFFFFF00FFFFFFFFFFFFBDBABDFF
          FFFFFFFBFFFFF7F7EFEFEFEFEBEFDEDBDEB5B2B58C8E8C8482848C8E8CADAAAD
          ADAEADADAEADB5B2B5BDBABDADAEAD9C9E9C636163525152CECBCEFFFFFFFFFF
          FF00FFFFFFFFFFFFADAEADFFFBFFFFF7F7EFEFEFDEDBDE9C9E9C9C9E9CBDBABD
          C6C7C69C9E9C8C8E8C8482848482848C8E8C9C9E9CB5B2B5BDBABDBDBEBDC6C3
          C6BDBABDC6C7C6FFFFFFFFFFFF00FFFFFFFFFFFFADAAADF7F3F7CECFCE9C9694
          9C9E9CD6D3D6DEDBDED6D3D6D6D3D6CECBCEBDBEBDADAAADADAAAD9C9E9C8C8E
          8C8486848C8A8C9C9E9CBDBABD8CBE8C8CBE8CFFFFFFFFFFFF00FFFFFFFFFFFF
          9C9E9C8C8A8C9C9694DEDBDEDEDFDEDEDBDED6D3D6CECBCEEFEBEFE7E7E7E7E7
          E7EFEBEFDEDBDECECBCEBDBABDADAEADADAEAD9C96948486848482849C9694FF
          FFFFFFFFFF00FFFFFFFFFFFF8C8E8CEFEBEFE7E3E7DEDFDEDEDBDED6D3D6CECF
          CEE7E3E7DEDBDEB5B2B5BDBABDBDBABDBDBEBDCECFCEE7E7E7E7E7E7D6D3D6C6
          C7C6BDBEBDBDBABDADAAADFFFFFFFFFFFF00FFFFFFFFFFFF8C8A8CE7E3E7DEDF
          DEDEDBDED6D3D6CECFCEDEDBDEE7E7E7C6C3C6EFEFEFEFEFEFEFEBEFCECFCEBD
          BEBDBDBABDBDBABDBDBEBDD6D3D6E7E3E7DEDFDED6D3D6FFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFD6D3D6DEDBDED6D3D6CECFCEDEDFDECECFCEC6C3C6F7F3F7F7
          F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEFDEDBDEC6C7C6BDBABDBDBABDBDBABD
          CECBCEFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFE7E7E7ADAEADBDBEBDC6
          C3C6D6D3D6C6C7C6CECBCEE7E7E7F7F3F7EFEFEFEFEFEFEFEFEFEFEBEFEFEBEF
          E7E7E7E7E7E7D6D3D6ADAEADFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFADAAADE7E7E7E7E7E7ADAEADB5B2B5BDBABDBDBABDC6C3C6
          CECBCEDEDBDEE7E7E7E7E7E7EFEBEFCECBCEB5B2B5FFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADAAADFFFBF7FFF3E7EFDBCE
          D6D3D6C6C7C6C6C7C6BDBABDC6C3C6BDBEBDBDAAA5BDAAA5B5B2B5DEDBDEFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFCE9A84FFD7ADFFD7ADFFD7ADFFDFBDFFDFBDFFEBD6F7E3D6EFE7DECEAA
          ADDEDBDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6AA94FFDFBDFFD7ADFFDFBDFFD7ADFFDF
          BDFFD7ADFFDFBDF7D3A5BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3B5FFDF
          BDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDFFDFBDD6B2ADBD9A94FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFDEC7B5FFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEFFE7CEBD
          9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBD9A94FFEBD6FFEBD6FFEBD6FFEBD6FF
          EBD6FFEBD6FFEBD6EFDBCEBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDECBC6FF
          F3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7FFF3E7D6B2ADBD9A94FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFD6BEBDFFF7EFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFFBEFFFF7EF
          BD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED7D6FFFFFFFFFBFFFFFFFFFFFFFF
          FFFBFFFFFFFFFFFFFFEFEBEFBD9A94FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFCEBEB5BD9A94
          BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94BD9A94FFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF00}
        Margin = 0
      end
      object btnEdit: TBitBtn [2]
        Left = 29
        Top = 3
        Width = 86
        Height = 31
        Caption = '&Edit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnEditClick
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
      inherited btClose: TButton
        Left = 204
        Width = 88
        Cancel = True
        ModalResult = 2
        TabOrder = 2
        OnClick = btCloseClick
      end
    end
  end
  inherited EspacamentoEsquerdo: TPanel
    Top = 270
    Height = 37
  end
  inherited EspacamentoDireito: TPanel
    Left = 650
    Top = 270
    Height = 37
  end
  inherited EspacamentoSuperior: TPanel
    Top = 270
    Width = 653
    Height = 0
  end
  object pnlSetup: TPanel [4]
    Left = 0
    Top = 351
    Width = 653
    Height = 84
    Align = alBottom
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object lbReport1: TLabel
      Left = 78
      Top = 45
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Label 1 :'
    end
    object btnOpenFile: TSpeedButton
      Left = 727
      Top = 40
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
    object btRemove: TSpeedButton
      Left = 751
      Top = 40
      Width = 24
      Height = 21
      Flat = True
      Glyph.Data = {
        06030000424D06030000000000003600000028000000100000000F0000000100
        180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
        2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
        EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
        2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
        ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
        00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
        30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
        31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
        00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
        0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
        FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
        0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF}
      OnClick = btRemoveClick
    end
    object lbSetup: TLabel
      Left = 51
      Top = 1
      Width = 69
      Height = 13
      Alignment = taRightJustify
      Caption = 'Label Setup'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 124
      Top = 8
      Width = 605
      Height = 0
      Shape = bsTopLine
    end
    object lbReport2: TLabel
      Left = 78
      Top = 68
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Label 2 :'
    end
    object btnOpenFile2: TSpeedButton
      Left = 727
      Top = 63
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
      OnClick = btnOpenFile2Click
    end
    object btRemove2: TSpeedButton
      Left = 751
      Top = 63
      Width = 24
      Height = 21
      Flat = True
      Glyph.Data = {
        06030000424D06030000000000003600000028000000100000000F0000000100
        180000000000D0020000D40E0000D40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF0C31FF0C31FFFF00FF2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B1EE90030DE601DEA0030DE0030DE
        2D27E3FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF611D
        EA0030DE641DEAFF00FF3F24E62129E20030DE2429E2FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF5220E8032FDE7619EDFF00FFFF00FFFF00FFFF00FF
        2429E20030DE3625E5FF00FFFF00FFFF00FFFF00FFFF00FF551FE90030DE6D1B
        ECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF092EDF0030DE2A28E3FF00FFFF
        00FFFF00FF5420E80030DE6D1BECFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF3C41F00535E01B2BE7FF00FF4822E7062EDE7F18EEFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF564EF10435EB00
        30E40030E47919EDFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF652DED0234F10030E10032F08151F9FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6D1CF40032F1092FEB4B
        31FC4B31FC1035EB7954FAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF6D1DFB0032F50032F30C31FFFF00FFFF00FF0C31FF1041FD7A4CFBFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF761BFF0333FD0033FA0C31FFFF00FFFF
        00FFFF00FFFF00FF0C31FF1B4BFB7957FAFF00FFFF00FFFF00FFFF00FF641FFF
        0034FF0C31FF0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C31FF2448
        FF6C45FFFF00FFFF00FF6120FF0034FF0034FF0C31FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF0C31FF0C31FFFF00FFFF00FF0034FF0034FF
        0C31FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF}
      OnClick = btRemove2Click
    end
    object lbSkipRep1: TLabel
      Left = 637
      Top = 44
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'Skip :'
    end
    object lbSkipRep2: TLabel
      Left = 637
      Top = 66
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'Skip :'
    end
    object lbBarcodePrinter: TLabel
      Left = 78
      Top = 21
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = 'Printer  :'
    end
    object edtReportFile: TEdit
      Left = 122
      Top = 40
      Width = 506
      Height = 21
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 1
    end
    object edtReportFile2: TEdit
      Left = 122
      Top = 63
      Width = 506
      Height = 21
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 2
    end
    object edtSkipRep1: TEdit
      Left = 667
      Top = 40
      Width = 38
      Height = 21
      TabOrder = 3
      Text = '0'
      OnKeyPress = edtSkipRep1KeyPress
    end
    object edtSkipRep2: TEdit
      Left = 667
      Top = 62
      Width = 38
      Height = 21
      TabOrder = 4
      Text = '0'
      OnKeyPress = edtSkipRep1KeyPress
    end
    object UpDownRep1: TUpDown
      Left = 705
      Top = 40
      Width = 15
      Height = 21
      Associate = edtSkipRep1
      TabOrder = 5
    end
    object UpDown1: TUpDown
      Left = 705
      Top = 62
      Width = 15
      Height = 21
      Associate = edtSkipRep2
      TabOrder = 6
    end
    object cbxBarcodePrinter: TComboBox
      Left = 122
      Top = 17
      Width = 206
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbxBarcodePrinterChange
    end
  end
  object pgFilter: TPageControl [5]
    Left = 0
    Top = 0
    Width = 653
    Height = 270
    ActivePage = tsDate
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 5
    OnChange = pgFilterChange
    OnChanging = pgFilterChanging
    object tsMultiple: TTabSheet
      Caption = 'List'
      ImageIndex = 1
      object lbListTab: TLabel
        Left = 0
        Top = 61
        Width = 645
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = 'Search Results'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Panel18: TPanel
        Left = 0
        Top = 0
        Width = 645
        Height = 61
        Align = alTop
        TabOrder = 0
        object Label4: TLabel
          Tag = -1
          Left = 24
          Top = 10
          Width = 48
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdRightToLeft
          Caption = 'Category :'
          ParentBiDiMode = False
        end
        object lbModelGroup: TLabel
          Left = 2
          Top = 33
          Width = 70
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdRightToLeft
          Caption = 'Sub-Category :'
          ParentBiDiMode = False
        end
        object lbModelSubGroup: TLabel
          Left = 395
          Top = 10
          Width = 35
          Height = 13
          Alignment = taRightJustify
          BiDiMode = bdRightToLeft
          Caption = 'Group :'
          ParentBiDiMode = False
        end
        object cmbCategory: TSuperComboADO
          Left = 75
          Top = 6
          Width = 251
          Height = 21
          TabOrder = 0
          Text = '<-->'
          CodeLength = 100
          LookUpSource = DM.dsLookUpGroup
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          EditCodePos = taEditCodeRight
          IDLanguage = 0
        end
        object btClearCatego: TButton
          Left = 331
          Top = 7
          Width = 37
          Height = 21
          Caption = 'All'
          TabOrder = 1
          OnClick = btClearCategoClick
        end
        object cbxMethod: TComboBox
          Left = 435
          Top = 30
          Width = 86
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          TabStop = False
          Items.Strings = (
            'Starts with'
            'End with'
            'Contains')
        end
        object edModel: TEdit
          Left = 621
          Top = 30
          Width = 80
          Height = 21
          TabOrder = 3
        end
        object btAllModel: TButton
          Left = 704
          Top = 30
          Width = 37
          Height = 21
          Caption = 'All'
          TabOrder = 4
          OnClick = btAllModelClick
        end
        object btClearSubCatego: TButton
          Left = 331
          Top = 29
          Width = 37
          Height = 21
          Caption = 'All'
          TabOrder = 5
          OnClick = btClearSubCategoClick
        end
        object btClearGroup: TButton
          Left = 704
          Top = 6
          Width = 37
          Height = 21
          Caption = 'All'
          TabOrder = 6
          OnClick = btClearGroupClick
        end
        object scModelGroup: TSuperComboADO
          Left = 75
          Top = 30
          Width = 251
          Height = 21
          TabOrder = 7
          Text = '<-->'
          CodeLength = 100
          LookUpSource = DM.dsLookUpModelGroup
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          EditCodePos = taEditCodeRight
          IDLanguage = 0
        end
        object scModelSubGroup: TSuperComboADO
          Left = 435
          Top = 6
          Width = 266
          Height = 21
          TabOrder = 8
          Text = '<-->'
          CodeLength = 100
          LookUpSource = DM.dsLookUpModelSubGroup
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          EditCodePos = taEditCodeRight
          IDLanguage = 0
        end
        object cbxType: TComboBox
          Left = 523
          Top = 30
          Width = 95
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 9
          Items.Strings = (
            'Model'
            'Description'
            'Barcode')
        end
        object Panel27: TPanel
          Left = 564
          Top = 1
          Width = 80
          Height = 59
          Align = alRight
          BevelOuter = bvNone
          Caption = 'Panel27'
          TabOrder = 10
          object btnRefresh: TSpeedButton
            Left = 14
            Top = 11
            Width = 51
            Height = 32
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
            OnClick = btnRefreshClick
          end
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 75
        Width = 645
        Height = 164
        Align = alClient
        Caption = 'Panel4'
        TabOrder = 1
        object Panel14: TPanel
          Left = 769
          Top = 1
          Width = 82
          Height = 162
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object Bevel6: TBevel
            Left = 8
            Top = 47
            Width = 72
            Height = 3
          end
          object Bevel7: TBevel
            Left = 8
            Top = 80
            Width = 72
            Height = 3
          end
          object Bevel8: TBevel
            Left = 10
            Top = 114
            Width = 72
            Height = 3
          end
          object btColumn: TSpeedButton
            Left = 5
            Top = 87
            Width = 75
            Height = 25
            Caption = '&Columns'
            OnClick = btColumnClick
          end
          object btadd: TBitBtn
            Left = 5
            Top = 20
            Width = 75
            Height = 25
            Caption = 'Add'
            Enabled = False
            TabOrder = 0
            OnClick = btAddClick
          end
          object btAddAll: TBitBtn
            Left = 5
            Top = 53
            Width = 75
            Height = 25
            Caption = 'Add Al&l'
            Enabled = False
            TabOrder = 1
            OnClick = btAddAllClick
          end
          object btnClearList: TBitBtn
            Left = 5
            Top = 122
            Width = 75
            Height = 25
            Caption = 'Clear Queue'
            Enabled = False
            TabOrder = 2
            Visible = False
            OnClick = btnClearListClick
          end
        end
        object grdBarcodeByList: TcxGrid
          Left = 1
          Top = 1
          Width = 768
          Height = 162
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          LookAndFeel.Kind = lfFlat
          object grdBarcodeByListDB: TcxGridDBTableView
            DataController.Filter.Criteria = {FFFFFFFF0000000000}
            DataController.KeyFieldNames = 'IDBarcode'
            DataController.Summary.DefaultGroupSummaryItems = <
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubSellingPrice'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubFinalCost'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubVendorCost'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubFreightCost'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubOtherCost'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubRealMarkUpValue'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubSuggRetail'
              end
              item
                Format = '0'
                Kind = skSum
                Position = spFooter
                FieldName = 'PositiveQty'
              end
              item
                Format = '#,##0.00'
                Kind = skSum
                Position = spFooter
                FieldName = 'SubSellingPrice'
              end>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            Filtering.MaxDropDownCount = 50
            Filtering.Visible = fvNever
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.CellEndEllipsis = True
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLines = glHorizontal
            OptionsView.GroupByBox = False
            OptionsView.GroupFooters = gfVisibleWhenExpanded
            OptionsView.HeaderAutoHeight = True
            OptionsView.HeaderEndEllipsis = True
            Preview.AutoHeight = False
            Preview.MaxLineCount = 2
            object cxGridDBColumn21: TcxGridDBColumn
              Caption = 'Date'
              DataBinding.FieldName = 'databarcode'
              Options.Editing = False
              Options.Filtering = False
              Width = 99
            end
            object cxGridDBColumn22: TcxGridDBColumn
              Caption = 'Barcode'
              DataBinding.FieldName = 'IDBarcode'
              Options.Editing = False
              Options.Filtering = False
              SortOrder = soAscending
              Width = 120
            end
            object cxGridDBColumn23: TcxGridDBColumn
              DataBinding.FieldName = 'Model'
              Options.Editing = False
              Options.Filtering = False
              Width = 101
            end
            object cxGridDBColumn24: TcxGridDBColumn
              DataBinding.FieldName = 'Category'
              Visible = False
              Width = 100
            end
            object cxGridDBColumn25: TcxGridDBColumn
              Caption = 'OnHand'
              DataBinding.FieldName = 'qtyOnHand'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
              Width = 51
            end
            object cxGridDBColumn26: TcxGridDBColumn
              DataBinding.FieldName = 'Description'
              Options.Editing = False
              Options.Filtering = False
              Width = 150
            end
            object grdBarcodeByListDBDBColumn1: TcxGridDBColumn
              Caption = 'Store Price'
              DataBinding.FieldName = 'StoreAVGPrice'
              Visible = False
              Width = 105
            end
            object cxGridDBColumn27: TcxGridDBColumn
              Caption = 'Selling Price'
              DataBinding.FieldName = 'SellingPrice'
              Options.Editing = False
              Options.Filtering = False
              Width = 76
            end
            object cxGridDBColumn28: TcxGridDBColumn
              Caption = 'Num. Copies'
              DataBinding.FieldName = 'NumCopy'
              PropertiesClassName = 'TcxCurrencyEditProperties'
              Properties.DisplayFormat = '0.00;-0.00'
            end
            object cxGridDBColumn29: TcxGridDBColumn
              DataBinding.FieldName = 'Subcategory'
              Visible = False
            end
            object cxGridDBColumn30: TcxGridDBColumn
              Caption = 'Group'
              DataBinding.FieldName = 'msgGroup'
              Visible = False
            end
          end
          object grdBarcodeByListGridLevel: TcxGridLevel
            GridView = grdBarcodeByListDB
          end
        end
      end
    end
    object tsDate: TTabSheet
      Caption = 'Last Update'
      ImageIndex = 1
      object lbLastUpdateTab: TLabel
        Left = 0
        Top = 61
        Width = 645
        Height = 14
        Align = alTop
        Alignment = taCenter
        Caption = 'Search Results'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 645
        Height = 61
        Align = alTop
        TabOrder = 0
        object lbFrom: TLabel
          Left = 6
          Top = 12
          Width = 29
          Height = 13
          Alignment = taRightJustify
          Caption = 'From :'
        end
        object lbTo: TLabel
          Left = 16
          Top = 37
          Width = 16
          Height = 13
          Alignment = taRightJustify
          Caption = 'To:'
        end
        object dtStart: TDateBox
          Left = 42
          Top = 8
          Width = 93
          Height = 21
          TabOrder = 0
        end
        object dtEnd: TDateBox
          Left = 43
          Top = 33
          Width = 93
          Height = 21
          TabOrder = 1
        end
        object Panel28: TPanel
          Left = 564
          Top = 1
          Width = 80
          Height = 59
          Align = alRight
          BevelOuter = bvNone
          Caption = 'Panel28'
          TabOrder = 2
          object btnRefreshLastUpdate: TSpeedButton
            Left = 19
            Top = 13
            Width = 51
            Height = 32
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
            OnClick = btnRefreshClick
          end
        end
      end
      object Panel6: TPanel
        Left = 563
        Top = 75
        Width = 82
        Height = 164
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object Bevel4: TBevel
          Left = 7
          Top = 47
          Width = 72
          Height = 3
        end
        object Bevel5: TBevel
          Left = 8
          Top = 114
          Width = 72
          Height = 3
        end
        object btColumn2: TSpeedButton
          Left = 5
          Top = 87
          Width = 75
          Height = 25
          Caption = '&Columns'
          OnClick = btColumnClick
        end
        object Bevel9: TBevel
          Left = 8
          Top = 80
          Width = 72
          Height = 3
        end
        object btAddLast: TBitBtn
          Left = 5
          Top = 20
          Width = 75
          Height = 25
          Caption = '&Add'
          Enabled = False
          TabOrder = 0
          OnClick = btAddClick
        end
        object btAddAllLast: TBitBtn
          Left = 5
          Top = 53
          Width = 75
          Height = 25
          Caption = 'Add Al&l'
          TabOrder = 1
          OnClick = btAddAllClick
        end
        object btClearLastUpdate: TBitBtn
          Left = 5
          Top = 122
          Width = 75
          Height = 25
          Caption = 'Clear Queue'
          TabOrder = 2
          Visible = False
        end
      end
      object grdBarcodeLastUpdate: TcxGrid
        Left = 0
        Top = 75
        Width = 563
        Height = 164
        Align = alClient
        TabOrder = 2
        LookAndFeel.Kind = lfFlat
        object grdBarcodeLastUpdateDB: TcxGridDBTableView
          DataController.Filter.Criteria = {FFFFFFFF0000000000}
          DataController.KeyFieldNames = 'IDBarcode'
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubSellingPrice'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubFinalCost'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubVendorCost'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubFreightCost'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubOtherCost'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubRealMarkUpValue'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubSuggRetail'
            end
            item
              Format = '0'
              Kind = skSum
              Position = spFooter
              FieldName = 'PositiveQty'
            end
            item
              Format = '#,##0.00'
              Kind = skSum
              Position = spFooter
              FieldName = 'SubSellingPrice'
            end>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.MaxDropDownCount = 50
          Filtering.Visible = fvNever
          OptionsBehavior.IncSearch = True
          OptionsCustomize.ColumnFiltering = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.HeaderAutoHeight = True
          OptionsView.HeaderEndEllipsis = True
          Preview.AutoHeight = False
          Preview.MaxLineCount = 2
          object cxGridDBColumn11: TcxGridDBColumn
            Caption = 'Date'
            DataBinding.FieldName = 'data'
            Options.Editing = False
            Options.Filtering = False
            Width = 91
          end
          object cxGridDBColumn12: TcxGridDBColumn
            Caption = 'Barcode'
            DataBinding.FieldName = 'IDBarcode'
            Options.Editing = False
            Options.Filtering = False
            SortOrder = soAscending
            Width = 104
          end
          object cxGridDBColumn13: TcxGridDBColumn
            DataBinding.FieldName = 'Model'
            Options.Editing = False
            Options.Filtering = False
            Width = 88
          end
          object cxGridDBColumn14: TcxGridDBColumn
            DataBinding.FieldName = 'Category'
            Visible = False
            Width = 100
          end
          object cxGridDBColumn15: TcxGridDBColumn
            Caption = 'OnHand'
            DataBinding.FieldName = 'qtyOnHand'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Options.Editing = False
            Width = 69
          end
          object cxGridDBColumn16: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Options.Editing = False
            Options.Filtering = False
            Width = 234
          end
          object cxGridDBColumn17: TcxGridDBColumn
            Caption = 'Selling Price'
            DataBinding.FieldName = 'SellingPrice'
            Options.Editing = False
            Options.Filtering = False
            Width = 69
          end
          object cxGridDBColumn18: TcxGridDBColumn
            Caption = 'Num. Copies'
            DataBinding.FieldName = 'NumCopy'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = '0'
            Options.Editing = False
            Width = 73
          end
          object cxGridDBColumn19: TcxGridDBColumn
            DataBinding.FieldName = 'Subcategory'
            Visible = False
          end
          object cxGridDBColumn20: TcxGridDBColumn
            Caption = 'Group'
            DataBinding.FieldName = 'msgGroup'
            Visible = False
          end
        end
        object grdBarcodeLastUpdateLevel: TcxGridLevel
          GridView = grdBarcodeLastUpdateDB
        end
      end
    end
    object tsBarcodeQueue: TTabSheet
      Caption = 'Quick Print'
      ImageIndex = 2
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 645
        Height = 61
        Align = alTop
        TabOrder = 0
        object lblSearchType: TLabel
          Left = 4
          Top = 15
          Width = 62
          Height = 13
          Caption = 'Search with :'
        end
        object lblVendor: TLabel
          Left = 25
          Top = 39
          Width = 40
          Height = 13
          Caption = 'Vendor :'
        end
        object cbxSearchType: TComboBox
          Left = 74
          Top = 7
          Width = 140
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'Barcode'
            'Model'
            'Vendor SKU')
        end
        object scVendor: TSuperComboADO
          Left = 74
          Top = 31
          Width = 339
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          LookUpSource = DM.dsLookUpFornecedor
          DropDownRows = 18
          ShowBtnAddNew = False
          ShowBtnUpdate = False
          IDLanguage = 0
        end
        object edtSearch: TEdit
          Left = 212
          Top = 7
          Width = 201
          Height = 21
          TabOrder = 2
          OnChange = edtSearchChange
          OnKeyPress = edtSearchKeyPress
        end
      end
    end
  end
  object Panel2: TPanel [6]
    Left = 3
    Top = 270
    Width = 647
    Height = 37
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 6
    object lbPrinQueue: TLabel
      Left = 1
      Top = 1
      Width = 645
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'Print Queue'
      Color = clBtnShadow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Panel8: TPanel
      Left = 558
      Top = 15
      Width = 88
      Height = 21
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Bevel2: TBevel
        Left = 12
        Top = 40
        Width = 72
        Height = 3
      end
      object Bevel3: TBevel
        Left = 13
        Top = 79
        Width = 73
        Height = 3
      end
      object btDel: TBitBtn
        Left = 9
        Top = 9
        Width = 75
        Height = 25
        Caption = '&Del'
        Enabled = False
        TabOrder = 0
        OnClick = btDelClick
      end
      object btDelAll: TBitBtn
        Left = 11
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Del All'
        Enabled = False
        TabOrder = 1
        OnClick = btDelAllClick
      end
    end
    object grdBarcode: TcxGrid
      Left = 1
      Top = 15
      Width = 557
      Height = 21
      Align = alClient
      TabOrder = 1
      LookAndFeel.Kind = lfFlat
      object grdBarcodeDB: TcxGridDBTableView
        DataController.Filter.Criteria = {FFFFFFFF0000000000}
        DataController.KeyFieldNames = 'IDBarcode'
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubSellingPrice'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubFinalCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubVendorCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubFreightCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubOtherCost'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubRealMarkUpValue'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubSuggRetail'
          end
          item
            Format = '0'
            Kind = skSum
            Position = spFooter
            FieldName = 'PositiveQty'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            FieldName = 'SubSellingPrice'
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        Filtering.MaxDropDownCount = 50
        Filtering.Visible = fvNever
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.HeaderAutoHeight = True
        OptionsView.HeaderEndEllipsis = True
        Preview.AutoHeight = False
        Preview.MaxLineCount = 2
        object grdBarcodeDBIDBarcode: TcxGridDBColumn
          Caption = 'Barcode'
          DataBinding.FieldName = 'idbarcode'
          Options.Editing = False
          Options.Filtering = False
          Width = 104
        end
        object grdBarcodeDBModel: TcxGridDBColumn
          DataBinding.FieldName = 'Model'
          Options.Editing = False
          Options.Filtering = False
          SortOrder = soAscending
          Width = 88
        end
        object grdBarcodeDBCategory: TcxGridDBColumn
          DataBinding.FieldName = 'Category'
          Visible = False
          Options.Editing = False
          Width = 100
        end
        object grdBarcodeDBDBQtyOnHand: TcxGridDBColumn
          Caption = 'OnHand'
          DataBinding.FieldName = 'qtyOnHand'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          Options.Editing = False
          Options.Sorting = False
          Width = 69
        end
        object grdBarcodeDBDescription: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Options.Editing = False
          Options.Filtering = False
          Width = 234
        end
        object grdBarcodeDBDBColumn3: TcxGridDBColumn
          Caption = 'Store Price'
          DataBinding.FieldName = 'StoreAVGPrice'
          Visible = False
          Options.Editing = False
        end
        object grdBarcodeDBSellingPrice: TcxGridDBColumn
          Caption = 'Selling Price'
          DataBinding.FieldName = 'SellingPrice'
          Options.Editing = False
          Options.Filtering = False
          Width = 69
        end
        object grdBarcodeDBDBColumn1: TcxGridDBColumn
          Caption = 'Label'
          DataBinding.FieldName = 'report'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.Items.Strings = (
            'Label 1'
            'Label 2')
          Properties.ReadOnly = False
          Properties.OnCloseUp = grdBarcodeDBDBColumn1PropertiesCloseUp
          Options.Sorting = False
        end
        object grdBarcodeDBNumCopy: TcxGridDBColumn
          Caption = 'Num. Copies'
          DataBinding.FieldName = 'NumCopy'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 0
          Properties.DisplayFormat = '######0'
          Properties.ReadOnly = False
          Options.Sorting = False
          Width = 73
        end
        object grdBarcodeDBDBSubcategory: TcxGridDBColumn
          DataBinding.FieldName = 'Subcategory'
          Visible = False
          Options.Editing = False
        end
        object grdBarcodeDBDBGroup: TcxGridDBColumn
          Caption = 'Group'
          DataBinding.FieldName = 'msgGroup'
          Visible = False
          Options.Editing = False
        end
        object grdBarcodeDBDBColumn2: TcxGridDBColumn
          Caption = 'IdModel'
          DataBinding.FieldName = 'idmodel'
          Visible = False
          Options.Editing = False
        end
      end
      object grdBarcodeLevel: TcxGridLevel
        GridView = grdBarcodeDB
      end
    end
  end
  object Panel5: TPanel [7]
    Left = 0
    Top = 307
    Width = 653
    Height = 44
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 7
    object chkSendToPrinter: TCheckBox
      Left = 5
      Top = 4
      Width = 221
      Height = 19
      Caption = 'Send straight to printer. ( Don'#39't queue )'
      TabOrder = 0
      OnClick = chkSendToPrinterClick
    end
    object chkInventoryCopy: TCheckBox
      Left = 5
      Top = 22
      Width = 231
      Height = 17
      Caption = 'Make label quantity equal quantity on hand.'
      TabOrder = 1
      OnClick = chkInventoryCopyClick
    end
    object chkSaveQueue: TCheckBox
      Left = 415
      Top = 7
      Width = 113
      Height = 17
      Caption = 'Save print queue.'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkPrimaryUpc: TCheckBox
      Left = 415
      Top = 24
      Width = 295
      Height = 17
      Caption = 'Display primary barcodes only.'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object ppReport: TppReport [8]
    AutoStop = False
    Columns = 3
    ColumnPositions.Strings = (
      '4064'
      '74676'
      '146050')
    DataPipeline = ppDBPipeline
    PrinterSetup.BinName = 'Manual'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Letter'
    PrinterSetup.PrinterName = 'CutePDF Writer'
    PrinterSetup.mmMarginBottom = 17526
    PrinterSetup.mmMarginLeft = 4064
    PrinterSetup.mmMarginRight = 4064
    PrinterSetup.mmMarginTop = 14224
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    Template.FileName = 
      'C:\Users\OFFICE\Documents\My Dropbox\MainRetail_Reports\V5_Label' +
      's\Labels\SO1-lbs-311Y-Img-Product.rtm'
    DeviceType = 'Screen'
    OnPreviewFormCreate = ppReportPreviewFormCreate
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 349
    Top = 329
    Version = '7.02'
    mmColumnWidth = 69256
    DataPipelineName = 'ppDBPipeline'
    object ppColumnHeaderBand1: TppColumnHeaderBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppDetailBand1: TppDetailBand
      ColumnTraversal = ctLeftToRight
      mmBottomOffset = 0
      mmHeight = 37835
      mmPrintPosition = 0
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        DataField = 'Description'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 8467
        mmLeft = 32279
        mmTop = 3175
        mmWidth = 35983
        BandType = 4
      end
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        DataField = 'Price'
        DataPipeline = ppDBPipeline
        DisplayFormat = '$#,0.00;-$#,0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial Black'
        Font.Size = 14
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 7938
        mmLeft = 38894
        mmTop = 21167
        mmWidth = 21696
        BandType = 4
      end
      object RBDBEan: TRBDBEan
        UserName = 'DBEan'
        BackgroundColor = clWhite
        Transparent = False
        ShowLabels = False
        StartStopLines = True
        TypBarCode = bcCode128
        LinesColor = clBlack
        Ean13AddUp = True
        FontAutoSize = True
        Security = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Angle = 0
        LabelMask = '__________________________________________________'
        DisableEditor = False
        DataField = 'Barcode'
        DataPipeLine = ppDBPipeline
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 5027
        mmLeft = 38365
        mmTop = 12171
        mmWidth = 24342
        BandType = 4
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        DataField = 'Barcode'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3440
        mmLeft = 37835
        mmTop = 17463
        mmWidth = 24871
        BandType = 4
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'Model'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3175
        mmLeft = 1058
        mmTop = 26723
        mmWidth = 29369
        BandType = 4
      end
      object ppDBImage1: TppDBImage
        UserName = 'DBImage1'
        MaintainAspectRatio = False
        Stretch = True
        DataField = 'LargeImage'
        DataPipeline = ppDBPipeline
        GraphicType = 'Bitmap'
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 24871
        mmLeft = 794
        mmTop = 1323
        mmWidth = 29898
        BandType = 4
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        DataField = 'SizeName'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4022
        mmLeft = 33073
        mmTop = 12700
        mmWidth = 17198
        BandType = 4
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        DataField = 'Color'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4022
        mmLeft = 51329
        mmTop = 12700
        mmWidth = 16669
        BandType = 4
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        DataField = 'ModelToScan'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4022
        mmLeft = 2646
        mmTop = 32279
        mmWidth = 17198
        BandType = 4
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        DataField = 'BarcodeToScan'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4022
        mmLeft = 34925
        mmTop = 32279
        mmWidth = 17198
        BandType = 4
      end
    end
    object ppColumnFooterBand1: TppColumnFooterBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppParameterList1: TppParameterList
    end
  end
  object ppDBPipeline: TppDBPipeline [9]
    DataSource = dsBarcodePrint
    CloseDataSource = True
    UserName = 'Barcode'
    Left = 349
    Top = 374
    object ppDBPipelineppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'IDModel'
      FieldName = 'IDModel'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 0
      Position = 0
    end
    object ppDBPipelineppField2: TppField
      FieldAlias = 'Model'
      FieldName = 'Model'
      FieldLength = 30
      DisplayWidth = 30
      Position = 1
    end
    object ppDBPipelineppField3: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 50
      DisplayWidth = 50
      Position = 2
    end
    object ppDBPipelineppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'SuggRetail'
      FieldName = 'SuggRetail'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 3
    end
    object ppDBPipelineppField5: TppField
      FieldAlias = 'SizeName'
      FieldName = 'SizeName'
      FieldLength = 20
      DisplayWidth = 20
      Position = 4
    end
    object ppDBPipelineppField6: TppField
      FieldAlias = 'CodSize'
      FieldName = 'CodSize'
      FieldLength = 10
      DisplayWidth = 10
      Position = 5
    end
    object ppDBPipelineppField7: TppField
      FieldAlias = 'Color'
      FieldName = 'Color'
      FieldLength = 20
      DisplayWidth = 20
      Position = 6
    end
    object ppDBPipelineppField8: TppField
      FieldAlias = 'CodColor'
      FieldName = 'CodColor'
      FieldLength = 10
      DisplayWidth = 10
      Position = 7
    end
    object ppDBPipelineppField9: TppField
      FieldAlias = 'Category'
      FieldName = 'Category'
      FieldLength = 30
      DisplayWidth = 30
      Position = 8
    end
    object ppDBPipelineppField10: TppField
      FieldAlias = 'SubCategory'
      FieldName = 'SubCategory'
      FieldLength = 30
      DisplayWidth = 30
      Position = 9
    end
    object ppDBPipelineppField11: TppField
      FieldAlias = 'Group'
      FieldName = 'Group'
      FieldLength = 30
      DisplayWidth = 30
      Position = 10
    end
    object ppDBPipelineppField12: TppField
      FieldAlias = 'Barcode'
      FieldName = 'Barcode'
      FieldLength = 20
      DisplayWidth = 20
      Position = 11
    end
    object ppDBPipelineppField13: TppField
      Alignment = taRightJustify
      FieldAlias = 'PromotionPrice'
      FieldName = 'PromotionPrice'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 12
    end
    object ppDBPipelineppField14: TppField
      Alignment = taRightJustify
      FieldAlias = 'DiscountPerc'
      FieldName = 'DiscountPerc'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 13
    end
    object ppDBPipelineppField15: TppField
      Alignment = taRightJustify
      FieldAlias = 'VendorCost'
      FieldName = 'VendorCost'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 14
    end
    object ppDBPipelineppField16: TppField
      Alignment = taRightJustify
      FieldAlias = 'AvgCost'
      FieldName = 'AvgCost'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 15
    end
    object ppDBPipelineppField17: TppField
      Alignment = taRightJustify
      FieldAlias = 'SellingPrice'
      FieldName = 'SellingPrice'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 16
    end
    object ppDBPipelineppField18: TppField
      Alignment = taRightJustify
      FieldAlias = 'Price'
      FieldName = 'Price'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 17
    end
    object ppDBPipelineppField19: TppField
      Alignment = taRightJustify
      FieldAlias = 'StoreCostPrice'
      FieldName = 'StoreCostPrice'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 18
    end
    object ppDBPipelineppField20: TppField
      Alignment = taRightJustify
      FieldAlias = 'StoreAvgPrice'
      FieldName = 'StoreAvgPrice'
      FieldLength = 4
      DataType = dtDouble
      DisplayWidth = 20
      Position = 19
    end
    object ppDBPipelineppField21: TppField
      FieldAlias = 'LargeImage'
      FieldName = 'LargeImage'
      FieldLength = 255
      DisplayWidth = 255
      Position = 20
    end
    object ppDBPipelineppField22: TppField
      FieldAlias = 'LargeImage2'
      FieldName = 'LargeImage2'
      FieldLength = 255
      DisplayWidth = 255
      Position = 21
    end
    object ppDBPipelineppField23: TppField
      Alignment = taRightJustify
      FieldAlias = 'IDVendor'
      FieldName = 'IDVendor'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 22
    end
    object ppDBPipelineppField24: TppField
      FieldAlias = 'VendorNum'
      FieldName = 'VendorNum'
      FieldLength = 6
      DisplayWidth = 6
      Position = 23
    end
    object ppDBPipelineppField25: TppField
      FieldAlias = 'Vendor'
      FieldName = 'Vendor'
      FieldLength = 50
      DisplayWidth = 50
      Position = 24
    end
    object ppDBPipelineppField26: TppField
      Alignment = taRightJustify
      FieldAlias = 'NumCopies'
      FieldName = 'NumCopies'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 25
    end
    object ppDBPipelineppField27: TppField
      FieldAlias = 'Manufacture'
      FieldName = 'Manufacture'
      FieldLength = 50
      DisplayWidth = 50
      Position = 26
    end
    object ScaleValidDay: TppField
      FieldAlias = 'ScaleValidDay'
      FieldName = 'ScaleValidDay'
      FieldLength = 10
      DataType = dtInteger
      DisplayWidth = 10
      Position = 27
    end
    object ValidDate: TppField
      FieldAlias = 'ValidDate'
      FieldName = 'ValidDate'
      FieldLength = 10
      DataType = dtDateTime
      DisplayWidth = 10
      Position = 28
    end
    object ppDBPipelineppField28: TppField
      FieldAlias = 'ModelToScan'
      FieldName = 'ModelToScan'
      FieldLength = 10
      DisplayWidth = 10
      Position = 29
    end
    object ppDBPipelineppField29: TppField
      FieldAlias = 'BarcodeToScan'
      FieldName = 'BarcodeToScan'
      FieldLength = 10
      DisplayWidth = 10
      Position = 30
    end
  end
  object dsBarcodePrint: TDataSource [10]
    DataSet = cdsBarcodePrint
    Left = 517
    Top = 438
  end
  object ppDesigner: TppDesigner [11]
    AllowDataSettingsChange = True
    Caption = 'Application Network - Dynamic Reports'
    DataSettings.DatabaseName = 'ADODBConnect'
    DataSettings.SessionType = 'ADOSession'
    DataSettings.AllowEditSQL = True
    DataSettings.CollationType = ctASCII
    DataSettings.DatabaseType = dtMSSQLServer
    DataSettings.IsCaseSensitive = True
    DataSettings.SQLType = sqSQL1
    DataSettings.UseDataDictionary = True
    Position = poScreenCenter
    Report = ppReport
    ShowData = False
    IniStorageType = 'IniFile'
    IniStorageName = '($WINSYS)\RBBuilder.ini'
    WindowHeight = 400
    WindowLeft = 100
    WindowTop = 50
    WindowWidth = 600
    WindowState = wsMaximized
    Left = 350
    Top = 285
  end
  object OD: TOpenDialog [12]
    Filter = 'Report file|*.rtm'
    Left = 665
    Top = 30
  end
  inherited siLang: TsiLangRT
    StorageFile = 'MR_FrmBarcodePrint.sil'
    Left = 32
    Top = 204
  end
  object quBarcodePrint: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    AfterOpen = quBarcodePrintAfterOpen
    CommandText = 
      'SELECT'#13#10#9'M.IDModel,'#13#10#9'M.Model,'#13#10#9'M.Description,'#13#10#9'M.SuggRetail,'#13 +
      #10#9'S.SizeName,'#13#10#9'S.CodSize,'#13#10#9'C.Color,'#13#10#9'C.CodColor,'#13#10#9'CT.Name as' +
      ' Category,'#13#10#9'MG.ModelGroup as SubCategory,'#13#10#9'MSG.ModelSubGroup a' +
      's [Group],'#13#10#9'LTRIM(RTRIM(B.IDBarcode)) as Barcode,'#13#10#9'M.Promotion' +
      'Price,'#13#10#9'M.DiscountPerc,'#13#10#9'M.VendorCost,'#13#10#9'M.AvgCost,'#13#10#9'M.Sellin' +
      'gPrice,'#13#10#9'M.LargeImage,'#13#10#9'M.LargeImage2,'#13#10#9'M.ScaleValidDay,'#13#10#9'(C' +
      'ASE IsNull(INV.SellingPrice,0) WHEN 0 THEN P.NewSalePrice ELSE I' +
      'NV.SellingPrice END) as Price,'#13#10#9'(CASE IsNull(INV.SellingPrice,0' +
      ') WHEN 0 THEN P.NewSalePrice ELSE INV.SellingPrice END) as Store' +
      'SellPrice,'#13#10#9'(CASE IsNull(INV.StoreCostPrice,0) WHEN 0 THEN M.Ve' +
      'ndorCost ELSE INV.StoreCostPrice END) as StoreCostPrice,'#13#10#9'(CASE' +
      ' IsNull(INV.StoreAvgPrice,0) WHEN 0 THEN M.AvgCost ELSE INV.Stor' +
      'eAvgPrice END) as StoreAvgPrice,'#13#10#9'V.IDPessoa as IDVendor,'#13#10#9'V.U' +
      'serCode as VendorNum,'#13#10#9'V.Pessoa as Vendor,'#13#10#9'F.Pessoa as Manufa' +
      'cture,'#13#10#9'CAST(1 as int) as NumCopy,'#13#10#9'CAST(DATEADD(day, M.ScaleV' +
      'alidDay, GetDate()) as DateTime) ValidDate,'#13#10'                LTR' +
      'IM(RTRIM(B.IDBarcode)) IdBarcode,'#13#10'               ('#39'*'#39' + LTRIM(R' +
      'TRIM(M.Model)) + '#39'*'#39' ) as ModelToScan,'#13#10'               ('#39'*'#39' + LT' +
      'RIM(RTRIM(B.IdBarcode)) + '#39'*'#39') as BarcodeToScan '#13#10'FROM'#13#10#9'Barcode' +
      ' B (NOLOCK)'#13#10#9'JOIN Model M (NOLOCK) ON (B.IDModel = M.IDModel)'#13#10 +
      #9'JOIN TabGroup CT (NOLOCK) ON (M.GroupID = CT.IDGroup)'#13#10#9'LEFT OU' +
      'TER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelG' +
      'roup)'#13#10#9'LEFT OUTER JOIN ModelSubGroup MSG (NOLOCK) ON (M.IDModel' +
      'SubGroup = MSG.IDModelSubGroup)'#13#10#9'LEFT OUTER JOIN InvSize S (NOL' +
      'OCK) ON (S.IDSize = M.IDSize)'#13#10#9'LEFT OUTER JOIN InvColor C (NOLO' +
      'CK) ON (C.IDColor = M.IDColor)'#13#10#9'LEFT JOIN Inventory INV (NOLOCK' +
      ') ON (INV.ModelID = M.IDModel AND INV.StoreID = :StoreID)'#13#10'     ' +
      '           LEFT OUTER JOIN Pur_PurchaseItem P (NOLOCK) on (B.IDM' +
      'odel = P.IDModel and B.BarcodeOrder = 1 and ct.IDGroup = p.IDGro' +
      'up)  '#13#10'                JOIN #Temp_Barcode TB ON (TB.Barcode = B.' +
      'IDBarcode)'#13#10#9'LEFT OUTER JOIN Inv_ModelVendor MV (NOLOCK) ON (M.I' +
      'DModel = MV.IDModel AND MV.VendorOrder = 1)'#13#10#9'LEFT OUTER JOIN Pe' +
      'ssoa V (NOLOCK) ON (MV.IDPessoa = V.IDPessoa)'#13#10#9'LEFT OUTER JOIN ' +
      'Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)'#13#10'WHERE '#13#10#9'M.D' +
      'esativado = 0'#13#10'              and  ( ( :IdPurchase is null ) or (' +
      ' ( :IdPurchase IS not NULL ) and ( :IdPurchase = P.IdPurchase) )' +
      ' )'#13#10#13#10
    CommandTimeout = 720
    Parameters = <
      item
        Name = 'StoreID'
        Size = -1
        Value = Null
      end
      item
        Name = 'IdPurchase'
        Size = -1
        Value = Null
      end
      item
        Name = 'IdPurchase'
        Size = -1
        Value = Null
      end
      item
        Name = 'IdPurchase'
        Size = -1
        Value = Null
      end>
    Left = 516
    Top = 287
  end
  object dspBarcodePrint: TDataSetProvider
    DataSet = quBarcodePrint
    Left = 516
    Top = 346
  end
  object cdsBarcodePrint: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'IDModel'
        DataType = ftInteger
      end
      item
        Name = 'Model'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'SuggRetail'
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'SizeName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CodSize'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Color'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CodColor'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Category'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'SubCategory'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Group'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Barcode'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PromotionPrice'
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'DiscountPerc'
        DataType = ftFloat
      end
      item
        Name = 'VendorCost'
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'AvgCost'
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'SellingPrice'
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'StoreSellPrice'
        Attributes = [faReadonly]
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'StoreCostPrice'
        Attributes = [faReadonly]
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'StoreAvgPrice'
        Attributes = [faReadonly]
        DataType = ftBCD
        Precision = 19
        Size = 4
      end
      item
        Name = 'LargeImage'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'LargeImage2'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'IDVendor'
        DataType = ftInteger
      end
      item
        Name = 'VendorNum'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'Vendor'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'NumCopies'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'Manufacture'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ScaleValidDay'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'StoreID'
        ParamType = ptInput
        Size = -1
      end
      item
        DataType = ftInteger
        Name = 'IdPurchase'
        ParamType = ptInput
        Size = -1
      end
      item
        DataType = ftInteger
        Name = 'IdPurchase'
        ParamType = ptInput
        Size = -1
      end
      item
        DataType = ftInteger
        Name = 'IdPurchase'
        ParamType = ptInput
        Size = -1
      end>
    ProviderName = 'dspBarcodePrint'
    StoreDefs = True
    AfterOpen = cdsBarcodePrintAfterOpen
    BeforeClose = cdsBarcodePrintBeforeClose
    Left = 516
    Top = 390
  end
  object quModelFeature: TADODataSet
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    CommandText = 
      #13#10'SELECT'#13#10#9'F.IDInvFeatures,'#13#10#9'F.Feature'#13#10'FROM'#13#10#9'InvFeatures F (N' +
      'OLOCK)'#13#10'WHERE'#13#10#9'F.IDModel = :IDModel'
    CommandTimeout = 180
    DataSource = dsBarcodePrint
    Parameters = <
      item
        Name = 'IDModel'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 600
    Top = 283
    object quModelFeatureIDInvFeatures: TIntegerField
      FieldName = 'IDInvFeatures'
    end
    object quModelFeatureFeature: TStringField
      FieldName = 'Feature'
      Size = 255
    end
  end
  object dsModelFeature: TDataSource
    DataSet = quModelFeature
    Left = 600
    Top = 338
  end
  object ppModelFeature: TppDBPipeline
    DataSource = dsModelFeature
    CloseDataSource = True
    SkipWhenNoRecords = False
    UserName = 'ModelFeature'
    Left = 595
    Top = 404
  end
  object quLookUpGroup: TLookUpADOQuery
    CursorType = ctOpenForwardOnly
    MaxRecords = 200
    CommandText = 
      'SELECT IDGroup , Name, PathName, UserCode'#13#10'FROM dbo.TabGroup Tab' +
      'Group (FastFirstRow NOLOCK) ORDER BY Name'#13#10
    Parameters = <>
    SecondFieldType = ftString
    ListField = 'Name'
    CodeField = 'PathName'
    CodeFieldSearch = False
    LookUpField = 'IDGroup'
    Left = 30
    Top = 75
    object quLookUpGroupIDGroup: TIntegerField
      FieldName = 'IDGroup'
    end
    object quLookUpGroupName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object quLookUpGroupPathName: TStringField
      FieldName = 'PathName'
      Size = 255
    end
    object quLookUpGroupUserCode: TStringField
      FieldName = 'UserCode'
      Size = 5
    end
  end
  object dsLookUpGroup: TDataSource
    DataSet = quLookUpGroup
    Left = 96
    Top = 90
  end
end
