inherited FrmPrintPO: TFrmPrintPO
  Left = 82
  Top = 12
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Print PO'
  ClientHeight = 144
  ClientWidth = 201
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton [0]
    Left = 61
    Top = 110
    Width = 75
    Height = 25
    Caption = 'Print PO'
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object sortOrderRadio: TRadioGroup [1]
    Left = 0
    Top = 10
    Width = 185
    Height = 90
    Caption = 'sortOrderRadio'
    Columns = 2
    Items.Strings = (
      'Barcode '
      'Cost'
      'Description'
      'Model'
      'Qty'
      'VendorCost')
    TabOrder = 1
  end
  inherited siLang: TsiLangRT
    Left = 12
    Top = 72
  end
  object ppReport: TppReport
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'Carta'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 279401
    PrinterSetup.mmPaperWidth = 215900
    PrinterSetup.PaperSize = 1
    AllowPrintToArchive = True
    AllowPrintToFile = True
    DeviceType = 'Screen'
    Icon.Data = {
      0000010002002020000001001800A80C0000260000002020000001002000A810
      0000CE0C00002800000020000000400000000100180000000000800C00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000009D9D9C8988877275
      7569686A73727175767500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000008485847475738A8B8B9B999BA5A3A4A8A7A7A7A6A6A8A8
      A8A6A6A6DCDCDCDFDEDF78787873757500000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000006D6D6D717272A5A6A5CAC9C9CECECDC5C6C5BABBBBB2B2B2ABABAAA7A7
      A7A1A1A1CCCCCCFFFFFFF8F8F8A3A2A263636300000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000686766
      979696CFCDCEE6E5E5E2E2E1D2D2D2C8C8C7BFBEBEB6B6B6AFAFAFA9A9AAA5A5
      A5A1A1A1D5D6D6FFFFFFF7F7F7FFFFFFCDCCCD61616200000000000000000000
      0000000000000000000000000000000000000000000000000000000000E2E0DF
      FFFFFFF3F3F3E5E4E4D9D7D7D1D0CFCBCBC9CBCACBC8C8C7C4C4C4BEBFBFBDBD
      BDB2B3B2A2A2A2EFEFEFFEFEFEF6F6F6FFFFFFF1F0F086868600000000000000
      0000000000000000000000000000000000000000000000000000000000F1F0F1
      F3F2F2EAE9E9E8E8E8E7E6E6E6E6E6E0DFDFCECECEBEBFBEB5B5B5B0B0B0ACAC
      AC9D9D9D6D6D6E858686DCDBDCFFFEFEF7F7F6FFFEFEFEFFFE8D8E8D00000000
      0000000000000000000000000000000000000000000000000000D3D2D2EDEBEB
      F7F7F6F2F1F1E1E1E0C9C8C8BEBEBFBCBCBDBBBABABBBBBBB8B7B7B1B0B1A6A6
      A6A6A7A7C7C7C7B5B4B5939293BBBBBAF9F9F9FBFBFBFFFEFFF6F5F674737200
      0000000000000000000000000000000000000000000000000000DBDBDAE0E1E0
      D0D0D0BBBBBBBCBBBBCFCECEE5E4E4F0EEEEE9E8E9D8D7D8C6C6C7B9B8B8AEAE
      AEA6A6A5BFC0BFD1D4D1D6D7D79394938F8E8CDEDEDEFFFFFFFFFFFFAEAEAA00
      0000000000000000000000000000000000000000000000000000C5C5C5A1A1A1
      CCCCCDE5E4E4F9F8F8F9F8F8F0EFEFE3E3E2D4D3D4C4C3C4BCBBBCBFBDBDC6C6
      C5A3A3A3919191C5C8C5CDCFCEDFE1E0ACADAB7B7A79B3B3B3FFFFFFD8D8D600
      0000000000000000000000000000000000000000000000000000B9BABAD1D1D0
      FFFDFEEFEEEEDBDBDAD6D6D6D4D4D3BFBFBDC5C5C5C9C7C6D0CDCCEAEAEACECD
      CBE1E0E09C9C9CA9A9A8C6C9C6CCCECDE7E8E7D2D2D18181828C8C8BDCDCDC00
      0000000000000000000000000000000000000000000000000000000000C2C0BE
      D2D2D2B2B1B0CDCDCDCFCECDD3D3D1E4E4E4CDCAC9E9E8E7E3E1DFDFDCDCF1F1
      F0D7D4D2E5E4E49C9C9DB4B6B4C4C6C3CACCCAE4E5E4EBEBEB9E9F9E7D7D7E00
      0000000000000000000000000000000000000000000000000000000000ACA8A5
      CCCBCBE0DFDED0CCC9E3E2E1DBDBDAC8C5C5CECFCECECDCBF0F0F0DBD8D8E1DE
      DEEAEAE9E5E4E3E0E1E1B3B3B3E5E6E5D0D2D0D5D6D5E1E2E1F4F5F4AEAEAE00
      0000000000000000000000000000000000000000000000000000000000000000
      AFA9A4D4D4D3E5E5E5DCDAD9DEDDDDD8D6D6CDCDCAD5D5D4D6D4D2F4F3F2E1DF
      DFEFEFF0E1DFDFECECECE7E6E7DCDBDCD1D1D0BDBFBDDBDDDBEDEEEDC8C9C800
      0000000000000000000000000000000000000000000000000000000000000000
      0000009F9C98E3E4E7E1E0DFCCCAC8FAFBFBF2F1F0F7F8F7DDDFE0E8E9EAE2E2
      E3BEBEBE9D9E9E7676776767684B4A4B605F5F3739397A7978DEDEDEDEDEDE00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3AFAEE1E2E3EAEBECDEDFE1ADB0B485888C7575757373727878
      784241421414141111110C0C0E0404044B4B4B3D3E3D1516154E4D4C9A999900
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000A8A6A75B5D5E545250797166AA977EDCC6A2998B7A5256
      5A4B494A0F0F0F1C1C1C2525242525254C4C4C77777633333235363561606000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000B7A48FEFD0AAFFDCB2FFD8AFFFD9B1EDD2B0625F
      5D5A5B5D4B4B4A5555555A5A5A5657564F50503D3C3E5453545B5C5B9B9B9B00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000E0CDB7FFDAAEFECAA8FED1B1FCD2B5FFE2C3CDC0
      AC949495ADAEAE3D3D3D222222232222161514454544A4A4A400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFDFC4FFE3CAFADEC5FBDCC4FBE1CCFFFD
      ECC6C4BF0000000000000000000000002529319FA1A300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4E6D8FCEBDAF8E9D8F6EADDF9EF
      E2FEFBF4B6B6B6000000000000000000614E30645C4C756C5C877C6800000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DAD8D5FAF1E5F5EBE1F3EBE0F8F0
      E5FAF9F6ABAEB4000000C29840D09D2EFCB42AEEAC2FF9B927DAAD587F859000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000EFEDECFAF7F5F7F7F6FAFA
      F9F8F7F69FA5AEC7BAA5FFCE44FFC93AFFC338FFC135FFC529BA934E686D7700
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000E8E8EAFFFFFFF9FAFBF1F1
      F1E9E7E7BFC1C6B5B3AFC59A43C29645A1844B9D7E469D7D4559504200000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000CCCCCCD1D1D10000000000
      000000000000000000009795928E8E90888A9000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC
      0FFFFF8003FFFE0001FFF80000FFF800007FF800003FF000001FF000001FF000
      001FF000001FF800001FF800001FFC00001FFE00001FFF00001FFF80001FFFC0
      001FFFC0007FFFE03CFFFFF01C3FFFF0101FFFF8001FFFF8003FFFF9F1FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF280000002000000040000000010020000000
      00008010000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FDFDFD02FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F1F112E3E4E322DFDFE024D9D8D929CACAC938BBBB
      BB45E8E8E81CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01EEEE
      EE11D8D8D828BDBCBD51A9A8A97A9D9D9C96898887B3727575D269686AE27372
      71F0757675CFA0A1A17FEFEFEF15FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F708C5C5C53A848584857475
      73B98A8B8BD19B999BEBA5A3A4F7A8A7A7FCA7A6A6FFA8A8A8FFA6A6A6FFDCDC
      DCFFDFDEDFFF787878FF737575B2E1E1E122FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E6E6E6199FA0A0656D6D6DAC717272E6A5A6A5FFCAC9
      C9FFCECECDFFC5C6C5FFBABBBBFFB2B2B2FFABABAAFFA7A7A7FFA1A1A1FFCCCC
      CCFDFFFFFFFDF8F8F8FFA3A2A2FF636363CBC4C4C33CFFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E5E5E530686766C3979696FFCFCDCEFFE6E5E5FFE2E2E1FFD2D2
      D2FFC8C8C7FFBFBEBEFFB6B6B6FFAFAFAFFFA9A9AAFFA5A5A5FFA1A1A1FFD5D6
      D6FEFFFFFFFDF7F7F7FDFFFFFFFDCDCCCDFF616162E9A0A0A05FFFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D8D7D764E2E0DFFFFFFFFFFFF3F3F3FFE5E4E4FFD9D7D7FFD1D0
      CFFFCBCBC9FFCBCACBFFC8C8C7FEC4C4C4FFBEBFBFFFBDBDBDFEB2B3B2FFA2A2
      A2FEEFEFEFFDFEFEFEFDF6F6F6FDFFFFFFFDF1F0F0FF868686F2A3A3A35FFEFE
      FE01FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D5D4D46AF1F0F1FFF3F2F2FFEAE9E9FFE8E8E8FFE7E6E6FFE6E6
      E6FFE0DFDFFECECECEFEBEBFBEFFB5B5B5FEB0B0B0FFACACACFF9D9D9DFE6D6D
      6EFD858686FEDCDBDCFEFFFEFEFDF7F7F6FDFFFEFEFDFEFFFEFF8D8E8DF2A0A0
      A063FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D3D2D280EDEBEBFFF7F7F6FFF2F1F1FFE1E1E0FFC9C8C8FFBEBE
      BFFFBCBCBDFFBBBABAFFBBBBBBFFB8B7B7FFB1B0B1FFA6A6A6FFA6A7A7FEC7C7
      C7FDB5B4B5FD939293FDBBBBBAFDF9F9F9FDFBFBFBFDFFFEFFFDF6F5F6FF7473
      72DBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DBDBDA93E0E1E0FFD0D0D0FFBBBBBBFEBCBBBBFECFCECEFEE5E4
      E4FFF0EEEEFFE9E8E9FFD8D7D8FFC6C6C7FFB9B8B8FFAEAEAEFFA6A6A5FEBFC0
      BFFED1D4D1FFD6D7D7FF939493FE8F8E8CFEDEDEDEFDFFFFFFFDFFFFFFFFAEAE
      AAFAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C5C5C59DA1A1A1FFCCCCCDFEE5E4E4FFF9F8F8FFF9F8F8FFF0EF
      EFFFE3E3E2FFD4D3D4FEC4C3C4FEBCBBBCFFBFBDBDFDC6C6C5FEA3A3A3FE9191
      91FEC5C8C5FFCDCFCEFFDFE1E0FEACADABFE7B7A79FDB3B3B3FEFFFFFFFFD8D8
      D6FAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B9BABAA5D1D1D0FFFFFDFEFFEFEEEEFEDBDBDAFED6D6D6FED4D4
      D3FDBFBFBDFDC5C5C5FDC9C7C6FDD0CDCCFEEAEAEAFDCECDCBFEE1E0E0FD9C9C
      9CFDA9A9A8FEC6C9C6FFCCCECDFFE7E8E7FFD2D2D1FF818182FF8C8C8BFFDCDC
      DCF9FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CDCDCD6BC2C0BEFFD2D2D2FFB2B1B0FDCDCDCDFECFCECDFDD3D3
      D1FDE4E4E4FDCDCAC9FEE9E8E7FDE3E1DFFEDFDCDCFEF1F1F0FDD7D4D2FDE5E4
      E4FD9C9C9DFDB4B6B4FDC4C6C3FECACCCAFFE4E5E4FFEBEBEBFF9E9F9EFF7D7D
      7EEFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F8F7F70FACA8A59ACCCBCBFEE0DFDEFFD0CCC9FEE3E2E1FDDBDB
      DAFDC8C5C5FDCECFCEFDCECDCBFEF0F0F0FDDBD8D8FEE1DEDEFDEAEAE9FDE5E4
      E3FDE0E1E1FDB3B3B3FDE5E6E5FED0D2D0FFD5D6D5FFE1E2E1FFF4F5F4FFAEAE
      AEEEFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F6F5F410AFA9A4A4D4D4D3FFE5E5E5FEDCDAD9FEDEDD
      DDFDD8D6D6FDCDCDCAFED5D5D4FED6D4D2FEF4F3F2FDE1DFDFFEEFEFF0FDE1DF
      DFFEECECECFDE7E6E7FDDCDBDCFDD1D1D0FDBDBFBDFEDBDDDBFFEDEEEDFFC8C9
      C8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7E5E7259F9C98DAE3E4E7FFE1E0DFFFCCCA
      C8FDFAFBFBFDF2F1F0FDF7F8F7FDDDDFE0FDE8E9EAFDE2E2E3FDBEBEBEFE9D9E
      9EFE767677FE676768FE4B4A4BFE605F5FFE373939FD7A7978FEDEDEDEFFDEDE
      DEFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D0CE49B3AFAEBDE1E2E3FBEAEB
      ECFFDEDFE1FDADB0B4FD85888CFD757575FD737372FD787878FE424142FE1414
      14FE111111FE0C0C0EFE040404FE4B4B4BFD3D3E3DFD151615FF4E4D4CFF9A99
      99FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E8E5E428A8A6A7A25B5D
      5EFE545250FF797166FFAA977EFEDCC6A2FF998B7AFE52565AFD4B494AFF0F0F
      0FFF1C1C1CFD252524FD252525FD4C4C4CFD777776FD333332FF353635FF6160
      60DCFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D5D3D23EB7A4
      8FEAEFD0AAFFFFDCB2FFFFD8AFFFFFD9B1FFEDD2B0FF625F5DFD5A5B5DF64B4B
      4AFF555555FF5A5A5AFF565756FF4F5050FD3D3C3EFF545354FF5B5C5BFF9B9B
      9B9AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F5F50FE0CD
      B7C3FFDAAEFFFECAA8FFFED1B1FEFCD2B5FEFFE2C3FECDC0ACFE949495AFADAE
      AE8A3D3D3DEE222222FF232222FF161514FF454544DFA4A4A48EC0BFBF66F1F1
      F116FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E3
      E150FFDFC4F6FFE3CAFFFADEC5FEFBDCC4FEFBE1CCFEFFFDECFFC6C4BFE0D5D5
      D541DFDFDF34B9BAB969ABABAC77252931FF9FA1A38BFDFDFD02F0F0F016FAFA
      FA09FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF01EDE8E570F4E6D8FBFCEBDAFFF8E9D8FEF6EADDFEF9EFE2FEFEFBF4FFB6B6
      B699FFFFFF00F0F0F014BBBAB95E614E30FF645C4CDB756C5CC7877C68E8B8B8
      BA7CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF01DAD8D5A9FAF1E5FFF5EBE1FEF3EBE0FEF8F0E5FEFAF9F6FFABAE
      B4AEBCB3A673C29840E3D09D2EFEFCB42AFFEEAC2FFFF9B927FFDAAD58FF7F85
      90BBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E4E5E566EFEDECFFFAF7F5FEF7F7F6FEFAFAF9FFF8F7F6FF9FA5
      AEB8C7BAA5A1FFCE44FDFFC93AFFFFC338FFFFC135FFFFC529FFBA934EFF686D
      77C1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DFE0E04AE8E8EAFFFFFFFFFFF9FAFBFFF1F1F1FFE9E7E7FFBFC1
      C694B5B3AF8BC59A43FFC29645FFA1844BFF9D7E46FF9D7D45FF595042ED9FA0
      A16CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0F0F020CCCCCC98D1D1D190DCDDDC72E1E1E15DE3E3E34BF8F8
      F813CCCCCC599795929B8E8E908F888A9083999B9E74B2B4B75DCCCCCD3AF9F9
      F906FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFDFFFFFFF9FFFFFFF9
      FFFFFFF80FFFFF8003FFFE0001FFF80000FFF000007FF000001FF000001FF000
      001FF000001FF000001FF000001FF000001FF000001FF800001FFC00001FFE00
      001FFF00001FFF80001FFF80001FFFC0001FFFC0101FFFE0001FFFF0001FFFF0
      001FFFF0001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = True
    OutlineSettings.Visible = False
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zs100Percent
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 72
    Top = 72
    Version = '7.02'
    mmColumnWidth = 0
    object ppHeaderBand: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 529
      mmPrintPosition = 0
    end
    object ppDetailBand: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 5027
      mmPrintPosition = 0
      object ppSubReport: TppSubReport
        UserName = 'SubReport'
        ExpandAll = False
        NewPrintJob = False
        OutlineSettings.CreateNode = True
        TraverseAllData = False
        DataPipelineName = 'ppTransferItems'
        mmHeight = 5027
        mmLeft = 0
        mmTop = 0
        mmWidth = 203200
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        object ppChildReport: TppChildReport
          AutoStop = False
          DataPipeline = ppTransferItems
          PrinterSetup.BinName = 'Default'
          PrinterSetup.DocumentName = 'Report'
          PrinterSetup.PaperName = 'Carta'
          PrinterSetup.PrinterName = 'Default'
          PrinterSetup.mmMarginBottom = 6350
          PrinterSetup.mmMarginLeft = 6350
          PrinterSetup.mmMarginRight = 6350
          PrinterSetup.mmMarginTop = 6350
          PrinterSetup.mmPaperHeight = 279401
          PrinterSetup.mmPaperWidth = 215900
          PrinterSetup.PaperSize = 1
          Version = '7.02'
          mmColumnWidth = 0
          DataPipelineName = 'ppTransferItems'
          object ppTitleBand: TppTitleBand
            mmBottomOffset = 0
            mmHeight = 0
            mmPrintPosition = 0
          end
          object ppDetailBand2: TppDetailBand
            mmBottomOffset = 0
            mmHeight = 3704
            mmPrintPosition = 0
            object ppDBText6: TppDBText
              UserName = 'DBText6'
              DataField = 'Description'
              DataPipeline = ppTransferItems
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppTransferItems'
              mmHeight = 3440
              mmLeft = 31221
              mmTop = 0
              mmWidth = 65617
              BandType = 4
            end
            object ppDBText5: TppDBText
              UserName = 'DBText5'
              DataField = 'Model'
              DataPipeline = ppTransferItems
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppTransferItems'
              mmHeight = 3440
              mmLeft = 265
              mmTop = 0
              mmWidth = 30427
              BandType = 4
            end
            object ppDBText9: TppDBText
              UserName = 'DBText9'
              DataField = 'CostTotal'
              DataPipeline = ppTransferItems
              DisplayFormat = '#,0.00;-#,0.00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              DataPipelineName = 'ppTransferItems'
              mmHeight = 3704
              mmLeft = 180975
              mmTop = 0
              mmWidth = 18521
              BandType = 4
            end
            object ppDBText16: TppDBText
              UserName = 'DBText16'
              DataField = 'VendorCode'
              DataPipeline = ppTransferItems
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppTransferItems'
              mmHeight = 3440
              mmLeft = 128323
              mmTop = 0
              mmWidth = 27781
              BandType = 4
            end
            object ppVariable1: TppVariable
              UserName = 'varQty'
              CalcOrder = 0
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taRightJustified
              Transparent = True
              mmHeight = 3440
              mmLeft = 156634
              mmTop = 0
              mmWidth = 11906
              BandType = 4
            end
            object ppLabel7: TppLabel
              UserName = 'lblCase1'
              Caption = 'lblCase'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              TextAlignment = taCentered
              Transparent = True
              mmHeight = 3440
              mmLeft = 169069
              mmTop = 0
              mmWidth = 11377
              BandType = 4
            end
            object ppDBText8: TppDBText
              UserName = 'DBText8'
              DataField = 'Barcode'
              DataPipeline = ppTransferItems
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Name = 'Tahoma'
              Font.Size = 8
              Font.Style = []
              Transparent = True
              DataPipelineName = 'ppTransferItems'
              mmHeight = 3440
              mmLeft = 97631
              mmTop = 0
              mmWidth = 30163
              BandType = 4
            end
          end
          object ppGroup2: TppGroup
            BreakName = 'DocumentID'
            DataPipeline = ppTransferItems
            KeepTogether = True
            OutlineSettings.CreateNode = True
            UserName = 'Group2'
            mmNewColumnThreshold = 0
            mmNewPageThreshold = 0
            DataPipelineName = 'ppTransferItems'
            object ppGroupHeaderBand2: TppGroupHeaderBand
              mmBottomOffset = 0
              mmHeight = 3440
              mmPrintPosition = 0
              object ppLabel5: TppLabel
                UserName = 'lbModel'
                ReprintOnOverFlow = True
                AutoSize = False
                Caption = 'Model'
                Color = 15921906
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                mmHeight = 3440
                mmLeft = 265
                mmTop = 0
                mmWidth = 30427
                BandType = 3
                GroupNo = 0
              end
              object ppLabel6: TppLabel
                UserName = 'lbDescription'
                ReprintOnOverFlow = True
                AutoSize = False
                Caption = 'Description'
                Color = 15921906
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                mmHeight = 3440
                mmLeft = 31221
                mmTop = 0
                mmWidth = 65617
                BandType = 3
                GroupNo = 0
              end
              object ppLabel18: TppLabel
                UserName = 'Label18'
                ReprintOnOverFlow = True
                AutoSize = False
                Caption = 'Barcode'
                Color = 15921906
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                mmHeight = 3440
                mmLeft = 97631
                mmTop = 0
                mmWidth = 30163
                BandType = 3
                GroupNo = 0
              end
              object ppLabel12: TppLabel
                UserName = 'lbModel1'
                ReprintOnOverFlow = True
                AutoSize = False
                Caption = 'Vendor Code'
                Color = 15921906
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                mmHeight = 3440
                mmLeft = 128323
                mmTop = 0
                mmWidth = 27781
                BandType = 3
                GroupNo = 0
              end
              object ppLabel8: TppLabel
                UserName = 'lbQty'
                ReprintOnOverFlow = True
                AutoSize = False
                Caption = 'Qty'
                Color = 15921906
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                TextAlignment = taCentered
                mmHeight = 3440
                mmLeft = 156634
                mmTop = 0
                mmWidth = 11906
                BandType = 3
                GroupNo = 0
              end
              object ppLabel16: TppLabel
                UserName = 'lblCase'
                ReprintOnOverFlow = True
                AutoSize = False
                Caption = 'UOM'
                Color = 15921906
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                TextAlignment = taCentered
                mmHeight = 3440
                mmLeft = 169069
                mmTop = 0
                mmWidth = 11377
                BandType = 3
                GroupNo = 0
              end
              object ppLabel9: TppLabel
                UserName = 'lbAmount1'
                ReprintOnOverFlow = True
                AutoSize = False
                Caption = 'Total Cost'
                Color = 15921906
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                TextAlignment = taRightJustified
                mmHeight = 3440
                mmLeft = 180975
                mmTop = 0
                mmWidth = 18521
                BandType = 3
                GroupNo = 0
              end
            end
            object ppGroupFooterBand2: TppGroupFooterBand
              mmBottomOffset = 0
              mmHeight = 4763
              mmPrintPosition = 0
              object ppLabel11: TppLabel
                UserName = 'lbFROM1'
                Caption = 'Totals :'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = []
                TextAlignment = taRightJustified
                Transparent = True
                mmHeight = 3429
                mmLeft = 140092
                mmTop = 265
                mmWidth = 9398
                BandType = 5
                GroupNo = 0
              end
              object ppDBCalc1: TppDBCalc
                UserName = 'DBCalc1'
                DataField = 'Qty'
                DataPipeline = ppTransferItems
                DisplayFormat = '0.######;-0.######'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = [fsBold]
                ResetGroup = ppGroup2
                TextAlignment = taRightJustified
                Transparent = True
                DataPipelineName = 'ppTransferItems'
                mmHeight = 3440
                mmLeft = 156634
                mmTop = 265
                mmWidth = 11906
                BandType = 5
                GroupNo = 0
              end
              object ppDBCalc3: TppDBCalc
                UserName = 'DBCalc3'
                DataField = 'CostTotal'
                DataPipeline = ppTransferItems
                DisplayFormat = '#,0.00;-#,0.00'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Tahoma'
                Font.Size = 8
                Font.Style = [fsBold]
                ResetGroup = ppGroup2
                TextAlignment = taRightJustified
                Transparent = True
                DataPipelineName = 'ppTransferItems'
                mmHeight = 3440
                mmLeft = 180975
                mmTop = 265
                mmWidth = 18521
                BandType = 5
                GroupNo = 0
              end
              object ppLine2: TppLine
                UserName = 'Line2'
                Weight = 0.750000000000000000
                mmHeight = 794
                mmLeft = 794
                mmTop = 265
                mmWidth = 198438
                BandType = 5
                GroupNo = 0
              end
            end
          end
          object raCodeModule2: TraCodeModule
            ProgramStream = {
              01060A54726150726F6772616D094368696C645479706502130B50726F677261
              6D4E616D65060E476C6F62616C4F6E4372656174650B50726F6772616D547970
              65070B747450726F63656475726506536F7572636506B470726F636564757265
              20476C6F62616C4F6E4372656174653B0D0A626567696E0D0A20206C624D6F64
              656C2E43617074696F6E202020202020203A3D20734D6F64656C3B0D0A20206C
              624465736372697074696F6E2E43617074696F6E203A3D2073446573633B0D0A
              20206C625174792E43617074696F6E2020202020202020203A3D20735174793B
              0D0A20206C626C436173652E43617074696F6E202020202020203A3D20734361
              73653B0D0A656E643B0D0A0001060F5472614576656E7448616E646C65720B50
              726F6772616D4E616D65060C7661725174794F6E43616C630B50726F6772616D
              54797065070B747450726F63656475726506536F7572636506B070726F636564
              757265207661725174794F6E43616C63287661722056616C75653A2056617269
              616E74293B0D0A626567696E0D0A0D0A202069662028504F4974656D735B2743
              617365517479275D203E203029205448454E200D0A202020202056616C756520
              3A3D20504F4974656D735B2743617365517479275D0D0A2020656C73650D0A20
              2020202056616C7565203A3D20504F4974656D735B27556E6974517479275D3B
              0D0A0D0A656E643B0D0A0D436F6D706F6E656E744E616D650606766172517479
              094576656E744E616D6506064F6E43616C63074576656E74494402210001060F
              5472614576656E7448616E646C65720B50726F6772616D4E616D650611446574
              61696C4265666F72655072696E740B50726F6772616D54797065070B74745072
              6F63656475726506536F7572636506AC70726F6365647572652044657461696C
              4265666F72655072696E743B0D0A626567696E0D0A0969662028504F4974656D
              735B2743617365517479275D203C3E203029207468656E0D0A09096C626C4361
              7365312E43617074696F6E203A3D20274353273B0D0A0969662028504F497465
              6D735B2748617343617365275D203D203029205448454E0D0A09096C626C4361
              7365312E43617074696F6E203A3D20274541273B0D0A656E643B0D0A0D436F6D
              706F6E656E744E616D65060644657461696C094576656E744E616D65060B4265
              666F72655072696E74074576656E74494402180000}
          end
        end
      end
    end
    object ppSummaryBand3: TppSummaryBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppGroup1: TppGroup
      BreakName = 'DocumentID'
      KeepTogether = True
      OutlineSettings.CreateNode = True
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = ''
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 43127
        mmPrintPosition = 0
        object ppLabel1: TppLabel
          UserName = 'lbNum'
          Caption = 'PO #:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3440
          mmLeft = 130440
          mmTop = 1588
          mmWidth = 10848
          BandType = 3
          GroupNo = 0
        end
        object ppDBText1: TppDBText
          UserName = 'DBText1'
          AutoSize = True
          DataField = 'DocumentID'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3429
          mmLeft = 143404
          mmTop = 1588
          mmWidth = 1778
          BandType = 3
          GroupNo = 0
        end
        object ppDBText2: TppDBText
          UserName = 'DBText2'
          DataField = 'Vendor'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 7673
          mmTop = 15346
          mmWidth = 53181
          BandType = 3
          GroupNo = 0
        end
        object ppDBText3: TppDBText
          UserName = 'DBText3'
          DataField = 'Address'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 7673
          mmTop = 19315
          mmWidth = 53181
          BandType = 3
          GroupNo = 0
        end
        object ppLabel10: TppLabel
          UserName = 'lbDate'
          Caption = 'Date:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = []
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3440
          mmLeft = 130175
          mmTop = 5556
          mmWidth = 11113
          BandType = 3
          GroupNo = 0
        end
        object ppDBText10: TppDBText
          UserName = 'DBText10'
          AutoSize = True
          DataField = 'DataPedido'
          DataPipeline = ppTransfer
          DisplayFormat = 'mm/dd/yyyy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3429
          mmLeft = 143404
          mmTop = 5556
          mmWidth = 17526
          BandType = 3
          GroupNo = 0
        end
        object ppDBText12: TppDBText
          UserName = 'DBText12'
          DataField = 'Phone'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 22754
          mmTop = 31221
          mmWidth = 41540
          BandType = 3
          GroupNo = 0
        end
        object ppDBText13: TppDBText
          UserName = 'DBText13'
          DataField = 'VendorCityStateZip'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 7673
          mmTop = 23283
          mmWidth = 56886
          BandType = 3
          GroupNo = 0
        end
        object ppDBText24: TppDBText
          UserName = 'DBText24'
          DataField = 'VendorAccount'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 22754
          mmTop = 35190
          mmWidth = 38365
          BandType = 3
          GroupNo = 0
        end
        object lbAccount: TppLabel
          UserName = 'lbAccount'
          Caption = 'Account:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3440
          mmLeft = 7673
          mmTop = 35190
          mmWidth = 12435
          BandType = 3
          GroupNo = 0
        end
        object ppLabel17: TppLabel
          UserName = 'Label1'
          Caption = 'Vendor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 7673
          mmTop = 10583
          mmWidth = 13843
          BandType = 3
          GroupNo = 0
        end
        object ppDBText17: TppDBText
          UserName = 'DBText17'
          DataField = 'Store'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 87313
          mmTop = 15346
          mmWidth = 53181
          BandType = 3
          GroupNo = 0
        end
        object ppDBText18: TppDBText
          UserName = 'DBText18'
          DataField = 'StoreAddress'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 87313
          mmTop = 19315
          mmWidth = 53181
          BandType = 3
          GroupNo = 0
        end
        object ppDBText19: TppDBText
          UserName = 'DBText19'
          DataField = 'StoreCityStateZip'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 87313
          mmTop = 23283
          mmWidth = 66146
          BandType = 3
          GroupNo = 0
        end
        object ppDBText21: TppDBText
          UserName = 'DBText201'
          DataField = 'StoreEmail'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 100013
          mmTop = 35190
          mmWidth = 53446
          BandType = 3
          GroupNo = 0
        end
        object ppLabel13: TppLabel
          UserName = 'lbFax1'
          Caption = 'Fax:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3440
          mmLeft = 87313
          mmTop = 27252
          mmWidth = 6085
          BandType = 3
          GroupNo = 0
        end
        object ppLabel14: TppLabel
          UserName = 'lbEmail1'
          Caption = 'Email:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3440
          mmLeft = 87313
          mmTop = 35190
          mmWidth = 8731
          BandType = 3
          GroupNo = 0
        end
        object ppDBText22: TppDBText
          UserName = 'DBText22'
          DataField = 'StoreFax'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 100013
          mmTop = 27252
          mmWidth = 53446
          BandType = 3
          GroupNo = 0
        end
        object ppLabel15: TppLabel
          UserName = 'lbTel2'
          Caption = 'Phone:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3440
          mmLeft = 87313
          mmTop = 31221
          mmWidth = 10583
          BandType = 3
          GroupNo = 0
        end
        object ppDBText23: TppDBText
          UserName = 'DBText23'
          DataField = 'StorePhone'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 100013
          mmTop = 31221
          mmWidth = 53446
          BandType = 3
          GroupNo = 0
        end
        object ppLabel2: TppLabel
          UserName = 'Label2'
          Caption = 'Ship To:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 4233
          mmLeft = 87313
          mmTop = 10583
          mmWidth = 14552
          BandType = 3
          GroupNo = 0
        end
        object ppLabel3: TppLabel
          UserName = 'Label3'
          Caption = 'Phone:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3440
          mmLeft = 7673
          mmTop = 31221
          mmWidth = 10054
          BandType = 3
          GroupNo = 0
        end
        object ppLabel4: TppLabel
          UserName = 'Label4'
          Caption = 'Fax:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3440
          mmLeft = 7673
          mmTop = 27252
          mmWidth = 6085
          BandType = 3
          GroupNo = 0
        end
        object ppDBText7: TppDBText
          UserName = 'DBText7'
          DataField = 'Fax'
          DataPipeline = ppTransfer
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Tahoma'
          Font.Size = 8
          Font.Style = [fsBold]
          ParentDataPipeline = False
          Transparent = True
          DataPipelineName = 'ppTransfer'
          mmHeight = 3440
          mmLeft = 22754
          mmTop = 27252
          mmWidth = 41804
          BandType = 3
          GroupNo = 0
        end
        object ppLine1: TppLine
          UserName = 'Line1'
          Weight = 0.750000000000000000
          mmHeight = 1058
          mmLeft = 1588
          mmTop = 40481
          mmWidth = 198173
          BandType = 3
          GroupNo = 0
        end
        object ppLogoImage: TppImage
          UserName = 'LogoImage'
          MaintainAspectRatio = False
          mmHeight = 13229
          mmLeft = 173302
          mmTop = 10848
          mmWidth = 13229
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 265
        mmPrintPosition = 0
      end
    end
    object raCodeModule1: TraCodeModule
      ProgramStream = {
        01060D54726156617250726F6772616D094368696C645479706502110B50726F
        6772616D4E616D6506095661726961626C65730B50726F6772616D5479706507
        0B747450726F63656475726506536F75726365065B70726F6365647572652056
        61726961626C65733B0D0A7661720D0A202020734D6F64656C2C207344657363
        2C20735174792C2073436173652C20416D6F756E74203A20737472696E673B0D
        0A626567696E0D0A0D0A656E643B0D0A0001060A54726150726F6772616D0943
        68696C645479706502130B50726F6772616D4E616D65060E476C6F62616C4F6E
        4372656174650B50726F6772616D54797065070B747450726F63656475726506
        536F75726365140904000070726F63656475726520476C6F62616C4F6E437265
        6174653B0D0A7661720D0A202049444C616E67203A20496E74656765723B0D0A
        626567696E200D0A202049444C616E67203A3D205265706F72742E506172616D
        65746572732E56616C7565735B2749444C616E6775616765275D3B0D0A202063
        6173652049444C616E67206F660D0A20202020313A626567696E20202020200D
        0A0920206C6254656C322E43617074696F6E202020203A3D202750686F6E6520
        3A273B0D0A0920206C624E756D2E43617074696F6E20202020203A3D2027504F
        2023273B0D0A0920206C62446174652E43617074696F6E202020203A3D202744
        617465203A273B0D0A0920206C624163636F756E742E43617074696F6E203A3D
        20274163636F756E74203A273B0D0A092020734D6F64656C2020202020202020
        202020203A3D20274D6F64656C273B0D0A092020734465736309202020202020
        20203A3D20274465736372697074696F6E273B0D0A0920207351747909202020
        20202020203A3D2027517479273B0D0A09202073436173652020202020202020
        20202020203A3D202743617365273B0D0A202020202020656E643B0D0A202020
        20323A626567696E20202020200D0A0920206C6254656C322E43617074696F6E
        202020203A3D202754656C203A273B0D0A20202020202020206C624E756D2E43
        617074696F6E20202020203A3D20274EC2BA204F43273B0D0A0920206C624163
        636F756E742E43617074696F6E203A3D2027436F6E7461203A273B0D0A202020
        2020202020734D6F64656C2020202020202020202020203A3D20274D6F64656C
        6F273B0D0A2020202020202020734465736320090920203A3D20274465736372
        69C3A7C3A36F273B0D0A2020202020202020735174790920202020202020203A
        3D2027517464273B0D0A20202020202020207343617365202020202020202020
        202020203A3D2027456D62616C6167656D273B0D0A202020202020656E643B0D
        0A20202020333A626567696E20202020200D0A0920206C6254656C322E436170
        74696F6E202020203A3D202754656C203A273B0D0A20202020202020206C624E
        756D2E43617074696F6E20202020203A3D20274EC2BA204F43273B0D0A092020
        6C624163636F756E742E43617074696F6E203A3D20274375656E7461203A273B
        0D0A2020202020202020734D6F64656C2020202020202020202020203A3D2027
        4D6F64656C6F273B0D0A2020202020202020734465736320090920203A3D2027
        446573637269706369C3B36E273B0D0A20202020202020207351747909202020
        20202020203A3D2027437464273B0D0A20202020202020207343617365202020
        202020202020202020203A3D2027456D62616C616A65273B0D0A202020202020
        656E643B0D0A2020656E643B0D0A656E643B0D0A0000}
    end
    object ppParameterList1: TppParameterList
      object IDLanguage: TppParameter
        DataType = dtInteger
        Value = 1
      end
    end
  end
  object ppDesigner: TppDesigner
    AllowDataSettingsChange = True
    Caption = 'Dynamic Reports'
    DataSettings.DatabaseName = 'ADODBConnect'
    DataSettings.SessionType = 'ADOSession'
    DataSettings.AllowEditSQL = True
    DataSettings.CollationType = ctASCII
    DataSettings.DatabaseType = dtMSSQLServer
    DataSettings.IsCaseSensitive = True
    DataSettings.SQLType = sqSQL1
    DataSettings.UseDataDictionary = True
    Icon.Data = {
      0000010002002020000001001800A80C0000260000002020000001002000A810
      0000CE0C00002800000020000000400000000100180000000000800C00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000009D9D9C8988877275
      7569686A73727175767500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000008485847475738A8B8B9B999BA5A3A4A8A7A7A7A6A6A8A8
      A8A6A6A6DCDCDCDFDEDF78787873757500000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000006D6D6D717272A5A6A5CAC9C9CECECDC5C6C5BABBBBB2B2B2ABABAAA7A7
      A7A1A1A1CCCCCCFFFFFFF8F8F8A3A2A263636300000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000686766
      979696CFCDCEE6E5E5E2E2E1D2D2D2C8C8C7BFBEBEB6B6B6AFAFAFA9A9AAA5A5
      A5A1A1A1D5D6D6FFFFFFF7F7F7FFFFFFCDCCCD61616200000000000000000000
      0000000000000000000000000000000000000000000000000000000000E2E0DF
      FFFFFFF3F3F3E5E4E4D9D7D7D1D0CFCBCBC9CBCACBC8C8C7C4C4C4BEBFBFBDBD
      BDB2B3B2A2A2A2EFEFEFFEFEFEF6F6F6FFFFFFF1F0F086868600000000000000
      0000000000000000000000000000000000000000000000000000000000F1F0F1
      F3F2F2EAE9E9E8E8E8E7E6E6E6E6E6E0DFDFCECECEBEBFBEB5B5B5B0B0B0ACAC
      AC9D9D9D6D6D6E858686DCDBDCFFFEFEF7F7F6FFFEFEFEFFFE8D8E8D00000000
      0000000000000000000000000000000000000000000000000000D3D2D2EDEBEB
      F7F7F6F2F1F1E1E1E0C9C8C8BEBEBFBCBCBDBBBABABBBBBBB8B7B7B1B0B1A6A6
      A6A6A7A7C7C7C7B5B4B5939293BBBBBAF9F9F9FBFBFBFFFEFFF6F5F674737200
      0000000000000000000000000000000000000000000000000000DBDBDAE0E1E0
      D0D0D0BBBBBBBCBBBBCFCECEE5E4E4F0EEEEE9E8E9D8D7D8C6C6C7B9B8B8AEAE
      AEA6A6A5BFC0BFD1D4D1D6D7D79394938F8E8CDEDEDEFFFFFFFFFFFFAEAEAA00
      0000000000000000000000000000000000000000000000000000C5C5C5A1A1A1
      CCCCCDE5E4E4F9F8F8F9F8F8F0EFEFE3E3E2D4D3D4C4C3C4BCBBBCBFBDBDC6C6
      C5A3A3A3919191C5C8C5CDCFCEDFE1E0ACADAB7B7A79B3B3B3FFFFFFD8D8D600
      0000000000000000000000000000000000000000000000000000B9BABAD1D1D0
      FFFDFEEFEEEEDBDBDAD6D6D6D4D4D3BFBFBDC5C5C5C9C7C6D0CDCCEAEAEACECD
      CBE1E0E09C9C9CA9A9A8C6C9C6CCCECDE7E8E7D2D2D18181828C8C8BDCDCDC00
      0000000000000000000000000000000000000000000000000000000000C2C0BE
      D2D2D2B2B1B0CDCDCDCFCECDD3D3D1E4E4E4CDCAC9E9E8E7E3E1DFDFDCDCF1F1
      F0D7D4D2E5E4E49C9C9DB4B6B4C4C6C3CACCCAE4E5E4EBEBEB9E9F9E7D7D7E00
      0000000000000000000000000000000000000000000000000000000000ACA8A5
      CCCBCBE0DFDED0CCC9E3E2E1DBDBDAC8C5C5CECFCECECDCBF0F0F0DBD8D8E1DE
      DEEAEAE9E5E4E3E0E1E1B3B3B3E5E6E5D0D2D0D5D6D5E1E2E1F4F5F4AEAEAE00
      0000000000000000000000000000000000000000000000000000000000000000
      AFA9A4D4D4D3E5E5E5DCDAD9DEDDDDD8D6D6CDCDCAD5D5D4D6D4D2F4F3F2E1DF
      DFEFEFF0E1DFDFECECECE7E6E7DCDBDCD1D1D0BDBFBDDBDDDBEDEEEDC8C9C800
      0000000000000000000000000000000000000000000000000000000000000000
      0000009F9C98E3E4E7E1E0DFCCCAC8FAFBFBF2F1F0F7F8F7DDDFE0E8E9EAE2E2
      E3BEBEBE9D9E9E7676776767684B4A4B605F5F3739397A7978DEDEDEDEDEDE00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3AFAEE1E2E3EAEBECDEDFE1ADB0B485888C7575757373727878
      784241421414141111110C0C0E0404044B4B4B3D3E3D1516154E4D4C9A999900
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000A8A6A75B5D5E545250797166AA977EDCC6A2998B7A5256
      5A4B494A0F0F0F1C1C1C2525242525254C4C4C77777633333235363561606000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000B7A48FEFD0AAFFDCB2FFD8AFFFD9B1EDD2B0625F
      5D5A5B5D4B4B4A5555555A5A5A5657564F50503D3C3E5453545B5C5B9B9B9B00
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000E0CDB7FFDAAEFECAA8FED1B1FCD2B5FFE2C3CDC0
      AC949495ADAEAE3D3D3D222222232222161514454544A4A4A400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFDFC4FFE3CAFADEC5FBDCC4FBE1CCFFFD
      ECC6C4BF0000000000000000000000002529319FA1A300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4E6D8FCEBDAF8E9D8F6EADDF9EF
      E2FEFBF4B6B6B6000000000000000000614E30645C4C756C5C877C6800000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DAD8D5FAF1E5F5EBE1F3EBE0F8F0
      E5FAF9F6ABAEB4000000C29840D09D2EFCB42AEEAC2FF9B927DAAD587F859000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000EFEDECFAF7F5F7F7F6FAFA
      F9F8F7F69FA5AEC7BAA5FFCE44FFC93AFFC338FFC135FFC529BA934E686D7700
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000E8E8EAFFFFFFF9FAFBF1F1
      F1E9E7E7BFC1C6B5B3AFC59A43C29645A1844B9D7E469D7D4559504200000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000CCCCCCD1D1D10000000000
      000000000000000000009795928E8E90888A9000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC
      0FFFFF8003FFFE0001FFF80000FFF800007FF800003FF000001FF000001FF000
      001FF000001FF800001FF800001FFC00001FFE00001FFF00001FFF80001FFFC0
      001FFFC0007FFFE03CFFFFF01C3FFFF0101FFFF8001FFFF8003FFFF9F1FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF280000002000000040000000010020000000
      00008010000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FEFEFE01FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE01FDFDFD02FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F0F1F112E3E4E322DFDFE024D9D8D929CACAC938BBBB
      BB45E8E8E81CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE01EEEE
      EE11D8D8D828BDBCBD51A9A8A97A9D9D9C96898887B3727575D269686AE27372
      71F0757675CFA0A1A17FEFEFEF15FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7F708C5C5C53A848584857475
      73B98A8B8BD19B999BEBA5A3A4F7A8A7A7FCA7A6A6FFA8A8A8FFA6A6A6FFDCDC
      DCFFDFDEDFFF787878FF737575B2E1E1E122FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E6E6E6199FA0A0656D6D6DAC717272E6A5A6A5FFCAC9
      C9FFCECECDFFC5C6C5FFBABBBBFFB2B2B2FFABABAAFFA7A7A7FFA1A1A1FFCCCC
      CCFDFFFFFFFDF8F8F8FFA3A2A2FF636363CBC4C4C33CFFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E5E5E530686766C3979696FFCFCDCEFFE6E5E5FFE2E2E1FFD2D2
      D2FFC8C8C7FFBFBEBEFFB6B6B6FFAFAFAFFFA9A9AAFFA5A5A5FFA1A1A1FFD5D6
      D6FEFFFFFFFDF7F7F7FDFFFFFFFDCDCCCDFF616162E9A0A0A05FFFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D8D7D764E2E0DFFFFFFFFFFFF3F3F3FFE5E4E4FFD9D7D7FFD1D0
      CFFFCBCBC9FFCBCACBFFC8C8C7FEC4C4C4FFBEBFBFFFBDBDBDFEB2B3B2FFA2A2
      A2FEEFEFEFFDFEFEFEFDF6F6F6FDFFFFFFFDF1F0F0FF868686F2A3A3A35FFEFE
      FE01FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D5D4D46AF1F0F1FFF3F2F2FFEAE9E9FFE8E8E8FFE7E6E6FFE6E6
      E6FFE0DFDFFECECECEFEBEBFBEFFB5B5B5FEB0B0B0FFACACACFF9D9D9DFE6D6D
      6EFD858686FEDCDBDCFEFFFEFEFDF7F7F6FDFFFEFEFDFEFFFEFF8D8E8DF2A0A0
      A063FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D3D2D280EDEBEBFFF7F7F6FFF2F1F1FFE1E1E0FFC9C8C8FFBEBE
      BFFFBCBCBDFFBBBABAFFBBBBBBFFB8B7B7FFB1B0B1FFA6A6A6FFA6A7A7FEC7C7
      C7FDB5B4B5FD939293FDBBBBBAFDF9F9F9FDFBFBFBFDFFFEFFFDF6F5F6FF7473
      72DBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DBDBDA93E0E1E0FFD0D0D0FFBBBBBBFEBCBBBBFECFCECEFEE5E4
      E4FFF0EEEEFFE9E8E9FFD8D7D8FFC6C6C7FFB9B8B8FFAEAEAEFFA6A6A5FEBFC0
      BFFED1D4D1FFD6D7D7FF939493FE8F8E8CFEDEDEDEFDFFFFFFFDFFFFFFFFAEAE
      AAFAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C5C5C59DA1A1A1FFCCCCCDFEE5E4E4FFF9F8F8FFF9F8F8FFF0EF
      EFFFE3E3E2FFD4D3D4FEC4C3C4FEBCBBBCFFBFBDBDFDC6C6C5FEA3A3A3FE9191
      91FEC5C8C5FFCDCFCEFFDFE1E0FEACADABFE7B7A79FDB3B3B3FEFFFFFFFFD8D8
      D6FAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B9BABAA5D1D1D0FFFFFDFEFFEFEEEEFEDBDBDAFED6D6D6FED4D4
      D3FDBFBFBDFDC5C5C5FDC9C7C6FDD0CDCCFEEAEAEAFDCECDCBFEE1E0E0FD9C9C
      9CFDA9A9A8FEC6C9C6FFCCCECDFFE7E8E7FFD2D2D1FF818182FF8C8C8BFFDCDC
      DCF9FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CDCDCD6BC2C0BEFFD2D2D2FFB2B1B0FDCDCDCDFECFCECDFDD3D3
      D1FDE4E4E4FDCDCAC9FEE9E8E7FDE3E1DFFEDFDCDCFEF1F1F0FDD7D4D2FDE5E4
      E4FD9C9C9DFDB4B6B4FDC4C6C3FECACCCAFFE4E5E4FFEBEBEBFF9E9F9EFF7D7D
      7EEFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F8F7F70FACA8A59ACCCBCBFEE0DFDEFFD0CCC9FEE3E2E1FDDBDB
      DAFDC8C5C5FDCECFCEFDCECDCBFEF0F0F0FDDBD8D8FEE1DEDEFDEAEAE9FDE5E4
      E3FDE0E1E1FDB3B3B3FDE5E6E5FED0D2D0FFD5D6D5FFE1E2E1FFF4F5F4FFAEAE
      AEEEFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F6F5F410AFA9A4A4D4D4D3FFE5E5E5FEDCDAD9FEDEDD
      DDFDD8D6D6FDCDCDCAFED5D5D4FED6D4D2FEF4F3F2FDE1DFDFFEEFEFF0FDE1DF
      DFFEECECECFDE7E6E7FDDCDBDCFDD1D1D0FDBDBFBDFEDBDDDBFFEDEEEDFFC8C9
      C8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E7E5E7259F9C98DAE3E4E7FFE1E0DFFFCCCA
      C8FDFAFBFBFDF2F1F0FDF7F8F7FDDDDFE0FDE8E9EAFDE2E2E3FDBEBEBEFE9D9E
      9EFE767677FE676768FE4B4A4BFE605F5FFE373939FD7A7978FEDEDEDEFFDEDE
      DEFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D0CE49B3AFAEBDE1E2E3FBEAEB
      ECFFDEDFE1FDADB0B4FD85888CFD757575FD737372FD787878FE424142FE1414
      14FE111111FE0C0C0EFE040404FE4B4B4BFD3D3E3DFD151615FF4E4D4CFF9A99
      99FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E8E5E428A8A6A7A25B5D
      5EFE545250FF797166FFAA977EFEDCC6A2FF998B7AFE52565AFD4B494AFF0F0F
      0FFF1C1C1CFD252524FD252525FD4C4C4CFD777776FD333332FF353635FF6160
      60DCFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D5D3D23EB7A4
      8FEAEFD0AAFFFFDCB2FFFFD8AFFFFFD9B1FFEDD2B0FF625F5DFD5A5B5DF64B4B
      4AFF555555FF5A5A5AFF565756FF4F5050FD3D3C3EFF545354FF5B5C5BFF9B9B
      9B9AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6F5F50FE0CD
      B7C3FFDAAEFFFECAA8FFFED1B1FEFCD2B5FEFFE2C3FECDC0ACFE949495AFADAE
      AE8A3D3D3DEE222222FF232222FF161514FF454544DFA4A4A48EC0BFBF66F1F1
      F116FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E3
      E150FFDFC4F6FFE3CAFFFADEC5FEFBDCC4FEFBE1CCFEFFFDECFFC6C4BFE0D5D5
      D541DFDFDF34B9BAB969ABABAC77252931FF9FA1A38BFDFDFD02F0F0F016FAFA
      FA09FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF01EDE8E570F4E6D8FBFCEBDAFFF8E9D8FEF6EADDFEF9EFE2FEFEFBF4FFB6B6
      B699FFFFFF00F0F0F014BBBAB95E614E30FF645C4CDB756C5CC7877C68E8B8B8
      BA7CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF01DAD8D5A9FAF1E5FFF5EBE1FEF3EBE0FEF8F0E5FEFAF9F6FFABAE
      B4AEBCB3A673C29840E3D09D2EFEFCB42AFFEEAC2FFFF9B927FFDAAD58FF7F85
      90BBFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E4E5E566EFEDECFFFAF7F5FEF7F7F6FEFAFAF9FFF8F7F6FF9FA5
      AEB8C7BAA5A1FFCE44FDFFC93AFFFFC338FFFFC135FFFFC529FFBA934EFF686D
      77C1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DFE0E04AE8E8EAFFFFFFFFFFF9FAFBFFF1F1F1FFE9E7E7FFBFC1
      C694B5B3AF8BC59A43FFC29645FFA1844BFF9D7E46FF9D7D45FF595042ED9FA0
      A16CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0F0F020CCCCCC98D1D1D190DCDDDC72E1E1E15DE3E3E34BF8F8
      F813CCCCCC599795929B8E8E908F888A9083999B9E74B2B4B75DCCCCCD3AF9F9
      F906FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFDFFFFFFF9FFFFFFF9
      FFFFFFF80FFFFF8003FFFE0001FFF80000FFF000007FF000001FF000001FF000
      001FF000001FF000001FF000001FF000001FF000001FF800001FFC00001FFE00
      001FFF00001FFF80001FFF80001FFFC0001FFFC0101FFFE0001FFFF0001FFFF0
      001FFFF0001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Position = poScreenCenter
    Report = ppReport
    IniStorageType = 'IniFile'
    IniStorageName = '($WINSYS)\RBBuilder.ini'
    WindowHeight = 400
    WindowLeft = 100
    WindowTop = 50
    WindowWidth = 600
    WindowState = wsMaximized
    Left = 148
    Top = 72
  end
  object quPOItems: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'IDVendor'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = 'IDStore'
        DataType = ftInteger
        Size = -1
        Value = Null
      end
      item
        Name = 'DocumentID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      #9'PIM.DocumentID,'
      #9'(PIM.Qty * PIM.CostPrice) as CostTotal,'
      
        #9'(CASE WHEN IsNull(PIM.CaseQty, 0) = 0 THEN PIM.CostPrice ELSE P' +
        'IM.CaseCost END) as CostPrice,'
      #9'PIM.SalePrice,'
      #9'PIM.SuggRetail,'
      #9'PIM.Qty as UnitQty,'
      #9'PIM.QtyRealMov,'
      #9'PIM.CaseQty,'
      #9'PIM.CaseCost,'
      
        '                (CASE WHEN (IsNull(PIM.CaseQty, 0) <> 0) THEN PI' +
        'M.CaseQty'
      
        #9#9'ELSE (CASE WHEN (PIM.Qty - IsNull(PIM.QtyRealMov, 0)) >= 0 THE' +
        'N (PIM.Qty - IsNull(PIM.QtyRealMov, 0))'
      #9#9#9'ELSE 0 END)'
      '                END) as Qty,'
      
        #9'cast (CASE WHEN ((PIM.CaseQty is Null) or (PIM.CaseQTY = 0) ) T' +
        'HEN 0 ELSE 1 end as int ) as HasCase,'
      #9'M.Model,'
      #9'M.Description,'
      #9'M.SellingPrice as ModelSellingPrice,'
      #9'CAST(M.TotQtyOnHand as money) as TotQtyOnHand,'
      #9'M.Peso as Weight,'
      #9'TB.Name as Category,'
      
        #9'(SELECT TOP 1 MVC.VendorCode FROM VendorModelCode MVC WHERE MVC' +
        '.IDModel = M.IDModel AND MVC.IDPessoa = :IDVendor)as VendorCode,'
      #9'F.Pessoa as Manufacturer,'
      #9'S.SizeName [Size],'
      #9'C.Color,'
      #9'SU.[SystemUser],'
      #9'B.IDBarcode as Barcode,'
      #9'I.QtyOnHand'
      'FROM'
      #9'PreInventoryMov PIM (NOLOCK) '
      #9'JOIN Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)'
      #9'JOIN TabGroup TB (NOLOCK) ON (TB.IDGroup = M.GroupID)'
      
        #9'LEFT JOIN Barcode B (NOLOCK) ON (M.IDModel = B.IDModel AND B.Ba' +
        'rcodeOrder = 1)'
      #9'LEFT JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa)'
      #9'LEFT JOIN InvSize S (NOLOCK) ON (M.IDSize = S.IDSize)'
      #9'LEFT JOIN InvColor C (NOLOCK) ON (M.IDColor = C.IDColor)'
      #9'LEFT JOIN [SystemUser] SU (NOLOCK) ON (PIM.UserID = SU.IDUser)'
      
        #9'LEFT JOIN Inventory I (NOLOCK) ON (I.StoreID = :IDStore AND I.M' +
        'odelID = PIM.ModelID)'
      'WHERE'
      #9'PIM.DocumentID = :DocumentID'
      #9'AND PIM.InventMovTypeID = 2'
      #9'AND PIM.Qty <> 0'
      
        '                AND (CASE WHEN (IsNull(PIM.CaseQty, 0) > 1) THEN' +
        ' PIM.CaseQty'
      
        #9#9'ELSE (CASE WHEN (PIM.Qty - IsNull(PIM.QtyRealMov, 0)) >= 0 THE' +
        'N (PIM.Qty - IsNull(PIM.QtyRealMov, 0))'
      #9#9#9'ELSE 0 END)'
      #9' END) > 0')
    Left = 148
    Top = 116
    object quPOItemsDocumentID: TIntegerField
      FieldName = 'DocumentID'
    end
    object quPOItemsCostPrice: TBCDField
      FieldName = 'CostPrice'
      Precision = 19
    end
    object quPOItemsSalePrice: TBCDField
      FieldName = 'SalePrice'
      Precision = 19
    end
    object quPOItemsSuggRetail: TBCDField
      FieldName = 'SuggRetail'
      Precision = 19
    end
    object quPOItemsQty: TFloatField
      FieldName = 'Qty'
    end
    object quPOItemsUnitQty: TFloatField
      FieldName = 'UnitQty'
    end
    object quPOItemsCaseQty: TFloatField
      FieldName = 'CaseQty'
    end
    object quPOItemsCaseCost: TBCDField
      FieldName = 'CaseCost'
      Precision = 19
    end
    object quPOItemsModel: TStringField
      FieldName = 'Model'
      Size = 30
    end
    object quPOItemsDescription: TStringField
      FieldName = 'Description'
      Size = 50
    end
    object quPOItemsVendorCode: TStringField
      FieldName = 'VendorCode'
      Size = 35
    end
    object quPOItemsCostTotal: TFloatField
      FieldName = 'CostTotal'
      ReadOnly = True
    end
    object quPOItemsQtyRealMov: TFloatField
      FieldName = 'QtyRealMov'
    end
    object quPOItemsHasCase: TIntegerField
      FieldName = 'HasCase'
      ReadOnly = True
    end
    object quPOItemsModelSellingPrice: TBCDField
      FieldName = 'ModelSellingPrice'
      Precision = 19
    end
    object quPOItemsTotQtyOnHand: TFloatField
      FieldName = 'TotQtyOnHand'
    end
    object quPOItemsCategory: TStringField
      FieldName = 'Category'
      Size = 30
    end
    object quPOItemsManufacturer: TStringField
      FieldName = 'Manufacturer'
      Size = 50
    end
    object quPOItemsWeight: TCurrencyField
      FieldName = 'Weight'
    end
    object quPOItemsSize: TStringField
      FieldName = 'Size'
    end
    object quPOItemsColor: TStringField
      FieldName = 'Color'
    end
    object quPOItemsSystemUser: TStringField
      FieldName = 'SystemUser'
      Size = 50
    end
    object quPOItemsBarcode: TStringField
      FieldName = 'Barcode'
      FixedChar = True
    end
    object quPOItemsQtyOnHand: TBCDField
      FieldName = 'QtyOnHand'
      Precision = 32
    end
  end
  object quPO: TADOQuery
    Connection = DM.ADODBConnect
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      #9'PO.IDPO as DocumentID,'
      #9'F.IDPessoa as IDVendor,'
      #9'PO.DataPedido,'
      #9'PO.Freight,'
      #9'PO.Charges,'
      #9'PO.SubTotal,'
      #9'PO.EstArrival,'
      #9'PO.PayDays,'
      #9'PO.OBS,'
      #9'F.Pessoa as Vendor,'
      #9'F.Email,'
      #9'F.Fax,'
      #9'F.Contatos as Contact,'
      #9'F.Endereco as Address,'
      #9'F.Cidade as City,'
      #9'F.Bairro as Neighborhood,'
      #9'F.IDEstado,'
      #9'F.CEP as Zip,'
      #9'F.Telefone as Phone,'
      #9'F.Cellular as Cell,'
      #9'F.Fax,'
      #9'F.OBS as VOBS,'
      #9'F.PhoneAreaCode,'
      #9'F.CellAreaCode,'
      #9'F.CPF as BirthState,'
      #9'F.CartTrabalho as SocialSecurity,'
      #9'F.InscEstadual as FederalID,'
      #9'F.InscMunicipal as SalesTax,'
      #9'F.HomePage as HomePage,'
      #9'EMP.Empresa,'
      #9'EMP.RazaoSocial RazaoEMP,'
      #9'EMP.CGC CNPJEMP,'
      #9'EMP.InscricaoEstadual IEEMP,'
      #9'EMP.InscricaoMunicipal IMEMP,'
      
        #9'EMP.Endereco + '#39' '#39' +CAST(EMP.Numero AS VARCHAR) + '#39' '#39' + EMP.Cop' +
        'lemento EndEMP,'
      #9'EMP.Bairro BairroEMP,'
      #9'EMP.Cidade CidadeEMP,'
      #9'EMP.CEP CEPEMP,'
      #9'EMP.IDEstado EstadoEMP,'
      #9'EMP.LogoEmpresa,'
      #9'S.Name as Store,'
      #9'S.Address as StoreAddress,'
      #9'S.City as StoreCity,'
      #9'S.Zip as StoreZip,'
      #9'S.Telephone as StorePhone,'
      #9'S.Cellular as StoreCell,'
      #9'S.Fax as StoreFax,'
      #9'S.Contato as StoreContact,'
      #9'S.Email as StoreEmail,'
      #9'S.WebPage as StoreWebSite,'
      #9'SVA.Account as VendorAccount,'
      #9'E.Estado as StoreState'
      'FROM '
      #9'PO  (NOLOCK) '
      #9'JOIN Pessoa F (NOLOCK) ON (F.IDPessoa = PO.IDFornecedor)'
      #9'JOIN Store S (NOLOCK) ON (S.IDStore = PO.IDStore)'
      
        #9'LEFT JOIN Sis_Empresa EMP (NOLOCK) ON (S.IDEmpresa = EMP.IDEmpr' +
        'esa)'
      #9'LEFT OUTER JOIN Estado E (NOLOCK) ON (E.IDEstado = S.IDEstado)'
      
        #9'LEFT OUTER JOIN Mnt_StoreVendorAccount SVA (NOLOCK) ON (SVA.IDP' +
        'essoa = PO.IDFornecedor AND SVA.IDStore = PO.IDStore)'
      'ORDER BY'
      #9'F.Pessoa,'
      #9'PO.IDPO')
    Left = 76
    Top = 116
    object quPODocumentID: TIntegerField
      FieldName = 'DocumentID'
    end
    object quPOIDVendor: TIntegerField
      FieldName = 'IDVendor'
    end
    object quPODataPedido: TDateTimeField
      FieldName = 'DataPedido'
    end
    object quPOFreight: TBCDField
      FieldName = 'Freight'
      Precision = 19
    end
    object quPOCharges: TBCDField
      FieldName = 'Charges'
      Precision = 19
    end
    object quPOSubTotal: TBCDField
      FieldName = 'SubTotal'
      Precision = 19
    end
    object quPOEstArrival: TDateTimeField
      FieldName = 'EstArrival'
    end
    object quPOPayDays: TIntegerField
      FieldName = 'PayDays'
    end
    object quPOOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
    object quPOVendor: TStringField
      FieldName = 'Vendor'
      Size = 50
    end
    object quPOEmail: TStringField
      FieldName = 'Email'
      Size = 50
    end
    object quPOFax: TStringField
      FieldName = 'Fax'
      Size = 40
    end
    object quPOContact: TStringField
      FieldName = 'Contact'
      Size = 255
    end
    object quPOAddress: TStringField
      FieldName = 'Address'
      Size = 80
    end
    object quPOCity: TStringField
      FieldName = 'City'
      Size = 40
    end
    object quPONeighborhood: TStringField
      FieldName = 'Neighborhood'
      Size = 50
    end
    object quPOIDEstado: TStringField
      FieldName = 'IDEstado'
      FixedChar = True
      Size = 3
    end
    object quPOZip: TStringField
      FieldName = 'Zip'
      FixedChar = True
      Size = 12
    end
    object quPOPhone: TStringField
      FieldName = 'Phone'
      Size = 40
    end
    object quPOCell: TStringField
      FieldName = 'Cell'
      FixedChar = True
      Size = 18
    end
    object quPOFax_1: TStringField
      FieldName = 'Fax_1'
      Size = 40
    end
    object quPOVOBS: TStringField
      FieldName = 'VOBS'
      Size = 100
    end
    object quPOPhoneAreaCode: TStringField
      FieldName = 'PhoneAreaCode'
      Size = 5
    end
    object quPOCellAreaCode: TStringField
      FieldName = 'CellAreaCode'
      Size = 5
    end
    object quPOBirthState: TStringField
      FieldName = 'BirthState'
      Size = 30
    end
    object quPOSocialSecurity: TStringField
      FieldName = 'SocialSecurity'
      Size = 30
    end
    object quPOFederalID: TStringField
      FieldName = 'FederalID'
      Size = 30
    end
    object quPOSalesTax: TStringField
      FieldName = 'SalesTax'
      Size = 30
    end
    object quPOHomePage: TStringField
      FieldName = 'HomePage'
      Size = 200
    end
    object quPOStore: TStringField
      FieldName = 'Store'
      Size = 30
    end
    object quPOStoreAddress: TStringField
      FieldName = 'StoreAddress'
      Size = 80
    end
    object quPOStoreCity: TStringField
      FieldName = 'StoreCity'
      Size = 40
    end
    object quPOStoreZip: TStringField
      FieldName = 'StoreZip'
      FixedChar = True
      Size = 12
    end
    object quPOStorePhone: TStringField
      FieldName = 'StorePhone'
      Size = 40
    end
    object quPOStoreCell: TStringField
      FieldName = 'StoreCell'
      Size = 18
    end
    object quPOStoreFax: TStringField
      FieldName = 'StoreFax'
      Size = 40
    end
    object quPOStoreContact: TStringField
      FieldName = 'StoreContact'
      Size = 50
    end
    object quPOStoreEmail: TStringField
      FieldName = 'StoreEmail'
      Size = 60
    end
    object quPOStoreWebSite: TStringField
      FieldName = 'StoreWebSite'
      Size = 80
    end
    object quPOVendorAccount: TStringField
      FieldName = 'VendorAccount'
      Size = 35
    end
    object quPOStoreState: TStringField
      FieldName = 'StoreState'
      Size = 50
    end
    object quPOEmpresa: TStringField
      FieldName = 'Empresa'
      Size = 35
    end
    object quPORazaoEMP: TStringField
      FieldName = 'RazaoEMP'
      Size = 100
    end
    object quPOCNPJEMP: TStringField
      FieldName = 'CNPJEMP'
    end
    object quPOIEEMP: TStringField
      FieldName = 'IEEMP'
    end
    object quPOIMEMP: TStringField
      FieldName = 'IMEMP'
    end
    object quPOBairroEMP: TStringField
      FieldName = 'BairroEMP'
    end
    object quPOCidadeEMP: TStringField
      FieldName = 'CidadeEMP'
      Size = 30
    end
    object quPOCEPEMP: TStringField
      FieldName = 'CEPEMP'
      Size = 10
    end
    object quPOEstadoEMP: TStringField
      FieldName = 'EstadoEMP'
      FixedChar = True
      Size = 3
    end
    object quPOEndEMP: TStringField
      FieldName = 'EndEMP'
      ReadOnly = True
      Size = 102
    end
    object quPOLogoEmpresa: TBlobField
      FieldName = 'LogoEmpresa'
    end
  end
  object dsPO: TDataSource
    DataSet = quPO
    Left = 76
    Top = 160
  end
  object ppTransferItems: TppDBPipeline
    DataSource = dsPOItems
    UserName = 'POItems'
    Left = 148
    Top = 204
  end
  object dsPOItems: TDataSource
    DataSet = quPOItems
    Left = 148
    Top = 160
  end
  object ppTransfer: TppDBPipeline
    DataSource = dsPO
    UserName = 'Transfer'
    Left = 76
    Top = 204
  end
  object ppExportPDF: TPsRBExportPDF
    ShowSetupDialog = False
    CompressionMethod = cmNormal
    ExportImageFormat = ifJPG
    EncryptionLevel = el40Bit
    Left = 172
    Top = 16
  end
end
